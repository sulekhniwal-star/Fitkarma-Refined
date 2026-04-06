// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_aw_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(foodAwService)
final foodAwServiceProvider = FoodAwServiceProvider._();

final class FoodAwServiceProvider
    extends $FunctionalProvider<FoodAwService, FoodAwService, FoodAwService>
    with $Provider<FoodAwService> {
  FoodAwServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'foodAwServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$foodAwServiceHash();

  @$internal
  @override
  $ProviderElement<FoodAwService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FoodAwService create(Ref ref) {
    return foodAwService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FoodAwService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FoodAwService>(value),
    );
  }
}

String _$foodAwServiceHash() => r'6867d84f6afcb3b9f9055b5521f9a709ced002a5';
