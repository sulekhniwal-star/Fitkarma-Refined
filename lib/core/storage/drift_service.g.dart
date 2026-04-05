// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the Drift database singleton.

@ProviderFor(driftDb)
final driftDbProvider = DriftDbProvider._();

/// Provider for the Drift database singleton.

final class DriftDbProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  /// Provider for the Drift database singleton.
  DriftDbProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driftDbProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driftDbHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return driftDb(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$driftDbHash() => r'17349fa667de20372c4d8960f1ccc8f167d78198';
