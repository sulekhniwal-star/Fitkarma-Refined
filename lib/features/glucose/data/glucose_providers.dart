// lib/features/glucose/data/glucose_providers.dart
// Riverpod providers for Glucose feature

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/glucose/data/glucose_service.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';

/// Provider for database instance (must be overridden)
final glucoseDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('Glucose database provider must be overridden');
});

/// Provider for user ID (must be overridden)
final glucoseUserIdProvider = FutureProvider<String>((ref) async {
  final authService = AuthAwService();
  final userId = await authService.getStoredUserId();
  if (userId == null) {
    throw Exception('User not logged in');
  }
  return userId;
});

/// Provider for Glucose service
final glucoseServiceProvider = Provider<GlucoseService>((ref) {
  final db = ref.watch(glucoseDatabaseProvider);
  return GlucoseService(db);
});

/// Provider for latest glucose log
final latestGlucoseLogProvider = FutureProvider.autoDispose<GlucoseLog?>((
  ref,
) async {
  try {
    final userId = await ref.watch(glucoseUserIdProvider.future);
    final glucoseService = ref.watch(glucoseServiceProvider);
    return glucoseService.getLatestGlucoseLog(userId);
  } catch (e) {
    return null;
  }
});

/// Provider for recent glucose logs (last 7 days)
final recentGlucoseLogsProvider = FutureProvider.autoDispose<List<GlucoseLog>>((
  ref,
) async {
  try {
    final userId = await ref.watch(glucoseUserIdProvider.future);
    final glucoseService = ref.watch(glucoseServiceProvider);
    return glucoseService.getRecentGlucoseLogs(userId, 7);
  } catch (e) {
    return [];
  }
});

/// Provider for glucose logs for last 30 days
final glucoseLogs30DaysProvider = FutureProvider.autoDispose<List<GlucoseLog>>((
  ref,
) async {
  try {
    final userId = await ref.watch(glucoseUserIdProvider.future);
    final glucoseService = ref.watch(glucoseServiceProvider);
    return glucoseService.getRecentGlucoseLogs(userId, 30);
  } catch (e) {
    return [];
  }
});

/// Provider for glucose logs for last 90 days (for HbA1c estimate)
final glucoseLogs90DaysProvider = FutureProvider.autoDispose<List<GlucoseLog>>((
  ref,
) async {
  try {
    final userId = await ref.watch(glucoseUserIdProvider.future);
    final glucoseService = ref.watch(glucoseServiceProvider);
    return glucoseService.getRecentGlucoseLogs(userId, 90);
  } catch (e) {
    return [];
  }
});

/// Provider for glucose statistics (last 7 days)
final glucoseStatistics7DaysProvider =
    FutureProvider.autoDispose<GlucoseStatistics>((ref) async {
      try {
        final userId = await ref.watch(glucoseUserIdProvider.future);
        final glucoseService = ref.watch(glucoseServiceProvider);
        return glucoseService.getGlucoseStatistics(userId, 7);
      } catch (e) {
        return GlucoseStatistics.empty();
      }
    });

/// Provider for glucose statistics (last 30 days)
final glucoseStatistics30DaysProvider =
    FutureProvider.autoDispose<GlucoseStatistics>((ref) async {
      try {
        final userId = await ref.watch(glucoseUserIdProvider.future);
        final glucoseService = ref.watch(glucoseServiceProvider);
        return glucoseService.getGlucoseStatistics(userId, 30);
      } catch (e) {
        return GlucoseStatistics.empty();
      }
    });

/// Provider for glucose statistics (last 90 days)
final glucoseStatistics90DaysProvider =
    FutureProvider.autoDispose<GlucoseStatistics>((ref) async {
      try {
        final userId = await ref.watch(glucoseUserIdProvider.future);
        final glucoseService = ref.watch(glucoseServiceProvider);
        return glucoseService.getGlucoseStatistics(userId, 90);
      } catch (e) {
        return GlucoseStatistics.empty();
      }
    });

/// Provider for 90-day HbA1c estimate
final hba1cEstimateProvider =
    FutureProvider.autoDispose<
      ({double averageGlucose, double estimatedHbA1c})
    >((ref) async {
      try {
        final userId = await ref.watch(glucoseUserIdProvider.future);
        final glucoseService = ref.watch(glucoseServiceProvider);
        return glucoseService.get90DayHbA1cEstimate(userId);
      } catch (e) {
        return (averageGlucose: 0.0, estimatedHbA1c: 0.0);
      }
    });

/// Helper class for glucose logging actions
class GlucoseLoggingHelper {
  final Ref ref;

  GlucoseLoggingHelper(this.ref);

  /// Log a new glucose reading and award XP
  Future<GlucoseLog?> logGlucose({
    required double glucoseMgdl,
    required GlucoseReadingType readingType,
    String? foodLogId,
    String source = 'manual',
  }) async {
    try {
      final userId = await ref.read(glucoseUserIdProvider.future);
      final glucoseService = ref.read(glucoseServiceProvider);

      // Log the glucose
      final log = await glucoseService.logGlucose(
        userId: userId,
        glucoseMgdl: glucoseMgdl,
        readingType: readingType,
        foodLogId: foodLogId,
        source: source,
      );

      // Award XP
      await _awardXp(5);

      // Invalidate related providers to refresh UI
      ref.invalidate(latestGlucoseLogProvider);
      ref.invalidate(recentGlucoseLogsProvider);
      ref.invalidate(glucoseLogs30DaysProvider);
      ref.invalidate(glucoseLogs90DaysProvider);
      ref.invalidate(glucoseStatistics7DaysProvider);
      ref.invalidate(glucoseStatistics30DaysProvider);
      ref.invalidate(glucoseStatistics90DaysProvider);
      ref.invalidate(hba1cEstimateProvider);

      return log;
    } catch (e) {
      return null;
    }
  }

  /// Link glucose log to food log
  Future<void> linkToFoodLog(String glucoseLogId, String foodLogId) async {
    try {
      final glucoseService = ref.read(glucoseServiceProvider);
      await glucoseService.linkToFoodLog(glucoseLogId, foodLogId);
      ref.invalidate(recentGlucoseLogsProvider);
    } catch (e) {
      // Silent fail
    }
  }

  /// Unlink glucose log from food log
  Future<void> unlinkFromFoodLog(String glucoseLogId) async {
    try {
      final glucoseService = ref.read(glucoseServiceProvider);
      await glucoseService.unlinkFromFoodLog(glucoseLogId);
      ref.invalidate(recentGlucoseLogsProvider);
    } catch (e) {
      // Silent fail
    }
  }

  /// Delete a glucose log
  Future<void> deleteGlucoseLog(String logId) async {
    try {
      final glucoseService = ref.read(glucoseServiceProvider);
      await glucoseService.deleteGlucoseLog(logId);

      // Invalidate related providers to refresh UI
      ref.invalidate(latestGlucoseLogProvider);
      ref.invalidate(recentGlucoseLogsProvider);
      ref.invalidate(glucoseLogs30DaysProvider);
      ref.invalidate(glucoseLogs90DaysProvider);
      ref.invalidate(glucoseStatistics7DaysProvider);
      ref.invalidate(glucoseStatistics30DaysProvider);
      ref.invalidate(glucoseStatistics90DaysProvider);
      ref.invalidate(hba1cEstimateProvider);
    } catch (e) {
      // Silent fail
    }
  }

  /// Award XP to user
  Future<void> _awardXp(int xpAmount) async {
    try {
      final db = ref.read(glucoseDatabaseProvider);
      final authService = AuthAwService();
      final userId = await authService.getStoredUserId();

      if (userId == null) return;

      final profile = await (db.select(
        db.userProfiles,
      )..where((t) => t.userId.equals(userId))).getSingleOrNull();

      if (profile != null) {
        final newXp = profile.xpPoints + xpAmount;
        await (db.update(db.userProfiles)
              ..where((t) => t.userId.equals(userId)))
            .write(UserProfilesCompanion(xpPoints: Value(newXp)));
      }
    } catch (e) {
      // Silent fail for XP
    }
  }
}

/// Provider for glucose logging helper
final glucoseLoggingHelperProvider = Provider<GlucoseLoggingHelper>((ref) {
  return GlucoseLoggingHelper(ref);
});

/// Provider for glucose logs by date range
final glucoseLogsByDateRangeProvider = FutureProvider.family
    .autoDispose<List<GlucoseLog>, ({DateTime start, DateTime end})>((
      ref,
      params,
    ) async {
      try {
        final userId = await ref.watch(glucoseUserIdProvider.future);
        final glucoseService = ref.watch(glucoseServiceProvider);
        return glucoseService.getGlucoseLogsByDateRange(
          userId,
          params.start,
          params.end,
        );
      } catch (e) {
        return [];
      }
    });

/// Provider for glucose logs linked to a specific food log
final glucoseLogsForFoodLogProvider = FutureProvider.family
    .autoDispose<List<GlucoseLog>, String>((ref, foodLogId) async {
      try {
        final glucoseService = ref.watch(glucoseServiceProvider);
        return glucoseService.getGlucoseLogsForFoodLog(foodLogId);
      } catch (e) {
        return [];
      }
    });

/// Provider for target bands based on reading type
final glucoseTargetBandsProvider =
    Provider.family<GlucoseTargetBands, GlucoseReadingType>((ref, readingType) {
      final glucoseService = ref.watch(glucoseServiceProvider);
      return glucoseService.getTargetBands(readingType);
    });
