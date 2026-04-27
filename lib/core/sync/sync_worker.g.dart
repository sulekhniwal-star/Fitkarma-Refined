// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_worker.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$connectivityStreamHash() =>
    r'16fc017b7071ec671b89b1f0b229f3f965f138a9';

/// See also [connectivityStream].
@ProviderFor(connectivityStream)
final connectivityStreamProvider =
    AutoDisposeStreamProvider<ConnectivityResult>.internal(
  connectivityStream,
  name: r'connectivityStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$connectivityStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConnectivityStreamRef
    = AutoDisposeStreamProviderRef<ConnectivityResult>;
String _$dlqCountHash() => r'81d90bccf9941b72559936d0b3cbc665539b7ab1';

/// See also [dlqCount].
@ProviderFor(dlqCount)
final dlqCountProvider = AutoDisposeFutureProvider<int>.internal(
  dlqCount,
  name: r'dlqCountProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dlqCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DlqCountRef = AutoDisposeFutureProviderRef<int>;
String _$pendingSyncCountHash() => r'9c1e4971d2acffad3afce99f77d4d1ec14da7dd7';

/// See also [pendingSyncCount].
@ProviderFor(pendingSyncCount)
final pendingSyncCountProvider = AutoDisposeFutureProvider<int>.internal(
  pendingSyncCount,
  name: r'pendingSyncCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pendingSyncCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PendingSyncCountRef = AutoDisposeFutureProviderRef<int>;
String _$syncManagerHash() => r'4b9da29abd145d0038fca4533924052179561e1c';

/// See also [syncManager].
@ProviderFor(syncManager)
final syncManagerProvider = AutoDisposeProvider<void>.internal(
  syncManager,
  name: r'syncManagerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$syncManagerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SyncManagerRef = AutoDisposeProviderRef<void>;
String _$syncWorkerHash() => r'72248529286510a4e45c4aeada6230f947f5588f';

/// See also [SyncWorker].
@ProviderFor(SyncWorker)
final syncWorkerProvider =
    AutoDisposeNotifierProvider<SyncWorker, void>.internal(
  SyncWorker.new,
  name: r'syncWorkerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$syncWorkerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SyncWorker = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
