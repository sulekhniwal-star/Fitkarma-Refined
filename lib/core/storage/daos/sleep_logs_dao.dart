import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'sleep_logs_dao.g.dart';


@DriftAccessor(tables: [SleepLogs])
class SleepLogsDao extends DatabaseAccessor<AppDatabase>
    with _$SleepLogsDaoMixin {
  SleepLogsDao(super.db);

  Future<List<SleepLog>> getAll(String userId) =>
      (select(sleepLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.sleepStart)]))
          .get();

  Future<List<SleepLog>> getByDateRange(
      String userId, DateTime start, DateTime end) {
    return (select(sleepLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.sleepStart.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.sleepStart)]))
        .get();
  }

  Future<SleepLog?> getLatest(String userId) =>
      (select(sleepLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.sleepStart)])
            ..limit(1))
          .getSingleOrNull();

  Future<double> getAvgDurationMinutes(
      String userId, DateTime start, DateTime end) async {
    final query = selectOnly(sleepLogs)
      ..addColumns([sleepLogs.durationMinutes.avg()])
      ..where(sleepLogs.userId.equals(userId))
      ..where(sleepLogs.sleepStart.isBetweenValues(start, end));
    final row = await query.getSingle();
    return row.read(sleepLogs.durationMinutes.avg()) ?? 0.0;
  }

  Future<int> insertLog(SleepLogsCompanion entry) =>
      into(sleepLogs).insert(entry);

  Future<bool> updateLog(SleepLogsCompanion entry) =>
      update(sleepLogs).replace(entry);

  Future<int> deleteLog(int id) =>
      (delete(sleepLogs)..where((t) => t.id.equals(id))).go();

  Stream<List<SleepLog>> watchRecent(String userId, {int limit = 7}) {
    return (select(sleepLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.sleepStart)])
          ..limit(limit))
        .watch();
  }
}
