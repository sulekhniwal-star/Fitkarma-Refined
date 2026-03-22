import 'package:flutter/material.dart';
import 'package:fitkarma/features/insight_engine/models/insight_rule.dart';

/// Rules related to blood pressure monitoring
class BpNormalRule extends InsightRule {
  @override
  String get id => 'bp_normal';

  @override
  String get name => 'Blood Pressure Normal';

  @override
  InsightCategory get category => InsightCategory.health;

  @override
  InsightPriority get priority => InsightPriority.high;

  @override
  int get iconCodePoint => Icons.favorite.codePoint;

  @override
  int get colorValue => 0xFF4CAF50; // Green

  @override
  int get cooldownDays => 5;

  @override
  List<String> get requiredDataTypes => ['bloodPressure'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableHealthInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final systolic = userData['systolicBp'] as int?;
    final diastolic = userData['diastolicBp'] as int?;

    if (systolic == null || diastolic == null) return null;

    if (systolic < 120 && diastolic < 80) {
      return '❤️ Your BP is optimal ($systolic/$diastolic mmHg). Great job!';
    } else if (systolic < 130 && diastolic < 80) {
      return '👍 Your BP is elevated ($systolic/$diastolic mmHg). Keep it up!';
    }
    return null;
  }
}

class BpWarningRule extends InsightRule {
  @override
  String get id => 'bp_warning';

  @override
  String get name => 'Blood Pressure Warning';

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
  List<String> get requiredDataTypes => ['bloodPressure'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableHealthInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final systolic = userData['systolicBp'] as int?;
    final diastolic = userData['diastolicBp'] as int?;

    if (systolic == null || diastolic == null) return null;

    // High BP - Stage 1 or 2 hypertension
    if (systolic >= 140 || diastolic >= 90) {
      return '⚠️ Your BP is high ($systolic/$diastolic mmHg). Consult your doctor.';
    } else if (systolic >= 130 || diastolic >= 80) {
      return '⚡ Your BP is elevated ($systolic/$diastolic mmHg). Monitor closely and reduce salt.';
    }
    return null;
  }
}

class BpImprovementRule extends InsightRule {
  @override
  String get id => 'bp_improvement';

  @override
  String get name => 'BP Improvement';

  @override
  InsightCategory get category => InsightCategory.health;

  @override
  InsightPriority get priority => InsightPriority.medium;

  @override
  int get iconCodePoint => Icons.trending_down.codePoint;

  @override
  int get colorValue => 0xFF2196F3; // Blue

  @override
  int get cooldownDays => 7;

  @override
  List<String> get requiredDataTypes => ['bloodPressure'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableHealthInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    // This would need historical comparison - simplified
    // In production, we'd compare with previous readings
    return null;
  }
}

/// Get all BP rules
List<InsightRule> getBpRules() {
  return [BpNormalRule(), BpWarningRule(), BpImprovementRule()];
}
