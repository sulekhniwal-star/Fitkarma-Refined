// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'karma_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(karmaService)
final karmaServiceProvider = KarmaServiceProvider._();

final class KarmaServiceProvider
    extends $FunctionalProvider<KarmaService, KarmaService, KarmaService>
    with $Provider<KarmaService> {
  KarmaServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'karmaServiceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$karmaServiceHash();

  @$internal
  @override
  $ProviderElement<KarmaService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  KarmaService create(Ref ref) {
    return karmaService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KarmaService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KarmaService>(value),
    );
  }
}

String _$karmaServiceHash() => r'2eb5dd7a0b124084510ee7b9b1f082ec65d6830c';

@ProviderFor(XpFloatNotifier)
final xpFloatProvider = XpFloatNotifierProvider._();

final class XpFloatNotifierProvider
    extends $NotifierProvider<XpFloatNotifier, List<int>> {
  XpFloatNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'xpFloatProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$xpFloatNotifierHash();

  @$internal
  @override
  XpFloatNotifier create() => XpFloatNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<int> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<int>>(value),
    );
  }
}

String _$xpFloatNotifierHash() => r'1e2da30d9af5c988a8e101ee414fef93f0fd57ab';

abstract class _$XpFloatNotifier extends $Notifier<List<int>> {
  List<int> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<int>, List<int>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<int>, List<int>>, List<int>, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(userKarma)
final userKarmaProvider = UserKarmaProvider._();

final class UserKarmaProvider
    extends $FunctionalProvider<AsyncValue<dynamic>, dynamic, Stream<dynamic>>
    with $FutureModifier<dynamic>, $StreamProvider<dynamic> {
  UserKarmaProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userKarmaProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userKarmaHash();

  @$internal
  @override
  $StreamProviderElement<dynamic> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<dynamic> create(Ref ref) {
    return userKarma(ref);
  }
}

String _$userKarmaHash() => r'a550833cccef8984ec57d9b8f90aef28427671ac';

@ProviderFor(leaderboard)
final leaderboardProvider = LeaderboardFamily._();

final class LeaderboardProvider extends $FunctionalProvider<
        AsyncValue<List<Map<String, dynamic>>>,
        List<Map<String, dynamic>>,
        FutureOr<List<Map<String, dynamic>>>>
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  LeaderboardProvider._(
      {required LeaderboardFamily super.from,
      required LeaderboardType super.argument})
      : super(
          retry: null,
          name: r'leaderboardProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$leaderboardHash();

  @override
  String toString() {
    return r'leaderboardProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    final argument = this.argument as LeaderboardType;
    return leaderboard(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is LeaderboardProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$leaderboardHash() => r'1fac6f961259bac5c41bc6dd29732b0c056e8a02';

final class LeaderboardFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<List<Map<String, dynamic>>>,
            LeaderboardType> {
  LeaderboardFamily._()
      : super(
          retry: null,
          name: r'leaderboardProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  LeaderboardProvider call(
    LeaderboardType type,
  ) =>
      LeaderboardProvider._(argument: type, from: this);

  @override
  String toString() => r'leaderboardProvider';
}
