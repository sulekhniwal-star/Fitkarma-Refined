import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/festival/presentation/festival_providers.dart';
import 'package:fitkarma/features/festival/data/festival_repository.dart';
import 'package:fitkarma/features/festival/domain/festival_date_engine.dart';
import 'package:fitkarma/features/festival/domain/festival_diet_plan.dart';
import 'package:fitkarma/core/storage/drift_service.dart';

import 'package:fitkarma/features/auth/domain/auth_providers.dart';
import 'package:fitkarma/features/onboarding/domain/onboarding_providers.dart';
import 'package:fitkarma/features/dashboard/domain/dashboard_providers.dart';
import 'package:fitkarma/features/abha/data/abha_repository.dart';
import 'package:fitkarma/core/config/app_theme.dart';
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
import 'package:fitkarma/shared/widgets/glass_card.dart';
import 'package:fitkarma/shared/widgets/bento_card.dart';
import 'package:fitkarma/shared/widgets/glowing_metric.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger festival sync on startup
    Future.microtask(() async {
      final db = DriftService.db;
      final engine = FestivalDateEngine();
      final repo = FestivalRepository(db: db, engine: engine);
      await repo.syncAll();
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
    final karmaValue = ref.watch(karmaProvider);
    final currentFest = ref.watch(currentFestivalProvider).value;

    return FitScaffold(
      pattern: ScaffoldPattern.immersiveHero,
      title: 'Dashboard',
      heroHeight: 340,
      heroBackground: currentFest != null
          ? Container(
              decoration: const BoxDecoration(gradient: AppTheme.heroFestival),
            )
          : null,
      heroContent: AsyncValueWidget<KarmaData>(
        value: karmaValue,
        loading: const Center(
          child: CircularProgressIndicator(color: Colors.white24),
        ),
        data: (karma) => _buildHeroContent(context, karma),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Welcome & Stats Header
          _buildUserHeader(context, user),
          const SizedBox(height: 32),

          // 2. Seasonal Wellness (Ritucharya)
          const RitucharyaCard(),
          const SizedBox(height: 24),

          // 3. Promo Banner (Festival or Wedding)
          _buildContextualBanner(ref, currentFest),
          const SizedBox(height: 24),

          // 4. Activity Bento Box
          _buildActivityBento(ref),
          const SizedBox(height: 32),

          // 5. AI Insights
          _buildInsightSection(ref),
          const SizedBox(height: 32),

          // 6. Food & Nutrition
          _buildMealSection(ref),

          const SizedBox(height: 100), // Padding for BottomNav + FAB
        ],
      ),
    );
  }

  Widget _buildHeroContent(BuildContext context, KarmaData karma) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 60),
        // Karma Metric with Glow (§8)
        GlowingMetric(
          value: karma.level.toString(),
          unit: 'LEVEL',
          color: AppTheme.accent,
        ),
        const SizedBox(height: 12),
        Text(
          karma.title.toUpperCase(),
          style: AppTheme.caption(context).copyWith(
            color: AppTheme.accent.withValues(alpha: 0.8),
            letterSpacing: 4.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 40),
        // XP Progress - Slim, sleek version
        SizedBox(
          width: 200,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                child: LinearProgressIndicator(
                  value: karma.currentXP / karma.nextLevelXP,
                  backgroundColor: Colors.white.withValues(alpha: 0.05),
                  valueColor: const AlwaysStoppedAnimation(AppTheme.primary),
                  minHeight: 4,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${karma.currentXP} / ${karma.nextLevelXP} XP'.toUpperCase(),
                style: AppTheme.monoSm(context).copyWith(color: Colors.white38),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserHeader(BuildContext context, dynamic user) {
    return Row(
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [AppTheme.primary, AppTheme.accent],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              user?.name.characters.first ?? 'U',
              style: AppTheme.h3(context).copyWith(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BilingualLabel(
                english: 'Namaste, ${user?.name.split(' ').first ?? 'Friend'}',
                hindi: 'नमस्ते, ${user?.name.split(' ').first ?? 'मित्र'}',
              ),
              _buildAbhaBadge(ref),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildActivityBento(WidgetRef ref) {
    final steps = ref.watch(todayStepsProvider).value ?? 0;
    final calories = ref.watch(todayCaloriesProvider).value ?? 0;
    final water = ref.watch(todayWaterProvider).value ?? 0;
    final minutes = ref.watch(todayActiveMinutesProvider).value ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BilingualLabel(english: 'Daily Activity', hindi: 'दैनिक गतिविधि'),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: BentoCard(
                size: BentoSize.twoThird,
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: ActivityRingsWidget(
                  strokeWidth: 12,
                  gap: 12,
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
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  _buildStatMiniCard(
                    Icons.water_drop_outlined,
                    water.toString(),
                    'Cups',
                    AppTheme.teal,
                  ),
                  const SizedBox(height: 12),
                  _buildStatMiniCard(
                    Icons.timer_outlined,
                    minutes.toString(),
                    'Min',
                    AppTheme.purple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatMiniCard(
    IconData icon,
    String value,
    String unit,
    Color color,
  ) {
    return BentoCard(
      size: BentoSize.quarter,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTheme.labelLg(
              context,
            ).copyWith(color: AppTheme.textPrimary),
          ),
          Text(
            unit,
            style: AppTheme.caption(
              context,
            ).copyWith(color: AppTheme.textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildAbhaBadge(WidgetRef ref) {
    final abhaId = ref.watch(abhaStatusProvider);
    return ABHALinkBadge(isLinked: abhaId != null);
  }

  Widget _buildContextualBanner(
    WidgetRef ref,
    FestivalCalendarEntry? festival,
  ) {
    if (festival != null) {
      final now = DateTime.now();
      final daysRemaining = festival.startDate.difference(now).inDays;

      return FestivalCountdownBanner(
        festivalName: festival.nameEn,
        festivalNameHi: festival.nameHi,
        daysRemaining: daysRemaining < 0 ? 0 : daysRemaining,
        fastingType: festival.fastingType ?? 'Normal',
        bannerColor: AppTheme.primary,
        onViewDietPlan: () {},
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
            onViewPlan: () {},
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
    final festival = ref.watch(currentFestivalProvider).value;

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

            // Festival Diet Insight (§9)
            if (festival != null &&
                DateTime.now().isAfter(
                  festival.startDate.subtract(const Duration(days: 1)),
                ))
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: BentoCard(
                  size: BentoSize.fullWidth,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.auto_awesome, color: AppTheme.accent),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          festival.insightMessage,
                          style: AppTheme.labelMd(
                            context,
                          ).copyWith(color: AppTheme.textPrimary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

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
              onPressed: () {},
              child: Text(
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
        FoodItemCard(
          name: 'Classic Masala Dosa',
          nameHi: 'मसाला डोसा',
          portionInfo: '1 plate · 340 kcal',
          emoji: '🍳',
          onAdd: () {},
        ),
        const SizedBox(height: 12),
        FoodItemCard(
          name: 'Greek Yogurt with Berries',
          portionInfo: '1 bowl · 185 kcal',
          emoji: '🥣',
          onAdd: () {},
        ),
      ],
    );
  }
}
