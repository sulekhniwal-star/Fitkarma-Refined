import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/user_experience_stage.dart';
import '../../../core/providers/ux_stage_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_gradients.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/activity_rings.dart';
import '../../../shared/widgets/ambient_widgets.dart';
import '../../../shared/widgets/badge_widgets.dart';
import '../../../shared/widgets/bilingual_label.dart';
import '../../../shared/widgets/food_widgets.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/karma_widgets.dart';
import '../../../shared/widgets/quick_log_fab.dart';
import '../../../shared/widgets/status_widgets.dart';
import '../../reports/providers/abha_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _mealTab = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final uxStage = ref.watch(uxStageProvider);
    final isFirstWeek = uxStage == UXStage.firstWeek;
    final abhaLinked = ref.watch(aBHANotifierProvider).value ?? false;

    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final primary = isDark ? AppColorsDark.primary : AppColorsLight.primary;
    final secondary = isDark ? AppColorsDark.secondary : AppColorsLight.secondary;
    final amber = isDark ? AppColorsDark.accent : AppColorsLight.accent;

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.bg0 : AppColorsLight.bg0,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // ── heroDeep gradient (320 px) ──────────────────────
          Container(
            height: 320,
            decoration: BoxDecoration(
              gradient: isDark ? AppGradients.heroDeep : AppGradients.heroDeepLight,
            ),
            child: const AmbientBlobs(),
          ),

          // ── Pattern B: DraggableScrollableSheet body ────────
          DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.65,
            maxChildSize: 1.0,
            builder: (_, controller) => Container(
              decoration: BoxDecoration(
                color: isDark ? AppColorsDark.surface1 : AppColorsLight.surface1,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(AppSpacing.screenH + 8)),
              ),
              child: CustomScrollView(
                controller: controller,
                slivers: [
                  // ── Hero section ──────────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.screenH, 24, AppSpacing.screenH, 8,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Avatar 48px with primary ring + glow
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDark ? AppColorsDark.surface0 : AppColorsLight.surface0,
                              border: Border.all(color: primary, width: 2),
                              boxShadow: isDark
                                  ? [BoxShadow(color: AppColorsDark.primaryGlow, blurRadius: 12)]
                                  : null,
                            ),
                            child: Icon(Icons.person, size: 24, color: text0),
                          ),
                          const SizedBox(width: 14),

                          // Greeting + pills
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BilingualLabel(
                                  english: 'Namaste',
                                  hindi: 'नमस्ते',
                                  showBorder: false,
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    _Pill(label: 'XP 1,250', color: amber),
                                    const SizedBox(width: 8),
                                    _Pill(label: 'Level 5', color: secondary),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // ABHA compact badge (only when not linked)
                          ABHALinkBadge(isLinked: abhaLinked, compact: true),
                        ],
                      ),
                    ),
                  ),

                  // ── Bento grid ────────────────────────────────
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenH,
                      vertical: AppSpacing.bentoGap,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // Row 1 — ActivityRingsWidget full width
                        GlassCard(
                          padding: const EdgeInsets.all(AppSpacing.cardH),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: ActivityRingsWidget(
                                  values: const [0.75, 0.60, 0.85, 0.70],
                                  colors: [
                                    AppColorsDark.success,
                                    AppColorsDark.accent,
                                    AppColorsDark.primary,
                                    AppColorsDark.secondary,
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _RingLegend(label: 'Steps', value: '7,500', color: AppColorsDark.success),
                                  _RingLegend(label: 'Calories', value: '420 kcal', color: AppColorsDark.accent),
                                  _RingLegend(label: 'Move', value: '42 min', color: AppColorsDark.primary),
                                  _RingLegend(label: 'Sleep', value: '7h 32m', color: AppColorsDark.secondary),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.bentoGap),

                        // Row 2 — Latest Workout + Sleep Recovery (half cards)
                        if (!isFirstWeek)
                          Row(
                            children: [
                              Expanded(
                                child: GlassCard(
                                  padding: const EdgeInsets.all(AppSpacing.cardH),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Latest Workout', style: AppTypography.bodySm(color: text2)),
                                      const SizedBox(height: 6),
                                      Text('Yoga Flow', style: AppTypography.h4(color: text0)),
                                      const SizedBox(height: 2),
                                      Text('45 min · 150 kcal', style: AppTypography.bodySm(color: text2)),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.bentoGap),
                              Expanded(
                                child: GlassCard(
                                  padding: const EdgeInsets.all(AppSpacing.cardH),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Sleep Recovery', style: AppTypography.bodySm(color: text2)),
                                      const SizedBox(height: 6),
                                      Text('7h 32m', style: AppTypography.h4(color: text0)),
                                      const SizedBox(height: 2),
                                      Text('Good Sleep', style: AppTypography.bodySm(color: AppColorsDark.success)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                        if (!isFirstWeek) const SizedBox(height: AppSpacing.bentoGap),

                        // Row 3 — InsightCard (max 1; CorrelationInsightCard for expert)
                        if (uxStage == UXStage.expert)
                          CorrelationInsightCard(
                            message: 'On days you sleep 7h+, your step count is 23% higher.',
                            icons: const [Icons.bedtime, Icons.directions_walk],
                          )
                        else
                          InsightCard(
                            message: 'You moved 12% more today than yesterday! Keep it up 🔥',
                          ),
                        const SizedBox(height: AppSpacing.bentoGap),

                        // Row 4+ — Today's Meals with MealTypeTabBar
                        GlassCard(
                          padding: const EdgeInsets.all(AppSpacing.cardH),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Today's Meals", style: AppTypography.h4(color: text0)),
                              const SizedBox(height: 8),
                              MealTypeTabBar(
                                types: const ['Breakfast', 'Lunch', 'Dinner', 'Snacks'],
                                selectedIndex: _mealTab,
                                onSelected: (i) => setState(() => _mealTab = i),
                              ),
                              const SizedBox(height: 8),
                              Text('No meals logged yet', style: AppTypography.bodySm(color: text2)),
                            ],
                          ),
                        ),

                        const SizedBox(height: AppSpacing.fabClearance),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: const QuickLogFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// ── Small helpers ──────────────────────────────────────────────────────────────

class _Pill extends StatelessWidget {
  final String label;
  final Color color;
  const _Pill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSpacing.screenH),
      ),
      child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
    );
  }
}

class _RingLegend extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _RingLegend({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text('$label  ', style: TextStyle(fontSize: 11, color: color)),
          Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
