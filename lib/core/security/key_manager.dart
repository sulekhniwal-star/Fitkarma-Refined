import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:cryptography/dart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _masterKeyName = 'fitkarma_master_key';
const _saltName = 'fitkarma_encryption_salt';
const _deviceIdName = 'fitkarma_device_id';
const _installUuidName = 'fitkarma_install_uuid';

const _pbkdf2Iterations = 200000;
const _saltLength = 32;

final _pbkdf2 = Pbkdf2(
  macAlgorithm: Hmac.sha256(),
  iterations: _pbkdf2Iterations,
  bits: 256,
);

final _hkdf = DartHkdf(
  hmac: Hmac.sha256(),
  outputLength: 32,
);

final _secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ),
  iOptions: IOSOptions(
    accessibility: KeychainAccessibility.first_unlock_this_device,
  ),
);

class KeyManager {
  KeyManager._();

  static final KeyManager instance = KeyManager._();

  SecretKey? _cachedMasterKey;
  bool _initialized = false;

  Future<void> initialize(String? deviceId) async {
    if (_initialized) return;
    _initialized = true;

    final deviceIdValue = deviceId ?? await _getOrCreateDeviceId();
    final installUuid = await _getOrCreateInstallUuid();
    final salt = await _getOrCreateSalt();

    final input = '$deviceIdValue$installUuid$salt';
    final saltBytes = Uint8List.fromList(salt.codeUnits);

    _cachedMasterKey = await _pbkdf2.deriveKeyFromPassword(
      password: input,
      nonce: saltBytes,
    );

    final keyBytes = await _cachedMasterKey!.extractBytes();
    final keyString = _uint8ListToString(keyBytes);
    await _secureStorage.write(key: _masterKeyName, value: keyString);

    debugPrint('KeyManager initialized');
  }

  Future<SecretKey> getMasterKey() async {
    if (_cachedMasterKey != null) return _cachedMasterKey!;

    final storedKey = await _secureStorage.read(key: _masterKeyName);
    if (storedKey != null && storedKey.isNotEmpty) {
      final bytes = _stringToUint8List(storedKey);
      final algorithm = AesGcm.with256bits();
      _cachedMasterKey = await algorithm.newSecretKeyFromBytes(bytes);
      return _cachedMasterKey!;
    }

    await initialize(null);
    return _cachedMasterKey!;
  }

  Future<SecretKey> getKeyForDataClass(String dataClass) async {
    final masterKey = await getMasterKey();
    final infoBytes = Uint8List.fromList('fitkarma_$dataClass'.codeUnits);

    final key = await _hkdf.deriveKey(
      secretKey: masterKey,
      info: infoBytes,
    );

    return key;
  }

  Future<String> _getOrCreateDeviceId() async {
    try {
      final existing = await _secureStorage.read(key: _deviceIdName);
      if (existing != null && existing.isNotEmpty) return existing;
    } catch (_) {}

    final newDeviceId = _generateRandomId();
    try {
      await _secureStorage.write(key: _deviceIdName, value: newDeviceId);
    } catch (_) {}
    return newDeviceId;
  }

  Future<String> _getOrCreateInstallUuid() async {
    try {
      final existing = await _secureStorage.read(key: _installUuidName);
      if (existing != null && existing.isNotEmpty) return existing;
    } catch (_) {}

    final newUuid = _generateRandomId();
    try {
      await _secureStorage.write(key: _installUuidName, value: newUuid);
    } catch (_) {}
    return newUuid;
  }

  Future<String> _getOrCreateSalt() async {
    try {
      final existing = await _secureStorage.read(key: _saltName);
      if (existing != null && existing.isNotEmpty) return existing;
    } catch (_) {}

    final newSalt = _generateRandomId();
    try {
      await _secureStorage.write(key: _saltName, value: newSalt);
    } catch (_) {}
    return newSalt;
  }

  String _generateRandomId() {
    final random = Random.secure();
    final bytes = List<int>.generate(_saltLength, (_) => random.nextInt(256));
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  String _uint8ListToString(List<int> bytes) {
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  Uint8List _stringToUint8List(String input) {
    final result = <int>[];
    for (var i = 0; i < input.length; i += 2) {
      if (i + 1 < input.length) {
        result.add(int.parse(input.substring(i, i + 2), radix: 16));
      }
    }
    return Uint8List.fromList(result);
  }
}

class DataClassKeys {
  static const String bpGlucose = 'bp_glucose';
  static const String period = 'period';
  static const String journal = 'journal';
  static const String appointments = 'appointments';
  static const String emergencyCard = 'emergency_card';
}

Future<SecretKey> getKeyForDataClass(String dataClass) =>
    KeyManager.instance.getKeyForDataClass(dataClass);

Future<SecretKey> getMasterKey() => KeyManager.instance.getMasterKey();