import 'package:drift/drift.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/storage/tables/ayurveda_tables.dart';

part 'ayurveda_dao.g.dart';

@DriftAccessor(tables: [AyurvedicRitualLogs])
class AyurvedaDao extends DatabaseAccessor<AppDatabase> with _$AyurvedaDaoMixin {
  AyurvedaDao(super.db);

  Future<List<AyurvedicRitualLog>> getCompletionsForDate(String userId, DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    
    return (select(ayurvedicRitualLogs)..where((t) => t.userId.equals(userId) & t.completedAt.isBetweenValues(start, end))).get();
  }

  Future<List<AyurvedicRitualLog>> getCompletionsForRange(String userId, DateTime start, DateTime end) {
    return (select(ayurvedicRitualLogs)..where((t) => t.userId.equals(userId) & t.completedAt.isBetweenValues(start, end))).get();
  }

  Future<int> recordCompletion(String userId, String ritualKey, int karma) {
    return into(ayurvedicRitualLogs).insert(
      AyurvedicRitualLogsCompanion.insert(
        userId: userId,
        ritualKey: ritualKey,
        completedAt: DateTime.now(),
        karmaAwarded: karma,
      ),
    );
  }
}

