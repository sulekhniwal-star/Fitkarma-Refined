import 'package:flutter/material.dart';
import '../models/insight_rule.dart';

/// General protein gap rule.
class ProteinGapRule extends InsightRule {
  const ProteinGapRule();

  @override
  String get id => 'protein_gap';

  @override
  String get name => 'Daily protein goal not met';

  @override
  InsightModule get module => InsightModule.nutrition;

  @override
  Future<InsightOutput?> evaluate(InsightContext ctx) async {
    final proteinGoal = (ctx.nutritionGoals?['proteinTarget'] as num?)?.toDouble() ?? 60;

    // Check last 3 days
    int lowProteinDays = 0;
    for (int i = 0; i < 3; i++) {
      final day = ctx.today.subtract(Duration(days: i));
      final dayLogs = ctx.recentFoodLogs.where((l) {
        final d = DateTime.parse(l['logged_at'].toString());
        return d.year == day.year && d.month == day.month && d.day == day.day;
      });
      final total = dayLogs.fold(0.0, (s, l) => s + ((l['protein_g'] as num?)?.toDouble() ?? 0));
      if (total < proteinGoal * 0.75) lowProteinDays++;
    }

    if (lowProteinDays < 2) return null;

    return const InsightOutput(
      ruleId: 'protein_gap',
      module: InsightModule.nutrition,
      priority: InsightPriority.normal,
      titleEn: '🥗 You\'re low on protein',
      titleHi: 'प्रोटीन की कमी है',
      bodyEn: 'You\'ve been consistently short on daily protein. Add a serving of dal, paneer, or eggs to your next meal.',
      bodyHi: 'आपके भोजन में नियमित रूप से प्रोटीन कम है। दाल, पनीर या अंडे जोड़ें।',
      actionLabel: 'Log Food',
      actionRoute: '/food',
      icon: Icons.restaurant,
      color: Color(0xFFE67E22),
    );
  }
}

/// Rule for identifying the biggest micronutrient gap (Iron, B12, Vit D, Calcium).
class MicronutrientGapRule extends InsightRule {
  const MicronutrientGapRule();

  @override
  String get id => 'micronutrient_gap';

  @override
  String get name => 'Identify biggest micronutrient gap';

  @override
  InsightModule get module => InsightModule.nutrition;

  @override
  Future<InsightOutput?> evaluate(InsightContext ctx) async {
    // Average RDAs for India
    const targets = {
      'iron_mg': 18.0,
      'vitamin_b12_mcg': 2.2,
      'vitamin_d_mcg': 15.0,
      'calcium_mg': 1000.0,
    };

    final labels = {
      'iron_mg': ('Iron', 'आयरन'),
      'vitamin_b12_mcg': ('Vitamin B12', 'विटामिन B12'),
      'vitamin_d_mcg': ('Vitamin D', 'विटामिन D'),
      'calcium_mg': ('Calcium', 'कैल्शियम'),
    };

    final suggestions = {
      'iron_mg': ('spinach, beetroots, or pomegranate', 'पालक, चुकंदर या अनार'),
      'vitamin_b12_mcg': ('dairy, eggs, or fortified cereals', 'डेयरी, अंडे या फोर्टिफाइड अनाज'),
      'vitamin_d_mcg': ('mushrooms, fatty fish, or 15 mins of sun', 'मशरूम या 15 मिनट धूप'),
      'calcium_mg': ('paneer, curd, or ragi', 'पनीर, दही या रागी'),
    };

    // Calculate average intake over last 7 days
    final totals = <String, double>{};
    for (final key in targets.keys) {
      totals[key] = 0.0;
    }

    int loggedDays = 0;
    for (int i = 0; i < 7; i++) {
      final day = ctx.today.subtract(Duration(days: i));
      final dayLogs = ctx.recentFoodLogs.where((l) {
        final d = DateTime.parse(l['logged_at'].toString());
        return d.year == day.year && d.month == day.month && d.day == day.day;
      });
      if (dayLogs.isEmpty) continue;
      loggedDays++;

      for (final log in dayLogs) {
        totals['iron_mg'] = totals['iron_mg']! + ((log['iron_mg'] as num?)?.toDouble() ?? 0);
        totals['vitamin_b12_mcg'] = totals['vitamin_b12_mcg']! + ((log['vitamin_b12_mcg'] as num?)?.toDouble() ?? 0);
        totals['vitamin_d_mcg'] = totals['vitamin_d_mcg']! + ((log['vitamin_d_mcg'] as num?)?.toDouble() ?? 0);
        totals['calcium_mg'] = totals['calcium_mg']! + ((log['calcium_mg'] as num?)?.toDouble() ?? 0);
      }
    }

    if (loggedDays < 3) return null;

    // Find biggest percentage gap
    String? biggestGapKey;
    double maxGapPct = 0.0;

    for (final entry in totals.entries) {
      final avg = entry.value / loggedDays;
      final target = targets[entry.key]!;
      final gapPct = (target - avg) / target;

      if (gapPct > 0.4 && gapPct > maxGapPct) { // Only if gap > 40%
        maxGapPct = gapPct;
        biggestGapKey = entry.key;
      }
    }

    if (biggestGapKey == null) return null;

    final label = labels[biggestGapKey]!;
    final suggestion = suggestions[biggestGapKey]!;
    final gapAmount = (targets[biggestGapKey]! - (totals[biggestGapKey]! / loggedDays)).toStringAsFixed(1);
    final unit = biggestGapKey.split('_').last;

    return InsightOutput(
      ruleId: 'micronutrient_gap_$biggestGapKey',
      module: InsightModule.nutrition,
      priority: InsightPriority.normal,
      titleEn: 'You\'re short on ${label.$1}',
      titleHi: '${label.$2} की कमी है',
      bodyEn: 'Your average intake of ${label.$1} is $gapAmount $unit below target. Add more ${suggestion.$1} to your diet.',
      bodyHi: 'आपका ${label.$2} औसत लक्ष्य से $gapAmount $unit कम है। अपने आहार में ${suggestion.$2} शामिल करें।',
      actionLabel: 'Log More',
      actionRoute: '/food',
      icon: Icons.biotech,
      color: const Color(0xFF27AE60),
    );
  }
}
