// lib/features/measurements/data/measurement_service.dart
// Measurement Service for body measurements with calculations

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// Service for managing body measurements with auto-calculations
class MeasurementService {
  final AppDatabase db;
  final _uuid = const Uuid();

  MeasurementService(this.db);

  /// Save a new measurement log
  Future<BodyMeasurement> saveMeasurement({
    required String userId,
    required DateTime measuredAt,
    double? weightKg,
    double? heightCm,
    double? bodyFatPercentage,
    double? waistCm,
    double? hipCm,
    double? chestCm,
    double? armsCm,
    double? thighsCm,
    String? photoPath,
  }) async {
    final id = 'measurement_${_uuid.v4()}';

    await db
        .into(db.bodyMeasurements)
        .insert(
          BodyMeasurementsCompanion.insert(
            id: id,
            userId: userId,
            measuredAt: measuredAt,
            weightKg: Value(weightKg),
            heightCm: Value(heightCm),
            bodyFatPercentage: Value(bodyFatPercentage),
            waistCm: Value(waistCm),
            hipCm: Value(hipCm),
            chestCm: Value(chestCm),
            armsCm: Value(armsCm),
            thighsCm: Value(thighsCm),
            photoPath: Value(photoPath),
          ),
        );

    // Return the saved measurement
    final saved = await (db.select(
      db.bodyMeasurements,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
    return saved;
  }

  /// Get the latest measurement for a user
  Future<BodyMeasurement?> getLatestMeasurement(String userId) async {
    return (db.select(db.bodyMeasurements)
          ..where((tbl) => tbl.userId.equals(userId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.measuredAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Get measurements for a specific date range
  Future<List<BodyMeasurement>> getMeasurementsInRange(
    String userId,
    DateTime start,
    DateTime end,
  ) async {
    return (db.select(db.bodyMeasurements)
          ..where(
            (tbl) =>
                tbl.userId.equals(userId) &
                tbl.measuredAt.isBiggerOrEqualValue(start) &
                tbl.measuredAt.isSmallerOrEqualValue(end),
          )
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.measuredAt)]))
        .get();
  }

  /// Get measurements for the last N days
  Future<List<BodyMeasurement>> getRecentMeasurements(
    String userId,
    int days,
  ) async {
    final end = DateTime.now();
    final start = end.subtract(Duration(days: days));
    return getMeasurementsInRange(userId, start, end);
  }

  /// Get measurements for 30 days
  Future<List<BodyMeasurement>> getMeasurements30Days(String userId) async {
    return getRecentMeasurements(userId, 30);
  }

  /// Get measurements for 90 days
  Future<List<BodyMeasurement>> getMeasurements90Days(String userId) async {
    return getRecentMeasurements(userId, 90);
  }

  /// Get measurements for 180 days
  Future<List<BodyMeasurement>> getMeasurements180Days(String userId) async {
    return getRecentMeasurements(userId, 180);
  }

  /// Delete a measurement
  Future<void> deleteMeasurement(String id) async {
    await (db.delete(
      db.bodyMeasurements,
    )..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Get user's height from latest measurement or user profile
  Future<double?> getUserHeight(String userId) async {
    // First check measurements
    final measurement = await getLatestMeasurement(userId);
    if (measurement?.heightCm != null) {
      return measurement!.heightCm;
    }

    // Fall back to user profile
    final profile = await (db.select(
      db.userProfiles,
    )..where((tbl) => tbl.userId.equals(userId))).getSingleOrNull();
    return profile?.heightCm;
  }

  /// Save progress photo locally (never synced to Appwrite)
  Future<String?> saveProgressPhoto(String userId, File photoFile) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final photosDir = Directory(p.join(directory.path, 'progress_photos'));

      if (!await photosDir.exists()) {
        await photosDir.create(recursive: true);
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'progress_${userId}_$timestamp.jpg';
      final savedPath = p.join(photosDir.path, fileName);

      await photoFile.copy(savedPath);
      return savedPath;
    } catch (e) {
      return null;
    }
  }

  /// Delete progress photo
  Future<void> deleteProgressPhoto(String photoPath) async {
    try {
      final file = File(photoPath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Ignore errors
    }
  }

  /// Get all progress photos for a user
  Future<List<String>> getProgressPhotos(String userId) async {
    final measurements = await getRecentMeasurements(userId, 365); // Last year
    final photos = <String>[];

    for (final m in measurements) {
      if (m.photoPath != null) {
        final file = File(m.photoPath!);
        if (await file.exists()) {
          photos.add(m.photoPath!);
        }
      }
    }

    return photos;
  }
}

/// BMI Calculator
class BmiCalculator {
  /// Calculate BMI from weight (kg) and height (cm)
  static double? calculate(double? weightKg, double? heightCm) {
    if (weightKg == null || heightCm == null || heightCm <= 0) {
      return null;
    }
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  /// Get BMI category
  static BmiCategory getCategory(double? bmi) {
    if (bmi == null) return BmiCategory.unknown;

    if (bmi < 18.5) return BmiCategory.underweight;
    if (bmi < 25) return BmiCategory.normal;
    if (bmi < 30) return BmiCategory.overweight;
    return BmiCategory.obese;
  }

  /// Get BMI category with description
  static BmiCategoryInfo getCategoryInfo(double? bmi) {
    final category = getCategory(bmi);

    switch (category) {
      case BmiCategory.underweight:
        return BmiCategoryInfo(
          category: category,
          title: 'Underweight',
          description: 'BMI below 18.5 - Consider gaining weight healthily',
          colorValue: 0xFFFF9800, // Orange
        );
      case BmiCategory.normal:
        return BmiCategoryInfo(
          category: category,
          title: 'Normal',
          description: 'BMI 18.5-24.9 - Healthy weight range',
          colorValue: 0xFF4CAF50, // Green
        );
      case BmiCategory.overweight:
        return BmiCategoryInfo(
          category: category,
          title: 'Overweight',
          description: 'BMI 25-29.9 - Consider lifestyle changes',
          colorValue: 0xFFFF9800, // Orange
        );
      case BmiCategory.obese:
        return BmiCategoryInfo(
          category: category,
          title: 'Obese',
          description: 'BMI 30+ - Consult a healthcare provider',
          colorValue: 0xFFF44336, // Red
        );
      case BmiCategory.unknown:
        return BmiCategoryInfo(
          category: category,
          title: 'Unknown',
          description: 'Insufficient data to calculate BMI',
          colorValue: 0xFF9E9E9E, // Grey
        );
    }
  }
}

enum BmiCategory { unknown, underweight, normal, overweight, obese }

class BmiCategoryInfo {
  final BmiCategory category;
  final String title;
  final String description;
  final int colorValue;

  BmiCategoryInfo({
    required this.category,
    required this.title,
    required this.description,
    required this.colorValue,
  });
}

/// Waist-to-Hip Ratio Calculator
class WaistHipRatioCalculator {
  /// Calculate waist-to-hip ratio
  static double? calculate(double? waistCm, double? hipCm) {
    if (waistCm == null || hipCm == null || hipCm <= 0) {
      return null;
    }
    return waistCm / hipCm;
  }

  /// Get health risk category based on WHO guidelines
  static WaistHipRatioRisk getRisk(double? ratio, {String? gender}) {
    if (ratio == null) return WaistHipRatioRisk.unknown;

    // Different thresholds for men and women
    final isMale = gender?.toLowerCase() == 'male';

    if (isMale) {
      if (ratio < 0.90) return WaistHipRatioRisk.low;
      if (ratio < 1.0) return WaistHipRatioRisk.moderate;
      return WaistHipRatioRisk.high;
    } else {
      if (ratio < 0.85) return WaistHipRatioRisk.low;
      if (ratio < 0.90) return WaistHipRatioRisk.moderate;
      return WaistHipRatioRisk.high;
    }
  }

  /// Get risk info
  static WaistHipRatioRiskInfo getRiskInfo(double? ratio, {String? gender}) {
    final risk = getRisk(ratio, gender: gender);

    switch (risk) {
      case WaistHipRatioRisk.low:
        return WaistHipRatioRiskInfo(
          risk: risk,
          title: 'Low Risk',
          description:
              'Your waist-to-hip ratio indicates a healthy weight distribution',
          colorValue: 0xFF4CAF50, // Green
        );
      case WaistHipRatioRisk.moderate:
        return WaistHipRatioRiskInfo(
          risk: risk,
          title: 'Moderate Risk',
          description:
              'Consider lifestyle modifications to improve weight distribution',
          colorValue: 0xFFFF9800, // Orange
        );
      case WaistHipRatioRisk.high:
        return WaistHipRatioRiskInfo(
          risk: risk,
          title: 'High Risk',
          description: 'Consult a healthcare provider for guidance',
          colorValue: 0xFFF44336, // Red
        );
      case WaistHipRatioRisk.unknown:
        return WaistHipRatioRiskInfo(
          risk: risk,
          title: 'Unknown',
          description: 'Insufficient data to calculate ratio',
          colorValue: 0xFF9E9E9E, // Grey
        );
    }
  }
}

enum WaistHipRatioRisk { unknown, low, moderate, high }

class WaistHipRatioRiskInfo {
  final WaistHipRatioRisk risk;
  final String title;
  final String description;
  final int colorValue;

  WaistHipRatioRiskInfo({
    required this.risk,
    required this.title,
    required this.description,
    required this.colorValue,
  });
}

/// Waist-to-Height Ratio Calculator
class WaistHeightRatioCalculator {
  /// Calculate waist-to-height ratio
  static double? calculate(double? waistCm, double? heightCm) {
    if (waistCm == null || heightCm == null || heightCm <= 0) {
      return null;
    }
    return waistCm / heightCm;
  }

  /// Get health risk category
  static WaistHeightRatioRisk getRisk(double? ratio) {
    if (ratio == null) return WaistHeightRatioRisk.unknown;

    // Simple thresholds based on research
    if (ratio < 0.4) return WaistHeightRatioRisk.underweight;
    if (ratio < 0.5) return WaistHeightRatioRisk.healthy;
    if (ratio < 0.6) return WaistHeightRatioRisk.overweight;
    return WaistHeightRatioRisk.obese;
  }

  /// Get risk info
  static WaistHeightRatioRiskInfo getRiskInfo(double? ratio) {
    final risk = getRisk(ratio);

    switch (risk) {
      case WaistHeightRatioRisk.underweight:
        return WaistHeightRatioRiskInfo(
          risk: risk,
          title: 'Underweight',
          description: 'Consider healthy weight gain',
          colorValue: 0xFFFF9800,
        );
      case WaistHeightRatioRisk.healthy:
        return WaistHeightRatioRiskInfo(
          risk: risk,
          title: 'Healthy',
          description: 'Your waist-to-height ratio is in the healthy range',
          colorValue: 0xFF4CAF50,
        );
      case WaistHeightRatioRisk.overweight:
        return WaistHeightRatioRiskInfo(
          risk: risk,
          title: 'Overweight',
          description: 'Consider lifestyle modifications',
          colorValue: 0xFFFF9800,
        );
      case WaistHeightRatioRisk.obese:
        return WaistHeightRatioRiskInfo(
          risk: risk,
          title: 'Obese',
          description: 'Consult a healthcare provider',
          colorValue: 0xFFF44336,
        );
      case WaistHeightRatioRisk.unknown:
        return WaistHeightRatioRiskInfo(
          risk: risk,
          title: 'Unknown',
          description: 'Insufficient data to calculate ratio',
          colorValue: 0xFF9E9E9E,
        );
    }
  }
}

enum WaistHeightRatioRisk { unknown, underweight, healthy, overweight, obese }

class WaistHeightRatioRiskInfo {
  final WaistHeightRatioRisk risk;
  final String title;
  final String description;
  final int colorValue;

  WaistHeightRatioRiskInfo({
    required this.risk,
    required this.title,
    required this.description,
    required this.colorValue,
  });
}
