// lib/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Temas y estilos globales
import 'ui/theme.dart';

// Pantalla raíz
import 'ui/screens/auth_gate.dart';

// Flujo inicial
import 'ui/screens/choice_start.dart';
import 'ui/screens/login_page.dart';

// Registro
import 'ui/screens/register_name_page.dart';
import 'ui/screens/register_password_page.dart';
import 'ui/screens/register_role_page.dart';

// Pantallas principales (Homes por rol)
import 'ui/screens/home_caregiver.dart';
import 'ui/screens/home_consultant.dart';

// Ajustes
import 'ui/screens/settings_page.dart';
import 'ui/screens/edit_profile_page.dart';

// Pacientes
import 'ui/screens/patients_list_page.dart';
import 'ui/screens/register_patient_page.dart';

// Juegos
import 'ui/screens/game_page.dart';       // Solo menú de juegos (GamesPage)
import 'ui/screens/memorama_page.dart';   // Juego del memorama (MemoramaPage)

// Notificaciones
import 'ui/screens/notifications_page.dart'; // Nueva pantalla de notificaciones

/// Aplicación principal de Who Am I?
///
/// Define el árbol de navegación, tema visual y localización de la app.
/// Desde aquí se gestiona el flujo de pantallas y rutas globales.
class WhoAmIApp extends StatelessWidget {
  const WhoAmIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Who Am I?',
      theme: appTheme,

      // Configuración de idioma y localización
      supportedLocales: const [
        Locale('es'),
        Locale('es', 'MX'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('es', 'MX'),

      // Rutas de navegación principales
      initialRoute: '/',
      routes: {
        // --- Raíz y flujo inicial ---
        '/': (_) => const AuthGate(),
        '/auth/choice': (_) => const ChoiceStart(),
        '/login': (_) => const LoginPage(),

        // --- Registro de usuarios ---
        '/register/name': (_) => const RegisterNamePage(),
        '/register/password': (_) => const RegisterPasswordPage(),
        '/register/role': (_) => const RegisterRolePage(),

        // --- Pantallas principales por rol ---
        '/home/caregiver': (ctx) {
          final args = ModalRoute.of(ctx)?.settings.arguments as Map?;
          return HomeCaregiverPage(displayName: args?['name'] as String?);
        },
        '/home/consultant': (ctx) {
          final args = ModalRoute.of(ctx)?.settings.arguments as Map?;
          return HomeConsultantPage(displayName: args?['name'] as String?);
        },

        // --- Ajustes y perfil ---
        '/settings': (_) => const SettingsPage(),
        '/settings/edit-profile': (_) => const EditProfilePage(),

        // --- Gestión de pacientes ---
        PatientsListPage.route: (_) => const PatientsListPage(),
        RegisterPatientPage.route: (_) => const RegisterPatientPage(),

        // --- Juegos ---
        GamesPage.route: (_) => const GamesPage(),
        MemoramaPage.route: (_) => const MemoramaPage(),

        // --- Notificaciones ---
        NotificationsPage.route: (_) => const NotificationsPage(),
      },
    );
  }
}
