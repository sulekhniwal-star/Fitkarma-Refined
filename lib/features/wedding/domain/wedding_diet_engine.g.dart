// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wedding_diet_engine.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WeddingDietProvider)
final weddingDietProviderProvider = WeddingDietProviderProvider._();

final class WeddingDietProviderProvider
    extends $AsyncNotifierProvider<WeddingDietProvider, WeddingDietPlan?> {
  WeddingDietProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weddingDietProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weddingDietProviderHash();

  @$internal
  @override
  WeddingDietProvider create() => WeddingDietProvider();
}

String _$weddingDietProviderHash() =>
    r'aa2d8d127b4bb2dfb4ddc9fa7466165b22310d0b';

abstract class _$WeddingDietProvider extends $AsyncNotifier<WeddingDietPlan?> {
  FutureOr<WeddingDietPlan?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<WeddingDietPlan?>, WeddingDietPlan?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<WeddingDietPlan?>, WeddingDietPlan?>,
              AsyncValue<WeddingDietPlan?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
