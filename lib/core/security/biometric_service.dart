import 'package:local_auth/local_auth.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import '../errors/app_exception.dart';

/// Service for handling biometric authentication and device integrity checks.
class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  /// Checks if the device is rooted or jailbroken.
  Future<bool> isDeviceCompromised() async {
    try {
      return await FlutterJailbreakDetection.jailbroken;
    } catch (_) {
      return false; // Fallback to safe if check fails
    }
  }

  /// Checks if the device supports any biometric authentication.
  Future<bool> canAuthenticate() async {
    final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
    return canAuthenticate;
  }

  /// Returns the type of biometrics available on the device.
  Future<List<BiometricType>> getAvailableBiometrics() async {
    return await _auth.getAvailableBiometrics();
  }

  /// Triggers the biometric authentication flow.
  Future<bool> authenticate({
    required String reason,
    bool stickyAuth = true,
  }) async {
    try {
      return await _auth.authenticate(
        localizedReason: reason,
      );
    } catch (e) {
      throw SecurityException('Biometric authentication failed: ${e.toString()}');
    }
  }
}

class SecurityException extends AppException {
  SecurityException(String message) : super(message, 'SECURITY_ERROR');
}

