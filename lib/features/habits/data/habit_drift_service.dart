// lib/features/habits/data/habit_drift_service.dart
// Drift service for habit data persistence

import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart' as db;
import 'package:fitkarma/features/habits/data/habit_models.dart';

class HabitDriftService {
  final db.AppDatabase _db;

  HabitDriftService(this._db);

  /// Get all habits for a user
  Future<List<db.Habit>> getUserHabits(String userId) async {
    return await (_db.select(_db.habits)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  /// Get a single habit by ID
  Future<db.Habit?> getHabitById(String id) async {
    final results = await (_db.select(
      _db.habits,
    )..where((t) => t.id.equals(id))).get();
    return results.isEmpty ? null : results.first;
  }

  /// Create a new habit
  Future<void> createHabit({
    required String id,
    required String userId,
    required String name,
    required String emoji,
    required int targetCount,
    required String unit,
    required String frequency,
    bool isPreset = false,
    String? reminderTime,
  }) async {
    await _db
        .into(_db.habits)
        .insert(
          db.HabitsCompanion.insert(
            id: id,
            userId: userId,
            name: name,
            icon: emoji,
            targetCount: targetCount,
            unit: unit,
            frequency: frequency,
            isPreset: Value(isPreset),
            reminderTime: Value(reminderTime),
          ),
        );
  }

  /// Update a habit
  Future<void> updateHabit({
    required String id,
    String? name,
    String? emoji,
    int? targetCount,
    String? unit,
    String? frequency,
    int? currentStreak,
    int? longestStreak,
    String? reminderTime,
  }) async {
    await (_db.update(_db.habits)..where((t) => t.id.equals(id))).write(
      db.HabitsCompanion(
        name: name != null ? Value(name) : const Value.absent(),
        icon: emoji != null ? Value(emoji) : const Value.absent(),
        targetCount: targetCount != null
            ? Value(targetCount)
            : const Value.absent(),
        unit: unit != null ? Value(unit) : const Value.absent(),
        frequency: frequency != null ? Value(frequency) : const Value.absent(),
        currentStreak: currentStreak != null
            ? Value(currentStreak)
            : const Value.absent(),
        longestStreak: longestStreak != null
            ? Value(longestStreak)
            : const Value.absent(),
        reminderTime: reminderTime != null
            ? Value(reminderTime)
            : const Value.absent(),
      ),
    );
  }

  /// Delete a habit
  Future<int> deleteHabit(String id) async {
    // Also delete all completions for this habit
    await (_db.delete(
      _db.habitCompletions,
    )..where((t) => t.habitId.equals(id))).go();
    return await (_db.delete(_db.habits)..where((t) => t.id.equals(id))).go();
  }

  /// Get completions for a habit in a date range
  Future<List<HabitCompletion>> getCompletionsInRange(
    String habitId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final results =
        await (_db.select(_db.habitCompletions)
              ..where(
                (t) =>
                    t.habitId.equals(habitId) &
                    t.date.isBiggerOrEqualValue(startDate) &
                    t.date.isSmallerThanValue(endDate),
              )
              ..orderBy([(t) => OrderingTerm.desc(t.date)]))
            .get();

    return results
        .map(
          (c) => HabitCompletion(
            id: c.id,
            habitId: c.habitId,
            date: c.date,
            count: c.count,
          ),
        )
        .toList();
  }

  /// Get today's completion for a habit
  Future<HabitCompletion?> getTodayCompletion(String habitId) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final results =
        await (_db.select(_db.habitCompletions)..where(
              (t) =>
                  t.habitId.equals(habitId) &
                  t.date.isBiggerOrEqualValue(startOfDay) &
                  t.date.isSmallerThanValue(endOfDay),
            ))
            .get();

    if (results.isEmpty) return null;
    final c = results.first;
    return HabitCompletion(
      id: c.id,
      habitId: c.habitId,
      date: c.date,
      count: c.count,
    );
  }

  /// Log completion for a habit
  Future<void> logCompletion({
    required String id,
    required String habitId,
    required int count,
  }) async {
    final now = DateTime.now();
    final date = DateTime(now.year, now.month, now.day);

    // Check if completion already exists for today
    final existing = await getTodayCompletion(habitId);

    if (existing != null) {
      // Update existing completion
      await (_db.update(_db.habitCompletions)
            ..where((t) => t.id.equals(existing.id)))
          .write(db.HabitCompletionsCompanion(count: Value(count)));
    } else {
      // Insert new completion
      await _db
          .into(_db.habitCompletions)
          .insert(
            db.HabitCompletionsCompanion.insert(
              id: id,
              habitId: habitId,
              date: date,
              count: count,
            ),
          );
    }
  }

  /// Increment habit completion count by 1
  Future<void> incrementCompletion(String habitId, String completionId) async {
    final existing = await getTodayCompletion(habitId);

    if (existing != null) {
      await (_db.update(
        _db.habitCompletions,
      )..where((t) => t.id.equals(existing.id))).write(
        db.HabitCompletionsCompanion(count: Value(existing.count + 1)),
      );
    } else {
      await logCompletion(id: completionId, habitId: habitId, count: 1);
    }
  }

  /// Get completions for all user habits in a date range
  Future<Map<String, List<HabitCompletion>>> getAllCompletionsInRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final habits = await getUserHabits(userId);
    final Map<String, List<HabitCompletion>> result = {};

    for (final habit in habits) {
      final completions = await getCompletionsInRange(
        habit.id,
        startDate,
        endDate,
      );
      result[habit.id] = completions;
    }

    return result;
  }

  /// Calculate streak for a habit
  Future<int> calculateStreak(String habitId) async {
    final habit = await getHabitById(habitId);
    if (habit == null) return 0;

    final now = DateTime.now();
    int streak = habit.currentStreak;

    // Check if habit was completed today
    final todayCompletion = await getTodayCompletion(habitId);
    final today = DateTime(now.year, now.month, now.day);

    if (todayCompletion == null || todayCompletion.count < habit.targetCount) {
      // Not completed today, check if yesterday broke the streak
      final yesterday = today.subtract(const Duration(days: 1));
      final yesterdayEnd = yesterday.add(const Duration(days: 1));

      final yesterdayCompletions = await getCompletionsInRange(
        habitId,
        yesterday,
        yesterdayEnd,
      );

      if (yesterdayCompletions.isEmpty ||
          yesterdayCompletions.first.count < habit.targetCount) {
        // Streak broken
        streak = 0;
      }
    }

    return streak;
  }

  /// Update streak for a habit after completion
  Future<void> updateStreak(String habitId, bool completedToday) async {
    final habit = await getHabitById(habitId);
    if (habit == null) return;

    int newStreak = habit.currentStreak;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (completedToday) {
      // Check yesterday's completion
      final yesterdayCompletions = await getCompletionsInRange(
        habitId,
        yesterday,
        today,
      );

      final wasCompletedYesterday =
          yesterdayCompletions.isNotEmpty &&
          yesterdayCompletions.first.count >= habit.targetCount;

      if (wasCompletedYesterday) {
        // Continue streak
        newStreak = habit.currentStreak + 1;
      } else if (habit.currentStreak == 0) {
        // Start new streak
        newStreak = 1;
      }
    }

    // Update longest streak if needed
    final newLongestStreak = newStreak > habit.longestStreak
        ? newStreak
        : habit.longestStreak;

    await updateHabit(
      id: habitId,
      currentStreak: newStreak,
      longestStreak: newLongestStreak,
    );
  }

  /// Check if habit is completed for today
  Future<bool> isCompletedToday(String habitId) async {
    final habit = await getHabitById(habitId);
    if (habit == null) return false;

    final completion = await getTodayCompletion(habitId);
    return completion != null && completion.count >= habit.targetCount;
  }

  /// Get weekly heatmap data (last 7 days)
  Future<List<DayCompletion>> getWeeklyHeatmap(String userId) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final habits = await getUserHabits(userId);

    final List<DayCompletion> heatmap = [];

    for (int i = 6; i >= 0; i--) {
      final date = today.subtract(Duration(days: i));
      final nextDate = date.add(const Duration(days: 1));

      int completedCount = 0;

      for (final habit in habits) {
        final completions = await getCompletionsInRange(
          habit.id,
          date,
          nextDate,
        );

        if (completions.isNotEmpty &&
            completions.first.count >= habit.targetCount) {
          completedCount++;
        }
      }

      heatmap.add(
        DayCompletion(
          date: date,
          completedHabits: completedCount,
          totalHabits: habits.length,
        ),
      );
    }

    return heatmap;
  }

  /// Watch user habits (reactive)
  Stream<List<db.Habit>> watchUserHabits(String userId) {
    return (_db.select(_db.habits)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .watch();
  }

  /// Check if preset habits exist for user
  Future<bool> hasPresetHabits(String userId) async {
    final results = await (_db.select(
      _db.habits,
    )..where((t) => t.userId.equals(userId) & t.isPreset.equals(true))).get();
    return results.isNotEmpty;
  }

  /// Seed preset habits for a user
  Future<void> seedPresetHabits(String userId) async {
    for (final preset in PresetHabit.presets) {
      final id = '${preset.id}_$userId';
      await createHabit(
        id: id,
        userId: userId,
        name: preset.name,
        emoji: preset.emoji,
        targetCount: preset.targetCount,
        unit: preset.unit,
        frequency: preset.frequency,
        isPreset: true,
      );
    }
  }
}
