import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/appwrite_client.dart';
import '../../../core/storage/drift_service.dart';
import '../../../core/storage/app_database.dart';
import 'package:drift/drift.dart';

class UsersRepository {
  UsersRepository();

  Future<void> updateWeddingData({
    required String userId,
    required String role,
    required String? relativeType,
    required DateTime? startDate,
    required DateTime? endDate,
    required List<String> events,
    required String? prepWeeks,
    required String? primaryGoal,
  }) async {
    final account = AppwriteClient.account;
    final prefs = await account.getPrefs();
    
    final weddingData = {
      'wedding_role': role,
      'wedding_relative_type': relativeType,
      'wedding_start_date': startDate?.toIso8601String(),
      'wedding_end_date': endDate?.toIso8601String(),
      'wedding_events': events,
      'wedding_prep_weeks': prepWeeks,
      'wedding_primary_goal': primaryGoal,
      'is_wedding_active': true,
    };

    final newPrefs = Map<String, dynamic>.from(prefs.data)..addAll(weddingData);
    await account.updatePrefs(prefs: newPrefs);

    final db = DriftService.db;
    await (db.update(db.users)..where((u) => u.id.equals(userId))).write(
      UsersCompanion(
        weddingRole: Value(role),
        weddingRelationType: Value(relativeType),
        weddingStartDate: Value(startDate),
        weddingEndDate: Value(endDate),
        weddingPrepWeeks: Value(int.tryParse(prepWeeks ?? '')),
        weddingEvents: Value(events.toString()),
        weddingPrimaryGoal: Value(primaryGoal),
      ),
    );
  }
}

final usersRepositoryProvider = Provider<UsersRepository>((ref) {
  return UsersRepository();
});

