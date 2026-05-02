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

String _$bPNotifierHash() => r'5cec265dad2247172412facfc3799782f1de9936';

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

@ProviderFor(bpHistory)
final bpHistoryProvider = BpHistoryFamily._();

final class BpHistoryProvider extends $FunctionalProvider<
        AsyncValue<List<dynamic>>, List<dynamic>, Stream<List<dynamic>>>
    with $FutureModifier<List<dynamic>>, $StreamProvider<List<dynamic>> {
  BpHistoryProvider._(
      {required BpHistoryFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'bpHistoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$bpHistoryHash();

  @override
  String toString() {
    return r'bpHistoryProvider'
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
    return bpHistory(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is BpHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bpHistoryHash() => r'3810d964aaf51e9ac1e53859819b4803a0e65440';

final class BpHistoryFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<dynamic>>, int> {
  BpHistoryFamily._()
      : super(
          retry: null,
          name: r'bpHistoryProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  BpHistoryProvider call(
    int days,
  ) =>
      BpHistoryProvider._(argument: days, from: this);

  @override
  String toString() => r'bpHistoryProvider';
}

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

String _$glucoseNotifierHash() => r'ff50cd8ac983064790ee463378b1698e4062eb42';

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

@ProviderFor(glucoseHistory)
final glucoseHistoryProvider = GlucoseHistoryFamily._();

final class GlucoseHistoryProvider extends $FunctionalProvider<
        AsyncValue<List<dynamic>>, List<dynamic>, Stream<List<dynamic>>>
    with $FutureModifier<List<dynamic>>, $StreamProvider<List<dynamic>> {
  GlucoseHistoryProvider._(
      {required GlucoseHistoryFamily super.from,
      required ({
        String type,
        int days,
      })
          super.argument})
      : super(
          retry: null,
          name: r'glucoseHistoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$glucoseHistoryHash();

  @override
  String toString() {
    return r'glucoseHistoryProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<List<dynamic>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<dynamic>> create(Ref ref) {
    final argument = this.argument as ({
      String type,
      int days,
    });
    return glucoseHistory(
      ref,
      type: argument.type,
      days: argument.days,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GlucoseHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$glucoseHistoryHash() => r'b4affdcf2ba79f05f4102c8bc9f6060f6779cecb';

final class GlucoseHistoryFamily extends $Family
    with
        $FunctionalFamilyOverride<
            Stream<List<dynamic>>,
            ({
              String type,
              int days,
            })> {
  GlucoseHistoryFamily._()
      : super(
          retry: null,
          name: r'glucoseHistoryProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  GlucoseHistoryProvider call({
    required String type,
    required int days,
  }) =>
      GlucoseHistoryProvider._(argument: (
        type: type,
        days: days,
      ), from: this);

  @override
  String toString() => r'glucoseHistoryProvider';
}

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

String _$spO2NotifierHash() => r'ca0987da7305017258b48822393c29d8c03feb2e';

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

@ProviderFor(latestSpo2)
final latestSpo2Provider = LatestSpo2Provider._();

final class LatestSpo2Provider
    extends $FunctionalProvider<AsyncValue<dynamic>, dynamic, Stream<dynamic>>
    with $FutureModifier<dynamic>, $StreamProvider<dynamic> {
  LatestSpo2Provider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'latestSpo2Provider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$latestSpo2Hash();

  @$internal
  @override
  $StreamProviderElement<dynamic> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<dynamic> create(Ref ref) {
    return latestSpo2(ref);
  }
}

String _$latestSpo2Hash() => r'aaaf2b256d2ee2a1cbe98069fc6e6306082abe42';

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

String _$sleepNotifierHash() => r'c47dcde2cade9cfdaa3912c2b711c8645f521638';

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

String _$sleepDebtHash() => r'33838d4cb498107b3f1e4725c334c3f7052e514a';

@ProviderFor(BodyMetricsNotifier)
final bodyMetricsProvider = BodyMetricsNotifierProvider._();

final class BodyMetricsNotifierProvider
    extends $StreamNotifierProvider<BodyMetricsNotifier, List<dynamic>> {
  BodyMetricsNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'bodyMetricsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$bodyMetricsNotifierHash();

  @$internal
  @override
  BodyMetricsNotifier create() => BodyMetricsNotifier();
}

String _$bodyMetricsNotifierHash() =>
    r'3091ddd59142693bf8a38cace4e3317d95038119';

abstract class _$BodyMetricsNotifier extends $StreamNotifier<List<dynamic>> {
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

@ProviderFor(weightHistory)
final weightHistoryProvider = WeightHistoryFamily._();

final class WeightHistoryProvider extends $FunctionalProvider<
        AsyncValue<List<dynamic>>, List<dynamic>, Stream<List<dynamic>>>
    with $FutureModifier<List<dynamic>>, $StreamProvider<List<dynamic>> {
  WeightHistoryProvider._(
      {required WeightHistoryFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'weightHistoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$weightHistoryHash();

  @override
  String toString() {
    return r'weightHistoryProvider'
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
    return weightHistory(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WeightHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$weightHistoryHash() => r'56d0d8fac1dec4d28e87f1c889a5007887087b4c';

final class WeightHistoryFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<dynamic>>, int> {
  WeightHistoryFamily._()
      : super(
          retry: null,
          name: r'weightHistoryProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  WeightHistoryProvider call(
    int days,
  ) =>
      WeightHistoryProvider._(argument: days, from: this);

  @override
  String toString() => r'weightHistoryProvider';
}

@ProviderFor(bodyMetrics)
final bodyMetricsProvider = BodyMetricsProvider._();

final class BodyMetricsProvider extends $FunctionalProvider<
        AsyncValue<Map<String, dynamic>>,
        Map<String, dynamic>,
        Stream<Map<String, dynamic>>>
    with
        $FutureModifier<Map<String, dynamic>>,
        $StreamProvider<Map<String, dynamic>> {
  BodyMetricsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'bodyMetricsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$bodyMetricsHash();

  @$internal
  @override
  $StreamProviderElement<Map<String, dynamic>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Map<String, dynamic>> create(Ref ref) {
    return bodyMetrics(ref);
  }
}

String _$bodyMetricsHash() => r'2023ebc2b42a7cce1b94c91d42505dc9b7696c5b';
