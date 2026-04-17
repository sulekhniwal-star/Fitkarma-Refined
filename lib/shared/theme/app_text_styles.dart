import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle _base(double size, FontWeight weight, Color color) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }

  static TextStyle displayLarge(bool isDark) => _base(
        32,
        FontWeight.w700,
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );

  static TextStyle displayMedium(bool isDark) => _base(
        28,
        FontWeight.w700,
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );

  static TextStyle h1(bool isDark) => _base(
        24,
        FontWeight.w700,
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );

  static TextStyle h2(bool isDark) => _base(
        20,
        FontWeight.w700,
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );

  static TextStyle h3(bool isDark) => _base(
        18,
        FontWeight.w600,
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );

  static TextStyle h4(bool isDark) => _base(
        16,
        FontWeight.w600,
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );

  static TextStyle sectionHeader(bool isDark) => _base(
        14,
        FontWeight.w700,
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );

  static TextStyle sectionHeaderHindi(bool isDark) => _base(
        11,
        FontWeight.w500,
        isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
      );

  static TextStyle bodyLarge(bool isDark) => _base(
        16,
        FontWeight.w400,
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );

  static TextStyle bodyMedium(bool isDark) => _base(
        14,
        FontWeight.w400,
        isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
      );

  static TextStyle bodySmall(bool isDark) => _base(
        12,
        FontWeight.w400,
        isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
      );

  static TextStyle labelLarge(bool isDark) => _base(
        14,
        FontWeight.w600,
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );

  static TextStyle labelMedium(bool isDark) => _base(
        12,
        FontWeight.w600,
        isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
      );

  static TextStyle caption(bool isDark) => _base(
        10,
        FontWeight.w400,
        isDark ? AppColorsDark.textMuted : AppColors.textMuted,
      );

  static TextStyle statLarge(bool isDark) => _base(
        22,
        FontWeight.w700,
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );

  static TextStyle statMedium(bool isDark) => _base(
        18,
        FontWeight.w700,
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );

  static TextStyle buttonLarge(bool isDark) => _base(
        16,
        FontWeight.w700,
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );

  static const TextStyle h1OnDark = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle bodyOnDark = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
  );

  static const TextStyle captionOnDark = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: Colors.white54,
  );

  static TextStyle navLabelEn(bool isDark) => _base(
        10,
        FontWeight.w600,
        isDark ? AppColorsDark.textMuted : AppColors.textMuted,
      );

  static TextStyle navLabelHi(bool isDark) => _base(
        9,
        FontWeight.w400,
        isDark ? AppColorsDark.textMuted : AppColors.textMuted,
      );

  static TextStyle labelSmall(bool isDark) => _base(
        10,
        FontWeight.w600,
        isDark ? AppColorsDark.textMuted : AppColors.textMuted,
      );
}


