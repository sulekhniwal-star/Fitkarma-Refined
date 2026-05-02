import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'app_database.g.dart';

// ── Table Definitions ────────────────────────────────────────

class FoodLogs extends Table {
  TextColumn  get id           => text().withLength(max: 36)();
  TextColumn  get userId       => text().withLength(max: 36)();
  TextColumn  get foodName     => text().withLength(max: 200)();
  TextColumn  get foodNameLocal => text().withLength(max: 200).nullable()();
  TextColumn  get mealType     => text().withLength(max: 20)(); // breakfast/lunch/dinner/snack
  IntColumn   get loggedAt     => integer()();  // Unix timestamp
  RealColumn  get calories     => real()();
  RealColumn  get proteinG     => real().nullable()();
  RealColumn  get carbsG       => real().nullable()();
  RealColumn  get fatG         => real().nullable()();
  TextColumn  get portionUnit  => text().withLength(max: 30).nullable()();
  RealColumn  get portionQty   => real().nullable()();
  TextColumn  get source       => text().withLength(max: 20).nullable()(); // manual/scan/swiggy
  TextColumn  get syncStatus   => text().withDefault(const Constant('pending'))();
  TextColumn  get remoteId     => text().withLength(max: 36).nullable()();
  IntColumn   get failedAttempts => integer().withDefault(const Constant(0))();

  @override Set<Column> get primaryKey => {id};
}

class BpReadings extends Table {
  TextColumn  get id            => text().withLength(max: 36)();
  TextColumn  get userId        => text().withLength(max: 36)();
  IntColumn   get systolic      => integer()();
  IntColumn   get diastolic     => integer()();
  IntColumn   get pulse         => integer().nullable()();
  IntColumn   get measuredAt    => integer()();
  TextColumn  get notes         => text().withLength(max: 500).nullable()();
  TextColumn  get classification => text().withLength(max: 30).nullable()();
  TextColumn  get syncStatus    => text().withDefault(const Constant('pending'))();
  TextColumn  get remoteId      => text().withLength(max: 36).nullable()();
  IntColumn   get failedAttempts => integer().withDefault(const Constant(0))();

  @override Set<Column> get primaryKey => {id};
}

class GlucoseReadings extends Table {
  TextColumn  get id            => text().withLength(max: 36)();
  TextColumn  get userId        => text().withLength(max: 36)();
  RealColumn  get valueMgDl     => real()();
  TextColumn  get readingType   => text().withLength(max: 20)();
  IntColumn   get measuredAt    => integer()();
  TextColumn  get classification => text().withLength(max: 20).nullable()();
  TextColumn  get linkedFoodLogId => text().withLength(max: 36).nullable()();
  TextColumn  get syncStatus    => text().withDefault(const Constant('pending'))();
  TextColumn  get remoteId      => text().withLength(max: 36).nullable()();
  IntColumn   get failedAttempts => integer().withDefault(const Constant(0))();

  @override Set<Column> get primaryKey => {id};
}

class SleepLogs extends Table {
  TextColumn  get id               => text().withLength(max: 36)();
  TextColumn  get userId           => text().withLength(max: 36)();
  IntColumn   get sleepStart       => integer()();
  IntColumn   get sleepEnd         => integer()();
  IntColumn   get durationMinutes  => integer()();
  IntColumn   get qualityScore     => integer().nullable()();
  TextColumn  get source           => text().withLength(max: 20).nullable()();
  TextColumn  get syncStatus       => text().withDefault(const Constant('pending'))();
  TextColumn  get remoteId         => text().withLength(max: 36).nullable()();
  IntColumn   get failedAttempts   => integer().withDefault(const Constant(0))();

  @override Set<Column> get primaryKey => {id};
}

class Workouts extends Table {
  TextColumn  get id              => text().withLength(max: 36)();
  TextColumn  get userId          => text().withLength(max: 36)();
  TextColumn  get name            => text().withLength(max: 100)();
  TextColumn  get type            => text().withLength(max: 30)();
  IntColumn   get startedAt       => integer()();
  IntColumn   get durationMinutes => integer()();
  IntColumn   get caloriesBurned  => integer().nullable()();
  RealColumn  get distanceKm      => real().nullable()();
  IntColumn   get avgHeartRate    => integer().nullable()();
  TextColumn  get exercisesJson   => text().withLength(max: 5000).nullable()();
  TextColumn  get syncStatus      => text().withDefault(const Constant('pending'))();
  TextColumn  get remoteId        => text().withLength(max: 36).nullable()();
  IntColumn   get failedAttempts  => integer().withDefault(const Constant(0))();

  @override Set<Column> get primaryKey => {id};
}

class Habits extends Table {
  TextColumn  get id              => text().withLength(max: 36)();
  TextColumn  get userId          => text().withLength(max: 36)();
  TextColumn  get name            => text().withLength(max: 100)();
  TextColumn  get icon            => text().withLength(max: 10).nullable()();
  IntColumn   get currentStreak   => integer().withDefault(const Constant(0))();
  IntColumn   get longestStreak   => integer().withDefault(const Constant(0))();
  TextColumn  get completedDates  => text().withLength(max: 5000).nullable()(); // JSON
  TextColumn  get syncStatus      => text().withDefault(const Constant('pending'))();
  TextColumn  get remoteId        => text().withLength(max: 36).nullable()();
  IntColumn   get failedAttempts  => integer().withDefault(const Constant(0))();

  @override Set<Column> get primaryKey => {id};
}

class JournalEntries extends Table {
  TextColumn  get id          => text().withLength(max: 36)();
  TextColumn  get userId      => text().withLength(max: 36)();
  TextColumn  get title       => text().withLength(max: 200).nullable()();
  TextColumn  get body        => text().withLength(max: 10000).nullable()();
  TextColumn  get moodEmoji   => text().withLength(max: 10).nullable()();
  IntColumn   get moodScore   => integer().nullable()();
  TextColumn  get tags        => text().withLength(max: 500).nullable()(); // JSON
  IntColumn   get createdAt   => integer()();
  TextColumn  get syncStatus  => text().withDefault(const Constant('pending'))();
  TextColumn  get remoteId    => text().withLength(max: 36).nullable()();
  IntColumn   get failedAttempts => integer().withDefault(const Constant(0))();

  @override Set<Column> get primaryKey => {id};
}

class WeddingPlans extends Table {
  TextColumn  get id           => text().withLength(max: 36)();
  TextColumn  get userId       => text().withLength(max: 36)();
  TextColumn  get role         => text().withLength(max: 20)(); // bride/groom/guest/relative
  TextColumn  get relation     => text().withLength(max: 30).nullable()(); // father_of_bride etc.
  IntColumn   get firstEventTs => integer()();   // Unix timestamp
  IntColumn   get lastEventTs  => integer()();
  TextColumn  get eventsJson   => text().withLength(max: 1000)(); // JSON list of event keys
  IntColumn   get prepWeeks    => integer()();
  TextColumn  get primaryGoal  => text().withLength(max: 30)();
  TextColumn  get currentPhase => text().withLength(max: 20)(); // pre_wedding/wedding_week/post
  TextColumn  get syncStatus   => text().withDefault(const Constant('pending'))();

  @override Set<Column> get primaryKey => {id};
}

class WeddingMealLogs extends Table {
  TextColumn  get id          => text().withLength(max: 36)();
  TextColumn  get userId      => text().withLength(max: 36)();
  TextColumn  get planId      => text().withLength(max: 36)();
  TextColumn  get eventTag    => text().withLength(max: 30)(); // haldi/sangeet/vivah etc.
  TextColumn  get timing      => text().withLength(max: 20)(); // pre_event/during/post_event
  IntColumn   get loggedAt    => integer()();
  RealColumn  get calories    => real()();
  TextColumn  get notes       => text().withLength(max: 500).nullable()();
  TextColumn  get syncStatus  => text().withDefault(const Constant('pending'))();

  @override Set<Column> get primaryKey => {id};
}

// ── Database Class ────────────────────────────────────────────

@DriftDatabase(tables: [
  FoodLogs, BpReadings, GlucoseReadings, SleepLogs,
  Workouts, Habits, JournalEntries,
  WeddingPlans, WeddingMealLogs,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);
  
  factory AppDatabase.authenticated() => AppDatabase(openConnection());

  int get schemaVersion => 1;

  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      // Add migrations per version bump here
    },
  );
}

// ── Encrypted Database Factory ─────────────────────────────────

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    const storage = FlutterSecureStorage();

    // Retrieve or generate 32-byte AES key for SQLCipher
    String? key = await storage.read(key: 'db_encryption_key');
    if (key == null) {
      final bytes = List.generate(32, (_) => 
          (DateTime.now().microsecondsSinceEpoch % 256));
      key = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
      await storage.write(key: 'db_encryption_key', value: key);
    }

    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'fitkarma_encrypted.db'));

    return NativeDatabase.createInBackground(
      file,
      setup: (database) {
        // Apply SQLCipher key
        database.execute("PRAGMA key = '$key'");
      },
    );
  });
}
