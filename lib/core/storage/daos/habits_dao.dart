import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'habits_dao.g.dart';


@DriftAccessor(tables: [Habits, HabitCompletions])
class HabitsDao extends DatabaseAccessor<AppDatabase>
    with _$HabitsDaoMixin {
  HabitsDao(super.db);

  Future<List<Habit>> getActive(String userId) =>
      (select(habits)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.isActive.equals(true)))
          .get();

  Future<Habit?> getById(int id) =>
      (select(habits)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertHabit(HabitsCompanion entry) =>
      into(habits).insert(entry);

  Future<bool> updateHabit(HabitsCompanion entry) =>
      update(habits).replace(entry);

  Future<int> deleteHabit(int id) =>
      (delete(habits)..where((t) => t.id.equals(id))).go();

  Future<int> completeHabit(HabitCompletionsCompanion entry) =>
      into(habitCompletions).insert(entry);

  Future<List<HabitCompletion>> getCompletionsForDate(
      int habitId, DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return (select(habitCompletions)
          ..where((t) => t.habitId.equals(habitId))
          ..where((t) => t.completedAt.isBetweenValues(start, end)))
        .get();
  }

  Future<List<HabitCompletion>> getCompletionsForHabit(
      int habitId, DateTime start, DateTime end) {
    return (select(habitCompletions)
          ..where((t) => t.habitId.equals(habitId))
          ..where((t) => t.completedAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.completedAt)]))
        .get();
  }

  Future<int> getStreak(int habitId, DateTime today) async {
    var streak = 0;
    var checkDate = today;
    while (true) {
      final start = DateTime(checkDate.year, checkDate.month, checkDate.day);
      final end = start.add(const Duration(days: 1));
      final completions = await (select(habitCompletions)
            ..where((t) => t.habitId.equals(habitId))
            ..where((t) => t.completedAt.isBetweenValues(start, end)))
          .get();
      if (completions.isEmpty) break;
      streak++;
      checkDate = checkDate.subtract(const Duration(days: 1));
    }
    return streak;
  }
}
