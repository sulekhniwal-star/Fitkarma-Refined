import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'spo2_logs_dao.g.dart';


@DriftDatabase(tables: [Spo2Logs])
class Spo2LogsDao extends DatabaseAccessor<AppDatabase>
    with _$Spo2LogsDaoMixin {
  Spo2LogsDao(super.db);

  Future<List<Spo2Log>> getAll(String userId) =>
      (select(spo2Logs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
          .get();

  Future<List<Spo2Log>> getByDateRange(
      String userId, DateTime start, DateTime end) {
    return (select(spo2Logs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.loggedAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .get();
  }

  Future<int> insertLog(Spo2LogsCompanion entry) =>
      into(spo2Logs).insert(entry);

  Future<bool> updateLog(Spo2LogsCompanion entry) =>
      update(spo2Logs).replace(entry);

  Future<int> deleteLog(int id) =>
      (delete(spo2Logs)..where((t) => t.id.equals(id))).go();
}
