// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insight_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CorrelationEngine)
final correlationEngineProvider = CorrelationEngineProvider._();

final class CorrelationEngineProvider
    extends $NotifierProvider<CorrelationEngine, void> {
  CorrelationEngineProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'correlationEngineProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$correlationEngineHash();

  @$internal
  @override
  CorrelationEngine create() => CorrelationEngine();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$correlationEngineHash() => r'e3daf496d0291ecae5c798f7645f0c8966b3983c';

abstract class _$CorrelationEngine extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<void, void>, void, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(dashboardInsight)
final dashboardInsightProvider = DashboardInsightProvider._();

final class DashboardInsightProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  DashboardInsightProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'dashboardInsightProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$dashboardInsightHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return dashboardInsight(ref);
  }
}

String _$dashboardInsightHash() => r'e0ca71243f2540b58c6a23049c9952a8f4109085';
