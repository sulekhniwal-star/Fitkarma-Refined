// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_api_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(foodApiService)
final foodApiServiceProvider = FoodApiServiceProvider._();

final class FoodApiServiceProvider
    extends $FunctionalProvider<FoodApiService, FoodApiService, FoodApiService>
    with $Provider<FoodApiService> {
  FoodApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'foodApiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$foodApiServiceHash();

  @$internal
  @override
  $ProviderElement<FoodApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FoodApiService create(Ref ref) {
    return foodApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FoodApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FoodApiService>(value),
    );
  }
}

String _$foodApiServiceHash() => r'6d04ce8babfb8593b773add81471e2b02daeb7f8';
