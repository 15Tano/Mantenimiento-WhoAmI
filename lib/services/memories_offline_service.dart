// lib/services/memories_offline_service.dart
//
// ╔══════════════════════════════════════════════════════════════╗
// ║  MEMORIES OFFLINE SERVICE — Who Am I?  Sprint 2            ║
// ║  Responsable: Owen (Backend/Lógica)                        ║
// ║                                                            ║
// ║  Guarda en SharedPreferences el índice de recuerdos        ║
// ║  (lista de dateIds con fecha y texto) para que             ║
// ║  CalendarPage funcione sin internet.                       ║
// ║                                                            ║
// ║  ESTRATEGIA DE CACHÉ:                                      ║
// ║  • En línea  → lee Firestore, actualiza caché y UI.        ║
// ║  • Sin línea → lee caché, muestra indicador "offline".     ║
// ║                                                            ║
// ║  ESTRUCTURA CACHEADA (SharedPreferences):                  ║
// ║  Clave: memories_index_{uid}                               ║
// ║  Valor: JSON  → { "dateId": { text, imageUrl?, cachedAt }} ║
// ╚══════════════════════════════════════════════════════════════╝

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─────────────────────────────────────────────────────────────
//  Modelo lightweight de recuerdo para caché
// ─────────────────────────────────────────────────────────────

/// Representación mínima de un recuerdo para uso offline.
class MemoryCache {
  const MemoryCache({
    required this.dateId,
    required this.text,
    this.imageUrl,
    required this.cachedAt,
  });

  final String   dateId;
  final String   text;
  final String?  imageUrl;
  final DateTime cachedAt;

  factory MemoryCache.fromMap(String dateId, Map<String, dynamic> m) =>
      MemoryCache(
        dateId  : dateId,
        text    : (m['text']     as String? ?? ''),
        imageUrl: (m['imageUrl'] as String?),
        cachedAt: DateTime.tryParse(m['cachedAt'] as String? ?? '') ??
            DateTime.now(),
      );

  Map<String, dynamic> toMap() => {
        'text'    : text,
        if (imageUrl != null) 'imageUrl': imageUrl,
        'cachedAt': cachedAt.toIso8601String(),
      };
}

// ─────────────────────────────────────────────────────────────
//  Servicio
// ─────────────────────────────────────────────────────────────

class MemoriesOfflineService {
  MemoriesOfflineService(this._db);
  final FirebaseFirestore _db;

  static const _prefix = 'memories_index_';

  // ── Ruta Firestore ────────────────────────────────────────
  CollectionReference<Map<String, dynamic>> _col(String uid) => _db
      .collection('memories')
      .doc(uid)
      .collection('user_memories');

  // ─────────────────────────────────────────────────────────
  //  API pública
  // ─────────────────────────────────────────────────────────

  /// Carga todos los recuerdos del usuario, priorizando Firestore.
  ///
  /// Si Firestore falla (sin internet), devuelve el caché local.
  /// Nunca lanza excepción al caller: devuelve mapa vacío en el peor caso.
  ///
  /// Retorna: `{ "2025-03-15": MemoryCache, ... }`
  Future<({Map<String, MemoryCache> data, bool fromCache})> loadAll(
    String uid,
  ) async {
    // 1) Intentar Firestore
    try {
      final snap = await _col(uid)
          .get(const GetOptions(source: Source.serverAndCache))
          .timeout(const Duration(seconds: 7));

      final freshMap = <String, MemoryCache>{};
      for (final doc in snap.docs) {
        freshMap[doc.id] = MemoryCache.fromMap(doc.id, {
          ...doc.data(),
          'cachedAt': DateTime.now().toIso8601String(),
        });
      }

      // Guardar en caché para uso posterior offline
      await _writeCache(uid, freshMap);
      return (data: freshMap, fromCache: false);
    } catch (_) {
      // 2) Sin internet → usar caché local
      final cached = await _readCache(uid);
      return (data: cached, fromCache: true);
    }
  }

  /// Carga un único recuerdo por fecha.
  ///
  /// Primero intenta Firestore; si falla, busca en caché.
  Future<({MemoryCache? memory, bool fromCache})> loadOne(
    String uid,
    String dateId,
  ) async {
    try {
      final doc = await _col(uid)
          .doc(dateId)
          .get(const GetOptions(source: Source.serverAndCache))
          .timeout(const Duration(seconds: 6));

      if (!doc.exists) return (memory: null, fromCache: false);

      final mc = MemoryCache.fromMap(dateId, {
        ...doc.data()!,
        'cachedAt': DateTime.now().toIso8601String(),
      });
      // Actualizar entrada en caché
      await _patchCache(uid, dateId, mc);
      return (memory: mc, fromCache: false);
    } catch (_) {
      final cached = await _readCache(uid);
      return (memory: cached[dateId], fromCache: true);
    }
  }

  /// Fuerza una actualización del caché (llamar después de guardar un recuerdo).
  Future<void> invalidate(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_prefix$uid');
  }

  // ─────────────────────────────────────────────────────────
  //  Helpers privados de caché
  // ─────────────────────────────────────────────────────────

  Future<Map<String, MemoryCache>> _readCache(String uid) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw   = prefs.getString('$_prefix$uid');
      if (raw == null) return {};

      final json = jsonDecode(raw) as Map<String, dynamic>;
      return json.map(
        (dateId, val) => MapEntry(
          dateId,
          MemoryCache.fromMap(dateId, val as Map<String, dynamic>),
        ),
      );
    } catch (_) {
      return {};
    }
  }

  Future<void> _writeCache(
    String uid,
    Map<String, MemoryCache> data,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json  = data.map((k, v) => MapEntry(k, v.toMap()));
      await prefs.setString('$_prefix$uid', jsonEncode(json));
    } catch (_) {
      // No bloquear la UI si el caché falla
    }
  }

  Future<void> _patchCache(
    String uid,
    String dateId,
    MemoryCache mc,
  ) async {
    final existing = await _readCache(uid);
    existing[dateId] = mc;
    await _writeCache(uid, existing);
  }
}
