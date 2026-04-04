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

String _$authRepositoryHash() => r'd4d1a0ad163cc2c2a356f385e841212c54a7a5a3';

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

String _$currentUserHash() => r'4a1d968a9cedf9c31ee817443670e79d6574ae49';

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

String _$authStateChangesHash() => r'506903f36836124cc60eca850f1b1af144ac60b2';
