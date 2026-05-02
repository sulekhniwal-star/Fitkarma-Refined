// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(foodRepository)
final foodRepositoryProvider = FoodRepositoryProvider._();

final class FoodRepositoryProvider
    extends $FunctionalProvider<FoodRepository, FoodRepository, FoodRepository>
    with $Provider<FoodRepository> {
  FoodRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'foodRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$foodRepositoryHash();

  @$internal
  @override
  $ProviderElement<FoodRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FoodRepository create(Ref ref) {
    return foodRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FoodRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FoodRepository>(value),
    );
  }
}

String _$foodRepositoryHash() => r'4726f4269ed6f763c6a5c9ead6f8be4aae5446a0';

@ProviderFor(FoodLogNotifier)
final foodLogProvider = FoodLogNotifierFamily._();

final class FoodLogNotifierProvider
    extends $StreamNotifierProvider<FoodLogNotifier, List<dynamic>> {
  FoodLogNotifierProvider._(
      {required FoodLogNotifierFamily super.from,
      required DateTime super.argument})
      : super(
          retry: null,
          name: r'foodLogProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$foodLogNotifierHash();

  @override
  String toString() {
    return r'foodLogProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FoodLogNotifier create() => FoodLogNotifier();

  @override
  bool operator ==(Object other) {
    return other is FoodLogNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$foodLogNotifierHash() => r'a8df1a3348d8d53f7bbc2cae71661a8c6d4d25a0';

final class FoodLogNotifierFamily extends $Family
    with
        $ClassFamilyOverride<FoodLogNotifier, AsyncValue<List<dynamic>>,
            List<dynamic>, Stream<List<dynamic>>, DateTime> {
  FoodLogNotifierFamily._()
      : super(
          retry: null,
          name: r'foodLogProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FoodLogNotifierProvider call(
    DateTime date,
  ) =>
      FoodLogNotifierProvider._(argument: date, from: this);

  @override
  String toString() => r'foodLogProvider';
}

abstract class _$FoodLogNotifier extends $StreamNotifier<List<dynamic>> {
  late final _$args = ref.$arg as DateTime;
  DateTime get date => _$args;

  Stream<List<dynamic>> build(
    DateTime date,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<dynamic>>, List<dynamic>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<dynamic>>, List<dynamic>>,
        AsyncValue<List<dynamic>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

@ProviderFor(todayCalories)
final todayCaloriesProvider = TodayCaloriesProvider._();

final class TodayCaloriesProvider
    extends $FunctionalProvider<AsyncValue<double>, double, FutureOr<double>>
    with $FutureModifier<double>, $FutureProvider<double> {
  TodayCaloriesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'todayCaloriesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$todayCaloriesHash();

  @$internal
  @override
  $FutureProviderElement<double> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<double> create(Ref ref) {
    return todayCalories(ref);
  }
}

String _$todayCaloriesHash() => r'cfdf97c344d8620ff5f319e0aa3641046f9c943c';

@ProviderFor(foodSearch)
final foodSearchProvider = FoodSearchFamily._();

final class FoodSearchProvider extends $FunctionalProvider<
        AsyncValue<List<dynamic>>, List<dynamic>, FutureOr<List<dynamic>>>
    with $FutureModifier<List<dynamic>>, $FutureProvider<List<dynamic>> {
  FoodSearchProvider._(
      {required FoodSearchFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'foodSearchProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$foodSearchHash();

  @override
  String toString() {
    return r'foodSearchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<dynamic>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<dynamic>> create(Ref ref) {
    final argument = this.argument as String;
    return foodSearch(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FoodSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$foodSearchHash() => r'5d49d17f6be2502d172a826308fc52d978abc1c1';

final class FoodSearchFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<dynamic>>, String> {
  FoodSearchFamily._()
      : super(
          retry: null,
          name: r'foodSearchProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FoodSearchProvider call(
    String query,
  ) =>
      FoodSearchProvider._(argument: query, from: this);

  @override
  String toString() => r'foodSearchProvider';
}
