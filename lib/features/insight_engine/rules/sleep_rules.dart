import 'package:drift/drift.dart';
import '../models/insight_rule.dart';
import '../../../core/storage/drift_service.dart';

class SleepDebtRule extends InsightRule {
  @override
  String get id => 'sleep_debt';
  @override
  int get priority => 2;

  @override
  Future<bool> condition(DriftService dbProvider, String userId) async {
    final db = dbProvider.database;
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfMonday = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    
    final logs = await (db.select(db.sleepLogs)
          ..where((t) => t.userId.equals(userId) & t.date.isBiggerOrEqualValue(startOfMonday)))
        .get();
    
    final totalDebtMin = logs.fold(0, (sum, item) => sum + (item.sleepDebtMin ?? 0));
    return totalDebtMin > 180; // > 3 hours
  }

  @override
  Future<String> message(DriftService dbProvider, String userId) async {
    final db = dbProvider.database;
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfMonday = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    
    final logs = await (db.select(db.sleepLogs)
          ..where((t) => t.userId.equals(userId) & t.date.isBiggerOrEqualValue(startOfMonday)))
        .get();
    
    final totalDebtMin = logs.fold(0, (sum, item) => sum + (item.sleepDebtMin ?? 0));
    final hours = (totalDebtMin / 60).toStringAsFixed(1);
    
    return "You've built up $hours h sleep debt this week. Aim for 8h tonight.";
  }
}

class PoorSleepConsistencyRule extends InsightRule {
  @override
  String get id => 'poor_sleep_consistency';
  @override
  int get priority => 3;

  @override
  Future<bool> condition(DriftService dbProvider, String userId) async {
    final db = dbProvider.database;
    final now = DateTime.now();
    final sevenDaysAgo = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 7));
    
    final logs = await (db.select(db.sleepLogs)
          ..where((t) => t.userId.equals(userId) & t.date.isBiggerOrEqualValue(sevenDaysAgo)))
        .get();
    
    if (logs.length < 5) return false;

    final avgDurationMin = logs.fold(0, (sum, item) => sum + item.durationMin) / logs.length;
    return avgDurationMin < 360; // < 6 hours
  }

  @override
  Future<String> message(DriftService dbProvider, String userId) async {
    return "Your 7-day sleep average is under 6 hours. Consider drinking warm turmeric milk before bed for better Vata balance.";
  }
}

