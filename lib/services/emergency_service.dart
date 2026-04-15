// lib/services/emergency_service.dart
// Responsable: Owen
// CAMBIO FINAL: escribe SOLO en alerts/ (no subcollección).
// Funciona aunque caregiverId sea null. Sin índice compuesto.

import 'package:cloud_firestore/cloud_firestore.dart';

enum EmergencyResult { success, offline, noCaregiverAssigned, error }

class EmergencyService {
  EmergencyService(this._db);
  final FirebaseFirestore _db;

  Future<EmergencyResult> triggerEmergency({
    required String patientUid,
    required String patientNameFallback,
  }) async {
    try {
      // Leer perfil del paciente
      final userSnap = await _db
          .collection('users')
          .doc(patientUid)
          .get()
          .timeout(const Duration(seconds: 8));

      if (!userSnap.exists) return EmergencyResult.error;

      final data        = userSnap.data()!;
      final caregiverId = data['caregiverId'] as String?;
      final firstName   = (data['firstName'] as String? ?? '').trim();
      final lastName    = (data['lastName']  as String? ?? '').trim();
      final patientName = [firstName, lastName]
              .where((s) => s.isNotEmpty)
              .join(' ')
              .let((n) => n.isNotEmpty ? n : patientNameFallback);

      // Escribir UNA sola vez en alerts/ — sin subcollección
      await _db.collection('alerts').add({
        'patientUid'  : patientUid,
        'patientName' : patientName,
        'caregiverId' : caregiverId,   // puede ser null, no importa
        'type'        : 'emergency',
        'resolved'    : false,
        'createdAt'   : FieldValue.serverTimestamp(),
      });

      return caregiverId != null && caregiverId.isNotEmpty
          ? EmergencyResult.success
          : EmergencyResult.noCaregiverAssigned;
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' || e.code == 'deadline-exceeded') {
        return EmergencyResult.offline;
      }
      return EmergencyResult.error;
    } catch (_) {
      return EmergencyResult.offline;
    }
  }
}

// Dart extension para encadenar .let()
extension _Let<T> on T {
  R let<R>(R Function(T) block) => block(this);
}
