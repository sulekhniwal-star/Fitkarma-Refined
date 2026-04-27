// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'karma_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$karmaServiceHash() => r'cbb04db19f41203cf3f9410a88da64245bf5b1cc';

/// See also [karmaService].
@ProviderFor(karmaService)
final karmaServiceProvider = AutoDisposeProvider<KarmaService>.internal(
  karmaService,
  name: r'karmaServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$karmaServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef KarmaServiceRef = AutoDisposeProviderRef<KarmaService>;
String _$userKarmaHash() => r'99799e73b7ad1e0b0f0db96f8665ac28373c9970';

/// See also [userKarma].
@ProviderFor(userKarma)
final userKarmaProvider = AutoDisposeStreamProvider<UserProfile?>.internal(
  userKarma,
  name: r'userKarmaProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userKarmaHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserKarmaRef = AutoDisposeStreamProviderRef<UserProfile?>;
String _$leaderboardHash() => r'ab99a2bad340a7f076f3371d9339f2bafd8bad41';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [leaderboard].
@ProviderFor(leaderboard)
const leaderboardProvider = LeaderboardFamily();

/// See also [leaderboard].
class LeaderboardFamily extends Family<AsyncValue<List<dynamic>>> {
  /// See also [leaderboard].
  const LeaderboardFamily();

  /// See also [leaderboard].
  LeaderboardProvider call(
    String type,
  ) {
    return LeaderboardProvider(
      type,
    );
  }

  @override
  LeaderboardProvider getProviderOverride(
    covariant LeaderboardProvider provider,
  ) {
    return call(
      provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'leaderboardProvider';
}

/// See also [leaderboard].
class LeaderboardProvider extends AutoDisposeFutureProvider<List<dynamic>> {
  /// See also [leaderboard].
  LeaderboardProvider(
    String type,
  ) : this._internal(
          (ref) => leaderboard(
            ref as LeaderboardRef,
            type,
          ),
          from: leaderboardProvider,
          name: r'leaderboardProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$leaderboardHash,
          dependencies: LeaderboardFamily._dependencies,
          allTransitiveDependencies:
              LeaderboardFamily._allTransitiveDependencies,
          type: type,
        );

  LeaderboardProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final String type;

  @override
  Override overrideWith(
    FutureOr<List<dynamic>> Function(LeaderboardRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LeaderboardProvider._internal(
        (ref) => create(ref as LeaderboardRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<dynamic>> createElement() {
    return _LeaderboardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LeaderboardProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LeaderboardRef on AutoDisposeFutureProviderRef<List<dynamic>> {
  /// The parameter `type` of this provider.
  String get type;
}

class _LeaderboardProviderElement
    extends AutoDisposeFutureProviderElement<List<dynamic>>
    with LeaderboardRef {
  _LeaderboardProviderElement(super.provider);

  @override
  String get type => (origin as LeaderboardProvider).type;
}

String _$xpFloatNotifierHash() => r'1e2da30d9af5c988a8e101ee414fef93f0fd57ab';

/// See also [XpFloatNotifier].
@ProviderFor(XpFloatNotifier)
final xpFloatNotifierProvider =
    AutoDisposeNotifierProvider<XpFloatNotifier, List<int>>.internal(
  XpFloatNotifier.new,
  name: r'xpFloatNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$xpFloatNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$XpFloatNotifier = AutoDisposeNotifier<List<int>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
