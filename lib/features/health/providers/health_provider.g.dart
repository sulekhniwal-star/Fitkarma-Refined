// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$latestBpReadingHash() => r'd8fb0d2a5146a1f6a2ce6156685ad3d9b91ea78c';

/// See also [latestBpReading].
@ProviderFor(latestBpReading)
final latestBpReadingProvider = AutoDisposeStreamProvider<BpReading?>.internal(
  latestBpReading,
  name: r'latestBpReadingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$latestBpReadingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LatestBpReadingRef = AutoDisposeStreamProviderRef<BpReading?>;
String _$latestGlucoseHash() => r'687bd1634b0f12aff6d475afd735059ab4e2b670';

/// See also [latestGlucose].
@ProviderFor(latestGlucose)
final latestGlucoseProvider =
    AutoDisposeStreamProvider<GlucoseReading?>.internal(
  latestGlucose,
  name: r'latestGlucoseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$latestGlucoseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LatestGlucoseRef = AutoDisposeStreamProviderRef<GlucoseReading?>;
String _$sleepHistoryHash() => r'7252186fe36ed31fa679c8ec161cfc9f3b76aaa3';

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

/// See also [sleepHistory].
@ProviderFor(sleepHistory)
const sleepHistoryProvider = SleepHistoryFamily();

/// See also [sleepHistory].
class SleepHistoryFamily extends Family<AsyncValue<List<SleepLog>>> {
  /// See also [sleepHistory].
  const SleepHistoryFamily();

  /// See also [sleepHistory].
  SleepHistoryProvider call(
    int days,
  ) {
    return SleepHistoryProvider(
      days,
    );
  }

  @override
  SleepHistoryProvider getProviderOverride(
    covariant SleepHistoryProvider provider,
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
  String? get name => r'sleepHistoryProvider';
}

/// See also [sleepHistory].
class SleepHistoryProvider extends AutoDisposeStreamProvider<List<SleepLog>> {
  /// See also [sleepHistory].
  SleepHistoryProvider(
    int days,
  ) : this._internal(
          (ref) => sleepHistory(
            ref as SleepHistoryRef,
            days,
          ),
          from: sleepHistoryProvider,
          name: r'sleepHistoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sleepHistoryHash,
          dependencies: SleepHistoryFamily._dependencies,
          allTransitiveDependencies:
              SleepHistoryFamily._allTransitiveDependencies,
          days: days,
        );

  SleepHistoryProvider._internal(
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
    Stream<List<SleepLog>> Function(SleepHistoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SleepHistoryProvider._internal(
        (ref) => create(ref as SleepHistoryRef),
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
  AutoDisposeStreamProviderElement<List<SleepLog>> createElement() {
    return _SleepHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SleepHistoryProvider && other.days == days;
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
mixin SleepHistoryRef on AutoDisposeStreamProviderRef<List<SleepLog>> {
  /// The parameter `days` of this provider.
  int get days;
}

class _SleepHistoryProviderElement
    extends AutoDisposeStreamProviderElement<List<SleepLog>>
    with SleepHistoryRef {
  _SleepHistoryProviderElement(super.provider);

  @override
  int get days => (origin as SleepHistoryProvider).days;
}

String _$sleepDebtHash() => r'5756c1791f2511340078ab4db7db7c34c4301e77';

/// See also [sleepDebt].
@ProviderFor(sleepDebt)
final sleepDebtProvider = AutoDisposeProvider<double>.internal(
  sleepDebt,
  name: r'sleepDebtProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sleepDebtHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SleepDebtRef = AutoDisposeProviderRef<double>;
String _$bPNotifierHash() => r'e0d2fe3bb5d68df4f0ed522d9c5ec7a41ac600fb';

/// See also [BPNotifier].
@ProviderFor(BPNotifier)
final bPNotifierProvider =
    AutoDisposeStreamNotifierProvider<BPNotifier, List<BpReading>>.internal(
  BPNotifier.new,
  name: r'bPNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$bPNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BPNotifier = AutoDisposeStreamNotifier<List<BpReading>>;
String _$glucoseNotifierHash() => r'44293e31394cf5d44aa126ea5772391ecab1aaec';

/// See also [GlucoseNotifier].
@ProviderFor(GlucoseNotifier)
final glucoseNotifierProvider = AutoDisposeStreamNotifierProvider<
    GlucoseNotifier, List<GlucoseReading>>.internal(
  GlucoseNotifier.new,
  name: r'glucoseNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$glucoseNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GlucoseNotifier = AutoDisposeStreamNotifier<List<GlucoseReading>>;
String _$spO2NotifierHash() => r'6ee63c543c847e064bee5a4b9e54c9c7f07aa670';

/// See also [SpO2Notifier].
@ProviderFor(SpO2Notifier)
final spO2NotifierProvider =
    AutoDisposeStreamNotifierProvider<SpO2Notifier, List<Spo2Reading>>.internal(
  SpO2Notifier.new,
  name: r'spO2NotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$spO2NotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SpO2Notifier = AutoDisposeStreamNotifier<List<Spo2Reading>>;
String _$sleepNotifierHash() => r'aa0032e5766f2b2526f354b270580e9b6e152794';

/// See also [SleepNotifier].
@ProviderFor(SleepNotifier)
final sleepNotifierProvider =
    AutoDisposeStreamNotifierProvider<SleepNotifier, List<SleepLog>>.internal(
  SleepNotifier.new,
  name: r'sleepNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sleepNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SleepNotifier = AutoDisposeStreamNotifier<List<SleepLog>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
