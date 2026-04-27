import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart';
import '../config/app_config.dart';
import '../database/app_database.dart';

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

final appwriteTablesDBProvider = Provider<TablesDB>((ref) {
  return TablesDB(ref.watch(appwriteClientProvider));
});

final appwriteFunctionsProvider = Provider<Functions>((ref) {
  return Functions(ref.watch(appwriteClientProvider));
});

final appwriteStorageProvider = Provider<Storage>((ref) {
  return Storage(ref.watch(appwriteClientProvider));
});

// Local database — to be overridden in ProviderScope in main.dart
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('Must be overridden in ProviderScope overrides');
});
