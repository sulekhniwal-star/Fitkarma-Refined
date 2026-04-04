import 'dart:convert';
import 'package:appwrite/appwrite.dart';
import '../../core/constants/app_config.dart';
import '../../core/security/key_manager.dart';
import '../../core/storage/app_database.dart';

/// A standalone runner for background sync tasks.
/// Background isolates do not share the main ProviderContainer/Riverpod state,
/// so we must initialize a minimal set of services manually.
class BackgroundSyncRunner {
  late final AppDatabase db;
  late final Client client;
  late final Databases databases;

  Future<void> init() async {
    // 1. Initialize Database with Encryption
    final masterKey = await KeyManager.getMasterKey();
    final keyB64 = base64.encode(masterKey);
    db = AppDatabase(keyB64);

    // 2. Initialize Appwrite Client
    client = Client()
      ..setEndpoint(AppConfig.appwriteEndpoint)
      ..setProject(AppConfig.appwriteProjectId)
      ..setSelfSigned(status: true);
    
    databases = Databases(client);
  }

  Future<void> dispose() async {
    await db.close();
  }
}
