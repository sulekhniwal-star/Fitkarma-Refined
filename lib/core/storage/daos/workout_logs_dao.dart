import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'workout_logs_dao.g.dart';


@DriftDatabase(tables: [WorkoutLogs])
class WorkoutLogsDao extends DatabaseAccessor<AppDatabase>
    with _$WorkoutLogsDaoMixin {
  WorkoutLogsDao(super.db);

  Future<List<WorkoutLog>> getAll(String userId) =>
      (select(workoutLogs)..where((t) => t.userId.equals(userId))).get();

  Future<List<WorkoutLog>> getByDate(String userId, DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return (select(workoutLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.loggedAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .get();
  }

  Future<List<WorkoutLog>> getByType(String userId, String workoutType) =>
      (select(workoutLogs)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.workoutType.equals(workoutType))
            ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
          .get();

  Future<int> getWeeklyCalories(String userId, DateTime weekStart) {
    final weekEnd = weekStart.add(const Duration(days: 7));
    final query = selectOnly(workoutLogs)
      ..addColumns([workoutLogs.caloriesBurned.sum()])
      ..where(workoutLogs.userId.equals(userId))
      ..where(workoutLogs.loggedAt.isBetweenValues(weekStart, weekEnd));
    return query.getSingle().then(
        (row) => row.read(workoutLogs.caloriesBurned.sum()) ?? 0);
  }

  Future<int> insertLog(WorkoutLogsCompanion entry) =>
      into(workoutLogs).insert(entry);

  Future<bool> updateLog(WorkoutLogsCompanion entry) =>
      update(workoutLogs).replace(entry);

  Future<int> deleteLog(int id) =>
      (delete(workoutLogs)..where((t) => t.id.equals(id))).go();

  Stream<List<WorkoutLog>> watchByDate(String userId, DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return (select(workoutLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.loggedAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .watch();
  }
}
