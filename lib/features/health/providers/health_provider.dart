import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../auth/providers/auth_provider.dart';
import '../repositories/health_repository.dart';

part 'health_provider.g.dart';

@riverpod
class BPNotifier extends _$BPNotifier {
  @override
  Stream<List<BpReading>> build() {
    final authState = ref.watch(authProvider);
    final user = authState.asData?.value;
    if (user == null) return Stream.value([]);

    // Watch last 30 days by default for the list
    final start = DateTime.now().subtract(const Duration(days: 30));
    final db = ref.watch(appDatabaseProvider);
    return (db.select(db.bpReadings)
          ..where((t) => t.userId.equals(user.$id))
          ..where((t) => t.measuredAt.isBiggerOrEqualValue(start))
          ..orderBy([(t) => OrderingTerm.desc(t.measuredAt)]))
        .watch();
  }

  Future<void> logReading({
    required int systolic,
    required int diastolic,
    int? pulse,
    String? notes,
  }) async {
    final authState = ref.read(authProvider);
    final user = authState.asData?.value;
    if (user == null) return;

    final db = ref.read(appDatabaseProvider);
    final id = const Uuid().v4();
    
    final companion = BpReadingsCompanion.insert(
      id: id,
      userId: user.$id,
      systolic: systolic,
      diastolic: diastolic,
      pulse: Value(pulse),
      measuredAt: DateTime.now(),
      notes: Value(notes),
    );

    await db.into(db.bpReadings).insert(companion);
    
    try {
      await ref.read(healthRepositoryProvider).pushBpToRemote(id);
    } catch (_) {}
  }
}

@riverpod
Stream<BpReading?> latestBpReading(Ref ref) {
  final authState = ref.watch(authProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value(null);

  return ref.watch(appDatabaseProvider).watchLatestBpReading(user.$id);
}

@riverpod
class GlucoseNotifier extends _$GlucoseNotifier {
  @override
  Stream<List<GlucoseReading>> build() {
    final authState = ref.watch(authProvider);
    final user = authState.asData?.value;
    if (user == null) return Stream.value([]);

    final db = ref.watch(appDatabaseProvider);
    return (db.select(db.glucoseReadings)
          ..where((t) => t.userId.equals(user.$id))
          ..orderBy([(t) => OrderingTerm.desc(t.measuredAt)]))
        .watch();
  }

  Future<void> logReading({
    required double value,
    required String readingType,
    String? linkedFoodLogId,
  }) async {
    final authState = ref.read(authProvider);
    final user = authState.asData?.value;
    if (user == null) return;

    final db = ref.read(appDatabaseProvider);
    final id = const Uuid().v4();
    
    final companion = GlucoseReadingsCompanion.insert(
      id: id,
      userId: user.$id,
      valueMgDl: value,
      readingType: readingType,
      measuredAt: DateTime.now(),
      linkedFoodLogId: Value(linkedFoodLogId),
    );

    await db.into(db.glucoseReadings).insert(companion);
    
    try {
      await ref.read(healthRepositoryProvider).pushGlucoseToRemote(id);
    } catch (_) {}
  }
}

@riverpod
Stream<GlucoseReading?> latestGlucose(Ref ref) {
  final authState = ref.watch(authProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value(null);

  return ref.watch(appDatabaseProvider).watchLatestGlucose(user.$id);
}

@riverpod
class SpO2Notifier extends _$SpO2Notifier {
  @override
  Stream<List<Spo2Reading>> build() {
    final authState = ref.watch(authProvider);
    final user = authState.asData?.value;
    if (user == null) return Stream.value([]);

    final db = ref.watch(appDatabaseProvider);
    return (db.select(db.spo2Readings)
          ..where((t) => t.userId.equals(user.$id))
          ..orderBy([(t) => OrderingTerm.desc(t.measuredAt)]))
        .watch();
  }

  Future<void> logReading({
    required int spo2Percentage,
    int? pulse,
  }) async {
    final authState = ref.read(authProvider);
    final user = authState.asData?.value;
    if (user == null) return;

    final db = ref.read(appDatabaseProvider);
    final id = const Uuid().v4();
    
    final companion = Spo2ReadingsCompanion.insert(
      id: id,
      userId: user.$id,
      spo2Percentage: spo2Percentage,
      pulse: Value(pulse),
      measuredAt: DateTime.now(),
    );

    await db.into(db.spo2Readings).insert(companion);
    
    try {
      await ref.read(healthRepositoryProvider).pushSpo2ToRemote(id);
    } catch (_) {}
  }
}

@riverpod
class SleepNotifier extends _$SleepNotifier {
  @override
  Stream<List<SleepLog>> build() {
    final authState = ref.watch(authProvider);
    final user = authState.asData?.value;
    if (user == null) return Stream.value([]);

    return ref.watch(appDatabaseProvider).watchSleepHistory(user.$id, 30);
  }

  Future<void> logSleep({
    required DateTime start,
    required DateTime end,
    String source = 'manual',
    int? qualityScore,
  }) async {
    final authState = ref.read(authProvider);
    final user = authState.asData?.value;
    if (user == null) return;

    final db = ref.read(appDatabaseProvider);
    final id = const Uuid().v4();
    final duration = end.difference(start).inMinutes;
    
    final companion = SleepLogsCompanion.insert(
      id: id,
      userId: user.$id,
      sleepStart: start,
      sleepEnd: end,
      durationMinutes: duration,
      qualityScore: Value(qualityScore),
      source: Value(source),
    );

    await db.into(db.sleepLogs).insert(companion);
    
    try {
      await ref.read(healthRepositoryProvider).pushSleepToRemote(id);
    } catch (_) {}
  }
}

@riverpod
Stream<List<SleepLog>> sleepHistory(Ref ref, int days) {
  final authState = ref.watch(authProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value([]);

  return ref.watch(appDatabaseProvider).watchSleepHistory(user.$id, days);
}

@riverpod
double sleepDebt(Ref ref) {
  final historyAsync = ref.watch(sleepHistoryProvider(7));
  
  return historyAsync.when(
    data: (logs) {
      if (logs.isEmpty) return 0.0;
      // Target: 7 hours (420 minutes) per day
      const targetMin = 420;
      final totalMinutes = logs.fold(0, (sum, log) => sum + log.durationMinutes);
      final expectedMinutes = targetMin * 7;
      
      return (expectedMinutes - totalMinutes) / 60.0; // In hours
    },
    loading: () => 0.0,
    error: (_, __) => 0.0,
  );
}
