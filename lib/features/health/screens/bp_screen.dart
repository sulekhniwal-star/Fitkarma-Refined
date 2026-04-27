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

// ── AHA classification ─────────────────────────────────────────────────────────

typedef _AHAClass = ({String label, Color color});

_AHAClass _ahaClassify(int sys, int dia) {
  if (sys < 120 && dia < 80) return (label: 'Normal', color: AppColorsDark.success);
  if (sys < 130 && dia < 80) return (label: 'Elevated', color: AppColorsDark.warning);
  if (sys < 140 || dia < 90) return (label: 'Stage 1', color: AppColorsDark.primary);
  if (sys < 180 || dia < 120) return (label: 'Stage 2', color: AppColorsDark.error);
  return (label: 'Crisis', color: const Color(0xFFFF0000));
}

// ── Screen ─────────────────────────────────────────────────────────────────────

class BPScreen extends ConsumerStatefulWidget {
  const BPScreen({super.key});

  @override
  ConsumerState<BPScreen> createState() => _BPScreenState();
}

class _BPScreenState extends ConsumerState<BPScreen> {
  int _dayRange = 7; // 7 / 30 / 90
  bool _morningReminder = true;
  bool _eveningReminder = true;

  void _showLogSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _LogBPSheet(
        onSave: (sys, dia, pulse, notes) {
          ref.read(bPNotifierProvider.notifier).logReading(
                systolic: sys,
                diastolic: dia,
                pulse: pulse,
                notes: notes,
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

    final latestAsync = ref.watch(latestBpReadingProvider);
    final historyAsync = ref.watch(bPNotifierProvider);

    final latest = latestAsync.valueOrNull;
    final aha = latest != null
        ? _ahaClassify(latest.systolic, latest.diastolic)
        : null;

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.bg0 : AppColorsLight.bg0,
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        onPressed: _showLogSheet,
        backgroundColor: AppColorsDark.primary,
        shape: const CircleBorder(),
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
      body: Stack(
        children: [
          // ── Hero ──────────────────────────────────────────────
          Container(
            height: 320,
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
                        Text('Blood Pressure',
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
                            // metricXL reading with neon glow per number
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _GlowNumber(
                                    value: '${latest.systolic}',
                                    color: Colors.white),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8, left: 4, right: 4),
                                  child: Text('/',
                                      style: AppTypography.displayLg(
                                          color: Colors.white
                                              .withValues(alpha: 0.5))),
                                ),
                                _GlowNumber(
                                    value: '${latest.diastolic}',
                                    color: Colors.white),
                                const SizedBox(width: 8),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text('mmHg',
                                      style: AppTypography.bodyMd(
                                          color: Colors.white
                                              .withValues(alpha: 0.5))),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                if (aha != null)
                                  _ClassBadge(label: aha.label, color: aha.color),
                                const SizedBox(width: 12),
                                if (latest.pulse != null)
                                  Text(
                                    '${latest.pulse} bpm',
                                    style: AppTypography.bodyLg(
                                        color: Colors.white
                                            .withValues(alpha: 0.75)),
                                  ),
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

                  // ── Period toggle ─────────────────────────────
                  _PeriodToggle(
                    selected: _dayRange,
                    onChanged: (v) => setState(() => _dayRange = v),
                    text0: text0,
                    text2: text2,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 12),

                  // ── Trend chart ───────────────────────────────
                  GlassCard(
                    borderRadius: AppRadius.md,
                    padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                    child: historyAsync.when(
                      data: (readings) => _BPTrendChart(
                        readings: readings
                            .where((r) => r.measuredAt.isAfter(
                                DateTime.now()
                                    .subtract(Duration(days: _dayRange))))
                            .toList(),
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
                                  style:
                                      AppTypography.bodySm(color: text2)))),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Reminders card ────────────────────────────
                  Text('Reminders', style: AppTypography.h4(color: text0)),
                  const SizedBox(height: 10),
                  GlassCard(
                    borderRadius: AppRadius.md,
                    padding: const EdgeInsets.all(AppSpacing.cardH),
                    child: Column(
                      children: [
                        _ReminderRow(
                          label: 'Morning (8:00 AM)',
                          icon: Icons.wb_sunny_rounded,
                          color: AppColorsDark.accent,
                          enabled: _morningReminder,
                          onToggle: (v) =>
                              setState(() => _morningReminder = v),
                          text0: text0,
                          text2: text2,
                          divider: divider,
                        ),
                        Divider(color: divider, height: 1),
                        _ReminderRow(
                          label: 'Evening (8:00 PM)',
                          icon: Icons.nights_stay_rounded,
                          color: AppColorsDark.secondary,
                          enabled: _eveningReminder,
                          onToggle: (v) =>
                              setState(() => _eveningReminder = v),
                          text0: text0,
                          text2: text2,
                          divider: divider,
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

// ── Glow number ────────────────────────────────────────────────────────────────

class _GlowNumber extends StatelessWidget {
  final String value;
  final Color color;
  const _GlowNumber({required this.value, required this.color});

  @override
  Widget build(BuildContext context) => Text(
        value,
        style: AppTypography.metricXL(color: color).copyWith(
          shadows: [
            Shadow(
                color: color.withValues(alpha: 0.5), blurRadius: 20),
            Shadow(
                color: color.withValues(alpha: 0.25), blurRadius: 40),
          ],
        ),
      );
}

// ── Classification badge ───────────────────────────────────────────────────────

class _ClassBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _ClassBadge({required this.label, required this.color});

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

// ── Period toggle ──────────────────────────────────────────────────────────────

class _PeriodToggle extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;
  final Color text0, text2;
  final bool isDark;
  const _PeriodToggle(
      {required this.selected,
      required this.onChanged,
      required this.text0,
      required this.text2,
      required this.isDark});

  @override
  Widget build(BuildContext context) {
    final primary =
        isDark ? AppColorsDark.primary : AppColorsLight.primary;
    final surface0 =
        isDark ? AppColorsDark.surface0 : AppColorsLight.surface0;
    final divider =
        isDark ? AppColorsDark.divider : AppColorsLight.divider;
    return Row(
      children: [7, 30, 90].map((d) {
        final active = selected == d;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () => onChanged(d),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 7),
              decoration: BoxDecoration(
                color: active ? primary : surface0,
                borderRadius:
                    BorderRadius.circular(AppRadius.full),
                border: Border.all(
                    color: active ? Colors.transparent : divider),
              ),
              child: Text('${d}d',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: active ? Colors.white : text2)),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ── BP trend chart ─────────────────────────────────────────────────────────────

class _BPTrendChart extends StatelessWidget {
  final List<dynamic> readings;
  final Color text2;
  const _BPTrendChart({required this.readings, required this.text2});

  @override
  Widget build(BuildContext context) {
    if (readings.isEmpty) {
      return SizedBox(
          height: 140,
          child: Center(
              child: Text('No readings in this period',
                  style: AppTypography.bodySm(color: text2))));
    }

    final sorted = [...readings]
      ..sort((a, b) => (a.measuredAt as DateTime)
          .compareTo(b.measuredAt as DateTime));

    final sysSpots = sorted.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), (e.value.systolic as int).toDouble());
    }).toList();
    final diaSpots = sorted.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), (e.value.diastolic as int).toDouble());
    }).toList();

    return SizedBox(
      height: 160,
      child: LineChart(
        LineChartData(
          minY: 50,
          maxY: 200,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
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
          // AHA reference bands
          rangeAnnotations: RangeAnnotations(
            horizontalRangeAnnotations: [
              HorizontalRangeAnnotation(
                  y1: 50,
                  y2: 120,
                  color: AppColorsDark.success.withValues(alpha: 0.05)),
              HorizontalRangeAnnotation(
                  y1: 120,
                  y2: 130,
                  color: AppColorsDark.warning.withValues(alpha: 0.07)),
              HorizontalRangeAnnotation(
                  y1: 130,
                  y2: 140,
                  color: AppColorsDark.primary.withValues(alpha: 0.07)),
              HorizontalRangeAnnotation(
                  y1: 140,
                  y2: 200,
                  color: AppColorsDark.error.withValues(alpha: 0.07)),
            ],
          ),
          lineBarsData: [
            // Systolic
            LineChartBarData(
              spots: sysSpots,
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
            ),
            // Diastolic
            LineChartBarData(
              spots: diaSpots,
              isCurved: true,
              curveSmoothness: 0.3,
              color: AppColorsDark.secondary,
              barWidth: 2,
              dotData: FlDotData(
                show: true,
                getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
                    radius: 3,
                    color: AppColorsDark.secondary,
                    strokeWidth: 0),
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

// ── Reminder row ───────────────────────────────────────────────────────────────

class _ReminderRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool enabled;
  final ValueChanged<bool> onToggle;
  final Color text0, text2, divider;
  const _ReminderRow(
      {required this.label,
      required this.icon,
      required this.color,
      required this.enabled,
      required this.onToggle,
      required this.text0,
      required this.text2,
      required this.divider});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 10),
            Expanded(
                child: Text(label,
                    style: AppTypography.bodyMd(color: text0))),
            Switch(
              value: enabled,
              onChanged: onToggle,
              activeThumbColor: AppColorsDark.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      );
}

// ── Log BP bottom sheet ────────────────────────────────────────────────────────

class _LogBPSheet extends StatefulWidget {
  final void Function(int sys, int dia, int? pulse, String? notes) onSave;
  const _LogBPSheet({required this.onSave});

  @override
  State<_LogBPSheet> createState() => _LogBPSheetState();
}

class _LogBPSheetState extends State<_LogBPSheet> {
  final _sysCtrl = TextEditingController();
  final _diaCtrl = TextEditingController();
  final _pulseCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  @override
  void dispose() {
    _sysCtrl.dispose();
    _diaCtrl.dispose();
    _pulseCtrl.dispose();
    _notesCtrl.dispose();
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
                Text('Log Blood Pressure',
                    style: AppTypography.h3(color: text0)),
                const Spacer(),
                const EncryptionBadge(),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: _NumField(
                        ctrl: _sysCtrl,
                        label: 'Systolic',
                        hint: '120',
                        text0: text0,
                        text2: text2)),
                const SizedBox(width: 12),
                Expanded(
                    child: _NumField(
                        ctrl: _diaCtrl,
                        label: 'Diastolic',
                        hint: '80',
                        text0: text0,
                        text2: text2)),
                const SizedBox(width: 12),
                Expanded(
                    child: _NumField(
                        ctrl: _pulseCtrl,
                        label: 'Pulse',
                        hint: '72',
                        text0: text0,
                        text2: text2)),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _notesCtrl,
              style: TextStyle(fontSize: 14, color: text0),
              decoration: InputDecoration(
                hintText: 'Notes (optional)',
                hintStyle: TextStyle(color: text2),
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
                    horizontal: 12, vertical: 10),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  final sys = int.tryParse(_sysCtrl.text);
                  final dia = int.tryParse(_diaCtrl.text);
                  if (sys == null || dia == null) return;
                  widget.onSave(sys, dia,
                      int.tryParse(_pulseCtrl.text),
                      _notesCtrl.text.isEmpty ? null : _notesCtrl.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColorsDark.primary,
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

class _NumField extends StatelessWidget {
  final TextEditingController ctrl;
  final String label, hint;
  final Color text0, text2;
  const _NumField(
      {required this.ctrl,
      required this.label,
      required this.hint,
      required this.text0,
      required this.text2});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTypography.caption(color: text2)),
        const SizedBox(height: 4),
        TextField(
          controller: ctrl,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: text0),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: text2),
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
                horizontal: 8, vertical: 10),
          ),
        ),
      ],
    );
  }
}
