// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$labReportsHash() => r'770df5da23335fd3e93666f972ae9df27201a121';

/// See also [labReports].
@ProviderFor(labReports)
final labReportsProvider = AutoDisposeStreamProvider<List<LabReport>>.internal(
  labReports,
  name: r'labReportsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$labReportsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LabReportsRef = AutoDisposeStreamProviderRef<List<LabReport>>;
String _$shareLinkHash() => r'89c2ef057f08f714d70a811f7004f3158d53260b';

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

/// See also [shareLink].
@ProviderFor(shareLink)
const shareLinkProvider = ShareLinkFamily();

/// See also [shareLink].
class ShareLinkFamily extends Family<AsyncValue<String>> {
  /// See also [shareLink].
  const ShareLinkFamily();

  /// See also [shareLink].
  ShareLinkProvider call(
    String reportId,
  ) {
    return ShareLinkProvider(
      reportId,
    );
  }

  @override
  ShareLinkProvider getProviderOverride(
    covariant ShareLinkProvider provider,
  ) {
    return call(
      provider.reportId,
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
  String? get name => r'shareLinkProvider';
}

/// See also [shareLink].
class ShareLinkProvider extends AutoDisposeFutureProvider<String> {
  /// See also [shareLink].
  ShareLinkProvider(
    String reportId,
  ) : this._internal(
          (ref) => shareLink(
            ref as ShareLinkRef,
            reportId,
          ),
          from: shareLinkProvider,
          name: r'shareLinkProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$shareLinkHash,
          dependencies: ShareLinkFamily._dependencies,
          allTransitiveDependencies: ShareLinkFamily._allTransitiveDependencies,
          reportId: reportId,
        );

  ShareLinkProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.reportId,
  }) : super.internal();

  final String reportId;

  @override
  Override overrideWith(
    FutureOr<String> Function(ShareLinkRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ShareLinkProvider._internal(
        (ref) => create(ref as ShareLinkRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        reportId: reportId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _ShareLinkProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ShareLinkProvider && other.reportId == reportId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, reportId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ShareLinkRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `reportId` of this provider.
  String get reportId;
}

class _ShareLinkProviderElement extends AutoDisposeFutureProviderElement<String>
    with ShareLinkRef {
  _ShareLinkProviderElement(super.provider);

  @override
  String get reportId => (origin as ShareLinkProvider).reportId;
}

String _$healthReportHash() => r'604e025f80b91e874c925a5c2f0f3632d3f8973b';

/// See also [healthReport].
@ProviderFor(healthReport)
const healthReportProvider = HealthReportFamily();

/// See also [healthReport].
class HealthReportFamily extends Family<Map<String, dynamic>> {
  /// See also [healthReport].
  const HealthReportFamily();

  /// See also [healthReport].
  HealthReportProvider call(
    String period,
  ) {
    return HealthReportProvider(
      period,
    );
  }

  @override
  HealthReportProvider getProviderOverride(
    covariant HealthReportProvider provider,
  ) {
    return call(
      provider.period,
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
  String? get name => r'healthReportProvider';
}

/// See also [healthReport].
class HealthReportProvider extends AutoDisposeProvider<Map<String, dynamic>> {
  /// See also [healthReport].
  HealthReportProvider(
    String period,
  ) : this._internal(
          (ref) => healthReport(
            ref as HealthReportRef,
            period,
          ),
          from: healthReportProvider,
          name: r'healthReportProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$healthReportHash,
          dependencies: HealthReportFamily._dependencies,
          allTransitiveDependencies:
              HealthReportFamily._allTransitiveDependencies,
          period: period,
        );

  HealthReportProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.period,
  }) : super.internal();

  final String period;

  @override
  Override overrideWith(
    Map<String, dynamic> Function(HealthReportRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HealthReportProvider._internal(
        (ref) => create(ref as HealthReportRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        period: period,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Map<String, dynamic>> createElement() {
    return _HealthReportProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HealthReportProvider && other.period == period;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, period.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HealthReportRef on AutoDisposeProviderRef<Map<String, dynamic>> {
  /// The parameter `period` of this provider.
  String get period;
}

class _HealthReportProviderElement
    extends AutoDisposeProviderElement<Map<String, dynamic>>
    with HealthReportRef {
  _HealthReportProviderElement(super.provider);

  @override
  String get period => (origin as HealthReportProvider).period;
}

String _$labReportNotifierHash() => r'ef7a7a1ec9f0b6bbc39ec641c8a15c11ec76c114';

/// See also [LabReportNotifier].
@ProviderFor(LabReportNotifier)
final labReportNotifierProvider =
    AutoDisposeNotifierProvider<LabReportNotifier, void>.internal(
  LabReportNotifier.new,
  name: r'labReportNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$labReportNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LabReportNotifier = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
