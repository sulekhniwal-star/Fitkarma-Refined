// lib/features/glucose/data/glucose_service.dart
// Glucose Service with classification, HbA1c estimation, and meal correlation

import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:uuid/uuid.dart';

/// Glucose reading types
enum GlucoseReadingType { fasting, postMeal, random, bedtime }

extension GlucoseReadingTypeExtension on GlucoseReadingType {
  String get displayName {
    switch (this) {
      case GlucoseReadingType.fasting:
        return 'Fasting';
      case GlucoseReadingType.postMeal:
        return 'Post-meal (2h)';
      case GlucoseReadingType.random:
        return 'Random';
      case GlucoseReadingType.bedtime:
        return 'Bedtime';
    }
  }

  String get dbValue {
    switch (this) {
      case GlucoseReadingType.fasting:
        return 'fasting';
      case GlucoseReadingType.postMeal:
        return 'post_meal';
      case GlucoseReadingType.random:
        return 'random';
      case GlucoseReadingType.bedtime:
        return 'bedtime';
    }
  }

  static GlucoseReadingType fromDbValue(String value) {
    switch (value) {
      case 'fasting':
        return GlucoseReadingType.fasting;
      case 'post_meal':
        return GlucoseReadingType.postMeal;
      case 'random':
        return GlucoseReadingType.random;
      case 'bedtime':
        return GlucoseReadingType.bedtime;
      default:
        return GlucoseReadingType.random;
    }
  }
}

/// Glucose Classification based on ADA guidelines
enum GlucoseClassification {
  low, // Below 70 mg/dL - hypoglycemia
  normal,
  preDiabetes,
  diabetes,
}

extension GlucoseClassificationExtension on GlucoseClassification {
  String get displayName {
    switch (this) {
      case GlucoseClassification.low:
        return 'Low';
      case GlucoseClassification.normal:
        return 'Normal';
      case GlucoseClassification.preDiabetes:
        return 'Pre-Diabetes';
      case GlucoseClassification.diabetes:
        return 'High';
    }
  }

  String get description {
    switch (this) {
      case GlucoseClassification.low:
        return 'Blood glucose is too low - consume fast-acting carbs';
      case GlucoseClassification.normal:
        return 'Blood glucose is in a healthy range';
      case GlucoseClassification.preDiabetes:
        return 'Blood glucose is elevated - consider lifestyle changes';
      case GlucoseClassification.diabetes:
        return 'Blood glucose is high - monitor closely';
    }
  }

  int get colorValue {
    switch (this) {
      case GlucoseClassification.low:
        return 0xFF9C27B0; // Purple
      case GlucoseClassification.normal:
        return 0xFF4CAF50; // Green
      case GlucoseClassification.preDiabetes:
        return 0xFFFF9800; // Orange
      case GlucoseClassification.diabetes:
        return 0xFFF44336; // Red
    }
  }

  bool get isNormal =>
      this == GlucoseClassification.normal || this == GlucoseClassification.low;
}

/// Classify fasting glucose based on ADA guidelines
/// Returns the classification based on fasting glucose value in mg/dL
GlucoseClassification classifyFasting(double glucoseMgdl) {
  if (glucoseMgdl < 70) {
    return GlucoseClassification.low;
  }
  if (glucoseMgdl < 100) {
    return GlucoseClassification.normal;
  }
  if (glucoseMgdl < 126) {
    return GlucoseClassification.preDiabetes;
  }
  return GlucoseClassification.diabetes;
}

/// Classify post-meal (2-hour) glucose based on ADA guidelines
/// Returns the classification based on post-meal glucose value in mg/dL
GlucoseClassification classifyPostMeal2h(double glucoseMgdl) {
  if (glucoseMgdl < 70) {
    return GlucoseClassification.low;
  }
  if (glucoseMgdl < 140) {
    return GlucoseClassification.normal;
  }
  if (glucoseMgdl < 200) {
    return GlucoseClassification.preDiabetes;
  }
  return GlucoseClassification.diabetes;
}

/// Classify random glucose based on ADA guidelines
/// Returns the classification based on random glucose value in mg/dL
GlucoseClassification classifyRandom(double glucoseMgdl) {
  if (glucoseMgdl < 70) {
    return GlucoseClassification.low;
  }
  if (glucoseMgdl < 140) {
    return GlucoseClassification.normal;
  }
  if (glucoseMgdl < 200) {
    return GlucoseClassification.preDiabetes;
  }
  return GlucoseClassification.diabetes;
}

/// Classify bedtime glucose (similar to fasting for overnight baseline)
GlucoseClassification classifyBedtime(double glucoseMgdl) {
  if (glucoseMgdl < 70) {
    return GlucoseClassification.low;
  }
  if (glucoseMgdl < 120) {
    return GlucoseClassification.normal;
  }
  if (glucoseMgdl < 180) {
    return GlucoseClassification.preDiabetes;
  }
  return GlucoseClassification.diabetes;
}

/// Classify glucose based on reading type
GlucoseClassification classifyGlucose(
  double glucoseMgdl,
  GlucoseReadingType readingType,
) {
  switch (readingType) {
    case GlucoseReadingType.fasting:
      return classifyFasting(glucoseMgdl);
    case GlucoseReadingType.postMeal:
      return classifyPostMeal2h(glucoseMgdl);
    case GlucoseReadingType.random:
      return classifyRandom(glucoseMgdl);
    case GlucoseReadingType.bedtime:
      return classifyBedtime(glucoseMgdl);
  }
}

/// Estimate HbA1c from average glucose
/// Uses the ADA formula: eA1c = (Avg Glucose + 46.7) / 28.7
double estimateHbA1cFromAverageGlucose(double averageGlucoseMgdl) {
  return (averageGlucoseMgdl + 46.7) / 28.7;
}

/// Calculate average glucose from HbA1c
/// Inverse of the ADA formula
double calculateAverageGlucoseFromHbA1c(double hba1cPercentage) {
  return (hba1cPercentage * 28.7) - 46.7;
}

/// Glucose Statistics
class GlucoseStatistics {
  final double averageGlucose;
  final double minGlucose;
  final double maxGlucose;
  final int totalLogs;
  final double estimatedHbA1c;
  final Map<GlucoseClassification, int> classificationCounts;
  final List<GlucoseReadingType> readingTypes;

  GlucoseStatistics({
    required this.averageGlucose,
    required this.minGlucose,
    required this.maxGlucose,
    required this.totalLogs,
    required this.estimatedHbA1c,
    required this.classificationCounts,
    required this.readingTypes,
  });

  factory GlucoseStatistics.empty() {
    return GlucoseStatistics(
      averageGlucose: 0,
      minGlucose: 0,
      maxGlucose: 0,
      totalLogs: 0,
      estimatedHbA1c: 0,
      classificationCounts: {},
      readingTypes: [],
    );
  }
}

/// Glucose Target Bands for trend chart
class GlucoseTargetBands {
  final double lowNormalMin;
  final double lowNormalMax;
  final double normalMin;
  final double normalMax;
  final double highNormalMin;
  final double highNormalMax;

  const GlucoseTargetBands({
    this.lowNormalMin = 70,
    this.lowNormalMax = 80,
    this.normalMin = 80,
    this.normalMax = 100,
    this.highNormalMin = 100,
    this.highNormalMax = 120,
  });

  /// ADA recommended target ranges for fasting glucose
  static const fasting = GlucoseTargetBands(
    lowNormalMin: 70,
    lowNormalMax: 80,
    normalMin: 80,
    normalMax: 100,
    highNormalMin: 100,
    highNormalMax: 130,
  );

  /// ADA recommended target ranges for post-meal glucose (2h)
  static const postMeal = GlucoseTargetBands(
    lowNormalMin: 70,
    lowNormalMax: 80,
    normalMin: 80,
    normalMax: 140,
    highNormalMin: 140,
    highNormalMax: 180,
  );

  /// Default/random target ranges
  static const random = GlucoseTargetBands(
    lowNormalMin: 70,
    lowNormalMax: 80,
    normalMin: 80,
    normalMax: 140,
    highNormalMin: 140,
    highNormalMax: 180,
  );

  /// Bedtime target ranges
  static const bedtime = GlucoseTargetBands(
    lowNormalMin: 70,
    lowNormalMax: 80,
    normalMin: 80,
    normalMax: 120,
    highNormalMin: 120,
    highNormalMax: 150,
  );
}

/// Glucose Service for managing glucose logs
class GlucoseService {
  final AppDatabase db;
  static const _uuid = Uuid();

  GlucoseService(this.db);

  /// Log a new glucose reading
  Future<GlucoseLog> logGlucose({
    required String userId,
    required double glucoseMgdl,
    required GlucoseReadingType readingType,
    String? foodLogId,
    String source = 'manual',
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();

    // Classify based on reading type
    final classification = classifyGlucose(glucoseMgdl, readingType);

    // Generate idempotency key
    final idempotencyKey = '${userId}_glucose_${now.millisecondsSinceEpoch}';

    final companion = GlucoseLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      glucoseMgdl: Value(glucoseMgdl),
      readingType: Value(readingType.dbValue),
      foodLogId: Value(foodLogId),
      loggedAt: Value(now),
      classification: Value(classification.displayName),
      hba1cEstimate: Value<double?>(null),
      source: Value(source),
      idempotencyKey: Value(idempotencyKey),
    );

    await db.into(db.glucoseLogs).insert(companion);

    return (await db.select(db.glucoseLogs)
          ..where((t) => t.id.equals(id)))
        .getSingle();
  }

  /// Get latest glucose log for a user
  Future<GlucoseLog?> getLatestGlucoseLog(String userId) async {
    return (db.select(db.glucoseLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Get recent glucose logs
  Future<List<GlucoseLog>> getRecentGlucoseLogs(String userId, int days) async {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    return (db.select(db.glucoseLogs)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.loggedAt.isBiggerOrEqualValue(cutoff),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.loggedAt)]))
        .get();
  }

  /// Get glucose logs by date range
  Future<List<GlucoseLog>> getGlucoseLogsByDateRange(
    String userId,
    DateTime start,
    DateTime end,
  ) async {
    return (db.select(db.glucoseLogs)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.loggedAt.isBiggerOrEqualValue(start) &
                t.loggedAt.isSmallerOrEqualValue(end),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.loggedAt)]))
        .get();
  }

  /// Get glucose logs linked to a specific food log
  Future<List<GlucoseLog>> getGlucoseLogsForFoodLog(String foodLogId) async {
    return (db.select(db.glucoseLogs)
          ..where((t) => t.foodLogId.equals(foodLogId))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .get();
  }

  /// Link a glucose log to a food log
  Future<void> linkToFoodLog(String glucoseLogId, String foodLogId) async {
    await (db.update(db.glucoseLogs)..where((t) => t.id.equals(glucoseLogId)))
        .write(GlucoseLogsCompanion(foodLogId: Value(foodLogId)));
  }

  /// Unlink a glucose log from a food log
  Future<void> unlinkFromFoodLog(String glucoseLogId) async {
    await (db.update(db.glucoseLogs)..where((t) => t.id.equals(glucoseLogId)))
        .write(const GlucoseLogsCompanion(foodLogId: Value(null)));
  }

  /// Get glucose statistics for a period
  Future<GlucoseStatistics> getGlucoseStatistics(
    String userId,
    int days,
  ) async {
    final logs = await getRecentGlucoseLogs(userId, days);

    if (logs.isEmpty) {
      return GlucoseStatistics.empty();
    }

    final glucoseValues = logs
        .map((l) => l.glucoseMgdl)
        .where((g) => g != null)
        .cast<double>()
        .toList();

    if (glucoseValues.isEmpty) {
      return GlucoseStatistics.empty();
    }

    final average =
        glucoseValues.reduce((a, b) => a + b) / glucoseValues.length;
    final minVal = glucoseValues.reduce((a, b) => a < b ? a : b);
    final maxVal = glucoseValues.reduce((a, b) => a > b ? a : b);

    // Count classifications
    final Map<GlucoseClassification, int> counts = {};
    for (final log in logs) {
      final classification = _getClassificationFromString(log.classification);
      counts[classification] = (counts[classification] ?? 0) + 1;
    }

    // Get reading types
    final readingTypes = logs
        .map((l) => GlucoseReadingTypeExtension.fromDbValue(l.readingType))
        .toSet()
        .toList();

    // Estimate HbA1c
    final estimatedHbA1c = estimateHbA1cFromAverageGlucose(average);

    return GlucoseStatistics(
      averageGlucose: average,
      minGlucose: minVal,
      maxGlucose: maxVal,
      totalLogs: logs.length,
      estimatedHbA1c: estimatedHbA1c,
      classificationCounts: counts,
      readingTypes: readingTypes,
    );
  }

  /// Get 90-day average glucose and estimated HbA1c
  Future<({double averageGlucose, double estimatedHbA1c})>
  get90DayHbA1cEstimate(String userId) async {
    final stats = await getGlucoseStatistics(userId, 90);
    return (
      averageGlucose: stats.averageGlucose,
      estimatedHbA1c: stats.estimatedHbA1c,
    );
  }

  /// Delete a glucose log
  Future<void> deleteGlucoseLog(String logId) async {
    await (db.delete(db.glucoseLogs)..where((t) => t.id.equals(logId))).go();
  }

  /// Get all glucose logs for a user
  Future<List<GlucoseLog>> getAllGlucoseLogs(String userId) async {
    return (db.select(db.glucoseLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .get();
  }

  /// Helper to get classification from string
  GlucoseClassification _getClassificationFromString(String value) {
    switch (value.toLowerCase()) {
      case 'low':
        return GlucoseClassification.low;
      case 'normal':
        return GlucoseClassification.normal;
      case 'pre-diabetes':
      case 'pre diabetes':
        return GlucoseClassification.preDiabetes;
      case 'high':
      case 'diabetes':
        return GlucoseClassification.diabetes;
      default:
        return GlucoseClassification.normal;
    }
  }

  /// Get target bands for a reading type
  GlucoseTargetBands getTargetBands(GlucoseReadingType readingType) {
    switch (readingType) {
      case GlucoseReadingType.fasting:
        return GlucoseTargetBands.fasting;
      case GlucoseReadingType.postMeal:
        return GlucoseTargetBands.postMeal;
      case GlucoseReadingType.random:
        return GlucoseTargetBands.random;
      case GlucoseReadingType.bedtime:
        return GlucoseTargetBands.bedtime;
    }
  }
}
