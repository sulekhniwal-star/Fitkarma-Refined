import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart';
import 'package:fitkarma/core/constants/app_config.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/core/network/connectivity_service.dart';
import 'package:fitkarma/core/security/encryption_service.dart';
import 'package:fitkarma/core/security/key_manager.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// ROOT PROVIDERS — App-wide singletons
// ═══════════════════════════════════════════════════════════════════════════════

/// Appwrite Client — singleton, stays alive for app lifetime
final appwriteClientProvider = Provider<Client>((ref) {
  return Client()
    ..setEndpoint(AppConfig.appwriteEndpoint)
    ..setProject(AppConfig.appwriteProjectId);
});

/// Appwrite TablesDB — depends on client
final appwriteTablesDbProvider = Provider<TablesDB>((ref) {
  final client = ref.watch(appwriteClientProvider);
  return TablesDB(client);
});

/// Drift Database — singleton, stays alive for app lifetime
/// NOTE: Use `keepAlive: true` (default) for database
final driftDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

/// Connectivity Service — singleton
final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService.instance;
});

/// Encryption Service — singleton
final encryptionServiceProvider = Provider<EncryptionService>((ref) {
  return EncryptionService.instance;
});

/// Key Manager — singleton
/// NOTE: Use `keepAlive: true` for key manager to persist across UI rebuilds
final keyManagerProvider = Provider<KeyManager>((ref) {
  return KeyManager.instance;
});

// ═══════════════════════════════════════════════════════════════════════════════
// FEATURE PROVIDER SCOPING GUIDE
// ═══════════════════════════════════════════════════════════════════════════════
//
// ORGANISATION:
//
// lib/core/di/providers.dart              — Root providers (this file)
// lib/features/X/data/X_repository.dart   — Repository class
// lib/features/X/data/X_providers.dart   — Repository providers
// lib/features/X/presentation/X_screen.dart    — UI
// lib/features/X/presentation/X_providers.dart — UI state providers
//
// SCOPING RULES:
//
// 1. Root providers (this file): keepAlive: true — app lifetime
// 2. Repository providers: keepAlive: true — shared across screens
// 3. UI state providers: keepAlive: false — disposable on navigation pop
//
// EXAMPLE: Feature repository provider
//
// // lib/features/food/data/food_providers.dart
// final foodRepositoryProvider = Provider<FoodRepository>((ref) {
//   final db = ref.watch(driftDatabaseProvider);
//   return FoodRepository(db);
// });
//
// EXAMPLE: Route-scoped UI state
//
// // In route/go_router:
// ProviderScope(
//   overrides: [foodRepositoryProvider.overrideWith((ref) => FoodRepository())],
//   child: FoodListScreen(),
// ),
//
// CANCELLATION FOR LONG-RUNNING OPERATIONS:
//
// final searchProvider = FutureProvider.autoDispose.family(async (ref, query) {
//   final token = createCancellationToken(ref);
//   final results = await searchFoods(query, token: token);
//   return results;
// });
//

// ═══════════════════════════════════════════════════════════════════════════════
// CANCELLATION UTILITIES
// ═══════════════════════════════════════════════════════════════════════════════

class AppCancellationToken {
  bool _isCancelled = false;
  
  bool get isCancelled => _isCancelled;
  
  void cancel() => _isCancelled = true;
  
  void throwIfCancelled() {
    if (_isCancelled) {
      throw CancelledException();
    }
  }
}

class CancelledException implements Exception {
  @override
  String toString() => 'Operation cancelled';
}

/// Creates a cancellation token that cancels when provider is disposed
AppCancellationToken createCancellationToken(Ref ref) {
  final token = AppCancellationToken();
  ref.onDispose(() => token.cancel());
  return token;
}

/// Helper to cancel long-running operations in provider dispose
void cancelOnDispose(Ref ref, List<Completer> completers) {
  ref.onDispose(() {
    for (final c in completers) {
      if (!c.isCompleted) c.complete();
    }
  });
}