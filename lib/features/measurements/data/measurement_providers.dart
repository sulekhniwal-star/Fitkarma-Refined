// lib/features/measurements/data/measurement_providers.dart
// Riverpod providers for Measurements feature

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/core/storage/drift_service.dart';
import 'package:fitkarma/features/measurements/data/measurement_service.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';
import 'package:fitkarma/core/di/providers.dart';

/// Provider for database via DriftService
final measurementDatabaseProvider = Provider<AppDatabase>((ref) {
  final driftService = ref.watch(driftServiceProvider);
  return driftService.db;
});

/// Provider for user ID
final measurementUserIdProvider = FutureProvider<String>((ref) async {
  final authService = AuthAwService();
  final userId = await authService.getStoredUserId();
  if (userId == null) {
    throw Exception('User not logged in');
  }
  return userId;
});

/// Provider for Measurement service
final measurementServiceProvider = Provider<MeasurementService>((ref) {
  final db = ref.watch(measurementDatabaseProvider);
  return MeasurementService(db);
});

/// Provider for latest measurement
final latestMeasurementProvider = FutureProvider.autoDispose<BodyMeasurement?>((
  ref,
) async {
  try {
    final userId = await ref.watch(measurementUserIdProvider.future);
    final service = ref.watch(measurementServiceProvider);
    return service.getLatestMeasurement(userId);
  } catch (e) {
    return null;
  }
});

/// Provider for measurements in last 30 days
final measurements30DaysProvider =
    FutureProvider.autoDispose<List<BodyMeasurement>>((ref) async {
      try {
        final userId = await ref.watch(measurementUserIdProvider.future);
        final service = ref.watch(measurementServiceProvider);
        return service.getMeasurements30Days(userId);
      } catch (e) {
        return [];
      }
    });

/// Provider for measurements in last 90 days
final measurements90DaysProvider =
    FutureProvider.autoDispose<List<BodyMeasurement>>((ref) async {
      try {
        final userId = await ref.watch(measurementUserIdProvider.future);
        final service = ref.watch(measurementServiceProvider);
        return service.getMeasurements90Days(userId);
      } catch (e) {
        return [];
      }
    });

/// Provider for measurements in last 180 days
final measurements180DaysProvider =
    FutureProvider.autoDispose<List<BodyMeasurement>>((ref) async {
      try {
        final userId = await ref.watch(measurementUserIdProvider.future);
        final service = ref.watch(measurementServiceProvider);
        return service.getMeasurements180Days(userId);
      } catch (e) {
        return [];
      }
    });

/// Provider for user's height (from measurements or profile)
final userHeightProvider = FutureProvider.autoDispose<double?>((ref) async {
  try {
    final userId = await ref.watch(measurementUserIdProvider.future);
    final service = ref.watch(measurementServiceProvider);
    return service.getUserHeight(userId);
  } catch (e) {
    return null;
  }
});

/// Provider for progress photos
final progressPhotosProvider = FutureProvider.autoDispose<List<String>>((
  ref,
) async {
  try {
    final userId = await ref.watch(measurementUserIdProvider.future);
    final service = ref.watch(measurementServiceProvider);
    return service.getProgressPhotos(userId);
  } catch (e) {
    return [];
  }
});

/// Provider for BMI calculation from latest measurement
final bmiCalculationProvider = FutureProvider.autoDispose<BmiCategoryInfo>((
  ref,
) async {
  final measurement = await ref.watch(latestMeasurementProvider.future);
  if (measurement == null) {
    return BmiCalculator.getCategoryInfo(null);
  }

  final bmi = BmiCalculator.calculate(
    measurement.weightKg,
    measurement.heightCm,
  );
  return BmiCalculator.getCategoryInfo(bmi);
});

/// Provider for waist-to-hip ratio
final waistHipRatioProvider = FutureProvider.autoDispose<WaistHipRatioRiskInfo>(
  (ref) async {
    final measurement = await ref.watch(latestMeasurementProvider.future);
    if (measurement == null) {
      return WaistHipRatioCalculator.getRiskInfo(null);
    }

    final ratio = WaistHipRatioCalculator.calculate(
      measurement.waistCm,
      measurement.hipCm,
    );

    // Get user's gender from profile
    String? gender;
    try {
      final db = ref.watch(measurementDatabaseProvider);
      final userId = await ref.watch(measurementUserIdProvider.future);
      final profile = await (db.select(
        db.userProfiles,
      )..where((tbl) => tbl.userId.equals(userId))).getSingleOrNull();
      gender = profile?.gender;
    } catch (_) {}

    return WaistHipRatioCalculator.getRiskInfo(ratio, gender: gender);
  },
);

/// Provider for waist-to-height ratio
final waistHeightRatioProvider =
    FutureProvider.autoDispose<WaistHeightRatioRiskInfo>((ref) async {
      final measurement = await ref.watch(latestMeasurementProvider.future);
      if (measurement == null) {
        return WaistHeightRatioCalculator.getRiskInfo(null);
      }

      final height = await ref.watch(userHeightProvider.future);

      final ratio = WaistHeightRatioCalculator.calculate(
        measurement.waistCm,
        height ?? measurement.heightCm,
      );
      return WaistHeightRatioCalculator.getRiskInfo(ratio);
    });

/// Selected time range for charts
enum MeasurementTimeRange { days30, days90, days180 }

/// Provider for selected time range (uses a simple Provider with a mutable ref)
final measurementTimeRangeProvider = Provider<MeasurementTimeRange>((ref) {
  return MeasurementTimeRange.days30;
});

/// Provider for measurements based on selected time range
final measurementsByTimeRangeProvider =
    FutureProvider.autoDispose<List<BodyMeasurement>>((ref) async {
      final timeRange = ref.watch(measurementTimeRangeProvider);
      final userId = await ref.watch(measurementUserIdProvider.future);
      final service = ref.watch(measurementServiceProvider);

      switch (timeRange) {
        case MeasurementTimeRange.days30:
          return service.getMeasurements30Days(userId);
        case MeasurementTimeRange.days90:
          return service.getMeasurements90Days(userId);
        case MeasurementTimeRange.days180:
          return service.getMeasurements180Days(userId);
      }
    });

/// Notifier for measurement operations
class MeasurementNotifier extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<BodyMeasurement?> saveMeasurement({
    required DateTime measuredAt,
    double? weightKg,
    double? heightCm,
    double? bodyFatPercentage,
    double? waistCm,
    double? hipCm,
    double? chestCm,
    double? armsCm,
    double? thighsCm,
    File? photoFile,
  }) async {
    state = const AsyncValue.loading();

    try {
      final service = ref.read(measurementServiceProvider);
      final userId = await ref.read(measurementUserIdProvider.future);

      String? photoPath;
      if (photoFile != null) {
        photoPath = await service.saveProgressPhoto(userId, photoFile);
      }

      final measurement = await service.saveMeasurement(
        userId: userId,
        measuredAt: measuredAt,
        weightKg: weightKg,
        heightCm: heightCm,
        bodyFatPercentage: bodyFatPercentage,
        waistCm: waistCm,
        hipCm: hipCm,
        chestCm: chestCm,
        armsCm: armsCm,
        thighsCm: thighsCm,
        photoPath: photoPath,
      );

      state = const AsyncValue.data(null);

      // Invalidate related providers
      ref.invalidate(latestMeasurementProvider);
      ref.invalidate(measurements30DaysProvider);
      ref.invalidate(measurements90DaysProvider);
      ref.invalidate(measurements180DaysProvider);
      ref.invalidate(measurementsByTimeRangeProvider);
      ref.invalidate(bmiCalculationProvider);
      ref.invalidate(waistHipRatioProvider);
      ref.invalidate(waistHeightRatioProvider);
      ref.invalidate(progressPhotosProvider);

      return measurement;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<void> deleteMeasurement(String id) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(measurementServiceProvider);
      await service.deleteMeasurement(id);
      state = const AsyncValue.data(null);

      // Invalidate related providers
      ref.invalidate(latestMeasurementProvider);
      ref.invalidate(measurements30DaysProvider);
      ref.invalidate(measurements90DaysProvider);
      ref.invalidate(measurements180DaysProvider);
      ref.invalidate(measurementsByTimeRangeProvider);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

/// Provider for measurement notifier
final measurementNotifierProvider =
    NotifierProvider<MeasurementNotifier, AsyncValue<void>>(() {
      return MeasurementNotifier();
    });
