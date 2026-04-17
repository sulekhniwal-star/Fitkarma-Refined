// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'festival_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ✅ DATABASE PROVIDER

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

/// ✅ DATABASE PROVIDER

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  /// ✅ DATABASE PROVIDER
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'05d93eba9c459f963f85f8d901cdfbf120e35e64';

/// ✅ ACTIVE FESTIVALS

@ProviderFor(activeFestivals)
final activeFestivalsProvider = ActiveFestivalsProvider._();

/// ✅ ACTIVE FESTIVALS

final class ActiveFestivalsProvider
    extends $FunctionalProvider<AsyncValue<dynamic>, dynamic, FutureOr<dynamic>>
    with $FutureModifier<dynamic>, $FutureProvider<dynamic> {
  /// ✅ ACTIVE FESTIVALS
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
  $FutureProviderElement<dynamic> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<dynamic> create(Ref ref) {
    return activeFestivals(ref);
  }
}

String _$activeFestivalsHash() => r'af96bc8335ff86c37cdc893d87d0ed33334170ac';

/// ✅ UPCOMING FESTIVALS

@ProviderFor(upcomingFestivals)
final upcomingFestivalsProvider = UpcomingFestivalsProvider._();

/// ✅ UPCOMING FESTIVALS

final class UpcomingFestivalsProvider
    extends $FunctionalProvider<AsyncValue<dynamic>, dynamic, FutureOr<dynamic>>
    with $FutureModifier<dynamic>, $FutureProvider<dynamic> {
  /// ✅ UPCOMING FESTIVALS
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
  $FutureProviderElement<dynamic> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<dynamic> create(Ref ref) {
    return upcomingFestivals(ref);
  }
}

String _$upcomingFestivalsHash() => r'0a259064e9106582cbcfd7f1a14604ef9fd9ba76';

/// ✅ FESTIVAL DETAIL

@ProviderFor(festivalDetail)
final festivalDetailProvider = FestivalDetailFamily._();

/// ✅ FESTIVAL DETAIL

final class FestivalDetailProvider
    extends $FunctionalProvider<AsyncValue<dynamic>, dynamic, FutureOr<dynamic>>
    with $FutureModifier<dynamic>, $FutureProvider<dynamic> {
  /// ✅ FESTIVAL DETAIL
  FestivalDetailProvider._({
    required FestivalDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'festivalDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$festivalDetailHash();

  @override
  String toString() {
    return r'festivalDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<dynamic> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<dynamic> create(Ref ref) {
    final argument = this.argument as String;
    return festivalDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FestivalDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$festivalDetailHash() => r'263fb47d149bdef4a8b2d703cc5e3da5565310fd';

/// ✅ FESTIVAL DETAIL

final class FestivalDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<dynamic>, String> {
  FestivalDetailFamily._()
    : super(
        retry: null,
        name: r'festivalDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// ✅ FESTIVAL DETAIL

  FestivalDetailProvider call(String festivalKey) =>
      FestivalDetailProvider._(argument: festivalKey, from: this);

  @override
  String toString() => r'festivalDetailProvider';
}

