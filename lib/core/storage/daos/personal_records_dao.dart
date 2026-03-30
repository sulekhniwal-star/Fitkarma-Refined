import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'personal_records_dao.g.dart';


@DriftDatabase(tables: [PersonalRecords])
class PersonalRecordsDao extends DatabaseAccessor<AppDatabase>
    with _$PersonalRecordsDaoMixin {
  PersonalRecordsDao(super.db);

  Future<List<PersonalRecord>> getAll(String userId) =>
      (select(personalRecords)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.achievedAt)]))
          .get();

  Future<List<PersonalRecord>> getByExercise(
          String userId, String exerciseName) =>
      (select(personalRecords)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.exerciseName.equals(exerciseName))
            ..orderBy([(t) => OrderingTerm.desc(t.achievedAt)]))
          .get();

  Future<PersonalRecord?> getBest(String userId, String exerciseName,
          String recordType) =>
      (select(personalRecords)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.exerciseName.equals(exerciseName))
            ..where((t) => t.recordType.equals(recordType))
            ..orderBy([(t) => OrderingTerm.desc(t.value)])
            ..limit(1))
          .getSingleOrNull();

  Future<int> insertRecord(PersonalRecordsCompanion entry) =>
      into(personalRecords).insert(entry);

  Future<bool> updateRecord(PersonalRecordsCompanion entry) =>
      update(personalRecords).replace(entry);

  Future<int> deleteRecord(int id) =>
      (delete(personalRecords)..where((t) => t.id.equals(id))).go();
}
