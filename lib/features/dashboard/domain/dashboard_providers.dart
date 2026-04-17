import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/meal_tab_bar.dart';

// --- Placeholder Models ---

class InsightOutput {
  final String message;
  final bool isCorrelation;
  final List<dynamic>? modules; // Simplified for now
  InsightOutput({required this.message, this.isCorrelation = false, this.modules});
}

class KarmaData {
  final int level;
  final String title;
  final int currentXP;
  final int nextLevelXP;
  KarmaData({required this.level, required this.title, required this.currentXP, required this.nextLevelXP});
}

class FestivalData {
  final String name;
  final String nameHi;
  final int daysRemaining;
  final String fastingType;
  FestivalData({required this.name, required this.nameHi, required this.daysRemaining, required this.fastingType});
}

class WeddingEventData {
  final String role;
  final int daysToWedding;
  final String nextEventName;
  final int daysToNextEvent;
  WeddingEventData({required this.role, required this.daysToWedding, required this.nextEventName, required this.daysToNextEvent});
}

// --- Dashboard Providers (Mocked for UI Implementation) ---

final todayStepsProvider = FutureProvider<int>((ref) async {
  return 8540;
});

final todayCaloriesProvider = FutureProvider<double>((ref) async {
  return 1450.0;
});

final todayWaterProvider = FutureProvider<int>((ref) async {
  return 6;
});

final todayActiveMinutesProvider = FutureProvider<int>((ref) async {
  return 45;
});

final latestInsightProvider = FutureProvider<InsightOutput?>((ref) async {
  return InsightOutput(
    message: "You've been consistent with your water intake this week! Drinking more water helped improve your sleep quality by 12%.",
    isCorrelation: true,
  );
});

final selectedMealTabProvider = NotifierProvider<MealTabNotifier, MealType>(MealTabNotifier.new);

class MealTabNotifier extends Notifier<MealType> {
  @override
  MealType build() => MealType.breakfast;

  void setTab(MealType tab) {
    state = tab;
  }
}

final karmaProvider = FutureProvider<KarmaData>((ref) async {
  return KarmaData(level: 12, title: 'Health Warrior', currentXP: 1450, nextLevelXP: 2000);
});

final activeFestivalProvider = FutureProvider<FestivalData?>((ref) async {
  return FestivalData(name: 'Navratri', nameHi: 'नवरात्रि', daysRemaining: 3, fastingType: 'Fruitarian');
});

final activeWeddingProvider = FutureProvider<WeddingEventData?>((ref) async {
  return null; // For now
});

