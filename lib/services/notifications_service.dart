import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:firebase_auth/firebase_auth.dart';


/// =============================================================
/// SERVICIO CENTRALIZADO DE NOTIFICACIONES
/// =============================================================
/// Compatible con Android 13–15 y iOS.
/// Maneja la inicialización, programación, cancelación
/// y consulta de notificaciones locales.
/// =============================================================

enum MemoryCadence {
  hourly1,
  hourly2,
  hourly6,
  daily1,
  daily2,
  weekly,
  biweekly,
  monthly,
  quarterly,
  semiannual,
  annual,
}

/// =============================================================
/// Conversión de texto a tipo de cadencia
/// =============================================================
MemoryCadence cadenceFromString(String v) {
  switch (v) {
    case 'hourly1':
      return MemoryCadence.hourly1;
    case 'hourly2':
      return MemoryCadence.hourly2;
    case 'hourly6':
      return MemoryCadence.hourly6;
    case 'daily1':
      return MemoryCadence.daily1;
    case 'daily2':
      return MemoryCadence.daily2;
    case 'weekly':
      return MemoryCadence.weekly;
    case 'biweekly':
      return MemoryCadence.biweekly;
    case 'monthly':
      return MemoryCadence.monthly;
    case 'quarterly':
      return MemoryCadence.quarterly;
    case 'semiannual':
      return MemoryCadence.semiannual;
    case 'annual':
      return MemoryCadence.annual;
    default:
      return MemoryCadence.monthly;
  }
}

/// =============================================================
/// CLASE PRINCIPAL DE SERVICIO DE NOTIFICACIONES
/// =============================================================
class NotificationsService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// Getter público para acceder al plugin desde otras clases
  static FlutterLocalNotificationsPlugin get plugin => _plugin;

  static bool _initialized = false;

  static const _androidChannelId = 'memories_reminders';
  static const _androidChannelName = 'Recordatorios de recuerdos';
  static const _androidChannelDesc =
      'Notificaciones periódicas de recuerdos programados por el usuario.';

  /// =============================================================
  /// Inicialización segura sin requestPermission()
  /// =============================================================
  static Future<void> init() async {
    if (_initialized) return;

    try {
      tz.initializeTimeZones();

      const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosInit = DarwinInitializationSettings();
      const initSettings =
          InitializationSettings(android: androidInit, iOS: iosInit);

      await _plugin.initialize(initSettings);

      final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      // Crear canal de notificaciones persistente
      const androidChannel = AndroidNotificationChannel(
        _androidChannelId,
        _androidChannelName,
        description: _androidChannelDesc,
        importance: Importance.max,
      );
      await androidPlugin?.createNotificationChannel(androidChannel);

      // iOS: solicitar permisos visuales
      await _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);

      _initialized = true;
      debugPrint('✅ Notificaciones inicializadas correctamente');
    } catch (e) {
      debugPrint('⚠️ Error al inicializar notificaciones: $e');
    }
  }

  /// Garantiza que esté inicializado antes de usarse
  static Future<void> ensureInitialized() async {
    if (!_initialized) await init();
  }

  /// =============================================================
  /// Programar notificaciones con cadencia personalizada
  /// =============================================================
  static Future<void> scheduleForMemory({
    required String memoryId,
    required String title,
    required DateTime anchorDate,
    required MemoryCadence cadence,
    int occurrences = 12,
  }) async {
    await ensureInitialized();

    // Cancelar anteriores
    await cancelAllForMemory(memoryId);

    // Asegurar que la fecha esté en el futuro
    var adjustedDate = anchorDate;
    if (adjustedDate.isBefore(DateTime.now())) {
      adjustedDate = DateTime.now().add(const Duration(minutes: 1));
    }

    final baseId = _baseId(memoryId);
    final list = _generateOccurrences(adjustedDate, cadence, occurrences);

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        _androidChannelId,
        _androidChannelName,
        channelDescription: _androidChannelDesc,
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    for (var i = 0; i < list.length; i++) {
      try {
        await _plugin.zonedSchedule(
          baseId + i,
          'Recordatorio de recuerdo',
          title,
          tz.TZDateTime.from(list[i], tz.local),
          details,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          androidAllowWhileIdle: true,
          payload: memoryId,
        );
      } catch (e) {
        debugPrint('Error al programar notificación $i: $e');
      }
    }

    debugPrint('✅ Programadas ${list.length} notificaciones para $memoryId');
  }

  /// =============================================================
  /// Cancelar todas las notificaciones de un recuerdo
  /// =============================================================
  static Future<void> cancelAllForMemory(String memoryId) async {
    await ensureInitialized();
    final base = _baseId(memoryId);
    for (var i = 0; i < 50; i++) {
      await _plugin.cancel(base + i);
    }
  }

  /// =============================================================
  /// Cancelar una notificación individual
  /// =============================================================
  static Future<void> cancel(int id) async {
    await ensureInitialized();
    await _plugin.cancel(id);
  }

  /// =============================================================
  /// Cancelar todas las notificaciones
  /// =============================================================
  static Future<void> cancelAll() async {
    await ensureInitialized();
    await _plugin.cancelAll();
  }

  /// =============================================================
  /// Obtener lista de notificaciones pendientes
  /// =============================================================
  static Future<List<PendingNotificationRequest>>
      pendingNotificationRequests() async {
    await ensureInitialized();
    try {
      return await _plugin.pendingNotificationRequests();
    } catch (e) {
      debugPrint('⚠️ Error al obtener notificaciones pendientes: $e');
      return [];
    }
  }

  /// =============================================================
  /// Obtener cantidad de notificaciones pendientes
  /// =============================================================
  static Future<int> getPendingCount() async {
    await ensureInitialized();
    try {
      final pending = await _plugin.pendingNotificationRequests();
      return pending.length;
    } catch (e) {
      debugPrint('⚠️ No se pudieron obtener notificaciones pendientes: $e');
      return 0;
    }
  }

  // =============================================================
  // Internos
  // =============================================================
  static int _baseId(String id) {
  final uid = FirebaseAuth.instance.currentUser?.uid ?? 'guest';
  final combined = '$uid-$id';
  return (combined.hashCode & 0x7fffffff) % 900000 + 100000;
}

  static List<DateTime> _generateOccurrences(
      DateTime start, MemoryCadence c, int count) {
    final result = <DateTime>[];
    var current = start;
    for (int i = 0; i < count; i++) {
      current = _addCadence(current, c);
      result.add(current);
    }
    return result;
  }

  static DateTime _addCadence(DateTime d, MemoryCadence c) {
    switch (c) {
      case MemoryCadence.hourly1:
        return d.add(const Duration(hours: 1));
      case MemoryCadence.hourly2:
        return d.add(const Duration(hours: 2));
      case MemoryCadence.hourly6:
        return d.add(const Duration(hours: 6));
      case MemoryCadence.daily1:
        return d.add(const Duration(days: 1));
      case MemoryCadence.daily2:
        return d.add(const Duration(days: 2));
      case MemoryCadence.weekly:
        return d.add(const Duration(days: 7));
      case MemoryCadence.biweekly:
        return d.add(const Duration(days: 14));
      case MemoryCadence.monthly:
        return _addMonths(d, 1);
      case MemoryCadence.quarterly:
        return _addMonths(d, 3);
      case MemoryCadence.semiannual:
        return _addMonths(d, 6);
      case MemoryCadence.annual:
        return _addMonths(d, 12);
    }
  }

  static DateTime _addMonths(DateTime d, int m) {
    final newMonth = d.month + m;
    final year = d.year + ((newMonth - 1) ~/ 12);
    final month = ((newMonth - 1) % 12) + 1;
    final day = min(d.day, _daysInMonth(year, month));
    return DateTime(year, month, day, d.hour, d.minute);
  }

  static int _daysInMonth(int year, int month) {
    final first = DateTime(year, month, 1);
    final next =
        (month == 12) ? DateTime(year + 1, 1, 1) : DateTime(year, month + 1, 1);
    return next.difference(first).inDays;
  }
}
