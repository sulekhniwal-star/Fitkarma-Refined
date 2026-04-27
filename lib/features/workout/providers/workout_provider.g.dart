// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activeWorkoutHash() => r'13dd7632d21fb65722d1d6fffec2933633467ffe';

/// See also [activeWorkout].
@ProviderFor(activeWorkout)
final activeWorkoutProvider = AutoDisposeStreamProvider<Workout?>.internal(
  activeWorkout,
  name: r'activeWorkoutProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeWorkoutHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveWorkoutRef = AutoDisposeStreamProviderRef<Workout?>;
String _$workoutHistoryHash() => r'49ee97bd44b2a446bde6ef5300335f61a7ffaebe';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [workoutHistory].
@ProviderFor(workoutHistory)
const workoutHistoryProvider = WorkoutHistoryFamily();

/// See also [workoutHistory].
class WorkoutHistoryFamily extends Family<AsyncValue<List<Workout>>> {
  /// See also [workoutHistory].
  const WorkoutHistoryFamily();

  /// See also [workoutHistory].
  WorkoutHistoryProvider call({
    int limit = 20,
  }) {
    return WorkoutHistoryProvider(
      limit: limit,
    );
  }

  @override
  WorkoutHistoryProvider getProviderOverride(
    covariant WorkoutHistoryProvider provider,
  ) {
    return call(
      limit: provider.limit,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'workoutHistoryProvider';
}

/// See also [workoutHistory].
class WorkoutHistoryProvider extends AutoDisposeStreamProvider<List<Workout>> {
  /// See also [workoutHistory].
  WorkoutHistoryProvider({
    int limit = 20,
  }) : this._internal(
          (ref) => workoutHistory(
            ref as WorkoutHistoryRef,
            limit: limit,
          ),
          from: workoutHistoryProvider,
          name: r'workoutHistoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$workoutHistoryHash,
          dependencies: WorkoutHistoryFamily._dependencies,
          allTransitiveDependencies:
              WorkoutHistoryFamily._allTransitiveDependencies,
          limit: limit,
        );

  WorkoutHistoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.limit,
  }) : super.internal();

  final int limit;

  @override
  Override overrideWith(
    Stream<List<Workout>> Function(WorkoutHistoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WorkoutHistoryProvider._internal(
        (ref) => create(ref as WorkoutHistoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Workout>> createElement() {
    return _WorkoutHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WorkoutHistoryProvider && other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WorkoutHistoryRef on AutoDisposeStreamProviderRef<List<Workout>> {
  /// The parameter `limit` of this provider.
  int get limit;
}

class _WorkoutHistoryProviderElement
    extends AutoDisposeStreamProviderElement<List<Workout>>
    with WorkoutHistoryRef {
  _WorkoutHistoryProviderElement(super.provider);

  @override
  int get limit => (origin as WorkoutHistoryProvider).limit;
}

String _$personalRecordsHash() => r'd9261ab2fef894d76c7a5359301f5eb5804b657c';

/// See also [personalRecords].
@ProviderFor(personalRecords)
final personalRecordsProvider =
    AutoDisposeProvider<Map<String, dynamic>>.internal(
  personalRecords,
  name: r'personalRecordsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$personalRecordsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PersonalRecordsRef = AutoDisposeProviderRef<Map<String, dynamic>>;
String _$workoutNotifierHash() => r'4fe10124c3b12ce022161021d8267d964747bf64';

/// See also [WorkoutNotifier].
@ProviderFor(WorkoutNotifier)
final workoutNotifierProvider =
    AutoDisposeStreamNotifierProvider<WorkoutNotifier, List<Workout>>.internal(
  WorkoutNotifier.new,
  name: r'workoutNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$workoutNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WorkoutNotifier = AutoDisposeStreamNotifier<List<Workout>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
