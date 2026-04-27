import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/ambient_widgets.dart';
import '../../../shared/widgets/food_widgets.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/quick_log_fab.dart';
import '../providers/food_provider.dart';

class FoodHomeScreen extends ConsumerStatefulWidget {
  const FoodHomeScreen({super.key});

  @override
  ConsumerState<FoodHomeScreen> createState() => _FoodHomeScreenState();
}

class _FoodHomeScreenState extends ConsumerState<FoodHomeScreen> {
  int _mealTab = 0;
  static const _mealTypes = ['Breakfast', 'Lunch', 'Dinner', 'Snacks'];
  static const _mealTypeKeys = ['breakfast', 'lunch', 'dinner', 'snack'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final primary = isDark ? AppColorsDark.primary : AppColorsLight.primary;
    final amber = isDark ? AppColorsDark.accent : AppColorsLight.accent;
    final bg1 = isDark ? AppColorsDark.bg1 : AppColorsLight.bg1;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final logsAsync = ref.watch(foodLogNotifierProvider(today));
    final totalCalories = ref.watch(todayCaloriesProvider);

    return Scaffold(
      backgroundColor: bg1,
      body: Stack(
        children: [
          const AmbientBlobs(),
          NestedScrollView(
            headerSliverBuilder: (_, __) => [
              // ── App bar ──────────────────────────────────────
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                pinned: true,
                title: Text('Nutrition', style: AppTypography.h1(color: text0)),
                actions: [
                  IconButton(
                    icon: Icon(Icons.qr_code_scanner_rounded, color: text2),
                    onPressed: () => context.push('/home/food/lab-scan'),
                  ),
                ],
              ),

              // ── Sticky MealTypeTabBar ─────────────────────────
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyTabDelegate(
                  child: ColoredBox(
                    color: bg1,
                    child: MealTypeTabBar(
                      types: _mealTypes,
                      selectedIndex: _mealTab,
                      onSelected: (i) => setState(() => _mealTab = i),
                    ),
                  ),
                ),
              ),
            ],
            body: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenH,
                    vertical: AppSpacing.bentoGap,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // ── Macro Summary card ──────────────────────
                      GlassCard(
                        padding: const EdgeInsets.all(AppSpacing.cardH),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Today's Macros", style: AppTypography.h4(color: text0)),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _MacroRing(
                                  label: 'Calories',
                                  value: totalCalories.toInt(),
                                  goal: 2000,
                                  unit: 'kcal',
                                  color: primary,
                                ),
                                _MacroRing(
                                  label: 'Protein',
                                  value: 45,
                                  goal: 120,
                                  unit: 'g',
                                  color: AppColorsDark.teal,
                                ),
                                _MacroRing(
                                  label: 'Carbs',
                                  value: 180,
                                  goal: 250,
                                  unit: 'g',
                                  color: amber,
                                ),
                                _MacroRing(
                                  label: 'Fat',
                                  value: 32,
                                  goal: 65,
                                  unit: 'g',
                                  color: AppColorsDark.secondary,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.bentoGap),

                      // ── Micronutrient bar row ───────────────────
                      GlassCard(
                        padding: const EdgeInsets.all(AppSpacing.cardH),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Micronutrients', style: AppTypography.h4(color: text0)),
                            const SizedBox(height: 12),
                            _MicroBar(label: 'Iron', value: 0.6, color: AppColorsDark.error, isDark: isDark),
                            const SizedBox(height: 8),
                            _MicroBar(label: 'B12', value: 0.4, color: AppColorsDark.secondary, isDark: isDark),
                            const SizedBox(height: 8),
                            _MicroBar(label: 'Vit D', value: 0.25, color: amber, isDark: isDark),
                            const SizedBox(height: 8),
                            _MicroBar(label: 'Calcium', value: 0.55, color: AppColorsDark.teal, isDark: isDark),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.bentoGap),

                      // ── Copy Yesterday banner (if today empty) ──
                      logsAsync.when(
                        data: (logs) {
                          final tabLogs = logs.where(
                            (l) => l.mealType == _mealTypeKeys[_mealTab],
                          ).toList();

                          if (tabLogs.isEmpty) {
                            return Column(
                              children: [
                                _CopyYesterdayBanner(amber: amber, text0: text0, text2: text2),
                                const SizedBox(height: AppSpacing.bentoGap),
                                _EmptyMealState(
                                  mealType: _mealTypes[_mealTab],
                                  mealKey: _mealTypeKeys[_mealTab],
                                  text2: text2,
                                  primary: primary,
                                ),
                              ],
                            );
                          }

                          return Column(
                            children: tabLogs.map((log) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: _LoggedMealRow(
                                log: log,
                                isDark: isDark,
                                text0: text0,
                                text2: text2,
                                onDelete: () => ref
                                    .read(foodLogNotifierProvider(today).notifier)
                                    .deleteFood(log.id),
                              ),
                            )).toList(),
                          );
                        },
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (e, _) => Text('Error: $e', style: AppTypography.bodySm()),
                      ),

                      const SizedBox(height: AppSpacing.fabClearance),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: const QuickLogFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// ── Macro Ring ─────────────────────────────────────────────────────────────────

class _MacroRing extends StatelessWidget {
  final String label;
  final int value;
  final int goal;
  final String unit;
  final Color color;

  const _MacroRing({
    required this.label,
    required this.value,
    required this.goal,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (value / goal).clamp(0.0, 1.0);
    return Column(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: progress,
                strokeWidth: 5,
                backgroundColor: color.withValues(alpha: 0.15),
                valueColor: AlwaysStoppedAnimation(color),
              ),
              Center(
                child: Text(
                  '$value',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        Text(unit, style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.7))),
      ],
    );
  }
}

// ── Micro Bar ──────────────────────────────────────────────────────────────────

class _MicroBar extends StatelessWidget {
  final String label;
  final double value; // 0.0–1.0
  final Color color;
  final bool isDark;

  const _MicroBar({
    required this.label,
    required this.value,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    return Row(
      children: [
        SizedBox(
          width: 52,
          child: Text(label, style: TextStyle(fontSize: 11, color: text2)),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 6,
              backgroundColor: color.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${(value * 100).toInt()}%',
          style: TextStyle(fontSize: 10, color: text2),
        ),
      ],
    );
  }
}

// ── Copy Yesterday Banner ──────────────────────────────────────────────────────

class _CopyYesterdayBanner extends StatelessWidget {
  final Color amber;
  final Color text0;
  final Color text2;

  const _CopyYesterdayBanner({
    required this.amber,
    required this.text0,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      glowColor: null,
      borderRadius: AppSpacing.cardH,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(Icons.copy_rounded, color: amber, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Copy yesterday\'s meals to save time',
              style: TextStyle(fontSize: 13, color: text0),
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: amber,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Copy', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

// ── Empty Meal State ───────────────────────────────────────────────────────────

class _EmptyMealState extends StatelessWidget {
  final String mealType;
  final String mealKey;
  final Color text2;
  final Color primary;

  const _EmptyMealState({
    required this.mealType,
    required this.mealKey,
    required this.text2,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.cardH),
      child: Row(
        children: [
          Icon(Icons.add_circle_outline_rounded, color: text2, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'No $mealType logged yet',
              style: TextStyle(fontSize: 13, color: text2),
            ),
          ),
          TextButton(
            onPressed: () => context.push('/home/food/log/$mealKey'),
            style: TextButton.styleFrom(
              foregroundColor: primary,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Add', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

// ── Logged Meal Row ────────────────────────────────────────────────────────────

class _LoggedMealRow extends StatelessWidget {
  final dynamic log;
  final bool isDark;
  final Color text0;
  final Color text2;
  final VoidCallback onDelete;

  const _LoggedMealRow({
    required this.log,
    required this.isDark,
    required this.text0,
    required this.text2,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(log.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColorsDark.error.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppSpacing.cardH),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: AppColorsDark.error),
      ),
      onDismissed: (_) => onDelete(),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColorsDark.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.restaurant_rounded, size: 18, color: AppColorsDark.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(log.foodName, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: text0)),
                  if (log.foodNameLocal != null)
                    Text(log.foodNameLocal!, style: TextStyle(fontSize: 11, color: text2)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${log.calories.toInt()} kcal',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColorsDark.primary),
                ),
                if (log.portionQty != null && log.portionUnit != null)
                  Text(
                    '${log.portionQty} ${log.portionUnit}',
                    style: TextStyle(fontSize: 10, color: text2),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Sticky Tab Delegate ────────────────────────────────────────────────────────

class _StickyTabDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  const _StickyTabDelegate({required this.child});

  @override
  Widget build(_, __, ___) => child;

  @override
  double get maxExtent => 60;
  @override
  double get minExtent => 60;
  @override
  bool shouldRebuild(_) => true;
}
