// lib/features/fasting/data/fasting_providers.dart
// Riverpod providers for Fasting feature

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/core/storage/drift_service.dart';
import 'package:fitkarma/core/di/providers.dart';
import 'package:fitkarma/features/fasting/data/fasting_service.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';

/// Provider for database via DriftService
final fastingDatabaseProvider = Provider<AppDatabase>((ref) {
  final driftService = ref.watch(driftServiceProvider);
  return driftService.db;
});

/// Provider for user ID
final fastingUserIdProvider = FutureProvider<String>((ref) async {
  final authService = AuthAwService();
  final userId = await authService.getStoredUserId();
  if (userId == null) {
    throw Exception('User not logged in');
  }
  return userId;
});

/// Provider for Fasting service
final fastingServiceProvider = Provider<FastingService>((ref) {
  final db = ref.watch(fastingDatabaseProvider);
  return FastingService(db);
});

/// Provider for active fast
final activeFastProvider = FutureProvider.autoDispose<FastingLog?>((ref) async {
  try {
    final userId = await ref.watch(fastingUserIdProvider.future);
    final service = ref.watch(fastingServiceProvider);
    return service.getActiveFast(userId);
  } catch (e) {
    return null;
  }
});

/// Provider for fasting state (includes live timer updates)
final fastingStateProvider = StreamProvider.autoDispose<FastingState>((
  ref,
) async* {
  final activeFast = await ref.watch(activeFastProvider.future);

  if (activeFast == null) {
    yield FastingState();
    return;
  }

  final service = ref.watch(fastingServiceProvider);

  // Emit initial state
  yield service.calculateFastingState(activeFast);

  // Update every second
  while (true) {
    await Future.delayed(const Duration(seconds: 1));
    if (!ref.mounted) break;
    yield service.calculateFastingState(activeFast);
  }
});

/// Provider for latest completed fast
final latestCompletedFastProvider = FutureProvider.autoDispose<FastingLog?>((
  ref,
) async {
  try {
    final userId = await ref.watch(fastingUserIdProvider.future);
    final service = ref.watch(fastingServiceProvider);
    return service.getLatestCompletedFast(userId);
  } catch (e) {
    return null;
  }
});

/// Provider for fasting history
final fastingHistoryProvider = FutureProvider.autoDispose<List<FastingLog>>((
  ref,
) async {
  try {
    final userId = await ref.watch(fastingUserIdProvider.future);
    final service = ref.watch(fastingServiceProvider);
    return service.getFastingHistory(userId);
  } catch (e) {
    return [];
  }
});

/// Provider for fasting statistics
final fastingStatisticsProvider = FutureProvider.autoDispose<FastingStatistics>(
  (ref) async {
    try {
      final userId = await ref.watch(fastingUserIdProvider.future);
      final service = ref.watch(fastingServiceProvider);
      return service.getFastingStatistics(userId);
    } catch (e) {
      return FastingStatistics.empty();
    }
  },
);

/// Provider for selected protocol
final selectedProtocolProvider = StateProvider<FastingProtocol>((ref) {
  return FastingProtocol.protocol16_8;
});

/// Provider for custom fasting hours (when custom protocol selected)
final customFastingHoursProvider = StateProvider<int>((ref) => 16);

/// Provider for Ramadan mode
final ramadanModeProvider = StateProvider<bool>((ref) => false);

/// Provider for hydration alerts enabled
final hydrationAlertsEnabledProvider = StateProvider<bool>((ref) => true);

/// Provider for hydration alert interval (in minutes)
final hydrationAlertIntervalProvider = StateProvider<int>((ref) => 60);

/// Notifier for fasting operations
class FastingNotifier extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<FastingLog?> startFast({
    required FastingProtocol protocol,
    int? customFastingHours,
    bool isRamadanMode = false,
    DateTime? sehriTime,
    DateTime? iftarTime,
  }) async {
    state = const AsyncValue.loading();

    try {
      final service = ref.read(fastingServiceProvider);
      final userId = await ref.read(fastingUserIdProvider.future);

      List<int>? hydrationAlerts;
      if (ref.read(hydrationAlertsEnabledProvider)) {
        final interval = ref.read(hydrationAlertIntervalProvider);
        // Generate alert intervals based on target duration
        if (protocol == FastingProtocol.custom && customFastingHours != null) {
          final hours = customFastingHours;
          final alertCount = hours * 60 ~/ interval;
          hydrationAlerts = List.generate(
            alertCount,
            (i) => (i + 1) * interval,
          );
        } else {
          final hours = protocol.fastingHours;
          final alertCount = hours * 60 ~/ interval;
          hydrationAlerts = List.generate(
            alertCount,
            (i) => (i + 1) * interval,
          );
        }
      }

      final fasting = await service.startFast(
        userId: userId,
        protocol: protocol,
        customFastingHours: customFastingHours,
        isRamadanMode: isRamadanMode,
        sehriTime: sehriTime,
        iftarTime: iftarTime,
        hydrationAlertIntervals: hydrationAlerts,
      );

      state = const AsyncValue.data(null);

      // Invalidate related providers
      ref.invalidate(activeFastProvider);
      ref.invalidate(fastingStateProvider);
      ref.invalidate(fastingHistoryProvider);
      ref.invalidate(fastingStatisticsProvider);

      return fasting;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<FastingLog?> endFast(String fastingId) async {
    state = const AsyncValue.loading();

    try {
      final service = ref.read(fastingServiceProvider);
      final fasting = await service.endFast(fastingId);

      state = const AsyncValue.data(null);

      // Invalidate related providers
      ref.invalidate(activeFastProvider);
      ref.invalidate(fastingStateProvider);
      ref.invalidate(latestCompletedFastProvider);
      ref.invalidate(fastingHistoryProvider);
      ref.invalidate(fastingStatisticsProvider);

      return fasting;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<void> deleteFastingLog(String id) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(fastingServiceProvider);
      await service.deleteFastingLog(id);
      state = const AsyncValue.data(null);

      ref.invalidate(fastingHistoryProvider);
      ref.invalidate(fastingStatisticsProvider);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

/// Provider for fasting notifier
final fastingNotifierProvider =
    NotifierProvider<FastingNotifier, AsyncValue<void>>(() {
      return FastingNotifier();
    });
