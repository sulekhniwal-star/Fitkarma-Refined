import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/domain/auth_providers.dart';
import '../../nutrition/data/water_repository.dart';
import '../../../shared/widgets/meal_tab_bar.dart';
import '../../../core/di/providers.dart';
import '../../festival/presentation/festival_providers.dart';
import '../../karma/data/karma_repository.dart';

// --- Dashboard Models ---

class InsightOutput {
  final String message;
  final bool isCorrelation;
  final List<dynamic>? modules;
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

// --- Dashboard Providers (Connected to Real Data) ---

final todayStepsProvider = StreamProvider<int>((ref) {
  final userId = ref.watch(authStateProvider).value?.id;
  if (userId == null) return Stream.value(0);
  
  final dao = ref.watch(healthDaoProvider);
  final now = DateTime.now();
  final start = DateTime(now.year, now.month, now.day);
  final end = start.add(const Duration(days: 1));
  
  return dao.watchSteps(userId, start, end).map((logs) =>
    logs.fold(0, (sum, log) => sum + log.stepCount)
  );
});

final todayCaloriesProvider = StreamProvider<double>((ref) {
  final userId = ref.watch(authStateProvider).value?.id;
  if (userId == null) return Stream.value(0.0);
  
  final dao = ref.watch(foodDaoProvider);
  return dao.getTodayLogs(userId, DateTime.now()).map((logs) =>
    logs.fold(0.0, (sum, log) => sum + log.calories)
  );
});

final todayWaterProvider = FutureProvider<int>((ref) async {
  final userId = ref.watch(authStateProvider).value?.id;
  if (userId == null) return 0;
  final repo = ref.watch(waterRepositoryProvider);
  return repo.getTotalDailyWater(userId, DateTime.now());
});

final todayActiveMinutesProvider = FutureProvider<int>((ref) async {
  final userId = ref.watch(authStateProvider).value?.id;
  if (userId == null) return 0;
  
  final dao = ref.watch(healthDaoProvider);
  final workouts = await dao.getRecentWorkouts(userId, 20);
  
  final today = DateTime.now();
  final todayWorkouts = workouts.where((w) => 
    w.loggedAt.year == today.year && 
    w.loggedAt.month == today.month && 
    w.loggedAt.day == today.day
  );
  
  return todayWorkouts.fold<int>(0, (sum, w) => sum + w.durationMin);
});

final latestInsightProvider = FutureProvider<InsightOutput?>((ref) async {
  // Placeholder until Insight Engine is fully connected
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
  final userId = ref.watch(authStateProvider).value?.id;
  if (userId == null) return KarmaData(level: 1, title: 'Seedling', currentXP: 0, nextLevelXP: 100);
  
  final userDao = ref.watch(userDaoProvider);
  final user = await userDao.getUser(userId);
  final repo = ref.watch(karmaRepositoryProvider);
  
  final xp = user?.karmaTotal ?? 0;
  final level = user?.karmaLevel ?? 1;
  
  // Simple XP for next level calculation (quadratic matching repository)
  // threshold = 41.65 * (level)^2
  final nextLevelXP = (41.65 * level * level).toInt();
  
  return KarmaData(
    level: level,
    title: repo.getLevelTitle(level),
    currentXP: xp,
    nextLevelXP: nextLevelXP,
  );
});

final activeFestivalProvider = FutureProvider<FestivalData?>((ref) async {
  final repo = ref.watch(festivalRepositoryProvider);
  final festival = await repo.getCurrentFestival();
  
  if (festival == null) return null;
  
  final now = DateTime.now();
  final daysRemaining = festival.startDate.isAfter(now) 
    ? festival.startDate.difference(now).inDays 
    : 0;

  return FestivalData(
    name: festival.nameEn,
    nameHi: festival.nameHi,
    daysRemaining: daysRemaining,
    fastingType: festival.fastingType ?? 'No Restriction',
  );
});

final activeWeddingProvider = FutureProvider<WeddingEventData?>((ref) async {
  // Placeholder until Wedding Repository is implemented
  return null;
});
