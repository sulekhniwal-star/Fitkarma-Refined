// lib/core/di/providers.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../storage/drift_service.dart';
import '../storage/app_database.dart';
import '../network/appwrite_service.dart';
import 'package:appwrite/appwrite.dart';

part 'providers.g.dart';

/// Root-level provider for the AppDatabase (Drift).
/// Initialised in main.dart via DriftService.init().
@Riverpod(keepAlive: true)
AppDatabase database(Ref ref) {
  return DriftService.db;
}

/// Provider for the Appwrite Client.
@Riverpod(keepAlive: true)
Client client(Ref ref) {
  return ref.watch(appwriteClientProvider);
}

/// Provider for the Appwrite Account service.
@Riverpod(keepAlive: true)
Account account(Ref ref) {
  return ref.read(appwriteAccountProvider);
}

/// Provider for the Appwrite Databases service.
@Riverpod(keepAlive: true)
Databases databases(Ref ref) {
  return ref.read(appwriteDatabasesProvider);
}

/// Provider for the Appwrite Storage service.
@Riverpod(keepAlive: true)
Storage storage(Ref ref) {
  return ref.read(appwriteStorageProvider);
}

/// Provider for the Appwrite Functions service.
@Riverpod(keepAlive: true)
Functions functions(Ref ref) {
  return ref.read(appwriteFunctionsProvider);
}
