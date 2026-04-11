// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Root-level provider for the AppDatabase (Drift).
/// Initialised in main.dart via DriftService.init().

@ProviderFor(database)
final databaseProvider = DatabaseProvider._();

/// Root-level provider for the AppDatabase (Drift).
/// Initialised in main.dart via DriftService.init().

final class DatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  /// Root-level provider for the AppDatabase (Drift).
  /// Initialised in main.dart via DriftService.init().
  DatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'databaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$databaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return database(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$databaseHash() => r'ad6952491258e05f152b85b873bff3521247a0cb';

/// Provider for the Appwrite Client.

@ProviderFor(client)
final clientProvider = ClientProvider._();

/// Provider for the Appwrite Client.

final class ClientProvider extends $FunctionalProvider<Client, Client, Client>
    with $Provider<Client> {
  /// Provider for the Appwrite Client.
  ClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientHash();

  @$internal
  @override
  $ProviderElement<Client> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Client create(Ref ref) {
    return client(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Client value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Client>(value),
    );
  }
}

String _$clientHash() => r'a2fa2006ecfc7f137718c2490fb011cda3444f45';

/// Provider for the Appwrite Account service.

@ProviderFor(account)
final accountProvider = AccountProvider._();

/// Provider for the Appwrite Account service.

final class AccountProvider
    extends $FunctionalProvider<Account, Account, Account>
    with $Provider<Account> {
  /// Provider for the Appwrite Account service.
  AccountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountHash();

  @$internal
  @override
  $ProviderElement<Account> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Account create(Ref ref) {
    return account(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Account value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Account>(value),
    );
  }
}

String _$accountHash() => r'4c180263cf7421cfe56a6373c3c7843a2ee641dc';

/// Provider for the Appwrite Databases service.

@ProviderFor(databases)
final databasesProvider = DatabasesProvider._();

/// Provider for the Appwrite Databases service.

final class DatabasesProvider
    extends $FunctionalProvider<Databases, Databases, Databases>
    with $Provider<Databases> {
  /// Provider for the Appwrite Databases service.
  DatabasesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'databasesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$databasesHash();

  @$internal
  @override
  $ProviderElement<Databases> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Databases create(Ref ref) {
    return databases(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Databases value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Databases>(value),
    );
  }
}

String _$databasesHash() => r'14b2bd5d5f9eb8c6faa1b2ca05ae149889864ede';

/// Provider for the Appwrite Storage service.

@ProviderFor(storage)
final storageProvider = StorageProvider._();

/// Provider for the Appwrite Storage service.

final class StorageProvider
    extends $FunctionalProvider<Storage, Storage, Storage>
    with $Provider<Storage> {
  /// Provider for the Appwrite Storage service.
  StorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storageHash();

  @$internal
  @override
  $ProviderElement<Storage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Storage create(Ref ref) {
    return storage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Storage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Storage>(value),
    );
  }
}

String _$storageHash() => r'3bbfe255b999f1f66c8de5252d2f755645f153a1';

/// Provider for the Appwrite Functions service.

@ProviderFor(functions)
final functionsProvider = FunctionsProvider._();

/// Provider for the Appwrite Functions service.

final class FunctionsProvider
    extends $FunctionalProvider<Functions, Functions, Functions>
    with $Provider<Functions> {
  /// Provider for the Appwrite Functions service.
  FunctionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'functionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$functionsHash();

  @$internal
  @override
  $ProviderElement<Functions> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Functions create(Ref ref) {
    return functions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Functions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Functions>(value),
    );
  }
}

String _$functionsHash() => r'9268653b92e0f11f968d30b4cf8b3d7c7323893e';
