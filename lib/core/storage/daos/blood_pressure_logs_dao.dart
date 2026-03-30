import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'blood_pressure_logs_dao.g.dart';


@DriftDatabase(tables: [BloodPressureLogs])
class BloodPressureLogsDao extends DatabaseAccessor<AppDatabase>
    with _$BloodPressureLogsDaoMixin {
  BloodPressureLogsDao(super.db);

  Future<List<BloodPressureLog>> getAll(String userId) =>
      (select(bloodPressureLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
          .get();

  Future<List<BloodPressureLog>> getByDateRange(
      String userId, DateTime start, DateTime end) {
    return (select(bloodPressureLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.loggedAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .get();
  }

  Future<BloodPressureLog?> getLatest(String userId) =>
      (select(bloodPressureLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)])
            ..limit(1))
          .getSingleOrNull();

  Future<int> insertLog(BloodPressureLogsCompanion entry) =>
      into(bloodPressureLogs).insert(entry);

  Future<bool> updateLog(BloodPressureLogsCompanion entry) =>
      update(bloodPressureLogs).replace(entry);

  Future<int> deleteLog(int id) =>
      (delete(bloodPressureLogs)..where((t) => t.id.equals(id))).go();
}
