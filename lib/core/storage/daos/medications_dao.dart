import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'medications_dao.g.dart';


@DriftAccessor(tables: [Medications])
class MedicationsDao extends DatabaseAccessor<AppDatabase>
    with _$MedicationsDaoMixin {
  MedicationsDao(super.db);

  Future<List<Medication>> getActive(String userId) =>
      (select(medications)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.isActive.equals(true)))
          .get();

  Future<List<Medication>> getAll(String userId) =>
      (select(medications)..where((t) => t.userId.equals(userId))).get();

  Future<Medication?> getById(int id) =>
      (select(medications)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertMedication(MedicationsCompanion entry) =>
      into(medications).insert(entry);

  Future<bool> updateMedication(MedicationsCompanion entry) =>
      update(medications).replace(entry);

  Future<int> deleteMedication(int id) =>
      (delete(medications)..where((t) => t.id.equals(id))).go();

  Stream<List<Medication>> watchActive(String userId) {
    return (select(medications)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.isActive.equals(true)))
        .watch();
  }
}
