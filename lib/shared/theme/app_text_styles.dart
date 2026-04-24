import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // --- Plus Jakarta Sans Base ---
  static TextStyle _plusJakarta(double size, FontWeight weight, Color color) {
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }

  // --- JetBrains Mono Base ---
  static TextStyle _jetBrains(double size, FontWeight weight, Color color) {
    return GoogleFonts.jetBrainsMono(
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }

  // --- Display Styles ---
  static TextStyle displayLg(bool isDark) => _plusJakarta(
        56,
        FontWeight.w800,
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );

  static TextStyle displayMd(bool isDark) => _jetBrains(
        40,
        FontWeight.w700,
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );

  // --- Heading Styles ---
  static TextStyle h1(bool isDark) => _plusJakarta(
        28,
        FontWeight.w700,
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );

  static TextStyle h2(bool isDark) => _plusJakarta(
        22,
        FontWeight.w600,
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );

  static TextStyle h3(bool isDark) => _plusJakarta(
        17,
        FontWeight.w600,
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );

  static TextStyle h4(bool isDark) => _plusJakarta(
        14,
        FontWeight.w500,
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );

  // --- Body Styles ---
  static TextStyle body1(bool isDark) => _plusJakarta(
        15,
        FontWeight.w400,
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );

  static TextStyle body2(bool isDark) => _plusJakarta(
        13,
        FontWeight.w400,
        isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
      );

  // --- Utility Styles ---
  static TextStyle caption(bool isDark) => _plusJakarta(
        12,
        FontWeight.w400,
        isDark ? AppColorsDark.textMuted : AppColors.textMuted,
      );

  static TextStyle sectionHeaderHindi(bool isDark) => _plusJakarta(
        11,
        FontWeight.w400,
        isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
      );

  static TextStyle monoLg(bool isDark) => _jetBrains(
        24,
        FontWeight.w700,
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );

  static TextStyle monoSm(bool isDark) => _jetBrains(
        12,
        FontWeight.w400,
        isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
      );

  // --- Legacy Compatibility Aliases ---
  static TextStyle displayLarge(bool isDark) => h1(isDark);
  static TextStyle displayMedium(bool isDark) => h2(isDark);
  static TextStyle bodyLarge(bool isDark) => body1(isDark);
  static TextStyle bodyMedium(bool isDark) => body2(isDark);
  static TextStyle bodySmall(bool isDark) => caption(isDark);
  static TextStyle labelLarge(bool isDark) => h4(isDark);
  static TextStyle labelMedium(bool isDark) => body2(isDark);
  static TextStyle statLarge(bool isDark) => monoLg(isDark);
  static TextStyle statMedium(bool isDark) => monoSm(isDark);
  
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
}



