import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/glucose_drift_service.dart';
import '../../../core/di/providers.dart';

final glucoseDriftServiceProvider = Provider<GlucoseDriftService>((ref) {
  final db = ref.watch(driftDbProvider);
  return GlucoseDriftService(db);
});

final glucoseLogsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final service = ref.watch(glucoseDriftServiceProvider);
  return await service.getDecryptedLogs('current_user');
});

final latestGlucoseProvider = Provider<Map<String, dynamic>?>((ref) {
  final logs = ref.watch(glucoseLogsProvider).value;
  if (logs == null || logs.isEmpty) return null;
  return logs.first;
});

/// Provider that calculates estimated HbA1c based on 90-day average.
final hba1cEstimateProvider = Provider<double?>((ref) {
  final logs = ref.watch(glucoseLogsProvider).value ?? [];
  if (logs.length < 30) return null;

  final ninetyDaysAgo = DateTime.now().subtract(const Duration(days: 90));
  final recentLogs = logs.where((l) => l['loggedAt'].isAfter(ninetyDaysAgo)).toList();
  
  if (recentLogs.length < 30) return null;

  final avg = recentLogs.map((l) => l['value'] as double).reduce((a, b) => a + b) / recentLogs.length;
  return (avg + 46.7) / 28.7;
});

