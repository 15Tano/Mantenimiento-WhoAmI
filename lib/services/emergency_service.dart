
import 'package:cloud_firestore/cloud_firestore.dart';

/// Resultado de intentar disparar una emergencia.
enum EmergencyResult {
  /// La alerta se escribió correctamente en Firestore.
  success,

  /// No hay conexión o falló la escritura.
  offline,

  /// El paciente no tiene un cuidador asignado aún.
  noCaregiverAssigned,

  /// Error desconocido.
  error,
}

class EmergencyService {
  EmergencyService(this._db);
  final FirebaseFirestore _db;

  /// Dispara una alerta de emergencia para [patientUid].
  ///
  /// Lee el perfil del paciente para obtener su nombre y caregiverId,
  /// luego escribe el documento en `alerts/`.
  ///
  /// Lanza [EmergencyResult] según el resultado.
  Future<EmergencyResult> triggerEmergency({
    required String patientUid,
    required String patientNameFallback,
  }) async {
    try {
      // 1) Leer perfil del paciente para obtener caregiverId y nombre.
      final userSnap =
          await _db.collection('users').doc(patientUid).get().timeout(
                const Duration(seconds: 8),
              );

      if (!userSnap.exists) return EmergencyResult.error;

      final data = userSnap.data()!;
      final caregiverId = data['caregiverId'] as String?;

      // Construir nombre lo más completo posible.
      final firstName = (data['firstName'] as String? ?? '').trim();
      final lastName  = (data['lastName']  as String? ?? '').trim();
      final displayName =
          [firstName, lastName].where((s) => s.isNotEmpty).join(' ');
      final patientName =
          displayName.isNotEmpty ? displayName : patientNameFallback;

      // 2) Escribir alerta en `alerts/`.
      await _db.collection('alerts').add({
        'patientUid'   : patientUid,
        'patientName'  : patientName,
        'caregiverId'  : caregiverId, // puede ser null si no está asignado
        'type'         : 'emergency',
        'resolved'     : false,
        'createdAt'    : FieldValue.serverTimestamp(),
      });

      // 3) También escribir en la subcolección del cuidador (si existe)
      //    para que su listener en HomeCaregiver lo reciba directamente.
      if (caregiverId != null && caregiverId.isNotEmpty) {
        await _db
            .collection('caregivers')
            .doc(caregiverId)
            .collection('emergencies')
            .add({
          'patientUid'  : patientUid,
          'patientName' : patientName,
          'resolved'    : false,
          'createdAt'   : FieldValue.serverTimestamp(),
        });
      } else {
        // Alerta registrada, pero sin cuidador asignado.
        return EmergencyResult.noCaregiverAssigned;
      }

      return EmergencyResult.success;
    } on FirebaseException catch (e) {
      // Firestore indica falta de conectividad con este código.
      if (e.code == 'unavailable' || e.code == 'deadline-exceeded') {
        return EmergencyResult.offline;
      }
      return EmergencyResult.error;
    } catch (_) {
      // Timeout u otro error de red.
      return EmergencyResult.offline;
    }
  }
}
