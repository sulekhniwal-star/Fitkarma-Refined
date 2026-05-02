import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'insight_provider.g.dart';

@riverpod
class CorrelationEngine extends _$CorrelationEngine {
  @override
  void build() {}

  Future<String?> sleepMoodInsight() async {
    final sleep = await ref.read(sleepHistoryProvider(14).future);
    final mood = await ref.read(moodHistoryProvider(14).future);

    if (sleep.length < 5 || mood.length < 5) return null;

    final avgSleep = sleep.map((e) => e.durationMinutes).average / 60.0;
    final avgMood = mood.map((e) => e.moodScore ?? 5).average;

    if (avgSleep < 6 && avgMood < 6) {
      return "Low sleep (avg ${avgSleep.toStringAsFixed(1)}h) is correlating with lower mood. Try getting 7+ hours tonight.";
    }
    return "Your mood seems stable with your current sleep patterns.";
  }

  Future<String?> stepsEnergyInsight() async {
    final stepsHistory = await ref.read(stepHistoryProvider(7).future);
    final moodHistory = await ref.read(moodHistoryProvider(7).future);

    if (stepsHistory.length < 3 || moodHistory.length < 3) return null;

    final avgSteps = stepsHistory.map((e) => e.count).average;
    final avgMood = moodHistory.map((e) => e.moodScore ?? 5).average;

    if (avgSteps > 8000 && avgMood > 7) {
      return "Great job! High activity (avg ${avgSteps.toInt()} steps) is strongly linked to your peak mood scores.";
    }
    return null;
  }

  Future<String?> foodGlucoseInsight() async {
    // Requires matching food timestamps with glucose readings
    // Logic: Look for glucose readings taken 1-2 hours after high carb food logs
    return null; 
  }
}

@riverpod
Future<String> dashboardInsight(Ref ref) async {
  final engine = ref.read(correlationEngineProvider.notifier);
  
  final sleepMood = await engine.sleepMoodInsight();
  if (sleepMood != null) return sleepMood;

  final stepsEnergy = await engine.stepsEnergyInsight();
  if (stepsEnergy != null) return stepsEnergy;

  return "Consistency is key! Log more data to unlock deeper personalized insights.";
}
