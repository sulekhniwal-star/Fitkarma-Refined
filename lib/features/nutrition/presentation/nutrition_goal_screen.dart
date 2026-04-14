import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../shared/widgets/micronutrient_bar.dart';

class NutritionGoalScreen extends ConsumerWidget {
  const NutritionGoalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.background : AppColors.background,
      appBar: AppBar(title: const Text('Nutrition Goals')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Daily Micro-Targets', style: AppTextStyles.h2(isDark)),
            const SizedBox(height: 8),
            const Text('Based on ICMR RDA Guidelines for Indian Adults', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
            const SizedBox(height: 32),

            const MicronutrientBar(name: 'Iron', current: 12, goal: 21, unit: ' mg'),
            const SizedBox(height: 16),
            const MicronutrientBar(name: 'Vitamin B12', current: 1.1, goal: 2.2, unit: ' mcg'),
            const SizedBox(height: 16),
            const MicronutrientBar(name: 'Vitamin D', current: 200, goal: 600, unit: ' IU'),
            const SizedBox(height: 16),
            const MicronutrientBar(name: 'Calcium', current: 450, goal: 1000, unit: ' mg'),

            const SizedBox(height: 48),
            _buildWeeklyDeficitReport(context, isDark),
            
            const SizedBox(height: 48),
            _buildWeightGoalCard(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyDeficitReport(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.analytics_outlined, color: Colors.red),
              const SizedBox(width: 12),
              Text('WEEKLY GAP REPORT', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 10)),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'High Deficit Identified: Vitamin D',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your Vitamin D intake has been < 60% of target for 5 consecutive days. Consider consuming mushrooms, fortified milk, or consult about supplements.',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('View Recommended Supplements', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightGoalCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('BASAL METABOLIC RATE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54)),
                  Text('1,640 kcal/day', style: AppTextStyles.h3(isDark)),
                ],
              ),
              const Icon(Icons.calculate_outlined, color: AppColors.primary),
            ],
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('MAINTENANCE (TDEE)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54)),
                  Text('2,450 kcal', style: AppTextStyles.h3(isDark).copyWith(color: AppColors.primary)),
                ],
              ),
              TextButton(onPressed: () {}, child: const Text('Recalculate')),
            ],
          ),
        ],
      ),
    );
  }
}
