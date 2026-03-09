import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../services/patients_service.dart';
import '../screens/choice_start.dart';
import '../user_avatar.dart'; // ✅ muestra la foto de perfil

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  static const route = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _db = FirebaseFirestore.instance;
  late final PatientsService _svc;

  User? get _user => FirebaseAuth.instance.currentUser;
  String? get _uid => _user?.uid;

  static const kPurple = Color(0xFFD6A7F4);
  static const kBlue = Color(0xFF9ED3FF);
  static const kPink = Color(0xFFFFB3B3);
  static const kInk = Color(0xFF111111);
  static const kPurpleStrong = Color(0xFF9D4DCB);
  static const kBlueStrong = Color(0xFF4C99E8);

  bool _showTrashAnim = false;

  @override
  void initState() {
    super.initState();
    _svc = PatientsService(_db);
  }

  // ===========================================================
  // FUNCIÓN ELIMINAR CUENTA
  // ===========================================================
  Future<void> _deleteAccount(BuildContext context) async {
    if (_uid == null || _user == null) return;

    final userDoc = await _db.collection('users').doc(_uid).get();
    final data = userDoc.data() ?? {};
    final role = (data['role'] ?? '').toString();

    String message;
    if (role == 'Consultante') {
      message =
          'Perderás todos tus recuerdos, fotos y datos vinculados. Tu cuidador dejará de verte en su lista.';
    } else if (role == 'Cuidador') {
      message =
          'Se eliminarán tus datos, tus consultantes dejarán de estar vinculados y no podrán verte más.';
    } else {
      message =
          'Esta acción eliminará permanentemente tu cuenta y toda tu información.';
    }

    final confirm = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        final passCtrl = TextEditingController();
        bool obscure = true;
        String? errorText;
        bool verifying = false;

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              '¿Eliminar cuenta?',
              style: TextStyle(
                  color: kInk, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$message\n\nPor seguridad, ingresa tu contraseña para confirmar.',
                  style: const TextStyle(color: kInk),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: passCtrl,
                  obscureText: obscure,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: const TextStyle(color: kInk),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: kInk,
                      ),
                      onPressed: () => setState(() => obscure = !obscure),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                if (errorText != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    errorText!,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                  ),
                ],
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                style: TextButton.styleFrom(
                  backgroundColor: kPurple,
                  foregroundColor: kInk,
                ),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: verifying
                    ? null
                    : () async {
                        final password = passCtrl.text.trim();
                        if (password.isEmpty) {
                          setState(() =>
                              errorText = 'Por favor, ingresa tu contraseña.');
                          return;
                        }

                        setState(() {
                          verifying = true;
                          errorText = null;
                        });

                        try {
                          final cred = EmailAuthProvider.credential(
                            email: _user!.email!,
                            password: password,
                          );
                          await _user!.reauthenticateWithCredential(cred);
                          if (ctx.mounted) Navigator.pop(ctx, true);
                        } catch (_) {
                          setState(() {
                            errorText = 'Contraseña incorrecta.';
                            verifying = false;
                          });
                        }
                      },
                style: TextButton.styleFrom(
                  backgroundColor: kPink,
                  foregroundColor: kInk,
                ),
                child: verifying
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Eliminar cuenta'),
              ),
            ],
          );
        });
      },
    );

    if (confirm != true) return;

    try {
      if (role == 'Cuidador') {
        final patients = await _db
            .collection('users')
            .where('caregiverId', isEqualTo: _uid)
            .get();
        for (var doc in patients.docs) {
          await doc.reference.update({'caregiverId': null});
        }
      }

      await _db.collection('users').doc(_uid).delete();

      // 🔹 Guarda UID antes de eliminar (por seguridad)
      final uidToDelete = _uid;

      await _user?.delete();

      if (!mounted) return;

      setState(() => _showTrashAnim = true);
      await Future.delayed(const Duration(seconds: 3));
      setState(() => _showTrashAnim = false);

      if (mounted) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text(
              'Cuenta eliminada',
              style: TextStyle(
                  color: kInk, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            content: const Text(
              'Tu cuenta ha sido eliminada correctamente.',
              style: TextStyle(color: kInk),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kBlue,
                  foregroundColor: kInk,
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      ChoiceStart.route,
                      (_) => false,
                    );
                  }
                },
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al eliminar cuenta: $e'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // ===========================================================
  // INTERFAZ PRINCIPAL
  // ===========================================================
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildMainUI(context),
        if (_showTrashAnim)
          AnimatedTrashAnimation(
            onDone: () => setState(() => _showTrashAnim = false),
          ),
      ],
    );
  }

  Widget _buildMainUI(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_rounded, color: kInk),
        ),
        title: const Text(
          'Ajustes',
          style:
              TextStyle(color: kInk, fontSize: 22, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const UserAvatar(radius: 60), // ✅ avatar agregado
                  const SizedBox(height: 14),

                  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: _uid != null
                        ? _db.collection('users').doc(_uid).snapshots()
                        : const Stream.empty(),
                    builder: (context, snap) {
                      if (!snap.hasData || !snap.data!.exists) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text('Usuario no encontrado'),
                        );
                      }

                      final me = snap.data!.data() ?? {};
                      final role = (me['role'] as String?)?.trim() ?? '';
                      final firstName =
                          (me['firstName'] as String?)?.trim() ?? '';
                      final lastName =
                          (me['lastName'] as String?)?.trim() ?? '';
                      final caregiverId = me['caregiverId'] as String?;
                      final myName = [firstName, lastName]
                          .where((e) => e.isNotEmpty)
                          .join(' ');

                      return Column(
                        children: [
                          Text(
                            myName,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: kInk),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 8),
                            decoration: BoxDecoration(
                              color: role == 'Cuidador'
                                  ? const Color(0xFFF5E9FC)
                                  : const Color(0xFFE8F5FF),
                              border: Border.all(
                                color: role == 'Cuidador'
                                    ? kPurpleStrong
                                    : kBlueStrong,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              role,
                              style: TextStyle(
                                color: role == 'Cuidador'
                                    ? kPurpleStrong
                                    : kBlueStrong,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (role == 'Consultante')
                            _buildCaregiverBlock(caregiverId)
                          else if (role == 'Cuidador')
                            _buildConsultantsBlock(_uid ?? ''),
                          const SizedBox(height: 24),
                        ],
                      );
                    },
                  ),
                  const Text('Gestiona tu cuenta',
                      style: TextStyle(color: Colors.black54)),
                  const SizedBox(height: 10),
                  _buildActionButtons(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // BLOQUES Y BOTONES
  // ===========================================================
  Widget _buildCaregiverBlock(String? caregiverId) {
    if (caregiverId == null || caregiverId.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: kPurple.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: kPurpleStrong, width: 2.0),
        ),
        child: const Text(
          'No tienes un cuidador asignado actualmente.',
          style: TextStyle(
            color: kPurpleStrong,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    return FutureBuilder<DocumentSnapshot>(
      future: _db.collection('users').doc(caregiverId).get(),
      builder: (context, snap) {
        if (!snap.hasData) return const CircularProgressIndicator();
        final data = snap.data!.data() as Map<String, dynamic>?;
        final name = data != null
            ? '${data['firstName'] ?? ''} ${data['lastName'] ?? ''}'.trim()
            : '(Desconocido)';

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: kPurple.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: kPurpleStrong, width: 2.0),
          ),
          child: Text(
            'Tu cuidador: $name',
            style: const TextStyle(
              color: kPurpleStrong,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
        );
      },
    );
  }

  Widget _buildConsultantsBlock(String caregiverId) {
    return StreamBuilder<QuerySnapshot>(
      stream: _db
          .collection('users')
          .where('caregiverId', isEqualTo: caregiverId)
          .snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const CircularProgressIndicator();
        final patients = snap.data!.docs;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: kBlue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: kBlueStrong, width: 2.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tus consultantes:',
                style: TextStyle(
                  color: kBlueStrong,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 6),
              if (patients.isEmpty)
                const Text(
                  'Aún no tienes consultantes asignados.',
                  style: TextStyle(
                    color: kBlueStrong,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              for (var doc in patients)
                Row(
                  children: [
                    const Icon(Icons.person_outline,
                        size: 18, color: kBlueStrong),
                    const SizedBox(width: 6),
                    Text(
                      '${doc['firstName']} ${doc['lastName']}',
                      style: const TextStyle(
                        color: kBlueStrong,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 52,
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: kBlue,
              foregroundColor: kInk,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            onPressed: () =>
                Navigator.pushNamed(context, '/settings/edit-profile'),
            icon: const Icon(Icons.person_outline),
            label: const Text('Perfil'),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: kPurple,
              foregroundColor: kInk,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!mounted) return;
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (_) => false);
            },
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar sesión'),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: kPink,
              foregroundColor: kInk,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            onPressed: () => _deleteAccount(context),
            icon: const Icon(Icons.delete_forever_outlined),
            label: const Text('Eliminar cuenta'),
          ),
        ),
      ],
    );
  }
}

// ===========================================================
// ANIMACIÓN DEL BOTE DE BASURA
// ===========================================================
class AnimatedTrashAnimation extends StatefulWidget {
  final VoidCallback onDone;
  const AnimatedTrashAnimation({super.key, required this.onDone});

  @override
  State<AnimatedTrashAnimation> createState() =>
      _AnimatedTrashAnimationState();
}

class _AnimatedTrashAnimationState extends State<AnimatedTrashAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _paperAnim;
  late Animation<double> _lidAnim;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _paperAnim = Tween<double>(begin: -1, end: 0.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _lidAnim = Tween<double>(begin: 0, end: -0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
    );
    _controller.forward().whenComplete(widget.onDone);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.95),
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Transform.translate(
                offset: Offset(0, 200 * _paperAnim.value),
                child: const Icon(Icons.description_outlined,
                    size: 60, color: Colors.grey),
              ),
              const Positioned(
                bottom: 200,
                child:
                    Icon(Icons.delete_outline, size: 100, color: Colors.black87),
              ),
              Positioned(
                bottom: 280,
                child: Transform.rotate(
                  angle: _lidAnim.value,
                  origin: const Offset(30, 10),
                  child: const Icon(Icons.horizontal_rule_rounded,
                      size: 100, color: Colors.black87),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
