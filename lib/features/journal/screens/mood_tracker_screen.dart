import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/ambient_widgets.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/status_widgets.dart';
import '../../journal/providers/mood_provider.dart';
import '../../insights/providers/insight_provider.dart';

// ── Constants ──────────────────────────────────────────────────────────────────

const _emojis = ['😡', '😟', '😐', '😊', '🤩'];
const _emojiLabels = ['Awful', 'Bad', 'Okay', 'Good', 'Great'];
const _tags = [
  'Stressed', 'Happy', 'Tired', 'Calm',
  'Anxious', 'Energised', 'Focused',
];

// ── Screen ─────────────────────────────────────────────────────────────────────

class MoodTrackerScreen extends ConsumerStatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  ConsumerState<MoodTrackerScreen> createState() =>
      _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends ConsumerState<MoodTrackerScreen> {
  int? _selectedMood;       // 0–4 index
  double _energy = 5;
  final Set<String> _selectedTags = {};
  bool _saving = false;

  // Heatmap detail overlay
  int? _tappedDayIndex;

  Future<void> _save() async {
    if (_selectedMood == null) return;
    setState(() => _saving = true);
    HapticFeedback.mediumImpact();
    await ref.read(moodNotifierProvider.notifier).logMood(
          score: _selectedMood! + 1,
          emoji: _emojis[_selectedMood!],
          tags: _selectedTags.toList(),
        );
    setState(() { _saving = false; _selectedMood = null; _selectedTags.clear(); _energy = 5; });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final bg1 = isDark ? AppColorsDark.bg1 : AppColorsLight.bg1;
    final primary = isDark ? AppColorsDark.primary : AppColorsLight.primary;
    final surface0 = isDark ? AppColorsDark.surface0 : AppColorsLight.surface0;
    final divider = isDark ? AppColorsDark.divider : AppColorsLight.divider;

    final todayMoodAsync = ref.watch(todayMoodProvider);
    final historyAsync = ref.watch(moodHistoryProvider(7));
    final allHistoryAsync = ref.watch(moodHistoryProvider(30));
    final insightAsync = ref.watch(dashboardInsightProvider);

    final history = historyAsync.asData?.value ?? [];
    final allHistory = allHistoryAsync.asData?.value ?? [];
    final showCorrelation = allHistory.length >= 14;

    final alreadyLogged = todayMoodAsync.asData?.value != null;

    return Scaffold(
      backgroundColor: bg1,
      body: Stack(
        children: [
          const AmbientBlobs(),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  pinned: true,
                  leading: GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(Icons.arrow_back_ios_new_rounded,
                        size: 20, color: text2),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mood',
                          style: AppTypography.h1(color: text0)),
                      Text('मनोदशा',
                          style: AppTypography.hindi(color: text2)),
                    ],
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenH),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([

                      // ── Today's mood card ─────────────────────
                      GlassCard(
                        borderRadius: AppRadius.md,
                        padding: const EdgeInsets.all(AppSpacing.cardH),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              alreadyLogged
                                  ? 'Mood logged today ✓'
                                  : 'How are you feeling?',
                              style: AppTypography.h4(color: text0),
                            ),
                            const SizedBox(height: 16),

                            // 5 emoji buttons — spring pop
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: List.generate(5, (i) {
                                final selected = _selectedMood == i;
                                return GestureDetector(
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    setState(() => _selectedMood =
                                        selected ? null : i);
                                  },
                                  child: AnimatedScale(
                                    scale: selected ? 1.25 : 1.0,
                                    duration: const Duration(
                                        milliseconds: 200),
                                    curve: Curves.elasticOut,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 52,
                                          height: 52,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: selected
                                                ? Border.all(
                                                    color: primary,
                                                    width: 2.5)
                                                : null,
                                            color: selected
                                                ? primary.withValues(
                                                    alpha: 0.1)
                                                : Colors.transparent,
                                          ),
                                          child: Center(
                                            child: Text(_emojis[i],
                                                style: const TextStyle(
                                                    fontSize: 28)),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(_emojiLabels[i],
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: selected
                                                    ? primary
                                                    : text2)),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 20),

                            // Energy slider — gradient
                            Text(
                              'Energy: ${_energy.round()}/10',
                              style: AppTypography.bodySm(color: text2),
                            ),
                            const SizedBox(height: 6),
                            SliderTheme(
                              data: SliderThemeData(
                                trackHeight: 6,
                                thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 10),
                                overlayShape:
                                    const RoundSliderOverlayShape(
                                        overlayRadius: 18),
                                activeTrackColor: primary,
                                inactiveTrackColor:
                                    primary.withValues(alpha: 0.15),
                                thumbColor: primary,
                                overlayColor:
                                    primary.withValues(alpha: 0.15),
                              ),
                              child: Slider(
                                value: _energy,
                                min: 0,
                                max: 10,
                                divisions: 10,
                                onChanged: (v) {
                                  HapticFeedback.selectionClick();
                                  setState(() => _energy = v);
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Drained',
                                    style: AppTypography.caption(
                                        color: text2)),
                                Text('Energised',
                                    style: AppTypography.caption(
                                        color: text2)),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Tags multi-select
                            Text('How would you describe it?',
                                style: AppTypography.bodySm(
                                    color: text2)),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _tags.map((tag) {
                                final active =
                                    _selectedTags.contains(tag);
                                return GestureDetector(
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    setState(() {
                                      if (active) {
                                        _selectedTags.remove(tag);
                                      } else {
                                        _selectedTags.add(tag);
                                      }
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(
                                        milliseconds: 150),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: active
                                          ? primary.withValues(alpha: 0.15)
                                          : surface0,
                                      borderRadius: BorderRadius.circular(
                                          AppRadius.full),
                                      border: Border.all(
                                          color: active
                                              ? primary.withValues(
                                                  alpha: 0.5)
                                              : divider),
                                    ),
                                    child: Text(tag,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: active
                                                ? primary
                                                : text2)),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 16),

                            // Save button
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: (_selectedMood == null ||
                                        _saving)
                                    ? null
                                    : _save,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppRadius.md)),
                                ),
                                child: _saving
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white))
                                    : const Text("Save Today's Mood",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── 7-day heatmap ─────────────────────────
                      Text('7-Day Mood',
                          style: AppTypography.h4(color: text0)),
                      const SizedBox(height: 10),
                      _MoodHeatmap(
                        history: history,
                        tappedIndex: _tappedDayIndex,
                        onTap: (i) => setState(() =>
                            _tappedDayIndex =
                                _tappedDayIndex == i ? null : i),
                        isDark: isDark,
                        text2: text2,
                        primary: primary,
                      ),
                      const SizedBox(height: 20),

                      // ── Correlation insight (14+ data points) ─
                      if (showCorrelation) ...[
                        insightAsync.when(
                          data: (insight) => InsightCard(
                            message: insight,
                            onThumbsUp: () {},
                            onThumbsDown: () {},
                          ),
                          loading: () => const SizedBox.shrink(),
                          error: (_, __) => const SizedBox.shrink(),
                        ),
                        const SizedBox(height: 20),
                      ],

                      // ── Mood trend spline chart ────────────────
                      if (history.isNotEmpty) ...[
                        Text('Mood Trend',
                            style: AppTypography.h4(color: text0)),
                        const SizedBox(height: 10),
                        GlassCard(
                          borderRadius: AppRadius.md,
                          padding:
                              const EdgeInsets.fromLTRB(12, 16, 12, 8),
                          child: _MoodTrendChart(
                              history: history, text2: text2),
                        ),
                      ],

                      const SizedBox(height: AppSpacing.fabClearance),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Mood heatmap ───────────────────────────────────────────────────────────────

class _MoodHeatmap extends StatelessWidget {
  final List<dynamic> history;
  final int? tappedIndex;
  final ValueChanged<int> onTap;
  final bool isDark;
  final Color text2, primary;
  const _MoodHeatmap({
    required this.history,
    required this.tappedIndex,
    required this.onTap,
    required this.isDark,
    required this.text2,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final slots = List.generate(7, (i) {
      final day = DateTime(now.year, now.month, now.day)
          .subtract(Duration(days: 6 - i));
      final match = history.firstWhere(
        (e) {
          final d = e.createdAt as DateTime;
          return d.year == day.year &&
              d.month == day.month &&
              d.day == day.day;
        },
        orElse: () => null,
      );
      return (
        day: day,
        emoji: match?.moodEmoji as String?,
        score: match?.moodScore as int?,
        tags: match?.tagsJson as String?,
      );
    });

    return GlassCard(
      borderRadius: AppRadius.md,
      padding: const EdgeInsets.all(AppSpacing.cardH),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (i) {
              final s = slots[i];
              final isTapped = tappedIndex == i;
              return GestureDetector(
                onTap: s.emoji != null ? () => onTap(i) : null,
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isTapped
                            ? primary.withValues(alpha: 0.15)
                            : Colors.transparent,
                        border: isTapped
                            ? Border.all(
                                color: primary.withValues(alpha: 0.5))
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          s.emoji ?? '·',
                          style: TextStyle(
                              fontSize: s.emoji != null ? 22 : 18,
                              color: s.emoji == null
                                  ? text2.withValues(alpha: 0.3)
                                  : null),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(_dayLabel(s.day),
                        style: TextStyle(fontSize: 9, color: text2)),
                  ],
                ),
              );
            }),
          ),
          // Detail overlay for tapped day
          if (tappedIndex != null && slots[tappedIndex!].emoji != null)
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Text(
                    '${slots[tappedIndex!].emoji} Score ${slots[tappedIndex!].score ?? "—"}/5',
                    style: AppTypography.bodySm(color: text2),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _dayLabel(DateTime d) {
    const labels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return labels[d.weekday % 7];
  }
}

// ── Mood trend spline chart ────────────────────────────────────────────────────

class _MoodTrendChart extends StatelessWidget {
  final List<dynamic> history;
  final Color text2;
  const _MoodTrendChart(
      {required this.history, required this.text2});

  @override
  Widget build(BuildContext context) {
    final sorted = [...history]
      ..sort((a, b) => (a.createdAt as DateTime)
          .compareTo(b.createdAt as DateTime));

    final spots = sorted.asMap().entries.map((e) {
      return FlSpot(
          e.key.toDouble(), ((e.value.moodScore as int?) ?? 3).toDouble());
    }).toList();

    return SizedBox(
      height: 140,
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: 6,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 2,
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
            bottomTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              curveSmoothness: 0.4,
              color: AppColorsDark.purple,
              barWidth: 2.5,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, _, __, ___) {
                  return FlDotCirclePainter(
                      radius: 4,
                      color: AppColorsDark.purple,
                      strokeWidth: 0);
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColorsDark.purple.withValues(alpha: 0.3),
                    AppColorsDark.purple.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      ),
    );
  }
}
