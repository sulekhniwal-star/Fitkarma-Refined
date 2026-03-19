// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(driftService)
final driftServiceProvider = DriftServiceProvider._();

final class DriftServiceProvider
    extends $FunctionalProvider<DriftService, DriftService, DriftService>
    with $Provider<DriftService> {
  DriftServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driftServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driftServiceHash();

  @$internal
  @override
  $ProviderElement<DriftService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DriftService create(Ref ref) {
    return driftService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DriftService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DriftService>(value),
    );
  }
}

String _$driftServiceHash() => r'e511d38ca9d338198883f422f6326cf71eba1b29';
