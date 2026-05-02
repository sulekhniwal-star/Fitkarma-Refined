// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'festival_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: type=lint, type=warning

@ProviderFor(activeFestivals)
final activeFestivalsProvider = ActiveFestivalsProvider._();

final class ActiveFestivalsProvider
    extends $FunctionalProvider<AsyncValue<List<Festival>>, List<Festival>, Stream<List<Festival>>>
    with $StreamModifier<List<Festival>>, $StreamProvider<List<Festival>> {
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
  $StreamProviderElement<List<Festival>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Festival>> create(Ref ref) {
    return activeFestivals(ref);
  }
}

String _$activeFestivalsHash() => r'activeFestivals_hash_placeholder';

@ProviderFor(upcomingFestivals)
final upcomingFestivalsProvider = UpcomingFestivalsProvider._();

final class UpcomingFestivalsProvider
    extends $FunctionalProvider<AsyncValue<List<Festival>>, List<Festival>, Stream<List<Festival>>>
    with $StreamModifier<List<Festival>>, $StreamProvider<List<Festival>> {
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
  $StreamProviderElement<List<Festival>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Festival>> create(Ref ref) {
    return upcomingFestivals(ref);
  }
}

String _$upcomingFestivalsHash() => r'upcomingFestivals_hash_placeholder';

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

  Override overrideWithValue(Map<String, String?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, String?>>(value),
    );
  }
}

String _$userFestivalFilterHash() => r'userFestivalFilter_hash_placeholder';

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
const festivalDietPlanProvider = FestivalDietPlanFamily._();

final class FestivalDietPlanProvider
    extends $FunctionalProvider<AsyncValue<Map<String, dynamic>?>, Map<String, dynamic>?, FutureOr<Map<String, dynamic>?>>
    with $FutureModifier<Map<String, dynamic>?>, $FutureProvider<Map<String, dynamic>?> {
  const FestivalDietPlanProvider._(String festivalId)
      : _festivalId = festivalId,
        super(
          from: festivalDietPlanProvider,
          argument: festivalId,
          retry: null,
          name: r'festivalDietPlanProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  final String _festivalId;

  @override
  String debugGetCreateSourceHash() => _$festivalDietPlanHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>?> create(Ref ref) {
    return festivalDietPlan(ref, _festivalId);
  }
}

final class FestivalDietPlanFamily extends Family {
  const FestivalDietPlanFamily._()
      : super(
          retry: null,
          name: r'festivalDietPlanProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FestivalDietPlanProvider call(String festivalId) =>
      FestivalDietPlanProvider._(festivalId);

  @override
  String debugGetCreateSourceHash() => _$festivalDietPlanHash();

  @override
  String toString() => r'festivalDietPlanProvider';
}

String _$festivalDietPlanHash() => r'festivalDietPlan_hash_placeholder';

@ProviderFor(filteredActiveFestivals)
final filteredActiveFestivalsProvider = FilteredActiveFestivalsProvider._();

final class FilteredActiveFestivalsProvider
    extends $FunctionalProvider<List<Festival>, List<Festival>, List<Festival>>
    with $Provider<List<Festival>> {
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
  $ProviderElement<List<Festival>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Festival> create(Ref ref) {
    return filteredActiveFestivals(ref);
  }

  Override overrideWithValue(List<Festival> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Festival>>(value),
    );
  }
}

String _$filteredActiveFestivalsHash() => r'filteredActiveFestivals_hash_placeholder';
