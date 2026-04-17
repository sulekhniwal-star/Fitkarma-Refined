import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/core_log_tables.dart';
import 'tables/sync_tables.dart';
import 'tables/sensitive_tables.dart';
import 'tables/india_platform_tables.dart';
import 'tables/insight_tables.dart';
import 'tables/user_tables.dart';
import 'tables/ayurveda_tables.dart';
import 'daos/food_dao.dart';
import 'daos/health_dao.dart';
import 'daos/user_dao.dart';
import 'daos/sync_dao.dart';
import '../../features/ayurveda/data/ayurveda_dao.dart';
import 'converters/json_converters.dart';
import 'converters/encryption_converters.dart';

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
  EmergencyCards,
  FestivalCalendar,
  RemoteConfigCache,
  WeddingEvents,
  InsightLogs,
  InsightRatings,
  Users,
  HeartRateLogs,
  AyurvedicRitualLogs,
], daos: [
  FoodDao,
  HealthDao,
  UserDao,
  SyncDao,
  AyurvedaDao,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(String encryptionKey) : super(_openConnection(encryptionKey));

  @override
  int get schemaVersion => 14;

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
          await m.createTable(emergencyCards);
          await m.createTable(festivalCalendar);
          await m.createTable(remoteConfigCache);
        }
        if (from < 6) {
          await m.createTable(insightLogs);
          await m.createTable(insightRatings);
        }
        if (from < 7) {
          await m.createTable(users);
        }
        if (from < 8) {
          // Re-create PeriodLogs because columns changed significantly
          await m.deleteTable('period_logs');
          await m.createTable(periodLogs);
        }
        if (from < 9) {
          await m.deleteTable('abha_links');
          await m.createTable(abhaLinks);
        }
        if (from < 10) {
          await m.createTable(heartRateLogs);
        }
        if (from < 11) {
          await m.deleteTable('doctor_appointments');
          await m.createTable(doctorAppointments);
        }
        if (from < 12) {
          await m.deleteTable('emergency_cards');
          await m.createTable(emergencyCards);
        }
        if (from < 13) {
          await m.addColumn(users, users.weddingRole);
          await m.addColumn(users, users.weddingRelationType);
          await m.addColumn(users, users.weddingStartDate);
          await m.addColumn(users, users.weddingEndDate);
          await m.addColumn(users, users.weddingPrepWeeks);
          await m.addColumn(users, users.weddingEvents);
          await m.addColumn(users, users.weddingPrimaryGoal);
        }
        if (from < 14) {
          await m.createTable(ayurvedicRitualLogs);
        }
      },
    );
  }

  /// Prefix-based FTS5 search for food items with BM25 ranking.
  Future<List<FoodItem>> searchFoodFts(String query) async {
    final rows = await customSelect(
      "SELECT food_items.* FROM food_items "
      "INNER JOIN food_items_fts ON food_items_fts.rowid = food_items.id "
      "WHERE food_items_fts MATCH '$query*' "
      "ORDER BY bm25(food_items_fts) "
      "LIMIT 50",
      readsFrom: {foodItems},
    ).get();
    return rows.map((row) => foodItems.map(row.data)).toList();
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

