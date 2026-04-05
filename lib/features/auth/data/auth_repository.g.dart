// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'ea0d51f9426ca424320871fafa9bdffba41b2aa5';

/// A provider that exposes the current Appwrite User, or null if logged out.

@ProviderFor(currentUser)
final currentUserProvider = CurrentUserProvider._();

/// A provider that exposes the current Appwrite User, or null if logged out.

final class CurrentUserProvider
    extends
        $FunctionalProvider<
          AsyncValue<models.User?>,
          models.User?,
          FutureOr<models.User?>
        >
    with $FutureModifier<models.User?>, $FutureProvider<models.User?> {
  /// A provider that exposes the current Appwrite User, or null if logged out.
  CurrentUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserHash();

  @$internal
  @override
  $FutureProviderElement<models.User?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<models.User?> create(Ref ref) {
    return currentUser(ref);
  }
}

String _$currentUserHash() => r'fb855c87dc47c968dcbc4090e080d440b5dac6e3';

/// A provider that manages the authentication state (authenticated/unauthenticated/initial).

@ProviderFor(authStateChanges)
final authStateChangesProvider = AuthStateChangesProvider._();

/// A provider that manages the authentication state (authenticated/unauthenticated/initial).

final class AuthStateChangesProvider
    extends
        $FunctionalProvider<
          AsyncValue<models.User?>,
          models.User?,
          Stream<models.User?>
        >
    with $FutureModifier<models.User?>, $StreamProvider<models.User?> {
  /// A provider that manages the authentication state (authenticated/unauthenticated/initial).
  AuthStateChangesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStateChangesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStateChangesHash();

  @$internal
  @override
  $StreamProviderElement<models.User?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<models.User?> create(Ref ref) {
    return authStateChanges(ref);
  }
}

String _$authStateChangesHash() => r'c8a6a5e99e6e41dbb7418e32be508d050474b0ed';
