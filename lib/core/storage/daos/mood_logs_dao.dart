import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'mood_logs_dao.g.dart';


@DriftDatabase(tables: [MoodLogs])
class MoodLogsDao extends DatabaseAccessor<AppDatabase>
    with _$MoodLogsDaoMixin {
  MoodLogsDao(super.db);

  Future<List<MoodLog>> getAll(String userId) =>
      (select(moodLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
          .get();

  Future<List<MoodLog>> getByDateRange(
      String userId, DateTime start, DateTime end) {
    return (select(moodLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.loggedAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .get();
  }

  Future<MoodLog?> getLatest(String userId) =>
      (select(moodLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)])
            ..limit(1))
          .getSingleOrNull();

  Future<int> insertLog(MoodLogsCompanion entry) =>
      into(moodLogs).insert(entry);

  Future<bool> updateLog(MoodLogsCompanion entry) =>
      update(moodLogs).replace(entry);

  Future<int> deleteLog(int id) =>
      (delete(moodLogs)..where((t) => t.id.equals(id))).go();

  Stream<List<MoodLog>> watchRecent(String userId, {int limit = 7}) {
    return (select(moodLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)])
          ..limit(limit))
        .watch();
  }
}
