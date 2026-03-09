import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whoami_app/services/biometric_auth_service.dart';
import 'home_router.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  String? _error;

  @override
  void initState() {
    super.initState();
    _tryUnlock();
  }

  Future<void> _tryUnlock() async {
    final ok = await BiometricAuthService.instance.authenticate(
      reason: 'Usa tu huella, rostro o PIN',
    );
    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeRouter()),
      );
    } else {
      setState(() => _error = 'No se pudo verificar. Puedes usar tu contraseña.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.fingerprint, size: 72),
                const SizedBox(height: 16),
                Text('Hola, ${user?.email ?? "usuario"}',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                const Text('Desbloquea con biometría o PIN.'),
                if (_error != null) ...[
                  const SizedBox(height: 8),
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                ],
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _tryUnlock,
                  child: const Text('Intentar de nuevo'),
                ),
                TextButton(
                  onPressed: () {
                    // Volver al login con contraseña
                    Navigator.of(context).pop();
                  },
                  child: const Text('Usar contraseña'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
