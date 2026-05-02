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
import '../../../shared/widgets/metric_widgets.dart';
import '../../../shared/widgets/status_widgets.dart';
import '../providers/health_provider.dart';

class SpO2Screen extends ConsumerWidget {
  const SpO2Screen({super.key});

  void _showLogSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _LogSpO2Sheet(
        onSave: (spo2, pulse) {
          ref.read(spO2Provider.notifier).logReading(
                spo2Percentage: spo2,
                pulse: pulse,
              );
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final surface1 = isDark ? AppColorsDark.surface1 : AppColorsLight.surface1;
    final divider = isDark ? AppColorsDark.divider : AppColorsLight.divider;

    final latestAsync = ref.watch(spO2Provider);
    final latest = latestAsync.asData?.value.isNotEmpty == true
        ? latestAsync.value!.first
        : null;
    final isLow = latest != null && latest.spo2Percentage < 95;

    // Build 7-day history from all readings
    final allReadings = latestAsync.asData?.value ?? [];

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.bg0 : AppColorsLight.bg0,
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showLogSheet(context, ref),
        backgroundColor: AppColorsDark.teal,
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
                        Text('SpO₂',
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
                                  '${latest.spo2Percentage}',
                                  style: AppTypography.metricXL(
                                          color: AppColorsDark.teal)
                                      .copyWith(shadows: [
                                    Shadow(
                                        color: AppColorsDark.teal
                                            .withValues(alpha: 0.6),
                                        blurRadius: 24),
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8, left: 4),
                                  child: Text('%',
                                      style: AppTypography.displayMd(
                                          color: Colors.white
                                              .withValues(alpha: 0.5))),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            if (latest.pulse != null)
                              Text('${latest.pulse} bpm',
                                  style: AppTypography.bodyLg(
                                      color: Colors.white
                                          .withValues(alpha: 0.75))),
                            const SizedBox(height: 4),
                            Text(
                              _fmtTime(latest.measuredAt),
                              style: AppTypography.caption(
                                  color: Colors.white
                                      .withValues(alpha: 0.5)),
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

                  // ── Low SpO2 alert banner ─────────────────────
                  if (isLow) ...[
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.cardH),
                      decoration: BoxDecoration(
                        color: AppColorsDark.error.withValues(alpha: 0.1),
                        borderRadius:
                            BorderRadius.circular(AppRadius.md),
                        border: Border.all(
                            color: AppColorsDark.error
                                .withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        children: [
                          PulseRing(
                            color: AppColorsDark.error,
                            child: const SizedBox(width: 32, height: 32),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text('⚠ SpO₂ is low',
                                    style: AppTypography.labelMd(
                                        color: AppColorsDark.error)),
                                Text(
                                    'Seek medical attention if this persists.',
                                    style: AppTypography.bodySm(
                                        color: AppColorsDark.error
                                            .withValues(alpha: 0.8))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // ── 7-day chart ───────────────────────────────
                  Text('7-Day History',
                      style: AppTypography.h4(color: text0)),
                  const SizedBox(height: 10),
                  GlassCard(
                    borderRadius: AppRadius.md,
                    padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                    child: _SpO2Chart(
                        readings: allReadings.take(28).toList(),
                        text2: text2),
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

// ── SpO2 chart ─────────────────────────────────────────────────────────────────

class _SpO2Chart extends StatelessWidget {
  final List<dynamic> readings;
  final Color text2;
  const _SpO2Chart({required this.readings, required this.text2});

  @override
  Widget build(BuildContext context) {
    if (readings.isEmpty) {
      return SizedBox(
          height: 140,
          child: Center(
              child: Text('No readings yet',
                  style: AppTypography.bodySm(color: text2))));
    }

    final sorted = [...readings]
      ..sort((a, b) => (a.measuredAt as DateTime)
          .compareTo(b.measuredAt as DateTime));
    final spots = sorted.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(),
          (e.value.spo2Percentage as int).toDouble());
    }).toList();

    return SizedBox(
      height: 160,
      child: LineChart(
        LineChartData(
          minY: 85,
          maxY: 102,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) =>
                FlLine(color: AppColorsDark.divider, strokeWidth: 1),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                interval: 5,
                getTitlesWidget: (v, _) => Text('${v.toInt()}',
                    style: TextStyle(fontSize: 9, color: text2)),
              ),
            ),
            rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            bottomTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
          ),
          // 95–100% target band
          rangeAnnotations: RangeAnnotations(
            horizontalRangeAnnotations: [
              HorizontalRangeAnnotation(
                  y1: 95,
                  y2: 102,
                  color: AppColorsDark.teal.withValues(alpha: 0.08)),
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
                  final isLow = spot.y < 95;
                  return FlDotCirclePainter(
                      radius: 3.5,
                      color: isLow
                          ? AppColorsDark.error
                          : AppColorsDark.teal,
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

// ── Log SpO2 sheet ─────────────────────────────────────────────────────────────

class _LogSpO2Sheet extends StatefulWidget {
  final void Function(int spo2, int? pulse) onSave;
  const _LogSpO2Sheet({required this.onSave});

  @override
  State<_LogSpO2Sheet> createState() => _LogSpO2SheetState();
}

class _LogSpO2SheetState extends State<_LogSpO2Sheet> {
  final _spo2Ctrl = TextEditingController();
  final _pulseCtrl = TextEditingController();

  @override
  void dispose() {
    _spo2Ctrl.dispose();
    _pulseCtrl.dispose();
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
                Text('Log SpO₂',
                    style: AppTypography.h3(color: text0)),
                const Spacer(),
                const EncryptionBadge(),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _SheetField(
                      ctrl: _spo2Ctrl,
                      label: 'SpO₂ %',
                      hint: '98',
                      suffix: '%',
                      text0: text0,
                      text2: text2,
                      isDark: isDark),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SheetField(
                      ctrl: _pulseCtrl,
                      label: 'Pulse (optional)',
                      hint: '72',
                      suffix: 'bpm',
                      text0: text0,
                      text2: text2,
                      isDark: isDark),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  final spo2 = int.tryParse(_spo2Ctrl.text);
                  if (spo2 == null) return;
                  widget.onSave(spo2, int.tryParse(_pulseCtrl.text));
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

class _SheetField extends StatelessWidget {
  final TextEditingController ctrl;
  final String label, hint, suffix;
  final Color text0, text2;
  final bool isDark;
  const _SheetField(
      {required this.ctrl,
      required this.label,
      required this.hint,
      required this.suffix,
      required this.text0,
      required this.text2,
      required this.isDark});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTypography.caption(color: text2)),
          const SizedBox(height: 4),
          TextField(
            controller: ctrl,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: text0),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: text2),
              suffixText: suffix,
              suffixStyle: TextStyle(color: text2, fontSize: 12),
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
                  horizontal: 8, vertical: 12),
            ),
          ),
        ],
      );
}

String _fmtTime(DateTime dt) {
  final h = dt.hour > 12 ? dt.hour - 12 : dt.hour == 0 ? 12 : dt.hour;
  final m = dt.minute.toString().padLeft(2, '0');
  final ampm = dt.hour >= 12 ? 'PM' : 'AM';
  return '$h:$m $ampm · ${dt.day}/${dt.month}';
}
