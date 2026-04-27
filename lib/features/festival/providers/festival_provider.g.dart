// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'festival_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activeFestivalsHash() => r'5ec7bc13a9bd50136377fefcc0ffa886d6b9ec0e';

/// See also [activeFestivals].
@ProviderFor(activeFestivals)
final activeFestivalsProvider =
    AutoDisposeStreamProvider<List<Festival>>.internal(
  activeFestivals,
  name: r'activeFestivalsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeFestivalsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveFestivalsRef = AutoDisposeStreamProviderRef<List<Festival>>;
String _$upcomingFestivalsHash() => r'51d93a64c9b55b9e83fb7765e5e3007d03f3f072';

/// See also [upcomingFestivals].
@ProviderFor(upcomingFestivals)
final upcomingFestivalsProvider =
    AutoDisposeStreamProvider<List<Festival>>.internal(
  upcomingFestivals,
  name: r'upcomingFestivalsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$upcomingFestivalsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpcomingFestivalsRef = AutoDisposeStreamProviderRef<List<Festival>>;
String _$festivalDietPlanHash() => r'7fe846e52e196283b9f252bcdaca4f6028ca6a68';

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

/// See also [festivalDietPlan].
@ProviderFor(festivalDietPlan)
const festivalDietPlanProvider = FestivalDietPlanFamily();

/// See also [festivalDietPlan].
class FestivalDietPlanFamily extends Family<AsyncValue<Map<String, dynamic>?>> {
  /// See also [festivalDietPlan].
  const FestivalDietPlanFamily();

  /// See also [festivalDietPlan].
  FestivalDietPlanProvider call(
    String festivalId,
  ) {
    return FestivalDietPlanProvider(
      festivalId,
    );
  }

  @override
  FestivalDietPlanProvider getProviderOverride(
    covariant FestivalDietPlanProvider provider,
  ) {
    return call(
      provider.festivalId,
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
  String? get name => r'festivalDietPlanProvider';
}

/// See also [festivalDietPlan].
class FestivalDietPlanProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>?> {
  /// See also [festivalDietPlan].
  FestivalDietPlanProvider(
    String festivalId,
  ) : this._internal(
          (ref) => festivalDietPlan(
            ref as FestivalDietPlanRef,
            festivalId,
          ),
          from: festivalDietPlanProvider,
          name: r'festivalDietPlanProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$festivalDietPlanHash,
          dependencies: FestivalDietPlanFamily._dependencies,
          allTransitiveDependencies:
              FestivalDietPlanFamily._allTransitiveDependencies,
          festivalId: festivalId,
        );

  FestivalDietPlanProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.festivalId,
  }) : super.internal();

  final String festivalId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>?> Function(FestivalDietPlanRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FestivalDietPlanProvider._internal(
        (ref) => create(ref as FestivalDietPlanRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        festivalId: festivalId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>?> createElement() {
    return _FestivalDietPlanProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FestivalDietPlanProvider && other.festivalId == festivalId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, festivalId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FestivalDietPlanRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>?> {
  /// The parameter `festivalId` of this provider.
  String get festivalId;
}

class _FestivalDietPlanProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>?>
    with FestivalDietPlanRef {
  _FestivalDietPlanProviderElement(super.provider);

  @override
  String get festivalId => (origin as FestivalDietPlanProvider).festivalId;
}

String _$filteredActiveFestivalsHash() =>
    r'574a9c8f13c1bad8aa02edf10e121599f3098ed4';

/// See also [filteredActiveFestivals].
@ProviderFor(filteredActiveFestivals)
final filteredActiveFestivalsProvider =
    AutoDisposeProvider<List<Festival>>.internal(
  filteredActiveFestivals,
  name: r'filteredActiveFestivalsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredActiveFestivalsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredActiveFestivalsRef = AutoDisposeProviderRef<List<Festival>>;
String _$userFestivalFilterHash() =>
    r'f607ce5bbeeb8807c162249a548e8d409676e1fc';

/// See also [UserFestivalFilter].
@ProviderFor(UserFestivalFilter)
final userFestivalFilterProvider = AutoDisposeNotifierProvider<
    UserFestivalFilter, Map<String, String?>>.internal(
  UserFestivalFilter.new,
  name: r'userFestivalFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userFestivalFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserFestivalFilter = AutoDisposeNotifier<Map<String, String?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
