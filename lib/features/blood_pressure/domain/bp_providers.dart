import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/bp_drift_service.dart';
import '../../../core/di/providers.dart';

final bpDriftServiceProvider = Provider<BPDriftService>((ref) {
  final db = ref.watch(driftDbProvider);
  return BPDriftService(db);
});

final bpLogsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final service = ref.watch(bpDriftServiceProvider);
  // Ideally get actual user ID
  return await service.getDecryptedLogs('current_user');
});

final latestBPProvider = Provider<Map<String, dynamic>?>((ref) {
  final logs = ref.watch(bpLogsProvider).value;
  if (logs == null || logs.isEmpty) return null;
  return logs.first;
});
