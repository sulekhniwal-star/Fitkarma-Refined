import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart';
import '../config/app_config.dart';
// Note: AppDatabase will be implemented in Section 2.5
// For now, we stub the import or use a dummy class if needed
// However, the docs show it imported.

// Appwrite Client — singleton
final appwriteClientProvider = Provider<Client>((ref) {
  return Client()
    ..setEndpoint(AppConfig.appwriteEndpoint)
    ..setProject(AppConfig.appwriteProjectId)
    ..setSelfSigned(status: false);
});

// Appwrite services
final appwriteAccountProvider = Provider<Account>((ref) {
  return Account(ref.watch(appwriteClientProvider));
});

final appwriteDatabasesProvider = Provider<Databases>((ref) {
  return Databases(ref.watch(appwriteClientProvider));
});

final appwriteStorageProvider = Provider<Storage>((ref) {
  return Storage(ref.watch(appwriteClientProvider));
});

// Local database — to be overridden in ProviderScope in main.dart
final appDatabaseProvider = Provider<dynamic>((ref) {
  throw UnimplementedError('Must be overridden in ProviderScope overrides');
});
