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
    extends $NotifierProvider<CorrelationEngine, bool> {
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
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$correlationEngineHash() => r'4d617294e57572f1b7ce04256c90fd8a3ca00300';

abstract class _$CorrelationEngine extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
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

String _$dashboardInsightHash() => r'e735a2f9286283eb4442d7c8f4d6c05c1802a793';
