import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/core_tables.dart';
import 'tables/health_tables.dart';
import 'tables/infrastructure_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    // Core logging tables
    FoodLogs, FoodItems, WorkoutLogs, StepLogs, SleepLogs,
    MoodLogs, Medications, Habits, HabitCompletions, BodyMeasurements,
    FastingLogs, MealPlans, Recipes, PersonalRecords, NutritionGoals,
    KarmaTransactions, SyncQueue, SyncDeadLetter, UserProfiles,
    // Sensitive / encrypted tables
    BloodPressureLogs, GlucoseLogs, Spo2Logs, PeriodLogs,
    JournalEntries, DoctorAppointments,
    // India-specific tables
    LabReports, AbhaLinks,
    // Platform / infrastructure tables
    EmergencyCards, FestivalCalendar, RemoteConfigCaches,
  ],
  daos: [
    FoodLogsDao, FoodItemsDao, WorkoutLogsDao, StepLogsDao, SleepLogsDao,
    MoodLogsDao, HabitsDao, HabitCompletionsDao, BodyMeasurementsDao,
    MedicationsDao, FastingLogsDao, MealPlansDao, RecipesDao,
    BloodPressureLogsDao, GlucoseLogsDao, Spo2LogsDao, PeriodLogsDao,
    JournalEntriesDao, DoctorAppointmentsDao, LabReportsDao, AbhaLinksDao,
    EmergencyCardDao, FestivalCalendarDao, RemoteConfigCacheDao,
    KarmaTransactionsDao, NutritionGoalsDao, PersonalRecordsDao,
    SyncQueueDao, SyncDeadLetterDao, UserProfilesDao,
  ],
)
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
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (m, from, to) async {
        if (from < 6) {
          await m.createTable(userProfiles);
        }
        // v1 → v2: add sync reliability columns and composite indices
        if (from < 2) {
          await m.addColumn(foodLogs, foodLogs.idempotencyKey);
          await m.addColumn(foodLogs, foodLogs.fieldVersions);
          
          await m.createIndex(Index('food_logs_idx', 'CREATE INDEX food_logs_idx ON food_logs (user_id, logged_at DESC)'));
          await m.createIndex(Index('step_logs_idx', 'CREATE INDEX step_logs_idx ON step_logs (user_id, date DESC)'));
          await m.createIndex(Index('workout_logs_idx', 'CREATE INDEX workout_logs_idx ON workout_logs (user_id, logged_at DESC)'));
          await m.createIndex(Index('mood_logs_idx', 'CREATE INDEX mood_logs_idx ON mood_logs (user_id, logged_at DESC)'));
          await m.createIndex(Index('sleep_logs_idx', 'CREATE INDEX sleep_logs_idx ON sleep_logs (user_id, date DESC)'));
          await m.createIndex(Index('bp_logs_idx', 'CREATE INDEX bp_logs_idx ON blood_pressure_logs (user_id, logged_at DESC)'));
          await m.createIndex(Index('glucose_logs_idx', 'CREATE INDEX glucose_logs_idx ON glucose_logs (user_id, logged_at DESC)'));
        }
        // v2 → v3: sleep debt tracking + lab reports
        if (from < 3) {
          await m.addColumn(sleepLogs, sleepLogs.sleepDebtMin);
          await m.createTable(labReports);
        }
        // v3 → v4: encrypted health tables
        if (from < 4) {
          await m.createTable(bloodPressureLogs);
          await m.createTable(glucoseLogs);
          await m.createTable(spo2Logs);
          await m.createTable(periodLogs);
          await m.createTable(journalEntries);
          await m.createTable(doctorAppointments);
        }
        // v4 → v5: India ecosystem + platform tables
        if (from < 5) {
          await m.createTable(abhaLinks);
          await m.createTable(emergencyCards);
          await m.createTable(festivalCalendar);
          await m.createTable(remoteConfigCaches);
        }
      },
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
        // Triggers for FTS5 consistency
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
        
        // Composite indices for clean installs
        await m.createIndex(Index('food_logs_idx', 'CREATE INDEX food_logs_idx ON food_logs (user_id, logged_at DESC)'));
        await m.createIndex(Index('step_logs_idx', 'CREATE INDEX step_logs_idx ON step_logs (user_id, date DESC)'));
        await m.createIndex(Index('workout_logs_idx', 'CREATE INDEX workout_logs_idx ON workout_logs (user_id, logged_at DESC)'));
        await m.createIndex(Index('mood_logs_idx', 'CREATE INDEX mood_logs_idx ON mood_logs (user_id, logged_at DESC)'));
        await m.createIndex(Index('sleep_logs_idx', 'CREATE INDEX sleep_logs_idx ON sleep_logs (user_id, date DESC)'));
        await m.createIndex(Index('bp_logs_idx', 'CREATE INDEX bp_logs_idx ON blood_pressure_logs (user_id, logged_at DESC)'));
        await m.createIndex(Index('glucose_logs_idx', 'CREATE INDEX glucose_logs_idx ON glucose_logs (user_id, logged_at DESC)'));
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

// DAO implementations
@DriftAccessor(tables: [FoodLogs])
class FoodLogsDao extends DatabaseAccessor<AppDatabase> with _$FoodLogsDaoMixin {
  FoodLogsDao(super.db);
  Future<List<FoodLog>> getRecentLogs(String userId, int limit) =>
      (select(foodLogs)..where((t) => t.userId.equals(userId))..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)])..limit(limit)).get();
}

@DriftAccessor(tables: [FoodItems])
class FoodItemsDao extends DatabaseAccessor<AppDatabase> with _$FoodItemsDaoMixin {
  FoodItemsDao(super.db);
}

@DriftAccessor(tables: [WorkoutLogs])
class WorkoutLogsDao extends DatabaseAccessor<AppDatabase> with _$WorkoutLogsDaoMixin {
  WorkoutLogsDao(super.db);
}

@DriftAccessor(tables: [StepLogs])
class StepLogsDao extends DatabaseAccessor<AppDatabase> with _$StepLogsDaoMixin {
  StepLogsDao(super.db);
}

@DriftAccessor(tables: [SleepLogs])
class SleepLogsDao extends DatabaseAccessor<AppDatabase> with _$SleepLogsDaoMixin {
  SleepLogsDao(super.db);
}

@DriftAccessor(tables: [MoodLogs])
class MoodLogsDao extends DatabaseAccessor<AppDatabase> with _$MoodLogsDaoMixin {
  MoodLogsDao(super.db);
}

@DriftAccessor(tables: [Habits])
class HabitsDao extends DatabaseAccessor<AppDatabase> with _$HabitsDaoMixin {
  HabitsDao(super.db);
}

@DriftAccessor(tables: [HabitCompletions])
class HabitCompletionsDao extends DatabaseAccessor<AppDatabase> with _$HabitCompletionsDaoMixin {
  HabitCompletionsDao(super.db);
}

@DriftAccessor(tables: [BodyMeasurements])
class BodyMeasurementsDao extends DatabaseAccessor<AppDatabase> with _$BodyMeasurementsDaoMixin {
  BodyMeasurementsDao(super.db);
}

@DriftAccessor(tables: [Medications])
class MedicationsDao extends DatabaseAccessor<AppDatabase> with _$MedicationsDaoMixin {
  MedicationsDao(super.db);
}

@DriftAccessor(tables: [FastingLogs])
class FastingLogsDao extends DatabaseAccessor<AppDatabase> with _$FastingLogsDaoMixin {
  FastingLogsDao(super.db);
}

@DriftAccessor(tables: [MealPlans])
class MealPlansDao extends DatabaseAccessor<AppDatabase> with _$MealPlansDaoMixin {
  MealPlansDao(super.db);
}

@DriftAccessor(tables: [Recipes])
class RecipesDao extends DatabaseAccessor<AppDatabase> with _$RecipesDaoMixin {
  RecipesDao(super.db);
}

@DriftAccessor(tables: [BloodPressureLogs])
class BloodPressureLogsDao extends DatabaseAccessor<AppDatabase> with _$BloodPressureLogsDaoMixin {
  BloodPressureLogsDao(super.db);
}

@DriftAccessor(tables: [GlucoseLogs])
class GlucoseLogsDao extends DatabaseAccessor<AppDatabase> with _$GlucoseLogsDaoMixin {
  GlucoseLogsDao(super.db);
}

@DriftAccessor(tables: [Spo2Logs])
class Spo2LogsDao extends DatabaseAccessor<AppDatabase> with _$Spo2LogsDaoMixin {
  Spo2LogsDao(super.db);
}

@DriftAccessor(tables: [PeriodLogs])
class PeriodLogsDao extends DatabaseAccessor<AppDatabase> with _$PeriodLogsDaoMixin {
  PeriodLogsDao(super.db);
}

@DriftAccessor(tables: [JournalEntries])
class JournalEntriesDao extends DatabaseAccessor<AppDatabase> with _$JournalEntriesDaoMixin {
  JournalEntriesDao(super.db);
}

@DriftAccessor(tables: [DoctorAppointments])
class DoctorAppointmentsDao extends DatabaseAccessor<AppDatabase> with _$DoctorAppointmentsDaoMixin {
  DoctorAppointmentsDao(super.db);
}

@DriftAccessor(tables: [LabReports])
class LabReportsDao extends DatabaseAccessor<AppDatabase> with _$LabReportsDaoMixin {
  LabReportsDao(super.db);
}

@DriftAccessor(tables: [AbhaLinks])
class AbhaLinksDao extends DatabaseAccessor<AppDatabase> with _$AbhaLinksDaoMixin {
  AbhaLinksDao(super.db);
}

@DriftAccessor(tables: [EmergencyCards])
class EmergencyCardDao extends DatabaseAccessor<AppDatabase> with _$EmergencyCardDaoMixin {
  EmergencyCardDao(super.db);
}

@DriftAccessor(tables: [FestivalCalendar])
class FestivalCalendarDao extends DatabaseAccessor<AppDatabase> with _$FestivalCalendarDaoMixin {
  FestivalCalendarDao(super.db);
}

@DriftAccessor(tables: [RemoteConfigCaches])
class RemoteConfigCacheDao extends DatabaseAccessor<AppDatabase> with _$RemoteConfigCacheDaoMixin {
  RemoteConfigCacheDao(super.db);

  Future<String?> getValue(String key) async {
    final row = await (select(remoteConfigCaches)..where((t) => t.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  Future<void> setValue(String key, String value) =>
      into(remoteConfigCaches).insertOnConflictUpdate(RemoteConfigCachesCompanion.insert(
        key: key,
        value: value,
        updatedAt: DateTime.now(),
      ));
}

@DriftAccessor(tables: [KarmaTransactions])
class KarmaTransactionsDao extends DatabaseAccessor<AppDatabase> with _$KarmaTransactionsDaoMixin {
  KarmaTransactionsDao(super.db);
}

@DriftAccessor(tables: [NutritionGoals])
class NutritionGoalsDao extends DatabaseAccessor<AppDatabase> with _$NutritionGoalsDaoMixin {
  NutritionGoalsDao(super.db);
}

@DriftAccessor(tables: [PersonalRecords])
class PersonalRecordsDao extends DatabaseAccessor<AppDatabase> with _$PersonalRecordsDaoMixin {
  PersonalRecordsDao(super.db);
}

@DriftAccessor(tables: [SyncQueue])
class SyncQueueDao extends DatabaseAccessor<AppDatabase> with _$SyncQueueDaoMixin {
  SyncQueueDao(super.db);
}

@DriftAccessor(tables: [SyncDeadLetter])
class SyncDeadLetterDao extends DatabaseAccessor<AppDatabase> with _$SyncDeadLetterDaoMixin {
  SyncDeadLetterDao(super.db);
}

@DriftAccessor(tables: [UserProfiles])
class UserProfilesDao extends DatabaseAccessor<AppDatabase> with _$UserProfilesDaoMixin {
  UserProfilesDao(super.db);

  Future<UserProfile?> getProfile(String userId) =>
      (select(userProfiles)..where((t) => t.id.equals(userId))).getSingleOrNull();

  Future<void> upsertProfile(UserProfilesCompanion profile) =>
      into(userProfiles).insertOnConflictUpdate(profile);
}

