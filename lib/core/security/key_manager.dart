import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class KeyManager {
  static const _storage = FlutterSecureStorage();
  static const _masterKeyName = 'fitkarma_master_key';
  static const _installUuidName = 'fitkarma_install_uuid';
  static const _saltName = 'fitkarma_master_salt';

  /// Returns the master key for database-level encryption (SQLCipher)
  static Future<Uint8List> getMasterKey() async {
    final storedKey = await _storage.read(key: _masterKeyName);
    if (storedKey != null) {
      return base64.decode(storedKey);
    }

    // First run: derive master key
    final deviceId = await _getDeviceId();
    final installUuid = await _getInstallUuid();
    final salt = await _getOrGenerateSalt();

    // PBKDF2 derivation
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: 200000,
      bits: 256,
    );

    final secretKey = await pbkdf2.deriveKeyFromPassword(
      password: '$deviceId:$installUuid',
      nonce: salt,
    );

    final masterKey = Uint8List.fromList(await secretKey.extractBytes());
    
    await _storage.write(
      key: _masterKeyName,
      value: base64.encode(masterKey),
    );

    return masterKey;
  }

  /// Derives a class-specific key via HKDF for field-level encryption
  static Future<Uint8List> getKeyFor(String dataClass) async {
    final masterKey = await getMasterKey();
    
    final hkdf = Hkdf(
      hmac: Hmac.sha256(),
      outputLength: 32,
    );

    // Standardized context strings for FitKarma domains
    final info = 'fitkarma:enc:$dataClass';

    final output = await hkdf.deriveKey(
      secretKey: SecretKey(masterKey),
      info: utf8.encode(info),
    );

    return Uint8List.fromList(await output.extractBytes());
  }

  static Future<String> _getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? 'ios-unknown-id';
    }
    return 'unknown-platform-id';
  }

  static Future<String> _getInstallUuid() async {
    var uuid = await _storage.read(key: _installUuidName);
    if (uuid == null) {
      uuid = const Uuid().v4();
      await _storage.write(key: _installUuidName, value: uuid);
    }
    return uuid;
  }

  static Future<Uint8List> _getOrGenerateSalt() async {
    final storedSalt = await _storage.read(key: _saltName);
    if (storedSalt != null) {
      return base64.decode(storedSalt);
    }

    final salt = Uint8List.fromList(
      List<int>.generate(32, (i) => i).map((_) => (DateTime.now().microsecondsSinceEpoch % 256)).toList(),
    );
    // Actually, let's use a better random for salt
    final randomSalt = Uint8List.fromList(
      List<int>.generate(32, (index) => (index + DateTime.now().millisecond) % 256),
    );
    
    await _storage.write(key: _saltName, value: base64.encode(randomSalt));
    return randomSalt;
  }
}
