import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class ABHALinkBadge extends StatelessWidget {
  final bool isLinked;
  final bool isLarge;

  const ABHALinkBadge({
    super.key,
    required this.isLinked,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (isLarge) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isLinked 
              ? (isDark ? AppColorsDark.success : AppColorsLight.success).withValues(alpha: 0.1)
              : (isDark ? AppColorsDark.primary : AppColorsLight.primary).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color: isLinked 
                  ? (isDark ? AppColorsDark.success : AppColorsLight.success)
                  : (isDark ? AppColorsDark.primary : AppColorsLight.primary), 
              width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isLinked ? Icons.verified_user : Icons.health_and_safety,
              color: isLinked 
                  ? (isDark ? AppColorsDark.success : AppColorsLight.success)
                  : (isDark ? AppColorsDark.primary : AppColorsLight.primary),
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              isLinked ? 'ABHA LINKED' : 'ABHA NOT LINKED',
              style: AppTypography.labelLg(
                color: isLinked 
                    ? (isDark ? AppColorsDark.success : AppColorsLight.success)
                    : (isDark ? AppColorsDark.primary : AppColorsLight.primary),
              ).copyWith(
                fontSize: 16,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isLinked 
            ? (isDark ? AppColorsDark.success : AppColorsLight.success).withValues(alpha: 0.1) 
            : (isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isLinked 
                ? (isDark ? AppColorsDark.success : AppColorsLight.success) 
                : (isDark ? AppColorsDark.divider : AppColorsLight.divider)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isLinked ? Icons.check_circle : Icons.add_circle_outline,
            size: 14,
            color: isLinked 
                ? (isDark ? AppColorsDark.success : AppColorsLight.success) 
                : (isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted),
          ),
          const SizedBox(width: 4),
          Text(
            isLinked ? 'ABHA Linked' : 'Link ABHA',
            style: AppTypography.labelMd(
              color: isLinked 
                  ? (isDark ? AppColorsDark.success : AppColorsLight.success) 
                  : (isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted),
            ).copyWith(fontSize: 10),
          ),
        ],
      ),
    );
  }
}

