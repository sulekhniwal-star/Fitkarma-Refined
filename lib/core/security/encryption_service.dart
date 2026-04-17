import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import '../errors/app_exception.dart';
import 'key_manager.dart';

/// Service for handling AES-256-GCM encryption and decryption.
class EncryptionService {
  static final _algorithm = AesGcm.with256bits();

  /// Encrypts a string using AES-256-GCM.
  /// 
  /// Returns a base64 string containing: [nonce (12b)] + [ciphertext] + [mac (16b)].
  static Future<String> encrypt(String plaintext, Uint8List key) async {
    try {
      final secretKey = SecretKey(key);
      final secretBox = await _algorithm.encrypt(
        utf8.encode(plaintext),
        secretKey: secretKey,
      );

      final combined = Uint8List.fromList([
        ...secretBox.nonce,
        ...secretBox.cipherText,
        ...secretBox.mac.bytes,
      ]);

      return base64Encode(combined);
    } catch (e) {
      throw EncryptionException('Encryption failed: ${e.toString()}');
    }
  }

  /// Decrypts a base64 string produced by [encrypt].
  /// 
  /// Throws [EncryptionException] on failure.
  static Future<String> decrypt(String encrypted, Uint8List key) async {
    try {
      final bytes = base64Decode(encrypted);
      
      // AES-256-GCM standard: nonce is 12 bytes, MAC is 16 bytes
      if (bytes.length < 12 + 16) {
        throw EncryptionException('Invalid encrypted data length');
      }

      final nonce = bytes.sublist(0, 12);
      final mac = bytes.sublist(bytes.length - 16);
      final ciphertext = bytes.sublist(12, bytes.length - 16);

      final secretKey = SecretKey(key);
      final secretBox = SecretBox(
        ciphertext,
        nonce: nonce,
        mac: Mac(mac),
      );

      final decryptedBytes = await _algorithm.decrypt(
        secretBox,
        secretKey: secretKey,
      );

      return utf8.decode(decryptedBytes);
    } catch (e) {
      // Never log the key or plaintext here.
      throw EncryptionException();
    }
  }

  /// Encrypts a specific field using a key derived from its data class.
  static Future<String> encryptField(String value, String dataClass) async {
    final key = await KeyManager.getKeyFor(dataClass);
    return await encrypt(value, key);
  }

  /// Decrypts a specific field using a key derived from its data class.
  static Future<String> decryptField(String value, String dataClass) async {
    final key = await KeyManager.getKeyFor(dataClass);
    return await decrypt(value, key);
  }
}

