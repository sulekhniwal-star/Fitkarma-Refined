import 'dart:typed_data';
import 'package:drift/drift.dart';
import 'package:encrypt/encrypt.dart' as enc;
import '../../security/key_manager.dart';

/// TypeConverter that transparently encrypts strings in the database.
///
/// Uses AES-CBC with a random IV prepended to the ciphertext.
/// Requires [KeyManager] to be initialized with the relevant [dataClass].
class EncryptedStringConverter extends TypeConverter<String, String> {
  final String dataClass;

  const EncryptedStringConverter(this.dataClass);

  @override
  String fromSql(String fromDb) {
    if (fromDb.isEmpty) return '';
    try {
      final key = enc.Key(KeyManager.getKeyForSync(dataClass));
      // fromDb is base64(IV + ciphertext)
      final parts = enc.IV.fromBase64(fromDb);
      // We use the first 16 bytes as IV, the rest as ciphertext
      // But enc.IV and enc.Encrypter.decrypt expect them separated
      // Actually enc.Encrypted.fromBase64 stores the whole thing
      final encrypted = enc.Encrypted.fromBase64(fromDb);

      // AES-CBC with 128-bit IV (16 bytes)
      // Extract IV from the first 16 bytes
      final iv = enc.IV(encrypted.bytes.sublist(0, 16));
      final ciphertext = enc.Encrypted(encrypted.bytes.sublist(16));

      final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
      return encrypter.decrypt(ciphertext, iv: iv);
    } catch (e) {
      return '[DECRYPTION_ERROR]';
    }
  }

  @override
  String toSql(String value) {
    if (value.isEmpty) return '';
    final key = enc.Key(KeyManager.getKeyForSync(dataClass));
    final iv = enc.IV.fromSecureRandom(16);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));

    final encrypted = encrypter.encrypt(value, iv: iv);
    // Combine IV + ciphertext
    final combined = Uint8List.fromList(iv.bytes + encrypted.bytes);
    return enc.Encrypted(combined).base64;
  }
}

/// TypeConverter that transparently encrypts DateTime values as ISO strings.
class EncryptedDateTimeConverter extends TypeConverter<DateTime, String> {
  final String dataClass;
  final EncryptedStringConverter _stringConverter;

  EncryptedDateTimeConverter(this.dataClass)
    : _stringConverter = EncryptedStringConverter(dataClass);

  @override
  DateTime fromSql(String fromDb) {
    final decrypted = _stringConverter.fromSql(fromDb);
    return DateTime.parse(decrypted);
  }

  @override
  String toSql(DateTime value) {
    final iso = value.toIso8601String();
    return _stringConverter.toSql(iso);
  }
}
