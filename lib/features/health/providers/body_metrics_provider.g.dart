// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_metrics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weightHistoryHash() => r'e8adc860adbf9bd068cf7f5fbd76f5a6ad77aaaf';

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

/// See also [weightHistory].
@ProviderFor(weightHistory)
const weightHistoryProvider = WeightHistoryFamily();

/// See also [weightHistory].
class WeightHistoryFamily extends Family<AsyncValue<List<WeightLog>>> {
  /// See also [weightHistory].
  const WeightHistoryFamily();

  /// See also [weightHistory].
  WeightHistoryProvider call(
    int days,
  ) {
    return WeightHistoryProvider(
      days,
    );
  }

  @override
  WeightHistoryProvider getProviderOverride(
    covariant WeightHistoryProvider provider,
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
  String? get name => r'weightHistoryProvider';
}

/// See also [weightHistory].
class WeightHistoryProvider extends AutoDisposeStreamProvider<List<WeightLog>> {
  /// See also [weightHistory].
  WeightHistoryProvider(
    int days,
  ) : this._internal(
          (ref) => weightHistory(
            ref as WeightHistoryRef,
            days,
          ),
          from: weightHistoryProvider,
          name: r'weightHistoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$weightHistoryHash,
          dependencies: WeightHistoryFamily._dependencies,
          allTransitiveDependencies:
              WeightHistoryFamily._allTransitiveDependencies,
          days: days,
        );

  WeightHistoryProvider._internal(
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
    Stream<List<WeightLog>> Function(WeightHistoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WeightHistoryProvider._internal(
        (ref) => create(ref as WeightHistoryRef),
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
  AutoDisposeStreamProviderElement<List<WeightLog>> createElement() {
    return _WeightHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WeightHistoryProvider && other.days == days;
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
mixin WeightHistoryRef on AutoDisposeStreamProviderRef<List<WeightLog>> {
  /// The parameter `days` of this provider.
  int get days;
}

class _WeightHistoryProviderElement
    extends AutoDisposeStreamProviderElement<List<WeightLog>>
    with WeightHistoryRef {
  _WeightHistoryProviderElement(super.provider);

  @override
  int get days => (origin as WeightHistoryProvider).days;
}

String _$bodyMetricsNotifierHash() =>
    r'7adf3ce1900729d402710932b46ebb9a3a7113d2';

/// See also [BodyMetricsNotifier].
@ProviderFor(BodyMetricsNotifier)
final bodyMetricsNotifierProvider = AutoDisposeStreamNotifierProvider<
    BodyMetricsNotifier, Map<String, dynamic>>.internal(
  BodyMetricsNotifier.new,
  name: r'bodyMetricsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bodyMetricsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BodyMetricsNotifier = AutoDisposeStreamNotifier<Map<String, dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
