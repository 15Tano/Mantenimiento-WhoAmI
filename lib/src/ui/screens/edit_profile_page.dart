import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../theme.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});
  static const route = '/settings/edit-profile';

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _firstName = TextEditingController();
  final _lastName  = TextEditingController();
  final _email     = TextEditingController();
  final _dobCtrl   = TextEditingController();

  bool _loading = true;
  bool _saving  = false;
  bool _dirty   = false;
  bool _isCaregiver = false;

  DateTime? _birthDate;
  String? _photoUrl;
  File? _localPhoto;

  late Map<String, String?> _original;

  @override
  void initState() {
    super.initState();
    _load();
  }

  // ===== Helpers UI: diálogos modales =====
  Future<void> _showDialogOk({
    required String title,
    required String message,
    IconData? icon,
  }) async {
    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: kPurple),
              const SizedBox(width: 8),
            ],
            Flexible(child: Text(title)),
          ],
        ),
        content: Text(message),
        actions: [
          FilledButton(
            style: pillLav(), // Fondo morado
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Aceptar',
              // ⬇️ Texto negro (antes blanco)
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  DateTime? _parseBirthDate(dynamic raw) {
    if (raw == null) return null;
    try {
      if (raw is Timestamp) return raw.toDate();
    } catch (_) {}
    if (raw is int) {
      try { return DateTime.fromMillisecondsSinceEpoch(raw); } catch (_) {}
    }
    if (raw is String) {
      try { return DateTime.parse(raw); } catch (_) {
        final p = raw.split('/');
        if (p.length == 3) {
          final d = int.tryParse(p[0]);
          final m = int.tryParse(p[1]);
          final y = int.tryParse(p[2]);
          if (d != null && m != null && y != null) return DateTime(y, m, d);
        }
      }
    }
    return null;
  }

  Future<void> _load() async {
    final user = FirebaseAuth.instance.currentUser!;
    final snap = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    final data = snap.data() ?? {};

    _firstName.text = (data['firstName'] as String?) ?? '';
    _lastName.text  = (data['lastName']  as String?) ?? '';
    _email.text     = user.email ?? '';
    _photoUrl       = user.photoURL;

    final role = (data['role'] as String?)?.trim() ?? 'Consultante';
    _isCaregiver = role == 'Cuidador';

    final rawDob = data['birthDate'] ?? data['birthday'] ?? data['dob'] ?? data['dateOfBirth'];
    _birthDate = _parseBirthDate(rawDob);
    _dobCtrl.text = _birthDate == null ? '' : _fmt(_birthDate!);

    _original = {
      'firstName': _firstName.text,
      'lastName' : _lastName.text,
      'email'    : _email.text,
      'photo'    : _photoUrl,
      'birthDate': _birthDate?.toIso8601String(),
    };

    if (_isCaregiver) {
      for (final c in [_firstName, _lastName, _dobCtrl]) {
        c.addListener(_recomputeDirty);
      }
    }

    _localPhoto = null;
    _dirty = false;

    if (mounted) setState(() => _loading = false);
  }

  void _recomputeDirty() {
    final photoChanged = _localPhoto != null;
    if (_isCaregiver) {
      final birthIso = _birthDate?.toIso8601String();
      final textChanged =
          _firstName.text != (_original['firstName'] ?? '') ||
          _lastName.text  != (_original['lastName']  ?? '') ||
          birthIso        != (_original['birthDate']);
      final newDirty = textChanged || photoChanged;
      if (newDirty != _dirty) setState(() => _dirty = newDirty);
    } else {
      final newDirty = photoChanged;
      if (newDirty != _dirty) setState(() => _dirty = newDirty);
    }
  }

  Future<void> _pickPhoto() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (img != null) {
      setState(() => _localPhoto = File(img.path));
      _recomputeDirty();
    }
  }

  Future<void> _pickBirthDate() async {
    if (!_isCaregiver) return;
    final now = DateTime.now();
    final initial = _birthDate ?? DateTime(now.year - 18, now.month, now.day);

    final picked = await showDatePicker(
      context: context,
      locale: const Locale('es'),
      initialDate: initial,
      firstDate: DateTime(1900, 1, 1),
      lastDate: now,
      helpText: 'Selecciona tu fecha de nacimiento',
    );
    if (picked != null) {
      setState(() {
        _birthDate = DateTime(picked.year, picked.month, picked.day);
        _dobCtrl.text = _fmt(_birthDate!);
      });
      _recomputeDirty();
    }
  }

  Future<String?> _uploadPhoto(User user) async {
    if (_localPhoto == null) return _photoUrl;

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('users') // si cambias reglas a profile_images, ajusta aquí
          .child(user.uid)
          .child('avatar.jpg');

      final task = await ref.putFile(
        _localPhoto!,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      if (task.state == TaskState.success) {
        final url = await ref.getDownloadURL();
        return url;
      } else {
        debugPrint('⚠️ Subida no exitosa: ${task.state}');
        return _photoUrl;
      }
    } on FirebaseException catch (e) {
      debugPrint('❌ Storage error: ${e.code} ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('❌ Error subiendo imagen: $e');
      rethrow;
    }
  }

  Future<void> _save({bool exitAfter = false}) async {
    if (!_dirty) {
      await _showDialogOk(
        title: 'Sin cambios',
        message: 'No hay cambios para guardar.',
        icon: Icons.info_outline,
      );
      return;
    }

    setState(() => _saving = true);
    final user = FirebaseAuth.instance.currentUser!;

    try {
      // FOTO
      if (_localPhoto != null) {
        final url = await _uploadPhoto(user);
        if (url != null) {
          _photoUrl = url;
          await user.updatePhotoURL(url);
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({'photoURL': url}, SetOptions(merge: true));
        }
      }

      // DATOS
      if (_isCaregiver) {
        final updates = <String, dynamic>{};

        if (_firstName.text.trim() != (_original['firstName'] ?? '')) {
          updates['firstName'] = _firstName.text.trim();
        }
        if (_lastName.text.trim() != (_original['lastName'] ?? '')) {
          updates['lastName'] = _lastName.text.trim();
        }
        if (_birthDate?.toIso8601String() != _original['birthDate']) {
          updates['birthDate'] = _birthDate;
        }

        if (updates.isNotEmpty) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(updates, SetOptions(merge: true));
        }

        final newDisplayName =
            '${_firstName.text.trim()} ${_lastName.text.trim()}'.trim();
        if (newDisplayName != ((user.displayName ?? '').trim())) {
          await user.updateDisplayName(newDisplayName);
        }
      }

      await user.reload();
      await _load();
      _localPhoto = null;
      _dirty = false;
      if (mounted) setState(() {});

      // ✅ Éxito: modal
      await _showDialogOk(
        title: '¡Listo!',
        message: 'Cambios guardados exitosamente.',
        icon: Icons.check_circle_outline,
      );

      if (exitAfter && mounted) Navigator.maybePop(context);
    } on FirebaseException catch (e) {
      await _showDialogOk(
        title: 'No se pudo guardar',
        message: 'Ocurrió un error (${e.code}). Intenta de nuevo.',
        icon: Icons.error_outline,
      );
    } catch (e) {
      await _showDialogOk(
        title: 'No se pudo guardar',
        message: 'Ocurrió un error inesperado.\n$e',
        icon: Icons.error_outline,
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<bool> _confirmBeforeLeave() async {
    if (!_dirty) return true;

    final action = await showDialog<_LeaveAction>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tienes cambios sin guardar'),
        content: const Text('Debes elegir una opción antes de salir.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, _LeaveAction.keepEditing),
            child: const Text('Seguir editando'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, _LeaveAction.discard),
            child: const Text('Cancelar cambios'),
          ),
          FilledButton(
            style: pillLav(),
            onPressed: () => Navigator.pop(context, _LeaveAction.saveAndExit),
            child: const Text(
              'Guardar y salir',
              // ⬇️ Texto negro (antes blanco)
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );

    switch (action) {
      case _LeaveAction.discard:
        _restoreOriginal();
        await _showDialogOk(
          title: 'Hecho',
          message: 'Cambios descartados.',
          icon: Icons.info_outline,
        );
        return true;
      case _LeaveAction.saveAndExit:
        await _save(exitAfter: true);
        return false;
      case _LeaveAction.keepEditing:
      default:
        return false;
    }
  }

  void _restoreOriginal() {
    _firstName.text = _original['firstName'] ?? '';
    _lastName.text  = _original['lastName']  ?? '';
    _email.text     = _original['email']     ?? '';
    _photoUrl       = _original['photo'];
    final origDob = _original['birthDate'];
    _birthDate = (origDob == null) ? null : DateTime.tryParse(origDob);
    _dobCtrl.text = _birthDate == null ? '' : _fmt(_birthDate!);
    _localPhoto = null;
    _dirty = false;
    if (mounted) setState(() {});
  }

  // 📩 Solicitar cambio de contraseña (también con modal)
  Future<void> _requestPasswordReset() async {
    final email = _email.text.trim().toLowerCase();
    if (email.isEmpty) {
      await _showDialogOk(
        title: 'Correo no disponible',
        message: 'Tu cuenta no tiene un correo válido.',
        icon: Icons.info_outline,
      );
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      await _showDialogOk(
        title: 'Revisa tu correo',
        message:
            'Te enviamos un enlace para cambiar tu contraseña a:\n\n$email\n\n'
            'Si no lo ves, revisa también SPAM.',
        icon: Icons.mark_email_read_outlined,
      );
    } on FirebaseAuthException catch (e) {
      String msg = 'No se pudo enviar el correo de recuperación.';
      if (e.code == 'invalid-email') msg = 'El correo no es válido.';
      if (e.code == 'user-not-found') msg = 'No existe una cuenta con ese correo.';
      await _showDialogOk(
        title: 'No se pudo enviar',
        message: msg,
        icon: Icons.error_outline,
      );
    } catch (e) {
      await _showDialogOk(
        title: 'Error',
        message: 'Ocurrió un error inesperado.\n$e',
        icon: Icons.error_outline,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _confirmBeforeLeave,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: kInk,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'Perfil',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: kInk),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: kInk),
            onPressed: () async {
              final canLeave = await _confirmBeforeLeave();
              if (canLeave && mounted) Navigator.maybePop(context);
            },
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: _loading
                  ? const Padding(
                      padding: EdgeInsets.only(top: 80),
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 20),

                          // Foto
                          Center(
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 52,
                                  backgroundImage: _localPhoto != null
                                      ? FileImage(_localPhoto!)
                                      : (_photoUrl != null ? NetworkImage(_photoUrl!) : null)
                                          as ImageProvider<Object>?,
                                  child: (_localPhoto == null && _photoUrl == null)
                                      ? const Icon(Icons.person, size: 48, color: Colors.white)
                                      : null,
                                  backgroundColor: Colors.black,
                                ),
                                Material(
                                  color: kPurple,
                                  shape: const CircleBorder(),
                                  elevation: 3,
                                  child: InkWell(
                                    customBorder: const CircleBorder(),
                                    onTap: _pickPhoto,
                                    child: const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(
                                        Icons.photo_camera_outlined,
                                        // ⬇️ Ícono negro (antes blanco)
                                        color: Colors.black,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 18),

                          TextField(
                            controller: _firstName,
                            enabled: _isCaregiver,
                            decoration: const InputDecoration(
                              labelText: 'Nombre',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (_) => _recomputeDirty(),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _lastName,
                            enabled: _isCaregiver,
                            decoration: const InputDecoration(
                              labelText: 'Apellidos',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (_) => _recomputeDirty(),
                          ),
                          const SizedBox(height: 12),

                          TextField(
                            controller: _dobCtrl,
                            readOnly: true,
                            enabled: _isCaregiver,
                            decoration: const InputDecoration(
                              labelText: 'Fecha de nacimiento',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            onTap: _isCaregiver ? _pickBirthDate : null,
                          ),
                          const SizedBox(height: 12),

                          TextField(
                            controller: _email,
                            enabled: false,
                            decoration: const InputDecoration(
                              labelText: 'Correo electrónico',
                              border: OutlineInputBorder(),
                            ),
                          ),

                          const SizedBox(height: 22),
                          const Divider(),
                          const SizedBox(height: 10),

                          // Botón morado con letras e ícono NEGROS
                          SizedBox(
                            height: 52,
                            child: FilledButton.icon(
                              style: pillLav(),
                              onPressed: _requestPasswordReset,
                              icon: const Icon(Icons.lock_reset, color: Colors.black),
                              label: const Text(
                                'Solicitar cambio de contraseña',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),

                          const SizedBox(height: 22),

                          Row(
                            children: [
                              Expanded(
                                child: FilledButton.icon(
                                  onPressed: _dirty ? _restoreOriginal : null,
                                  icon: const Icon(Icons.close_rounded, color: Colors.black),
                                  label: const Text(
                                    'Cancelar',
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                  ),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: const Color(0xFFFF9EA3),
                                    disabledBackgroundColor: const Color(0x55FF9EA3),
                                    shape: const StadiumBorder(),
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: FilledButton.icon(
                                  onPressed: (_saving || !_dirty) ? null : () => _save(),
                                  icon: _saving
                                      ? const SizedBox(
                                          width: 18, height: 18,
                                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                                        )
                                      : const Icon(Icons.save_outlined, color: Colors.black),
                                  label: Text(
                                    _saving ? 'Guardando...' : 'Guardar',
                                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                  ),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: kBlue,
                                    disabledBackgroundColor: const Color(0x559ED3FF),
                                    shape: const StadiumBorder(),
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),
                          if (!_dirty && !_saving)
                            const Text(
                              'Modifica tus datos para habilitar Guardar y Cancelar.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12, color: Color(0xFF8A8A8A)),
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

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _dobCtrl.dispose();
    super.dispose();
  }
}

enum _LeaveAction { keepEditing, discard, saveAndExit }
