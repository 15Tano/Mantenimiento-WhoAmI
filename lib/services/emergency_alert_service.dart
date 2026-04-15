// lib/services/emergency_alert_service.dart
// Responsable: Owen
// CAMBIO FINAL: escucha alerts/ global sin orderBy → sin índice compuesto.
// Ordena en cliente. Muestra TODAS las alertas no resueltas (demo OK).

import 'package:cloud_firestore/cloud_firestore.dart';

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
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data() ?? {};
    return EmergencyAlert(
      docId      : doc.id,
      patientUid : (d['patientUid']  as String? ?? ''),
      patientName: (d['patientName'] as String? ?? 'Paciente'),
      createdAt  : (d['createdAt']   as Timestamp?)?.toDate() ?? DateTime.now(),
      resolved   : (d['resolved']    as bool?) ?? false,
    );
  }
}

class EmergencyAlertService {
  EmergencyAlertService(this._db);
  final FirebaseFirestore _db;

  /// Stream de alertas NO resueltas.
  /// Solo usa .where('resolved') — índice simple, automático en Firestore.
  /// Sin .orderBy() → sin índice compuesto → sin setup manual.
  Stream<List<EmergencyAlert>> streamUnresolvedAlerts(String caregiverId) {
    return _db
        .collection('alerts')
        .where('resolved', isEqualTo: false)   // índice simple = automático
        .snapshots()
        .map((snap) {
          final list = snap.docs
              .map((d) => EmergencyAlert.fromDoc(d))
              .toList();
          // Ordenar en cliente: más reciente primero
          list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return list;
        })
        .handleError((_) => <EmergencyAlert>[]);
  }

  /// Marca la alerta como resuelta en alerts/.
  Future<void> resolveAlert({
    required String caregiverId,
    required String alertDocId,
    required String patientUid,
  }) async {
    await _db.collection('alerts').doc(alertDocId).update({
      'resolved'  : true,
      'resolvedAt': FieldValue.serverTimestamp(),
      'resolvedBy': caregiverId,
    });
  }
}
