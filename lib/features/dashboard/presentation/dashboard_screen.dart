import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/features/festival/presentation/festival_providers.dart';

import 'package:fitkarma/features/auth/domain/auth_providers.dart';
import 'package:fitkarma/features/dashboard/domain/dashboard_providers.dart';
import 'package:fitkarma/features/abha/data/abha_repository.dart';
import 'package:fitkarma/core/theme/app_theme.dart';
import 'package:fitkarma/shared/widgets/fit_scaffold.dart';
import 'package:fitkarma/shared/widgets/activity_rings.dart';
import 'package:fitkarma/shared/widgets/async_value_widget.dart';
import 'package:fitkarma/shared/widgets/bilingual_label.dart';
import 'package:fitkarma/shared/widgets/correlation_insight_card.dart';
import 'package:fitkarma/shared/widgets/festival_countdown_banner.dart';
import 'package:fitkarma/shared/widgets/food_item_card.dart';
import 'package:fitkarma/shared/widgets/insight_card.dart';
import 'package:fitkarma/shared/widgets/meal_tab_bar.dart';
import 'package:fitkarma/shared/widgets/abha_link_badge.dart';
import 'package:fitkarma/shared/widgets/wedding_countdown_card.dart';
import 'package:fitkarma/shared/widgets/ritucharya_card.dart';
import 'package:fitkarma/shared/widgets/bento_card.dart';
import 'package:fitkarma/shared/widgets/quick_log_fab.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger initialization syncs
    Future.microtask(() async {
      await ref.read(festivalRepositoryProvider).syncAll();
      _triggerAbhaSync();
    });
  }

  void _triggerAbhaSync() async {
    final status = await ref.read(abhaStatusProvider.future);
    if (status != null) {
      final userId = ref.read(authStateProvider).value?.id;
      if (userId != null) {
        try {
          final count = await ref
              .read(abhaRepositoryProvider)
              .syncRecentRecords(userId);
          if (count > 0 && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Synced $count new records from ABHA 🏥'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        } catch (e) {
          debugPrint('ABHA Sync Error: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateProvider).value;
    final currentFest = ref.watch(activeFestivalProvider).value;

    return FitScaffold(
      pattern: ScaffoldPattern.immersiveHero,
      title: 'Dashboard',
      heroHeight: 320,
      heroBackground: currentFest != null
          ? Container(
              decoration: const BoxDecoration(gradient: AppTheme.heroFestival),
            )
          : null,
      heroContent: _buildHeroContent(context, user),
      floatingActionButton: QuickLogFAB(
        onActions: {
          QuickLogAction.food: () => context.push('/food/log'),
          QuickLogAction.water: () {},
          QuickLogAction.mood: () {},
          QuickLogAction.workout: () {},
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Activity Row
          _buildActivitySummary(ref),
          const SizedBox(height: 24),

          // Row 2: Secondary Metrics
          _buildSecondaryMetrics(ref),
          const SizedBox(height: 24),

          // Row 3: Seasonal Wellness
          const RitucharyaCard(),
          const SizedBox(height: 24),

          // Row 4: Contextual (Festival)
          _buildContextualBanner(ref, currentFest),
          const SizedBox(height: 24),

          // 5. AI Insights
          _buildInsightSection(ref),
          const SizedBox(height: 32),

          // 6. Food & Nutrition
          _buildMealSection(ref),

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildHeroContent(BuildContext context, dynamic user) {
    final steps = ref.watch(todayStepsProvider).value ?? 0;
    final calories = ref.watch(todayCaloriesProvider).value ?? 0;
    final water = ref.watch(todayWaterProvider).value ?? 0;
    final minutes = ref.watch(todayActiveMinutesProvider).value ?? 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 48),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              _buildAvatar(user),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BilingualLabel(
                    english: 'Namaste, ${user?.name.split(' ').first ?? 'Friend'}',
                    hindi: 'नमस्ते, ${user?.name.split(' ').first ?? 'मित्र'}',
                  ),
                  _buildAbhaBadge(ref),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        ActivityRingsWidget(
          showLabels: false,
          rings: [
            RingData(
              progress: (steps / 10000).clamp(0, 1),
              color: AppTheme.primary,
              value: steps.toString(),
              label: 'Steps',
              goal: '10k',
            ),
            RingData(
              progress: (calories / 2000).clamp(0, 1),
              color: AppTheme.accent,
              value: calories.toInt().toString(),
              label: 'Kcal',
              goal: '2k',
            ),
            RingData(
              progress: (water / 10).clamp(0, 1),
              color: AppTheme.teal,
              value: water.toString(),
              label: 'Water',
              goal: '10',
            ),
            RingData(
              progress: (minutes / 45).clamp(0, 1),
              color: AppTheme.purple,
              value: minutes.toString(),
              label: 'Minutes',
              goal: '45',
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildAvatar(dynamic user) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [AppTheme.primary, AppTheme.accent],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          user?.name.characters.first ?? 'U',
          style: AppTheme.h3(context).copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildActivitySummary(WidgetRef ref) {
    final steps = ref.watch(todayStepsProvider).value ?? 0;
    final calories = ref.watch(todayCaloriesProvider).value ?? 0;
    final karmaValue = ref.watch(karmaProvider).value;

    return BentoCard(
      size: BentoSize.full,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSimpleStat(Icons.directions_walk_rounded, steps.toString(), 'Steps', AppTheme.primary),
          _buildSimpleStat(Icons.local_fire_department_rounded, calories.toInt().toString(), 'Kcal', AppTheme.accent),
          _buildSimpleStat(Icons.emoji_events_rounded, '${karmaValue?.level ?? 1}', 'Level', AppTheme.warning),
        ],
      ),
    );
  }

  Widget _buildSimpleStat(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(value, style: AppTheme.h3(context)),
        Text(label, style: AppTheme.caption(context).copyWith(color: AppTheme.textMuted)),
      ],
    );
  }

  Widget _buildSecondaryMetrics(WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: BentoCard(
            size: BentoSize.half,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.directions_run_rounded, color: AppTheme.primary, size: 20),
                    Text('2h ago', style: AppTheme.caption(context).copyWith(color: AppTheme.textMuted)),
                  ],
                ),
                const SizedBox(height: 12),
                Text('Yoga Flow', style: AppTheme.h4(context)),
                Text('45 min · 320 kcal', style: AppTheme.bodySm(context).copyWith(color: AppTheme.textSecondary)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: BentoCard(
            size: BentoSize.half,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.bedtime_rounded, color: AppTheme.secondary, size: 20),
                    Text('Last Night', style: AppTheme.caption(context).copyWith(color: AppTheme.textMuted)),
                  ],
                ),
                const SizedBox(height: 12),
                Text('7h 20m', style: AppTheme.h4(context)),
                Text('92% Efficiency', style: AppTheme.bodySm(context).copyWith(color: AppTheme.textSecondary)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAbhaBadge(WidgetRef ref) {
    final status = ref.watch(abhaStatusProvider);
    return ABHALinkBadge(isLinked: status.value != null);
  }

  Widget _buildContextualBanner(
    WidgetRef ref,
    FestivalData? festival,
  ) {
    if (festival != null) {
      return FestivalCountdownBanner(
        festivalName: festival.name,
        festivalNameHi: festival.nameHi,
        daysRemaining: festival.daysRemaining,
        fastingType: festival.fastingType,
        bannerColor: AppTheme.primary,
        onViewDietPlan: () => context.push('/festival/${festival.name}/diet'),
      );
    }

    final wedding = ref.watch(activeWeddingProvider);
    return wedding.when(
      data: (wed) {
        if (wed != null) {
          return WeddingCountdownCard(
            role: wed.role,
            daysToWedding: wed.daysToWedding,
            nextEventName: wed.nextEventName,
            daysToNextEvent: wed.daysToNextEvent,
            onViewPlan: () => context.push('/wedding-planner'),
          );
        }
        return const SizedBox.shrink();
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }

  Widget _buildInsightSection(WidgetRef ref) {
    final insight = ref.watch(latestInsightProvider);

    return AsyncValueWidget<InsightOutput?>(
      value: insight,
      data: (output) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BilingualLabel(
              english: 'AI Insights',
              hindi: 'एआई अंतर्दृष्टि',
            ),
            const SizedBox(height: 16),

            if (output != null) ...[
              if (output.isCorrelation)
                CorrelationInsightCard(
                  message: output.message,
                  modules: const [],
                  onThumbsUp: () {},
                  onThumbsDown: () {},
                )
              else
                InsightCard(
                  message: output.message,
                  onThumbsUp: () {},
                  onThumbsDown: () {},
                  onDismiss: () {},
                ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildMealSection(WidgetRef ref) {
    final selectedTab = ref.watch(selectedMealTabProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BilingualLabel(english: "Today's Meals", hindi: "आज का खाना"),
            TextButton(
              onPressed: () => context.push('/food/log'),
              child: const Text(
                'Add Meal',
                style: TextStyle(color: AppTheme.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        MealTabBar(
          selected: selectedTab,
          onChanged: (type) =>
              ref.read(selectedMealTabProvider.notifier).setTab(type),
        ),
        const SizedBox(height: 16),
        // Food items should eventually come from todayCaloriesProvider's data
        FoodItemCard(
          name: 'Classic Masala Dosa',
          nameHi: 'मसाला डोसा',
          portionInfo: '1 plate · 340 kcal',
          emoji: '🍳',
          onAdd: () {},
        ),
      ],
    );
  }
}
