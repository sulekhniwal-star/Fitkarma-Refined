import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class WeddingRoleChip extends StatelessWidget {
  final String label;
  final String labelHi;
  final String emoji;
  final bool isSelected;
  final VoidCallback onTap;

  const WeddingRoleChip({
    super.key,
    required this.label,
    required this.labelHi,
    required this.emoji,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 140,
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColorsDark.primarySurface : AppColors.primarySurface)
              : (isDark ? AppColorsDark.surface : Colors.white),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? (isDark ? AppColorsDark.primary : AppColors.primary)
                : (isDark ? AppColorsDark.divider : AppColors.divider),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTextStyles.labelLarge(isDark).copyWith(
                color: isSelected ? (isDark ? AppColorsDark.primary : AppColors.primary) : null,
              ),
            ),
            Text(
              labelHi,
              style: AppTextStyles.caption(isDark).copyWith(
                color: isSelected ? (isDark ? AppColorsDark.primary : AppColors.primary) : null,
              ),
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Icon(
                  Icons.check_circle,
                  color: isDark ? AppColorsDark.primary : AppColors.primary,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
