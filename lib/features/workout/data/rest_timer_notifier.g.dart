// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_timer_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RestTimerNotifier)
final restTimerProvider = RestTimerNotifierProvider._();

final class RestTimerNotifierProvider
    extends $NotifierProvider<RestTimerNotifier, RestTimerState> {
  RestTimerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restTimerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restTimerNotifierHash();

  @$internal
  @override
  RestTimerNotifier create() => RestTimerNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RestTimerState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RestTimerState>(value),
    );
  }
}

String _$restTimerNotifierHash() => r'5445763cdbf986d6fa50402a00e101758d61a1fe';

abstract class _$RestTimerNotifier extends $Notifier<RestTimerState> {
  RestTimerState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RestTimerState, RestTimerState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RestTimerState, RestTimerState>,
              RestTimerState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
