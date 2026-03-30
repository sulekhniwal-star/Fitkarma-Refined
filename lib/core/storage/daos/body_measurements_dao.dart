import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'body_measurements_dao.g.dart';


@DriftDatabase(tables: [BodyMeasurements])
class BodyMeasurementsDao extends DatabaseAccessor<AppDatabase>
    with _$BodyMeasurementsDaoMixin {
  BodyMeasurementsDao(super.db);

  Future<List<BodyMeasurement>> getAll(String userId) =>
      (select(bodyMeasurements)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.measuredAt)]))
          .get();

  Future<BodyMeasurement?> getLatest(String userId) =>
      (select(bodyMeasurements)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.measuredAt)])
            ..limit(1))
          .getSingleOrNull();

  Future<List<BodyMeasurement>> getByDateRange(
      String userId, DateTime start, DateTime end) {
    return (select(bodyMeasurements)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.measuredAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.measuredAt)]))
        .get();
  }

  Future<int> insertMeasurement(BodyMeasurementsCompanion entry) =>
      into(bodyMeasurements).insert(entry);

  Future<bool> updateMeasurement(BodyMeasurementsCompanion entry) =>
      update(bodyMeasurements).replace(entry);

  Future<int> deleteMeasurement(int id) =>
      (delete(bodyMeasurements)..where((t) => t.id.equals(id))).go();

  Stream<BodyMeasurement?> watchLatest(String userId) {
    return (select(bodyMeasurements)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.measuredAt)])
          ..limit(1))
        .watchSingleOrNull();
  }
}
