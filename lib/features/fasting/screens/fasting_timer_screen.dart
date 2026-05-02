import 'dart:async';
import 'package:flutter/material.dart';
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
import '../../fasting/providers/fasting_provider.dart';
import '../../festival/providers/festival_provider.dart';

// ── Stage metadata ─────────────────────────────────────────────────────────────

const _stageTimeline = [
  (label: 'Fed',        hours: 0,  color: AppColorsDark.textMuted),
  (label: 'Fasted',     hours: 12, color: AppColorsDark.accent),
  (label: 'Fat Burn',   hours: 16, color: AppColorsDark.primary),
  (label: 'Ketosis',    hours: 24, color: AppColorsDark.secondary),
  (label: 'Autophagy',  hours: 48, color: AppColorsDark.teal),
];

const _fastingTypes = ['16:8', '18:6', '24h', 'OMAD', 'Custom'];

Color _stageColor(FastingStage stage) => switch (stage) {
      FastingStage.none => AppColorsDark.textMuted,
      FastingStage.bloodSugarRising => AppColorsDark.warning,
      FastingStage.bloodSugarFalling => AppColorsDark.accent,
      FastingStage.normalBloodSugar => AppColorsDark.success,
      FastingStage.transitionToFatBurning => AppColorsDark.primary,
      FastingStage.fatBurning => AppColorsDark.primary,
      FastingStage.ketosis => AppColorsDark.secondary,
      FastingStage.autophagy => AppColorsDark.teal,
    };

// ── Screen ─────────────────────────────────────────────────────────────────────

class FastingTimerScreen extends ConsumerStatefulWidget {
  const FastingTimerScreen({super.key});

  @override
  ConsumerState<FastingTimerScreen> createState() =>
      _FastingTimerScreenState();
}

class _FastingTimerScreenState extends ConsumerState<FastingTimerScreen> {
  Timer? _ticker;
  int _selectedTypeIndex = 0;

  @override
  void initState() {
    super.initState();
    // Tick every second to update countdown display
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  double _stageProgress(Duration elapsed) {
    final hours = elapsed.inHours;
    // Progress toward 48h autophagy as max
    return (hours / 48).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final surface1 = isDark ? AppColorsDark.surface1 : AppColorsLight.surface1;
    final divider = isDark ? AppColorsDark.divider : AppColorsLight.divider;
    final surface0 = isDark ? AppColorsDark.surface0 : AppColorsLight.surface0;

    final startTime = ref.watch(fastingTimerProvider);
    final stage = ref.watch(fastingStageProvider);
    final elapsed = ref.watch(fastingDurationProvider);
    final isActive = startTime != null;
    final stageColor = _stageColor(stage);

    final activeFestivals =
        ref.watch(activeFestivalsProvider).valueOrNull ?? [];

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.bg0 : AppColorsLight.bg0,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // ── Hero ──────────────────────────────────────────────
          Container(
            height: 360,
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
                        Text('Fasting Timer',
                            style: AppTypography.h1(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                // Hero content
                Positioned(
                  bottom: 28,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      // Stage name — displayMd
                      Text(
                        stage.title,
                        style: AppTypography.displayMd(color: stageColor),
                      ),
                      const SizedBox(height: 20),
                      // PulseRing + heroDisplay countdown
                      SizedBox(
                        width: 220,
                        height: 220,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if (isActive)
                              PulseRing(
                                color: stageColor,
                                child: const SizedBox(
                                    width: 200, height: 200),
                              ),
                            Text(
                              isActive
                                  ? _formatDuration(elapsed)
                                  : '00:00:00',
                              style: AppTypography.heroDisplay(
                                      color: Colors.white)
                                  .copyWith(
                                fontSize: 44,
                                fontFamily: 'JetBrainsMono',
                                shadows: isActive
                                    ? [
                                        Shadow(
                                            color: stageColor
                                                .withValues(alpha: 0.6),
                                            blurRadius: 24),
                                      ]
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Stage progress bar
                      if (isActive)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.screenH),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: _stageProgress(elapsed),
                              minHeight: 4,
                              backgroundColor:
                                  stageColor.withValues(alpha: 0.15),
                              valueColor:
                                  AlwaysStoppedAnimation(stageColor),
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
            initialChildSize: 0.52,
            minChildSize: 0.52,
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

                  // ── Active festival banner ────────────────────
                  if (activeFestivals.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColorsDark.accent.withValues(alpha: 0.1),
                        borderRadius:
                            BorderRadius.circular(AppRadius.sm),
                        border: Border.all(
                            color: AppColorsDark.accent
                                .withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        children: [
                          const Text('🪔',
                              style: TextStyle(fontSize: 16)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${activeFestivals.first.name} fast active',
                              style: AppTypography.bodySm(
                                  color: AppColorsDark.accent),
                            ),
                          ),
                          Icon(Icons.chevron_right_rounded,
                              color: AppColorsDark.accent, size: 18),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // ── Fasting type chips (when not active) ──────
                  if (!isActive) ...[
                    Text('Fasting Type',
                        style: AppTypography.h4(color: text0)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(_fastingTypes.length, (i) {
                        final active = i == _selectedTypeIndex;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedTypeIndex = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 160),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: active
                                  ? AppColorsDark.primary
                                  : surface0,
                              borderRadius: BorderRadius.circular(
                                  AppRadius.full),
                              border: Border.all(
                                  color: active
                                      ? Colors.transparent
                                      : divider),
                            ),
                            child: Text(_fastingTypes[i],
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: active ? Colors.white : text2)),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // ── Stage timeline ────────────────────────────
                  Text('Stage Timeline',
                      style: AppTypography.h4(color: text0)),
                  const SizedBox(height: 10),
                  GlassCard(
                    borderRadius: AppRadius.md,
                    padding: const EdgeInsets.all(AppSpacing.cardH),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _stageTimeline.map((s) {
                          final reached = isActive &&
                              elapsed.inHours >= s.hours;
                          return Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Column(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: reached
                                        ? s.color.withValues(alpha: 0.2)
                                        : divider.withValues(alpha: 0.3),
                                    border: Border.all(
                                        color: reached
                                            ? s.color
                                            : divider),
                                  ),
                                  child: Icon(
                                    reached
                                        ? Icons.check_rounded
                                        : Icons.radio_button_unchecked,
                                    size: 16,
                                    color: reached ? s.color : text2,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(s.label,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: reached
                                            ? s.color
                                            : text2)),
                                Text('${s.hours}h',
                                    style: TextStyle(
                                        fontSize: 9, color: text2)),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Control buttons ───────────────────────────
                  _ControlButtons(
                    isActive: isActive,
                    onStart: () => ref
                        .read(fastingTimerProvider.notifier)
                        .startFast(),
                    onStop: () => ref
                        .read(fastingTimerProvider.notifier)
                        .stopFast(),
                    text0: text0,
                    text2: text2,
                    divider: divider,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 20),

                  // ── Last fast card ────────────────────────────
                  GlassCard(
                    borderRadius: AppRadius.md,
                    padding: const EdgeInsets.all(AppSpacing.cardH),
                    child: Row(
                      children: [
                        const Icon(Icons.history_rounded,
                            size: 16, color: AppColorsDark.textMuted),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Last Fast',
                                  style: AppTypography.labelMd(
                                      color: text0)),
                              Text('No previous fasts recorded',
                                  style: AppTypography.bodySm(
                                      color: text2)),
                            ],
                          ),
                        ),
                        TrendChip(value: 0, isHigherBetter: true),
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

// ── Control buttons ────────────────────────────────────────────────────────────

class _ControlButtons extends StatelessWidget {
  final bool isActive;
  final VoidCallback onStart, onStop;
  final Color text0, text2, divider;
  final bool isDark;
  const _ControlButtons({
    required this.isActive,
    required this.onStart,
    required this.onStop,
    required this.text0,
    required this.text2,
    required this.divider,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    if (!isActive) {
      return SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton.icon(
          onPressed: onStart,
          icon: const Icon(Icons.play_arrow_rounded,
              color: Colors.white, size: 20),
          label: const Text('Start Fast',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColorsDark.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md)),
          ),
        ),
      );
    }

    return GlassCard(
      borderRadius: AppRadius.md,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _GlassBtn(
            icon: Icons.stop_rounded,
            label: 'End Fast',
            color: AppColorsDark.error,
            onTap: onStop,
          ),
        ],
      ),
    );
  }
}

class _GlassBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _GlassBtn(
      {required this.icon,
      required this.label,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 26),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color)),
          ],
        ),
      );
}
