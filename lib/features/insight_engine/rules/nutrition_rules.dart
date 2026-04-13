import 'package:drift/drift.dart';
import '../models/insight_rule.dart';
import '../../../core/storage/drift_service.dart';

class ProteinDeficitRule extends InsightRule {
  @override
  String get id => 'protein_deficit';
  @override
  int get priority => 1;

  @override
  Future<bool> condition(DriftService dbProvider, String userId) async {
    final db = dbProvider.database;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    final goal = await (db.select(db.nutritionGoals)..where((t) => t.userId.equals(userId))).getSingleOrNull();
    if (goal == null) return false;

    final logsToday = await (db.select(db.foodLogs)
          ..where((t) => t.userId.equals(userId) & t.loggedAt.isBiggerOrEqualValue(today)))
        .get();
    
    final proteinToday = logsToday.fold(0.0, (sum, item) => sum + item.proteinG);
    return proteinToday < (goal.proteinG * 0.8);
  }

  @override
  Future<String> message(DriftService dbProvider, String userId) async {
    final db = dbProvider.database;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    final goal = await (db.select(db.nutritionGoals)..where((t) => t.userId.equals(userId))).getSingle();
    final logsToday = await (db.select(db.foodLogs)
          ..where((t) => t.userId.equals(userId) & t.loggedAt.isBiggerOrEqualValue(today)))
        .get();
    
    final proteinToday = logsToday.fold(0.0, (sum, item) => sum + item.proteinG);
    final gap = (goal.proteinG - proteinToday).toStringAsFixed(1);
    
    return "You're $gap g protein short today. Adding a katori of dal will help!";
  }
}

class MicronutrientGapRule extends InsightRule {
  @override
  String get id => 'micronutrient_gap';
  @override
  int get priority => 2;

  @override
  Future<bool> condition(DriftService dbProvider, String userId) async {
    final db = dbProvider.database;
    final now = DateTime.now();
    final fiveDaysAgo = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 5));
    
    final goal = await (db.select(db.nutritionGoals)..where((t) => t.userId.equals(userId))).getSingleOrNull();
    if (goal == null) return false;

    final logs = await (db.select(db.foodLogs)
          ..where((t) => t.userId.equals(userId) & t.loggedAt.isBiggerOrEqualValue(fiveDaysAgo)))
        .get();

    // Group logs by day and check each day
    final dailyTotals = <DateTime, Map<String, double>>{};
    for (final log in logs) {
      final date = DateTime(log.loggedAt.year, log.loggedAt.month, log.loggedAt.day);
      final totals = dailyTotals.putIfAbsent(date, () => {
        'iron': 0.0, 'b12': 0.0, 'vitD': 0.0, 'calcium': 0.0
      });
      totals['iron'] = totals['iron']! + (log.ironMg ?? 0.0);
      totals['b12'] = totals['b12']! + (log.vitaminB12Mcg ?? 0.0);
      totals['vitD'] = totals['vitD']! + (log.vitaminDMcg ?? 0.0);
      totals['calcium'] = totals['calcium']! + (log.calciumMg ?? 0.0);
    }

    if (dailyTotals.length < 5) return false;

    // Check if any nutrient was < 40% for ALL of the last 5 days recorded
    final nutrientsToCheck = ['iron', 'b12', 'vitD', 'calcium'];
    for (final nutrient in nutrientsToCheck) {
      double rda = _getRda(goal, nutrient);
      bool consistentlyLow = true;
      for (final totals in dailyTotals.values) {
        if (totals[nutrient]! >= (rda * 0.4)) {
          consistentlyLow = false;
          break;
        }
      }
      if (consistentlyLow) return true;
    }

    return false;
  }

  double _getRda(dynamic goal, String nutrient) {
    switch (nutrient) {
      case 'iron': return goal.ironMg ?? 17.0;
      case 'b12': return goal.b12Mcg ?? 2.2;
      case 'vitD': return goal.vitDMcg ?? 15.0;
      case 'calcium': return goal.calciumMg ?? 1000.0;
      default: return 1.0;
    }
  }

  @override
  Future<String> message(DriftService dbProvider, String userId) async {
    // Determine which nutrient is low for the message
    // Simplified logic: just return one that fits the criteria
    return "Your micronutrient intake is consistently low. Consider adding more spinach or fortified foods to your diet.";
  }
}
