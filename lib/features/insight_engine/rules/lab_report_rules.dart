// lib/features/insight_engine/rules/lab_report_rules.dart
// Rules related to lab reports

import 'package:flutter/material.dart';
import 'package:fitkarma/features/insight_engine/models/insight_rule.dart';

/// Rule for users who haven't uploaded any lab data in 30 days
class LabReportDueRule extends InsightRule {
  @override
  String get id => 'lab_report_due';

  @override
  String get name => 'Lab Report Due';

  @override
  InsightCategory get category => InsightCategory.health;

  @override
  InsightPriority get priority => InsightPriority.medium;

  @override
  int get iconCodePoint => Icons.description.codePoint;

  @override
  int get colorValue => 0xFF9C27B0; // Purple

  @override
  int get cooldownDays => 30; // Show once every 30 days

  @override
  List<String> get requiredDataTypes => [
    'lastLabReportDate',
    'userActivityDate',
  ];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableHealthInsights'] != false &&
        userPreferences['enableLabReportReminders'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final lastLabReportDate = userData['lastLabReportDate'] as DateTime?;
    final userActivityDate = userData['userActivityDate'] as DateTime?;

    // If we don't have any lab report data, prompt immediately for active users
    if (lastLabReportDate == null) {
      // Check if user has been active for at least 7 days
      if (userActivityDate != null) {
        final daysSinceActivity = DateTime.now()
            .difference(userActivityDate)
            .inDays;
        if (daysSinceActivity >= 7) {
          return '📋 You haven\'t uploaded a lab report yet. Keeping track of your health metrics helps you monitor your progress over time.';
        }
      } else {
        return '📋 You haven\'t uploaded a lab report yet. Keep track of your health metrics by uploading your lab reports.';
      }
      return null;
    }

    // Check if it's been more than 30 days since last lab report
    final daysSinceLastReport = DateTime.now()
        .difference(lastLabReportDate)
        .inDays;

    if (daysSinceLastReport >= 30) {
      return '🩺 It\'s been $daysSinceLastReport days since your last lab report. Consider uploading a new one to track your health trends.';
    }

    return null;
  }
}

/// Rule for users with incomplete lab data
class LabReportIncompleteRule extends InsightRule {
  @override
  String get id => 'lab_report_incomplete';

  @override
  String get name => 'Complete Lab Data';

  @override
  InsightCategory get category => InsightCategory.health;

  @override
  InsightPriority get priority => InsightPriority.low;

  @override
  int get iconCodePoint => Icons.science.codePoint;

  @override
  int get colorValue => 0xFFFF9800; // Orange

  @override
  int get cooldownDays => 14;

  @override
  List<String> get requiredDataTypes => [
    'hasGlucose',
    'hasCholesterol',
    'hasVitaminD',
  ];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableHealthInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final hasGlucose = userData['hasGlucose'] as bool? ?? false;
    final hasCholesterol = userData['hasCholesterol'] as bool? ?? false;
    final hasVitaminD = userData['hasVitaminD'] as bool? ?? false;

    final missingMetrics = <String>[];
    if (!hasGlucose) missingMetrics.add('glucose');
    if (!hasCholesterol) missingMetrics.add('cholesterol');
    if (!hasVitaminD) missingMetrics.add('Vitamin D');

    if (missingMetrics.isNotEmpty && missingMetrics.length >= 2) {
      return '💡 Your lab data is missing ${missingMetrics.join(', ')}. Upload a lab report to get a complete picture of your health.';
    }

    return null;
  }
}

/// Get all lab report rules
List<InsightRule> getLabReportRules() {
  return [LabReportDueRule(), LabReportIncompleteRule()];
}
