import 'package:flutter/material.dart';
import '../models/insight_rule.dart';

/// Rule for high blood pressure alert.
class BpHighAlertRule extends InsightRule {
  const BpHighAlertRule();

  @override
  String get id => 'bp_high_alert';

  @override
  String get name => 'High blood pressure alert';

  @override
  InsightModule get module => InsightModule.bloodPressure;

  @override
  InsightPriority get priority => InsightPriority.high;

  @override
  Future<InsightOutput?> evaluate(InsightContext ctx) async {
    if (ctx.recentBpLogs.isEmpty) return null;

    final latest = ctx.recentBpLogs.first;
    final systolic = (latest['systolic'] as num?)?.toInt() ?? 0;
    final diastolic = (latest['diastolic'] as num?)?.toInt() ?? 0;

    if (systolic >= 140 || diastolic >= 90) {
      return InsightOutput(
        ruleId: 'bp_high_alert',
        module: InsightModule.bloodPressure,
        priority: InsightPriority.high,
        titleEn: '🩸 High BP Detected: $systolic/$diastolic',
        titleHi: 'उच्च रक्तचाप: $systolic/$diastolic',
        bodyEn: 'Your latest reading indicates Stage 1 or 2 Hypertension. Monitor daily and avoid high salt today. Consult your doctor if this persists.',
        bodyHi: 'आपका रक्तचाप अधिक है। नमक कम खाएं और रोजाना इसकी निगरानी करें।',
        actionLabel: 'BP Tracker',
        actionRoute: '/health/bp',
        icon: Icons.monitor_heart,
        color: const Color(0xFFE74C3C),
      );
    }
    return null;
  }
}

/// Rule for BP Crisis (Critical).
class BpCrisisRule extends InsightRule {
  const BpCrisisRule();

  @override
  String get id => 'bp_crisis';

  @override
  String get name => 'Hypertensive Crisis emergency alert';

  @override
  InsightModule get module => InsightModule.bloodPressure;

  @override
  InsightPriority get priority => InsightPriority.critical;

  @override
  Future<InsightOutput?> evaluate(InsightContext ctx) async {
    if (ctx.recentBpLogs.isEmpty) return null;

    final latest = ctx.recentBpLogs.first;
    final systolic = (latest['systolic'] as num?)?.toInt() ?? 0;
    final diastolic = (latest['diastolic'] as num?)?.toInt() ?? 0;

    if (systolic >= 180 || diastolic >= 120) {
      return const InsightOutput(
        ruleId: 'bp_crisis',
        module: InsightModule.bloodPressure,
        priority: InsightPriority.critical,
        titleEn: '🚨 BP EMERGENCY ALERT',
        titleHi: 'आपातकालीन सूचना',
        bodyEn: 'Your BP is $systolic/$diastolic. This is Hypertensive Crisis territory. Please seek immediate medical attention or contact your emergency contact.',
        bodyHi: 'आपका ब्लड प्रेशर $systolic/$diastolic है। यह खतरनाक है। कृपया तुरंत डॉक्टर से मिलें।',
        actionLabel: 'Emergency Card',
        actionRoute: '/health/emergency',
        icon: Icons.warning_rounded,
        color: Color(0xFFC0392B),
      );
    }
    return null;
  }
}
