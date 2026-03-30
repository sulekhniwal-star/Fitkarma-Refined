import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'period_logs_dao.g.dart';


@DriftDatabase(tables: [PeriodLogs])
class PeriodLogsDao extends DatabaseAccessor<AppDatabase>
    with _$PeriodLogsDaoMixin {
  PeriodLogsDao(super.db);

  Future<List<PeriodLog>> getAll(String userId) =>
      (select(periodLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.startDate)]))
          .get();

  Future<PeriodLog?> getActive(String userId, DateTime date) {
    return (select(periodLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.startDate.isSmallerOrEqualValue(date))
          ..where((t) => t.endDate.isNull() |
              t.endDate.isBiggerOrEqualValue(date)))
        .getSingleOrNull();
  }

  Future<int> insertLog(PeriodLogsCompanion entry) =>
      into(periodLogs).insert(entry);

  Future<bool> updateLog(PeriodLogsCompanion entry) =>
      update(periodLogs).replace(entry);

  Future<int> deleteLog(int id) =>
      (delete(periodLogs)..where((t) => t.id.equals(id))).go();
}
