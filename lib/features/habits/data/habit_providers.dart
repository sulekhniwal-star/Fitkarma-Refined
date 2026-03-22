// lib/features/habits/data/habit_providers.dart
// Riverpod providers for Habits feature

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';
import 'package:fitkarma/features/dashboard/data/dashboard_providers.dart';
import 'package:fitkarma/features/habits/data/habit_drift_service.dart';
import 'package:fitkarma/features/habits/data/habit_models.dart';
import 'package:fitkarma/features/karma/data/karma_drift_service.dart';
import 'package:fitkarma/features/karma/data/karma_providers.dart';

/// Provider for the current user ID
final habitUserIdProvider = FutureProvider<String?>((ref) async {
  final authService = AuthAwService();
  return await authService.getStoredUserId();
});

/// Provider for habit drift service
final habitDriftServiceProvider = Provider<HabitDriftService>((ref) {
  final db = ref.watch(databaseProvider);
  return HabitDriftService(db);
});

/// Provider for karma drift service (for XP)
final habitKarmaDriftServiceProvider = Provider<KarmaDriftService>((ref) {
  return KarmaDriftService();
});

/// Habits state notifier
class HabitsNotifier extends AsyncNotifier<HabitState> {
  @override
  Future<HabitState> build() async {
    return _loadHabits();
  }

  Future<HabitState> _loadHabits() async {
    final userId = await ref.watch(habitUserIdProvider.future);
    if (userId == null || userId.isEmpty) {
      return const HabitState(isLoading: false, error: 'Not logged in');
    }

    try {
      final habitService = ref.read(habitDriftServiceProvider);
      final habits = await habitService.getUserHabits(userId);

      // Get today's completion for each habit
      final List<HabitData> habitDataList = [];
      for (final habit in habits) {
        final todayCompletion = await habitService.getTodayCompletion(habit.id);
        final isCompleted =
            todayCompletion != null &&
            todayCompletion.count >= habit.targetCount;

        habitDataList.add(
          HabitData(
            id: habit.id,
            userId: habit.userId,
            name: habit.name,
            emoji: habit.icon,
            targetCount: habit.targetCount,
            unit: habit.unit,
            frequency: habit.frequency,
            currentStreak: habit.currentStreak,
            longestStreak: habit.longestStreak,
            isPreset: habit.isPreset,
            reminderTime: habit.reminderTime,
            todayCount: todayCompletion?.count ?? 0,
            isCompletedToday: isCompleted,
          ),
        );
      }

      // Get weekly heatmap
      final weeklyHeatmap = await habitService.getWeeklyHeatmap(userId);

      return HabitState(
        habits: habitDataList,
        isLoading: false,
        weeklyCompletions: {'heatmap': weeklyHeatmap as dynamic},
      );
    } catch (e) {
      return HabitState(isLoading: false, error: e.toString());
    }
  }

  /// Add a new habit
  Future<void> addHabit({
    required String name,
    required String emoji,
    required int targetCount,
    required String unit,
    required String frequency,
  }) async {
    final userId = await ref.read(habitUserIdProvider.future);
    if (userId == null || userId.isEmpty) return;

    final habitService = ref.read(habitDriftServiceProvider);
    final id = 'custom_${DateTime.now().millisecondsSinceEpoch}_$userId';

    await habitService.createHabit(
      id: id,
      userId: userId,
      name: name,
      emoji: emoji,
      targetCount: targetCount,
      unit: unit,
      frequency: frequency,
      isPreset: false,
    );

    ref.invalidateSelf();
  }

  /// Add preset habits
  Future<void> addPresetHabits() async {
    final userId = await ref.read(habitUserIdProvider.future);
    if (userId == null || userId.isEmpty) return;

    final habitService = ref.read(habitDriftServiceProvider);
    await habitService.seedPresetHabits(userId);
    ref.invalidateSelf();
  }

  /// Delete a habit
  Future<void> deleteHabit(String habitId) async {
    final habitService = ref.read(habitDriftServiceProvider);
    await habitService.deleteHabit(habitId);
    ref.invalidateSelf();
  }

  /// Increment habit completion (tap to complete)
  Future<int> incrementHabit(String habitId) async {
    final userId = await ref.read(habitUserIdProvider.future);
    if (userId == null || userId.isEmpty) return 0;

    final habitService = ref.read(habitDriftServiceProvider);
    final habit = await habitService.getHabitById(habitId);
    if (habit == null) return 0;

    // Get current completion
    final currentCompletion = await habitService.getTodayCompletion(habitId);
    final currentCount = currentCompletion?.count ?? 0;
    final newCount = currentCount + 1;

    // Generate completion ID
    final completionId = 'completion_${DateTime.now().millisecondsSinceEpoch}';

    // Log the completion
    await habitService.logCompletion(
      id: completionId,
      habitId: habitId,
      count: newCount,
    );

    // Check if now completed (reached target)
    final justCompleted =
        currentCount < habit.targetCount && newCount >= habit.targetCount;

    // Update streak
    await habitService.updateStreak(habitId, newCount >= habit.targetCount);

    // Award XP if habit was just completed
    int xpEarned = 0;
    if (justCompleted) {
      final karmaService = ref.read(habitKarmaDriftServiceProvider);

      // Add XP for completing habit (+2 XP)
      final profile = karmaService.addXp(
        userId: userId,
        baseXp: HabitXpRewards.habitCompletion,
        action: 'complete_habit',
        description: 'Completed habit: ${habit.name}',
      );
      xpEarned += HabitXpRewards.habitCompletion;

      // Check for 7-day streak bonus
      if (profile.currentStreak == 7) {
        karmaService.addXp(
          userId: userId,
          baseXp: HabitXpRewards.streak7Days,
          action: 'streak_7',
          description: '7-day streak bonus!',
        );
        xpEarned += HabitXpRewards.streak7Days;
      }

      // Check for 30-day streak bonus
      if (profile.currentStreak == 30) {
        karmaService.addXp(
          userId: userId,
          baseXp: HabitXpRewards.streak30Days,
          action: 'streak_30',
          description: '30-day streak bonus!',
        );
        xpEarned += HabitXpRewards.streak30Days;
      }
    }

    // Refresh the state
    ref.invalidateSelf();

    return xpEarned;
  }

  /// Check if preset habits exist
  Future<bool> hasPresetHabits() async {
    final userId = await ref.read(habitUserIdProvider.future);
    if (userId == null || userId.isEmpty) return false;

    final habitService = ref.read(habitDriftServiceProvider);
    return await habitService.hasPresetHabits(userId);
  }
}

/// Main habits provider
final habitsProvider = AsyncNotifierProvider<HabitsNotifier, HabitState>(() {
  return HabitsNotifier();
});

/// Provider for weekly heatmap data
final weeklyHeatmapProvider = FutureProvider<List<DayCompletion>>((ref) async {
  final userId = await ref.watch(habitUserIdProvider.future);
  if (userId == null || userId.isEmpty) return [];

  final habitService = ref.watch(habitDriftServiceProvider);
  return await habitService.getWeeklyHeatmap(userId);
});

/// Provider for checking if user has any habits
final hasHabitsProvider = FutureProvider<bool>((ref) async {
  final userId = await ref.watch(habitUserIdProvider.future);
  if (userId == null || userId.isEmpty) return false;

  final habitService = ref.watch(habitDriftServiceProvider);
  final habits = await habitService.getUserHabits(userId);
  return habits.isNotEmpty;
});

/// Provider for today's habit stats
final todayHabitStatsProvider = Provider<TodayHabitStats>((ref) {
  final habitsAsync = ref.watch(habitsProvider);

  return habitsAsync.maybeWhen(
    data: (habits) {
      final completed = habits.habits.where((h) => h.isCompletedToday).length;
      final total = habits.habits.length;
      return TodayHabitStats(
        completedCount: completed,
        totalCount: total,
        completionRate: total > 0 ? completed / total : 0.0,
      );
    },
    orElse: () => const TodayHabitStats(),
  );
});

/// Today's habit stats
class TodayHabitStats {
  final int completedCount;
  final int totalCount;
  final double completionRate;

  const TodayHabitStats({
    this.completedCount = 0,
    this.totalCount = 0,
    this.completionRate = 0.0,
  });

  bool get allCompleted => completedCount >= totalCount && totalCount > 0;
}
