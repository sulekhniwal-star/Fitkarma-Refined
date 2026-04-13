import 'dart:convert';
import '../security/key_manager.dart';
import 'app_database.dart';

/// Service to manage the Drift database instance and its lifecycle.
class DriftService {
  final AppDatabase database;
  
  DriftService(this.database);

  static AppDatabase? _db;

  /// Returns the global [AppDatabase] instance.
  /// 
  /// Throws an [AssertionError] if [init] has not been called.
  static AppDatabase get db {
    assert(_db != null, 'DriftService.init() must be called before accessing db');
    return _db!;
  }

  /// Initializes the SQLCipher-encrypted database.
  static Future<void> init() async {
    // 1. Get the device-anchored master key
    final masterKeyBytes = await KeyManager.getMasterKey();
    
    // 2. Base64 encode for encryption pragma
    final keyB64 = base64Encode(masterKeyBytes);

    // 3. Initialize the database
    _db = AppDatabase(keyB64);

    // 4. Pre-warm connection
    await _db!.customSelect('SELECT 1').get();
  }
}
