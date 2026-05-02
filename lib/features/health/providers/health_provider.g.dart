// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BPNotifier)
final bPProvider = BPNotifierProvider._();

final class BPNotifierProvider
    extends $StreamNotifierProvider<BPNotifier, List<dynamic>> {
  BPNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'bPProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$bPNotifierHash();

  @$internal
  @override
  BPNotifier create() => BPNotifier();
}

String _$bPNotifierHash() => r'26c9f960bb741e6be57485fc8f34ebf337e87087';

abstract class _$BPNotifier extends $StreamNotifier<List<dynamic>> {
  Stream<List<dynamic>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<dynamic>>, List<dynamic>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<dynamic>>, List<dynamic>>,
        AsyncValue<List<dynamic>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(latestBpReading)
final latestBpReadingProvider = LatestBpReadingProvider._();

final class LatestBpReadingProvider
    extends $FunctionalProvider<AsyncValue<dynamic>, dynamic, Stream<dynamic>>
    with $FutureModifier<dynamic>, $StreamProvider<dynamic> {
  LatestBpReadingProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'latestBpReadingProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$latestBpReadingHash();

  @$internal
  @override
  $StreamProviderElement<dynamic> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<dynamic> create(Ref ref) {
    return latestBpReading(ref);
  }
}

String _$latestBpReadingHash() => r'7e78537de476553301c0a95c8612590b13b9e9e5';

@ProviderFor(GlucoseNotifier)
final glucoseProvider = GlucoseNotifierProvider._();

final class GlucoseNotifierProvider
    extends $StreamNotifierProvider<GlucoseNotifier, List<dynamic>> {
  GlucoseNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'glucoseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$glucoseNotifierHash();

  @$internal
  @override
  GlucoseNotifier create() => GlucoseNotifier();
}

String _$glucoseNotifierHash() => r'4129cf50ae2f7b9808f62a2daa6fbc0f401919e0';

abstract class _$GlucoseNotifier extends $StreamNotifier<List<dynamic>> {
  Stream<List<dynamic>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<dynamic>>, List<dynamic>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<dynamic>>, List<dynamic>>,
        AsyncValue<List<dynamic>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(latestGlucose)
final latestGlucoseProvider = LatestGlucoseProvider._();

final class LatestGlucoseProvider
    extends $FunctionalProvider<AsyncValue<dynamic>, dynamic, Stream<dynamic>>
    with $FutureModifier<dynamic>, $StreamProvider<dynamic> {
  LatestGlucoseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'latestGlucoseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$latestGlucoseHash();

  @$internal
  @override
  $StreamProviderElement<dynamic> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<dynamic> create(Ref ref) {
    return latestGlucose(ref);
  }
}

String _$latestGlucoseHash() => r'3b668cc1a6c48b653324f60d0a8410b161dc66c3';

@ProviderFor(SpO2Notifier)
final spO2Provider = SpO2NotifierProvider._();

final class SpO2NotifierProvider
    extends $StreamNotifierProvider<SpO2Notifier, List<dynamic>> {
  SpO2NotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'spO2Provider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$spO2NotifierHash();

  @$internal
  @override
  SpO2Notifier create() => SpO2Notifier();
}

String _$spO2NotifierHash() => r'4787bb1aee7e37656736f10db3c82889a8a2b46f';

abstract class _$SpO2Notifier extends $StreamNotifier<List<dynamic>> {
  Stream<List<dynamic>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<dynamic>>, List<dynamic>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<dynamic>>, List<dynamic>>,
        AsyncValue<List<dynamic>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SleepNotifier)
final sleepProvider = SleepNotifierProvider._();

final class SleepNotifierProvider
    extends $StreamNotifierProvider<SleepNotifier, List<dynamic>> {
  SleepNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'sleepProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$sleepNotifierHash();

  @$internal
  @override
  SleepNotifier create() => SleepNotifier();
}

String _$sleepNotifierHash() => r'2046de9699bd92bf552fa1d3e1b49d4b447e4f76';

abstract class _$SleepNotifier extends $StreamNotifier<List<dynamic>> {
  Stream<List<dynamic>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<dynamic>>, List<dynamic>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<dynamic>>, List<dynamic>>,
        AsyncValue<List<dynamic>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(sleepHistory)
final sleepHistoryProvider = SleepHistoryFamily._();

final class SleepHistoryProvider extends $FunctionalProvider<
        AsyncValue<List<dynamic>>, List<dynamic>, Stream<List<dynamic>>>
    with $FutureModifier<List<dynamic>>, $StreamProvider<List<dynamic>> {
  SleepHistoryProvider._(
      {required SleepHistoryFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'sleepHistoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$sleepHistoryHash();

  @override
  String toString() {
    return r'sleepHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<dynamic>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<dynamic>> create(Ref ref) {
    final argument = this.argument as int;
    return sleepHistory(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SleepHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sleepHistoryHash() => r'001987144693fb1bf008337d2924aa304b428f15';

final class SleepHistoryFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<dynamic>>, int> {
  SleepHistoryFamily._()
      : super(
          retry: null,
          name: r'sleepHistoryProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  SleepHistoryProvider call(
    int days,
  ) =>
      SleepHistoryProvider._(argument: days, from: this);

  @override
  String toString() => r'sleepHistoryProvider';
}

@ProviderFor(sleepDebt)
final sleepDebtProvider = SleepDebtProvider._();

final class SleepDebtProvider
    extends $FunctionalProvider<AsyncValue<double>, double, FutureOr<double>>
    with $FutureModifier<double>, $FutureProvider<double> {
  SleepDebtProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'sleepDebtProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$sleepDebtHash();

  @$internal
  @override
  $FutureProviderElement<double> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<double> create(Ref ref) {
    return sleepDebt(ref);
  }
}

String _$sleepDebtHash() => r'ac44af7c4be8fa5d3720882739cc9de89d382cf6';
