import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'fasting_logs_dao.g.dart';


@DriftAccessor(tables: [FastingLogs])
class FastingLogsDao extends DatabaseAccessor<AppDatabase>
    with _$FastingLogsDaoMixin {
  FastingLogsDao(super.db);

  Future<List<FastingLog>> getAll(String userId) =>
      (select(fastingLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.startTime)]))
          .get();

  Future<FastingLog?> getActive(String userId) =>
      (select(fastingLogs)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.status.equals('active')))
          .getSingleOrNull();

  Future<int> insertLog(FastingLogsCompanion entry) =>
      into(fastingLogs).insert(entry);

  Future<bool> updateLog(FastingLogsCompanion entry) =>
      update(fastingLogs).replace(entry);

  Future<int> deleteLog(int id) =>
      (delete(fastingLogs)..where((t) => t.id.equals(id))).go();

  Stream<FastingLog?> watchActive(String userId) {
    return (select(fastingLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.status.equals('active')))
        .watchSingleOrNull();
  }
}
