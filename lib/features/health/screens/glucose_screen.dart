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
import '../../../shared/widgets/status_widgets.dart';
import '../providers/health_provider.dart';

// ── Glucose classification ─────────────────────────────────────────────────────

typedef _GClass = ({String label, Color color});

_GClass _glucoseClassify(double mg, String type) {
  if (type == 'fasting') {
    if (mg < 100) return (label: 'Normal', color: AppColorsDark.success);
    if (mg < 126) return (label: 'Pre-diabetic', color: AppColorsDark.warning);
    return (label: 'Diabetic', color: AppColorsDark.error);
  }
  // post-meal / random / bedtime
  if (mg < 140) return (label: 'Normal', color: AppColorsDark.success);
  if (mg < 200) return (label: 'Pre-diabetic', color: AppColorsDark.warning);
  return (label: 'Diabetic', color: AppColorsDark.error);
}

// Target bands per reading type (min, max)
Map<String, (double, double)> _targetBands = {
  'fasting':   (70, 100),
  'post_meal': (70, 140),
  'random':    (70, 140),
  'bedtime':   (100, 140),
};

const _readingTypes = ['fasting', 'post_meal', 'random', 'bedtime'];
const _readingLabels = ['Fasting', 'Post-meal', 'Random', 'Bedtime'];

// ── Screen ─────────────────────────────────────────────────────────────────────

class GlucoseScreen extends ConsumerStatefulWidget {
  const GlucoseScreen({super.key});

  @override
  ConsumerState<GlucoseScreen> createState() => _GlucoseScreenState();
}

class _GlucoseScreenState extends ConsumerState<GlucoseScreen> {
  int _typeIndex = 0;

  void _showLogSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _LogGlucoseSheet(
        selectedType: _readingTypes[_typeIndex],
        onSave: (value, type) {
          ref.read(glucoseNotifierProvider.notifier).logReading(
                value: value,
                readingType: type,
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
    final primary = isDark ? AppColorsDark.primary : AppColorsLight.primary;
    final surface0 = isDark ? AppColorsDark.surface0 : AppColorsLight.surface0;

    final latestAsync = ref.watch(latestGlucoseProvider);
    final allAsync = ref.watch(glucoseNotifierProvider);

    final latest = latestAsync.asData?.value;
    final gClass = latest != null
        ? _glucoseClassify(latest.valueMgDl, latest.readingType)
        : null;

    final allReadings = allAsync.asData?.value ?? [];
    final filteredReadings = allReadings
        .where((r) => r.readingType == _readingTypes[_typeIndex])
        .toList();
    final showHbA1c = allReadings.length >= 30;

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.bg0 : AppColorsLight.bg0,
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        onPressed: _showLogSheet,
        backgroundColor: primary,
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
                        Text('Glucose',
                            style: AppTypography.h1(color: Colors.white)),
                        const Spacer(),
                        const EncryptionBadge(),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 28,
                  left: AppSpacing.screenH,
                  right: AppSpacing.screenH,
                  child: latest == null
                      ? Text('No readings yet',
                          style: AppTypography.bodyMd(
                              color: Colors.white.withValues(alpha: 0.6)))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  latest.valueMgDl.toStringAsFixed(0),
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
                                  child: Text('mg/dL',
                                      style: AppTypography.bodyMd(
                                          color: Colors.white
                                              .withValues(alpha: 0.5))),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                if (gClass != null)
                                  _Pill(
                                      label: gClass.label,
                                      color: gClass.color),
                                const SizedBox(width: 8),
                                _Pill(
                                    label: _readingLabels[_readingTypes
                                        .indexOf(latest.readingType)
                                        .clamp(0, 3)],
                                    color: AppColorsDark.secondary),
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
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                          color: divider,
                          borderRadius: BorderRadius.circular(2)),
                    ),
                  ),

                  // ── Reading type pills ────────────────────────
                  SizedBox(
                    height: 36,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _readingTypes.length,
                      itemBuilder: (_, i) {
                        final active = i == _typeIndex;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _typeIndex = i),
                            child: AnimatedContainer(
                              duration:
                                  const Duration(milliseconds: 160),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 7),
                              decoration: BoxDecoration(
                                color: active ? primary : surface0,
                                borderRadius: BorderRadius.circular(
                                    AppRadius.full),
                                border: Border.all(
                                    color: active
                                        ? Colors.transparent
                                        : divider),
                              ),
                              child: Text(_readingLabels[i],
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: active
                                          ? Colors.white
                                          : text2)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── History chart ─────────────────────────────
                  GlassCard(
                    borderRadius: AppRadius.md,
                    padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                    child: _GlucoseChart(
                      readings: filteredReadings,
                      readingType: _readingTypes[_typeIndex],
                      text2: text2,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── HbA1c estimator ───────────────────────────
                  if (showHbA1c) ...[
                    _HbA1cCard(
                        readings: allReadings,
                        text0: text0,
                        text2: text2),
                    const SizedBox(height: 20),
                  ],

                  // ── Meal correlation row ──────────────────────
                  GlassCard(
                    borderRadius: AppRadius.md,
                    padding: const EdgeInsets.all(AppSpacing.cardH),
                    child: Row(
                      children: [
                        const Icon(Icons.restaurant_rounded,
                            size: 16, color: AppColorsDark.accent),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text('Meal Correlation',
                                  style: AppTypography.labelMd(
                                      color: text0)),
                              Text(
                                  'Link post-meal readings to food logs',
                                  style: AppTypography.bodySm(
                                      color: text2)),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right_rounded,
                            color: text2, size: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // ── Import from lab report ────────────────────
                  GlassCard(
                    borderRadius: AppRadius.md,
                    padding: const EdgeInsets.all(AppSpacing.cardH),
                    child: Row(
                      children: [
                        const Icon(Icons.science_rounded,
                            size: 16, color: AppColorsDark.teal),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text('Import from Lab Report',
                              style: AppTypography.labelMd(
                                  color: text0)),
                        ),
                        Icon(Icons.arrow_forward_rounded,
                            color: AppColorsDark.teal, size: 18),
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

// ── Glucose chart ──────────────────────────────────────────────────────────────

class _GlucoseChart extends StatelessWidget {
  final List<dynamic> readings;
  final String readingType;
  final Color text2;
  const _GlucoseChart(
      {required this.readings,
      required this.readingType,
      required this.text2});

  @override
  Widget build(BuildContext context) {
    if (readings.isEmpty) {
      return SizedBox(
          height: 140,
          child: Center(
              child: Text('No $readingType readings yet',
                  style: AppTypography.bodySm(color: text2))));
    }

    final sorted = [...readings]
      ..sort((a, b) => (a.measuredAt as DateTime)
          .compareTo(b.measuredAt as DateTime));
    final spots = sorted.asMap().entries.map((e) {
      return FlSpot(
          e.key.toDouble(), (e.value.valueMgDl as double));
    }).toList();

    final band = _targetBands[readingType] ?? (70.0, 140.0);

    return SizedBox(
      height: 160,
      child: LineChart(
        LineChartData(
          minY: 50,
          maxY: 300,
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
          rangeAnnotations: RangeAnnotations(
            horizontalRangeAnnotations: [
              HorizontalRangeAnnotation(
                  y1: band.$1,
                  y2: band.$2,
                  color: AppColorsDark.success.withValues(alpha: 0.08)),
            ],
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              curveSmoothness: 0.3,
              color: AppColorsDark.teal,
              barWidth: 2.5,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, _, __, ___) {
                  final val = spot.y;
                  final inRange = val >= band.$1 && val <= band.$2;
                  return FlDotCirclePainter(
                      radius: 3.5,
                      color: inRange
                          ? AppColorsDark.success
                          : AppColorsDark.error,
                      strokeWidth: 0);
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColorsDark.teal.withValues(alpha: 0.2),
                    AppColorsDark.teal.withValues(alpha: 0.0),
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

// ── HbA1c estimator card ───────────────────────────────────────────────────────

class _HbA1cCard extends StatelessWidget {
  final List<dynamic> readings;
  final Color text0, text2;
  const _HbA1cCard(
      {required this.readings,
      required this.text0,
      required this.text2});

  double _estimateHbA1c() {
    if (readings.isEmpty) return 0;
    final avg = readings.fold(0.0, (s, r) => s + (r.valueMgDl as double)) /
        readings.length;
    // Nathan formula: HbA1c = (avg + 46.7) / 28.7
    return (avg + 46.7) / 28.7;
  }

  @override
  Widget build(BuildContext context) {
    final hba1c = _estimateHbA1c();
    final color = hba1c < 5.7
        ? AppColorsDark.success
        : hba1c < 6.5
            ? AppColorsDark.warning
            : AppColorsDark.error;

    return GlassCard(
      borderRadius: AppRadius.md,
      padding: const EdgeInsets.all(AppSpacing.cardH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.biotech_rounded,
                  size: 16, color: AppColorsDark.secondary),
              const SizedBox(width: 8),
              Text('Estimated HbA1c',
                  style: AppTypography.labelMd(
                      color: AppColorsDark.secondary)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(hba1c.toStringAsFixed(1),
                  style: AppTypography.monoLg(color: color)),
              Padding(
                padding: const EdgeInsets.only(bottom: 4, left: 4),
                child: Text('%',
                    style: AppTypography.bodyMd(color: text2)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Based on ${readings.length} readings. Not a medical diagnosis.',
            style: AppTypography.caption(color: text2),
          ),
        ],
      ),
    );
  }
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

// ── Log Glucose bottom sheet ───────────────────────────────────────────────────

class _LogGlucoseSheet extends StatefulWidget {
  final String selectedType;
  final void Function(double value, String type) onSave;
  const _LogGlucoseSheet(
      {required this.selectedType, required this.onSave});

  @override
  State<_LogGlucoseSheet> createState() => _LogGlucoseSheetState();
}

class _LogGlucoseSheetState extends State<_LogGlucoseSheet> {
  final _ctrl = TextEditingController();
  late String _type;

  @override
  void initState() {
    super.initState();
    _type = widget.selectedType;
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            Row(
              children: [
                Text('Log Glucose',
                    style: AppTypography.h3(color: text0)),
                const Spacer(),
                const EncryptionBadge(),
              ],
            ),
            const SizedBox(height: 16),
            // Type selector
            Wrap(
              spacing: 8,
              children: List.generate(_readingTypes.length, (i) {
                final active = _type == _readingTypes[i];
                return GestureDetector(
                  onTap: () =>
                      setState(() => _type = _readingTypes[i]),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: active
                          ? AppColorsDark.teal
                          : (isDark
                              ? AppColorsDark.surface0
                              : AppColorsLight.surface0),
                      borderRadius:
                          BorderRadius.circular(AppRadius.full),
                      border: Border.all(
                          color: active
                              ? Colors.transparent
                              : divider),
                    ),
                    child: Text(_readingLabels[i],
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: active ? Colors.white : text2)),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _ctrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,1}'))
              ],
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: text0),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: '95',
                hintStyle: TextStyle(color: text2),
                suffixText: 'mg/dL',
                suffixStyle: TextStyle(color: text2, fontSize: 14),
                filled: true,
                fillColor: isDark
                    ? AppColorsDark.surface0
                    : AppColorsLight.surface0,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  borderSide: BorderSide.none,
                ),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  final val = double.tryParse(_ctrl.text);
                  if (val == null) return;
                  widget.onSave(val, _type);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColorsDark.teal,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppRadius.md)),
                ),
                child: const Text('Save Reading',
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
