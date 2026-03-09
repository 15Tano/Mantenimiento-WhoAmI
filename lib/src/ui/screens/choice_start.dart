// lib/src/ui/screens/choice_start.dart
import 'package:flutter/material.dart';
import '../brand_logo.dart';
import '../theme.dart';
import 'login_page.dart';
import 'register_name_page.dart';

/// =============================================================
/// PANTALLA DE INICIO - "Comencemos"
/// =============================================================
class ChoiceStart extends StatelessWidget {
  const ChoiceStart({super.key});

  static const route = '/auth/choice';

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: const TextScaler.linear(1),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Comencemos',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: kInk,
            ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),

                    /// --- Logotipo ---
                    const BrandLogo(size: 160),

                    const SizedBox(height: 40),

                    /// --- Botón Iniciar sesión ---
                    SizedBox(
                      width: 296,
                      height: 56,
                      child: FilledButton.icon(
                        style: pillLav(),
                        icon: const Icon(Icons.login_rounded,
                            color: Colors.black),
                        label: const Text(
                          'Iniciar sesión',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: kInk,
                          ),
                        ),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          LoginPage.route,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// --- Botón Registrarse ---
                    SizedBox(
                      width: 296,
                      height: 56,
                      child: FilledButton.icon(
                        style: pillBlue(),
                        icon: const Icon(Icons.person_add_alt_1_rounded,
                            color: Colors.black),
                        label: const Text(
                          'Regístrate',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: kInk,
                          ),
                        ),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          RegisterNamePage.route,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
