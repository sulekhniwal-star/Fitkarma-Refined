import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/fit_scaffold.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../../shared/widgets/bilingual_label.dart';

class StepsHomeScreen extends ConsumerWidget {
  const StepsHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FitScaffold(
      pattern: ScaffoldPattern.immersiveHero,
      title: 'Steps Tracker',
      heroHeight: 300,
      heroContent: _buildHeroDisplay(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          _buildWeeklyTrend(context),
          const SizedBox(height: 24),
          _buildAchievements(context),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildHeroDisplay(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.directions_walk, color: Colors.white54, size: 40),
        const SizedBox(height: 16),
        Text(
          '8,432',
          style: AppTheme.heroDisplay(context).copyWith(
            color: Colors.white,
            fontSize: 72,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          'STEPS TODAY',
          style: AppTheme.monoSm(context).copyWith(
            color: Colors.white70,
            letterSpacing: 4.0,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          width: 200,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.84,
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(color: AppTheme.primary.withValues(alpha: 0.5), blurRadius: 10),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '84% of your 10k goal',
          style: AppTheme.caption(context).copyWith(color: Colors.white54),
        ),
      ],
    );
  }

  Widget _buildWeeklyTrend(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BilingualLabel(english: 'Weekly Progress', hindi: 'साप्ताहिक प्रगति'),
        const SizedBox(height: 16),
        GlassCard(
          height: 220,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 12000,
                barTouchData: BarTouchData(enabled: false),
                titlesData: const FlTitlesData(show: false),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _makeGroupData(0, 8000),
                  _makeGroupData(1, 10200),
                  _makeGroupData(2, 6500),
                  _makeGroupData(3, 11000),
                  _makeGroupData(4, 9800),
                  _makeGroupData(5, 8432),
                  _makeGroupData(6, 0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  BarChartGroupData _makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: y >= 10000 ? AppTheme.primary : AppTheme.textMuted.withValues(alpha: 0.3),
          width: 16,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ],
    );
  }

  Widget _buildAchievements(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BilingualLabel(english: 'Badges', hindi: 'बैज'),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildBadge('🔥', '7 Day Streak', context),
              const SizedBox(width: 12),
              _buildBadge('🏔️', 'Everest Climber', context),
              const SizedBox(width: 12),
              _buildBadge('👟', 'Early Bird', context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(String emoji, String title, BuildContext context) {
    return GlassCard(
      width: 140,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTheme.labelMd(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
