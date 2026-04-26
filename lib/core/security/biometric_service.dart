import 'package:local_auth/local_auth.dart';

class BiometricService {
  static final _auth = LocalAuthentication();

  static Future<bool> authenticate() async {
    final canAuth = await _auth.canCheckBiometrics;
    final isSupported = await _auth.isDeviceSupported();
    
    if (!canAuth || !isSupported) {
      return true;
    }

    try {
      return await _auth.authenticate(
        localizedReason: 'Authenticate to view sensitive health data',
        biometricOnly: false,
        persistAcrossBackgrounding: true,
        authMessages: const [], 
      );
    } catch (e) {
      // Fallback for different versions of local_auth if needed
      return false;
    }
  }
}
