import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_gradients.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/ambient_widgets.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/metric_widgets.dart';
import '../providers/steps_provider.dart';

// ── Constants ──────────────────────────────────────────────────────────────────

const int _dailyGoal = 10000;

// ── Screen ─────────────────────────────────────────────────────────────────────

class StepsScreen extends ConsumerStatefulWidget {
  const StepsScreen({super.key});

  @override
  ConsumerState<StepsScreen> createState() => _StepsScreenState();
}

class _StepsScreenState extends ConsumerState<StepsScreen> {
  bool _goalAccepted = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final surface1 = isDark ? AppColorsDark.surface1 : AppColorsLight.surface1;
    final divider = isDark ? AppColorsDark.divider : AppColorsLight.divider;

    final stepsAsync = ref.watch(stepsProvider);
    final historyAsync = ref.watch(stepHistoryProvider(7));
    final suggestedGoal = ref.watch(adaptiveGoalProvider);

    final steps = stepsAsync.valueOrNull ?? 0;
    final progress = (steps / _dailyGoal).clamp(0.0, 1.0);
    final goalMet = steps >= _dailyGoal;

    // Derived stats
    final distanceKm = steps * 0.000762; // avg stride ~76.2 cm
    final calories = (steps * 0.04).round(); // ~0.04 kcal/step

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.bg0 : AppColorsLight.bg0,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // ── Hero gradient (Pattern B — heroPrimary) ───────────
          Container(
            height: 340,
            decoration: const BoxDecoration(gradient: AppGradients.heroPrimary),
            child: Stack(
              children: [
                const AmbientBlobs(),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenH),
                    child: Row(
                      children: [
                        Text('Steps',
                            style: AppTypography.h1(color: Colors.white)),
                        const Spacer(),
                        Text('कदम',
                            style: AppTypography.hindi(
                                color: Colors.white.withValues(alpha: 0.6))),
                      ],
                    ),
                  ),
                ),
                // Hero content — step count + PulseRing
                Positioned(
                  bottom: 32,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // PulseRing progress behind count
                            PulseRing(
                              color: AppColorsDark.success,
                              child: SizedBox(
                                width: 180,
                                height: 180,
                                child: CircularProgressIndicator(
                                  value: progress,
                                  strokeWidth: 8,
                                  backgroundColor: AppColorsDark.success
                                      .withValues(alpha: 0.12),
                                  valueColor: const AlwaysStoppedAnimation(
                                      AppColorsDark.success),
                                ),
                              ),
                            ),
                            // Step count — heroDisplay 72sp white + success glow
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _fmt(steps),
                                  style: AppTypography.heroDisplay(
                                    color: Colors.white,
                                  ).copyWith(
                                    shadows: [
                                      Shadow(
                                        color: AppColorsDark.success
                                            .withValues(alpha: 0.6),
                                        blurRadius: 24,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'of ${_fmt(_dailyGoal)} steps',
                                  style: AppTypography.bodySm(
                                      color: Colors.white
                                          .withValues(alpha: 0.7)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Goal label
                      _GoalLabel(
                          goalMet: goalMet, progress: progress, text2: text2),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Scrollable body ───────────────────────────────────
          DraggableScrollableSheet(
            initialChildSize: 0.58,
            minChildSize: 0.58,
            maxChildSize: 1.0,
            builder: (_, controller) => Container(
              decoration: BoxDecoration(
                color: surface1,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppRadius.xl)),
              ),
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenH, 12, AppSpacing.screenH, 32),
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      width: 36,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: divider,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // ── Distance + Calories half-cards ────────────
                  Row(
                    children: [
                      Expanded(
                        child: _StatHalfCard(
                          label: 'Distance',
                          value: distanceKm.toStringAsFixed(2),
                          unit: 'km',
                          icon: Icons.route_rounded,
                          color: AppColorsDark.teal,
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.bentoGap),
                      Expanded(
                        child: _StatHalfCard(
                          label: 'Calories',
                          value: calories.toString(),
                          unit: 'kcal',
                          icon: Icons.local_fire_department_rounded,
                          color: AppColorsDark.primary,
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ── Hourly bar chart ──────────────────────────
                  Text('Today\'s Activity',
                      style: AppTypography.h4(color: text0)),
                  const SizedBox(height: 10),
                  GlassCard(
                    borderRadius: AppRadius.md,
                    padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                    child: _HourlyBarChart(
                        steps: steps, isDark: isDark, text2: text2),
                  ),
                  const SizedBox(height: 20),

                  // ── 7-day trend chart ─────────────────────────
                  Text('7-Day Trend',
                      style: AppTypography.h4(color: text0)),
                  const SizedBox(height: 10),
                  GlassCard(
                    borderRadius: AppRadius.md,
                    padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                    child: historyAsync.when(
                      data: (history) => _WeeklyTrendChart(
                          history: history, isDark: isDark, text2: text2),
                      loading: () => const SizedBox(
                          height: 120,
                          child: Center(
                              child: CircularProgressIndicator(strokeWidth: 2))),
                      error: (_, __) => SizedBox(
                          height: 120,
                          child: Center(
                              child: Text('No data',
                                  style: AppTypography.bodySm(
                                      color: text2)))),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Adaptive goal card ────────────────────────
                  if (!_goalAccepted &&
                      suggestedGoal.round() != _dailyGoal)
                    _AdaptiveGoalCard(
                      suggested: suggestedGoal.round(),
                      current: _dailyGoal,
                      isDark: isDark,
                      text0: text0,
                      text2: text2,
                      onAccept: () => setState(() => _goalAccepted = true),
                      onKeep: () => setState(() => _goalAccepted = true),
                    ),

                  // ── Inactivity nudge card ─────────────────────
                  // Show if steps are very low (proxy for inactivity)
                  if (steps < 500)
                    _InactivityNudgeCard(
                        isDark: isDark, text0: text0, text2: text2),

                  const SizedBox(height: AppSpacing.fabClearance),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Goal label ─────────────────────────────────────────────────────────────────

class _GoalLabel extends StatelessWidget {
  final bool goalMet;
  final double progress;
  final Color text2;
  const _GoalLabel(
      {required this.goalMet,
      required this.progress,
      required this.text2});

  @override
  Widget build(BuildContext context) {
    if (goalMet) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: AppColorsDark.success.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(
              color: AppColorsDark.success.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_rounded,
                size: 14, color: AppColorsDark.success),
            const SizedBox(width: 6),
            Text('Goal reached! 🎉',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColorsDark.success)),
          ],
        ),
      );
    }
    final pct = (progress * 100).round();
    return Text(
      '$pct% of daily goal',
      style: TextStyle(
          fontSize: 12,
          color: Colors.white.withValues(alpha: 0.65)),
    );
  }
}

// ── Stat half-card ─────────────────────────────────────────────────────────────

class _StatHalfCard extends StatelessWidget {
  final String label, value, unit;
  final IconData icon;
  final Color color;
  final bool isDark;
  const _StatHalfCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: AppRadius.md,
      padding: const EdgeInsets.all(AppSpacing.cardH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 6),
              Text(label,
                  style: AppTypography.caption(
                      color: isDark
                          ? AppColorsDark.textMuted
                          : AppColorsLight.textMuted)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTypography.monoLg(color: color),
          ),
          Text(unit,
              style: AppTypography.caption(
                  color: isDark
                      ? AppColorsDark.textMuted
                      : AppColorsLight.textMuted)),
        ],
      ),
    );
  }
}

// ── Hourly bar chart ───────────────────────────────────────────────────────────

class _HourlyBarChart extends StatelessWidget {
  final int steps;
  final bool isDark;
  final Color text2;
  const _HourlyBarChart(
      {required this.steps, required this.isDark, required this.text2});

  // Distribute today's steps across hours up to current hour
  List<double> _hourlyData() {
    final hour = DateTime.now().hour;
    if (hour == 0 || steps == 0) return List.filled(24, 0);
    final data = List<double>.filled(24, 0);
    // Simple distribution: weight morning + lunch + evening peaks
    final weights = List<double>.generate(24, (h) {
      if (h < 6) return 0.1;
      if (h < 9) return 2.5; // morning
      if (h < 12) return 1.5;
      if (h < 14) return 2.0; // lunch walk
      if (h < 17) return 1.2;
      if (h < 20) return 2.8; // evening
      return 0.8;
    });
    final totalWeight =
        weights.sublist(0, hour + 1).fold(0.0, (a, b) => a + b);
    for (int h = 0; h <= hour; h++) {
      data[h] = (steps * weights[h] / totalWeight).roundToDouble();
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final data = _hourlyData();
    final maxVal = data.reduce((a, b) => a > b ? a : b).clamp(1.0, double.infinity);
    final currentHour = DateTime.now().hour;

    return SizedBox(
      height: 120,
      child: BarChart(
        BarChartData(
          maxY: maxVal * 1.2,
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 6,
                getTitlesWidget: (v, _) {
                  final h = v.toInt();
                  if (h % 6 != 0) return const SizedBox.shrink();
                  final label = h == 0
                      ? '12a'
                      : h == 12
                          ? '12p'
                          : h < 12
                              ? '${h}a'
                              : '${h - 12}p';
                  return Text(label,
                      style: TextStyle(fontSize: 9, color: text2));
                },
              ),
            ),
          ),
          barGroups: List.generate(24, (h) {
            final isActive = h <= currentHour && data[h] > 0;
            return BarChartGroupData(
              x: h,
              barRods: [
                BarChartRodData(
                  toY: data[h],
                  width: 6,
                  borderRadius: BorderRadius.circular(3),
                  color: isActive
                      ? AppColorsDark.success
                      : AppColorsDark.success.withValues(alpha: 0.15),
                ),
              ],
            );
          }),
        ),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      ),
    );
  }
}

// ── 7-day trend chart ──────────────────────────────────────────────────────────

class _WeeklyTrendChart extends StatelessWidget {
  final List<dynamic> history;
  final bool isDark;
  final Color text2;
  const _WeeklyTrendChart(
      {required this.history, required this.isDark, required this.text2});

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return SizedBox(
        height: 120,
        child: Center(
            child: Text('No history yet',
                style: AppTypography.bodySm(color: text2))),
      );
    }

    // Build 7 slots (oldest → newest)
    final now = DateTime.now();
    final slots = List.generate(7, (i) {
      final day = DateTime(now.year, now.month, now.day)
          .subtract(Duration(days: 6 - i));
      final match = history.firstWhere(
        (s) {
          final d = (s.date as DateTime);
          return d.year == day.year &&
              d.month == day.month &&
              d.day == day.day;
        },
        orElse: () => null,
      );
      return (match?.count as int?) ?? 0;
    });

    final maxVal =
        slots.reduce((a, b) => a > b ? a : b).toDouble().clamp(1.0, double.infinity);

    final spots = List.generate(
        7, (i) => FlSpot(i.toDouble(), slots[i].toDouble()));

    return SizedBox(
      height: 120,
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: maxVal * 1.25,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxVal / 2,
            getDrawingHorizontalLine: (_) => FlLine(
              color: AppColorsDark.divider,
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, _) {
                  final day = DateTime(now.year, now.month, now.day)
                      .subtract(Duration(days: 6 - v.toInt()));
                  const labels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
                  return Text(labels[day.weekday % 7],
                      style: TextStyle(fontSize: 10, color: text2));
                },
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              curveSmoothness: 0.35,
              color: AppColorsDark.success,
              barWidth: 2.5,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
                  radius: 3,
                  color: AppColorsDark.success,
                  strokeWidth: 0,
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColorsDark.success.withValues(alpha: 0.25),
                    AppColorsDark.success.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
            // Goal reference line
            LineChartBarData(
              spots: [
                FlSpot(0, _dailyGoal.toDouble()),
                FlSpot(6, _dailyGoal.toDouble()),
              ],
              isCurved: false,
              color: AppColorsDark.primary.withValues(alpha: 0.4),
              barWidth: 1,
              dashArray: [4, 4],
              dotData: const FlDotData(show: false),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      ),
    );
  }
}

// ── Adaptive goal card ─────────────────────────────────────────────────────────

class _AdaptiveGoalCard extends StatelessWidget {
  final int suggested, current;
  final bool isDark;
  final Color text0, text2;
  final VoidCallback onAccept, onKeep;
  const _AdaptiveGoalCard({
    required this.suggested,
    required this.current,
    required this.isDark,
    required this.text0,
    required this.text2,
    required this.onAccept,
    required this.onKeep,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GlassCard(
        borderRadius: AppRadius.md,
        padding: const EdgeInsets.all(AppSpacing.cardH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.auto_graph_rounded,
                    size: 16, color: AppColorsDark.teal),
                const SizedBox(width: 8),
                Text('Adaptive Goal',
                    style: AppTypography.labelMd(
                        color: AppColorsDark.teal)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Based on your 7-day average, we suggest ${_fmt(suggested)} steps.',
              style: AppTypography.bodyMd(color: text0),
            ),
            const SizedBox(height: 4),
            Text(
              'Current goal: ${_fmt(current)} steps',
              style: AppTypography.bodySm(color: text2),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 38,
                    child: ElevatedButton(
                      onPressed: onAccept,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColorsDark.teal,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppRadius.sm)),
                      ),
                      child: Text('Accept ${_fmt(suggested)}',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 38,
                    child: OutlinedButton(
                      onPressed: onKeep,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: AppColorsDark.divider
                                .withValues(alpha: 0.4)),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppRadius.sm)),
                      ),
                      child: Text('Keep ${_fmt(current)}',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: text2)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Inactivity nudge card ──────────────────────────────────────────────────────

class _InactivityNudgeCard extends StatelessWidget {
  final bool isDark;
  final Color text0, text2;
  const _InactivityNudgeCard(
      {required this.isDark, required this.text0, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.cardH),
        decoration: BoxDecoration(
          color: AppColorsDark.warning.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
              color: AppColorsDark.warning.withValues(alpha: 0.25)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColorsDark.warning.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.directions_walk_rounded,
                  size: 20, color: AppColorsDark.warning),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Time to move!',
                      style: AppTypography.labelMd(
                          color: AppColorsDark.warning)),
                  const SizedBox(height: 2),
                  Text('You\'ve been inactive for a while.',
                      style: AppTypography.bodySm(color: text2)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 36,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColorsDark.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.sm)),
                ),
                child: const Text('Start Walk',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Helpers ────────────────────────────────────────────────────────────────────

String _fmt(int n) {
  if (n >= 1000) {
    return '${(n / 1000).toStringAsFixed(n % 1000 == 0 ? 0 : 1)}k';
  }
  return n.toString();
}
