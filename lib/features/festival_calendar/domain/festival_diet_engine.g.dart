// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'festival_diet_engine.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FestivalDietProvider)
final festivalDietProviderProvider = FestivalDietProviderProvider._();

final class FestivalDietProviderProvider
    extends
        $AsyncNotifierProvider<FestivalDietProvider, List<FestivalDietConfig>> {
  FestivalDietProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'festivalDietProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$festivalDietProviderHash();

  @$internal
  @override
  FestivalDietProvider create() => FestivalDietProvider();
}

String _$festivalDietProviderHash() =>
    r'e45149e4956b437ccc71633298a00fd4ebc70191';

abstract class _$FestivalDietProvider
    extends $AsyncNotifier<List<FestivalDietConfig>> {
  FutureOr<List<FestivalDietConfig>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<FestivalDietConfig>>,
              List<FestivalDietConfig>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<FestivalDietConfig>>,
                List<FestivalDietConfig>
              >,
              AsyncValue<List<FestivalDietConfig>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
