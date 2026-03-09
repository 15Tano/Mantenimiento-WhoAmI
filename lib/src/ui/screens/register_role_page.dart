// lib/src/ui/screens/register_role_page.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../brand_logo.dart';
import '../theme.dart';
import 'login_page.dart';

class RegisterRolePage extends StatefulWidget {
  const RegisterRolePage({super.key});
  static const route = '/register/role';

  @override
  State<RegisterRolePage> createState() => _RegisterRolePageState();
}

class _RegisterRolePageState extends State<RegisterRolePage> {
  bool _saving = false;

  String _buildDisplayName(String? nombre, String? apellidos, String? email) {
    final n = (nombre ?? '').trim();
    final a = (apellidos ?? '').trim();
    final byName = [n, a].where((e) => e.isNotEmpty).join(' ').trim();
    if (byName.isNotEmpty) return byName;
    return (email ?? '').trim();
  }

  /// ---- Ventana emergente de Confirmar rol ----
  Future<bool> _confirmarRol(String role) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.white,
              title: const Text(
                'Confirmar rol',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              content: Text(
                'Estás a punto de registrarte como "$role".\n\n'
                'Una vez creada tu cuenta, no podrás cambiar este rol.\n\n'
                '¿Deseas continuar?',
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 120,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: kPurple,
                          foregroundColor: Colors.black,
                          padding:
                              const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancelar'),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: kBlue,
                          foregroundColor: Colors.black,
                          padding:
                              const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Confirmar'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ) ??
        false;
  }

  /// ---- Ventana emergente de error personalizado ----
  Future<void> _showErrorDialog(String message) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Error',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
              SizedBox(
                width: 120,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: kBlue,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Aceptar'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Future<void> _finishSignUp(String role) async {
    final confirmado = await _confirmarRol(role);
    if (!confirmado) return;

    final args = (ModalRoute.of(context)?.settings.arguments as Map?) ?? {};
    final emailRaw = (args['email'] as String?)?.trim();
    final password = args['password'] as String?;
    final nombre = (args['nombre'] as String?)?.trim();
    final apellidos = (args['apellidos'] as String?)?.trim();
    final birthdayIso = args['birthday'] as String?;
    final birthday =
        birthdayIso != null ? DateTime.tryParse(birthdayIso) : null;

    final email = emailRaw?.toLowerCase();

    if (email == null || password == null || email.isEmpty || password.isEmpty) {
      await _showErrorDialog('Faltan correo o contraseña.');
      return;
    }

    setState(() => _saving = true);
    try {
      final cred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final uid = cred.user!.uid;
      final displayName = _buildDisplayName(nombre, apellidos, email);

      final data = <String, dynamic>{
        'email': email,
        'firstName': nombre ?? '',
        'lastName': apellidos ?? '',
        'displayName': displayName,
        'displayNameLower': displayName.toLowerCase(),
        'role': role,
        'archived': false,
        'caregiverId': null,
        'updatedAt': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
        if (birthday != null) 'birthday': Timestamp.fromDate(birthday),
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(data, SetOptions(merge: true));

      await cred.user!.updateDisplayName(displayName);

      try {
        await cred.user!.sendEmailVerification();
      } catch (e) {
        await _showErrorDialog('No se pudo enviar el correo de verificación.\n$e');
      }

      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (ctx) {
          bool _resending = false;
          return StatefulBuilder(
            builder: (ctx, setDlg) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor: Colors.white,
              title: const Text(
                'Cuenta creada',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              content: Text(
                'Tu cuenta se creó correctamente.\n\n'
                'Te enviamos un correo de verificación a:\n$email\n\n'
                'Por favor verifica antes de iniciar sesión.',
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: _resending
                      ? null
                      : () async {
                          setDlg(() => _resending = true);
                          try {
                            await cred.user!.sendEmailVerification();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    'Correo reenviado correctamente.',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  backgroundColor: kPurple.withOpacity(0.8),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            }
                          } finally {
                            if (ctx.mounted) setDlg(() => _resending = false);
                          }
                        },
                  child: _resending
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child:
                              CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text(
                          'Reenviar correo',
                          style: TextStyle(
                              color: kPurple, fontWeight: FontWeight.bold),
                        ),
                ),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: kPurple,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Aceptar'),
                ),
              ],
            ),
          );
        },
      );

      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, LoginPage.route, (_) => false);
      }
    } on FirebaseAuthException catch (e) {
      String msg = 'Ocurrió un problema.';
      switch (e.code) {
        case 'email-already-in-use':
          msg = 'Este correo ya está en uso. Intenta con otro.';
          break;
        case 'invalid-email':
          msg = 'El correo no es válido.';
          break;
        case 'weak-password':
          msg = 'La contraseña es muy débil.';
          break;
      }
      await _showErrorDialog(msg);
    } catch (e) {
      await _showErrorDialog('Error: $e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: kInk),
            onPressed: _saving ? null : () => Navigator.maybePop(context),
          ),
          centerTitle: true,
          title: const Text(
            'Regístrate',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: kInk,
            ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    const Align(child: BrandLogo(size: 170)),
                    const SizedBox(height: 22),
                    const Text(
                      'Selecciona un tipo de usuario',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: kInk,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Align(
                      child: SizedBox(
                        width: 296,
                        height: 56,
                        child: FilledButton(
                          style: pillLav(),
                          onPressed:
                              _saving ? null : () => _finishSignUp('Cuidador'),
                          child: _saving
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(),
                                )
                              : const Text('Cuidador'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Center(
                      child:
                          Text('O', style: TextStyle(fontSize: 18, color: kInk)),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      child: SizedBox(
                        width: 296,
                        height: 56,
                        child: FilledButton(
                          style: pillBlue(),
                          onPressed:
                              _saving ? null : () => _finishSignUp('Consultante'),
                          child: _saving
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(),
                                )
                              : const Text('Consultante'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
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
