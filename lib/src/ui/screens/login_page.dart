// lib/src/ui/screens/login_page.dart
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../brand_logo.dart';
import '../theme.dart';
import 'home_caregiver.dart';
import 'home_consultant.dart';
import 'choice_start.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const route = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _obscurePass = true;

  static const String _kLastResetTsKey = 'last_reset_email_at';
  static const Duration _resetCooldown = Duration(seconds: 60);
  DateTime? _lastResetEmailAt;

  Timer? _resetTimer;
  int _resetSecondsLeft = 0;
  Timer? _pulseTimer;
  bool _pulseUp = false;
  static const int _pulseThreshold = 10;

  final GlobalKey<_ShakeWidgetState> _passShakeKey =
      GlobalKey<_ShakeWidgetState>();
  bool _passwordError = false;
  String? _passwordErrorText;

  @override
  void initState() {
    super.initState();
    _loadCooldowns().then((_) => _startResetCountdownIfNeeded());
  }

  @override
  void dispose() {
    _resetTimer?.cancel();
    _pulseTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadCooldowns() async {
    final prefs = await SharedPreferences.getInstance();
    final resMs = prefs.getInt(_kLastResetTsKey);
    if (resMs != null) {
      _lastResetEmailAt = DateTime.fromMillisecondsSinceEpoch(resMs);
    }
  }

  Future<void> _saveResetTs(DateTime when) async {
    _lastResetEmailAt = when;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kLastResetTsKey, when.millisecondsSinceEpoch);
  }

  void _startResetCountdownIfNeeded() {
    _resetTimer?.cancel();
    final now = DateTime.now();
    if (_lastResetEmailAt == null) {
      _resetSecondsLeft = 0;
      _stopPulse();
      setState(() {});
      return;
    }
    final elapsed = now.difference(_lastResetEmailAt!);
    final remaining = _resetCooldown - elapsed;
    _resetSecondsLeft = remaining.isNegative ? 0 : remaining.inSeconds;
    _updatePulseState();
    setState(() {});
    if (_resetSecondsLeft > 0) {
      _resetTimer = Timer.periodic(const Duration(seconds: 1), (t) {
        if (!mounted) return;
        if (_resetSecondsLeft <= 1) {
          t.cancel();
          _resetSecondsLeft = 0;
          _stopPulse();
          setState(() {});
        } else {
          _resetSecondsLeft -= 1;
          _updatePulseState();
          setState(() {});
        }
      });
    }
  }

  void _updatePulseState() {
    if (_resetSecondsLeft > 0 && _resetSecondsLeft <= _pulseThreshold) {
      _startPulse();
    } else {
      _stopPulse();
    }
  }

  void _startPulse() {
    if (_pulseTimer != null) return;
    _pulseTimer = Timer.periodic(const Duration(milliseconds: 600), (_) {
      if (!mounted) return;
      _pulseUp = !_pulseUp;
      setState(() {});
    });
  }

  void _stopPulse() {
    _pulseTimer?.cancel();
    _pulseTimer = null;
    _pulseUp = false;
  }

  Future<void> _ensureUserProfile(User user) async {
    final db = FirebaseFirestore.instance;
    final ref = db.collection('users').doc(user.uid);
    final snap = await ref.get();
    final m = snap.data() ?? <String, dynamic>{};

    final firstName = ((m['firstName'] ?? '') as String).trim();
    final lastName = ((m['lastName'] ?? '') as String).trim();

    String display = ((m['displayName'] ?? '') as String).trim();
    if (display.isEmpty) {
      if (firstName.isNotEmpty || lastName.isNotEmpty) {
        display = '$firstName $lastName'.trim();
      } else {
        display =
            (user.displayName ?? user.email?.split('@').first ?? 'Usuario')
                .trim();
      }
    }

    final payload = <String, dynamic>{
      'email': (user.email ?? '').toLowerCase(),
      'firstName': firstName,
      'lastName': lastName,
      'displayName': display,
      'displayNameLower': display.toLowerCase(),
      'role': (m['role'] ?? ''),
      'updatedAt': FieldValue.serverTimestamp(),
      if (!snap.exists) 'createdAt': FieldValue.serverTimestamp(),
    };

    await ref.set(payload, SetOptions(merge: true));
  }

  String? _emailRule(String? v) {
    final s = v?.trim() ?? '';
    if (s.isEmpty) return 'Requerido';
    final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(s);
    return ok ? null : 'Ingresa un correo válido';
  }

  Future<void> _showDialogMsg(String title, String msg,
      {bool showVerifyButton = false, String? email}) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF3E9FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w700, color: Colors.black, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        content: Text(
          msg,
          style: const TextStyle(color: Colors.black87, fontSize: 15),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          if (showVerifyButton && email != null)
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF9ED3FF), // 💙 azul pastel
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Enviar verificación',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              onPressed: () async {
                try {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null && !user.emailVerified) {
                    await user.sendEmailVerification();
                    Navigator.pop(context);
                    await _showDialogMsg(
                      'Correo enviado',
                      'Se ha enviado un correo de verificación a $email. '
                      'Revisa tu bandeja de entrada.',
                    );
                  }
                } catch (e) {
                  Navigator.pop(context);
                  await _showDialogMsg('Error',
                      'No se pudo enviar el correo de verificación.');
                }
              },
            ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: kPurple, // botón Aceptar morado
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Future<void> _sendPasswordResetDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF3E9FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Recuperar contraseña',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        content: const Text(
            '¿Deseas enviar un correo para restablecer tu contraseña?'),
        actions: [
          TextButton(
            child: const Text('Cancelar', style: TextStyle(color: kPurple)),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            style: TextButton.styleFrom(
                backgroundColor: kPurple, foregroundColor: Colors.black),
            child: const Text('Enviar'),
            onPressed: () {
              Navigator.pop(context);
              _sendPasswordReset();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _sendPasswordReset() async {
    String email = _email.text.trim().toLowerCase();
    if (email.isEmpty) {
      await _showDialogMsg('Atención', 'Escribe tu correo para continuar.');
      return;
    }

    final query = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      await _showDialogMsg('Correo no encontrado',
          'El correo ingresado no está registrado en el sistema.');
      return;
    }

    try {
      final userMethods = FirebaseAuth.instance;
      final userList = await userMethods.fetchSignInMethodsForEmail(email);

      if (userList.isEmpty) {
        await _showDialogMsg('Correo no registrado',
            'Este correo no tiene una cuenta asociada.');
        return;
      }

      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null && !currentUser.emailVerified) {
        await _showDialogMsg(
          'Verifica tu correo',
          'Tu cuenta aún no ha sido verificada. ¿Deseas que te enviemos un nuevo correo de verificación?',
          showVerifyButton: true,
          email: email,
        );
        return;
      }
    } catch (_) {}

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      await _saveResetTs(DateTime.now());
      _startResetCountdownIfNeeded();
      await _showDialogMsg(
        'Correo enviado',
        'Se ha enviado un correo de verificación a $email. Revisa tu bandeja de entrada.',
      );
    } catch (e) {
      await _showDialogMsg('Error', 'No se pudo enviar el correo: $e');
    }
  }


Future<void> _submit() async {
  if (!_formKey.currentState!.validate()) return;
  FocusScope.of(context).unfocus();
  setState(() {
    _loading = true;
    _passwordError = false;
    _passwordErrorText = null;
  });

  final email = _email.text.trim().toLowerCase();
  final password = _pass.text.trim();

  try {
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;

    // 🔹 Intentar iniciar sesión directamente
    try {
  await auth.signInWithEmailAndPassword(email: email, password: password);
} on FirebaseAuthException catch (e) {
  // 🧩 Detecta el motivo exacto y muestra un mensaje claro
  if (e.code == 'user-not-found') {
    // 🔸 Correo no registrado
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF3E9FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Correo no registrado',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        content: const Text(
          'No existe ninguna cuenta asociada a este correo electrónico.\n\n'
          '¿Deseas registrarte con este correo?',
          style: TextStyle(color: Colors.black87, fontSize: 15),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFD6A7F4),
              foregroundColor: Colors.black,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF9ED3FF),
              foregroundColor: Colors.black,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/register'); // 👈 tu pantalla de registro
            },
            child: const Text('Registrarme'),
          ),
        ],
      ),
    );
    setState(() => _loading = false);
    return;

  } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
    // 🔸 Contraseña incorrecta (Firebase usa ambos códigos según versión)
    setState(() {
      _passwordError = true;
      _passwordErrorText = 'Contraseña incorrecta.';
    });
    _pass.clear();
    _passShakeKey.currentState?.shake();
    setState(() => _loading = false);
    return;

  } else if (e.code == 'user-disabled') {
    // 🔸 Cuenta deshabilitada
    await _showDialogMsg(
      'Cuenta deshabilitada',
      'Tu cuenta ha sido desactivada. Contacta al administrador.',
    );
    setState(() => _loading = false);
    return;

  } else if (e.code == 'invalid-email') {
    // 🔸 Formato de correo inválido
    await _showDialogMsg(
      'Correo inválido',
      'El formato del correo electrónico no es válido. Por favor revisa e intenta de nuevo.',
    );
    setState(() => _loading = false);
    return;

  } else {
    // 🔸 Cualquier otro error de FirebaseAuth
    await _showDialogMsg(
      'Error',
      'No se pudo iniciar sesión.\nCódigo de error: ${e.code}',
    );
    setState(() => _loading = false);
    return;
  }
}


    // 🔸 Usuario autenticado correctamente
    final user = auth.currentUser!;
    await user.reload();
    final refreshedUser = auth.currentUser!;

    // 🔸 Verificar si el correo está confirmado
    if (!refreshedUser.emailVerified) {
      await _showDialogMsg(
        'Verifica tu correo',
        'Tu cuenta aún no ha sido verificada. ¿Deseas que te enviemos un nuevo correo de verificación?',
        showVerifyButton: true,
        email: refreshedUser.email,
      );
      await auth.signOut();
      return;
    }

    // 🔹 Cargar información del perfil desde Firestore (ya autenticado)
    await _ensureUserProfile(refreshedUser);
    final snap =
        await firestore.collection('users').doc(refreshedUser.uid).get();
    final data = snap.data() ?? {};
    final role = (data['role'] as String?)?.trim() ?? '';

    final name =
        '${data['firstName'] ?? ''} ${data['lastName'] ?? ''}'.trim().isEmpty
            ? (refreshedUser.email?.split('@').first ?? 'Usuario')
            : '${data['firstName']} ${data['lastName']}';

    if (!mounted) return;

    // 🔸 Redirigir según el rol
    if (role == 'Cuidador') {
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeCaregiverPage.route,
        (_) => false,
        arguments: {'name': name},
      );
    } else if (role == 'Consultante') {
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeConsultantPage.route,
        (_) => false,
        arguments: {'name': name},
      );
    } else {
      await _showDialogMsg(
        'Cuenta sin rol',
        'Tu cuenta no tiene rol asignado. Contacta al administrador.',
      );
    }
  } catch (e) {
    debugPrint('Error general en _submit: $e');
    String message = 'Ocurrió un error al iniciar sesión.';
    if (e.toString().contains('permission-denied')) {
      message =
          'No tienes permiso para acceder a la base de datos. Verifica tus reglas de Firestore.';
    }
    await _showDialogMsg('Error', message);
  } finally {
    if (mounted) setState(() => _loading = false);
  }
}


  // --- UI de inicio de sesión ---
  @override
  Widget build(BuildContext context) {
    final resetLabel = _resetSecondsLeft > 0
        ? '¿Olvidaste tu contraseña? (${_resetSecondsLeft}s)'
        : '¿Olvidaste tu contraseña?';

    final pulseScale = (_resetSecondsLeft > 0 &&
            _resetSecondsLeft <= _pulseThreshold &&
            _pulseUp)
        ? 1.06
        : 1.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kInk),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, ChoiceStart.route, (_) => false);
            }
          },
        ),
        title: const Text(
          'Iniciar sesión',
          style: TextStyle(
            color: kInk,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    const Align(child: BrandLogo(size: 170)),
                    const SizedBox(height: 22),
                    const _FieldLabel('Correo electrónico'),
                    const SizedBox(height: 6),
                    _FieldBox(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: _emailRule,
                    ),
                    const SizedBox(height: 14),
                    const _FieldLabel('Contraseña'),
                    const SizedBox(height: 6),
                    ShakeWidget(
                      key: _passShakeKey,
                      child: TextFormField(
                        controller: _pass,
                        obscureText: _obscurePass,
                        validator: (v) =>
                            (v == null || v.isEmpty) ? 'Requerido' : null,
                        onChanged: (_) {
                          if (_passwordError) {
                            setState(() {
                              _passwordError = false;
                              _passwordErrorText = null;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          errorText: _passwordError ? _passwordErrorText : null,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePass
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey[700],
                            ),
                            onPressed: () {
                              setState(() => _obscurePass = !_obscurePass);
                            },
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: AnimatedScale(
                        scale: pulseScale,
                        duration: const Duration(milliseconds: 300),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF6A1B9A)),
                          onPressed: _resetSecondsLeft > 0
                              ? null
                              : _sendPasswordResetDialog,
                          child: Text(resetLabel),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Align(
                      child: SizedBox(
                        width: 296,
                        height: 56,
                        child: FilledButton.icon(
                          style: pillLav(),
                          onPressed: _loading ? null : _submit,
                          icon: const Icon(Icons.login_rounded,
                              color: Colors.black),
                          label: _loading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(),
                                )
                              : const Text('Entrar',
                                  style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---- Componentes auxiliares ----

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: kInk,
        ),
      );
}

class _FieldBox extends StatelessWidget {
  const _FieldBox({
    required this.controller,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.keyboardType,
  });
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      validator: validator,
      decoration: const InputDecoration(border: OutlineInputBorder()),
    );
  }
}

class ShakeWidget extends StatefulWidget {
  const ShakeWidget({
    super.key,
    required this.child,
    this.magnitude = 10,
    this.duration = const Duration(milliseconds: 420),
  });
  final Widget child;
  final double magnitude;
  final Duration duration;
  @override
  State<ShakeWidget> createState() => _ShakeWidgetState();
}

class _ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _anim;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _anim = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
  }

  Future<void> shake() async {
    if (!mounted) return;
    await _controller.forward(from: 0);
    if (!mounted) return;
    _controller.reset();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, child) {
        final t = _anim.value;
        final dx =
            math.sin(t * 3 * 2 * math.pi) * widget.magnitude * (1.0 - t);
        return Transform.translate(offset: Offset(dx, 0), child: child);
      },
      child: widget.child,
    );
  }
}
