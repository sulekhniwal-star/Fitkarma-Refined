import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// Compatibility layer for files still using AppTextStyles.
/// New code should use [AppTypography] directly.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle h1(bool isDark) => AppTypography.h1(
    color: isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary,
  );
  static TextStyle h2(bool isDark) => AppTypography.h2(
    color: isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary,
  );
  static TextStyle h3(bool isDark) => AppTypography.h3(
    color: isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary,
  );
  static TextStyle h4(bool isDark) => AppTypography.h4(
    color: isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary,
  );

  static TextStyle bodyLarge(bool isDark) => AppTypography.bodyLg(
    color: isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary,
  );
  static TextStyle bodyMedium(bool isDark) => AppTypography.bodyMd(
    color: isDark ? AppColorsDark.textSecondary : AppColorsLight.textSecondary,
  );
  static TextStyle bodySmall(bool isDark) => AppTypography.bodySm(
    color: isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted,
  );

  static TextStyle labelLarge(bool isDark) => AppTypography.labelLg(
    color: isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary,
  );
  static TextStyle labelMedium(bool isDark) => AppTypography.labelMd(
    color: isDark ? AppColorsDark.textSecondary : AppColorsLight.textSecondary,
  );

  static TextStyle caption(bool isDark) => AppTypography.caption(
    color: isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted,
  );

  static TextStyle displayLarge(bool isDark) => AppTypography.displayLg(color: isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary);
  static TextStyle statLarge(bool isDark) => AppTypography.metricLg(color: isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary);
  static TextStyle buttonLarge(bool isDark) => AppTypography.labelLg(color: isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary);
  static TextStyle sectionHeader(bool isDark) => AppTypography.labelLg(color: isDark ? AppColorsDark.textSecondary : AppColorsLight.textSecondary).copyWith(letterSpacing: 1.5, fontWeight: FontWeight.bold);

  static TextStyle sectionHeaderHindi(bool isDark) => AppTypography.hindi(
    color: isDark ? AppColorsDark.textSecondary : AppColorsLight.textSecondary,
  ).copyWith(fontSize: 14, fontWeight: FontWeight.w600);

  static TextStyle bodyHindi(bool isDark) => AppTypography.hindi(
    color: isDark ? AppColorsDark.textSecondary : AppColorsLight.textSecondary,
  );
}
