import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../app_database.dart';
import '../tables/core_log_tables.dart';
import '../tables/sensitive_tables.dart';

part 'health_dao.g.dart';

@DriftAccessor(tables: [
  WorkoutLogs,
  StepLogs,
  SleepLogs,
  MoodLogs,
  Medications,
  Habits,
  HabitCompletions,
  BodyMeasurements,
  FastingLogs,
  HeartRateLogs,
  BloodPressureLogs,
  GlucoseLogs,
  Spo2Logs,
  PeriodLogs,
])
class HealthDao extends DatabaseAccessor<AppDatabase> with _$HealthDaoMixin {
  HealthDao(super.db);

  final _uuid = const Uuid();

  /// Returns a stream of step logs for a specific date range.
  Stream<List<StepLog>> watchSteps(String userId, DateTime start, DateTime end) {
    return (select(stepLogs)
          ..where((t) => t.userId.equals(userId) & t.date.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc)]))
        .watch();
  }

  /// Returns a stream of active medications for a user.
  Stream<List<Medication>> watchActiveMedications(String userId) {
    return (select(medications)
          ..where((t) => t.userId.equals(userId) & t.isActive.equals(true)))
        .watch();
  }

  /// Inserts or updates a body measurement.
  Future<void> upsertWeight(BodyMeasurementsCompanion measurement) async {
    var companion = measurement;
    if (!companion.id.present) {
      companion = companion.copyWith(
        id: Value(_uuid.v4()),
        idempotencyKey: Value(_uuid.v4()),
      );
    }
    await into(bodyMeasurements).insert(companion, mode: InsertMode.insertOrReplace);
  }

  /// Fetches recent workout logs.
  Future<List<WorkoutLog>> getRecentWorkouts(String userId, int limit) async {
    return await (select(workoutLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)])
          ..limit(limit))
        .get();
  }

  /// Specific query for Period Logs (Encrypted).
  /// Note: Encryption/Decryption handled transparently by TypeConverters.
  Stream<List<PeriodLog>> watchPeriodLogs(String userId) {
    return (select(periodLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.cycleStartEncrypted, mode: OrderingMode.desc)]))
        .watch();
  }
}
