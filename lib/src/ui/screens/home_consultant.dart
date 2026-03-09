import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Estilos y componentes
import '../theme.dart';
import 'settings_page.dart';
import '../user_avatar.dart';

// Vistas
import 'tips_page.dart';
import 'calendar_page.dart';
import 'game_page.dart' as games; // evitar choques de nombres
import 'motivational_phrases_page.dart';
import 'notifications_page.dart';

// Servicios
import 'package:whoami_app/services/memories_scheduler.dart';
import 'package:whoami_app/services/notifications_service.dart';

/// =============================================================
/// HomeConsultantPage
/// Pantalla principal del rol "Consultante".
/// =============================================================
class HomeConsultantPage extends StatefulWidget {
  const HomeConsultantPage({super.key, this.displayName});
  static const route = '/home/consultant';

  final String? displayName;

  @override
  State<HomeConsultantPage> createState() => _HomeConsultantPageState();
}

class _HomeConsultantPageState extends State<HomeConsultantPage> {
  int _notifCount = 0;
  bool _loadingNotif = true;

  @override
  void initState() {
    super.initState();
    _initializeHome();
  }

  Future<void> _initializeHome() async {
    await NotificationsService.ensureInitialized();

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      // Programa recordatorios y luego actualiza el badge.
      await MemoriesScheduler.scheduleAllForUser(uid);
    }

    await _loadNotifCount();
  }

  Future<void> _loadNotifCount() async {
    try {
      final count = await NotificationsService.getPendingCount();
      if (!mounted) return;
      setState(() {
        _notifCount = count;
        _loadingNotif = false;
      });
    } catch (e) {
      debugPrint('Error al cargar notificaciones pendientes: $e');
      if (!mounted) return;
      setState(() => _loadingNotif = false);
    }
  }

  Future<void> _openNotifications() async {
    await Navigator.pushNamed(context, NotificationsPage.route);
    await _loadNotifCount();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Barra superior con Ajustes y Notificaciones
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                                );
                              },
                              icon: const Icon(Icons.settings, color: kInk, size: 28),
                              tooltip: 'Ajustes',
                            ),
                            _NotificationBell(
                              count: _notifCount,
                              loading: _loadingNotif,
                              onTap: _openNotifications,
                            ),
                          ],
                        ),
                      ),

                      // Avatar del usuario
                      const UserAvatar(radius: 60),
                      const SizedBox(height: 12),

                      // Nombre dinámico desde Auth/Firestore
                      StreamBuilder<User?>(
                        stream: FirebaseAuth.instance.userChanges(),
                        builder: (context, authSnap) {
                          final user = authSnap.data ?? FirebaseAuth.instance.currentUser;
                          if (user == null) return const SizedBox();
                          final uid = user.uid;

                          return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
                            builder: (context, docSnap) {
                              String name = 'Usuario';

                              if (docSnap.hasData && docSnap.data!.data() != null) {
                                final data = docSnap.data!.data()!;
                                final first = (data['firstName'] as String?)?.trim() ?? '';
                                final last = (data['lastName'] as String?)?.trim() ?? '';
                                final fsName = [first, last].where((e) => e.isNotEmpty).join(' ');
                                if (fsName.isNotEmpty) name = fsName;
                              }

                              if (name == 'Usuario') {
                                final dn = (user.displayName ?? '').trim();
                                if (dn.isNotEmpty) name = dn;
                              }

                              if (name == 'Usuario') {
                                final mail = user.email ?? '';
                                if (mail.contains('@')) name = mail.split('@').first;
                              }

                              name = name.isNotEmpty ? name : (widget.displayName ?? 'Usuario');

                              return Text(
                                'Bienvenido $name',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: kInk,
                                ),
                              );
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 8),
                      const Text('Selecciona una opción', style: TextStyle(color: kGrey1)),
                      const SizedBox(height: 20),

                      // Botones principales
                      _PillButton(
                        color: kBlue,
                        icon: Icons.menu_book_outlined,
                        text: 'Consejos',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const TipsPage()));
                        },
                      ),
                      _PillButton(
                        color: kBlue,
                        icon: Icons.auto_stories_outlined,
                        text: 'Frases motivadoras',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const MotivationalPhrasesPage()));
                        },
                      ),
                      _PillButton(
                        color: kBlue,
                        icon: Icons.event_note_outlined,
                        text: 'Calendario de recuerdos',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const CalendarPage()));
                        },
                      ),
                      _PillButton(
                        color: kBlue,
                        icon: Icons.chat_bubble_outline,
                        text: 'ChatWhoAmI',
                        onTap: () {
                          // Implementar chat IA en el futuro
                        },
                      ),
                      _PillButton(
                        color: kBlue,
                        icon: Icons.videogame_asset_outlined,
                        text: 'Juegos',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const games.GamesPage()));
                        },
                      ),

                      const SizedBox(height: 8),
                      _PillButton(
                        color: const Color(0xFFFF9AA0),
                        icon: Icons.warning_amber_rounded,
                        text: 'Emergencia',
                        onTap: () => _showComingSoonDialog(context),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// =============================================================
/// Campanita de notificaciones con badge o cargando
/// =============================================================
class _NotificationBell extends StatelessWidget {
  const _NotificationBell({
    required this.count,
    required this.onTap,
    this.loading = false,
  });

  final int count;
  final bool loading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final showBadge = count > 0;
    final display = count > 99 ? '99+' : count.toString();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: loading ? null : onTap,
          icon: const Icon(Icons.notifications_none_rounded, color: kInk, size: 28),
          tooltip: 'Notificaciones',
        ),
        if (loading)
          const Positioned(
            right: 10,
            top: 10,
            child: SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2)),
          ),
        if (!loading && showBadge)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 18),
              alignment: Alignment.center,
              child: Text(
                display,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// =============================================================
/// Botón con forma de pastilla reutilizable
/// =============================================================
class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.color,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final Color color;
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: color,
            foregroundColor: kInk,
            shape: const StadiumBorder(),
            elevation: 0,
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
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: kInk,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// =============================================================
/// Diálogo simple para la opción "Emergencia"
/// =============================================================
void _showComingSoonDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Emergencia'),
      content: const Text(
        'Muy pronto este botón avisará al cuidador con una notificación.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('Entendido'),
        ),
      ],
    ),
  );
}
