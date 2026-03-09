import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProfileService {
  AuthProfileService(this._auth, this._db);
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  /// Crea cuenta y asegura perfil en `users/{uid}`
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String role, // "Cuidador" | "Consultante"
    DateTime? birthday,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _ensureUserProfile(
      uid: cred.user!.uid,
      email: email,
      firstName: firstName,
      lastName: lastName,
      role: role,
      birthday: birthday,
    );
    return cred;
  }

  /// Login normal y asegura que el perfil exista y esté normalizado
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Asegura/normaliza perfil en cada login
    await _ensureUserProfile(uid: cred.user!.uid);
    return cred;
  }

  /// Crea o actualiza `users/{uid}` con merge (no duplica).
  Future<void> _ensureUserProfile({
    required String uid,
    String? email,
    String? firstName,
    String? lastName,
    String? role,
    DateTime? birthday,
    String? photoUrl,
  }) async {
    final ref = _db.collection('users').doc(uid);
    final now = FieldValue.serverTimestamp();

    // Lee lo que haya para no pisar campos existentes
    final snap = await ref.get();
    final current = snap.data() ?? <String, dynamic>{};

    final _first = (firstName ?? current['firstName'] ?? '').toString().trim();
    final _last  = (lastName  ?? current['lastName']  ?? '').toString().trim();
    final _display = (current['displayName'] ??
            '${_first.isNotEmpty ? _first : ''} ${_last.isNotEmpty ? _last : ''}')
        .toString()
        .trim();

    final data = <String, dynamic>{
      if (email != null) 'email': email,
      'firstName': _first,
      'lastName': _last,
      'displayName': _display.isNotEmpty ? _display : (_first.isNotEmpty || _last.isNotEmpty ? '$_first $_last'.trim() : (email ?? '')),
      'displayNameLower': (_display.isNotEmpty
              ? _display
              : (_first.isNotEmpty || _last.isNotEmpty ? '$_first $_last' : (email ?? '')))
          .toLowerCase()
          .trim(),
      if (role != null) 'role': role, // "Cuidador" o "Consultante"
      if (birthday != null) 'birthday': Timestamp.fromDate(birthday),
      if (photoUrl != null) 'photoUrl': photoUrl,
      // Nunca duplicar: estos flags ayudan a tu app
      'archived': false,
      'updatedAt': now,
      if (!snap.exists) 'createdAt': now,
    };

    await ref.set(data, SetOptions(merge: true));
  }

  /// Actualiza datos del perfil y mantiene `displayNameLower`
  Future<void> updateProfile({
    required String uid,
    String? firstName,
    String? lastName,
    String? displayName,
    DateTime? birthday,
    String? photoUrl,
  }) async {
    final ref = _db.collection('users').doc(uid);
    final snap = await ref.get();
    final cur = snap.data() ?? {};
    final _first = (firstName ?? cur['firstName'] ?? '').toString().trim();
    final _last  = (lastName  ?? cur['lastName']  ?? '').toString().trim();
    String _disp  = (displayName ?? cur['displayName'] ?? '').toString().trim();
    if (_disp.isEmpty) {
      _disp = '$_first $_last'.trim();
    }
    final data = <String, dynamic>{
      if (firstName != null) 'firstName': _first,
      if (lastName  != null) 'lastName': _last,
      'displayName': _disp,
      'displayNameLower': _disp.toLowerCase(),
      if (birthday != null) 'birthday': Timestamp.fromDate(birthday),
      if (photoUrl  != null) 'photoUrl': photoUrl,
      'updatedAt': FieldValue.serverTimestamp(),
    };
    await ref.set(data, SetOptions(merge: true));
  }
}
