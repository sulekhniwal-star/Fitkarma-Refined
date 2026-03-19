import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart' as crypto;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fitkarma/core/security/encryption_service.dart'
    show EncryptionDataClass;

/// Key manager for deriving and storing encryption keys.
///
/// Key derivation strategy:
/// 1. Master key derived from: device_id + app_install_uuid + stored_random_salt using PBKDF2 (200,000 iterations)
/// 2. Per-data-class keys derived from master key using HKDF
///
/// Storage:
/// - Random salt: stored in flutter_secure_storage (NOT in Drift or plaintext)
/// - Master key: stored in flutter_secure_storage (NOT recomputed on password change)
/// - app_install_uuid: stored in flutter_secure_storage
/// - device_id: stored in flutter_secure_storage
///
/// This ensures:
/// - Password changes do NOT invalidate existing encrypted data
/// - OAuth-only users (no password) have working encryption
class KeyManager {
  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  // Storage keys
  static const _saltKey = 'fitkarma_encryption_salt';
  static const _masterKeyKey = 'fitkarma_master_key';
  static const _appInstallUuidKey = 'fitkarma_app_install_uuid';
  static const _deviceIdKey = 'fitkarma_device_id';

  // PBKDF2 configuration
  static const int _pbkdf2Iterations = 200000;
  static const int _keyLengthBytes = 32; // 256 bits

  // HKDF info strings for per-data-class keys
  static const String _hkdfInfoBp = 'fitkarma_bp_glucose';
  static const String _hkdfInfoPeriod = 'fitkarma_period';
  static const String _hkdfInfoJournal = 'fitkarma_journal';
  static const String _hkdfInfoAppointments = 'fitkarma_appointments';
  static const String _hkdfInfoLabReports = 'fitkarma_lab_reports';

  /// Algorithm instances
  static final _pbkdf2 = crypto.Pbkdf2(
    macAlgorithm: crypto.Hmac.sha256(),
    iterations: _pbkdf2Iterations,
    bits: _keyLengthBytes * 8,
  );

  static final _hkdf = crypto.Hkdf(
    hmac: crypto.Hmac.sha256(),
    outputLength: _keyLengthBytes,
  );

  /// Generates a cryptographically secure random salt.
  static Uint8List _generateRandomSalt() {
    final random = Random.secure();
    final saltBytes = List<int>.generate(32, (i) => random.nextInt(256));
    return Uint8List.fromList(saltBytes);
  }

  /// Generates a cryptographically secure UUID.
  static String _generateUuid() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (i) => random.nextInt(256));
    // Set version (4) and variant bits
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;

    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
  }

  /// Gets or generates the app install UUID.
  /// This is unique per app installation and persists across updates.
  static Future<String> getAppInstallUuid() async {
    String? uuid = await _secureStorage.read(key: _appInstallUuidKey);

    if (uuid == null) {
      uuid = _generateUuid();
      await _secureStorage.write(key: _appInstallUuidKey, value: uuid);
    }

    return uuid;
  }

  /// Gets or generates the device ID.
  /// This identifies the physical device.
  static Future<String> getDeviceId() async {
    String? deviceId = await _secureStorage.read(key: _deviceIdKey);

    if (deviceId == null) {
      deviceId = _generateUuid();
      await _secureStorage.write(key: _deviceIdKey, value: deviceId);
    }

    return deviceId;
  }

  /// Gets or generates the random salt for key derivation.
  /// This salt is stored separately in flutter_secure_storage.
  static Future<Uint8List> getSalt() async {
    String? saltBase64 = await _secureStorage.read(key: _saltKey);

    if (saltBase64 == null) {
      final salt = _generateRandomSalt();
      saltBase64 = base64.encode(salt);
      await _secureStorage.write(key: _saltKey, value: saltBase64);
      return salt;
    }

    return base64.decode(saltBase64);
  }

  /// Derives the master key from device_id + app_install_uuid + salt using PBKDF2.
  ///
  /// This master key is stored in flutter_secure_storage after first derivation.
  /// It's NOT recomputed on password changes - this ensures existing encrypted data
  /// remains accessible.
  static Future<Uint8List> deriveMasterKey() async {
    // First check if we already have a stored master key
    String? storedMasterKey = await _secureStorage.read(key: _masterKeyKey);

    if (storedMasterKey != null) {
      return base64.decode(storedMasterKey);
    }

    // Derive new master key using PBKDF2
    final deviceId = await getDeviceId();
    final appInstallUuid = await getAppInstallUuid();
    final salt = await getSalt();

    // Combine device_id + app_install_uuid as the password
    final password = '$deviceId$appInstallUuid';

    final secretKey = await _pbkdf2.deriveKey(
      secretKey: crypto.SecretKey(utf8.encode(password)),
      nonce: salt,
    );

    final masterKey = await secretKey.extractBytes();

    // Store the derived master key (NOT the password/salt)
    final masterKeyBase64 = base64.encode(masterKey);
    await _secureStorage.write(key: _masterKeyKey, value: masterKeyBase64);

    return Uint8List.fromList(masterKey);
  }

  /// Gets the master key as a base64 string.
  /// This is a backward-compatible method used by EncryptionService.init().
  static Future<String> getMasterKey() async {
    final key = await deriveMasterKey();
    return base64.encode(key);
  }

  /// Derives a per-data-class encryption key using HKDF.
  ///
  /// HKDF (HMAC-based Key Derivation Function) derives multiple keys
  /// from a single master key using different "info" strings.
  /// This provides lateral movement protection - if one key leaks,
  /// the attacker cannot derive other data class keys without the master key.
  ///
  /// [dataClass] specifies the data class identifier (e.g., 'bp', 'period', 'journal')
  static Future<Uint8List> deriveDataClassKey(
    EncryptionDataClass dataClass,
  ) async {
    final masterKey = await deriveMasterKey();

    final info = _getHkdfInfo(dataClass);

    final derivedKey = await _hkdf.deriveKey(
      secretKey: crypto.SecretKey(masterKey),
      info: utf8.encode(info),
    );

    final keyBytes = await derivedKey.extractBytes();
    return Uint8List.fromList(keyBytes);
  }

  /// Gets the HKDF info string for a data class.
  static String _getHkdfInfo(EncryptionDataClass dataClass) {
    switch (dataClass) {
      case EncryptionDataClass.bp:
        return _hkdfInfoBp;
      case EncryptionDataClass.period:
        return _hkdfInfoPeriod;
      case EncryptionDataClass.journal:
        return _hkdfInfoJournal;
      case EncryptionDataClass.appointments:
        return _hkdfInfoAppointments;
      case EncryptionDataClass.labReports:
        return _hkdfInfoLabReports;
    }
  }

  /// Gets the base64-encoded per-data-class key.
  static Future<String> getDataClassKeyBase64(
    EncryptionDataClass dataClass,
  ) async {
    final key = await deriveDataClassKey(dataClass);
    return base64.encode(key);
  }

  /// Checks if encryption keys have been initialized.
  /// Returns true if the master key exists.
  static Future<bool> isInitialized() async {
    final storedMasterKey = await _secureStorage.read(key: _masterKeyKey);
    return storedMasterKey != null;
  }

  /// Clears all stored keys (use with caution - will make encrypted data unrecoverable).
  static Future<void> clearAllKeys() async {
    await _secureStorage.delete(key: _masterKeyKey);
    await _secureStorage.delete(key: _saltKey);
    await _secureStorage.delete(key: _appInstallUuidKey);
    await _secureStorage.delete(key: _deviceIdKey);
  }

  /// Re-derives the master key (force regeneration).
  /// This should only be called if there's a reason to believe the key was compromised.
  /// WARNING: This will make any previously encrypted data unreadable!
  static Future<Uint8List> regenerateMasterKey() async {
    await _secureStorage.delete(key: _masterKeyKey);
    return deriveMasterKey();
  }
}
