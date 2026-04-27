// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$foodRepositoryHash() => r'66266d63ac245eda548bec15a59e76574da9e2d9';

/// See also [foodRepository].
@ProviderFor(foodRepository)
final foodRepositoryProvider = AutoDisposeProvider<FoodRepository>.internal(
  foodRepository,
  name: r'foodRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$foodRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FoodRepositoryRef = AutoDisposeProviderRef<FoodRepository>;
String _$todayCaloriesHash() => r'62844a030ebdcd2f68339c9a414cf0125c52a268';

/// See also [todayCalories].
@ProviderFor(todayCalories)
final todayCaloriesProvider = AutoDisposeProvider<double>.internal(
  todayCalories,
  name: r'todayCaloriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todayCaloriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodayCaloriesRef = AutoDisposeProviderRef<double>;
String _$foodSearchHash() => r'affe25f2a01662300dfa7f47c257b045c7c6717e';

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

/// See also [foodSearch].
@ProviderFor(foodSearch)
const foodSearchProvider = FoodSearchFamily();

/// See also [foodSearch].
class FoodSearchFamily extends Family<AsyncValue<List<FoodLog>>> {
  /// See also [foodSearch].
  const FoodSearchFamily();

  /// See also [foodSearch].
  FoodSearchProvider call(
    String query,
  ) {
    return FoodSearchProvider(
      query,
    );
  }

  @override
  FoodSearchProvider getProviderOverride(
    covariant FoodSearchProvider provider,
  ) {
    return call(
      provider.query,
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
  String? get name => r'foodSearchProvider';
}

/// See also [foodSearch].
class FoodSearchProvider extends AutoDisposeFutureProvider<List<FoodLog>> {
  /// See also [foodSearch].
  FoodSearchProvider(
    String query,
  ) : this._internal(
          (ref) => foodSearch(
            ref as FoodSearchRef,
            query,
          ),
          from: foodSearchProvider,
          name: r'foodSearchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$foodSearchHash,
          dependencies: FoodSearchFamily._dependencies,
          allTransitiveDependencies:
              FoodSearchFamily._allTransitiveDependencies,
          query: query,
        );

  FoodSearchProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<FoodLog>> Function(FoodSearchRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FoodSearchProvider._internal(
        (ref) => create(ref as FoodSearchRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<FoodLog>> createElement() {
    return _FoodSearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FoodSearchProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FoodSearchRef on AutoDisposeFutureProviderRef<List<FoodLog>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _FoodSearchProviderElement
    extends AutoDisposeFutureProviderElement<List<FoodLog>> with FoodSearchRef {
  _FoodSearchProviderElement(super.provider);

  @override
  String get query => (origin as FoodSearchProvider).query;
}

String _$foodLogNotifierHash() => r'be5780173a66f951d435915a409f0c86d6903503';

abstract class _$FoodLogNotifier
    extends BuildlessAutoDisposeStreamNotifier<List<FoodLog>> {
  late final DateTime date;

  Stream<List<FoodLog>> build(
    DateTime date,
  );
}

/// See also [FoodLogNotifier].
@ProviderFor(FoodLogNotifier)
const foodLogNotifierProvider = FoodLogNotifierFamily();

/// See also [FoodLogNotifier].
class FoodLogNotifierFamily extends Family<AsyncValue<List<FoodLog>>> {
  /// See also [FoodLogNotifier].
  const FoodLogNotifierFamily();

  /// See also [FoodLogNotifier].
  FoodLogNotifierProvider call(
    DateTime date,
  ) {
    return FoodLogNotifierProvider(
      date,
    );
  }

  @override
  FoodLogNotifierProvider getProviderOverride(
    covariant FoodLogNotifierProvider provider,
  ) {
    return call(
      provider.date,
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
  String? get name => r'foodLogNotifierProvider';
}

/// See also [FoodLogNotifier].
class FoodLogNotifierProvider extends AutoDisposeStreamNotifierProviderImpl<
    FoodLogNotifier, List<FoodLog>> {
  /// See also [FoodLogNotifier].
  FoodLogNotifierProvider(
    DateTime date,
  ) : this._internal(
          () => FoodLogNotifier()..date = date,
          from: foodLogNotifierProvider,
          name: r'foodLogNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$foodLogNotifierHash,
          dependencies: FoodLogNotifierFamily._dependencies,
          allTransitiveDependencies:
              FoodLogNotifierFamily._allTransitiveDependencies,
          date: date,
        );

  FoodLogNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  Stream<List<FoodLog>> runNotifierBuild(
    covariant FoodLogNotifier notifier,
  ) {
    return notifier.build(
      date,
    );
  }

  @override
  Override overrideWith(FoodLogNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: FoodLogNotifierProvider._internal(
        () => create()..date = date,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<FoodLogNotifier, List<FoodLog>>
      createElement() {
    return _FoodLogNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FoodLogNotifierProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FoodLogNotifierRef
    on AutoDisposeStreamNotifierProviderRef<List<FoodLog>> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _FoodLogNotifierProviderElement
    extends AutoDisposeStreamNotifierProviderElement<FoodLogNotifier,
        List<FoodLog>> with FoodLogNotifierRef {
  _FoodLogNotifierProviderElement(super.provider);

  @override
  DateTime get date => (origin as FoodLogNotifierProvider).date;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
