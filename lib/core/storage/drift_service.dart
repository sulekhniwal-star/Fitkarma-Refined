import 'dart:convert';
import '../security/key_manager.dart';
import 'app_database.dart';

/// Singleton service to manage the Drift database instance and its lifecycle.
class DriftService {
  DriftService._();

  static AppDatabase? _db;

  /// Returns the global [AppDatabase] instance.
  /// 
  /// Throws an [AssertionError] if [init] has not been called.
  static AppDatabase get db {
    assert(_db != null, 'DriftService.init() must be called before accessing db');
    return _db!;
  }

  /// Initializes the SQLCipher-encrypted database.
  /// 
  /// 1. Derives the master key from [KeyManager].
  /// 2. Base64-encodes the key for SQLCipher consumption.
  /// 3. Instantiates [AppDatabase].
  /// 4. Pre-warms the connection to ensure immediate availability for the UI.
  static Future<void> init() async {
    // 1. Get the device-anchored master key
    final masterKeyBytes = await KeyManager.getMasterKey();
    
    // 2. Base64 encode for encryption pragma
    final keyB64 = base64Encode(masterKeyBytes);

    // 3. Initialize the database
    _db = AppDatabase(keyB64);

    // 4. Pre-warm connection
    // This executes a no-op query to trigger the LazyDatabase open and pragmas.
    await _db!.customSelect('SELECT 1').get();
  }
}
