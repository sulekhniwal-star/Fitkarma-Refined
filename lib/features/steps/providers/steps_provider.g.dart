// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'steps_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$stepHistoryHash() => r'59802f7f292e5c73af9e4cf4677cdab490cfcfa1';

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

/// See also [stepHistory].
@ProviderFor(stepHistory)
const stepHistoryProvider = StepHistoryFamily();

/// See also [stepHistory].
class StepHistoryFamily extends Family<AsyncValue<List<StepCount>>> {
  /// See also [stepHistory].
  const StepHistoryFamily();

  /// See also [stepHistory].
  StepHistoryProvider call(
    int days,
  ) {
    return StepHistoryProvider(
      days,
    );
  }

  @override
  StepHistoryProvider getProviderOverride(
    covariant StepHistoryProvider provider,
  ) {
    return call(
      provider.days,
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
  String? get name => r'stepHistoryProvider';
}

/// See also [stepHistory].
class StepHistoryProvider extends AutoDisposeStreamProvider<List<StepCount>> {
  /// See also [stepHistory].
  StepHistoryProvider(
    int days,
  ) : this._internal(
          (ref) => stepHistory(
            ref as StepHistoryRef,
            days,
          ),
          from: stepHistoryProvider,
          name: r'stepHistoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$stepHistoryHash,
          dependencies: StepHistoryFamily._dependencies,
          allTransitiveDependencies:
              StepHistoryFamily._allTransitiveDependencies,
          days: days,
        );

  StepHistoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.days,
  }) : super.internal();

  final int days;

  @override
  Override overrideWith(
    Stream<List<StepCount>> Function(StepHistoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StepHistoryProvider._internal(
        (ref) => create(ref as StepHistoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        days: days,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<StepCount>> createElement() {
    return _StepHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StepHistoryProvider && other.days == days;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, days.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StepHistoryRef on AutoDisposeStreamProviderRef<List<StepCount>> {
  /// The parameter `days` of this provider.
  int get days;
}

class _StepHistoryProviderElement
    extends AutoDisposeStreamProviderElement<List<StepCount>>
    with StepHistoryRef {
  _StepHistoryProviderElement(super.provider);

  @override
  int get days => (origin as StepHistoryProvider).days;
}

String _$adaptiveGoalHash() => r'04811745ff5aabe6047697ce8d52bceafaf88860';

/// See also [adaptiveGoal].
@ProviderFor(adaptiveGoal)
final adaptiveGoalProvider = AutoDisposeProvider<double>.internal(
  adaptiveGoal,
  name: r'adaptiveGoalProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$adaptiveGoalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AdaptiveGoalRef = AutoDisposeProviderRef<double>;
String _$stepsNotifierHash() => r'447a8a79eefc8080f15e0389e98110ce6ef8d564';

/// See also [StepsNotifier].
@ProviderFor(StepsNotifier)
final stepsNotifierProvider =
    AutoDisposeStreamNotifierProvider<StepsNotifier, int>.internal(
  StepsNotifier.new,
  name: r'stepsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$stepsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$StepsNotifier = AutoDisposeStreamNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
