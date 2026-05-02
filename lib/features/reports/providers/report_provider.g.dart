// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LabReportNotifier)
final labReportProvider = LabReportNotifierProvider._();

final class LabReportNotifierProvider
    extends $NotifierProvider<LabReportNotifier, bool> {
  LabReportNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'labReportProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$labReportNotifierHash();

  @$internal
  @override
  LabReportNotifier create() => LabReportNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$labReportNotifierHash() => r'e008bc20733863112039580d794ea0c0442db454';

abstract class _$LabReportNotifier extends $Notifier<bool> {
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

@ProviderFor(labReports)
final labReportsProvider = LabReportsProvider._();

final class LabReportsProvider extends $FunctionalProvider<
        AsyncValue<List<dynamic>>, List<dynamic>, Stream<List<dynamic>>>
    with $FutureModifier<List<dynamic>>, $StreamProvider<List<dynamic>> {
  LabReportsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'labReportsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$labReportsHash();

  @$internal
  @override
  $StreamProviderElement<List<dynamic>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<dynamic>> create(Ref ref) {
    return labReports(ref);
  }
}

String _$labReportsHash() => r'752901f496246d17b4b564bef694a0a61b9b77c7';

@ProviderFor(shareLink)
final shareLinkProvider = ShareLinkFamily._();

final class ShareLinkProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  ShareLinkProvider._(
      {required ShareLinkFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'shareLinkProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$shareLinkHash();

  @override
  String toString() {
    return r'shareLinkProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument = this.argument as String;
    return shareLink(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ShareLinkProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$shareLinkHash() => r'b9c3237bb8fb21ff1ebe0a436b341d00be46c871';

final class ShareLinkFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, String> {
  ShareLinkFamily._()
      : super(
          retry: null,
          name: r'shareLinkProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ShareLinkProvider call(
    String reportId,
  ) =>
      ShareLinkProvider._(argument: reportId, from: this);

  @override
  String toString() => r'shareLinkProvider';
}

@ProviderFor(healthReport)
final healthReportProvider = HealthReportFamily._();

final class HealthReportProvider extends $FunctionalProvider<
        AsyncValue<Map<String, Object?>>,
        Map<String, Object?>,
        FutureOr<Map<String, Object?>>>
    with
        $FutureModifier<Map<String, Object?>>,
        $FutureProvider<Map<String, Object?>> {
  HealthReportProvider._(
      {required HealthReportFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'healthReportProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$healthReportHash();

  @override
  String toString() {
    return r'healthReportProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Map<String, Object?>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, Object?>> create(Ref ref) {
    final argument = this.argument as String;
    return healthReport(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HealthReportProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$healthReportHash() => r'e32f8713e265cfb463d53093f514bac3bff75ca2';

final class HealthReportFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Map<String, Object?>>, String> {
  HealthReportFamily._()
      : super(
          retry: null,
          name: r'healthReportProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  HealthReportProvider call(
    String period,
  ) =>
      HealthReportProvider._(argument: period, from: this);

  @override
  String toString() => r'healthReportProvider';
}
