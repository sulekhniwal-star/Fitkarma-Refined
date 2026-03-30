import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

import 'key_manager.dart';

/// AES-256-GCM encryption/decryption service.
///
/// Each encrypt call produces:
///   base64(nonce ‖ ciphertext ‖ mac)
///
/// The nonce is 12 bytes (random per operation), ciphertext is
/// variable length, and the GCM tag (MAC) is 16 bytes.
///
/// Usage:
/// ```dart
/// final service = EncryptionService(key);
/// final encrypted = await service.encrypt('sensitive data');
/// final plain = await service.decrypt(encrypted);
/// ```
class EncryptionService {
  final SecretKey _key;
  final AesGcm _algorithm;

  EncryptionService(this._key)
      : _algorithm = AesGcm.with256bits();

  /// Create an [EncryptionService] for a specific data class.
  ///
  /// Derives the class-specific key via HKDF from the master key.
  static Future<EncryptionService> forClass({
    required String deviceId,
    required HkdfKey keyId,
  }) async {
    final key = await KeyManager.deriveClassKey(
      deviceId: deviceId,
      keyId: keyId,
    );
    return EncryptionService(key);
  }

  // ═══════════════════════════════════════════════════════════════
  // Encrypt
  // ═══════════════════════════════════════════════════════════════

  /// Encrypt a string value using AES-256-GCM.
  ///
  /// Returns `enc:gcm:<base64(nonce + ciphertext + mac)>`.
  Future<String> encrypt(String plaintext) async {
    final nonce = _algorithm.newNonce();
    final secretBox = await _algorithm.encrypt(
      utf8.encode(plaintext),
      secretKey: _key,
      nonce: nonce,
    );

    // Pack: nonce (12) + ciphertext (n) + mac (16)
    final packed = Uint8List(
      secretBox.nonce.length +
          secretBox.cipherText.length +
          secretBox.mac.bytes.length,
    );
    var offset = 0;
    packed.setRange(offset, offset + secretBox.nonce.length, secretBox.nonce);
    offset += secretBox.nonce.length;
    packed.setRange(
        offset, offset + secretBox.cipherText.length, secretBox.cipherText);
    offset += secretBox.cipherText.length;
    packed.setRange(offset, offset + secretBox.mac.bytes.length,
        secretBox.mac.bytes);

    return 'enc:gcm:${base64Encode(packed)}';
  }

  /// Encrypt a nullable string — returns null if input is null.
  Future<String?> encryptNullable(String? value) {
    if (value == null) return Future.value(null);
    return encrypt(value);
  }

  // ═══════════════════════════════════════════════════════════════
  // Decrypt
  // ═══════════════════════════════════════════════════════════════

  /// Decrypt an AES-256-GCM encrypted string.
  ///
  /// Throws [SecretBoxAuthenticationError] if the MAC verification fails
  /// (tampered data or wrong key).
  Future<String> decrypt(String stored) async {
    if (!stored.startsWith('enc:gcm:')) {
      return stored; // Not encrypted — return as-is (migration support)
    }

    final packed = base64Decode(stored.substring(8));

    if (packed.length < 12 + 1 + 16) {
      throw FormatException('Invalid encrypted payload: too short');
    }

    // Unpack: nonce (12) + ciphertext (n) + mac (16)
    final nonce = packed.sublist(0, 12);
    final macBytes = packed.sublist(packed.length - 16);
    final cipherText = packed.sublist(12, packed.length - 16);

    final secretBox = SecretBox(
      cipherText,
      nonce: nonce,
      mac: Mac(macBytes),
    );

    final clearBytes = await _algorithm.decrypt(
      secretBox,
      secretKey: _key,
    );

    return utf8.decode(clearBytes);
  }

  /// Decrypt a nullable string — returns null if input is null.
  Future<String?> decryptNullable(String? stored) {
    if (stored == null) return Future.value(null);
    return decrypt(stored);
  }

  // ═══════════════════════════════════════════════════════════════
  // Batch Operations
  // ═══════════════════════════════════════════════════════════════

  /// Encrypt multiple values in a single call.
  Future<List<String>> encryptBatch(List<String> values) async {
    return Future.wait(values.map(encrypt));
  }

  /// Decrypt multiple values in a single call.
  Future<List<String>> decryptBatch(List<String> values) async {
    return Future.wait(values.map(decrypt));
  }

  // ═══════════════════════════════════════════════════════════════
  // Streaming Encryption (for journal entries, etc.)
  // ═══════════════════════════════════════════════════════════════

  /// Encrypt a stream of bytes (for large journal entries or lab report PDFs).
  Stream<List<int>> encryptStream(Stream<List<int>> input) async* {
    final nonce = _algorithm.newNonce();
    yield nonce; // Prepend nonce for decryption

    await for (final chunk in input) {
      final box = await _algorithm.encrypt(
        chunk,
        secretKey: _key,
        nonce: nonce,
      );
      yield box.cipherText;
      yield box.mac.bytes;
    }
  }
}
