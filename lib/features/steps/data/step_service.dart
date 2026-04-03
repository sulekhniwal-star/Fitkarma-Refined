import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/di/providers.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:drift/drift.dart';

final stepServiceProvider = Provider<StepService>((ref) => StepService(ref));

class StepService {
  final Ref _ref;
  bool _healthPermissionGranted = false;
  int _cachedSteps = 0;

  StepService(this._ref);

  Future<bool> requestHealthPermissions() async {
    _healthPermissionGranted = true;
    return true;
  }

  Future<int> getTodaySteps() async {
    return _cachedSteps;
  }

  Future<void> saveStepsToDb(int steps, String odUserId) async {
    if (steps <= 0) return;

    final db = _ref.read(driftDatabaseProvider);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    await db.into(db.stepLogs).insert(
      StepLogsCompanion.insert(
        userId: odUserId,
        steps: steps,
        date: today,
      ),
    );
  }

  Future<List<StepLog>> getStepsHistory(String odUserId, int days) async {
    final db = _ref.read(driftDatabaseProvider);
    final endDate = DateTime.now();
    final startDate = endDate.subtract(Duration(days: days));

    final query = db.select(db.stepLogs)
      ..where((t) => t.userId.equals(odUserId) & t.date.isBiggerOrEqualValue(startDate));
    return query.get();
  }

  Future<int> get7DayAverage() async {
    final db = _ref.read(driftDatabaseProvider);
    final endDate = DateTime.now();
    final startDate = endDate.subtract(const Duration(days: 7));

    final query = db.select(db.stepLogs)
      ..where((t) => t.date.isBiggerOrEqualValue(startDate));
    final logs = await query.get();

    if (logs.isEmpty) return 0;

    int total = 0;
    for (final log in logs) {
      total += log.steps;
    }
    return (total / logs.length).round();
  }

  int calculateAdaptiveGoal(int avgSteps) {
    if (avgSteps < 3000) return 5000;
    if (avgSteps < 5000) return 7000;
    if (avgSteps < 8000) return 10000;
    if (avgSteps < 12000) return 12000;
    return avgSteps + 2000;
  }

  Future<int> calculateXp(int steps) async {
    const baseGoal = 10000;
    if (steps < baseGoal) return 0;
    
    final bonusSteps = steps - baseGoal;
    final xp = (bonusSteps / 1000 * 5).floor();
    return xp.clamp(0, 50);
  }

  void setCachedSteps(int steps) {
    _cachedSteps = steps;
  }
}

class StepGoalNotifier extends Notifier<int> {
  @override
  int build() => 10000;

  Future<void> refreshGoal() async {
    final ref = this.ref;
    final service = ref.read(stepServiceProvider);
    final avg = await service.get7DayAverage();
    state = service.calculateAdaptiveGoal(avg);
  }

  void setCustomGoal(int goal) => state = goal;
}

final stepGoalProvider = NotifierProvider<StepGoalNotifier, int>(() => StepGoalNotifier());

class DailyStepsNotifier extends Notifier<DailySteps> {
  @override
  DailySteps build() => DailySteps.empty();

  Future<void> refresh() async {
    final ref = this.ref;
    final service = ref.read(stepServiceProvider);
    final steps = await service.getTodaySteps();
    final goal = ref.read(stepGoalProvider);
    
    state = DailySteps(
      todaySteps: steps,
      goal: goal,
      lastUpdated: DateTime.now(),
    );
  }
}

final dailyStepsProvider = NotifierProvider<DailyStepsNotifier, DailySteps>(() => DailyStepsNotifier());

class DailySteps {
  final int todaySteps;
  final int goal;
  final DateTime lastUpdated;

  DailySteps({
    required this.todaySteps,
    required this.goal,
    required this.lastUpdated,
  });

  factory DailySteps.empty() => DailySteps(
    todaySteps: 0,
    goal: 10000,
    lastUpdated: DateTime.now(),
  );

  double get progress => (todaySteps / goal).clamp(0.0, 1.0);
  int get stepsRemaining => goal - todaySteps;
  bool get goalReached => todaySteps >= goal;
}