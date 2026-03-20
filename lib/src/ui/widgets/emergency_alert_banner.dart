// lib/src/ui/widgets/emergency_alert_banner.dart
//
// ╔══════════════════════════════════════════════════════════════╗
// ║  EMERGENCY ALERT BANNER — Who Am I?  Sprint 2              ║
// ║  Responsable: Alan (UI)                                    ║
// ║                                                            ║
// ║  Widget que muestra una o más alertas de emergencia        ║
// ║  en la parte superior de HomeCaregiverPage.                ║
// ║                                                            ║
// ║  Comportamiento:                                           ║
// ║  • Sin alertas → no ocupa espacio (SizedBox.shrink).       ║
// ║  • 1 alerta    → tarjeta única con nombre + hora + botón.  ║
// ║  • N alertas   → tarjeta con "N alertas activas" + lista.  ║
// ║  • Animación de entrada/salida con AnimatedSwitcher.       ║
// ║  • Pulso de color para llamar la atención del cuidador.    ║
// ╚══════════════════════════════════════════════════════════════╝

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:whoami_app/services/emergency_alert_service.dart';
import '../theme.dart';

// ─── Colores internos del banner ─────────────────────────────
const _kBannerBg     = Color(0xFFFFF0F0); // Rojo muy suave de fondo
const _kBannerBorder = Color(0xFFFF6B6B); // Borde rojo moderado
const _kBannerRed    = Color(0xFFE53935); // Rojo para el texto de urgencia
const _kBannerPulse  = Color(0xFFFF6B6B); // Dot pulsante

/// Widget de alertas de emergencia para HomeCaregiverPage.
///
/// Uso:
/// ```dart
/// EmergencyAlertBanner(
///   alerts   : listOfAlerts,     // List<EmergencyAlert>
///   onResolve: (alert) { ... },  // callback para resolver
/// )
/// ```
class EmergencyAlertBanner extends StatefulWidget {
  const EmergencyAlertBanner({
    super.key,
    required this.alerts,
    required this.onResolve,
  });

  final List<EmergencyAlert> alerts;
  final void Function(EmergencyAlert alert) onResolve;

  @override
  State<EmergencyAlertBanner> createState() => _EmergencyAlertBannerState();
}

class _EmergencyAlertBannerState extends State<EmergencyAlertBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late Animation<double>   _pulseAnim;

  // Control de expansión cuando hay múltiples alertas
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _pulseAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(EmergencyAlertBanner old) {
    super.didUpdateWidget(old);
    // Vibración cada vez que llega una nueva alerta
    if (widget.alerts.length > old.alerts.length && widget.alerts.isNotEmpty) {
      HapticFeedback.heavyImpact();
    }
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  // ─── Build ────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      transitionBuilder: (child, anim) => SizeTransition(
        sizeFactor  : anim,
        axisAlignment: -1,
        child: FadeTransition(opacity: anim, child: child),
      ),
      child: widget.alerts.isEmpty
          ? const SizedBox.shrink(key: ValueKey('empty'))
          : _buildBanner(key: const ValueKey('banner')),
    );
  }

  Widget _buildBanner({Key? key}) {
    final count    = widget.alerts.length;
    final hasMulti = count > 1;

    return Container(
      key       : key,
      margin    : const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color       : _kBannerBg,
        borderRadius: BorderRadius.circular(16),
        border      : Border.all(color: _kBannerBorder, width: 1.5),
        boxShadow   : [
          BoxShadow(
            color     : _kBannerBorder.withOpacity(0.18),
            blurRadius: 12,
            offset    : const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Header del banner ────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
            child: Row(
              children: [
                // Dot pulsante
                AnimatedBuilder(
                  animation: _pulseAnim,
                  builder: (_, __) => Opacity(
                    opacity: _pulseAnim.value,
                    child: Container(
                      width : 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: _kBannerPulse,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Texto del encabezado
                Expanded(
                  child: Text(
                    hasMulti
                        ? '⚠️  $count alertas de emergencia activas'
                        : '⚠️  Alerta de emergencia',
                    style: const TextStyle(
                      fontSize  : 15,
                      fontWeight: FontWeight.w800,
                      color     : _kBannerRed,
                    ),
                  ),
                ),

                // Botón expandir/colapsar para múltiples alertas
                if (hasMulti)
                  GestureDetector(
                    onTap: () => setState(() => _expanded = !_expanded),
                    child: Icon(
                      _expanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: _kBannerRed,
                    ),
                  ),
              ],
            ),
          ),

          // ── Contenido: alerta única o lista expandida ─────
          if (!hasMulti)
            _AlertRow(
              alert    : widget.alerts.first,
              onResolve: () => widget.onResolve(widget.alerts.first),
            )
          else ...[
            // Siempre muestra la más reciente
            _AlertRow(
              alert    : widget.alerts.first,
              onResolve: () => widget.onResolve(widget.alerts.first),
            ),
            // El resto se muestran si está expandido
            if (_expanded)
              ...widget.alerts.skip(1).map(
                    (a) => _AlertRow(
                      alert    : a,
                      onResolve: () => widget.onResolve(a),
                      muted    : true,
                    ),
                  ),
          ],

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Sub-widget: fila de una sola alerta
// ─────────────────────────────────────────────────────────────
class _AlertRow extends StatefulWidget {
  const _AlertRow({
    required this.alert,
    required this.onResolve,
    this.muted = false,
  });

  final EmergencyAlert alert;
  final VoidCallback   onResolve;
  final bool           muted;

  @override
  State<_AlertRow> createState() => _AlertRowState();
}

class _AlertRowState extends State<_AlertRow> {
  bool _resolving = false;

  @override
  Widget build(BuildContext context) {
    final timeStr = _formatTime(widget.alert.createdAt);

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icono
          Icon(
            Icons.sos_rounded,
            color : widget.muted ? Colors.grey[400] : _kBannerRed,
            size  : 28,
          ),
          const SizedBox(width: 10),

          // Nombre y hora
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.alert.patientName,
                  style: TextStyle(
                    fontSize  : 14,
                    fontWeight: FontWeight.w700,
                    color     : widget.muted ? Colors.grey[600] : kInk,
                  ),
                ),
                Text(
                  'Hace $timeStr',
                  style: TextStyle(
                    fontSize: 11,
                    color   : Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),

          // Botón resolver
          _resolving
              ? const SizedBox(
                  width: 20, height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : FilledButton(
                  onPressed: () async {
                    setState(() => _resolving = true);
                    widget.onResolve();
                    // No hace setState después porque el widget
                    // desaparece del stream cuando resolved=true.
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: widget.muted
                        ? Colors.grey[300]
                        : kGreenPastel,
                    foregroundColor: kInk,
                    padding        : const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6,
                    ),
                    minimumSize   : Size.zero,
                    tapTargetSize : MaterialTapTargetSize.shrinkWrap,
                    shape         : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Atendido',
                    style: TextStyle(
                      fontSize  : 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  /// Devuelve una cadena legible como "3 min", "1 hora", "ayer".
  String _formatTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inSeconds < 60)  return 'unos segundos';
    if (diff.inMinutes < 60)  return '${diff.inMinutes} min';
    if (diff.inHours   < 24)  return '${diff.inHours} h';
    if (diff.inDays    == 1)  return 'ayer a las ${DateFormat.Hm('es').format(dt)}';
    return DateFormat("d MMM, HH:mm", 'es').format(dt);
  }
}
