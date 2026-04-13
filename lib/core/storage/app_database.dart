import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/core_log_tables.dart';
import 'tables/sync_tables.dart';
import 'tables/sensitive_tables.dart';
import 'tables/india_platform_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  FoodLogs,
  FoodItems,
  WorkoutLogs,
  StepLogs,
  SleepLogs,
  MoodLogs,
  Medications,
  Habits,
  HabitCompletions,
  BodyMeasurements,
  FastingLogs,
  MealPlans,
  Recipes,
  PersonalRecords,
  NutritionGoals,
  KarmaTransactions,
  SyncQueue,
  SyncDeadLetter,
  BloodPressureLogs,
  GlucoseLogs,
  Spo2Logs,
  PeriodLogs,
  JournalEntries,
  DoctorAppointments,
  LabReports,
  AbhaLinks,
  EmergencyCard,
  FestivalCalendar,
  RemoteConfigCache,
  WeddingEvents,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(String encryptionKey) : super(_openConnection(encryptionKey));

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();

        // FTS5 Setup for FoodItems
        await customStatement(
            'CREATE VIRTUAL TABLE food_items_fts USING fts5(name, name_local, content="food_items", content_rowid="id")');

        // Triggers to keep FTS5 in sync
        await customStatement('''
          CREATE TRIGGER food_items_ai AFTER INSERT ON food_items BEGIN
            INSERT INTO food_items_fts(rowid, name, name_local) VALUES (new.id, new.name, new.name_local);
          END;
        ''');
        await customStatement('''
          CREATE TRIGGER food_items_ad AFTER DELETE ON food_items BEGIN
            INSERT INTO food_items_fts(food_items_fts, rowid, name, name_local) VALUES('delete', old.id, old.name, old.name_local);
          END;
        ''');
        await customStatement('''
          CREATE TRIGGER food_items_au AFTER UPDATE ON food_items BEGIN
            INSERT INTO food_items_fts(food_items_fts, rowid, name, name_local) VALUES('delete', old.id, old.name, old.name_local);
            INSERT INTO food_items_fts(rowid, name, name_local) VALUES (new.id, new.name, new.name_local);
          END;
        ''');
      },
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          await m.addColumn(foodLogs, foodLogs.idempotencyKey);
          await m.addColumn(foodLogs, foodLogs.fieldVersions);
        }
        if (from < 3) {
          await m.addColumn(sleepLogs, sleepLogs.sleepDebtMin);
          await m.createTable(labReports);
        }
        if (from < 4) {
          await m.createTable(bloodPressureLogs);
          await m.createTable(glucoseLogs);
          await m.createTable(spo2Logs);
          await m.createTable(periodLogs);
          await m.createTable(journalEntries);
          await m.createTable(doctorAppointments);
        }
        if (from < 5) {
          await m.createTable(abhaLinks);
          await m.createTable(emergencyCard);
          await m.createTable(festivalCalendar);
          await m.createTable(remoteConfigCache);
        }
      },
    );
  }

  /// Prefix-based FTS5 search for food items with BM25 ranking.
  Future<List<FoodItem>> searchFoodFts(String query) {
    return customSelect(
      "SELECT food_items.* FROM food_items "
      "INNER JOIN food_items_fts ON food_items_fts.rowid = food_items.id "
      "WHERE food_items_fts MATCH '$query*' "
      "ORDER BY bm25(food_items_fts) "
      "LIMIT 50",
      readsFrom: {foodItems},
    ).map((row) => foodItems.map(row)).get();
  }
}

LazyDatabase _openConnection(String encryptionKey) {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'fitkarma.db'));
    return NativeDatabase(
      file,
      setup: (database) {
        database.execute("PRAGMA key = '$encryptionKey'");
        database.execute('PRAGMA cipher_page_size = 4096');
      },
    );
  });
}
