import 'package:appwrite/appwrite.dart';
import 'package:fitkarma/core/constants/app_config.dart';
import 'package:flutter/foundation.dart';

class AppwriteClient {
  static late final Client _client;
  static bool _isInitialised = false;

  static void init({String? pinnedCertHash}) {
    if (_isInitialised) return;

    _client = Client()
      ..setEndpoint(AppConfig.appwriteEndpoint)
      ..setProject(AppConfig.appwriteProjectId)
      ..setSelfSigned(status: false);

    // Note: Official Appwrite SDK for Flutter uses its own internal http client management.
    // To support pinning in the SDK, we would normally use setClient(http.Client).
    
    _isInitialised = true;
  }

  static Client get client => _client;
  static Account get account => Account(_client);
  static Databases get databases => Databases(_client);
  static Storage get storage => Storage(_client);
  static Realtime get realtime => Realtime(_client);
  static Functions get functions => Functions(_client);

  /// Test connection by fetching current session/account info
  static Future<void> testConnection() async {
    try {
      final user = await account.get();
      debugPrint('Appwrite Connection Successful: ${user.name} (${user.email})');
    } catch (e) {
      debugPrint('Appwrite Connection Failed: $e');
      // If no session exists, this is expected to fail with 401
    }
  }
}
