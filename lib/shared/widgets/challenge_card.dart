import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class ChallengeCarouselCard extends StatelessWidget {
  final String title;
  final String description;
  final double progress; // 0.0 to 1.0
  final int xpReward;
  final String? festivalTag;
  final VoidCallback onTap;

  const ChallengeCarouselCard({
    super.key,
    required this.title,
    required this.description,
    required this.progress,
    required this.xpReward,
    this.festivalTag,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColorsDark.surface0 : AppColorsLight.surface0,
          borderRadius: BorderRadius.circular(12),
          border: isDark ? Border.all(color: AppColorsDark.divider) : null,
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (festivalTag != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: (isDark ? AppColorsDark.primary : AppColorsLight.primary).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      festivalTag!,
                      style: TextStyle(
                        color: isDark ? AppColorsDark.primary : AppColorsLight.primary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: (isDark ? AppColorsDark.accent : AppColorsLight.accent).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '+$xpReward XP',
                    style: TextStyle(
                      color: isDark ? AppColorsDark.accent : AppColorsLight.accent,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: (isDark ? AppTypography.h4() : AppTypography.h4(color: AppColorsLight.textPrimary)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: (isDark ? AppTypography.bodySm() : AppTypography.bodySm(color: AppColorsLight.textMuted)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progress',
                  style: (isDark ? AppTypography.caption() : AppTypography.caption(color: AppColorsLight.textMuted)),
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: (isDark ? AppTypography.caption() : AppTypography.caption(color: AppColorsLight.textMuted)).copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: isDark ? AppColorsDark.bg2 : AppColorsLight.bg2,
                valueColor: AlwaysStoppedAnimation<Color>(isDark ? AppColorsDark.primary : AppColorsLight.primary),
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

