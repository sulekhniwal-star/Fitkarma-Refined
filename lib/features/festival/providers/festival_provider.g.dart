// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'festival_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(activeFestivals)
final activeFestivalsProvider = ActiveFestivalsProvider._();

final class ActiveFestivalsProvider extends $FunctionalProvider<
        AsyncValue<List<dynamic>>, List<dynamic>, Stream<List<dynamic>>>
    with $FutureModifier<List<dynamic>>, $StreamProvider<List<dynamic>> {
  ActiveFestivalsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'activeFestivalsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$activeFestivalsHash();

  @$internal
  @override
  $StreamProviderElement<List<dynamic>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<dynamic>> create(Ref ref) {
    return activeFestivals(ref);
  }
}

String _$activeFestivalsHash() => r'f66951dc70354e265df23d079324c04dd7e68e29';

@ProviderFor(upcomingFestivals)
final upcomingFestivalsProvider = UpcomingFestivalsProvider._();

final class UpcomingFestivalsProvider extends $FunctionalProvider<
        AsyncValue<List<dynamic>>, List<dynamic>, Stream<List<dynamic>>>
    with $FutureModifier<List<dynamic>>, $StreamProvider<List<dynamic>> {
  UpcomingFestivalsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'upcomingFestivalsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$upcomingFestivalsHash();

  @$internal
  @override
  $StreamProviderElement<List<dynamic>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<dynamic>> create(Ref ref) {
    return upcomingFestivals(ref);
  }
}

String _$upcomingFestivalsHash() => r'b54ffb8ec3e84a3b705342e41696565cb9158374';

@ProviderFor(UserFestivalFilter)
final userFestivalFilterProvider = UserFestivalFilterProvider._();

final class UserFestivalFilterProvider
    extends $NotifierProvider<UserFestivalFilter, Map<String, String?>> {
  UserFestivalFilterProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userFestivalFilterProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userFestivalFilterHash();

  @$internal
  @override
  UserFestivalFilter create() => UserFestivalFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, String?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, String?>>(value),
    );
  }
}

String _$userFestivalFilterHash() =>
    r'f607ce5bbeeb8807c162249a548e8d409676e1fc';

abstract class _$UserFestivalFilter extends $Notifier<Map<String, String?>> {
  Map<String, String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Map<String, String?>, Map<String, String?>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Map<String, String?>, Map<String, String?>>,
        Map<String, String?>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(festivalDietPlan)
final festivalDietPlanProvider = FestivalDietPlanFamily._();

final class FestivalDietPlanProvider extends $FunctionalProvider<
        AsyncValue<Map<String, Object?>?>,
        Map<String, Object?>?,
        FutureOr<Map<String, Object?>?>>
    with
        $FutureModifier<Map<String, Object?>?>,
        $FutureProvider<Map<String, Object?>?> {
  FestivalDietPlanProvider._(
      {required FestivalDietPlanFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'festivalDietPlanProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$festivalDietPlanHash();

  @override
  String toString() {
    return r'festivalDietPlanProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Map<String, Object?>?> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, Object?>?> create(Ref ref) {
    final argument = this.argument as String;
    return festivalDietPlan(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FestivalDietPlanProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$festivalDietPlanHash() => r'09ec04e932ed8e1eb67929f038b154de124431d5';

final class FestivalDietPlanFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Map<String, Object?>?>, String> {
  FestivalDietPlanFamily._()
      : super(
          retry: null,
          name: r'festivalDietPlanProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FestivalDietPlanProvider call(
    String festivalId,
  ) =>
      FestivalDietPlanProvider._(argument: festivalId, from: this);

  @override
  String toString() => r'festivalDietPlanProvider';
}

@ProviderFor(filteredActiveFestivals)
final filteredActiveFestivalsProvider = FilteredActiveFestivalsProvider._();

final class FilteredActiveFestivalsProvider extends $FunctionalProvider<
        AsyncValue<List<dynamic>>, List<dynamic>, FutureOr<List<dynamic>>>
    with $FutureModifier<List<dynamic>>, $FutureProvider<List<dynamic>> {
  FilteredActiveFestivalsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'filteredActiveFestivalsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$filteredActiveFestivalsHash();

  @$internal
  @override
  $FutureProviderElement<List<dynamic>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<dynamic>> create(Ref ref) {
    return filteredActiveFestivals(ref);
  }
}

String _$filteredActiveFestivalsHash() =>
    r'e7fe113a58f6a7284bfe2cfd769edce2b47cdfa2';
