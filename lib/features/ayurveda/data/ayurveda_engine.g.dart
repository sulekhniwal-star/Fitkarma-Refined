// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayurveda_engine.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AyurvedaEngine)
final ayurvedaEngineProvider = AyurvedaEngineProvider._();

final class AyurvedaEngineProvider
    extends $NotifierProvider<AyurvedaEngine, void> {
  AyurvedaEngineProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ayurvedaEngineProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ayurvedaEngineHash();

  @$internal
  @override
  AyurvedaEngine create() => AyurvedaEngine();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$ayurvedaEngineHash() => r'1d6a1fb9b7a9d2b51597a31b2813f9f71e1eb60e';

abstract class _$AyurvedaEngine extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
