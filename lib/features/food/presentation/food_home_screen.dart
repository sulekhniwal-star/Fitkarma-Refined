import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/activity_rings.dart';
import '../../../shared/widgets/meal_tab_bar.dart';
import '../../../shared/widgets/micronutrient_bar.dart';
import '../../../shared/widgets/food_item_card.dart';
import '../../../shared/widgets/empty_state_widget.dart';
import '../../dashboard/domain/dashboard_providers.dart';

class FoodHomeScreen extends ConsumerWidget {
  const FoodHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedMeal = ref.watch(selectedMealTabProvider);

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.bg1 : AppColorsLight.bg1,
      appBar: AppBar(
        title: const Text('Nutrition Log'),
        actions: [
          IconButton(icon: const Icon(Icons.calendar_today_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMacroSummary(context, ref, isDark),
            const SizedBox(height: 24),
            _buildMicronutrientSection(context, ref, isDark),
            const SizedBox(height: 24),
            _buildCopyYesterdayBanner(context, ref, isDark),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Meal Logs', style: (isDark ? AppTypography.h2() : AppTypography.h2(color: AppColorsLight.textPrimary))),
                Text('Edit', style: TextStyle(color: isDark ? AppColorsDark.primary : AppColorsLight.primary)),
              ],
            ),
            MealTabBar(
              selected: selectedMeal,
              onChanged: (type) => ref.read(selectedMealTabProvider.notifier).state = type,
            ),
            const SizedBox(height: 16),
            _buildMealLogList(context, ref, selectedMeal, isDark),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroSummary(BuildContext context, WidgetRef ref, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface0 : AppColorsLight.surface0,
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
                Text('DAILY ENERGY', style: (isDark ? AppTypography.caption() : AppTypography.caption(color: AppColorsLight.textMuted))),
                Text('1,840 kcal', style: (isDark ? AppTypography.monoLg() : AppTypography.monoLg(color: AppColorsLight.textPrimary))),
                const SizedBox(height: 8),
                Text('640 kcal remaining', style: (isDark ? AppTypography.bodySm() : AppTypography.bodySm(color: AppColorsLight.textMuted))),
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
        Text('Micronutrients', style: (isDark ? AppTypography.h3() : AppTypography.h3(color: AppColorsLight.textPrimary))),
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
        color: isDark ? AppColorsDark.primaryMuted : AppColorsLight.primaryMuted,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: (isDark ? AppColorsDark.primary : AppColorsLight.primary).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.history_rounded, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Repeat Yesterday?', style: AppTypography.labelLg(color: isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary)),
                Text('Add all meals from yesterday in one tap.', style: AppTypography.caption(color: isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted)),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text('COPY ALL', style: TextStyle(color: isDark ? AppColorsDark.primary : AppColorsLight.primary)),
          ),
        ],
      ),
    );
  }

  Widget _buildMealLogList(BuildContext context, WidgetRef ref, MealType type, bool isDark) {
    if (type == MealType.dinner || type == MealType.snack) {
      return FitKarmaEmptyState(
        type: EmptyStateType.food,
        hindiTitle: 'कोई भोजन लॉग नहीं',
        subtitle: 'Log your ${type.name} to track your macros.',
        onAction: () {},
        actionLabel: 'LOG MEAL',
      );
    }

    String? asset;
    if (type == MealType.breakfast) asset = 'assets/images/food/South Indian.png';
    if (type == MealType.lunch) asset = 'assets/images/food/Healthy Thali.png';

    return Column(
      children: [
        FoodItemCard(
          name: type == MealType.lunch ? 'Healthy Thali / Meal' : 'Crispy Masala Dosa',
          nameHi: type == MealType.lunch ? 'स्वस्थ भोजन' : 'मसाला डोसा',
          portionInfo: type == MealType.lunch ? '1 plate · 420 kcal' : '1 plate · 340 kcal',
          assetPath: asset,
          emoji: type == MealType.lunch ? '🍱' : '🍳',
          onAdd: () {},
        ),
        if (type == MealType.breakfast)
          FoodItemCard(
            name: 'Poha with Sprouts',
            nameHi: 'पोहा और अंकुरित अनाज',
            portionInfo: '1 plate · 280 kcal',
            emoji: '🥣',
            onAdd: () {},
          ),
      ],
    );
  }
}

