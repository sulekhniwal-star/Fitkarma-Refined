// lib/core/di/providers.dart
// Root-level dependency injection providers
//
// ORGANIZATION:
// - Core providers are kept alive (keepAlive: true) as they persist across the app lifecycle
// - Feature providers should be scoped to routes with ProviderScope overrides
// - Long-running operations use CancelToken for proper cancellation on dispose

import 'dart:convert';
import 'dart:math';
import 'dart:io';

import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// =============================================================================
// ENVIRONMENT CONFIGURATION
// =============================================================================

/// Environment configuration provider
enum AppEnvironment { staging, production }

final appEnvironmentProvider = Provider<AppEnvironment>((ref) {
  // TODO: Load from environment config
  return AppEnvironment.staging;
});

final appwriteEndpointProvider = Provider<String>((ref) {
  final env = ref.watch(appEnvironmentProvider);
  return env == AppEnvironment.production
      ? 'https://cloud.appwrite.io/v1'
      : 'https://sgp.cloud.appwrite.io/v1';
});

final appwriteProjectIdProvider = Provider<String>((ref) {
  final env = ref.watch(appEnvironmentProvider);
  return env == AppEnvironment.production
      ? 'fitkarma-production'
      : 'fitkarma-staging';
});

// =============================================================================
// FLUTTER SECURE STORAGE
// =============================================================================

/// Secure storage for sensitive data (encryption keys, tokens)
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  // ignore: deprecated_member_use
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );
});

// =============================================================================
// ENCRYPTION KEYS
// =============================================================================

/// Encryption key for local database (SQLCipher)
/// Generated on first launch and stored in secure storage
final databaseEncryptionKeyProvider = FutureProvider<String>((ref) async {
  final storage = ref.watch(secureStorageProvider);

  const keyName = 'fitkarma_db_encryption_key';

  // Check if key exists
  String? existingKey = await storage.read(key: keyName);
  if (existingKey != null && existingKey.length >= 32) {
    return existingKey;
  }

  // Generate new key (32 bytes for SQLCipher)
  final random = Random.secure();
  final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  final keyData =
      '$timestamp-${random.nextInt(999999)}-${Platform.localHostname}';
  final key = sha256.convert(utf8.encode(keyData)).toString();

  // Store in secure storage
  await storage.write(key: keyName, value: key);

  return key;
});

/// API request encryption key (for sensitive API payloads)
final apiEncryptionKeyProvider = FutureProvider<String>((ref) async {
  final storage = ref.watch(secureStorageProvider);

  const keyName = 'fitkarma_api_encryption_key';

  String? existingKey = await storage.read(key: keyName);
  if (existingKey != null) {
    return existingKey;
  }

  // Generate new key
  final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  final keyData = 'api-$timestamp-${Platform.localHostname}';
  final key = sha256.convert(utf8.encode(keyData)).toString();

  await storage.write(key: keyName, value: key);

  return key;
});

// =============================================================================
// APPWRITE CLIENT
// =============================================================================

/// Appwrite client singleton
/// KeepAlive: true - persists throughout app lifecycle
final appwriteClientProvider = Provider<appwrite.Client>((ref) {
  final endpoint = ref.watch(appwriteEndpointProvider);
  final projectId = ref.watch(appwriteProjectIdProvider);

  final client = appwrite.Client()
      .setEndpoint(endpoint)
      .setProject(projectId)
      .setSelfSigned(
        status: kDebugMode, // Use self-signed in debug mode
      );

  return client;
});

/// Appwrite Account service
final appwriteAccountProvider = Provider<appwrite.Account>((ref) {
  final client = ref.watch(appwriteClientProvider);
  return appwrite.Account(client);
});

/// Appwrite Databases service
final appwriteDatabasesProvider = Provider<appwrite.Databases>((ref) {
  final client = ref.watch(appwriteClientProvider);
  return appwrite.Databases(client);
});

/// Appwrite Storage service
final appwriteStorageProvider = Provider<appwrite.Storage>((ref) {
  final client = ref.watch(appwriteClientProvider);
  return appwrite.Storage(client);
});

/// Appwrite Teams service
final appwriteTeamsProvider = Provider<appwrite.Teams>((ref) {
  final client = ref.watch(appwriteClientProvider);
  return appwrite.Teams(client);
});

/// Appwrite Functions service
final appwriteFunctionsProvider = Provider<appwrite.Functions>((ref) {
  final client = ref.watch(appwriteClientProvider);
  return appwrite.Functions(client);
});

/// Appwrite Locale service
final appwriteLocaleProvider = Provider<appwrite.Locale>((ref) {
  final client = ref.watch(appwriteClientProvider);
  return appwrite.Locale(client);
});

/// Current authenticated user session
/// KeepAlive: false - scoped to auth state
///
/// Use this provider to check if user is authenticated and get user info.
/// This provider watches the auth state and auto-updates on login/logout.
final appwriteSessionProvider = FutureProvider<AppwriteSessionState>((
  ref,
) async {
  final account = ref.watch(appwriteAccountProvider);

  try {
    final user = await account.get();
    return AppwriteSessionState(
      userId: user.$id,
      email: user.email,
      name: user.name,
      isAuthenticated: true,
      isLoading: false,
    );
  } catch (e) {
    return AppwriteSessionState(
      isAuthenticated: false,
      isLoading: false,
      error: e.toString(),
    );
  }
});

/// Triggers a session refresh
final sessionRefreshProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    ref.invalidate(appwriteSessionProvider);
  };
});

/// Triggers logout and clears session
final sessionLogoutProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    try {
      final account = ref.read(appwriteAccountProvider);
      await account.deleteSession(sessionId: 'current');
    } catch (_) {
      // Ignore errors during logout
    } finally {
      ref.invalidate(appwriteSessionProvider);
    }
  };
});

/// Session state data class
class AppwriteSessionState {
  final String? userId;
  final String? email;
  final String? name;
  final String? sessionId;
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;

  const AppwriteSessionState({
    this.userId,
    this.email,
    this.name,
    this.sessionId,
    this.isAuthenticated = false,
    this.isLoading = false,
    this.error,
  });
}

// =============================================================================
// DIO HTTP CLIENT
// =============================================================================

/// Dio instance for HTTP requests with CancelToken support
/// KeepAlive: true - single instance for the app
final dioProvider = Provider<Dio>((ref) {
  final baseUrl = ref.watch(appwriteEndpointProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'X-SDK-Name': 'Fitkarma',
        'X-SDK-Version': '1.0.0',
      },
    ),
  );

  // Add interceptors for logging in debug mode
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );
  }

  ref.onDispose(() {
    dio.close();
  });

  return dio;
});

/// Creates a new CancelToken for long-running operations
/// Call cancel() in provider dispose to cancel ongoing requests
final cancelTokenProvider = Provider<CancelToken>((ref) {
  final token = CancelToken();

  ref.onDispose(() {
    if (!token.isCancelled) {
      token.cancel('Provider disposed');
    }
  });

  return token;
});

/// Creates a new CancelToken that can be used for a single operation
/// The consumer is responsible for managing the token lifecycle
class CancelTokenFactory {
  final Ref _ref;

  CancelTokenFactory(this._ref);

  /// Creates a new CancelToken
  /// The caller should call cancel() in dispose or when operation completes
  CancelToken create() {
    return CancelToken();
  }

  /// Creates a CancelToken that auto-cancels when the ref is disposed
  CancelToken createWithAutoCleanup() {
    final token = CancelToken();
    _ref.onDispose(() {
      if (!token.isCancelled) {
        token.cancel('Ref disposed');
      }
    });
    return token;
  }
}

final cancelTokenFactoryProvider = Provider<CancelTokenFactory>((ref) {
  return CancelTokenFactory(ref);
});

// =============================================================================
// DRIFT DATABASE
// =============================================================================

/// Database query executor
/// KeepAlive: true - persists throughout app lifecycle
///
/// Note: For SQLCipher encryption, use drift_flutter package or manually
/// configure the native database with the encryption key.
final databaseProvider = FutureProvider<QueryExecutor>((ref) async {
  // Get encryption key (for future SQLCipher support)
  await ref.watch(databaseEncryptionKeyProvider.future);

  final dbFolder = await getApplicationDocumentsDirectory();
  final file = File(p.join(dbFolder.path, 'fitkarma.sqlite'));

  // Use NativeDatabase for basic drift support
  // For SQLCipher, configure with encryption key
  return NativeDatabase.createInBackground(file);
});

/// Database instance (after initialization)
/// Use this for actual database operations
///
/// Note: Currently returns unimplemented - replace with actual database schema
final driftDatabaseProvider = FutureProvider<DriftDatabase>((ref) async {
  // Watch the database provider to ensure it's initialized
  await ref.watch(databaseProvider.future);

  // TODO: Import and use actual database schema
  // final executor = ref.read(databaseProvider).future;
  // return DriftDatabase(executor);

  // Placeholder return - replace with actual database
  throw UnimplementedError('Database schema not yet implemented');
});

/// Typed table access for database operations
/// Example: final usersTable = ref.watch(databaseTablesProvider).users;
final databaseTablesProvider = FutureProvider<DatabaseTables>((ref) async {
  final db = await ref.watch(driftDatabaseProvider.future);
  return DatabaseTables(db);
});

// Placeholder for actual database tables
class DatabaseTables {
  // TODO: Add actual table accessors
  // final Table users;
  // final Table meals;
  // final Table workouts;

  DatabaseTables(dynamic db);
  // TODO: Initialize table accessors
  // : users = db.users, meals = db.meals, workouts = db.workouts;
}

// =============================================================================
// CONNECTIVITY
// =============================================================================

/// Network connectivity status
/// KeepAlive: false - should update in real-time
final connectivityProvider = StreamProvider<bool>((ref) async* {
  // TODO: Implement with connectivity_plus
  // final connectivity = ref.watch(connectivityPlusProvider);
  // await for (final result in connectivity.onConnectivityChanged) {
  //   yield result != ConnectivityResult.none;
  // }

  // Default to online
  yield true;
});

// =============================================================================
// FEATURE PROVIDER SCOPING EXAMPLES
// =============================================================================

/*
FEATURE PROVIDER ORGANIZATION:

Each feature should organize providers in two files:

1. features/{feature}/data/{feature}_providers.dart
   - Repository providers
   - Data source providers
   - KeepAlive: false (scoped to feature lifecycle)

2. features/{feature}/presentation/{feature}_providers.dart
   - UI state providers
   - View models
   - KeepAlive: false (scoped to screen lifecycle)

Example structure:

lib/
├── core/
│   └── di/
│       └── providers.dart          # Root providers (this file)
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   └── auth_providers.dart # Repository providers
│   │   └── presentation/
│   │       └── auth_providers.dart # UI state providers
│   ├── food/
│   │   ├── data/
│   │   │   └── food_providers.dart
│   │   └── presentation/
│   │       └── food_providers.dart
│   └── workout/
│       ├── data/
│       │   └── workout_providers.dart
│       └── presentation/
│           └── workout_providers.dart

USAGE IN ROUTES (with ProviderScope):

// In GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/food/search',
      builder: (context, state) => ProviderScope(
        overrides: [
          // Override with scoped providers for this route
          foodSearchQueryProvider.overrideWith((ref) => FoodSearchNotifier(ref)),
          foodSearchResultsProvider.overrideWith((ref) => FoodSearchResultsNotifier(ref)),
        ],
        child: const FoodSearchScreen(),
      ),
    ),
  ],
);

PROVIDER DISPOSAL:

Providers with keepAlive: false are automatically disposed when:
1. The ProviderScope override goes out of scope
2. The user navigates away from the screen
3. The provider throws an unhandled error

For long-running operations, always implement proper disposal:

class FoodSearchNotifier extends StateNotifier<AsyncValue<List<Food>>> {
  late final CancelToken _cancelToken;
  
  FoodSearchNotifier(this._ref) : super(const AsyncValue.loading()) {
    _cancelToken = _ref.read(cancelTokenFactoryProvider).createWithAutoCleanup();
  }
  
  Future<void> search(String query) async {
    try {
      final dio = _ref.read(dioProvider);
      final response = await dio.get(
        '/food/search',
        queryParameters: {'q': query},
        cancelToken: _cancelToken, // Pass cancel token
      );
      // Process results
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        // Request was cancelled - this is expected
        return;
      }
      rethrow;
    }
  }
  
  @override
  void dispose() {
    // Cancel any ongoing request
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel('FoodSearchNotifier disposed');
    }
    super.dispose();
  }
}

CANCEL TOKEN OPERATIONS:

Long-running operations that need cancellation:
1. Food search - user types new query before previous completes
2. GPS route save - user navigates away before save completes  
3. Bulk sync - user logs out or app goes to background
4. Image upload - user cancels or navigates away

Always pass CancelToken to:
- dio.request(), dio.get(), dio.post(), etc.
- Future.delayed() with timeout
- Stream subscriptions that can be cancelled
*/
