import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'key_manager.dart';

part 'encryption_service.g.dart';

class EncryptionService {
  final String dataClass;
  final AesGcm algorithm = AesGcm.with256bits();

  EncryptionService(this.dataClass);

  /// Encrypts a string using AES-256-GCM with a key derived from the data class.
  Future<String> encrypt(String plaintext) async {
    if (plaintext.isEmpty) return plaintext;
    
    final key = await KeyManager.getKeyFor(dataClass);
    final secretKey = SecretKey(key);
    
    final secretBox = await algorithm.encrypt(
      utf8.encode(plaintext),
      secretKey: secretKey,
    );
    
    // Concatenation includes nonce + cipher + mac
    return base64.encode(secretBox.concatenation());
  }

  /// Decrypts a base64 encoded string using AES-256-GCM.
  Future<String> decrypt(String ciphertext) async {
    if (ciphertext.isEmpty) return ciphertext;
    
    try {
      final key = await KeyManager.getKeyFor(dataClass);
      final secretKey = SecretKey(key);
      
      final secretBox = SecretBox.fromConcatenation(
        base64.decode(ciphertext),
        nonceLength: algorithm.nonceLength,
        macLength: algorithm.macAlgorithm.macLength,
      );
      
      final cleartext = await algorithm.decrypt(
        secretBox,
        secretKey: secretKey,
      );
      
      return utf8.decode(cleartext);
    } catch (e) {
      // In case of decryption failure, return original (might already be cleartext in dev)
      return ciphertext;
    }
  }

  /// Encrypts a JSON map or list.
  Future<String> encryptJson(dynamic json) async {
    final str = jsonEncode(json);
    return encrypt(str);
  }

  /// Decrypts to a dynamic JSON object.
  Future<dynamic> decryptJson(String ciphertext) async {
    final str = await decrypt(ciphertext);
    return jsonDecode(str);
  }
}

@riverpod
EncryptionService encryptionService(Ref ref, String dataClass) {
  return EncryptionService(dataClass);
}
