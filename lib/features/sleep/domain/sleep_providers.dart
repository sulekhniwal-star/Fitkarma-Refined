import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/sleep_drift_service.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';

final sleepDriftServiceProvider = Provider<SleepDriftService>((ref) {
  final db = ref.watch(driftDbProvider);
  return SleepDriftService(db);
});

final sleepLogsProvider = StreamProvider<List<SleepLog>>((ref) {
  final service = ref.watch(sleepDriftServiceProvider);
  return service.getWeeklyLogs('current_user');
});

final lastNightSleepProvider = Provider<SleepLog?>((ref) {
  final logs = ref.watch(sleepLogsProvider).value;
  if (logs == null || logs.isEmpty) return null;
  return logs.first;
});

final sleepDebtProvider = Provider<int>((ref) {
  final logs = ref.watch(sleepLogsProvider).value ?? [];
  final service = ref.watch(sleepDriftServiceProvider);
  return service.computeSleepDebt(logs);
});

final chronotypeProvider = Provider<Chronotype?>((ref) {
  final logs = ref.watch(sleepLogsProvider).value ?? [];
  final service = ref.watch(sleepDriftServiceProvider);
  return service.detectChronotype(logs);
});
