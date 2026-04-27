// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$socialRealtimeHash() => r'd72d61e86c5013326eb655323ddb553b4e0242bd';

/// See also [socialRealtime].
@ProviderFor(socialRealtime)
final socialRealtimeProvider = AutoDisposeStreamProvider<void>.internal(
  socialRealtime,
  name: r'socialRealtimeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$socialRealtimeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SocialRealtimeRef = AutoDisposeStreamProviderRef<void>;
String _$groupsHash() => r'd09848af0e60db6e1858c571c012e3731006df1d';

/// See also [groups].
@ProviderFor(groups)
final groupsProvider = AutoDisposeStreamProvider<List<CommunityGroup>>.internal(
  groups,
  name: r'groupsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$groupsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GroupsRef = AutoDisposeStreamProviderRef<List<CommunityGroup>>;
String _$myGroupsHash() => r'80aecceb69991d9da452ade98f468df08f9e4399';

/// See also [myGroups].
@ProviderFor(myGroups)
final myGroupsProvider =
    AutoDisposeStreamProvider<List<CommunityGroup>>.internal(
  myGroups,
  name: r'myGroupsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$myGroupsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyGroupsRef = AutoDisposeStreamProviderRef<List<CommunityGroup>>;
String _$socialFeedNotifierHash() =>
    r'957d7565d618771632ec234b170068444e8b289a';

/// See also [SocialFeedNotifier].
@ProviderFor(SocialFeedNotifier)
final socialFeedNotifierProvider = AutoDisposeStreamNotifierProvider<
    SocialFeedNotifier, List<SocialPost>>.internal(
  SocialFeedNotifier.new,
  name: r'socialFeedNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$socialFeedNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SocialFeedNotifier = AutoDisposeStreamNotifier<List<SocialPost>>;
String _$groupsNotifierHash() => r'e9e66cb1361a01b6e52723147a7cc3d6b1ae9fc4';

/// See also [GroupsNotifier].
@ProviderFor(GroupsNotifier)
final groupsNotifierProvider =
    AutoDisposeNotifierProvider<GroupsNotifier, void>.internal(
  GroupsNotifier.new,
  name: r'groupsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$groupsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GroupsNotifier = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
