import 'package:health/health.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'health_service.g.dart';

class HealthService {
  final Health _health = Health();

  Future<bool> requestPermissions() async {
    final types = [HealthDataType.STEPS];
    final permissions = [HealthDataAccess.READ];
    return await _health.requestAuthorization(types, permissions: permissions);
  }

  Future<int> getSteps(DateTime start, DateTime end) async {
    try {
      final steps = await _health.getTotalStepsInInterval(start, end);
      return steps ?? 0;
    } catch (e) {
      return 0;
    }
  }

  Future<int> todaySteps() async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    return getSteps(midnight, now);
  }
}

@Riverpod(keepAlive: true)
HealthService healthService(HealthServiceRef ref) {
  return HealthService();
}
