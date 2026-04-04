import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/di/providers.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/features/insight_engine/models/insight_models.dart';

final serverRulesServiceProvider = Provider<ServerRulesService>((ref) {
  final db = ref.watch(driftDatabaseProvider);
  return ServerRulesService(db);
});

class ServerRulesService {
  final AppDatabase _db;
  static const String _serverRulesKey = 'server_rules';

  ServerRulesService(this._db);

  Future<List<ServerInsightRule>> fetchServerRules() async {
    try {
      final cached = await _db.remoteConfigCacheDao.getByKey(_serverRulesKey);
      if (cached != null) {
        return _parseServerRules(cached.value);
      }
    } catch (_) {}
    return _getDefaultServerRules();
  }

  List<ServerInsightRule> _parseServerRules(String jsonString) {
    try {
      final List<dynamic> rulesJson = json.decode(jsonString);
      return rulesJson.map((r) => ServerInsightRule.fromJson(r)).toList();
    } catch (_) {
      return _getDefaultServerRules();
    }
  }

  List<ServerInsightRule> _getDefaultServerRules() {
    return [
      ServerInsightRule(
        id: 'server_hydration_summer',
        category: 'hydration',
        title: 'Summer Hydration',
        message: 'Hot weather! Increase water to 3L today.',
        threshold: 2500,
        condition: 'water_ml',
        priority: 75,
        icon: '☀️',
        isActive: true,
      ),
      ServerInsightRule(
        id: 'server_festival_prep',
        category: 'nutrition',
        title: 'Festival Season',
        message: 'Festivals ahead. Plan lighter meals 2 days before.',
        threshold: 2000,
        condition: 'calories',
        priority: 80,
        icon: '🪔',
        isActive: true,
        validUntil: DateTime.now().add(const Duration(days: 30)),
      ),
      ServerInsightRule(
        id: 'server_ramadan_nutrition',
        category: 'nutrition',
        title: 'Ramadan Nutrition',
        message: 'Pre-dawn meal: Include protein and complex carbs.',
        threshold: 0,
        condition: 'always',
        priority: 85,
        icon: '🌙',
        isActive: true,
        validUntil: DateTime.now().add(const Duration(days: 30)),
      ),
    ];
  }

  Future<void> cacheServerRules(List<ServerInsightRule> rules) async {
    final jsonString = json.encode(rules.map((r) => r.toJson()).toList());
    await _db.remoteConfigCacheDao.upsertConfig(
      RemoteConfigCacheCompanion(
        key: const Value(_serverRulesKey),
        value: Value(jsonString),
        type: const Value('json'),
        lastUpdated: Value(DateTime.now()),
      ),
    );
  }
}

class ServerInsightRule {
  final String id;
  final String category;
  final String title;
  final String message;
  final double threshold;
  final String condition;
  final int priority;
  final String? icon;
  final bool isActive;
  final DateTime? validUntil;

  ServerInsightRule({
    required this.id,
    required this.category,
    required this.title,
    required this.message,
    required this.threshold,
    required this.condition,
    required this.priority,
    this.icon,
    this.isActive = true,
    this.validUntil,
  });

  factory ServerInsightRule.fromJson(Map<String, dynamic> json) {
    return ServerInsightRule(
      id: json['id'] as String,
      category: json['category'] as String? ?? 'general',
      title: json['title'] as String,
      message: json['message'] as String,
      threshold: (json['threshold'] as num?)?.toDouble() ?? 0,
      condition: json['condition'] as String? ?? 'always',
      priority: json['priority'] as int? ?? 50,
      icon: json['icon'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      validUntil: json['validUntil'] != null 
          ? DateTime.parse(json['validUntil'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'category': category,
    'title': title,
    'message': message,
    'threshold': threshold,
    'condition': condition,
    'priority': priority,
    'icon': icon,
    'isActive': isActive,
    'validUntil': validUntil?.toIso8601String(),
  };

  bool get isValid {
    if (!isActive) return false;
    if (validUntil != null && DateTime.now().isAfter(validUntil!)) return false;
    return true;
  }

  bool evaluate(InsightInput input) {
    if (!isValid) return false;

    switch (condition) {
      case 'water_ml':
        final water = input.water?['ml'] ?? 0;
        return water < threshold;
      case 'calories':
        final calories = input.nutrition?['calories'] ?? 0;
        return calories > threshold;
      case 'steps':
        final steps = input.steps?['total'] ?? 0;
        return steps < threshold;
      case 'always':
        return true;
      default:
        return false;
    }
  }

  InsightOutput toInsightOutput() {
    return InsightOutput(
      ruleId: id,
      category: category,
      title: title,
      message: message,
      icon: icon,
      priority: priority,
      generatedAt: DateTime.now(),
    );
  }

  InsightRule toInsightRule() => _ServerInsightAdapter(this);
}

class _ServerInsightAdapter extends InsightRule {
  final ServerInsightRule _rule;

  _ServerInsightAdapter(this._rule);

  @override
  String get id => _rule.id;

  @override
  String get category => _rule.category;

  @override
  int get priority => _rule.priority;

  @override
  String get title => _rule.title;

  @override
  bool get isCrossModule => _rule.category == 'cross_module';

  @override
  bool condition(InsightInput input) => _rule.evaluate(input);

  @override
  String message(InsightInput input) => _rule.message;

  @override
  String? get icon => _rule.icon;
}
