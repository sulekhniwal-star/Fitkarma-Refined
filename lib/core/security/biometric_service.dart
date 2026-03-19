import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

/// Service for biometric authentication
class BiometricService {
  static const String _biometricEnabledKey = 'biometric_lock_enabled';

  final LocalAuthentication _localAuth = LocalAuthentication();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  /// Check if device supports biometric authentication
  Future<bool> isBiometricAvailable() async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      return canCheck && isDeviceSupported;
    } catch (e) {
      return false;
    }
  }

  /// Get available biometric types
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      return [];
    }
  }

  /// Check if biometric lock is enabled by user
  Future<bool> isBiometricLockEnabled() async {
    final value = await _secureStorage.read(key: _biometricEnabledKey);
    return value == 'true';
  }

  /// Enable or disable biometric lock
  Future<void> setBiometricLockEnabled(bool enabled) async {
    await _secureStorage.write(
      key: _biometricEnabledKey,
      value: enabled.toString(),
    );
  }

  /// Authenticate with biometrics
  Future<bool> authenticate({
    String reason = 'Authenticate to access Fitkarma',
  }) async {
    try {
      return await _localAuth.authenticate(localizedReason: reason);
    } catch (e) {
      return false;
    }
  }
}

/// Provider for BiometricService
final biometricServiceProvider = BiometricService();
