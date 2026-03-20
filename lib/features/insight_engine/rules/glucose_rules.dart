import 'package:flutter/material.dart';
import 'package:fitkarma/features/insight_engine/models/insight_rule.dart';

/// Rules related to blood glucose monitoring
class GlucoseNormalRule extends InsightRule {
  @override
  String get id => 'glucose_normal';

  @override
  String get name => 'Blood Glucose Normal';

  @override
  InsightCategory get category => InsightCategory.health;

  @override
  InsightPriority get priority => InsightPriority.high;

  @override
  int get iconCodePoint => Icons.water_drop.codePoint;

  @override
  int get colorValue => 0xFF4CAF50; // Green

  @override
  int get cooldownDays => 5;

  @override
  List<String> get requiredDataTypes => ['glucose'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableHealthInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final glucose = userData['glucoseMgdl'] as double?;

    if (glucose == null) return null;

    // Normal fasting glucose: 70-100 mg/dL
    if (glucose >= 70 && glucose <= 100) {
      return '✅ Your blood glucose is normal (${glucose.toStringAsFixed(0)} mg/dL).';
    } else if (glucose >= 100 && glucose < 126) {
      return '⚠️ Prediabetes range (${glucose.toStringAsFixed(0)} mg/dL). Consider lifestyle changes.';
    }
    return null;
  }
}

class GlucoseHighRule extends InsightRule {
  @override
  String get id => 'glucose_high';

  @override
  String get name => 'High Blood Glucose';

  @override
  InsightCategory get category => InsightCategory.health;

  @override
  InsightPriority get priority => InsightPriority.critical;

  @override
  int get iconCodePoint => Icons.warning.codePoint;

  @override
  int get colorValue => 0xFFF44336; // Red

  @override
  int get cooldownDays => 1;

  @override
  List<String> get requiredDataTypes => ['glucose'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableHealthInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final glucose = userData['glucoseMgdl'] as double?;

    if (glucose == null) return null;

    if (glucose >= 126) {
      return '⚠️ High blood glucose (${glucose.toStringAsFixed(0)} mg/dL). Consult your doctor.';
    } else if (glucose >= 200) {
      return '🚨 Very high glucose (${glucose.toStringAsFixed(0)} mg/dL). Seek medical attention.';
    }
    return null;
  }
}

class GlucoseLowRule extends InsightRule {
  @override
  String get id => 'glucose_low';

  @override
  String get name => 'Low Blood Glucose';

  @override
  InsightCategory get category => InsightCategory.health;

  @override
  InsightPriority get priority => InsightPriority.high;

  @override
  int get iconCodePoint => Icons.battery_alert.codePoint;

  @override
  int get colorValue => 0xFFFF9800; // Orange

  @override
  int get cooldownDays => 2;

  @override
  List<String> get requiredDataTypes => ['glucose'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableHealthInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final glucose = userData['glucoseMgdl'] as double?;

    if (glucose == null) return null;

    if (glucose < 70) {
      return '⚡ Low blood glucose (${glucose.toStringAsFixed(0)} mg/dL). Have a snack!';
    }
    return null;
  }
}

/// Get all glucose rules
List<InsightRule> getGlucoseRules() {
  return [GlucoseNormalRule(), GlucoseHighRule(), GlucoseLowRule()];
}
