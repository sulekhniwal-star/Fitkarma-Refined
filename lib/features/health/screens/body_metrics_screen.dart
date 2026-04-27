import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_gradients.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/ambient_widgets.dart';
import '../../../shared/widgets/glass_card.dart';
import '../providers/body_metrics_provider.dart';

// ── BMI classification ─────────────────────────────────────────────────────────

typedef _BMIClass = ({String label, Color color});

_BMIClass _bmiClassify(double bmi) {
  if (bmi < 18.5) return (label: 'Underweight', color: AppColorsDark.warning);
  if (bmi < 25.0) return (label: 'Normal', color: AppColorsDark.success);
  if (bmi < 30.0) return (label: 'Overweight', color: AppColorsDark.warning);
  return (label: 'Obese', color: AppColorsDark.error);
}

// ── Screen ─────────────────────────────────────────────────────────────────────

class BodyMetricsScreen extends ConsumerStatefulWidget {
  const BodyMetricsScreen({super.key});

  @override
  ConsumerState<BodyMetricsScreen> createState() =>
      _BodyMetricsScreenState();
}

class _BodyMetricsScreenState extends ConsumerState<BodyMetricsScreen> {
  // Inline measurement edit state
  final _waistCtrl = TextEditingController();
  final _chestCtrl = TextEditingController();
  final _hipsCtrl = TextEditingController();
  bool _editingMeasurements = false;

  // Target weight (kg) — user-configurable, default 70
  final double _targetWeight = 70.0;

  @override
  void dispose() {
    _waistCtrl.dispose();
    _chestCtrl.dispose();
    _hipsCtrl.dispose();
    super.dispose();
  }

  void _showLogWeightSheet() {
    final ctrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
        final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
        final surface1 = isDark ? AppColorsDark.surface1 : AppColorsLight.surface1;
        final divider = isDark ? AppColorsDark.divider : AppColorsLight.divider;

        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Text('Log Weight',
                    style: AppTypography.h3(color: text0)),
                const SizedBox(height: 16),
                TextField(
                  controller: ctrl,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,1}'))
                  ],
                  autofocus: true,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: text0),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '70.0',
                    hintStyle: TextStyle(color: text2),
                    suffixText: 'kg',
                    suffixStyle: TextStyle(color: text2, fontSize: 16),
                    filled: true,
                    fillColor: isDark
                        ? AppColorsDark.surface0
                        : AppColorsLight.surface0,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppRadius.sm),
                      borderSide: BorderSide.none,
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      final val = double.tryParse(ctrl.text);
                      if (val == null) return;
                      ref
                          .read(bodyMetricsNotifierProvider.notifier)
                          .logWeight(val);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColorsDark.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppRadius.md)),
                    ),
                    child: const Text('Save Weight',
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final surface1 = isDark ? AppColorsDark.surface1 : AppColorsLight.surface1;
    final divider = isDark ? AppColorsDark.divider : AppColorsLight.divider;

    final metricsAsync = ref.watch(bodyMetricsNotifierProvider);
    final weightHistoryAsync = ref.watch(weightHistoryProvider(30));
    final bmiHistoryAsync = ref.watch(weightHistoryProvider(90));

    final metrics = metricsAsync.valueOrNull ?? {};
    final weight = (metrics['weight'] as double?) ?? 0.0;
    final bmi = (metrics['bmi'] as double?) ?? 0.0;
    final bmiClass = bmi > 0 ? _bmiClassify(bmi) : null;

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.bg0 : AppColorsLight.bg0,
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        onPressed: _showLogWeightSheet,
        backgroundColor: AppColorsDark.primary,
        shape: const CircleBorder(),
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
      body: Stack(
        children: [
          // ── Hero ──────────────────────────────────────────────
          Container(
            height: 300,
            decoration: const BoxDecoration(gradient: AppGradients.heroDeep),
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
                        Text('Body Metrics',
                            style: AppTypography.h1(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 28,
                  left: AppSpacing.screenH,
                  right: AppSpacing.screenH,
                  child: weight == 0
                      ? Text('No weight logged yet',
                          style: AppTypography.bodyMd(
                              color: Colors.white.withValues(alpha: 0.6)))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Weight — metricXL
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  weight.toStringAsFixed(1),
                                  style: AppTypography.metricXL(
                                          color: Colors.white)
                                      .copyWith(shadows: [
                                    Shadow(
                                        color: Colors.white
                                            .withValues(alpha: 0.4),
                                        blurRadius: 20),
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8, left: 6),
                                  child: Text('kg',
                                      style: AppTypography.bodyMd(
                                          color: Colors.white
                                              .withValues(alpha: 0.5))),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // BMI — monoLg + classification badge
                            Row(
                              children: [
                                Text(
                                  'BMI ${bmi.toStringAsFixed(1)}',
                                  style: AppTypography.monoLg(
                                      color: Colors.white
                                          .withValues(alpha: 0.85)),
                                ),
                                const SizedBox(width: 10),
                                if (bmiClass != null)
                                  _Pill(
                                      label: bmiClass.label,
                                      color: bmiClass.color),
                              ],
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),

          // ── Scrollable body ───────────────────────────────────
          DraggableScrollableSheet(
            initialChildSize: 0.62,
            minChildSize: 0.62,
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

                  // ── 30-day weight trend ───────────────────────
                  Text('Weight Trend (30 days)',
                      style: AppTypography.h4(color: text0)),
                  const SizedBox(height: 10),
                  GlassCard(
                    borderRadius: AppRadius.md,
                    padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                    child: weightHistoryAsync.when(
                      data: (history) => _WeightChart(
                        history: history,
                        targetWeight: _targetWeight,
                        text2: text2,
                      ),
                      loading: () => const SizedBox(
                          height: 140,
                          child: Center(
                              child:
                                  CircularProgressIndicator(strokeWidth: 2))),
                      error: (_, __) => SizedBox(
                          height: 140,
                          child: Center(
                              child: Text('No data',
                                  style: AppTypography.bodySm(
                                      color: text2)))),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Body composition half-cards ───────────────
                  Text('Body Composition',
                      style: AppTypography.h4(color: text0)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _CompositionCard(
                          label: 'Body Fat',
                          value: '--',
                          unit: '%',
                          icon: Icons.monitor_weight_outlined,
                          color: AppColorsDark.warning,
                          note: 'Connect wearable',
                          isDark: isDark,
                          text2: text2,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.bentoGap),
                      Expanded(
                        child: _CompositionCard(
                          label: 'Muscle Mass',
                          value: '--',
                          unit: 'kg',
                          icon: Icons.fitness_center_rounded,
                          color: AppColorsDark.success,
                          note: 'Connect wearable',
                          isDark: isDark,
                          text2: text2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ── BMI 90-day chart ──────────────────────────
                  Text('BMI History (90 days)',
                      style: AppTypography.h4(color: text0)),
                  const SizedBox(height: 10),
                  GlassCard(
                    borderRadius: AppRadius.md,
                    padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                    child: bmiHistoryAsync.when(
                      data: (history) => _BMIChart(
                          history: history,
                          heightCm: (metrics['height'] as double?) ?? 170,
                          text2: text2),
                      loading: () => const SizedBox(
                          height: 120,
                          child: Center(
                              child:
                                  CircularProgressIndicator(strokeWidth: 2))),
                      error: (_, __) => SizedBox(
                          height: 120,
                          child: Center(
                              child: Text('No data',
                                  style: AppTypography.bodySm(
                                      color: text2)))),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Measurements card ─────────────────────────
                  Row(
                    children: [
                      Text('Measurements',
                          style: AppTypography.h4(color: text0)),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => setState(
                            () => _editingMeasurements =
                                !_editingMeasurements),
                        child: Text(
                          _editingMeasurements ? 'Done' : 'Edit',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColorsDark.primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GlassCard(
                    borderRadius: AppRadius.md,
                    padding: const EdgeInsets.all(AppSpacing.cardH),
                    child: Column(
                      children: [
                        _MeasurementRow(
                          label: 'Waist',
                          ctrl: _waistCtrl,
                          editing: _editingMeasurements,
                          text0: text0,
                          text2: text2,
                          divider: divider,
                          isDark: isDark,
                        ),
                        Divider(color: divider, height: 1),
                        _MeasurementRow(
                          label: 'Chest',
                          ctrl: _chestCtrl,
                          editing: _editingMeasurements,
                          text0: text0,
                          text2: text2,
                          divider: divider,
                          isDark: isDark,
                        ),
                        Divider(color: divider, height: 1),
                        _MeasurementRow(
                          label: 'Hips',
                          ctrl: _hipsCtrl,
                          editing: _editingMeasurements,
                          text0: text0,
                          text2: text2,
                          divider: divider,
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Weight trend chart ─────────────────────────────────────────────────────────

class _WeightChart extends StatelessWidget {
  final List<dynamic> history;
  final double targetWeight;
  final Color text2;
  const _WeightChart(
      {required this.history,
      required this.targetWeight,
      required this.text2});

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return SizedBox(
          height: 140,
          child: Center(
              child: Text('No weight logs yet',
                  style: AppTypography.bodySm(color: text2))));
    }

    final sorted = [...history]
      ..sort((a, b) => (a.measuredAt as DateTime)
          .compareTo(b.measuredAt as DateTime));
    final spots = sorted.asMap().entries.map((e) {
      return FlSpot(
          e.key.toDouble(), (e.value.weightKg as double));
    }).toList();

    final allWeights = sorted.map((e) => e.weightKg as double).toList();
    final minY = (allWeights.reduce((a, b) => a < b ? a : b) - 2)
        .clamp(0.0, double.infinity);
    final maxY = allWeights.reduce((a, b) => a > b ? a : b) + 2;

    return SizedBox(
      height: 160,
      child: LineChart(
        LineChartData(
          minY: minY,
          maxY: maxY,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) =>
                FlLine(color: AppColorsDark.divider, strokeWidth: 1),
          ),
          borderData: FlBorderData(show: false),
          titlesData: const FlTitlesData(
            leftTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            // Weight line
            LineChartBarData(
              spots: spots,
              isCurved: true,
              curveSmoothness: 0.3,
              color: AppColorsDark.primary,
              barWidth: 2.5,
              dotData: FlDotData(
                show: true,
                getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
                    radius: 3,
                    color: AppColorsDark.primary,
                    strokeWidth: 0),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColorsDark.primary.withValues(alpha: 0.2),
                    AppColorsDark.primary.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
            // Target dashed line
            LineChartBarData(
              spots: [
                FlSpot(0, targetWeight),
                FlSpot((spots.length - 1).toDouble(), targetWeight),
              ],
              isCurved: false,
              color: AppColorsDark.success.withValues(alpha: 0.5),
              barWidth: 1.5,
              dashArray: [5, 5],
              dotData: const FlDotData(show: false),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      ),
    );
  }
}

// ── BMI chart ──────────────────────────────────────────────────────────────────

class _BMIChart extends StatelessWidget {
  final List<dynamic> history;
  final double heightCm;
  final Color text2;
  const _BMIChart(
      {required this.history,
      required this.heightCm,
      required this.text2});

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty || heightCm == 0) {
      return SizedBox(
          height: 120,
          child: Center(
              child: Text('No data',
                  style: AppTypography.bodySm(color: text2))));
    }

    final sorted = [...history]
      ..sort((a, b) => (a.measuredAt as DateTime)
          .compareTo(b.measuredAt as DateTime));
    final hM = heightCm / 100;
    final spots = sorted.asMap().entries.map((e) {
      final bmi = (e.value.weightKg as double) / (hM * hM);
      return FlSpot(e.key.toDouble(), bmi);
    }).toList();

    return SizedBox(
      height: 120,
      child: LineChart(
        LineChartData(
          minY: 15,
          maxY: 40,
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: const FlTitlesData(
            leftTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          rangeAnnotations: RangeAnnotations(
            horizontalRangeAnnotations: [
              HorizontalRangeAnnotation(
                  y1: 18.5,
                  y2: 25,
                  color: AppColorsDark.success.withValues(alpha: 0.08)),
            ],
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: AppColorsDark.secondary,
              barWidth: 2,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColorsDark.secondary.withValues(alpha: 0.15),
                    AppColorsDark.secondary.withValues(alpha: 0.0),
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

// ── Body composition card ──────────────────────────────────────────────────────

class _CompositionCard extends StatelessWidget {
  final String label, value, unit, note;
  final IconData icon;
  final Color color;
  final bool isDark;
  final Color text2;
  const _CompositionCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    required this.note,
    required this.isDark,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) => GlassCard(
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
                    style: AppTypography.caption(color: text2)),
              ],
            ),
            const SizedBox(height: 8),
            Text(value, style: AppTypography.monoLg(color: color)),
            Text(unit,
                style: AppTypography.caption(color: text2)),
            const SizedBox(height: 4),
            Text(note,
                style: AppTypography.caption(
                    color: text2.withValues(alpha: 0.6))),
          ],
        ),
      );
}

// ── Measurement row ────────────────────────────────────────────────────────────

class _MeasurementRow extends StatelessWidget {
  final String label;
  final TextEditingController ctrl;
  final bool editing;
  final Color text0, text2, divider;
  final bool isDark;
  const _MeasurementRow({
    required this.label,
    required this.ctrl,
    required this.editing,
    required this.text0,
    required this.text2,
    required this.divider,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
                child: Text(label,
                    style: AppTypography.bodyMd(color: text0))),
            if (editing)
              SizedBox(
                width: 80,
                child: TextField(
                  controller: ctrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: text0),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: '--',
                    hintStyle: TextStyle(color: text2),
                    suffixText: 'cm',
                    suffixStyle:
                        TextStyle(color: text2, fontSize: 11),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              )
            else
              Text(
                ctrl.text.isEmpty ? '-- cm' : '${ctrl.text} cm',
                style: AppTypography.bodyMd(color: text2),
              ),
          ],
        ),
      );
}

// ── Pill ───────────────────────────────────────────────────────────────────────

class _Pill extends StatelessWidget {
  final String label;
  final Color color;
  const _Pill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) => Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: color)),
      );
}
