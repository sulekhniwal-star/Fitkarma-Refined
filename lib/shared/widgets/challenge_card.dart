import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class ChallengeCard extends StatelessWidget {
  final String title;
  final String description;
  final String icon;
  final int participants;
  final int daysLeft;
  final double progress;
  final VoidCallback? onTap;
  final bool isJoined;

  const ChallengeCard({
    super.key,
    required this.title,
    required this.description,
    this.icon = '🏆',
    required this.participants,
    required this.daysLeft,
    required this.progress,
    this.onTap,
    this.isJoined = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isJoined
                ? AppColors.primary.withValues(alpha: 0.5)
                : colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(icon, style: const TextStyle(fontSize: 24)),
                const Spacer(),
                if (isJoined)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Joined',
                      style: AppTextStyles.labelSmall
                          .copyWith(color: AppColors.success),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(title, style: AppTextStyles.titleSmall, maxLines: 1),
            const SizedBox(height: 4),
            Text(
              description,
              style: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress.clamp(0, 1),
                minHeight: 6,
                backgroundColor: colorScheme.outline.withValues(alpha: 0.2),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.people_outline, size: 14,
                    color: colorScheme.onSurfaceVariant),
                const SizedBox(width: 4),
                Text(
                  '$participants',
                  style: AppTextStyles.labelSmall
                      .copyWith(color: colorScheme.onSurfaceVariant),
                ),
                const Spacer(),
                Icon(Icons.timer_outlined, size: 14,
                    color: colorScheme.onSurfaceVariant),
                const SizedBox(width: 4),
                Text(
                  '${daysLeft}d left',
                  style: AppTextStyles.labelSmall
                      .copyWith(color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
