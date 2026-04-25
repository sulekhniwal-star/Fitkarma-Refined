import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/router/transitions.dart';

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

    return CardTapAnimation(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        width: 120,
        height: 160,
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColorsDark.primaryMuted : AppColorsLight.primaryMuted)
              : (isDark ? AppColorsDark.surface0 : AppColorsLight.surface0),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: isSelected
                ? (isDark ? AppColorsDark.primary : AppColorsLight.primary)
                : (isDark ? AppColorsDark.divider : AppColorsLight.divider),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected && isDark
              ? [
                  BoxShadow(
                    color: AppColorsDark.primary.withValues(alpha: 0.15),
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
                  borderRadius: BorderRadius.circular(AppRadius.sm),
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
                    style: (isDark ? AppTypography.labelLg() : AppTypography.labelLg(color: AppColorsLight.textPrimary)).copyWith(
                      color: isSelected ? (isDark ? AppColorsDark.primary : AppColorsLight.primary) : null,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                  Text(
                    labelHi,
                    style: AppTypography.hindi(
                      color: isSelected 
                          ? (isDark ? AppColorsDark.primary : AppColorsLight.primary) 
                          : (isDark ? AppColorsDark.textSecondary : AppColorsLight.textSecondary)
                    ).copyWith(fontSize: 11),
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
