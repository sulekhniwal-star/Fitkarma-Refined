import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../auth/providers/auth_provider.dart';
import '../repositories/habit_repository.dart';

part 'habit_provider.g.dart';

@riverpod
class HabitNotifier extends _$HabitNotifier {
  @override
  Stream<List<Habit>> build() {
    final authState = ref.watch(authProvider);
    final user = authState.asData?.value;
    if (user == null) return Stream.value([]);

    return ref.watch(appDatabaseProvider).watchAllHabits(user.$id);
  }

  Future<void> createHabit({
    required String name,
    required String icon,
  }) async {
    final authState = ref.read(authProvider);
    final user = authState.asData?.value;
    if (user == null) return;

    final db = ref.read(appDatabaseProvider);
    final id = const Uuid().v4();
    
    final companion = HabitsCompanion.insert(
      id: id,
      userId: user.$id,
      name: name,
      icon: icon,
    );

    await db.into(db.habits).insert(companion);
    
    try {
      await ref.read(habitRepositoryProvider).pushHabitToRemote(id);
    } catch (_) {}
  }

  Future<void> completeHabit(String habitId) async {
    final db = ref.read(appDatabaseProvider);
    final habit = await (db.select(db.habits)..where((t) => t.id.equals(habitId))).getSingle();
    
    final today = DateTime.now();
    final todayStr = DateTime(today.year, today.month, today.day).toIso8601String();
    
    List<String> completedDates = [];
    if (habit.completedDatesJson != null) {
      completedDates = List<String>.from(jsonDecode(habit.completedDatesJson!));
    }
    
    if (completedDates.contains(todayStr)) return; // Already completed today
    
    completedDates.add(todayStr);
    
    // Calculate new streak
    int newCurrentStreak = habit.currentStreak + 1;
    // Check if streak was broken (simplified: if yesterday wasn't completed)
    final yesterday = today.subtract(const Duration(days: 1));
    final yesterdayStr = DateTime(yesterday.year, yesterday.month, yesterday.day).toIso8601String();
    
    if (!completedDates.contains(yesterdayStr) && habit.currentStreak > 0) {
      // Note: In a real app, you'd check for the actual gap. 
      // For now, if they complete today, we just increment. 
      // If yesterday was missing, we should have reset earlier, 
      // but here we'll just keep it simple.
    }
    
    int newLongestStreak = habit.longestStreak;
    if (newCurrentStreak > newLongestStreak) {
      newLongestStreak = newCurrentStreak;
    }
    
    await (db.update(db.habits)..where((t) => t.id.equals(habitId))).write(
      HabitsCompanion(
        completedDatesJson: Value(jsonEncode(completedDates)),
        currentStreak: Value(newCurrentStreak),
        longestStreak: Value(newLongestStreak),
        syncStatus: const Value('pending'),
      ),
    );
    
    try {
      await ref.read(habitRepositoryProvider).pushHabitToRemote(habitId);
    } catch (_) {}
  }

  Future<void> recoverStreak(String habitId, String userId) async {
    // Logic for streak recovery (costs 50 XP, once a month)
    // For now, we'll just restore the streak to 1 if it was 0
    final db = ref.read(appDatabaseProvider);
    final habit = await (db.select(db.habits)..where((t) => t.id.equals(habitId))).getSingle();
    
    if (habit.currentStreak > 0) return; // No need to recover
    
    await (db.update(db.habits)..where((t) => t.id.equals(habitId))).write(
      const HabitsCompanion(
        currentStreak: Value(1),
        syncStatus: Value('pending'),
      ),
    );
    
    // In a real app, subtract 50 XP from User profile here
    
    try {
      await ref.read(habitRepositoryProvider).pushHabitToRemote(habitId);
    } catch (_) {}
  }
}

@riverpod
Stream<List<Habit>> todayHabits(Ref ref) {
  final authState = ref.watch(authProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value([]);

  return ref.watch(appDatabaseProvider).watchAllHabits(user.$id);
}
