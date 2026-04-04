import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/core_tables.dart';
import 'tables/health_tables.dart';
import 'tables/infrastructure_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  // Core logging tables
  FoodLogs, FoodItems, WorkoutLogs, StepLogs, SleepLogs,
  MoodLogs, Medications, Habits, HabitCompletions, BodyMeasurements,
  FastingLogs, MealPlans, Recipes, PersonalRecords, NutritionGoals,
  KarmaTransactions, SyncQueue, SyncDeadLetter,
  // Sensitive / encrypted tables
  BloodPressureLogs, GlucoseLogs, Spo2Logs, PeriodLogs,
  JournalEntries, DoctorAppointments,
  // India-specific tables
  LabReports, AbhaLinks,
  // Platform / infrastructure tables
  EmergencyCards, FestivalCalendar, RemoteConfigCaches,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(String encryptionKey) : super(_openConnection(encryptionKey));

  static QueryExecutor _openConnection(String encryptionKey) {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'fitkarma.db'));
      return NativeDatabase.createInBackground(
        file,
        setup: (rawDb) {
          rawDb.execute("PRAGMA key = '$encryptionKey'");
          rawDb.execute("PRAGMA cipher_page_size = 4096");
        },
      );
    });
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
        // FTS5 Virtual Table for Food Search
        await customStatement('''
          CREATE VIRTUAL TABLE food_items_fts USING fts5(
            name,
            name_local,
            content="food_items",
            content_rowid="rowid"
          )
        ''');
        // Triggers for FTS5
        await customStatement('''
          CREATE TRIGGER food_items_ai AFTER INSERT ON food_items BEGIN
            INSERT INTO food_items_fts(rowid, name, name_local)
            VALUES (new.rowid, new.name, new.name_local);
          END
        ''');
        await customStatement('''
          CREATE TRIGGER food_items_ad AFTER DELETE ON food_items BEGIN
            INSERT INTO food_items_fts(food_items_fts, rowid, name, name_local)
            VALUES ('delete', old.rowid, old.name, old.name_local);
          END
        ''');
        await customStatement('''
          CREATE TRIGGER food_items_au AFTER UPDATE ON food_items BEGIN
            INSERT INTO food_items_fts(food_items_fts, rowid, name, name_local)
            VALUES ('delete', old.rowid, old.name, old.name_local);
            INSERT INTO food_items_fts(rowid, name, name_local)
            VALUES (new.rowid, new.name, new.name_local);
          END
        ''');
      },
    );
  }

  // FTS5 search query
  Future<List<FoodItem>> searchFoodFts(String query) {
    if (query.isEmpty) return Future.value([]);
    final ftsQuery = query.trim().split(' ').map((t) => '$t*').join(' ');
    return customSelect(
      '''
      SELECT fi.* FROM food_items fi
      JOIN food_items_fts fts ON fi.rowid = fts.rowid
      WHERE food_items_fts MATCH ?
      ORDER BY bm25(food_items_fts)
      LIMIT 50
      ''',
      variables: [Variable.withString(ftsQuery)],
    ).map((row) => FoodItem.fromJson(row.data)).get();
  }
}
