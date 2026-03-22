// lib/features/spo2/data/spo2_providers.dart
// Riverpod providers for SpO2 feature

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/spo2/data/spo2_service.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';

/// Provider for database instance (must be overridden)
final spo2DatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('SpO2 database provider must be overridden');
});

/// Provider for user ID
final spo2UserIdProvider = FutureProvider<String>((ref) async {
  final authService = AuthAwService();
  final userId = await authService.getStoredUserId();
  if (userId == null) {
    throw Exception('User not logged in');
  }
  return userId;
});

/// Provider for SpO2 service
final spo2ServiceProvider = Provider<SpO2Service>((ref) {
  final db = ref.watch(spo2DatabaseProvider);
  return SpO2Service(db);
});

/// Provider for latest SpO2 log
final latestSpo2LogProvider = FutureProvider.autoDispose<Spo2Log?>((ref) async {
  try {
    final userId = await ref.watch(spo2UserIdProvider.future);
    final spo2Service = ref.watch(spo2ServiceProvider);
    return spo2Service.getLatestSpO2Log(userId);
  } catch (e) {
    return null;
  }
});

/// Provider for recent SpO2 logs
final recentSpo2LogsProvider = FutureProvider.autoDispose<List<Spo2Log>>((
  ref,
) async {
  try {
    final userId = await ref.watch(spo2UserIdProvider.future);
    final spo2Service = ref.watch(spo2ServiceProvider);
    return spo2Service.getRecentSpO2Logs(userId, 30);
  } catch (e) {
    return [];
  }
});

/// Provider for SpO2 statistics (30 days)
final spo2Statistics30DaysProvider = FutureProvider.autoDispose<SpO2Statistics>(
  (ref) async {
    try {
      final userId = await ref.watch(spo2UserIdProvider.future);
      final spo2Service = ref.watch(spo2ServiceProvider);
      return spo2Service.getSpO2Statistics(userId, 30);
    } catch (e) {
      return SpO2Statistics.empty();
    }
  },
);

/// Helper class for SpO2 logging
class SpO2LoggingHelper {
  final Ref ref;

  SpO2LoggingHelper(this.ref);

  /// Log a new SpO2 reading
  Future<Spo2Log?> logSpO2({
    required double spo2Percentage,
    int? pulseRate,
    String source = 'manual',
  }) async {
    try {
      final userId = await ref.read(spo2UserIdProvider.future);
      final spo2Service = ref.read(spo2ServiceProvider);

      final log = await spo2Service.logSpO2(
        userId: userId,
        spo2Percentage: spo2Percentage,
        pulseRate: pulseRate,
        source: source,
      );

      // Invalidate providers
      ref.invalidate(latestSpo2LogProvider);
      ref.invalidate(recentSpo2LogsProvider);
      ref.invalidate(spo2Statistics30DaysProvider);

      return log;
    } catch (e) {
      return null;
    }
  }

  /// Delete an SpO2 log
  Future<void> deleteSpO2Log(String logId) async {
    try {
      final spo2Service = ref.read(spo2ServiceProvider);
      await spo2Service.deleteSpO2Log(logId);

      ref.invalidate(latestSpo2LogProvider);
      ref.invalidate(recentSpo2LogsProvider);
      ref.invalidate(spo2Statistics30DaysProvider);
    } catch (e) {
      // Silent fail
    }
  }
}

/// Provider for SpO2 logging helper
final spo2LoggingHelperProvider = Provider<SpO2LoggingHelper>((ref) {
  return SpO2LoggingHelper(ref);
});
