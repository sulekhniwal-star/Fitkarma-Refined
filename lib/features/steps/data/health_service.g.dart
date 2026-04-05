// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(healthService)
final healthServiceProvider = HealthServiceProvider._();

final class HealthServiceProvider
    extends $FunctionalProvider<HealthService, HealthService, HealthService>
    with $Provider<HealthService> {
  HealthServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'healthServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$healthServiceHash();

  @$internal
  @override
  $ProviderElement<HealthService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HealthService create(Ref ref) {
    return healthService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HealthService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HealthService>(value),
    );
  }
}

String _$healthServiceHash() => r'1533e2e174c0d94017367ba4d980c09544e9a9ce';
