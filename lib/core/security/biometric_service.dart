import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

const _biometricEnabledKey = 'biometric_enabled';
const _firstLaunchKey = 'first_launch_complete';

final _secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
  iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device),
);

class BiometricService {
  static final BiometricService instance = BiometricService._();
  BiometricService._();

  final LocalAuthentication _auth = LocalAuthentication();
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      final canCheck = await _auth.canCheckBiometrics;
      final isDeviceSupported = await _auth.isDeviceSupported();
      _isInitialized = canCheck && isDeviceSupported;
    } catch (_) {
      _isInitialized = false;
    }
  }

  bool get isAvailable => _isInitialized;

  Future<bool> isBiometricEnabled() async {
    try {
      final value = await _secureStorage.read(key: _biometricEnabledKey);
      return value == 'true';
    } catch (_) {
      return false;
    }
  }

  Future<void> setBiometricEnabled(bool enabled) async {
    await _secureStorage.write(key: _biometricEnabledKey, value: enabled.toString());
  }

  Future<bool> isFirstLaunch() async {
    try {
      final value = await _secureStorage.read(key: _firstLaunchKey);
      return value == null || value.isEmpty;
    } catch (_) {
      return true;
    }
  }

  Future<void> markFirstLaunchComplete() async {
    await _secureStorage.write(key: _firstLaunchKey, value: 'complete');
  }

  Future<bool> authenticate({String reason = 'Authenticate to continue'}) async {
    if (!_isInitialized) return false;

    try {
      return await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (_) {
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    if (!_isInitialized) return [];
    try {
      return await _auth.getAvailableBiometrics();
    } catch (_) {
      return <BiometricType>[];
    }
  }
}