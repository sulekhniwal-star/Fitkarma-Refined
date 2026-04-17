// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayurveda_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AyurvedaNotifier)
final ayurvedaProvider = AyurvedaNotifierProvider._();

final class AyurvedaNotifierProvider
    extends $AsyncNotifierProvider<AyurvedaNotifier, DoshaScore?> {
  AyurvedaNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ayurvedaProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ayurvedaNotifierHash();

  @$internal
  @override
  AyurvedaNotifier create() => AyurvedaNotifier();
}

String _$ayurvedaNotifierHash() => r'0d2889786ff62b7684df96cc118cf0ad01d9abf1';

abstract class _$AyurvedaNotifier extends $AsyncNotifier<DoshaScore?> {
  FutureOr<DoshaScore?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DoshaScore?>, DoshaScore?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DoshaScore?>, DoshaScore?>,
              AsyncValue<DoshaScore?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(QuizProgress)
final quizProgressProvider = QuizProgressProvider._();

final class QuizProgressProvider
    extends $NotifierProvider<QuizProgress, Map<int, int>> {
  QuizProgressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quizProgressProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quizProgressHash();

  @$internal
  @override
  QuizProgress create() => QuizProgress();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<int, int> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<int, int>>(value),
    );
  }
}

String _$quizProgressHash() => r'5b64c4afcdaa758f427f8997390084af476a0691';

abstract class _$QuizProgress extends $Notifier<Map<int, int>> {
  Map<int, int> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Map<int, int>, Map<int, int>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<int, int>, Map<int, int>>,
              Map<int, int>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
