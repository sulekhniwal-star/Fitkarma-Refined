// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abha_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ABHANotifier)
final aBHAProvider = ABHANotifierProvider._();

final class ABHANotifierProvider
    extends $NotifierProvider<ABHANotifier, AsyncValue<bool>> {
  ABHANotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'aBHAProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$aBHANotifierHash();

  @$internal
  @override
  ABHANotifier create() => ABHANotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<bool> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<bool>>(value),
    );
  }
}

String _$aBHANotifierHash() => r'6d840238e72f344b8318d7bc6a50998d4c6d29cc';

abstract class _$ABHANotifier extends $Notifier<AsyncValue<bool>> {
  AsyncValue<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, AsyncValue<bool>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<bool>, AsyncValue<bool>>,
        AsyncValue<bool>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
