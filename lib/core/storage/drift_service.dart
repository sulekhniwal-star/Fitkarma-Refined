import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../security/key_manager.dart';
import 'app_database.dart';

part 'drift_service.g.dart';

class DriftService {
  static AppDatabase? _db;

  /// Returns the initialized Drift database instance.
  static AppDatabase get db {
    if (_db == null) {
      throw Exception('DriftService.init() must be called before accessing db');
    }
    return _db!;
  }

  /// Initializes the SQLCipher-encrypted database with the master key.
  static Future<void> init() async {
    // Derive master key (device-anchored)
    final masterKey = await KeyManager.getMasterKey();
    final keyB64 = base64.encode(masterKey);

    // Open the SQLCipher-encrypted database
    _db = AppDatabase(keyB64);

    // Pre-warm the connection
    try {
      await _db!.customSelect('SELECT 1').get();
    } catch (e) {
      // Log error (e.g. SQLCipher key mismatch)
      rethrow;
    }
  }
}

/// Provider for the Drift database singleton.
@Riverpod(keepAlive: true)
AppDatabase driftDb(Ref ref) {
  return DriftService.db;
}
