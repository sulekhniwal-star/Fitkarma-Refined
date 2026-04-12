import 'package:flutter/material.dart';
import 'insight_rule.dart';

/// Represents an insight rule delivered from the server via Remote Config.
class ServerInsightRule extends InsightRule {
  final Map<String, dynamic> config;

  const ServerInsightRule(this.config);

  @override
  String get id => config['id'] as String? ?? 'server_rule_unknown';

  @override
  String get name => config['name'] as String? ?? 'Server Rule';

  @override
  InsightPriority get priority {
    final p = config['priority'] as int? ?? 2;
    switch (p) {
      case 0:
        return InsightPriority.critical;
      case 1:
        return InsightPriority.high;
      case 3:
        return InsightPriority.low;
      case 2:
      default:
        return InsightPriority.normal;
    }
  }

  @override
  InsightModule get module {
    final m = config['module'] as String?;
    switch (m) {
      case 'workout':
        return InsightModule.workout;
      case 'nutrition':
        return InsightModule.nutrition;
      case 'sleep':
        return InsightModule.sleep;
      case 'steps':
        return InsightModule.steps;
      case 'hydration':
        return InsightModule.hydration;
      case 'blood_pressure':
        return InsightModule.bloodPressure;
      case 'fasting':
        return InsightModule.fasting;
      case 'glucose':
        return InsightModule.glucose;
      case 'festival':
        return InsightModule.festival;
      case 'cross_module':
        return InsightModule.crossModule;
      default:
        return InsightModule.crossModule;
    }
  }

  @override
  Future<InsightOutput?> evaluate(InsightContext ctx) async {
    // The server rule defines basic threshold conditions
    // Example: {"condition": {"type": "hydration", "operator": "<", "value": 2000}}
    final condition = config['condition'] as Map<String, dynamic>?;
    if (condition == null) return null;

    final type = condition['type'] as String?;
    final op = condition['operator'] as String?;
    final value = (condition['value'] as num?)?.toDouble() ?? 0.0;

    bool isTriggered = false;

    if (type == 'hydration') {
      // Very basic evaluation for demo purposes: evaluate recent food logs for hydration
      double todayHydration = 0;
      final todayStr = '${ctx.today.year}-${ctx.today.month.toString().padLeft(2, '0')}-${ctx.today.day.toString().padLeft(2, '0')}';
      
      for (final log in ctx.recentFoodLogs) {
        if (log['logged_at'].toString().startsWith(todayStr)) {
          // Assume water_ml log
          todayHydration += (log['water_ml'] as num?)?.toDouble() ?? 0.0;
        }
      }

      if (op == '<' && todayHydration < value) isTriggered = true;
      if (op == '>' && todayHydration > value) isTriggered = true;
    }

    // Add other types as needed or a more generic expression evaluator
    // E.g., type == 'sleep_debt', type == 'festival_soon'

    if (!isTriggered) return null;

    return InsightOutput(
      ruleId: id,
      module: module,
      priority: priority,
      titleEn: config['title_en'] as String? ?? 'Tip',
      titleHi: config['title_hi'] as String? ?? 'सुझाव',
      bodyEn: config['body_en'] as String? ?? '',
      bodyHi: config['body_hi'] as String? ?? '',
      actionLabel: config['action_label'] as String? ?? 'View',
      actionRoute: config['action_route'] as String? ?? '/',
      icon: _parseIcon(config['icon'] as String?),
      color: _parseColor(config['color'] as String?),
    );
  }

  IconData _parseIcon(String? iconStr) {
    if (iconStr == null) return Icons.lightbulb;
    switch (iconStr) {
      case 'water_drop': return Icons.water_drop;
      case 'celebration': return Icons.celebration;
      case 'fitness_center': return Icons.fitness_center;
      default: return Icons.lightbulb;
    }
  }

  Color _parseColor(String? colorStr) {
    if (colorStr == null || colorStr.length != 9 || !colorStr.startsWith('#')) {
      return const Color(0xFFF39C12);
    }
    // #AARRGGBB -> 0xAARRGGBB
    final intColor = int.tryParse(colorStr.replaceFirst('#', '0x'));
    if (intColor != null) return Color(intColor);
    return const Color(0xFFF39C12);
  }
}
