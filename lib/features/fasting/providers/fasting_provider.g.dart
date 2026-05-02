// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fasting_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FastingTimerNotifier)
final fastingTimerProvider = FastingTimerNotifierProvider._();

final class FastingTimerNotifierProvider
    extends $NotifierProvider<FastingTimerNotifier, DateTime?> {
  FastingTimerNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'fastingTimerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$fastingTimerNotifierHash();

  @$internal
  @override
  FastingTimerNotifier create() => FastingTimerNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime?>(value),
    );
  }
}

String _$fastingTimerNotifierHash() =>
    r'd7eb51e446c9af54e5f4647b6aef661aecbd1cd1';

abstract class _$FastingTimerNotifier extends $Notifier<DateTime?> {
  DateTime? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DateTime?, DateTime?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<DateTime?, DateTime?>, DateTime?, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(fastingDuration)
final fastingDurationProvider = FastingDurationProvider._();

final class FastingDurationProvider
    extends $FunctionalProvider<Duration, Duration, Duration>
    with $Provider<Duration> {
  FastingDurationProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'fastingDurationProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$fastingDurationHash();

  @$internal
  @override
  $ProviderElement<Duration> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Duration create(Ref ref) {
    return fastingDuration(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Duration value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Duration>(value),
    );
  }
}

String _$fastingDurationHash() => r'6bf732137faf994eea198e6df5e4ada44c18e01c';

@ProviderFor(fastingStage)
final fastingStageProvider = FastingStageProvider._();

final class FastingStageProvider
    extends $FunctionalProvider<FastingStage, FastingStage, FastingStage>
    with $Provider<FastingStage> {
  FastingStageProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'fastingStageProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$fastingStageHash();

  @$internal
  @override
  $ProviderElement<FastingStage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FastingStage create(Ref ref) {
    return fastingStage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FastingStage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FastingStage>(value),
    );
  }
}

String _$fastingStageHash() => r'4bdf666a6dd17eee6606021b285aeca956b1f581';
