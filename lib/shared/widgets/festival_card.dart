import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
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
                  color: (isDark ? AppColorsDark.primary : AppColorsLight.primary).withValues(alpha: 0.1),
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
                      style: (isDark ? AppTypography.h2() : AppTypography.h2(color: AppColorsLight.textPrimary)),
                    ),
                    Text(
                      '$titleHi · $dateRange',
                      style: (isDark ? AppTypography.bodySm() : AppTypography.bodySm(color: AppColorsLight.textMuted)),
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
                  color: (isDark ? AppColorsDark.secondary : AppColorsLight.secondary).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  region,
                  style: (isDark ? AppTypography.labelMd() : AppTypography.labelMd(color: AppColorsLight.textPrimary)).copyWith(
                    color: isDark ? AppColorsDark.secondary : AppColorsLight.secondary,
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
                    foregroundColor: isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary,
                    side: BorderSide(color: isDark ? AppColorsDark.divider : AppColorsLight.divider),
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
                    backgroundColor: isDark ? AppColorsDark.primary : AppColorsLight.primary,
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


