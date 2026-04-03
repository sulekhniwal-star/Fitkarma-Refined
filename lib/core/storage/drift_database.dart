import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

const _dbKeyName = 'fitkarma_db_encryption_key';
const _dbFilename = 'fitkarma_encrypted.db';

final _secureStorage = FlutterSecureStorage();

Future<String> getOrCreateEncryptionKey() async {
  try {
    final existing = await _secureStorage.read(key: _dbKeyName);
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }
  } catch (_) {}
  final newKey = _generateRandomKey();
  try {
    await _secureStorage.write(key: _dbKeyName, value: newKey);
  } catch (_) {}
  return newKey;
}

String _generateRandomKey() {
  final random = Random.secure();
  final bytes = List<int>.generate(32, (_) => random.nextInt(256));
  return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}

String deriveEncryptionKey(String key) {
  final bytes = <int>[];
  for (var i = 0; i < key.length; i += 2) {
    if (i + 1 < key.length) {
      bytes.add(int.parse(key.substring(i, i + 2), radix: 16));
    }
  }
  return "x'${bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join()}'";
}

Future<String> getEncryptedDatabasePath() async {
  final dir = await getApplicationDocumentsDirectory();
  return p.join(dir.path, _dbFilename);
}