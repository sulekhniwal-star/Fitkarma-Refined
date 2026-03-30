import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'emergency_card_dao.g.dart';


@DriftAccessor(tables: [EmergencyCard])
class EmergencyCardDao extends DatabaseAccessor<AppDatabase>
    with _$EmergencyCardDaoMixin {
  EmergencyCardDao(super.db);

  Future<EmergencyCardData?> getByUser(String userId) =>
      (select(emergencyCard)..where((t) => t.userId.equals(userId)))
          .getSingleOrNull();

  Future<int> upsertCard(EmergencyCardCompanion entry) =>
      into(emergencyCard).insertOnConflictUpdate(entry);

  Future<int> deleteCard(String userId) =>
      (delete(emergencyCard)..where((t) => t.userId.equals(userId))).go();

  Stream<EmergencyCardData?> watchByUser(String userId) {
    return (select(emergencyCard)..where((t) => t.userId.equals(userId)))
        .watchSingleOrNull();
  }
}
