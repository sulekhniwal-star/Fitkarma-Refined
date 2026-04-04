// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vision_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(visionService)
final visionServiceProvider = VisionServiceProvider._();

final class VisionServiceProvider
    extends $FunctionalProvider<VisionService, VisionService, VisionService>
    with $Provider<VisionService> {
  VisionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'visionServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$visionServiceHash();

  @$internal
  @override
  $ProviderElement<VisionService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VisionService create(Ref ref) {
    return visionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VisionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VisionService>(value),
    );
  }
}

String _$visionServiceHash() => r'eea932137f9f6f57a488c90dd162bd49a90e515e';
