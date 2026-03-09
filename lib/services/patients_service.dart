// lib/services/patients_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientsService {
  PatientsService(this._db);
  final FirebaseFirestore _db;

  /// Consultantes SIN cuidador (para buscador/agregar)
  /// 🔁 Solo filtramos por `role` en Firestore (no requiere índice compuesto).
  /// Luego filtramos en cliente por `caregiverId == null` y por texto (q).
  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      streamUnassignedConsultants({String q = ''}) {
    final col = _db.collection('users')
        .where('role', isEqualTo: 'Consultante')
        .limit(100);

    return col.snapshots().map((snap) {
      // 1) Filtrar en cliente por caregiverId null o inexistente
      var docs = snap.docs.where((d) {
        final data = d.data();
        return !data.containsKey('caregiverId') || data['caregiverId'] == null;
      }).toList();

      // 2) Filtro por texto (displayName o first/last)
      if (q.trim().isNotEmpty) {
        final lower = q.trim().toLowerCase();
        docs = docs.where((d) {
          final data = d.data();
          final displayName = (data['displayName'] ??
                  '${data['firstName'] ?? ''} ${data['lastName'] ?? ''}')
              .toString()
              .toLowerCase()
              .trim();
          return displayName.contains(lower);
        }).toList();
      }

      return docs;
    });
  }

  /// Consultantes ASIGNADOS al cuidador actual (lee índice y resuelve perfiles)
  Stream<List<DocumentSnapshot<Map<String, dynamic>>>> streamPatientsOfCaregiver(String caregiverId) {
    final idx = _db.collection('caregivers').doc(caregiverId).collection('patients');
    return idx.snapshots().asyncMap((snap) async {
      if (snap.docs.isEmpty) return <DocumentSnapshot<Map<String, dynamic>>>[];
      final futures = snap.docs.map((p) => _db.collection('users').doc(p.id).get());
      return Future.wait(futures);
    });
  }

  /// Agregar consultante a cuidador (transacción con validaciones)
  Future<void> addPatientToCaregiver({
    required String caregiverId,
    required String patientUserId,
  }) async {
    final userRef = _db.collection('users').doc(patientUserId);
    final idxRef  = _db.collection('caregivers').doc(caregiverId)
                    .collection('patients').doc(patientUserId);

    await _db.runTransaction((tx) async {
      final userSnap = await tx.get(userRef);
      if (!userSnap.exists) {
        throw Exception('El usuario no existe.');
      }
      final data = userSnap.data() as Map<String, dynamic>;
      if ((data['role'] ?? '') != 'Consultante') {
        throw Exception('Solo se pueden agregar usuarios con rol Consultante.');
      }
      final current = data['caregiverId'];
      if (current != null && current != caregiverId) {
        throw Exception('Este consultante ya está asignado a otro cuidador.');
      }
      if (current == caregiverId) {
        // ya estaba asignado contigo: asegurar índice
        if (!(await tx.get(idxRef)).exists) {
          tx.set(idxRef, {
            'patientUserId': patientUserId,
            'addedAt': FieldValue.serverTimestamp(),
          });
        }
        return;
      }
      // Asignación inicial
      tx.update(userRef, {'caregiverId': caregiverId});
      tx.set(idxRef, {
        'patientUserId': patientUserId,
        'addedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  /// Quitar consultante del cuidador (desasigna y borra del índice)
  Future<void> removePatientFromCaregiver({
    required String caregiverId,
    required String patientUserId,
  }) async {
    final userRef = _db.collection('users').doc(patientUserId);
    final idxRef  = _db.collection('caregivers').doc(caregiverId)
                    .collection('patients').doc(patientUserId);

    await _db.runTransaction((tx) async {
      final userSnap = await tx.get(userRef);
      if (!userSnap.exists) return;
      final data = userSnap.data() as Map<String, dynamic>;
      if (data['caregiverId'] == caregiverId) {
        tx.update(userRef, {'caregiverId': null});
      }
      tx.delete(idxRef);
    });
  }
}
