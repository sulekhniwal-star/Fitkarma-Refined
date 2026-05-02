// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_metrics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BodyMetricsNotifier)
final bodyMetricsProvider = BodyMetricsNotifierProvider._();

final class BodyMetricsNotifierProvider
    extends $StreamNotifierProvider<BodyMetricsNotifier, Map<String, Object>> {
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
    r'e32d57372205d8a6413bd083c5ed9aab2b46ece9';

abstract class _$BodyMetricsNotifier
    extends $StreamNotifier<Map<String, Object>> {
  Stream<Map<String, Object>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<Map<String, Object>>, Map<String, Object>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<Map<String, Object>>, Map<String, Object>>,
        AsyncValue<Map<String, Object>>,
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

String _$weightHistoryHash() => r'b5b9605b847c30356cde6d96bcd903b4517f5aaa';

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
