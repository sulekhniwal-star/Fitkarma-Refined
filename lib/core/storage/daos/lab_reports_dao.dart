import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'lab_reports_dao.g.dart';


@DriftDatabase(tables: [LabReports])
class LabReportsDao extends DatabaseAccessor<AppDatabase>
    with _$LabReportsDaoMixin {
  LabReportsDao(super.db);

  Future<List<LabReport>> getAll(String userId) =>
      (select(labReports)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.reportDate)]))
          .get();

  Future<int> insertReport(LabReportsCompanion entry) =>
      into(labReports).insert(entry);

  Future<bool> updateReport(LabReportsCompanion entry) =>
      update(labReports).replace(entry);

  Future<int> deleteReport(int id) =>
      (delete(labReports)..where((t) => t.id.equals(id))).go();
}
