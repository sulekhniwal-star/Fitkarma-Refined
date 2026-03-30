import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Derives and manages encryption keys for the Fitkarma app.
///
/// Master key derivation:
///   PBKDF2-SHA256(deviceId + appInstallUuid, randomSalt, 200_000 iterations)
///
/// Per-class key derivation:
///   HKDF-SHA256(masterKey, info: "fitkarma_<class>")
///
/// Password changes do NOT invalidate existing data — the master key is
/// derived from device identity, not the user password.
/// OAuth-only users (no password) still get working encryption.
class KeyManager {
  KeyManager._();

  static const _saltKey = 'fitkarma_enc_salt';
  static const _installUuidKey = 'fitkarma_install_uuid';

  static final _secureStorage = FlutterSecureStorage(
    aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    iOptions: const IOSOptions(
        accessibility: KeychainAccessibility.first_unlock),
  );

  static final _pbkdf2 = Pbkdf2(
    macAlgorithm: Hmac.sha256(),
    iterations: 200000,
    bits: 256,
  );

  static final _hkdf = Hkdf(hmac: Hmac.sha256(), outputLength: 32);

  static SecretKey? _cachedMasterKey;

  // ═══════════════════════════════════════════════════════════════
  // Master Key
  // ═══════════════════════════════════════════════════════════════

  /// Derive or retrieve the master device key.
  ///
  /// [deviceId] — platform device identifier (never changes)
  /// [appInstallUuid] — random UUID generated on first install
  static Future<SecretKey> getMasterKey({
    required String deviceId,
  }) async {
    if (_cachedMasterKey != null) return _cachedMasterKey!;

    final salt = await _getOrCreateSalt();
    final installUuid = await _getOrCreateInstallUuid();
    final password = utf8.encode('$deviceId:$installUuid');

    final key = await _pbkdf2.deriveKey(
      secretKey: SecretKey(password),
      nonce: salt,
    );

    _cachedMasterKey = key;
    return key;
  }

  // ═══════════════════════════════════════════════════════════════
  // Per-Class Keys (HKDF)
  // ═══════════════════════════════════════════════════════════════

  /// Derive a unique encryption key for each health data class.
  ///
  /// This prevents lateral exposure — if one key is compromised,
  /// other data classes remain protected.
  static Future<SecretKey> deriveClassKey({
    required String deviceId,
    required HkdfKey keyId,
  }) async {
    final master = await getMasterKey(deviceId: deviceId);
    final masterBytes = await master.extractBytes();

    final derived = await _hkdf.deriveKey(
      secretKey: SecretKey(masterBytes),
      nonce: utf8.encode(keyId.info),
      info: utf8.encode(keyId.info),
    );

    return derived;
  }

  /// Derive all class keys at once (for batch operations).
  static Future<Map<HkdfKey, SecretKey>> deriveAllClassKeys({
    required String deviceId,
  }) async {
    final result = <HkdfKey, SecretKey>{};
    for (final keyId in HkdfKey.values) {
      result[keyId] = await deriveClassKey(deviceId: deviceId, keyId: keyId);
    }
    return result;
  }

  // ═══════════════════════════════════════════════════════════════
  // Salt Management
  // ═══════════════════════════════════════════════════════════════

  static Future<Uint8List> _getOrCreateSalt() async {
    final existing = await _secureStorage.read(key: _saltKey);
    if (existing != null && existing.isNotEmpty) {
      return Uint8List.fromList(base64Decode(existing));
    }

    final salt = Uint8List(32);
    final random = Random.secure();
    for (var i = 0; i < 32; i++) {
      salt[i] = random.nextInt(256);
    }

    await _secureStorage.write(key: _saltKey, value: base64Encode(salt));
    return salt;
  }

  /// Get the current salt (for backup/export verification).
  static Future<String?> getSaltBase64() async {
    return _secureStorage.read(key: _saltKey);
  }

  // ═══════════════════════════════════════════════════════════════
  // Install UUID
  // ═══════════════════════════════════════════════════════════════

  static Future<String> _getOrCreateInstallUuid() async {
    final existing = await _secureStorage.read(key: _installUuidKey);
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }

    final uuid = _generateUuid();
    await _secureStorage.write(key: _installUuidKey, value: uuid);
    return uuid;
  }

  static String _generateUuid() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    // UUID v4 format
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-'
        '${hex.substring(8, 12)}-'
        '${hex.substring(12, 16)}-'
        '${hex.substring(16, 20)}-'
        '${hex.substring(20, 32)}';
  }

  // ═══════════════════════════════════════════════════════════════
  // Wipe
  // ═══════════════════════════════════════════════════════════════

  /// Delete all encryption keys and salt (data wipe).
  static Future<void> wipe() async {
    _cachedMasterKey = null;
    await _secureStorage.delete(key: _saltKey);
    await _secureStorage.delete(key: _installUuidKey);
  }
}

/// Identifies a per-class encryption key derived via HKDF.
///
/// Each health data category gets its own key to prevent lateral
/// exposure if one key is compromised.
enum HkdfKey {
  bpGlucose('fitkarma_bp_glucose'),
  period('fitkarma_period'),
  journal('fitkarma_journal'),
  appointments('fitkarma_appointments'),
  labReports('fitkarma_lab_reports');

  const HkdfKey(this.info);
  final String info;
}
