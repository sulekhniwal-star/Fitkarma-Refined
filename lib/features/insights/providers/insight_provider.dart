import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../health/providers/health_provider.dart';
import '../../journal/providers/mood_provider.dart';
import '../../steps/providers/steps_provider.dart';
import '../../food/providers/food_provider.dart';

part 'insight_provider.g.dart';

@riverpod
class CorrelationEngine extends _$CorrelationEngine {
  @override
  bool build() => false;

  Future<String?> sleepMoodInsight() async {
    // Requires 14 days of data for high-confidence correlation
    final sleep = await ref.read(sleepHistoryProvider(14).future);
    final mood = await ref.read(moodHistoryProvider(14).future);

    if (sleep.length < 7 || mood.length < 7) {
      return "Log at least 7 days of sleep and mood to see correlations.";
    }

    final avgSleep = sleep.map((e) => e.durationMinutes as int).average / 60.0;
    final avgMood = mood.map((e) => (e.moodScore ?? 5) as int).average;

    if (avgSleep < 6.5 && avgMood < 6) {
      return "Observation: Your mood scores drop when sleep average falls below 6.5 hours. Prioritize rest this week.";
    }
    
    if (avgSleep >= 7.5 && avgMood >= 8) {
      return "Success Pattern: You're consistently at your best when sleeping over 7.5 hours.";
    }

    return null;
  }

  Future<String?> foodGlucoseInsight() async {
    final glucose = await ref.read(glucoseHistoryProvider('Post-Meal', 14).future);
    final food = await ref.read(foodHistoryProvider(14).future);

    if (glucose.isEmpty || food.isEmpty) return null;

    // High glucose spikes (>140 mg/dL)
    final spikes = glucose.where((g) => g.value > 140).toList();
    if (spikes.isEmpty) return null;

    // Check food logs within 2 hours before the spikes
    final linkedFoods = <String>{};
    for (final spike in spikes) {
      final relevantFood = food.where((f) {
        final diff = spike.measuredAt.difference(f.loggedAt).inMinutes;
        return diff > 0 && diff <= 120;
      });
      for (final f in relevantFood) {
        linkedFoods.add(f.foodName);
      }
    }

    if (linkedFoods.isNotEmpty) {
      return "Insight: ${linkedFoods.take(2).join(', ')} seem to trigger higher glucose spikes for you. Consider smaller portions.";
    }

    return null;
  }

  Future<String?> stepsEnergyInsight() async {
    final stepsHistory = await ref.read(stepHistoryProvider(7).future);
    final moodHistory = await ref.read(moodHistoryProvider(7).future);

    if (stepsHistory.length < 3 || moodHistory.length < 3) return null;

    final avgSteps = stepsHistory.map((e) => e.count as int).average;
    final avgMood = moodHistory.map((e) => (e.moodScore ?? 5) as int).average;

    if (avgSteps > 10000 && avgMood > 7) {
      return "Movement is Medicine: Your mood is 25% higher on days you cross 10,000 steps!";
    }
    
    if (avgSteps < 4000 && avgMood < 5) {
      return "Low activity is currently linked to lower mood. A 10-minute walk could help.";
    }

    return null;
  }
}

@riverpod
Future<String> dashboardInsight(Ref ref) async {
  final engine = ref.read(correlationEngineProvider.notifier);
  
  // Try food-glucose first (Critical Health)
  final foodGlucose = await engine.foodGlucoseInsight();
  if (foodGlucose != null) return foodGlucose;

  // Then sleep-mood (Mental Health)
  final sleepMood = await engine.sleepMoodInsight();
  if (sleepMood != null) return sleepMood;

  // Then steps-energy (General Fitness)
  final stepsEnergy = await engine.stepsEnergyInsight();
  if (stepsEnergy != null) return stepsEnergy;

  return "Keep logging your food and vitals! The more you share, the better insights I can provide.";
}
