import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_gradients.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/ambient_widgets.dart';
import '../../../shared/widgets/glass_card.dart';
import '../providers/health_provider.dart';

// ── Helpers ────────────────────────────────────────────────────────────────────

String _fmtDuration(int minutes) {
  final h = minutes ~/ 60;
  final m = minutes % 60;
  return m == 0 ? '${h}h' : '${h}h ${m}m';
}

Color _barColor(int minutes) {
  if (minutes >= 420) return AppColorsDark.success;       // ≥7h
  if (minutes >= 360) return AppColorsDark.warning;       // 6–7h
  return AppColorsDark.error;                             // <6h
}

String _qualityEmoji(int minutes) {
  if (minutes >= 420) return '😴';
  if (minutes >= 360) return '😐';
  return '😩';
}

// ── Screen ─────────────────────────────────────────────────────────────────────

class SleepScreen extends ConsumerStatefulWidget {
  const SleepScreen({super.key});

  @override
  ConsumerState<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends ConsumerState<SleepScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _emojiCtrl;
  late Animation<double> _emojiFloat;

  @override
  void initState() {
    super.initState();
    _emojiCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _emojiFloat = Tween<double>(begin: -6, end: 6).animate(
      CurvedAnimation(parent: _emojiCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _emojiCtrl.dispose();
    super.dispose();
  }

  void _showLogSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _LogSleepSheet(
        onSave: (start, end) {
          ref.read(sleepNotifierProvider.notifier).logSleep(
                start: start,
                end: end,
              );
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final surface1 = isDark ? AppColorsDark.surface1 : AppColorsLight.surface1;
    final divider = isDark ? AppColorsDark.divider : AppColorsLight.divider;

    final historyAsync = ref.watch(sleepHistoryProvider(7));
    final allHistoryAsync = ref.watch(sleepHistoryProvider(30));
    final debtHours = ref.watch(sleepDebtProvider);

    final history = historyAsync.asData?.value ?? [];
    final allHistory = allHistoryAsync.asData?.value ?? [];

    // Latest sleep entry
    final latest = history.isNotEmpty ? history.first : null;
    final latestMin = latest?.durationMinutes ?? 0;
    final isGood = latestMin >= 420;

    // Chronotype: show after 30+ days
    final showChronotype = allHistory.length >= 30;

    // Avg sleep for Ayurvedic tip
    final avgMin = allHistory.isEmpty
        ? 0
        : allHistory.fold(0, (s, l) => s + l.durationMinutes) ~/
            allHistory.length;
    final showAyurveda = avgMin > 0 && avgMin < 360;

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.bg0 : AppColorsLight.bg0,
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        onPressed: _showLogSheet,
        backgroundColor: AppColorsDark.secondary,
        shape: const CircleBorder(),
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
      body: Stack(
        children: [
          // ── Hero — heroSleep 3-stop gradient ──────────────────
          Container(
            height: 320,
            decoration: const BoxDecoration(gradient: AppGradients.heroSleep),
            child: Stack(
              children: [
                const AmbientBlobs(),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenH),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: const Icon(Icons.arrow_back_ios_new_rounded,
                              size: 20, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Text('Sleep',
                            style: AppTypography.h1(color: Colors.white)),
                        const SizedBox(width: 8),
                        Text('नींद',
                            style: AppTypography.hindi(
                                color: Colors.white.withValues(alpha: 0.5))),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 28,
                  left: AppSpacing.screenH,
                  right: AppSpacing.screenH,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // metricXL duration
                            Text(
                              latestMin > 0
                                  ? _fmtDuration(latestMin)
                                  : '--',
                              style: AppTypography.metricXL(
                                      color: Colors.white)
                                  .copyWith(shadows: [
                                Shadow(
                                    color: AppColorsDark.secondary
                                        .withValues(alpha: 0.5),
                                    blurRadius: 24),
                              ]),
                            ),
                            const SizedBox(height: 8),
                            // Good/Poor badge
                            if (latestMin > 0)
                              _SleepBadge(isGood: isGood),
                          ],
                        ),
                      ),
                      // Animated floating emoji
                      if (latestMin > 0)
                        AnimatedBuilder(
                          animation: _emojiFloat,
                          builder: (_, __) => Transform.translate(
                            offset: Offset(0, _emojiFloat.value),
                            child: Text(
                              _qualityEmoji(latestMin),
                              style: const TextStyle(fontSize: 52),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Scrollable body ───────────────────────────────────
          DraggableScrollableSheet(
            initialChildSize: 0.60,
            minChildSize: 0.60,
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
                    AppSpacing.screenH, 12, AppSpacing.screenH, 100),
                children: [
                  Center(
                    child: Container(
                      width: 36,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: divider,
                          borderRadius: BorderRadius.circular(2)),
                    ),
                  ),

                  // ── 7-day bar chart ───────────────────────────
                  Text('7-Day History',
                      style: AppTypography.h4(color: text0)),
                  const SizedBox(height: 10),
                  GlassCard(
                    borderRadius: AppRadius.md,
                    padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                    child: _SleepBarChart(
                        history: history, text2: text2),
                  ),
                  const SizedBox(height: 20),

                  // ── Sleep debt card ───────────────────────────
                  _SleepDebtCard(
                      debtHours: debtHours,
                      isDark: isDark,
                      text0: text0,
                      text2: text2),
                  const SizedBox(height: 20),

                  // ── Chronotype card (30+ days) ────────────────
                  if (showChronotype) ...[
                    _ChronotypeCard(
                        history: allHistory,
                        isDark: isDark,
                        text0: text0,
                        text2: text2),
                    const SizedBox(height: 20),
                  ],

                  // ── Ayurvedic tip (avg <6h) ───────────────────
                  if (showAyurveda)
                    _AyurvedaTipCard(text0: text0, text2: text2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Sleep badge ────────────────────────────────────────────────────────────────

class _SleepBadge extends StatelessWidget {
  final bool isGood;
  const _SleepBadge({required this.isGood});

  @override
  Widget build(BuildContext context) {
    final color = isGood ? AppColorsDark.success : AppColorsDark.error;
    final label = isGood ? 'Good Sleep' : 'Poor Sleep';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w700, color: color)),
    );
  }
}

// ── 7-day bar chart ────────────────────────────────────────────────────────────

class _SleepBarChart extends StatelessWidget {
  final List<dynamic> history;
  final Color text2;
  const _SleepBarChart({required this.history, required this.text2});

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return SizedBox(
          height: 120,
          child: Center(
              child: Text('No sleep logged yet',
                  style: AppTypography.bodySm(color: text2))));
    }

    // Build 7 day slots oldest→newest
    final now = DateTime.now();
    final slots = List.generate(7, (i) {
      final day = DateTime(now.year, now.month, now.day)
          .subtract(Duration(days: 6 - i));
      final match = history.firstWhere(
        (s) {
          final d = s.sleepStart as DateTime;
          return d.year == day.year &&
              d.month == day.month &&
              d.day == day.day;
        },
        orElse: () => null,
      );
      return (match?.durationMinutes as int?) ?? 0;
    });

    return SizedBox(
      height: 140,
      child: BarChart(
        BarChartData(
          maxY: 600,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 120,
            getDrawingHorizontalLine: (_) =>
                FlLine(color: AppColorsDark.divider, strokeWidth: 1),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
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
          barGroups: List.generate(7, (i) {
            final min = slots[i];
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: min.toDouble(),
                  width: 22,
                  borderRadius: BorderRadius.circular(4),
                  color: min == 0
                      ? AppColorsDark.divider.withValues(alpha: 0.3)
                      : _barColor(min),
                  // 7h target line via rod background
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: 420,
                    color: AppColorsDark.success.withValues(alpha: 0.06),
                  ),
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

// ── Sleep debt card ────────────────────────────────────────────────────────────

class _SleepDebtCard extends StatelessWidget {
  final double debtHours;
  final bool isDark;
  final Color text0, text2;
  const _SleepDebtCard(
      {required this.debtHours,
      required this.isDark,
      required this.text0,
      required this.text2});

  @override
  Widget build(BuildContext context) {
    final isDebt = debtHours > 0;
    final color = isDebt ? AppColorsDark.error : AppColorsDark.success;
    final label = isDebt
        ? '${debtHours.abs().toStringAsFixed(1)}h sleep debt this week'
        : '${debtHours.abs().toStringAsFixed(1)}h sleep credit this week';
    final progress = (debtHours.abs() / 14).clamp(0.0, 1.0);

    return GlassCard(
      borderRadius: AppRadius.md,
      padding: const EdgeInsets.all(AppSpacing.cardH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isDebt
                    ? Icons.battery_alert_rounded
                    : Icons.battery_charging_full_rounded,
                size: 16,
                color: AppColorsDark.secondary,
              ),
              const SizedBox(width: 8),
              Text('Sleep Debt',
                  style: AppTypography.labelMd(
                      color: AppColorsDark.secondary)),
            ],
          ),
          const SizedBox(height: 10),
          Text(label, style: AppTypography.bodyMd(color: text0)),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              builder: (_, v, __) => LinearProgressIndicator(
                value: v,
                minHeight: 8,
                backgroundColor: color.withValues(alpha: 0.12),
                valueColor: AlwaysStoppedAnimation(color),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text('Target: 7h/night · 49h/week',
              style: AppTypography.caption(color: text2)),
        ],
      ),
    );
  }
}

// ── Chronotype card ────────────────────────────────────────────────────────────

class _ChronotypeCard extends StatelessWidget {
  final List<dynamic> history;
  final bool isDark;
  final Color text0, text2;
  const _ChronotypeCard(
      {required this.history,
      required this.isDark,
      required this.text0,
      required this.text2});

  @override
  Widget build(BuildContext context) {
    // Compute avg sleep start hour
    final avgStartHour = history.isEmpty
        ? 23.0
        : history
                .map((l) => (l.sleepStart as DateTime).hour.toDouble())
                .reduce((a, b) => a + b) /
            history.length;

    final isOwl = avgStartHour >= 23 || avgStartHour < 2;
    final label = isOwl ? '🦉 Night Owl' : '🐦 Early Bird';
    final window = isOwl
        ? 'Optimal sleep: 11 PM – 7 AM'
        : 'Optimal sleep: 9 PM – 5 AM';

    return GlassCard(
      borderRadius: AppRadius.md,
      padding: const EdgeInsets.all(AppSpacing.cardH),
      child: Row(
        children: [
          Text(isOwl ? '🦉' : '🐦',
              style: const TextStyle(fontSize: 32)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: AppTypography.h4(color: text0)),
                const SizedBox(height: 4),
                Text(window,
                    style: AppTypography.bodySm(color: text2)),
                const SizedBox(height: 2),
                Text('Based on ${history.length} nights of data',
                    style: AppTypography.caption(color: text2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Ayurvedic tip card ─────────────────────────────────────────────────────────

class _AyurvedaTipCard extends StatelessWidget {
  final Color text0, text2;
  const _AyurvedaTipCard({required this.text0, required this.text2});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppSpacing.cardH),
        decoration: BoxDecoration(
          color: AppColorsDark.teal.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
              color: AppColorsDark.teal.withValues(alpha: 0.3)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('🌿', style: TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ayurvedic Sleep Tip',
                      style: AppTypography.labelMd(
                          color: AppColorsDark.teal)),
                  const SizedBox(height: 4),
                  Text(
                    'Vata imbalance may be disrupting your sleep. Try warm sesame oil foot massage (Abhyanga) before bed and avoid screens after 9 PM.',
                    style: AppTypography.bodySm(color: text2),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

// ── Log Sleep bottom sheet ─────────────────────────────────────────────────────

class _LogSleepSheet extends StatefulWidget {
  final void Function(DateTime start, DateTime end) onSave;
  const _LogSleepSheet({required this.onSave});

  @override
  State<_LogSleepSheet> createState() => _LogSleepSheetState();
}

class _LogSleepSheetState extends State<_LogSleepSheet> {
  DateTime _bedtime = DateTime.now().subtract(const Duration(hours: 8));
  DateTime _wakeTime = DateTime.now();

  Future<void> _pickTime(bool isBedtime) async {
    final initial = isBedtime ? _bedtime : _wakeTime;
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (picked == null) return;
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
    setState(() {
      if (isBedtime) {
        _bedtime = dt.isAfter(now) ? dt.subtract(const Duration(days: 1)) : dt;
      } else {
        _wakeTime = dt;
      }
    });
  }

  String _fmtTime(DateTime dt) {
    final h = dt.hour > 12 ? dt.hour - 12 : dt.hour == 0 ? 12 : dt.hour;
    final m = dt.minute.toString().padLeft(2, '0');
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $ampm';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final surface1 = isDark ? AppColorsDark.surface1 : AppColorsLight.surface1;
    final divider = isDark ? AppColorsDark.divider : AppColorsLight.divider;
    final surface0 = isDark ? AppColorsDark.surface0 : AppColorsLight.surface0;

    final duration = _wakeTime.difference(_bedtime);
    final durationLabel = duration.isNegative
        ? 'Invalid range'
        : _fmtDuration(duration.inMinutes);

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: surface1,
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppRadius.lg)),
        ),
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenH, 12, AppSpacing.screenH, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                    color: divider,
                    borderRadius: BorderRadius.circular(2)),
              ),
            ),
            Text('Log Sleep',
                style: AppTypography.h3(color: text0)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _TimeButton(
                    label: 'Bedtime',
                    time: _fmtTime(_bedtime),
                    icon: Icons.bedtime_rounded,
                    color: AppColorsDark.secondary,
                    surface0: surface0,
                    text0: text0,
                    text2: text2,
                    onTap: () => _pickTime(true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _TimeButton(
                    label: 'Wake Time',
                    time: _fmtTime(_wakeTime),
                    icon: Icons.wb_sunny_rounded,
                    color: AppColorsDark.accent,
                    surface0: surface0,
                    text0: text0,
                    text2: text2,
                    onTap: () => _pickTime(false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Duration: $durationLabel',
                style: AppTypography.bodyMd(color: text2)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: duration.isNegative || duration.inMinutes < 30
                    ? null
                    : () => widget.onSave(_bedtime, _wakeTime),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColorsDark.secondary,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppRadius.md)),
                ),
                child: const Text('Save Sleep',
                    style: TextStyle(
                        fontSize: 15,
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

class _TimeButton extends StatelessWidget {
  final String label, time;
  final IconData icon;
  final Color color, surface0, text0, text2;
  final VoidCallback onTap;
  const _TimeButton({
    required this.label,
    required this.time,
    required this.icon,
    required this.color,
    required this.surface0,
    required this.text0,
    required this.text2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: surface0,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(height: 6),
              Text(label,
                  style: AppTypography.caption(color: text2)),
              const SizedBox(height: 2),
              Text(time,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: text0)),
            ],
          ),
        ),
      );
}
