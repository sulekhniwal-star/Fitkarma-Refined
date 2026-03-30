import 'dart:io';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

/// Opens a SQLCipher-encrypted Drift database.
///
/// On first launch, generates a random 256-bit encryption key and stores it
/// in Flutter Secure Storage. On subsequent launches, retrieves the key and
/// passes it via `PRAGMA key` to SQLCipher.
class EncryptedDriftDatabase {
  EncryptedDriftDatabase._();

  static const _keyStorageKey = 'fitkarma_db_cipher_key';

  static final _secureStorage = FlutterSecureStorage(
    aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    iOptions: const IOSOptions(
        accessibility: KeychainAccessibility.first_unlock),
  );

  /// Open the encrypted SQLite database.
  static Future<QueryExecutor> open({
    String databaseName = 'fitkarma.db',
  }) async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, databaseName));

    final key = await _getOrCreateKey();

    final database = NativeDatabase.createInBackground(
      file,
      setup: (db) {
        // Set the SQLCipher encryption key
        db.execute("PRAGMA key = '$key';");

        // SQLCipher 4 compatibility
        db.execute("PRAGMA cipher_compatibility = 4;");

        // Verify decryption succeeded — will throw if key is wrong
        db.execute("SELECT count(*) FROM sqlite_master;");

        // Performance pragmas
        db.execute('PRAGMA journal_mode = WAL;');
        db.execute('PRAGMA foreign_keys = ON;');
        db.execute('PRAGMA busy_timeout = 5000;');
      },
    );

    return database;
  }

  /// Retrieve the existing cipher key or generate a new one.
  static Future<String> _getOrCreateKey() async {
    final existing = await _secureStorage.read(key: _keyStorageKey);
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }

    final key = _generateKey();
    await _secureStorage.write(key: _keyStorageKey, value: key);
    return key;
  }

  /// Generate a cryptographically random hex key (256-bit).
  static String _generateKey() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  /// Delete the stored key (for account wipe or re-provisioning).
  static Future<void> deleteKey() async {
    await _secureStorage.delete(key: _keyStorageKey);
  }

  /// Delete the database file and key (full data wipe).
  static Future<void> wipe({String databaseName = 'fitkarma.db'}) async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, databaseName));
    if (await file.exists()) {
      await file.delete();
    }
    final wal = File('${file.path}-wal');
    final shm = File('${file.path}-shm');
    if (await wal.exists()) await wal.delete();
    if (await shm.exists()) await shm.delete();

    await deleteKey();
  }
}
