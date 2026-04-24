import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'festival_diet_badge.dart';
import 'glass_card.dart';

class FestivalCard extends StatelessWidget {
  final String title;
  final String titleHi;
  final String dateRange;
  final String fastingType;
  final String region;
  final String icon;
  final VoidCallback onSetReminder;
  final VoidCallback onViewDietPlan;

  const FestivalCard({
    super.key,
    required this.title,
    required this.titleHi,
    required this.dateRange,
    required this.fastingType,
    required this.region,
    required this.icon,
    required this.onSetReminder,
    required this.onViewDietPlan,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      padding: const EdgeInsets.all(16),
      onTap: onViewDietPlan,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: (isDark ? AppColorsDark.primary : AppColors.primary).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(icon, style: const TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.h2(isDark),
                    ),
                    Text(
                      '$titleHi · $dateRange',
                      style: AppTextStyles.bodySmall(isDark),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              FestivalDietBadge(fastingType: fastingType),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: (isDark ? AppColorsDark.secondary : AppColors.secondary).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  region,
                  style: AppTextStyles.labelMedium(isDark).copyWith(
                    color: isDark ? AppColorsDark.secondary : AppColors.secondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onSetReminder,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                    side: BorderSide(color: isDark ? AppColorsDark.divider : AppColors.divider),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Set Reminder'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: onViewDietPlan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? AppColorsDark.primary : AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('View Plan'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


