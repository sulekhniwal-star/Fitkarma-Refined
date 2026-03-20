import 'package:flutter/material.dart';
import 'insight_rule.dart';

/// Status of an insight card
enum InsightStatus {
  pending, // Not yet shown to user
  shown, // Currently displayed
  dismissed, // User dismissed
  acted, // User took action
  expired, // Too old, auto-dismissed
}

/// Feedback from user on an insight
enum InsightFeedback { thumbsUp, thumbsDown, none }

/// Model representing an insight output that can be shown to the user
class InsightOutput {
  final String id;
  final String ruleId;
  final String ruleName;
  final String message;
  final InsightCategory category;
  final InsightPriority priority;
  final int iconCodePoint;
  final String iconFontFamily;
  final Color color;
  final DateTime generatedAt;
  final DateTime? expiresAt;
  final InsightStatus status;
  final InsightFeedback feedback;
  final Map<String, dynamic>? metadata;

  const InsightOutput({
    required this.id,
    required this.ruleId,
    required this.ruleName,
    required this.message,
    required this.category,
    required this.priority,
    required this.iconCodePoint,
    required this.iconFontFamily,
    required this.color,
    required this.generatedAt,
    this.expiresAt,
    this.status = InsightStatus.pending,
    this.feedback = InsightFeedback.none,
    this.metadata,
  });

  /// Create a copy with updated fields
  InsightOutput copyWith({
    String? id,
    String? ruleId,
    String? ruleName,
    String? message,
    InsightCategory? category,
    InsightPriority? priority,
    int? iconCodePoint,
    String? iconFontFamily,
    Color? color,
    DateTime? generatedAt,
    DateTime? expiresAt,
    InsightStatus? status,
    InsightFeedback? feedback,
    Map<String, dynamic>? metadata,
  }) {
    return InsightOutput(
      id: id ?? this.id,
      ruleId: ruleId ?? this.ruleId,
      ruleName: ruleName ?? this.ruleName,
      message: message ?? this.message,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      iconFontFamily: iconFontFamily ?? this.iconFontFamily,
      color: color ?? this.color,
      generatedAt: generatedAt ?? this.generatedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      status: status ?? this.status,
      feedback: feedback ?? this.feedback,
      metadata: metadata ?? this.metadata,
    );
  }

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ruleId': ruleId,
      'ruleName': ruleName,
      'message': message,
      'category': category.index,
      'priority': priority.index,
      'iconCodePoint': iconCodePoint,
      'iconFontFamily': iconFontFamily,
      'color': color.value,
      'generatedAt': generatedAt.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'status': status.index,
      'feedback': feedback.index,
      'metadata': metadata,
    };
  }

  /// Create from JSON
  factory InsightOutput.fromJson(Map<String, dynamic> json) {
    return InsightOutput(
      id: json['id'] as String,
      ruleId: json['ruleId'] as String,
      ruleName: json['ruleName'] as String,
      message: json['message'] as String,
      category: InsightCategory.values[json['category'] as int],
      priority: InsightPriority.values[json['priority'] as int],
      iconCodePoint: json['iconCodePoint'] as int,
      iconFontFamily: json['iconFontFamily'] as String,
      color: Color(json['color'] as int),
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'] as String)
          : null,
      status: InsightStatus.values[json['status'] as int],
      feedback: InsightFeedback.values[json['feedback'] as int],
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsightOutput &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'InsightOutput{id: $id, ruleName: $ruleName, message: $message, status: $status}';
  }
}

/// Extension to convert InsightCategory to readable string
extension InsightCategoryExtension on InsightCategory {
  String get displayName {
    switch (this) {
      case InsightCategory.sleep:
        return 'Sleep';
      case InsightCategory.nutrition:
        return 'Nutrition';
      case InsightCategory.hydration:
        return 'Hydration';
      case InsightCategory.workout:
        return 'Workout';
      case InsightCategory.health:
        return 'Health';
      case InsightCategory.mood:
        return 'Mood';
      case InsightCategory.cycle:
        return 'Cycle';
      case InsightCategory.streak:
        return 'Streak';
      case InsightCategory.crossModule:
        return 'Wellness';
    }
  }
}

/// Extension to convert InsightPriority to readable string
extension InsightPriorityExtension on InsightPriority {
  String get displayName {
    switch (this) {
      case InsightPriority.critical:
        return 'Critical';
      case InsightPriority.high:
        return 'High';
      case InsightPriority.medium:
        return 'Medium';
      case InsightPriority.low:
        return 'Low';
    }
  }

  int get sortOrder {
    switch (this) {
      case InsightPriority.critical:
        return 0;
      case InsightPriority.high:
        return 1;
      case InsightPriority.medium:
        return 2;
      case InsightPriority.low:
        return 3;
    }
  }
}
