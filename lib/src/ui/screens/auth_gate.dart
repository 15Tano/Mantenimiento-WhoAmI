import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Pantallas del flujo
import 'splash_welcome.dart';   // animación de carga
import 'home_router.dart';      // dirige a caregiver/consultant
import 'choice_start.dart';     // "Comencemos"

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snap) {
        // 1) Mientras Firebase determina el estado → Splash
        if (snap.connectionState == ConnectionState.waiting) {
          return const SplashWelcome();
        }

        // 2) Si hay usuario → Home por rol
        final user = snap.data;
        if (user != null) {
          return const HomeRouter();
        }

        // 3) Si NO hay sesión → "Comencemos"
        return const ChoiceStart();
      },
    );
  }
}
