import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class ChallengeCard extends StatelessWidget {
  final String title;
  final String description;
  final double progress; // 0.0 - 1.0
  final int xpReward;
  final String? festivalTag;
  final Color baseColor;

  const ChallengeCard({
    super.key,
    required this.title,
    required this.description,
    required this.progress,
    required this.xpReward,
    this.festivalTag,
    this.baseColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      width: 280, // Optimized for horizontal carousel
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkSurface : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? AppColors.darkDivider : AppColors.divider,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (festivalTag != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accentLight.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.celebration_rounded, size: 12, color: AppColors.accentDark),
                      const SizedBox(width: 4),
                      Text(
                        festivalTag!,
                        style: AppTextStyles.labelMedium.copyWith(
                          fontSize: 10,
                          color: AppColors.accentDark,
                        ),
                      ),
                    ],
                  ),
                )
              else
                const Spacer(),
              
              Row(
                children: [
                  const Icon(Icons.bolt_rounded, size: 16, color: AppColors.accentDark),
                  const SizedBox(width: 2),
                  Text(
                    '+$xpReward XP',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.accentDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppTextStyles.h3.copyWith(height: 1.2),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: AppTextStyles.bodySmall.copyWith(fontSize: 12, color: AppColors.textSecondary),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: AppTextStyles.labelMedium.copyWith(fontSize: 11),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: AppTextStyles.labelMedium.copyWith(fontSize: 11, color: baseColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: baseColor.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(baseColor),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
