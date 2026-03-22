// lib/features/bp/data/bp_providers.dart
// Riverpod providers for BP feature

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/bp/data/bp_service.dart';

/// Provider for database instance (must be overridden)
final bpDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('BP database provider must be overridden');
});

/// Provider for user ID (must be overridden)
final bpUserIdProvider = Provider<String>((ref) {
  throw UnimplementedError('BP user ID provider must be overridden');
});

/// Provider for BP service
final bpServiceProvider = Provider<BpService>((ref) {
  final db = ref.watch(bpDatabaseProvider);
  return BpService(db);
});

/// Provider for latest BP log
final latestBpLogProvider = FutureProvider.autoDispose<BloodPressureLog?>((
  ref,
) async {
  try {
    final bpService = ref.watch(bpServiceProvider);
    final userId = ref.watch(bpUserIdProvider);
    return bpService.getLatestBpLog(userId);
  } catch (e) {
    return null;
  }
});

/// Provider for recent BP logs (last 7 days)
final recentBpLogsProvider = FutureProvider.autoDispose<List<BloodPressureLog>>(
  (ref) async {
    try {
      final bpService = ref.watch(bpServiceProvider);
      final userId = ref.watch(bpUserIdProvider);
      return bpService.getRecentBpLogs(userId, 7);
    } catch (e) {
      return [];
    }
  },
);

/// Provider for BP statistics (last 7 days)
final bpStatistics7DaysProvider = FutureProvider.autoDispose<BpStatistics>((
  ref,
) async {
  try {
    final bpService = ref.watch(bpServiceProvider);
    final userId = ref.watch(bpUserIdProvider);
    return bpService.getBpStatistics(userId, 7);
  } catch (e) {
    return BpStatistics.empty();
  }
});

/// Provider for BP statistics (last 30 days)
final bpStatistics30DaysProvider = FutureProvider.autoDispose<BpStatistics>((
  ref,
) async {
  try {
    final bpService = ref.watch(bpServiceProvider);
    final userId = ref.watch(bpUserIdProvider);
    return bpService.getBpStatistics(userId, 30);
  } catch (e) {
    return BpStatistics.empty();
  }
});

/// Provider for BP statistics (last 90 days)
final bpStatistics90DaysProvider = FutureProvider.autoDispose<BpStatistics>((
  ref,
) async {
  try {
    final bpService = ref.watch(bpServiceProvider);
    final userId = ref.watch(bpUserIdProvider);
    return bpService.getBpStatistics(userId, 90);
  } catch (e) {
    return BpStatistics.empty();
  }
});

/// Provider for BP logs in range
final bpLogsInRangeProvider = FutureProvider.family
    .autoDispose<List<BloodPressureLog>, BpRangeParams>((ref, params) async {
      try {
        final bpService = ref.watch(bpServiceProvider);
        final userId = ref.watch(bpUserIdProvider);
        return bpService.getBpLogsInRange(userId, params.start, params.end);
      } catch (e) {
        return [];
      }
    });

/// Parameters for BP range query
class BpRangeParams {
  final DateTime start;
  final DateTime end;

  BpRangeParams({required this.start, required this.end});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BpRangeParams &&
          runtimeType == other.runtimeType &&
          start == other.start &&
          end == other.end;

  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}

/// Provider for average BP
final averageBpProvider = FutureProvider.family
    .autoDispose<Map<String, double>, int>((ref, days) async {
      try {
        final bpService = ref.watch(bpServiceProvider);
        final userId = ref.watch(bpUserIdProvider);
        return bpService.getAverageBp(userId, days);
      } catch (e) {
        return {'systolic': 0, 'diastolic': 0, 'pulse': 0};
      }
    });

/// Result of BP logging
class BpLoggingResult {
  final bool success;
  final BloodPressureLog? log;
  final bool isHypertensiveCrisis;
  final BpClassification? classification;
  final String? error;

  BpLoggingResult({
    required this.success,
    this.log,
    this.isHypertensiveCrisis = false,
    this.classification,
    this.error,
  });
}

/// Provider for logging BP - returns a function to log BP
final bpLoggerProvider = Provider<BpLoggingFunction>((ref) {
  final bpService = ref.watch(bpServiceProvider);
  final userId = ref.watch(bpUserIdProvider);

  return ({required int systolic, required int diastolic, int? pulse}) async {
    // Log the BP reading
    final log = await bpService.logBp(
      userId: userId,
      systolic: systolic,
      diastolic: diastolic,
      pulse: pulse,
    );

    // Check for hypertensive crisis
    final isCrisis = isHypertensiveCrisis(systolic, diastolic);

    return BpLoggingResult(
      success: true,
      log: log,
      isHypertensiveCrisis: isCrisis,
      classification: classifyBp(systolic, diastolic),
    );
  };
});

/// Type alias for BP logging function
typedef BpLoggingFunction =
    Future<BpLoggingResult> Function({
      required int systolic,
      required int diastolic,
      int? pulse,
    });

/// Provider for selected trend period (7, 30, or 90 days)
final bpTrendPeriodProvider = Provider<int>((ref) => 7);
