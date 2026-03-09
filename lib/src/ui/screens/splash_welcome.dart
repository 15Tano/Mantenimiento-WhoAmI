import 'package:flutter/material.dart';
import '../brand_logo.dart';
import '../theme.dart';
import 'choice_start.dart';

// 👇 Importa tu servicio de permisos
import 'package:whoami_app/services/permission_service.dart';

class SplashWelcome extends StatefulWidget {
  const SplashWelcome({super.key});
  static const route = '/';

  @override
  State<SplashWelcome> createState() => _SplashWelcomeState();
}

class _SplashWelcomeState extends State<SplashWelcome> {
  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    // Solo pedimos los permisos, nada más
    await PermissionService.requestCameraAndGallery();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BrandLogo(size: 190),
                    const SizedBox(height: 20),
                    const Text('BIENVENIDO A', style: welcomeKicker),
                    const SizedBox(height: 8),
                    const Text(
                      'who am i?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: kInk,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: 296,
                      height: 56,
                      child: FilledButton(
                        style: pillBlue(),
                        onPressed: () => Navigator.pushNamed(context, ChoiceStart.route),
                        child: const Text('Comenzar'),
                      ),
                    ),
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
