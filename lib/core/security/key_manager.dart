import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

/// Manages cryptographic keys for the application using PBKDF2 and HKDF.
class KeyManager {
  static const _storage = FlutterSecureStorage();
  static const _masterKeyStorageKey = 'master_key';
  static const _installUuidStorageKey = 'install_uuid';
  static const _saltStorageKey = 'kdf_salt';

  /// Derives or retrieves the master key.
  /// 
  /// Uses device ID and a unique install UUID as source material.
  /// Derivation is performed via PBKDF2 with 200,000 iterations.
  static Future<Uint8List> getMasterKey() async {
    final existingKey = await _storage.read(key: _masterKeyStorageKey);
    if (existingKey != null) {
      return base64Decode(existingKey);
    }

    // 1. Get Device ID and Install UUID
    final deviceId = await _getDeviceId();
    var installUuid = await _storage.read(key: _installUuidStorageKey);
    if (installUuid == null) {
      installUuid = const Uuid().v4();
      await _storage.write(key: _installUuidStorageKey, value: installUuid);
    }

    // 2. Get or generate Salt
    var saltBase64 = await _storage.read(key: _saltStorageKey);
    late Uint8List salt;
    if (saltBase64 == null) {
      final random = Random.secure();
      salt = Uint8List.fromList(List.generate(32, (_) => random.nextInt(256)));
      await _storage.write(key: _saltStorageKey, value: base64Encode(salt));
    } else {
      salt = base64Decode(saltBase64);
    }

    // 3. Derive Key
    final input = '$deviceId:$installUuid';
    final masterKey = await derivePbkdf2(
      password: utf8.encode(input),
      salt: salt,
    );

    // 4. Store and return
    await _storage.write(key: _masterKeyStorageKey, value: base64Encode(masterKey));
    return masterKey;
  }

  /// Derives a cryptographically independent key for a specific data class.
  /// 
  /// Uses HKDF-expand to derive sub-keys from the master key.
  /// Valid [dataClass] values: 'bp_glucose', 'period', 'journal', 'appointments'.
  static Future<Uint8List> getKeyFor(String dataClass) async {
    final validClasses = {'bp_glucose', 'period', 'journal', 'appointments'};
    if (!validClasses.contains(dataClass)) {
      throw ArgumentError('Invalid data class for key derivation: $dataClass');
    }

    final masterKeyBytes = await getMasterKey();
    
    return await deriveHkdf(
      masterKeyBytes: masterKeyBytes,
      info: utf8.encode(dataClass),
    );
  }

  /// Pure function for PBKDF2 derivation.
  static Future<Uint8List> derivePbkdf2({
    required List<int> password,
    required List<int> salt,
    int iterations = 200000,
    int keyLength = 32,
  }) async {
    final algorithm = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: iterations,
      bits: keyLength * 8, // 32 bytes -> 256 bits
    );
    
    final secretKey = await algorithm.deriveKey(
      secretKey: SecretKey(password),
      nonce: salt,
    );
    
    final bytes = await secretKey.extractBytes();
    return Uint8List.fromList(bytes);
  }

  /// Pure function for HKDF derivation.
  static Future<Uint8List> deriveHkdf({
    required List<int> masterKeyBytes,
    required List<int> info,
    int outputLength = 32,
  }) async {
    final algorithm = Hkdf(
      hmac: Hmac.sha256(),
      outputLength: outputLength,
    );
    
    final secretKey = await algorithm.deriveKey(
      secretKey: SecretKey(masterKeyBytes),
      info: info,
    );
    
    final bytes = await secretKey.extractBytes();
    return Uint8List.fromList(bytes);
  }

  static Future<String> _getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? 'ios_unknown';
      }
    } catch (e) {
      // Fallback if platform-specific ID fails
    }
    return 'unknown_device';
  }
}
