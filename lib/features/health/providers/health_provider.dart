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
  Stream<List<dynamic>> build() {
    final authState = ref.watch(authProvider);
    final user = authState.asData?.value;
    if (user == null) return Stream.value([]);

    final db = ref.watch(appDatabaseProvider);
    return (db.select(db.bpReadings)
          ..where((t) => t.userId.equals(user.$id))
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
      syncStatus: const Value('pending'),
    );

    await db.into(db.bpReadings).insert(companion);
    
    _pushBpToRemote(id);
  }

  Future<void> _pushBpToRemote(String id) async {
    try {
      await ref.read(healthRepositoryProvider).pushBpToRemote(id);
    } catch (_) {}
  }

  Future<void> deleteReading(String id) async {
    final db = ref.read(appDatabaseProvider);
    await (db.delete(db.bpReadings)..where((t) => t.id.equals(id))).go();
  }
}

@riverpod
Stream<dynamic> latestBpReading(Ref ref) {
  final authState = ref.watch(authProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value(null);

  return ref.watch(appDatabaseProvider).watchLatestBpReading(user.$id);
}

@riverpod
Stream<List<dynamic>> bpHistory(Ref ref, int days) {
  final authState = ref.watch(authProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value([]);

  final start = DateTime.now().subtract(Duration(days: days));
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.bpReadings)
        ..where((t) => t.userId.equals(user.$id))
        ..where((t) => t.measuredAt.isBiggerOrEqualValue(start))
        ..orderBy([(t) => OrderingTerm.desc(t.measuredAt)]))
      .watch();
}

@riverpod
class GlucoseNotifier extends _$GlucoseNotifier {
  @override
  Stream<List<dynamic>> build() {
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
      syncStatus: const Value('pending'),
    );

    await db.into(db.glucoseReadings).insert(companion);
    
    _pushGlucoseToRemote(id);
  }

  Future<void> _pushGlucoseToRemote(String id) async {
    try {
      await ref.read(healthRepositoryProvider).pushGlucoseToRemote(id);
    } catch (_) {}
  }

  Future<void> deleteReading(String id) async {
    final db = ref.read(appDatabaseProvider);
    await (db.delete(db.glucoseReadings)..where((t) => t.id.equals(id))).go();
  }
}

@riverpod
Stream<dynamic> latestGlucose(Ref ref) {
  final authState = ref.watch(authProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value(null);

  return ref.watch(appDatabaseProvider).watchLatestGlucose(user.$id);
}

@riverpod
Stream<List<dynamic>> glucoseHistory(Ref ref, {required String type, required int days}) {
  final authState = ref.watch(authProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value([]);

  final start = DateTime.now().subtract(Duration(days: days));
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.glucoseReadings)
        ..where((t) => t.userId.equals(user.$id))
        ..where((t) => t.readingType.equals(type))
        ..where((t) => t.measuredAt.isBiggerOrEqualValue(start))
        ..orderBy([(t) => OrderingTerm.desc(t.measuredAt)]))
      .watch();
}

@riverpod
class SpO2Notifier extends _$SpO2Notifier {
  @override
  Stream<List<dynamic>> build() {
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
      syncStatus: const Value('pending'),
    );

    await db.into(db.spo2Readings).insert(companion);
    
    _pushSpo2ToRemote(id);
  }

  Future<void> _pushSpo2ToRemote(String id) async {
    try {
      await ref.read(healthRepositoryProvider).pushSpo2ToRemote(id);
    } catch (_) {}
  }

  Future<void> deleteReading(String id) async {
    final db = ref.read(appDatabaseProvider);
    await (db.delete(db.spo2Readings)..where((t) => t.id.equals(id))).go();
  }
}

@riverpod
Stream<dynamic> latestSpo2(Ref ref) {
  final authState = ref.watch(authProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value(null);

  return ref.watch(appDatabaseProvider).watchLatestSpo2(user.$id);
}

@riverpod
class SleepNotifier extends _$SleepNotifier {
  @override
  Stream<List<dynamic>> build() {
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
      syncStatus: const Value('pending'),
    );

    await db.into(db.sleepLogs).insert(companion);
    
    _pushSleepToRemote(id);
  }

  Future<void> _pushSleepToRemote(String id) async {
    try {
      await ref.read(healthRepositoryProvider).pushSleepToRemote(id);
    } catch (_) {}
  }

  Future<void> deleteLog(String id) async {
    final db = ref.read(appDatabaseProvider);
    await (db.delete(db.sleepLogs)..where((t) => t.id.equals(id))).go();
  }
}

@riverpod
Stream<List<dynamic>> sleepHistory(Ref ref, int days) {
  final authState = ref.watch(authProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value([]);

  return ref.watch(appDatabaseProvider).watchSleepHistory(user.$id, days);
}

@riverpod
Future<double> sleepDebt(Ref ref) async {
  final logs = await ref.watch(sleepHistoryProvider(7).future);
  
  if (logs.isEmpty) return 0.0;
  // Target: 7 hours (420 minutes) per day
  const targetMin = 420;
  final totalMinutes = logs.fold<int>(
    0,
    (sum, log) => sum + (log as dynamic).durationMinutes as int,
  );
  final expectedMinutes = targetMin * 7;
  
  return (expectedMinutes - totalMinutes) / 60.0; // In hours
}

@riverpod
class BodyMetricsNotifier extends _$BodyMetricsNotifier {
  @override
  Stream<List<dynamic>> build() {
    final authState = ref.watch(authProvider);
    final user = authState.asData?.value;
    if (user == null) return Stream.value([]);

    final db = ref.watch(appDatabaseProvider);
    return (db.select(db.weightLogs)
          ..where((t) => t.userId.equals(user.$id))
          ..orderBy([(t) => OrderingTerm.desc(t.measuredAt)]))
        .watch();
  }

  Future<void> logWeight(double kg) async {
    final authState = ref.read(authProvider);
    final user = authState.asData?.value;
    if (user == null) return;

    final db = ref.read(appDatabaseProvider);
    final id = const Uuid().v4();
    
    final companion = WeightLogsCompanion.insert(
      id: id,
      userId: user.$id,
      weightKg: kg,
      measuredAt: DateTime.now(),
      syncStatus: const Value('pending'),
    );

    await db.into(db.weightLogs).insert(companion);
    
    try {
      await ref.read(healthRepositoryProvider).pushWeightToRemote(id);
    } catch (_) {}
  }
}

@riverpod
Stream<List<dynamic>> weightHistory(Ref ref, int days) {
  final authState = ref.watch(authProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value([]);

  final start = DateTime.now().subtract(Duration(days: days));
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.weightLogs)
        ..where((t) => t.userId.equals(user.$id))
        ..where((t) => t.measuredAt.isBiggerOrEqualValue(start))
        ..orderBy([(t) => OrderingTerm.desc(t.measuredAt)]))
      .watch();
}

@riverpod
Stream<Map<String, dynamic>> bodyMetrics(Ref ref) async* {
  final authState = ref.watch(authProvider);
  final user = authState.asData?.value;
  if (user == null) {
    yield {'weight': 0.0, 'bmi': 0.0, 'height': 0.0};
    return;
  }

  final db = ref.watch(appDatabaseProvider);
  
  final profileStream = db.watchUserProfile(user.$id);
  final latestWeightStream = (db.select(db.weightLogs)
        ..where((t) => t.userId.equals(user.$id))
        ..orderBy([(t) => OrderingTerm.desc(t.measuredAt)])
        ..limit(1))
      .watchSingleOrNull();

  // Combine streams
  await for (final profile in profileStream) {
    final latestWeight = await latestWeightStream.first;
    final weight = (latestWeight as dynamic)?.weightKg ?? 0.0;
    final height = (profile as dynamic)?.heightCm ?? 0.0;
    
    double bmi = 0.0;
    if (height > 0 && weight > 0) {
      bmi = weight / ((height / 100) * (height / 100));
    }

    yield {
      'weight': weight,
      'height': height,
      'bmi': bmi,
    };
  }
}
