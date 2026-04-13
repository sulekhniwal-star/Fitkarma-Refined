import 'package:drift/drift.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/network/sync_queue.dart';

class MoodDriftService {
  final AppDatabase _db;

  MoodDriftService(this._db);

  /// Inserts a new mood log.
  Future<int> insertMoodLog({
    required String userId,
    required int score,
    required int energy,
    required int stress,
    required List<String> tags,
    String? voicePath,
  }) async {
    final companion = MoodLogsCompanion.insert(
      userId: userId,
      score: score,
      energy: energy,
      stress: stress,
      tags: Value(tags.join(',')),
      voicePath: Value(voicePath),
      loggedAt: DateTime.now(),
      idempotencyKey: generateIdempotencyKey(userId, 'mood_log', DateTime.now().toIso8601String()),
    );

    return await _db.into(_db.moodLogs).insert(companion);
  }

  /// Fetches mood logs for the last 30 days.
  Future<List<MoodLog>> getRecentMoods(String userId) async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    return await (_db.select(_db.moodLogs)
          ..where((t) => t.userId.equals(userId) & t.loggedAt.isAfterValue(thirtyDaysAgo))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)]))
        .get();
  }
}
