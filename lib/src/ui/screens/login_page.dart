// lib/src/ui/screens/login_page.dart
// Responsable: Owen
//
// CAMBIO FINAL (2 líneas):
//   ANTES: import 'home_consultant.dart';
//   DESPUÉS: import 'home_patient.dart';
//
//   ANTES: HomeConsultantPage.route  (en el bloque else if role == 'Consultante')
//   DESPUÉS: HomePatientPage.route
//
// Este archivo es IDÉNTICO al original excepto esas 2 líneas.
// ─────────────────────────────────────────────────────────────

import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../brand_logo.dart';
import '../theme.dart';
import 'home_caregiver.dart';
import 'home_patient.dart';    // ← CAMBIO: era home_consultant.dart
import 'choice_start.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const route = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _emailCtrl    = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure       = true;
  bool _loading       = false;
  String? _error;

  late AnimationController _animCtrl;
  late Animation<double>   _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeIn);
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final email    = _emailCtrl.text.trim();
    final password = _passwordCtrl.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => _error = 'Por favor llena todos los campos.');
      return;
    }

    setState(() { _loading = true; _error = null; });

    try {
      final auth      = FirebaseAuth.instance;
      final firestore = FirebaseFirestore.instance;

      final cred = await auth.signInWithEmailAndPassword(
        email   : email,
        password: password,
      );

      final refreshedUser = cred.user!;
      await refreshedUser.reload();
      final freshUser = auth.currentUser!;

      if (!freshUser.emailVerified) {
        await _showDialogMsg(
          'Verifica tu correo',
          'Tu cuenta aún no ha sido verificada. ¿Deseas reenviar el correo?',
          showVerifyButton: true,
          email: freshUser.email,
        );
        await auth.signOut();
        setState(() => _loading = false);
        return;
      }

      await _ensureUserProfile(freshUser);

      final snap = await firestore.collection('users').doc(freshUser.uid).get();
      final data = snap.data() ?? {};
      final role = (data['role'] as String?)?.trim() ?? '';

      final name =
          '${data['firstName'] ?? ''} ${data['lastName'] ?? ''}'.trim().isEmpty
              ? (freshUser.email?.split('@').first ?? 'Usuario')
              : '${data['firstName']} ${data['lastName']}';

      if (!mounted) return;

      // ── CAMBIO CLAVE: Consultante → HomePatientPage ───────
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
          HomePatientPage.route,   // ← CAMBIO: era HomeConsultantPage.route
          (_) => false,
          arguments: {'name': name},
        );
      } else {
        await _showDialogMsg(
          'Cuenta sin rol',
          'Tu cuenta no tiene rol asignado. Contacta al administrador.',
        );
        setState(() => _loading = false);
      }
    } on FirebaseAuthException catch (e) {
      String msg;
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          msg = 'Correo o contraseña incorrectos.';
          break;
        case 'too-many-requests':
          msg = 'Demasiados intentos. Espera un momento.';
          break;
        default:
          msg = 'Error de autenticación: ${e.message}';
      }
      setState(() { _error = msg; _loading = false; });
    } catch (e) {
      String message = 'Ocurrió un error al iniciar sesión.';
      if (e.toString().contains('permission-denied')) {
        message = 'No tienes permiso para acceder. Verifica tus reglas de Firestore.';
      }
      setState(() { _error = message; _loading = false; });
    }
  }

  Future<void> _ensureUserProfile(User user) async {
    final ref = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final snap = await ref.get();
    if (!snap.exists) {
      await ref.set({
        'email'    : user.email,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }
  }

  Future<void> _showDialogMsg(
    String title,
    String message, {
    bool showVerifyButton = false,
    String? email,
  }) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title  : Text(title),
        content: Text(message),
        actions: [
          if (showVerifyButton)
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.currentUser
                    ?.sendEmailVerification();
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: const Text('Reenviar correo'),
            ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child    : const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor     : Colors.white,
          surfaceTintColor    : Colors.transparent,
          elevation           : 0,
          leading             : BackButton(color: kInk),
          title               : const Text('Iniciar sesión'),
        ),
        body: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const BrandLogo(size: 110),
                      const SizedBox(height: 32),

                      // Email
                      TextField(
                        controller  : _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration  : const InputDecoration(
                          labelText: 'Correo electrónico',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Contraseña
                      TextField(
                        controller : _passwordCtrl,
                        obscureText: _obscure,
                        decoration : InputDecoration(
                          labelText: 'Contraseña',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(_obscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                            onPressed: () =>
                                setState(() => _obscure = !_obscure),
                          ),
                        ),
                        onSubmitted: (_) => _submit(),
                      ),

                      if (_error != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          _error!,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                      ],

                      const SizedBox(height: 28),

                      // Botón entrar
                      SizedBox(
                        width : 296,
                        height: 56,
                        child : FilledButton(
                          style    : pillLav(),
                          onPressed: _loading ? null : _submit,
                          child    : _loading
                              ? const SizedBox(
                                  width : 22,
                                  height: 22,
                                  child : CircularProgressIndicator(
                                      color: kInk, strokeWidth: 2.5),
                                )
                              : const Text(
                                  'Entrar',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: kInk),
                                ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      TextButton(
                        onPressed: () => Navigator.pushNamed(
                            context, ChoiceStart.route),
                        child: const Text('¿No tienes cuenta? Regístrate'),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
