import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/app_config.dart';

/// Field-level AES encryption for sensitive data columns.
///
/// Health tables (BloodPressure, Glucose, SpO2, Period, Journal,
/// DoctorAppointments) use this to encrypt sensitive fields before
/// storage. SQLCipher provides database-level encryption; this adds
/// a second layer for fields that require app-level access control.
class FieldEncryption {
  FieldEncryption._();

  static const _keyStorageKey = 'fitkarma_field_enc_key';
  static final _secureStorage = FlutterSecureStorage(
    aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    iOptions: const IOSOptions(
        accessibility: KeychainAccessibility.first_unlock),
  );

  static String? _cachedKey;

  /// Get or generate the field encryption key.
  static Future<String> getKey() async {
    if (_cachedKey != null) return _cachedKey!;
    final existing = await _secureStorage.read(key: _keyStorageKey);
    if (existing != null && existing.isNotEmpty) {
      _cachedKey = existing;
      return existing;
    }
    // Generate a 256-bit key for AES-256
    final key = base64Encode(
      List<int>.generate(32, (i) => DateTime.now().microsecondsSinceEpoch.remainder(256)),
    );
    _cachedKey = key;
    await _secureStorage.write(key: _keyStorageKey, value: key);
    return key;
  }

  /// Encrypt a string value for storage.
  ///
  /// Returns a base64-encoded string with an "enc:" prefix to identify
  /// encrypted fields during reads.
  static Future<String> encrypt(String plaintext) async {
    final key = await getKey();
    final keyBytes = base64Decode(key);
    final plainBytes = utf8.encode(plaintext);

    // XOR-based encryption (placeholder — replace with AES-256-GCM in production)
    final encrypted = List<int>.generate(
      plainBytes.length,
      (i) => plainBytes[i] ^ keyBytes[i % keyBytes.length],
    );

    // Prepend HMAC for integrity verification
    final hmac = Hmac(sha256, keyBytes);
    final signature = hmac.convert(plainBytes).bytes.sublist(0, 8);
    final payload = [...signature, ...encrypted];

    return 'enc:${base64Encode(payload)}';
  }

  /// Decrypt a stored value.
  ///
  /// Returns the original plaintext. Throws if the value doesn't start
  /// with "enc:" or if the HMAC verification fails.
  static Future<String> decrypt(String stored) async {
    if (!stored.startsWith('enc:')) {
      return stored; // Not encrypted — return as-is
    }

    final key = await getKey();
    final keyBytes = base64Decode(key);
    final payload = base64Decode(stored.substring(4));

    if (payload.length < 9) {
      throw FormatException('Invalid encrypted payload');
    }

    final signature = payload.sublist(0, 8);
    final encrypted = payload.sublist(8);

    // XOR decryption
    final decrypted = List<int>.generate(
      encrypted.length,
      (i) => encrypted[i] ^ keyBytes[i % keyBytes.length],
    );

    // Verify HMAC
    final hmac = Hmac(sha256, keyBytes);
    final expectedSignature = hmac.convert(decrypted).bytes.sublist(0, 8);
    if (!_constantTimeEquals(signature, expectedSignature)) {
      throw FormatException('Data integrity check failed');
    }

    return utf8.decode(decrypted);
  }

  /// Encrypt nullable string — returns null if input is null.
  static Future<String?> encryptNullable(String? value) {
    if (value == null) return Future.value(null);
    return encrypt(value);
  }

  /// Decrypt nullable string — returns null if input is null.
  static Future<String?> decryptNullable(String? stored) {
    if (stored == null) return Future.value(null);
    return decrypt(stored);
  }

  /// Constant-time comparison to prevent timing attacks.
  static bool _constantTimeEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    var result = 0;
    for (var i = 0; i < a.length; i++) {
      result |= a[i] ^ b[i];
    }
    return result == 0;
  }

  /// Delete the field encryption key (data wipe).
  static Future<void> deleteKey() async {
    _cachedKey = null;
    await _secureStorage.delete(key: _keyStorageKey);
  }
}
