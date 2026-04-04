// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_config.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Service that manages Appwrite Remote Config and local Drift caching.

@ProviderFor(RemoteConfigService)
final remoteConfigServiceProvider = RemoteConfigServiceProvider._();

/// Service that manages Appwrite Remote Config and local Drift caching.
final class RemoteConfigServiceProvider
    extends $AsyncNotifierProvider<RemoteConfigService, RemoteConfig> {
  /// Service that manages Appwrite Remote Config and local Drift caching.
  RemoteConfigServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteConfigServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteConfigServiceHash();

  @$internal
  @override
  RemoteConfigService create() => RemoteConfigService();
}

String _$remoteConfigServiceHash() =>
    r'a7ff97177c9d4b3ea499d9a6e3f41d188c0a8d01';

/// Service that manages Appwrite Remote Config and local Drift caching.

abstract class _$RemoteConfigService extends $AsyncNotifier<RemoteConfig> {
  FutureOr<RemoteConfig> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<RemoteConfig>, RemoteConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RemoteConfig>, RemoteConfig>,
              AsyncValue<RemoteConfig>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
