import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/storage/tables/ayurveda_tables.dart';

part 'ayurveda_dao.g.dart';

@DriftAccessor(tables: [AyurvedicRitualLogs])
class AyurvedaDao extends DatabaseAccessor<AppDatabase> with _$AyurvedaDaoMixin {
  final _uuid = const Uuid();

  AyurvedaDao(super.db);

  Future<List<AyurvedicRitualLog>> getCompletionsForDate(String userId, DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    
    return (select(ayurvedicRitualLogs)..where((t) => t.userId.equals(userId) & t.completedAt.isBetweenValues(start, end))).get();
  }

  Future<List<AyurvedicRitualLog>> getCompletionsForRange(String userId, DateTime start, DateTime end) {
    return (select(ayurvedicRitualLogs)..where((t) => t.userId.equals(userId) & t.completedAt.isBetweenValues(start, end))).get();
  }

  Future<void> recordCompletion(String userId, String ritualKey, int karma) async {
    await into(ayurvedicRitualLogs).insert(
      AyurvedicRitualLogsCompanion.insert(
        id: _uuid.v4(),
        userId: userId,
        ritualKey: ritualKey,
        completedAt: DateTime.now(),
        karmaAwarded: karma,
        idempotencyKey: _uuid.v4(),
        syncStatus: const Value('pending'),
      ),
    );
  }
}
