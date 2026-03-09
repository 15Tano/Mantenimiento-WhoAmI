import 'package:cloud_firestore/cloud_firestore.dart';
import 'notifications_service.dart';

/// Valores permitidos para la frecuencia en Firestore:
/// "weekly" | "biweekly" | "monthly" | "quarterly" | "semiannual" | "annual"
///
/// Si el documento no trae 'frequency', se usa "monthly" por defecto.
class MemoriesScheduler {
  static final _db = FirebaseFirestore.instance;

  /// Programa recordatorios para TODOS los recuerdos del usuario.
  static Future<void> scheduleAllForUser(String uid) async {
    final coll = _db.collection('memories').doc(uid).collection('user_memories');

    final snap = await coll.get();
    for (final doc in snap.docs) {
      await _scheduleFromDoc(uid, doc);
    }
  }

  /// Programa recordatorio para UN recuerdo a partir de su DocumentSnapshot.
  static Future<void> scheduleOneById(String uid, String memoryId) async {
    final ref = _db
        .collection('memories')
        .doc(uid)
        .collection('user_memories')
        .doc(memoryId);
    final doc = await ref.get();
    if (doc.exists) {
      await _scheduleFromDoc(uid, doc);
    }
  }

  /// Lee campos del doc y llama a NotificationsService.scheduleForMemory().
  static Future<void> _scheduleFromDoc(
      String uid, DocumentSnapshot<Map<String, dynamic>> doc) async {
    final data = doc.data();
    if (data == null) return;

    final memoryId = doc.id;

    // title: usa 'text' si existe, si no, un texto genérico
    final title = (data['text'] as String?)?.trim();
    final safeTitle = (title == null || title.isEmpty) ? 'Tu recuerdo' : title;

    // date: en tu base está como string ISO. Si algún doc lo tuviera como Timestamp, también soportamos.
    DateTime? anchor;
    final dateField = data['date'];
    if (dateField is String) {
      try {
        anchor = DateTime.parse(dateField).toLocal();
      } catch (_) {}
    } else if (dateField is Timestamp) {
      anchor = dateField.toDate();
    }
    if (anchor == null) return; // si no hay fecha válida, no se programa

    // frequency: opcional. Por defecto monthly
    final freqRaw = (data['frequency'] as String?)?.toLowerCase().trim() ?? 'monthly';
    final cadence = cadenceFromString(freqRaw);

    await NotificationsService.scheduleForMemory(
      memoryId: '$uid/$memoryId',
      title: safeTitle,
      anchorDate: anchor,
      cadence: cadence,
    );
  }
}
