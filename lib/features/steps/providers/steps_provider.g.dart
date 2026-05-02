// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'steps_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Steps)
final stepsProvider = StepsProvider._();

final class StepsProvider extends $StreamNotifierProvider<Steps, int> {
  StepsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'stepsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$stepsHash();

  @$internal
  @override
  Steps create() => Steps();
}

String _$stepsHash() => r'e1cf9a7f26674901793f731ccdcc448be7514f82';

abstract class _$Steps extends $StreamNotifier<int> {
  Stream<int> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<int>, int>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<int>, int>, AsyncValue<int>, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(stepHistory)
final stepHistoryProvider = StepHistoryFamily._();

final class StepHistoryProvider extends $FunctionalProvider<
        AsyncValue<List<dynamic>>, List<dynamic>, Stream<List<dynamic>>>
    with $FutureModifier<List<dynamic>>, $StreamProvider<List<dynamic>> {
  StepHistoryProvider._(
      {required StepHistoryFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'stepHistoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$stepHistoryHash();

  @override
  String toString() {
    return r'stepHistoryProvider'
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
    return stepHistory(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is StepHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$stepHistoryHash() => r'1a05a44787bab31c5f75fdcae76e18312ebad564';

final class StepHistoryFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<dynamic>>, int> {
  StepHistoryFamily._()
      : super(
          retry: null,
          name: r'stepHistoryProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  StepHistoryProvider call(
    int days,
  ) =>
      StepHistoryProvider._(argument: days, from: this);

  @override
  String toString() => r'stepHistoryProvider';
}

@ProviderFor(adaptiveGoal)
final adaptiveGoalProvider = AdaptiveGoalProvider._();

final class AdaptiveGoalProvider
    extends $FunctionalProvider<AsyncValue<double>, double, FutureOr<double>>
    with $FutureModifier<double>, $FutureProvider<double> {
  AdaptiveGoalProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'adaptiveGoalProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$adaptiveGoalHash();

  @$internal
  @override
  $FutureProviderElement<double> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<double> create(Ref ref) {
    return adaptiveGoal(ref);
  }
}

String _$adaptiveGoalHash() => r'5f79f11d193b2c9f0d525b0b12b68f51450aabe3';
