// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diet_conflict_resolver.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dietConflictInsight)
final dietConflictInsightProvider = DietConflictInsightProvider._();

final class DietConflictInsightProvider
    extends
        $FunctionalProvider<
          AsyncValue<ConflictInsight?>,
          ConflictInsight?,
          FutureOr<ConflictInsight?>
        >
    with $FutureModifier<ConflictInsight?>, $FutureProvider<ConflictInsight?> {
  DietConflictInsightProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dietConflictInsightProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dietConflictInsightHash();

  @$internal
  @override
  $FutureProviderElement<ConflictInsight?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ConflictInsight?> create(Ref ref) {
    return dietConflictInsight(ref);
  }
}

String _$dietConflictInsightHash() =>
    r'049bc3483e564e4695df95f05a0c23a5f22ddbc3';
