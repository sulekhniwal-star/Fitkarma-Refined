import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/domain/auth_providers.dart';
import '../../../core/di/providers.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../shared/widgets/activity_rings.dart';
import '../../../shared/widgets/async_value_widget.dart';
import '../../../shared/widgets/bilingual_label.dart';
import '../../../shared/widgets/correlation_insight_card.dart';
import '../../../shared/widgets/festival_countdown_banner.dart';
import '../../../shared/widgets/food_item_card.dart';
import '../../../shared/widgets/insight_card.dart';
import '../../../shared/widgets/meal_tab_bar.dart';
import '../../../shared/widgets/quick_log_fab.dart';
import '../../../shared/widgets/wedding_countdown_card.dart';
import '../domain/dashboard_providers.dart';

/// The primary landing screen of the application.
/// 
/// Agreggates daily health metrics, AI insights, cultural events, 
/// and active transformation plans in a unified dashboard.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = ref.watch(authStateProvider).value;

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.background : AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(todayStepsProvider);
                ref.invalidate(todayCaloriesProvider);
                ref.invalidate(latestInsightProvider);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Header Row
                    _buildHeader(context, ref, user, isDark),
                    const SizedBox(height: 24),

                    // 2. Promo Banner (Festival or Wedding)
                    _buildPromoBanner(ref),
                    const SizedBox(height: 16),

                    // 3. Activity Rings
                    _buildActivityRings(ref),
                    const SizedBox(height: 24),

                    // 4. AI Insight Section
                    _buildInsightSection(ref),
                    const SizedBox(height: 24),

                    // 5. Meal Logging Segment
                    _buildMealSection(ref, isDark),
                    
                    const SizedBox(height: 80), // Space for FAB
                  ],
                ),
              ),
            ),

            // 7. Quick Log FAB
            Positioned(
              bottom: 16,
              right: 16,
              child: QuickLogFAB(
                onActions: {
                  QuickLogAction.food: () {},
                  QuickLogAction.water: () {},
                  QuickLogAction.mood: () {},
                  QuickLogAction.workout: () {},
                  QuickLogAction.bp: () {},
                  QuickLogAction.glucose: () {},
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref, dynamic user, bool isDark) {
    final karmaResult = ref.watch(karmaProvider);

    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.secondarySurface,
          child: Text(user?.name.characters.first ?? 'U'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: BilingualLabel(
            english: 'Namaste, ${user?.name.split(' ').first ?? 'Friend'}',
            hindi: 'नमस्ते, ${user?.name.split(' ').first ?? 'मित्र'}',
          ),
        ),
        AsyncValueWidget<KarmaData>(
          value: karmaResult,
          loading: const SizedBox.shrink(),
          data: (karma) => Row(
            children: [
              _buildChip(
                label: '${karma.currentXP} XP',
                color: AppColors.accent,
                textColor: Colors.black,
              ),
              const SizedBox(width: 8),
              _buildChip(
                label: 'Lvl ${karma.level}',
                color: Colors.indigo,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChip({required String label, required Color color, required Color textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPromoBanner(WidgetRef ref) {
    final festival = ref.watch(activeFestivalProvider);
    final wedding = ref.watch(activeWeddingProvider);

    return festival.when(
      data: (fest) {
        if (fest != null) {
          return FestivalCountdownBanner(
            festivalName: fest.name,
            festivalNameHi: fest.nameHi,
            daysRemaining: fest.daysRemaining,
            fastingType: fest.fastingType,
            bannerColor: AppColors.primary,
            onViewDietPlan: () {},
          );
        }
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
          error: (_, __) => const SizedBox.shrink(),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildActivityRings(WidgetRef ref) {
    final steps = ref.watch(todayStepsProvider).value ?? 0;
    final calories = ref.watch(todayCaloriesProvider).value ?? 0;
    final water = ref.watch(todayWaterProvider).value ?? 0;
    final minutes = ref.watch(todayActiveMinutesProvider).value ?? 0;

    return Center(
      child: ActivityRingsWidget(
        rings: [
          RingData(
            progress: (calories / 2000).clamp(0, 1),
            color: Colors.orange,
            label: 'Calories',
            value: calories.toInt().toString(),
            goal: '2000',
          ),
          RingData(
            progress: (steps / 10000).clamp(0, 1),
            color: Colors.green,
            label: 'Steps',
            value: steps.toString(),
            goal: '10k',
          ),
          RingData(
            progress: (water / 8).clamp(0, 1),
            color: Colors.teal,
            label: 'Water',
            value: water.toString(),
            goal: '8',
          ),
          RingData(
            progress: (minutes / 30).clamp(0, 1),
            color: Colors.purple,
            label: 'Active',
            value: minutes.toString(),
            goal: '30m',
          ),
        ],
      ),
    );
  }

  Widget _buildInsightSection(WidgetRef ref) {
    final insight = ref.watch(latestInsightProvider);

    return AsyncValueWidget<InsightOutput?>(
      value: insight,
      data: (output) {
        if (output == null) return const SizedBox.shrink();
        if (output.isCorrelation) {
          return CorrelationInsightCard(
            message: output.message,
            modules: const [], // TODO: Add actual module links
            onThumbsUp: () {},
            onThumbsDown: () {},
          );
        }
        return InsightCard(
          message: output.message,
          onThumbsUp: () {},
          onThumbsDown: () {},
          onDismiss: () {},
        );
      },
    );
  }

  Widget _buildMealSection(WidgetRef ref, bool isDark) {
    final selectedTab = ref.watch(selectedMealTabProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BilingualLabel(
              english: "Today's Meals",
              hindi: "आज का खाना",
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {},
              color: AppColors.primary,
            ),
          ],
        ),
        MealTabBar(
          selected: selectedTab,
          onChanged: (type) => ref.read(selectedMealTabProvider.notifier).state = type,
        ),
        const SizedBox(height: 16),
        // Placeholder for meal items
        FoodItemCard(
          name: 'Classic Masala Dosa',
          nameHi: 'मसाला डोसा',
          portionInfo: '1 plate · 340 kcal',
          emoji: '🍳',
          onAdd: () {},
        ),
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
