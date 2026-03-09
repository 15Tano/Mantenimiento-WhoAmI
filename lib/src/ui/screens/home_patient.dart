// lib/src/ui/screens/home_patient.dart
//
// ╔══════════════════════════════════════════════════════════════╗
// ║   HOME PATIENT PAGE — Who Am I?                             ║
// ║                                                             ║
// ║   Responsables:                                             ║
// ║     Alan    → Layout, colores, tipografía, animaciones      ║
// ║     Owen    → EmergencyService, lógica offline/caché        ║
// ║     Sebastián → Flujo UX, textos, accesibilidad             ║
// ║                                                             ║
// ║   DECISIONES DE DISEÑO:                                     ║
// ║   • Sin login ni botón de retroceso (sesión persistente).   ║
// ║   • Nombre cacheado en SharedPreferences para modo offline. ║
// ║   • Botón emergencia escribe en Firestore vía               ║
// ║     EmergencyService y muestra feedback visual claro.       ║
// ║   • Sin scroll: toda la UI visible en una sola pantalla.    ║
// ║   • textScaler fijo en 1.0 para no romper layouts en        ║
// ║     dispositivos con fuente del sistema muy grande.         ║
// ╚══════════════════════════════════════════════════════════════╝

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme.dart';
import 'calendar_page.dart';   // "Mis Recuerdos"
import 'game_page.dart';        // "Mis Juegos"
import 'package:whoami_app/services/emergency_service.dart';

// ─── Colores específicos de esta pantalla ────────────────────
/// Rojo suave que no genera ansiedad pero comunica urgencia.
const kEmergencyRed    = Color(0xFFFF6B6B);

/// Fondo del botón de emergencia cuando está en estado "enviado".
const kEmergencyActive = Color(0xFFE53935);

/// Color de la sombra del botón de emergencia.
const kEmergencyShadow = Color(0x44FF6B6B);

// ─── Clave de SharedPreferences ──────────────────────────────
const _kCachedName = 'patient_cached_firstName';

// ─────────────────────────────────────────────────────────────
//  Widget principal
// ─────────────────────────────────────────────────────────────
class HomePatientPage extends StatefulWidget {
  const HomePatientPage({super.key});
  static const route = '/home/patient';

  @override
  State<HomePatientPage> createState() => _HomePatientPageState();
}

class _HomePatientPageState extends State<HomePatientPage>
    with SingleTickerProviderStateMixin {
  // ── Estado del nombre ──────────────────────────────────────
  String _firstName    = '';
  bool   _isOffline    = false;

  // ── Estado del botón de emergencia ────────────────────────
  _EmergencyState _emergencyState = _EmergencyState.idle;

  // ── Animación del pulso del botón de emergencia ───────────
  late AnimationController _pulseController;
  late Animation<double>    _pulseAnimation;

  // ── Servicio ───────────────────────────────────────────────
  late final EmergencyService _emergencyService;

  // ─────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();

    _emergencyService = EmergencyService(FirebaseFirestore.instance);

    // Animación de pulso para el botón de emergencia en idle.
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _loadPatientName();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────────────────────
  //  Carga del nombre con caché offline
  // ─────────────────────────────────────────────────────────

  /// Intenta obtener el nombre desde Firestore.
  /// Si falla (sin red), usa el valor guardado en SharedPreferences.
  Future<void> _loadPatientName() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    // 1) Intentar Firestore primero (con timeout corto).
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get(const GetOptions(source: Source.serverAndCache))
          .timeout(const Duration(seconds: 6));

      if (doc.exists && doc.data() != null) {
        final data  = doc.data()!;
        final first = (data['firstName'] as String? ?? '').trim();
        final last  = (data['lastName']  as String? ?? '').trim();

        // Guardar en caché para uso offline posterior.
        final prefs = await SharedPreferences.getInstance();
        final nameToCache = first.isNotEmpty ? first : last;
        if (nameToCache.isNotEmpty) {
          await prefs.setString(_kCachedName, nameToCache);
        }

        if (mounted) {
          setState(() {
            _firstName = first.isNotEmpty ? first : last;
            _isOffline = false;
          });
        }
        return;
      }
    } catch (_) {
      // Sin conexión o timeout → continúa al fallback.
    }

    // 2) Fallback: nombre cacheado en SharedPreferences.
    final prefs      = await SharedPreferences.getInstance();
    final cachedName = prefs.getString(_kCachedName) ?? '';

    if (mounted) {
      setState(() {
        _firstName = cachedName;
        _isOffline = true;
      });
    }
  }

  // ─────────────────────────────────────────────────────────
  //  Lógica del botón de emergencia
  // ─────────────────────────────────────────────────────────
  Future<void> _handleEmergencyPress() async {
    // Vibración háptica fuerte para confirmar la pulsación.
    HapticFeedback.heavyImpact();

    if (_emergencyState == _EmergencyState.sending) return;

    // Confirmar con diálogo accesible antes de enviar.
    final confirmed = await _showEmergencyConfirmDialog();
    if (!confirmed) return;

    setState(() => _emergencyState = _EmergencyState.sending);
    _pulseController.stop();

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      _showFeedback('Error al identificar al usuario.', isError: true);
      setState(() => _emergencyState = _EmergencyState.idle);
      return;
    }

    final result = await _emergencyService.triggerEmergency(
      patientUid: uid,
      patientNameFallback: _firstName.isNotEmpty ? _firstName : 'Paciente',
    );

    if (!mounted) return;

    switch (result) {
      case EmergencyResult.success:
        HapticFeedback.heavyImpact();
        setState(() => _emergencyState = _EmergencyState.sent);
        // Regresar al estado idle después de 8 segundos.
        Future.delayed(const Duration(seconds: 8), () {
          if (mounted) {
            setState(() => _emergencyState = _EmergencyState.idle);
            _pulseController.repeat(reverse: true);
          }
        });

      case EmergencyResult.noCaregiverAssigned:
        // La alerta se guardó, pero no hay cuidador asignado.
        setState(() => _emergencyState = _EmergencyState.sent);
        _showFeedback(
          'Alerta registrada. Pide a tu cuidador que configure la app.',
          isError: false,
        );
        Future.delayed(const Duration(seconds: 8), () {
          if (mounted) {
            setState(() => _emergencyState = _EmergencyState.idle);
            _pulseController.repeat(reverse: true);
          }
        });

      case EmergencyResult.offline:
        setState(() => _emergencyState = _EmergencyState.offline);
        _showFeedback(
          'Sin conexión. Pide ayuda a alguien cercano.',
          isError: true,
        );
        Future.delayed(const Duration(seconds: 5), () {
          if (mounted) {
            setState(() => _emergencyState = _EmergencyState.idle);
            _pulseController.repeat(reverse: true);
          }
        });

      case EmergencyResult.error:
        setState(() => _emergencyState = _EmergencyState.idle);
        _pulseController.repeat(reverse: true);
        _showFeedback('Ocurrió un error. Intenta de nuevo.', isError: true);
    }
  }

  // ─────────────────────────────────────────────────────────
  //  Diálogo de confirmación de emergencia
  // ─────────────────────────────────────────────────────────
  Future<bool> _showEmergencyConfirmDialog() async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            title: const Row(
              children: [
                Icon(Icons.warning_amber_rounded,
                    color: kEmergencyRed, size: 32),
                SizedBox(width: 12),
                Text(
                  '¿Necesitas ayuda?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            content: const Text(
              'Se avisará a tu cuidador de inmediato.',
              style: TextStyle(fontSize: 18),
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              // Botón cancelar — grande y claro
              SizedBox(
                width: 120,
                height: 52,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'No',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              // Botón confirmar — rojo grande
              SizedBox(
                width: 120,
                height: 52,
                child: FilledButton(
                  onPressed: () => Navigator.of(ctx).pop(true),
                  style: FilledButton.styleFrom(
                    backgroundColor: kEmergencyRed,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Sí',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  // ─────────────────────────────────────────────────────────
  //  Snackbar de feedback
  // ─────────────────────────────────────────────────────────
  void _showFeedback(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        backgroundColor: isError ? Colors.grey[800] : Colors.green[700],
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  //  BUILD
  // ─────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    // Bloquear el botón físico de retroceso — el paciente no debe
    // poder salir de esta pantalla accidentalmente.
    return PopScope(
      canPop: false,
      child: MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1)),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ── Indicador offline (solo visible si no hay red) ──
                  if (_isOffline) _OfflineBanner(),

                  const Spacer(flex: 2),

                  // ── Saludo ──────────────────────────────────────────
                  _GreetingSection(firstName: _firstName),

                  const Spacer(flex: 3),

                  // ── Botón de emergencia ─────────────────────────────
                  _EmergencyButton(
                    state         : _emergencyState,
                    pulseAnimation: _pulseAnimation,
                    onPressed     : _handleEmergencyPress,
                  ),

                  const Spacer(flex: 3),

                  // ── Botones secundarios ─────────────────────────────
                  _SecondaryButtons(
                    onMemoriesTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CalendarPage()),
                    ),
                    onGamesTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const GamesPage()),
                    ),
                  ),

                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Enum interno: estados del botón de emergencia
// ─────────────────────────────────────────────────────────────
enum _EmergencyState { idle, sending, sent, offline }

// ─────────────────────────────────────────────────────────────
//  Widget: Banner de modo offline
// ─────────────────────────────────────────────────────────────
class _OfflineBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3CD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFE082)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.wifi_off_rounded, size: 18, color: Color(0xFF795548)),
          SizedBox(width: 8),
          Text(
            'Sin conexión — mostrando datos guardados',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF5D4037),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Widget: Sección de saludo
// ─────────────────────────────────────────────────────────────
class _GreetingSection extends StatelessWidget {
  const _GreetingSection({required this.firstName});
  final String firstName;

  @override
  Widget build(BuildContext context) {
    // Determina el turno del día para personalizar el saludo.
    final hour    = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Buenos días,'
        : hour < 19
            ? 'Buenas tardes,'
            : 'Buenas noches,';

    final displayName = firstName.isNotEmpty ? firstName : '…';

    return Column(
      children: [
        // Sub-saludo por hora del día
        Text(
          greeting,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: kGrey1,
          ),
        ),
        const SizedBox(height: 4),
        // Nombre grande — lo más importante de la pantalla
        Text(
          displayName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 52,
            fontWeight: FontWeight.w800,
            color: kInk,
            height: 1.1,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Widget: Botón de emergencia
// ─────────────────────────────────────────────────────────────
class _EmergencyButton extends StatelessWidget {
  const _EmergencyButton({
    required this.state,
    required this.pulseAnimation,
    required this.onPressed,
  });

  final _EmergencyState     state;
  final Animation<double>   pulseAnimation;
  final VoidCallback        onPressed;

  @override
  Widget build(BuildContext context) {
    // Configuración visual según el estado.
    final config = _emergencyVisualConfig(state);

    return Column(
      children: [
        // Leyenda sobre el botón
        Text(
          config.label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: config.labelColor,
          ),
        ),
        const SizedBox(height: 16),

        // Botón con animación de pulso en idle
        AnimatedBuilder(
          animation: pulseAnimation,
          builder: (context, child) {
            final scale = state == _EmergencyState.idle
                ? pulseAnimation.value
                : 1.0;
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: GestureDetector(
            onTap: state == _EmergencyState.sending ? null : onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width  : 180,
              height : 180,
              decoration: BoxDecoration(
                shape     : BoxShape.circle,
                color     : config.backgroundColor,
                boxShadow : [
                  BoxShadow(
                    color     : config.shadowColor,
                    blurRadius: 32,
                    spreadRadius: 8,
                  ),
                ],
              ),
              child: Center(child: config.icon),
            ),
          ),
        ),
      ],
    );
  }

  /// Mapea cada estado a los valores visuales correspondientes.
  _EmergencyVisualConfig _emergencyVisualConfig(_EmergencyState s) {
    switch (s) {
      case _EmergencyState.idle:
        return _EmergencyVisualConfig(
          backgroundColor: kEmergencyRed,
          shadowColor    : kEmergencyShadow,
          label          : 'Presiona si necesitas ayuda',
          labelColor     : kGrey1,
          icon           : const Icon(
            Icons.sos_rounded,
            size : 80,
            color: Colors.white,
          ),
        );

      case _EmergencyState.sending:
        return _EmergencyVisualConfig(
          backgroundColor: kEmergencyRed.withOpacity(0.7),
          shadowColor    : Colors.transparent,
          label          : 'Enviando alerta…',
          labelColor     : kGrey1,
          icon           : const SizedBox(
            width : 60,
            height: 60,
            child : CircularProgressIndicator(
              color      : Colors.white,
              strokeWidth: 5,
            ),
          ),
        );

      case _EmergencyState.sent:
        return _EmergencyVisualConfig(
          backgroundColor: Colors.green[600]!,
          shadowColor    : Colors.green.withOpacity(0.3),
          label          : '✓ Tu cuidador fue avisado',
          labelColor     : Colors.green[700]!,
          icon           : const Icon(
            Icons.check_circle_outline_rounded,
            size : 80,
            color: Colors.white,
          ),
        );

      case _EmergencyState.offline:
        return _EmergencyVisualConfig(
          backgroundColor: Colors.grey[400]!,
          shadowColor    : Colors.transparent,
          label          : 'Sin conexión — pide ayuda a alguien cercano',
          labelColor     : Colors.grey[700]!,
          icon           : const Icon(
            Icons.wifi_off_rounded,
            size : 60,
            color: Colors.white,
          ),
        );
    }
  }
}

/// Datos de configuración visual del botón de emergencia.
class _EmergencyVisualConfig {
  const _EmergencyVisualConfig({
    required this.backgroundColor,
    required this.shadowColor,
    required this.label,
    required this.labelColor,
    required this.icon,
  });

  final Color  backgroundColor;
  final Color  shadowColor;
  final String label;
  final Color  labelColor;
  final Widget icon;
}

// ─────────────────────────────────────────────────────────────
//  Widget: Botones secundarios (Mis Recuerdos / Mis Juegos)
// ─────────────────────────────────────────────────────────────
class _SecondaryButtons extends StatelessWidget {
  const _SecondaryButtons({
    required this.onMemoriesTap,
    required this.onGamesTap,
  });

  final VoidCallback onMemoriesTap;
  final VoidCallback onGamesTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SecondaryCard(
            color     : kPurple,
            icon      : Icons.photo_album_outlined,
            label     : 'Mis\nRecuerdos',
            onTap     : onMemoriesTap,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _SecondaryCard(
            color     : kGreenPastel,
            icon      : Icons.videogame_asset_outlined,
            label     : 'Mis\nJuegos',
            onTap     : onGamesTap,
          ),
        ),
      ],
    );
  }
}

/// Tarjeta cuadrada para las opciones secundarias.
class _SecondaryCard extends StatelessWidget {
  const _SecondaryCard({
    required this.color,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final Color    color;
  final IconData icon;
  final String   label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color        : color,
          borderRadius : BorderRadius.circular(24),
          boxShadow    : [
            BoxShadow(
              color     : color.withOpacity(0.35),
              blurRadius: 12,
              offset    : const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: kInk),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize  : 17,
                fontWeight: FontWeight.w700,
                color     : kInk,
                height    : 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
