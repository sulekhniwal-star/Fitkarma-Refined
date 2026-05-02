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
    r'371d9b2d45e97d1a36706283737dca6f1ddd2662';

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

@ProviderFor(festivalDiet)
final festivalDietProvider = FestivalDietFamily._();

final class FestivalDietProvider extends $FunctionalProvider<
        AsyncValue<Map<String, dynamic>?>,
        Map<String, dynamic>?,
        FutureOr<Map<String, dynamic>?>>
    with
        $FutureModifier<Map<String, dynamic>?>,
        $FutureProvider<Map<String, dynamic>?> {
  FestivalDietProvider._(
      {required FestivalDietFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'festivalDietProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$festivalDietHash();

  @override
  String toString() {
    return r'festivalDietProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>?> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>?> create(Ref ref) {
    final argument = this.argument as String;
    return festivalDiet(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FestivalDietProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$festivalDietHash() => r'33a1c62c4f90014f1069d45ac05041b9bcd4eb2c';

final class FestivalDietFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Map<String, dynamic>?>, String> {
  FestivalDietFamily._()
      : super(
          retry: null,
          name: r'festivalDietProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FestivalDietProvider call(
    String festivalKey,
  ) =>
      FestivalDietProvider._(argument: festivalKey, from: this);

  @override
  String toString() => r'festivalDietProvider';
}

@ProviderFor(filteredFestivals)
final filteredFestivalsProvider = FilteredFestivalsFamily._();

final class FilteredFestivalsProvider extends $FunctionalProvider<
        AsyncValue<List<dynamic>>, List<dynamic>, FutureOr<List<dynamic>>>
    with $FutureModifier<List<dynamic>>, $FutureProvider<List<dynamic>> {
  FilteredFestivalsProvider._(
      {required FilteredFestivalsFamily super.from,
      required List<dynamic> super.argument})
      : super(
          retry: null,
          name: r'filteredFestivalsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$filteredFestivalsHash();

  @override
  String toString() {
    return r'filteredFestivalsProvider'
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
    final argument = this.argument as List<dynamic>;
    return filteredFestivals(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredFestivalsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredFestivalsHash() => r'26d33c2e190668678d2f81dc41f9624929b11c57';

final class FilteredFestivalsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<dynamic>>, List<dynamic>> {
  FilteredFestivalsFamily._()
      : super(
          retry: null,
          name: r'filteredFestivalsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FilteredFestivalsProvider call(
    List<dynamic> festivals,
  ) =>
      FilteredFestivalsProvider._(argument: festivals, from: this);

  @override
  String toString() => r'filteredFestivalsProvider';
}
