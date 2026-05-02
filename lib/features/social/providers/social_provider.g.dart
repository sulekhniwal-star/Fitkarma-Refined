// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SocialFeedNotifier)
final socialFeedProvider = SocialFeedNotifierFamily._();

final class SocialFeedNotifierProvider
    extends $StreamNotifierProvider<SocialFeedNotifier, List<dynamic>> {
  SocialFeedNotifierProvider._(
      {required SocialFeedNotifierFamily super.from,
      required ({
        int limit,
        int offset,
      })
          super.argument})
      : super(
          retry: null,
          name: r'socialFeedProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$socialFeedNotifierHash();

  @override
  String toString() {
    return r'socialFeedProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  SocialFeedNotifier create() => SocialFeedNotifier();

  @override
  bool operator ==(Object other) {
    return other is SocialFeedNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$socialFeedNotifierHash() =>
    r'763e757e8b36c51117c00c0cc3db175a578545fa';

final class SocialFeedNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
            SocialFeedNotifier,
            AsyncValue<List<dynamic>>,
            List<dynamic>,
            Stream<List<dynamic>>,
            ({
              int limit,
              int offset,
            })> {
  SocialFeedNotifierFamily._()
      : super(
          retry: null,
          name: r'socialFeedProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  SocialFeedNotifierProvider call({
    int limit = 20,
    int offset = 0,
  }) =>
      SocialFeedNotifierProvider._(argument: (
        limit: limit,
        offset: offset,
      ), from: this);

  @override
  String toString() => r'socialFeedProvider';
}

abstract class _$SocialFeedNotifier extends $StreamNotifier<List<dynamic>> {
  late final _$args = ref.$arg as ({
    int limit,
    int offset,
  });
  int get limit => _$args.limit;
  int get offset => _$args.offset;

  Stream<List<dynamic>> build({
    int limit = 20,
    int offset = 0,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<dynamic>>, List<dynamic>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<dynamic>>, List<dynamic>>,
        AsyncValue<List<dynamic>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              limit: _$args.limit,
              offset: _$args.offset,
            ));
  }
}

@ProviderFor(socialRealtime)
final socialRealtimeProvider = SocialRealtimeProvider._();

final class SocialRealtimeProvider extends $FunctionalProvider<
        AsyncValue<RealtimeMessage>, RealtimeMessage, Stream<RealtimeMessage>>
    with $FutureModifier<RealtimeMessage>, $StreamProvider<RealtimeMessage> {
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
  $StreamProviderElement<RealtimeMessage> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<RealtimeMessage> create(Ref ref) {
    return socialRealtime(ref);
  }
}

String _$socialRealtimeHash() => r'22fc2a519d2d625859badf66cb0657e038156beb';

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
