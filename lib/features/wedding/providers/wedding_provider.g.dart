// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wedding_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activeWeddingPlanHash() => r'e92ffed975f6c48867ed793eaf1f3ee26ee0aee7';

/// See also [activeWeddingPlan].
@ProviderFor(activeWeddingPlan)
final activeWeddingPlanProvider =
    AutoDisposeStreamProvider<WeddingPlan?>.internal(
  activeWeddingPlan,
  name: r'activeWeddingPlanProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeWeddingPlanHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveWeddingPlanRef = AutoDisposeStreamProviderRef<WeddingPlan?>;
String _$weddingPhaseHash() => r'681bde028a86de29034f6e02d9798ac0415c5af5';

/// See also [weddingPhase].
@ProviderFor(weddingPhase)
final weddingPhaseProvider = AutoDisposeProvider<String>.internal(
  weddingPhase,
  name: r'weddingPhaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$weddingPhaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WeddingPhaseRef = AutoDisposeProviderRef<String>;
String _$weddingEventDietHash() => r'26c30b3ef79aa68021e0bf29da558bdb727998fd';

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

/// See also [weddingEventDiet].
@ProviderFor(weddingEventDiet)
const weddingEventDietProvider = WeddingEventDietFamily();

/// See also [weddingEventDiet].
class WeddingEventDietFamily extends Family<Map<String, dynamic>> {
  /// See also [weddingEventDiet].
  const WeddingEventDietFamily();

  /// See also [weddingEventDiet].
  WeddingEventDietProvider call(
    String eventKey,
  ) {
    return WeddingEventDietProvider(
      eventKey,
    );
  }

  @override
  WeddingEventDietProvider getProviderOverride(
    covariant WeddingEventDietProvider provider,
  ) {
    return call(
      provider.eventKey,
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
  String? get name => r'weddingEventDietProvider';
}

/// See also [weddingEventDiet].
class WeddingEventDietProvider
    extends AutoDisposeProvider<Map<String, dynamic>> {
  /// See also [weddingEventDiet].
  WeddingEventDietProvider(
    String eventKey,
  ) : this._internal(
          (ref) => weddingEventDiet(
            ref as WeddingEventDietRef,
            eventKey,
          ),
          from: weddingEventDietProvider,
          name: r'weddingEventDietProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$weddingEventDietHash,
          dependencies: WeddingEventDietFamily._dependencies,
          allTransitiveDependencies:
              WeddingEventDietFamily._allTransitiveDependencies,
          eventKey: eventKey,
        );

  WeddingEventDietProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.eventKey,
  }) : super.internal();

  final String eventKey;

  @override
  Override overrideWith(
    Map<String, dynamic> Function(WeddingEventDietRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WeddingEventDietProvider._internal(
        (ref) => create(ref as WeddingEventDietRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        eventKey: eventKey,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Map<String, dynamic>> createElement() {
    return _WeddingEventDietProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WeddingEventDietProvider && other.eventKey == eventKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WeddingEventDietRef on AutoDisposeProviderRef<Map<String, dynamic>> {
  /// The parameter `eventKey` of this provider.
  String get eventKey;
}

class _WeddingEventDietProviderElement
    extends AutoDisposeProviderElement<Map<String, dynamic>>
    with WeddingEventDietRef {
  _WeddingEventDietProviderElement(super.provider);

  @override
  String get eventKey => (origin as WeddingEventDietProvider).eventKey;
}

String _$weddingPlanNotifierHash() =>
    r'5328f8cdb5f9f79e4e52f80f92fff1c43b36c6fd';

/// See also [WeddingPlanNotifier].
@ProviderFor(WeddingPlanNotifier)
final weddingPlanNotifierProvider =
    AutoDisposeNotifierProvider<WeddingPlanNotifier, void>.internal(
  WeddingPlanNotifier.new,
  name: r'weddingPlanNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weddingPlanNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WeddingPlanNotifier = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
