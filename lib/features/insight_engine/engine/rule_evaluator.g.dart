// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_evaluator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Riverpod provider that exposes the insight list for a given userId.

@ProviderFor(insightEngine)
final insightEngineProvider = InsightEngineFamily._();

/// Riverpod provider that exposes the insight list for a given userId.

final class InsightEngineProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<InsightOutput>>,
          List<InsightOutput>,
          FutureOr<List<InsightOutput>>
        >
    with
        $FutureModifier<List<InsightOutput>>,
        $FutureProvider<List<InsightOutput>> {
  /// Riverpod provider that exposes the insight list for a given userId.
  InsightEngineProvider._({
    required InsightEngineFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'insightEngineProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$insightEngineHash();

  @override
  String toString() {
    return r'insightEngineProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<InsightOutput>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<InsightOutput>> create(Ref ref) {
    final argument = this.argument as String;
    return insightEngine(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is InsightEngineProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$insightEngineHash() => r'c97e98187d61d60638182209e8ff5b11302769e4';

/// Riverpod provider that exposes the insight list for a given userId.

final class InsightEngineFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<InsightOutput>>, String> {
  InsightEngineFamily._()
    : super(
        retry: null,
        name: r'insightEngineProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Riverpod provider that exposes the insight list for a given userId.

  InsightEngineProvider call(String userId) =>
      InsightEngineProvider._(argument: userId, from: this);

  @override
  String toString() => r'insightEngineProvider';
}
