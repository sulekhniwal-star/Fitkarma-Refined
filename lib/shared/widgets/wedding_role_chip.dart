import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class WeddingRoleChip extends StatelessWidget {
  final String label;
  final String labelHi;
  final String emoji;
  final String? imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const WeddingRoleChip({
    super.key,
    required this.label,
    required this.labelHi,
    this.emoji = '',
    this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 120,
        height: 160,
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColorsDark.primaryMuted : AppColors.primaryMuted)
              : (isDark ? AppColorsDark.surface0 : AppColors.surface0),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? (isDark ? AppColorsDark.primary : AppColors.primary)
                : (isDark ? AppColorsDark.divider : AppColors.divider),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected && isDark
              ? [
                  BoxShadow(
                    color: AppColorsDark.primary.withOpacity(0.15),
                    blurRadius: 15,
                    spreadRadius: 1,
                  )
                ]
              : null,
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: imagePath != null
                      ? Image.asset(
                          imagePath!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : Center(
                          child: Text(
                            emoji,
                            style: const TextStyle(fontSize: 40),
                          ),
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
              child: Column(
                children: [
                  Text(
                    label,
                    style: AppTextStyles.labelLarge(isDark).copyWith(
                      color: isSelected ? (isDark ? AppColorsDark.primary : AppColors.primary) : null,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                  Text(
                    labelHi,
                    style: AppTextStyles.caption(isDark).copyWith(
                      color: isSelected ? (isDark ? AppColorsDark.primary : AppColors.primary) : (isDark ? AppColorsDark.textSecondary : AppColors.textSecondary),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

