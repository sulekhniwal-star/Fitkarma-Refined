import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'step_logs_dao.g.dart';


@DriftDatabase(tables: [StepLogs])
class StepLogsDao extends DatabaseAccessor<AppDatabase>
    with _$StepLogsDaoMixin {
  StepLogsDao(super.db);

  Future<List<StepLog>> getAll(String userId) =>
      (select(stepLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .get();

  Future<StepLog?> getByDate(String userId, DateTime date) {
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    return (select(stepLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.date.isBetweenValues(dayStart, dayEnd)))
        .getSingleOrNull();
  }

  Future<int> getWeeklySteps(String userId, DateTime weekStart) {
    final weekEnd = weekStart.add(const Duration(days: 7));
    final query = selectOnly(stepLogs)
      ..addColumns([stepLogs.steps.sum()])
      ..where(stepLogs.userId.equals(userId))
      ..where(stepLogs.date.isBetweenValues(weekStart, weekEnd));
    return query.getSingle()
        .then((row) => row.read(stepLogs.steps.sum()) ?? 0);
  }

  Future<int> upsertLog(StepLogsCompanion entry) =>
      into(stepLogs).insertOnConflictUpdate(entry);

  Future<int> deleteLog(int id) =>
      (delete(stepLogs)..where((t) => t.id.equals(id))).go();

  Stream<StepLog?> watchToday(String userId, DateTime date) {
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    return (select(stepLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.date.isBetweenValues(dayStart, dayEnd)))
        .watchSingleOrNull();
  }
}
