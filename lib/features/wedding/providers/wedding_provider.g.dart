// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wedding_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WeddingPlanNotifier)
final weddingPlanProvider = WeddingPlanNotifierProvider._();

final class WeddingPlanNotifierProvider
    extends $NotifierProvider<WeddingPlanNotifier, void> {
  WeddingPlanNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'weddingPlanProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$weddingPlanNotifierHash();

  @$internal
  @override
  WeddingPlanNotifier create() => WeddingPlanNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$weddingPlanNotifierHash() =>
    r'4972bd0d93debbc19ad9ac997e5de60faab9340f';

abstract class _$WeddingPlanNotifier extends $Notifier<void> {
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

@ProviderFor(activeWeddingPlan)
final activeWeddingPlanProvider = ActiveWeddingPlanProvider._();

final class ActiveWeddingPlanProvider
    extends $FunctionalProvider<AsyncValue<dynamic>, dynamic, Stream<dynamic>>
    with $FutureModifier<dynamic>, $StreamProvider<dynamic> {
  ActiveWeddingPlanProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'activeWeddingPlanProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$activeWeddingPlanHash();

  @$internal
  @override
  $StreamProviderElement<dynamic> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<dynamic> create(Ref ref) {
    return activeWeddingPlan(ref);
  }
}

String _$activeWeddingPlanHash() => r'd4ff8f9f6791a801709f2fc6b9591307f85b1103';

@ProviderFor(weddingPhase)
final weddingPhaseProvider = WeddingPhaseProvider._();

final class WeddingPhaseProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  WeddingPhaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'weddingPhaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$weddingPhaseHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return weddingPhase(ref);
  }
}

String _$weddingPhaseHash() => r'b4616591d61852fb494ff4732d988ca005fadf77';

@ProviderFor(weddingEventDiet)
final weddingEventDietProvider = WeddingEventDietFamily._();

final class WeddingEventDietProvider extends $FunctionalProvider<
        AsyncValue<Map<String, Object?>>,
        Map<String, Object?>,
        FutureOr<Map<String, Object?>>>
    with
        $FutureModifier<Map<String, Object?>>,
        $FutureProvider<Map<String, Object?>> {
  WeddingEventDietProvider._(
      {required WeddingEventDietFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'weddingEventDietProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$weddingEventDietHash();

  @override
  String toString() {
    return r'weddingEventDietProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Map<String, Object?>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, Object?>> create(Ref ref) {
    final argument = this.argument as String;
    return weddingEventDiet(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WeddingEventDietProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$weddingEventDietHash() => r'dbddc66e2ded7b46ee29fa702f5cba0b62f77b06';

final class WeddingEventDietFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Map<String, Object?>>, String> {
  WeddingEventDietFamily._()
      : super(
          retry: null,
          name: r'weddingEventDietProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  WeddingEventDietProvider call(
    String eventKey,
  ) =>
      WeddingEventDietProvider._(argument: eventKey, from: this);

  @override
  String toString() => r'weddingEventDietProvider';
}
