// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_worker.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SyncWorker)
final syncWorkerProvider = SyncWorkerProvider._();

final class SyncWorkerProvider extends $NotifierProvider<SyncWorker, bool> {
  SyncWorkerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'syncWorkerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$syncWorkerHash();

  @$internal
  @override
  SyncWorker create() => SyncWorker();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$syncWorkerHash() => r'4a7ba5b33cfa8188aa6c6df5a8a874125e2c300d';

abstract class _$SyncWorker extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(connectivityStream)
final connectivityStreamProvider = ConnectivityStreamProvider._();

final class ConnectivityStreamProvider extends $FunctionalProvider<
        AsyncValue<ConnectivityResult>,
        ConnectivityResult,
        Stream<ConnectivityResult>>
    with
        $FutureModifier<ConnectivityResult>,
        $StreamProvider<ConnectivityResult> {
  ConnectivityStreamProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'connectivityStreamProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$connectivityStreamHash();

  @$internal
  @override
  $StreamProviderElement<ConnectivityResult> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<ConnectivityResult> create(Ref ref) {
    return connectivityStream(ref);
  }
}

String _$connectivityStreamHash() =>
    r'2894935f798f4d0a2de919da66935d44ed0fd5db';

@ProviderFor(dlqCount)
final dlqCountProvider = DlqCountProvider._();

final class DlqCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  DlqCountProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'dlqCountProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$dlqCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return dlqCount(ref);
  }
}

String _$dlqCountHash() => r'e5724e56589ecd0d50f9ed7ba686bdd60adbd75b';

@ProviderFor(pendingSyncCount)
final pendingSyncCountProvider = PendingSyncCountProvider._();

final class PendingSyncCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  PendingSyncCountProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'pendingSyncCountProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$pendingSyncCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return pendingSyncCount(ref);
  }
}

String _$pendingSyncCountHash() => r'c7e9f0e3132a4c36c0fab34b69741c326ca66480';

@ProviderFor(SyncManager)
final syncManagerProvider = SyncManagerProvider._();

final class SyncManagerProvider extends $NotifierProvider<SyncManager, bool> {
  SyncManagerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'syncManagerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$syncManagerHash();

  @$internal
  @override
  SyncManager create() => SyncManager();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$syncManagerHash() => r'f74ae7b420cc731a0eecfecf18714204e8455058';

abstract class _$SyncManager extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
