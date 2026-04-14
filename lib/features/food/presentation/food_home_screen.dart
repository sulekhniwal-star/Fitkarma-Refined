import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../shared/widgets/activity_rings.dart';
import '../../../shared/widgets/meal_tab_bar.dart';
import '../../../shared/widgets/micronutrient_bar.dart';
import '../../../shared/widgets/food_item_card.dart';
import '../../../shared/widgets/quick_log_fab.dart';
import '../../dashboard/domain/dashboard_providers.dart';

class FoodHomeScreen extends ConsumerWidget {
  const FoodHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedMeal = ref.watch(selectedMealTabProvider);

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.background : AppColors.background,
      appBar: AppBar(
        title: const Text('Nutrition Log'),
        actions: [
          IconButton(icon: const Icon(Icons.calendar_today_outlined), onPressed: () {}),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Macro Summary
                _buildMacroSummary(context, ref, isDark),
                const SizedBox(height: 24),

                // 2. Micronutrient Highlights
                _buildMicronutrientSection(context, ref, isDark),
                const SizedBox(height: 24),

                // 3. Copy Yesterday Action
                _buildCopyYesterdayBanner(context, ref, isDark),
                const SizedBox(height: 24),

                // 4. Meal Logs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Meal Logs', style: AppTextStyles.h2(isDark)),
                    const Text('Edit', style: TextStyle(color: AppColors.primary)),
                  ],
                ),
                MealTabBar(
                  selected: selectedMeal,
                  onChanged: (type) => ref.read(selectedMealTabProvider.notifier).state = type,
                ),
                const SizedBox(height: 16),
                _buildMealLogList(context, ref, selectedMeal, isDark),

                const SizedBox(height: 80), // FAB Space
              ],
            ),
          ),
          
          // Floating Action Button
          Positioned(
            bottom: 16,
            right: 16,
            child: QuickLogFAB(
              onActions: {
                QuickLogAction.food: () {},
                QuickLogAction.water: () {},
                // ...
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroSummary(BuildContext context, WidgetRef ref, bool isDark) {
    // Mock values for now
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 140,
            height: 140,
            child: ActivityRingsWidget(
              rings: [
                RingData(progress: 0.7, color: Colors.orange, label: 'Prot', value: '110', goal: '160'),
                RingData(progress: 0.5, color: Colors.green, label: 'Carb', value: '180', goal: '350'),
                RingData(progress: 0.8, color: Colors.pink, label: 'Fat', value: '55', goal: '70'),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DAILY ENERGY', style: AppTextStyles.caption(isDark)),
                Text('1,840 kcal', style: AppTextStyles.statLarge(isDark)),
                const SizedBox(height: 8),
                Text('640 kcal remaining', style: AppTextStyles.bodySmall(isDark)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMicronutrientSection(BuildContext context, WidgetRef ref, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Micronutrients', style: AppTextStyles.h3(isDark)),
        const SizedBox(height: 12),
        const MicronutrientBar(name: 'Vitamin D', current: 400, goal: 600, unit: ' IU'),
        const MicronutrientBar(name: 'Vitamin B12', current: 2.1, goal: 2.4, unit: ' mcg'),
        const MicronutrientBar(name: 'Iron', current: 8.5, goal: 18, unit: ' mg'),
      ],
    );
  }

  Widget _buildCopyYesterdayBanner(BuildContext context, WidgetRef ref, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.history_rounded, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Repeat Yesterday?', style: AppTextStyles.labelLarge(false)),
                Text('Add all meals from yesterday in one tap.', style: AppTextStyles.caption(false)),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('COPY ALL'),
          ),
        ],
      ),
    );
  }

  Widget _buildMealLogList(BuildContext context, WidgetRef ref, MealType type, bool isDark) {
    return Column(
      children: [
        FoodItemCard(
          name: 'Poha with Sprouts',
          nameHi: 'पोहा और अंकुरित अनाज',
          portionInfo: '1 plate · 280 kcal',
          emoji: '🥣',
          onAdd: () {},
        ),
        FoodItemCard(
          name: 'Chai (No Sugar)',
          nameHi: 'बिना चीनी की चाय',
          portionInfo: '1 cup · 45 kcal',
          emoji: '☕',
          onAdd: () {},
        ),
      ],
    );
  }
}
