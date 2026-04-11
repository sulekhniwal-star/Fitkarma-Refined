import 'package:flutter/material.dart';
import '../models/insight_rule.dart';

/// Rule for high blood glucose alert.
class GlucoseHighAlertRule extends InsightRule {
  const GlucoseHighAlertRule();

  @override
  String get id => 'glucose_high_alert';

  @override
  String get name => 'High blood glucose alert';

  @override
  InsightModule get module => InsightModule.glucose;

  @override
  InsightPriority get priority => InsightPriority.high;

  @override
  Future<InsightOutput?> evaluate(InsightContext ctx) async {
    if (ctx.recentGlucoseLogs.isEmpty) return null;

    final latest = ctx.recentGlucoseLogs.first;
    final value = (latest['value_mg_dl'] as num?)?.toDouble() ?? 0;
    final type = latest['test_type'] as String?;

    bool isHigh = false;
    if (type == 'fasting' && value >= 126) isHigh = true;
    if (type == 'after_meal' && value >= 200) isHigh = true;
    if (value >= 250) isHigh = true; // Random/Default threshold

    if (isHigh) {
      return InsightOutput(
        ruleId: 'glucose_high_alert',
        module: InsightModule.glucose,
        priority: InsightPriority.high,
        titleEn: '🩸 High Glucose: ${value.toInt()} mg/dL',
        titleHi: 'उच्च ग्लूकोज: ${value.toInt()} mg/dL',
        bodyEn: 'Your $type glucose reading is higher than target. Watch your carbohydrate intake today and stay hydrated. Consult your doctor if this persists.',
        bodyHi: 'आपका ग्लूकोज स्तर सामान्य से अधिक है। आज कार्बोहाइड्रेट कम लें।',
        actionLabel: 'Glucose Tracker',
        actionRoute: '/health/glucose',
        icon: Icons.opacity,
        color: const Color(0xFFE67E22),
      );
    }
    return null;
  }
}
