import 'package:fitkarma/features/insight_engine/models/insight_rule.dart';

/// Server-defined insight rule parsed from Remote Config JSON
///
/// JSON Format:
/// {
///   "id": "server_hydration_summer",
///   "name": "Summer Hydration",
///   "category": "hydration",
///   "priority": "high",
///   "threshold": { "type": "min", "value": 10 },
///   "message": "It's hot! Drink extra water today.",
///   "cooldown_days": 1,
///   "enabled": true
/// }
class ServerInsightRule extends InsightRule {
  final Map<String, dynamic> _config;

  ServerInsightRule(this._config);

  @override
  String get id =>
      _config['id'] as String? ??
      'server_${DateTime.now().millisecondsSinceEpoch}';

  @override
  String get name => _config['name'] as String? ?? 'Server Rule';

  @override
  InsightCategory get category {
    final cat = _config['category'] as String? ?? 'health';
    return InsightCategory.values.firstWhere(
      (c) => c.name == cat.toLowerCase(),
      orElse: () => InsightCategory.health,
    );
  }

  @override
  InsightPriority get priority {
    final pri = _config['priority'] as String? ?? 'medium';
    return InsightPriority.values.firstWhere(
      (p) => p.name == pri.toLowerCase(),
      orElse: () => InsightPriority.medium,
    );
  }

  @override
  int get iconCodePoint {
    final iconName = _config['icon'] as String? ?? 'water_drop';
    return _iconNameToCodePoint(iconName);
  }

  @override
  int get colorValue {
    final colorHex = _config['color'] as String? ?? '2196F3';
    return int.parse(colorHex, radix: 16) + 0xFF000000;
  }

  @override
  int get cooldownDays => _config['cooldown_days'] as int? ?? 3;

  @override
  List<String> get requiredDataTypes {
    final dataType = _config['data_type'] as String? ?? 'water';
    return [dataType];
  }

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return _config['enabled'] as bool? ?? true;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final threshold = _config['threshold'] as Map<String, dynamic>?;
    if (threshold == null) return null;

    final type = threshold['type'] as String?;
    final thresholdValue = threshold['value'] as num?;
    final dataKey =
        threshold['data_key'] as String? ??
        _config['data_type'] as String? ??
        'waterGlasses';

    // Get the actual value from user data
    final actualValue = userData[dataKey];
    if (actualValue == null) return null;

    final actual = (actualValue is num) ? actualValue.toDouble() : null;
    if (actual == null || thresholdValue == null) return null;

    bool triggered = false;

    switch (type) {
      case 'min':
        triggered = actual >= thresholdValue;
        break;
      case 'max':
        triggered = actual <= thresholdValue;
        break;
      case 'range':
        final min = (threshold['min'] as num?)?.toDouble();
        final max = (threshold['max'] as num?)?.toDouble();
        if (min != null && max != null) {
          triggered = actual >= min && actual <= max;
        }
        break;
    }

    if (triggered) {
      return _config['message'] as String? ?? 'Insight from server';
    }

    return null;
  }

  int _iconNameToCodePoint(String name) {
    const iconMap = {
      'water_drop': 0xe5d4,
      'fitness_center': 0xeb42,
      'bedtime': 0xef47,
      'restaurant': 0xea47,
      'directions_walk': 0xe566,
      'favorite': 0xe25a,
      'mood': 0xea23,
      'celebration': 0xeb55,
      'phone_android': 0xea8d,
      'lightbulb': 0xe8f3,
      'warning': 0x0020,
      'local_fire_department': 0xea2b,
    };
    return iconMap[name] ?? 0xe8f3;
  }

  /// Parse a list of server rules from Remote Config JSON
  static List<ServerInsightRule> parseRules(
    List<Map<String, dynamic>> jsonRules,
  ) {
    return jsonRules
        .where((rule) => rule['enabled'] != false)
        .map((rule) => ServerInsightRule(rule))
        .toList();
  }
}
