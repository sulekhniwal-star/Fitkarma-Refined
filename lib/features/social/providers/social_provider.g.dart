// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SocialFeedNotifier)
final socialFeedProvider = SocialFeedNotifierProvider._();

final class SocialFeedNotifierProvider
    extends $StreamNotifierProvider<SocialFeedNotifier, List<dynamic>> {
  SocialFeedNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'socialFeedProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$socialFeedNotifierHash();

  @$internal
  @override
  SocialFeedNotifier create() => SocialFeedNotifier();
}

String _$socialFeedNotifierHash() =>
    r'48f821f229169b7ea531deb587e99d995c46124e';

abstract class _$SocialFeedNotifier extends $StreamNotifier<List<dynamic>> {
  Stream<List<dynamic>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<dynamic>>, List<dynamic>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<dynamic>>, List<dynamic>>,
        AsyncValue<List<dynamic>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(socialRealtime)
final socialRealtimeProvider = SocialRealtimeProvider._();

final class SocialRealtimeProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  SocialRealtimeProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'socialRealtimeProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$socialRealtimeHash();

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    return socialRealtime(ref);
  }
}

String _$socialRealtimeHash() => r'a15c57b518004c6dc4563fb58e7b6608689af2c3';

@ProviderFor(communityGroups)
final communityGroupsProvider = CommunityGroupsProvider._();

final class CommunityGroupsProvider extends $FunctionalProvider<
        AsyncValue<List<dynamic>>, List<dynamic>, Stream<List<dynamic>>>
    with $FutureModifier<List<dynamic>>, $StreamProvider<List<dynamic>> {
  CommunityGroupsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'communityGroupsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$communityGroupsHash();

  @$internal
  @override
  $StreamProviderElement<List<dynamic>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<dynamic>> create(Ref ref) {
    return communityGroups(ref);
  }
}

String _$communityGroupsHash() => r'3ebe8c7dd729903619d9b487a73aa41bb66eac95';

@ProviderFor(myGroups)
final myGroupsProvider = MyGroupsProvider._();

final class MyGroupsProvider extends $FunctionalProvider<
        AsyncValue<List<dynamic>>, List<dynamic>, Stream<List<dynamic>>>
    with $FutureModifier<List<dynamic>>, $StreamProvider<List<dynamic>> {
  MyGroupsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'myGroupsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$myGroupsHash();

  @$internal
  @override
  $StreamProviderElement<List<dynamic>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<dynamic>> create(Ref ref) {
    return myGroups(ref);
  }
}

String _$myGroupsHash() => r'5a6696258a361f109440a9d90dd695b025407d93';

@ProviderFor(GroupsNotifier)
final groupsProvider = GroupsNotifierProvider._();

final class GroupsNotifierProvider
    extends $NotifierProvider<GroupsNotifier, void> {
  GroupsNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'groupsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$groupsNotifierHash();

  @$internal
  @override
  GroupsNotifier create() => GroupsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$groupsNotifierHash() => r'e9e66cb1361a01b6e52723147a7cc3d6b1ae9fc4';

abstract class _$GroupsNotifier extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<void, void>, void, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
