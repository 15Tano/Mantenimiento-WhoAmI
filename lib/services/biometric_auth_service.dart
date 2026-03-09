import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BiometricAuthService {
  BiometricAuthService._();
  static final instance = BiometricAuthService._();

  final _auth = LocalAuthentication();
  final _storage = const FlutterSecureStorage();

  // Claves que ya usabas
  static const _kBiometricEnabledKey = 'biometric_enabled'; // “inicio rápido”
  static const _kLockEnabledKey = 'app_lock_enabled';       // “bloquear al abrir app”

  // ===== Disponibilidad =====
  Future<bool> isDeviceSupported() => _auth.isDeviceSupported();

  Future<bool> canCheckBiometrics() async {
    try {
      return (await _auth.canCheckBiometrics) || (await isDeviceSupported());
    } catch (_) {
      return false;
    }
  }

  Future<bool> hasBiometricsEnrolled() async {
    try {
      final types = await _auth.getAvailableBiometrics();
      return types.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  // ===== Autenticación =====
  /// Si [biometricOnly] = true => exige huella/rostro.
  /// Si false => permite PIN/Patrón/Password del dispositivo.
  Future<bool> authenticate({
    String reason = 'Confirma tu identidad',
    bool biometricOnly = false,
  }) async {
    try {
      final ok = await _auth.authenticate(
        localizedReason: reason,
        options: AuthenticationOptions(
          biometricOnly: biometricOnly,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
      return ok;
    } catch (_) {
      return false;
    }
  }

  Future<void> stop() async {
    try {
      await _auth.stopAuthentication();
    } catch (_) {}
  }

  // ===== Preferencias seguras =====
  Future<void> setBiometricEnabled(bool value) async =>
      _storage.write(key: _kBiometricEnabledKey, value: value.toString());

  Future<bool> getBiometricEnabled() async =>
      (await _storage.read(key: _kBiometricEnabledKey)) == 'true';

  Future<void> setAppLockEnabled(bool value) async =>
      _storage.write(key: _kLockEnabledKey, value: value.toString());

  Future<bool> getAppLockEnabled() async =>
      (await _storage.read(key: _kLockEnabledKey)) == 'true';

  /// Azúcar: ¿debería bloquear al abrir?
  Future<bool> shouldLockOnLaunch() async {
    final lockOn = await getAppLockEnabled();
    final canBio = await canCheckBiometrics();
    return lockOn && canBio;
  }
}
