import 'package:fitkarma/features/insight_engine/rules/cross_module_rules.dart';

abstract class InsightRule {
  String get id;
  String get category;
  int get priority;
  String get title;
  
  bool condition(InsightInput input);
  String message(InsightInput input);
  String? get icon;
  bool get isCrossModule;
}

class InsightInput {
  final String odUserId;
  final DateTime date;
  
  final Map<String, double>? nutrition;
  final Map<String, double>? sleep;
  final Map<String, double>? steps;
  final Map<String, double>? water;
  final Map<String, dynamic>? workout;
  final Map<String, dynamic>? bp;
  final Map<String, dynamic>? glucose;
  final Map<String, dynamic>? mood;
  final Map<String, dynamic>? cycle;
  final int? streakDays;
  final double? bmi;
  final int? fastingHours;
  final CorrelationService? correlationService;

  InsightInput({
    required this.odUserId,
    required this.date,
    this.nutrition,
    this.sleep,
    this.steps,
    this.water,
    this.workout,
    this.bp,
    this.glucose,
    this.mood,
    this.cycle,
    this.streakDays,
    this.bmi,
    this.fastingHours,
    this.correlationService,
  });

  factory InsightInput.fromJson(Map<String, dynamic> json) {
    return InsightInput(
      odUserId: json['odUserId'] as String,
      date: DateTime.parse(json['date'] as String),
      nutrition: (json['nutrition'] as Map<String, dynamic>?)?.map(
        (k, v) => MapEntry(k, (v as num).toDouble()),
      ),
      sleep: (json['sleep'] as Map<String, dynamic>?)?.map(
        (k, v) => MapEntry(k, (v as num).toDouble()),
      ),
      steps: (json['steps'] as Map<String, dynamic>?)?.map(
        (k, v) => MapEntry(k, (v as num).toDouble()),
      ),
      water: (json['water'] as Map<String, dynamic>?)?.map(
        (k, v) => MapEntry(k, (v as num).toDouble()),
      ),
      workout: json['workout'] as Map<String, dynamic>?,
      bp: json['bp'] as Map<String, dynamic>?,
      glucose: json['glucose'] as Map<String, dynamic>?,
      mood: json['mood'] as Map<String, dynamic>?,
      cycle: json['cycle'] as Map<String, dynamic>?,
      streakDays: json['streakDays'] as int?,
      bmi: json['bmi'] as double?,
      fastingHours: json['fastingHours'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'odUserId': odUserId,
    'date': date.toIso8601String(),
    'nutrition': nutrition,
    'sleep': sleep,
    'steps': steps,
    'water': water,
    'workout': workout,
    'bp': bp,
    'glucose': glucose,
    'mood': mood,
    'cycle': cycle,
    'streakDays': streakDays,
    'bmi': bmi,
    'fastingHours': fastingHours,
    'correlationService': correlationService,
  };
}

class InsightOutput {
  final String ruleId;
  final String category;
  final String title;
  final String message;
  final String? icon;
  final int priority;
  final DateTime generatedAt;

  InsightOutput({
    required this.ruleId,
    required this.category,
    required this.title,
    required this.message,
    this.icon,
    required this.priority,
    required this.generatedAt,
  });

  Map<String, dynamic> toJson() => {
    'ruleId': ruleId,
    'category': category,
    'title': title,
    'message': message,
    'icon': icon,
    'priority': priority,
    'generatedAt': generatedAt.toIso8601String(),
  };
}

class InsightFeedback {
  final String odUserId;
  final String ruleId;
  final bool thumbsUp;
  final DateTime votedAt;

  InsightFeedback({
    required this.odUserId,
    required this.ruleId,
    required this.thumbsUp,
    required this.votedAt,
  });
}

class InsightResult {
  final List<InsightOutput> insights;
  final DateTime evaluatedAt;

  InsightResult({required this.insights, required this.evaluatedAt});
}
