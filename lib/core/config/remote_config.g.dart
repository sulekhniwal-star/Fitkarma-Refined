// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_config.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RemoteConfig)
final remoteConfigProvider = RemoteConfigProvider._();

final class RemoteConfigProvider
    extends $AsyncNotifierProvider<RemoteConfig, RemoteConfigData> {
  RemoteConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteConfigHash();

  @$internal
  @override
  RemoteConfig create() => RemoteConfig();
}

String _$remoteConfigHash() => r'c540cbb479daa9aac0d54f8935735f38ee50a373';

abstract class _$RemoteConfig extends $AsyncNotifier<RemoteConfigData> {
  FutureOr<RemoteConfigData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<RemoteConfigData>, RemoteConfigData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RemoteConfigData>, RemoteConfigData>,
              AsyncValue<RemoteConfigData>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
