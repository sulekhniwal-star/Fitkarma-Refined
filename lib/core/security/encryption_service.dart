import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/foundation.dart';

final _aesGcm = AesGcm.with256bits();

class EncryptionService {
  EncryptionService._();

  static final EncryptionService instance = EncryptionService._();

  final _algorithm = AesGcm.with256bits();

  Future<Uint8List> encrypt(String plaintext, SecretKey key) async {
    final nonce = _algorithm.newNonce();

    final secretBox = await _algorithm.encrypt(
      utf8.encode(plaintext),
      secretKey: key,
      nonce: nonce,
    );

    final nonceOut = Uint8List.fromList(secretBox.nonce);
    final ciphertext = Uint8List.fromList(secretBox.cipherText);
    final tag = Uint8List.fromList(secretBox.mac.bytes);

    final result = Uint8List(nonceOut.length + tag.length + ciphertext.length);
    result.setRange(0, nonceOut.length, nonceOut);
    result.setRange(nonceOut.length, nonceOut.length + tag.length, tag);
    result.setRange(nonceOut.length + tag.length, result.length, ciphertext);

    return result;
  }

  Future<String> decrypt(Uint8List encryptedData, SecretKey key) async {
    final nonce = encryptedData.sublist(0, 12);
    final tag = encryptedData.sublist(12, 28);
    final ciphertext = encryptedData.sublist(28);

    final secretBox = SecretBox(
      ciphertext,
      nonce: nonce,
      mac: Mac(tag),
    );

    final decrypted = await _algorithm.decrypt(
      secretBox,
      secretKey: key,
    );

    return utf8.decode(decrypted);
  }

  Future<SecretKey> newSecretKey() => _algorithm.newSecretKey();

  Future<SecretKey> secretKeyFromBytes(List<int> bytes) =>
      _algorithm.newSecretKeyFromBytes(bytes);
}

class EncryptionHelper {
  static Future<Uint8List> encryptField(String value, SecretKey key) async {
    if (value.isEmpty) return Uint8List(0);
    return EncryptionService.instance.encrypt(value, key);
  }

  static Future<String> decryptField(Uint8List encryptedData, SecretKey key) async {
    if (encryptedData.isEmpty) return '';
    try {
      return EncryptionService.instance.decrypt(encryptedData, key);
    } catch (e) {
      debugPrint('Decryption failed: $e');
      return '';
    }
  }
}