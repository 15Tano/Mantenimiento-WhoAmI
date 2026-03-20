// lib/services/emergency_alert_service.dart
//
// ╔══════════════════════════════════════════════════════════════╗
// ║  EMERGENCY ALERT SERVICE — Who Am I?  Sprint 2             ║
// ║  Responsable: Owen (Backend/Lógica)                        ║
// ║                                                            ║
// ║  Provee un Stream en tiempo real de las alertas de         ║
// ║  emergencia NO resueltas para el cuidador activo.          ║
// ║                                                            ║
// ║  Lee de: caregivers/{caregiverId}/emergencies/             ║
// ║  Filtra: resolved == false                                 ║
// ║                                                            ║
// ║  También expone resolveAlert() para que el cuidador        ║
// ║  marque la alerta como atendida desde su pantalla.         ║
// ╚══════════════════════════════════════════════════════════════╝

import 'package:cloud_firestore/cloud_firestore.dart';

// ─────────────────────────────────────────────────────────────
//  Modelo de alerta
// ─────────────────────────────────────────────────────────────

/// Representa una alerta de emergencia sin resolver.
class EmergencyAlert {
  const EmergencyAlert({
    required this.docId,
    required this.patientUid,
    required this.patientName,
    required this.createdAt,
    this.resolved = false,
  });

  final String   docId;
  final String   patientUid;
  final String   patientName;
  final DateTime createdAt;
  final bool     resolved;

  factory EmergencyAlert.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};
    return EmergencyAlert(
      docId       : doc.id,
      patientUid  : (data['patientUid']  as String? ?? ''),
      patientName : (data['patientName'] as String? ?? 'Paciente'),
      createdAt   : (data['createdAt']   as Timestamp?)?.toDate() ?? DateTime.now(),
      resolved    : (data['resolved']    as bool?)    ?? false,
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Servicio
// ─────────────────────────────────────────────────────────────

class EmergencyAlertService {
  EmergencyAlertService(this._db);
  final FirebaseFirestore _db;

  /// Stream de alertas NO resueltas para [caregiverId].
  ///
  /// Actualiza automáticamente cuando llega una nueva alerta
  /// o cuando se resuelve una existente (resolved → true).
  ///
  /// El stream devuelve una lista vacía si no hay alertas pendientes,
  /// nunca un error visible al usuario: los errores se absorben silenciosamente.
  Stream<List<EmergencyAlert>> streamUnresolvedAlerts(String caregiverId) {
    return _db
        .collection('caregivers')
        .doc(caregiverId)
        .collection('emergencies')
        .where('resolved', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => EmergencyAlert.fromDoc(doc))
              .toList(),
        )
        .handleError((_) => <EmergencyAlert>[]);
  }

  /// Marca una alerta como resuelta.
  ///
  /// Actualiza en DOS lugares para mantener consistencia:
  ///   1. caregivers/{caregiverId}/emergencies/{alertDocId}
  ///   2. alerts/{alertDocId global} — si el campo patientUid
  ///      coincide con la alerta, también la resuelve allá.
  Future<void> resolveAlert({
    required String caregiverId,
    required String alertDocId,
    required String patientUid,
  }) async {
    final batch = _db.batch();

    // 1) Subcolección del cuidador
    final localRef = _db
        .collection('caregivers')
        .doc(caregiverId)
        .collection('emergencies')
        .doc(alertDocId);
    batch.update(localRef, {
      'resolved'  : true,
      'resolvedAt': FieldValue.serverTimestamp(),
    });

    // 2) Colección global alerts/ — buscamos el documento correspondiente
    //    por patientUid + resolved==false para no hacer un fetch costoso.
    //    Solo actualizamos el primero que coincida (el más reciente).
    try {
      final globalSnap = await _db
          .collection('alerts')
          .where('patientUid', isEqualTo: patientUid)
          .where('resolved',   isEqualTo: false)
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      for (final doc in globalSnap.docs) {
        batch.update(doc.reference, {
          'resolved'  : true,
          'resolvedAt': FieldValue.serverTimestamp(),
          'resolvedBy': caregiverId,
        });
      }
    } catch (_) {
      // Si falla la actualización global, al menos la local sí se resuelve.
    }

    await batch.commit();
  }
}
