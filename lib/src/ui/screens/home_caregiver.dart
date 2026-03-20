// lib/src/ui/screens/home_caregiver.dart
//
// ╔══════════════════════════════════════════════════════════════╗
// ║  HOME CAREGIVER PAGE — Who Am I?  Sprint 2                 ║
// ║                                                            ║
// ║  Responsables:                                             ║
// ║    Owen  → StreamBuilder de emergencias, lógica resolver   ║
// ║    Alan  → Integración de EmergencyAlertBanner             ║
// ║                                                            ║
// ║  CAMBIOS vs Sprint 1:                                      ║
// ║  • Se instancia EmergencyAlertService.                     ║
// ║  • StreamBuilder escucha caregivers/{uid}/emergencies.     ║
// ║  • EmergencyAlertBanner se inyecta en el cuerpo principal. ║
// ║  • Badge de notificaciones incluye alertas activas en      ║
// ║    el conteo total (suma alertas + notificaciones locales). ║
// ╚══════════════════════════════════════════════════════════════╝

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../theme.dart';
import 'settings_page.dart';
import '../user_avatar.dart';
import 'quick_guides_page.dart';
import 'patients_list_page.dart';
import 'calendar_page.dart';
import 'notifications_page.dart';

import 'package:whoami_app/services/memories_scheduler.dart';
import 'package:whoami_app/services/notifications_service.dart';
import 'package:whoami_app/services/emergency_alert_service.dart';
import 'package:whoami_app/src/ui/widgets/emergency_alert_banner.dart';

// ─────────────────────────────────────────────────────────────
class HomeCaregiverPage extends StatefulWidget {
  const HomeCaregiverPage({super.key, this.displayName});
  static const route = '/home/caregiver';

  final String? displayName;

  @override
  State<HomeCaregiverPage> createState() => _HomeCaregiverPageState();
}

class _HomeCaregiverPageState extends State<HomeCaregiverPage> {
  int  _notifCount   = 0;
  bool _loadingNotif = true;

  // ── Instancias de servicios ───────────────────────────────
  late final EmergencyAlertService _alertService;

  @override
  void initState() {
    super.initState();
    _alertService = EmergencyAlertService(FirebaseFirestore.instance);
    _initializeHome();
  }

  Future<void> _initializeHome() async {
    try {
      await NotificationsService.ensureInitialized();
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) await MemoriesScheduler.scheduleAllForUser(uid);
      await _loadNotifCount();
    } catch (e) {
      debugPrint('⚠️ Error en inicialización del HomeCaregiver: $e');
    }
  }

  Future<void> _loadNotifCount() async {
    try {
      final pending =
          await NotificationsService.plugin.pendingNotificationRequests();
      if (!mounted) return;
      setState(() {
        _notifCount   = pending.length;
        _loadingNotif = false;
      });
    } catch (e) {
      debugPrint('⚠️ Error notificaciones: $e');
      if (mounted) setState(() => _loadingNotif = false);
    }
  }

  Future<void> _openNotifications() async {
    await Navigator.pushNamed(context, NotificationsPage.route);
    await _loadNotifCount();
  }

  // ── Resolver una alerta de emergencia ─────────────────────
  Future<void> _resolveAlert(EmergencyAlert alert) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    try {
      await _alertService.resolveAlert(
        caregiverId : uid,
        alertDocId  : alert.docId,
        patientUid  : alert.patientUid,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content         : const Text('No se pudo marcar como atendida.'),
          backgroundColor : Colors.grey[800],
          behavior        : SnackBarBehavior.floating,
        ),
      );
    }
  }

  // ─────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';

    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // ── Cuerpo scrollable ───────────────────────────
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 72, 20, 20),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        // ════════════════════════════════════
                        //  BANNER DE EMERGENCIAS EN TIEMPO REAL
                        //  Owen: StreamBuilder → EmergencyAlertService
                        //  Alan: EmergencyAlertBanner widget
                        // ════════════════════════════════════
                        StreamBuilder<List<EmergencyAlert>>(
                          stream: uid.isNotEmpty
                              ? _alertService.streamUnresolvedAlerts(uid)
                              : const Stream.empty(),
                          builder: (context, snap) {
                            final alerts = snap.data ?? [];
                            return EmergencyAlertBanner(
                              alerts   : alerts,
                              onResolve: _resolveAlert,
                            );
                          },
                        ),

                        // ── Avatar ──────────────────────────
                        const UserAvatar(radius: 60),
                        const SizedBox(height: 12),

                        // ── Nombre dinámico ─────────────────
                        StreamBuilder<User?>(
                          stream: FirebaseAuth.instance.userChanges(),
                          builder: (context, authSnap) {
                            final user = authSnap.data ??
                                FirebaseAuth.instance.currentUser;
                            if (user == null) return const SizedBox();

                            return StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user.uid)
                                  .snapshots(),
                              builder: (context, docSnap) {
                                String name = 'Cuidador';
                                if (docSnap.hasData &&
                                    docSnap.data!.data() != null) {
                                  final data = docSnap.data!.data()!;
                                  final first = (data['firstName']
                                          as String? ??
                                      '').trim();
                                  final last = (data['lastName']
                                          as String? ??
                                      '').trim();
                                  final fsName = [first, last]
                                      .where((e) => e.isNotEmpty)
                                      .join(' ');
                                  if (fsName.isNotEmpty) name = fsName;
                                }
                                if (name == 'Cuidador') {
                                  final dn =
                                      (user.displayName ?? '').trim();
                                  if (dn.isNotEmpty) name = dn;
                                }
                                if (name == 'Cuidador') {
                                  final mail = user.email ?? '';
                                  if (mail.contains('@')) {
                                    name = mail.split('@').first;
                                  }
                                }
                                name = name.isNotEmpty
                                    ? name
                                    : (widget.displayName ?? 'Cuidador');

                                return Text(
                                  'Bienvenido $name',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize  : 28,
                                    fontWeight: FontWeight.w700,
                                    color     : kInk,
                                  ),
                                );
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 8),
                        const Text(
                          'Selecciona una opción',
                          style: TextStyle(color: kGrey1),
                        ),
                        const SizedBox(height: 20),

                        // ── Opciones principales ────────────
                        _PillButton(
                          color : kPurple,
                          icon  : Icons.people_outline,
                          text  : 'Pacientes',
                          onTap : () => Navigator.pushNamed(
                              context, PatientsListPage.route),
                        ),
                        _PillButton(
                          color : kPurple,
                          icon  : Icons.menu_book_outlined,
                          text  : 'Guías Rápidas',
                          onTap : () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const QuickGuidesPage()),
                          ),
                        ),
                        _PillButton(
                          color : kPurple,
                          icon  : Icons.event_note_outlined,
                          text  : 'Calendario de Recuerdos',
                          onTap : () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const CalendarPage()),
                          ),
                        ),
                        _PillButton(
                          color : kPurple,
                          icon  : Icons.chat_bubble_outline,
                          text  : 'ChatWhoAmI',
                          onTap : () {}, // Implementación futura Sprint 3
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ── Botón de Ajustes (izquierda) ────────────────
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, top: 4),
                  child: IconButton(
                    icon   : const Icon(Icons.settings, color: kInk, size: 28),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsPage()),
                    ),
                    tooltip: 'Ajustes',
                  ),
                ),
              ),
            ),

            // ── Campanita con badge (derecha) ───────────────
            // ¡NUEVO! El badge ahora suma alertas activas
            // obtenidas del mismo StreamBuilder.
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, top: 4),
                  child: StreamBuilder<List<EmergencyAlert>>(
                    stream: uid.isNotEmpty
                        ? _alertService.streamUnresolvedAlerts(uid)
                        : const Stream.empty(),
                    builder: (context, snap) {
                      final alertCount = snap.data?.length ?? 0;
                      return _NotificationBell(
                        count  : _notifCount + alertCount,
                        loading: _loadingNotif,
                        onTap  : _openNotifications,
                        // Badge rojo si hay alertas activas
                        urgent : alertCount > 0,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  _NotificationBell — igual que antes + parámetro `urgent`
// ─────────────────────────────────────────────────────────────
class _NotificationBell extends StatelessWidget {
  const _NotificationBell({
    required this.count,
    required this.onTap,
    this.loading = false,
    this.urgent  = false,
  });

  final int          count;
  final bool         loading;
  final VoidCallback onTap;
  // urgent=true → badge rojo intenso en vez de rojo normal
  final bool         urgent;

  @override
  Widget build(BuildContext context) {
    final showBadge = count > 0;
    final display   = count > 99 ? '99+' : count.toString();
    final badgeColor = urgent ? const Color(0xFFE53935) : Colors.red;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: loading ? null : onTap,
          icon     : Icon(
            urgent
                ? Icons.notifications_active_rounded
                : Icons.notifications_none_rounded,
            color: urgent ? const Color(0xFFE53935) : kInk,
            size : 28,
          ),
          tooltip: 'Notificaciones',
        ),
        if (loading)
          const Positioned(
            right: 10, top: 10,
            child: SizedBox(
              width: 14, height: 14,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        if (!loading && showBadge)
          Positioned(
            right: 6, top: 6,
            child: Container(
              padding    : const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration : BoxDecoration(
                color       : badgeColor,
                borderRadius: BorderRadius.circular(12),
              ),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 18),
              alignment  : Alignment.center,
              child      : Text(
                display,
                style: const TextStyle(
                  color     : Colors.white,
                  fontSize  : 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  _PillButton — sin cambios respecto a Sprint 1
// ─────────────────────────────────────────────────────────────
class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.color,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final Color    color;
  final IconData icon;
  final String   text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width : double.infinity,
        height: 56,
        child : FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: color,
            foregroundColor: kInk,
            shape          : const StadiumBorder(),
            elevation      : 0,
          ),
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: kInk),
              const SizedBox(width: 12),
              Text(
                text,
                style: const TextStyle(
                  fontSize  : 16,
                  fontWeight: FontWeight.w700,
                  color     : kInk,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
