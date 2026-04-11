// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StreakService)
final streakServiceProvider = StreakServiceProvider._();

final class StreakServiceProvider
    extends $NotifierProvider<StreakService, void> {
  StreakServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'streakServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$streakServiceHash();

  @$internal
  @override
  StreakService create() => StreakService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$streakServiceHash() => r'57b77502340d7d04668fd789559e07c1befbeb9f';

abstract class _$StreakService extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
