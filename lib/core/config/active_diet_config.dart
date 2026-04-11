import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/festival_calendar/domain/festival_diet_engine.dart';
import '../../features/wedding/domain/wedding_diet_engine.dart';

part 'active_diet_config.g.dart';

class CombinedDietConfig {
  final int totalCalorieOffset;
  final List<String> allowedFoods;
  final List<String> forbiddenFoods;
  final bool workoutSuppressed;
  final List<String> insights;

  CombinedDietConfig({
    this.totalCalorieOffset = 0,
    this.allowedFoods = const [],
    this.forbiddenFoods = const [],
    this.workoutSuppressed = false,
    this.insights = const [],
  });
}

@riverpod
Future<CombinedDietConfig> activeDietConfig(Ref ref) async {
  final festivalsAsync = await ref.watch(festivalDietProviderProvider.future);
  final weddingAsync = await ref.watch(weddingDietProviderProvider.future);

  int calorieOffset = 0;
  bool workoutSuppressed = false;
  final List<String> allowed = [];
  final List<String> forbidden = [];
  final List<String> insights = [];

  // Wedding takes precedence for calorie targets
  if (weddingAsync != null) {
    calorieOffset = weddingAsync.calorieOffset;
    insights.add(weddingAsync.adviceEn);
    // Wedding doesn't usually suppress workouts unless explicitly stated
  } else if (festivalsAsync.isNotEmpty) {
    // Combine festival calorie multipliers (multiplicative or additive? usually one festival is dominant)
    // Let's use the most significant one
    double totalMultiplier = 1.0;
    for (final f in festivalsAsync) {
      if (f.calorieMultiplier < 0.9) {
        totalMultiplier = f.calorieMultiplier;
      } else if (f.calorieMultiplier > 1.1) totalMultiplier = f.calorieMultiplier;
    }
    // We'll apply this to a base 2000 kcal for now or just treat as offset
    if (totalMultiplier < 1.0) {
      calorieOffset = -350;
    } else if (totalMultiplier > 1.0) calorieOffset = 450;
  }

  // Festival fasting rules are informational if wedding is active, 
  // but we still track allowed/forbidden foods.
  for (final f in festivalsAsync) {
    if (f.workoutSuppressed) workoutSuppressed = true;
    allowed.addAll(f.allowedFoods);
    forbidden.addAll(f.forbiddenFoods);
    if (f.insightMessage.isNotEmpty) insights.add(f.insightMessage);
  }

  // Final merge logic for foods: prompt says union for allowed
  // For simplicity, we just return the lists.
  
  return CombinedDietConfig(
    totalCalorieOffset: calorieOffset,
    allowedFoods: allowed.toSet().toList(), // deduplicate
    forbiddenFoods: forbidden.toSet().toList(),
    workoutSuppressed: workoutSuppressed,
    insights: insights.toSet().toList(),
  );
}
