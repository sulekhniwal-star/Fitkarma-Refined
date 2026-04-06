// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_goal_engine.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(nutritionGoals)
final nutritionGoalsProvider = NutritionGoalsProvider._();

final class NutritionGoalsProvider
    extends
        $FunctionalProvider<
          AsyncValue<NutritionGoalTargets>,
          NutritionGoalTargets,
          FutureOr<NutritionGoalTargets>
        >
    with
        $FutureModifier<NutritionGoalTargets>,
        $FutureProvider<NutritionGoalTargets> {
  NutritionGoalsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nutritionGoalsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nutritionGoalsHash();

  @$internal
  @override
  $FutureProviderElement<NutritionGoalTargets> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<NutritionGoalTargets> create(Ref ref) {
    return nutritionGoals(ref);
  }
}

String _$nutritionGoalsHash() => r'31b3684fa3af5eefaa291d5113c748ba7dba9965';
