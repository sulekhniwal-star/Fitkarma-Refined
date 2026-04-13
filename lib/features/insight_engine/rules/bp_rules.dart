import 'package:drift/drift.dart';
import '../models/insight_rule.dart';
import '../../../core/storage/drift_service.dart';

class ElevatedBPConsistencyRule extends InsightRule {
  @override
  String get id => 'elevated_bp_consistency';
  @override
  int get priority => 1;

  @override
  Future<bool> condition(DriftService dbProvider, String userId) async {
    final db = dbProvider.database;
    
    final lastReadings = await (db.select(db.bloodPressureLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)])
          ..limit(3))
        .get();

    if (lastReadings.length < 3) return false;

    // "Elevated or above" means class != 'normal'
    // Based on Phase 6.5: normal, elevated, stage1, stage2, crisis
    return lastReadings.every((r) => r.classification != 'normal');
  }

  @override
  Future<String> message(DriftService dbProvider, String userId) async {
    return "Your BP has been elevated for 3 consecutive readings. Track sodium intake and consult your doctor.";
  }
}
