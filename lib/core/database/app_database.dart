
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class FoodLogs extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get foodName => text().withLength(min: 1, max: 128)();
  TextColumn get foodNameLocal => text().nullable().withLength(min: 0, max: 128)();
  TextColumn get mealType => text().withLength(min: 1, max: 32)(); // e.g., breakfast, lunch
  DateTimeColumn get loggedAt => dateTime()();
  RealColumn get calories => real().withDefault(const Constant(0.0))();
  RealColumn get proteinG => real().withDefault(const Constant(0.0))();
  RealColumn get carbsG => real().withDefault(const Constant(0.0))();
  RealColumn get fatG => real().withDefault(const Constant(0.0))();
  TextColumn get portionUnit => text().withLength(min: 1, max: 32)();
  RealColumn get portionQty => real().withDefault(const Constant(1.0))();
  TextColumn get source => text().withLength(min: 1, max: 32).withDefault(const Constant('manual'))(); // manual, barcode
  TextColumn get syncStatus => text().withLength(min: 1, max: 16).withDefault(const Constant('pending'))(); // pending, synced, dlq
  TextColumn get remoteId => text().nullable()();
  IntColumn get failedAttempts => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class BpReadings extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  IntColumn get systolic => integer()();
  IntColumn get diastolic => integer()();
  IntColumn get pulse => integer().nullable()();
  DateTimeColumn get measuredAt => dateTime()();
  TextColumn get notes => text().nullable().withLength(min: 0, max: 500)();
  TextColumn get classification => text().nullable()(); // normal, elevated, stage1, stage2, crisis
  TextColumn get syncStatus => text().withLength(min: 1, max: 16).withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();
  IntColumn get failedAttempts => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class GlucoseReadings extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  RealColumn get valueMgDl => real()();
  TextColumn get readingType => text()(); // fasting, post_meal, random
  DateTimeColumn get measuredAt => dateTime()();
  TextColumn get classification => text().nullable()(); // normal, prediabetic, diabetic
  TextColumn get linkedFoodLogId => text().nullable()();
  TextColumn get syncStatus => text().withLength(min: 1, max: 16).withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();
  IntColumn get failedAttempts => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class SleepLogs extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  DateTimeColumn get sleepStart => dateTime()();
  DateTimeColumn get sleepEnd => dateTime()();
  IntColumn get durationMinutes => integer()();
  IntColumn get qualityScore => integer().nullable()(); // 1-100
  TextColumn get source => text().withLength(min: 1, max: 32).withDefault(const Constant('manual'))(); // manual, health_connect
  TextColumn get syncStatus => text().withLength(min: 1, max: 16).withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();
  IntColumn get failedAttempts => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class Workouts extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get name => text().withLength(min: 1, max: 128)();
  TextColumn get type => text().withLength(min: 1, max: 64)(); // yoga, run, gym, etc.
  DateTimeColumn get startedAt => dateTime()();
  IntColumn get durationMinutes => integer().nullable()();
  RealColumn get caloriesBurned => real().nullable()();
  RealColumn get distanceKm => real().nullable()();
  IntColumn get avgHeartRate => integer().nullable()();
  TextColumn get exercisesJson => text().nullable()(); // JSON string for list of exercises
  TextColumn get syncStatus => text().withLength(min: 1, max: 16).withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();
  IntColumn get failedAttempts => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class Habits extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get name => text().withLength(min: 1, max: 128)();
  TextColumn get icon => text().withLength(min: 1, max: 64)();
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();
  TextColumn get completedDatesJson => text().nullable()(); // List of ISO strings
  TextColumn get syncStatus => text().withLength(min: 1, max: 16).withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();
  IntColumn get failedAttempts => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class JournalEntries extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get title => text().nullable().withLength(min: 0, max: 128)();
  TextColumn get body => text()(); // Delta JSON from Quill
  TextColumn get moodEmoji => text().nullable()();
  IntColumn get moodScore => integer().nullable()(); // 1-10
  TextColumn get tagsJson => text().nullable()(); // List of strings
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get syncStatus => text().withLength(min: 1, max: 16).withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();
  IntColumn get failedAttempts => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class WeddingPlans extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get role => text()(); // bride, groom, sibling, parent
  TextColumn get relation => text().nullable()(); // e.g., sister of bride
  DateTimeColumn get firstEventTs => dateTime()();
  DateTimeColumn get lastEventTs => dateTime()();
  TextColumn get eventsJson => text()(); // Detailed event timeline
  IntColumn get prepWeeks => integer()();
  TextColumn get primaryGoal => text()(); // weight_loss, glow, endurance
  TextColumn get currentPhase => text()(); // prep, active, final, recovery
  TextColumn get syncStatus => text().withLength(min: 1, max: 16).withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

class WeddingMealLogs extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get planId => text().references(WeddingPlans, #id)();
  TextColumn get eventTag => text()(); // Haldi, Mehendi, Sangeet
  TextColumn get timing => text()(); // pre_event, during, post_event
  DateTimeColumn get loggedAt => dateTime()();
  RealColumn get calories => real().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get syncStatus => text().withLength(min: 1, max: 16).withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

class StepCounts extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  DateTimeColumn get date => dateTime()();
  IntColumn get count => integer().withDefault(const Constant(0))();
  TextColumn get syncStatus => text().withLength(min: 1, max: 16).withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

class Spo2Readings extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  IntColumn get spo2Percentage => integer()();
  IntColumn get pulse => integer().nullable()();
  DateTimeColumn get measuredAt => dateTime()();
  TextColumn get syncStatus => text().withLength(min: 1, max: 16).withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();
  IntColumn get failedAttempts => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class UserProfiles extends Table {
  @override
  String get tableName => 'user_profiles';
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get name => text().withLength(min: 1, max: 128)();
  IntColumn get xp => integer().withDefault(const Constant(0))();
  IntColumn get level => integer().withDefault(const Constant(1))();
  TextColumn get rank => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class KarmaEvents extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get eventType => text()();
  IntColumn get points => integer()();
  DateTimeColumn get occurredAt => dateTime()();
  TextColumn get syncStatus => text().withLength(min: 1, max: 16).withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [
  FoodLogs,
  BpReadings,
  GlucoseReadings,
  SleepLogs,
  Workouts,
  Habits,
  JournalEntries,
  WeddingPlans,
  WeddingMealLogs,
  StepCounts,
  Spo2Readings,
  UserProfiles,
  KarmaEvents,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      // Stubs for future migrations
    },
  );

  // --- Health Queries ---

  Stream<List<FoodLog>> watchTodayFoodLogs(String userId, DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return (select(foodLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.loggedAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .watch();
  }

  Stream<StepCount?> watchTodaySteps(String userId, DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    return (select(stepCounts)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.date.equals(day)))
        .watchSingleOrNull();
  }

  Stream<Habit> watchHabitById(String id) {
    return (select(habits)..where((t) => t.id.equals(id))).watchSingle();
  }

  Future<List<JournalEntry>> getJournalEntries(String userId, {int limit = 20}) {
    return (select(journalEntries)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit))
        .get();
  }

  Future<List<BpReading>> getBpHistory(String userId, int days) {
    final start = DateTime.now().subtract(Duration(days: days));
    return (select(bpReadings)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.measuredAt.isBiggerOrEqualValue(start))
          ..orderBy([(t) => OrderingTerm.asc(t.measuredAt)]))
        .get();
  }

  Future<List<GlucoseReading>> getGlucoseHistory(String userId, String readingType, int days) {
    final start = DateTime.now().subtract(Duration(days: days));
    return (select(glucoseReadings)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.readingType.equals(readingType))
          ..where((t) => t.measuredAt.isBiggerOrEqualValue(start))
          ..orderBy([(t) => OrderingTerm.asc(t.measuredAt)]))
        .get();
  }

  Future<List<SleepLog>> getSleepLogs(String userId, int days) {
    final start = DateTime.now().subtract(Duration(days: days));
    return (select(sleepLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.sleepStart.isBiggerOrEqualValue(start))
          ..orderBy([(t) => OrderingTerm.asc(t.sleepStart)]))
        .get();
  }

  Stream<BpReading?> watchLatestBpReading(String userId) {
    return (select(bpReadings)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.measuredAt)])
          ..limit(1))
        .watchSingleOrNull();
  }

  Stream<GlucoseReading?> watchLatestGlucose(String userId) {
    return (select(glucoseReadings)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.measuredAt)])
          ..limit(1))
        .watchSingleOrNull();
  }

  Stream<Spo2Reading?> watchLatestSpo2(String userId) {
    return (select(spo2Readings)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.measuredAt)])
          ..limit(1))
        .watchSingleOrNull();
  }

  Stream<List<SleepLog>> watchSleepHistory(String userId, int days) {
    final start = DateTime.now().subtract(Duration(days: days));
    return (select(sleepLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.sleepStart.isBiggerOrEqualValue(start))
          ..orderBy([(t) => OrderingTerm.desc(t.sleepStart)]))
        .watch();
  }

  Stream<Workout?> watchActiveWorkout(String userId) {
    return (select(workouts)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.durationMinutes.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.startedAt)])
          ..limit(1))
        .watchSingleOrNull();
  }

  Stream<List<Workout>> watchWorkoutHistory(String userId, int limit) {
    return (select(workouts)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.durationMinutes.isNotNull())
          ..orderBy([(t) => OrderingTerm.desc(t.startedAt)])
          ..limit(limit))
        .watch();
  }

  Stream<List<Habit>> watchAllHabits(String userId) {
    return (select(habits)..where((t) => t.userId.equals(userId))).watch();
  }

  Stream<List<StepCount>> watchStepHistory(String userId, int days) {
    final start = DateTime.now().subtract(Duration(days: days));
    return (select(stepCounts)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.date.isBiggerOrEqualValue(start))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();
  }

  Future<void> saveSteps(StepCountsCompanion companion) async {
    await into(stepCounts).insertOnConflictUpdate(companion);
  }

  Stream<UserProfile?> watchUserProfile(String id) {
    return (select(userProfiles)..where((t) => t.id.equals(id))).watchSingleOrNull();
  }

  // --- Generic Sync Queries ---

  Future<List<D>> getPendingRecords<T extends HasResultSet, D>(ResultSetImplementation<T, D> table) async {
    final rows = await customSelect(
      'SELECT * FROM ${table.aliasedName} WHERE sync_status = ? AND failed_attempts < 3',
      variables: [Variable.withString('pending')],
      readsFrom: {table},
    ).get();
    
    final results = <D>[];
    for (final row in rows) {
      results.add(await table.map(row.data));
    }
    return results;
  }

  Future<List<D>> getDLQRecords<T extends HasResultSet, D>(ResultSetImplementation<T, D> table) async {
    final rows = await customSelect(
      'SELECT * FROM ${table.aliasedName} WHERE sync_status = ?',
      variables: [Variable.withString('dlq')],
      readsFrom: {table},
    ).get();
    
    final results = <D>[];
    for (final row in rows) {
      results.add(await table.map(row.data));
    }
    return results;
  }

  Future<void> markSynced(String localId, String remoteId, String tableName) {
    return customUpdate(
      'UPDATE $tableName SET sync_status = ?, remote_id = ?, failed_attempts = 0 WHERE id = ?',
      variables: [
        Variable.withString('synced'),
        Variable.withString(remoteId),
        Variable.withString(localId),
      ],
      updates: {}, // This is tricky, usually we should know which table to update
    );
  }

  Future<void> incrementFailedAttempts(String localId, String tableName) {
    return customUpdate(
      'UPDATE $tableName SET failed_attempts = failed_attempts + 1, sync_status = CASE WHEN failed_attempts >= 2 THEN "dlq" ELSE "pending" END WHERE id = ?',
      variables: [Variable.withString(localId)],
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'fitkarma.sqlite'));
    return NativeDatabase(file);
  });
}
