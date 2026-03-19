import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:crypto/crypto.dart';
import 'package:fitkarma/core/security/key_manager.dart';

/// Data class identifiers for per-key derivation.
/// Renamed to avoid conflict with drift's DataClass.
enum EncryptionDataClass {
  bp, // Blood pressure and glucose
  period, // Menstrual cycle data
  journal, // Journal entries
  appointments, // Doctor appointments
  labReports, // Lab reports
}

/// Encryption service that supports both master key and per-data-class encryption.
///
/// Per-data-class keys are derived from the master key using HKDF,
/// providing lateral movement protection - if one key leaks,
/// the attacker cannot derive other data class keys without the master key.
///
/// Data classes:
/// - BP/Glucose: fitkarma_bp_glucose
/// - Period: fitkarma_period
/// - Journal: fitkarma_journal
/// - Appointments: fitkarma_appointments
/// - Lab Reports: fitkarma_lab_reports
class EncryptionService {
  static final EncryptionService instance = EncryptionService._();
  EncryptionService._();

  late enc.Key _masterKey;
  bool _isInitialised = false;

  // Per-data-class keys (pre-derived and cached)
  final Map<EncryptionDataClass, enc.Key> _dataClassKeys = {};
  bool _dataClassMode = false;

  /// Initialize with the master key (base64 encoded).
  /// This is called during app startup.
  void init(String base64Key) {
    final bytes = base64.decode(base64Key);
    // Derive a 32-byte key using SHA-256 to ensure it's the right length
    final digest = sha256.convert(bytes);
    _masterKey = enc.Key(Uint8List.fromList(digest.bytes));
    _isInitialised = true;
    _dataClassMode = false;
  }

  /// Initialize with per-data-class key derivation mode enabled (synchronous).
  /// This must be called after init() to enable HKDF-based per-class encryption.
  /// Keys are pre-derived synchronously using cached values.
  void initDataClassModeSync(List<int> masterKeyBytes) {
    if (!_isInitialised) {
      throw Exception('EncryptionService not initialised - call init() first');
    }
    _dataClassMode = true;

    // Pre-derive keys for all data classes synchronously
    for (final dataClass in EncryptionDataClass.values) {
      _deriveKeySync(masterKeyBytes, dataClass);
    }
  }

  /// Derive key synchronously using HKDF with pre-computed master key.
  void _deriveKeySync(List<int> masterKeyBytes, EncryptionDataClass dataClass) {
    final info = _getHkdfInfo(dataClass);

    // HKDF derivation using HMAC-SHA256
    final infoBytes = utf8.encode(info);
    final hmac = Hmac(sha256, masterKeyBytes);

    // HKDF expand: HMAC(key, info || 0x01)
    final expanded = hmac.convert([...infoBytes, 0x01]).bytes;

    // Use first 32 bytes as the key
    final keyDigest = sha256.convert(expanded);
    _dataClassKeys[dataClass] = enc.Key(Uint8List.fromList(keyDigest.bytes));
  }

  /// Get the HKDF info string for a data class.
  String _getHkdfInfo(EncryptionDataClass dataClass) {
    switch (dataClass) {
      case EncryptionDataClass.bp:
        return 'fitkarma_bp_glucose';
      case EncryptionDataClass.period:
        return 'fitkarma_period';
      case EncryptionDataClass.journal:
        return 'fitkarma_journal';
      case EncryptionDataClass.appointments:
        return 'fitkarma_appointments';
      case EncryptionDataClass.labReports:
        return 'fitkarma_lab_reports';
    }
  }

  /// Encrypt data using the master key (legacy mode).
  String encrypt(String plaintext) {
    _ensureInitialized();
    if (_dataClassMode) {
      throw Exception(
        'Data class mode is enabled. Use encryptDataClass() for per-class encryption.',
      );
    }
    return _encryptWithKey(plaintext, _masterKey);
  }

  /// Decrypt data using the master key (legacy mode).
  String decrypt(String ciphertext) {
    _ensureInitialized();
    if (_dataClassMode) {
      throw Exception(
        'Data class mode is enabled. Use decryptDataClass() for per-class encryption.',
      );
    }
    return _decryptWithKey(ciphertext, _masterKey);
  }

  /// Encrypt data using a per-data-class key.
  /// This provides lateral movement protection.
  String encryptDataClass(String plaintext, EncryptionDataClass dataClass) {
    _ensureInitialized();
    final key = _dataClassKeys[dataClass];
    if (key == null) {
      throw Exception('Data class key not initialized: $dataClass');
    }
    return _encryptWithKey(plaintext, key);
  }

  /// Decrypt data using a per-data-class key.
  String decryptDataClass(String ciphertext, EncryptionDataClass dataClass) {
    _ensureInitialized();
    final key = _dataClassKeys[dataClass];
    if (key == null) {
      throw Exception('Data class key not initialized: $dataClass');
    }
    return _decryptWithKey(ciphertext, key);
  }

  /// Encrypt with a specific key.
  String _encryptWithKey(String plaintext, enc.Key key) {
    final iv = enc.IV.fromLength(16); // Random IV for each encryption
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.sic));

    final encrypted = encrypter.encrypt(plaintext, iv: iv);

    // Return IV + Ciphertext (base64 combined)
    final combined = Uint8List(iv.bytes.length + encrypted.bytes.length);
    combined.setAll(0, iv.bytes);
    combined.setAll(iv.bytes.length, encrypted.bytes);

    return base64.encode(combined);
  }

  /// Decrypt with a specific key.
  String _decryptWithKey(String ciphertext, enc.Key key) {
    final combined = base64.decode(ciphertext);
    if (combined.length < 16) throw Exception('Invalid ciphertext');

    final iv = enc.IV(combined.sublist(0, 16));
    final encryptedBytes = combined.sublist(16);

    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.sic));
    return encrypter.decrypt(enc.Encrypted(encryptedBytes), iv: iv);
  }

  void _ensureInitialized() {
    if (!_isInitialised) {
      throw Exception(
        'EncryptionService not initialised. Call init() with master key first.',
      );
    }
  }

  /// Check if service is initialized.
  bool get isInitialized => _isInitialised;

  /// Check if data class mode is enabled.
  bool get isDataClassMode => _dataClassMode;

  /// Clear cached keys (for testing or security purposes).
  void clearCache() {
    _dataClassKeys.clear();
  }
}
