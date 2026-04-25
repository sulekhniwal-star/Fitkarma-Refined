import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class EventDayCard extends StatelessWidget {
  final String title;
  final String titleHi;
  final String energyDemand; // Low/Medium/High
  final String preMealSummary;
  final String postMealSummary;
  final VoidCallback onTap;

  const EventDayCard({
    super.key,
    required this.title,
    required this.titleHi,
    required this.energyDemand,
    required this.preMealSummary,
    required this.postMealSummary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color energyColor;
    switch (energyDemand.toLowerCase()) {
      case 'high':
        energyColor = isDark ? AppColorsDark.error : AppColorsLight.error;
        break;
      case 'medium':
        energyColor = isDark ? AppColorsDark.warning : AppColorsLight.warning;
        break;
      case 'low':
      default:
        energyColor = isDark ? AppColorsDark.success : AppColorsLight.success;
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: (isDark ? AppTypography.h3() : AppTypography.h3(color: AppColorsLight.textPrimary))),
                      Text(titleHi, style: AppTypography.hindi(color: isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: energyColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: energyColor.withValues(alpha: 0.5)),
                  ),
                  child: Text(
                    '$energyDemand Energy',
                    style: TextStyle(
                      color: energyColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _MealRow(
              label: 'Pre-Event:',
              content: preMealSummary,
              isDark: isDark,
              icon: Icons.fastfood_outlined,
            ),
            const SizedBox(height: 8),
            _MealRow(
              label: 'Post-Event:',
              content: postMealSummary,
              isDark: isDark,
              icon: Icons.vaping_rooms_outlined, // recovery icon
            ),
          ],
        ),
      ),
    );
  }
}

class _MealRow extends StatelessWidget {
  final String label;
  final String content;
  final bool isDark;
  final IconData icon;

  const _MealRow({
    required this.label,
    required this.content,
    required this.isDark,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$label ',
                  style: (isDark ? AppTypography.labelMd() : AppTypography.labelMd(color: AppColorsLight.textPrimary)).copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: content,
                  style: (isDark ? AppTypography.bodySm() : AppTypography.bodySm(color: AppColorsLight.textMuted)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

