import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/core/di/providers.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';

class EmergencyCardRepository extends Notifier<EmergencyCardData?> {
  late final AppDatabase _db;

  @override
  EmergencyCardData? build() {
    _db = ref.read(driftDatabaseProvider);
    _load();
    return null;
  }

  Future<void> _load() async {
    final user = await ref.read(currentUserProvider.future);
    final userId = user?.$id;
    if (userId == null) return;

    final entry = await (_db.select(_db.emergencyCard)
          ..where((t) => t.userId.equals(userId)))
        .getSingleOrNull();
    state = entry;
  }

  Future<void> updateCard({
    String? bloodGroup,
    String? allergies,
    String? emergencyContact,
    String? conditions,
    String? medications,
  }) async {
    final user = await ref.read(currentUserProvider.future);
    final userId = user?.$id;
    if (userId == null) return;

    final companion = EmergencyCardCompanion.insert(
      userId: userId,
      bloodGroup: Value(bloodGroup),
      allergies: Value(allergies),
      emergencyContact: Value(emergencyContact),
      conditions: Value(conditions),
      medications: Value(medications),
      updatedAt: DateTime.now(),
    );

    // Using userId as unique key for upsert
    await _db.into(_db.emergencyCard).insertOnConflictUpdate(companion);
    await _load();
  }
}

final emergencyCardRepositoryProvider =
    NotifierProvider<EmergencyCardRepository, EmergencyCardData?>(
  () => EmergencyCardRepository(),
);
