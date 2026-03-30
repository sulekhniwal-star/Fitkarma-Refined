import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'glucose_logs_dao.g.dart';


@DriftDatabase(tables: [GlucoseLogs])
class GlucoseLogsDao extends DatabaseAccessor<AppDatabase>
    with _$GlucoseLogsDaoMixin {
  GlucoseLogsDao(super.db);

  Future<List<GlucoseLog>> getAll(String userId) =>
      (select(glucoseLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
          .get();

  Future<List<GlucoseLog>> getByDateRange(
      String userId, DateTime start, DateTime end) {
    return (select(glucoseLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.loggedAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .get();
  }

  Future<GlucoseLog?> getLatest(String userId) =>
      (select(glucoseLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)])
            ..limit(1))
          .getSingleOrNull();

  Future<int> insertLog(GlucoseLogsCompanion entry) =>
      into(glucoseLogs).insert(entry);

  Future<bool> updateLog(GlucoseLogsCompanion entry) =>
      update(glucoseLogs).replace(entry);

  Future<int> deleteLog(int id) =>
      (delete(glucoseLogs)..where((t) => t.id.equals(id))).go();
}
