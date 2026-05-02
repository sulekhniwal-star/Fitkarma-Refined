// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WorkoutNotifier)
final workoutProvider = WorkoutNotifierProvider._();

final class WorkoutNotifierProvider
    extends $StreamNotifierProvider<WorkoutNotifier, List<dynamic>> {
  WorkoutNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'workoutProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$workoutNotifierHash();

  @$internal
  @override
  WorkoutNotifier create() => WorkoutNotifier();
}

String _$workoutNotifierHash() => r'05ef01fc3e2eb7a8c2adc8a34b5262fc96432793';

abstract class _$WorkoutNotifier extends $StreamNotifier<List<dynamic>> {
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

@ProviderFor(activeWorkout)
final activeWorkoutProvider = ActiveWorkoutProvider._();

final class ActiveWorkoutProvider
    extends $FunctionalProvider<AsyncValue<dynamic>, dynamic, Stream<dynamic>>
    with $FutureModifier<dynamic>, $StreamProvider<dynamic> {
  ActiveWorkoutProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'activeWorkoutProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$activeWorkoutHash();

  @$internal
  @override
  $StreamProviderElement<dynamic> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<dynamic> create(Ref ref) {
    return activeWorkout(ref);
  }
}

String _$activeWorkoutHash() => r'0c35c477ef02f7981482056846414f8d21966813';

@ProviderFor(workoutHistory)
final workoutHistoryProvider = WorkoutHistoryFamily._();

final class WorkoutHistoryProvider extends $FunctionalProvider<
        AsyncValue<List<dynamic>>, List<dynamic>, Stream<List<dynamic>>>
    with $FutureModifier<List<dynamic>>, $StreamProvider<List<dynamic>> {
  WorkoutHistoryProvider._(
      {required WorkoutHistoryFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'workoutHistoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$workoutHistoryHash();

  @override
  String toString() {
    return r'workoutHistoryProvider'
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
    return workoutHistory(
      ref,
      limit: argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WorkoutHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$workoutHistoryHash() => r'36dda118a625700cfa9acd237659a422b4940d5e';

final class WorkoutHistoryFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<dynamic>>, int> {
  WorkoutHistoryFamily._()
      : super(
          retry: null,
          name: r'workoutHistoryProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  WorkoutHistoryProvider call({
    int limit = 20,
  }) =>
      WorkoutHistoryProvider._(argument: limit, from: this);

  @override
  String toString() => r'workoutHistoryProvider';
}

@ProviderFor(personalRecords)
final personalRecordsProvider = PersonalRecordsProvider._();

final class PersonalRecordsProvider extends $FunctionalProvider<
        AsyncValue<Map<String, dynamic>>,
        Map<String, dynamic>,
        FutureOr<Map<String, dynamic>>>
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  PersonalRecordsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'personalRecordsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$personalRecordsHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    return personalRecords(ref);
  }
}

String _$personalRecordsHash() => r'2e667074f6bf0f589ab523f85e9c6d9448a99b12';
