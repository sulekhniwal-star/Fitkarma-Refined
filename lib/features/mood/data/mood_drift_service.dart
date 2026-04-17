import 'package:drift/drift.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/network/sync_queue.dart';

class MoodDriftService {
  final AppDatabase _db;

  MoodDriftService(this._db);

  Future<int> insertMoodLog({
    required String userId,
    required int score,
    required int energy,
    required int stress,
    required List<String> tags,
    String? note,
  }) async {
    final companion = MoodLogsCompanion.insert(
      userId: userId,
      moodScore: score,
      energyLevel: Value(energy),
      stressLevel: Value(stress),
      tags: Value(tags.join(',')),
      notes: Value(note),
      loggedAt: DateTime.now(),
      idempotencyKey: generateIdempotencyKey(userId, 'mood_log', DateTime.now().toIso8601String()),
    );

    return await _db.into(_db.moodLogs).insert(companion);
  }

  Future<List<MoodLog>> getRecentMoods(String userId) async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    return await (_db.select(_db.moodLogs)
          ..where((t) => t.userId.equals(userId) & t.loggedAt.isBiggerThanValue(thirtyDaysAgo))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)]))
        .get();
  }
}

