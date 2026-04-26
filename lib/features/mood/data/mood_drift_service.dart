import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/network/sync_queue.dart';

class MoodDriftService {
  final AppDatabase _db;
  final _uuid = const Uuid();

  MoodDriftService(this._db);

  Future<void> insertMoodLog({
    required String userId,
    required int score,
    required int energy,
    required int stress,
    required List<String> tags,
    String? note,
  }) async {
    final companion = MoodLogsCompanion.insert(
      id: _uuid.v4(),
      userId: userId,
      moodScore: score,
      energyLevel: Value(energy),
      stressLevel: Value(stress),
      tags: Value(tags.join(',')),
      notes: Value(note),
      loggedAt: DateTime.now(),
      idempotencyKey: generateIdempotencyKey(userId, 'mood_log', DateTime.now().toIso8601String()),
      syncStatus: const Value('pending'),
    );

    await _db.into(_db.moodLogs).insert(companion);
  }

  Future<List<MoodLog>> getRecentMoods(String userId) async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    return await (_db.select(_db.moodLogs)
          ..where((t) => t.userId.equals(userId) & t.loggedAt.isBiggerThanValue(thirtyDaysAgo))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)]))
        .get();
  }
}
