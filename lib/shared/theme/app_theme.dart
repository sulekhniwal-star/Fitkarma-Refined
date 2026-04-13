import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    const isDark = false;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge(isDark),
        displayMedium: AppTextStyles.displayMedium(isDark),
        headlineLarge: AppTextStyles.h1(isDark),
        headlineMedium: AppTextStyles.h2(isDark),
        headlineSmall: AppTextStyles.h3(isDark),
        titleLarge: AppTextStyles.h4(isDark),
        titleMedium: AppTextStyles.sectionHeader(isDark),
        bodyLarge: AppTextStyles.bodyLarge(isDark),
        bodyMedium: AppTextStyles.bodyMedium(isDark),
        bodySmall: AppTextStyles.bodySmall(isDark),
        labelLarge: AppTextStyles.labelLarge(isDark),
        labelMedium: AppTextStyles.labelMedium(isDark),
        labelSmall: AppTextStyles.caption(isDark),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.background,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        centerTitle: false,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: AppColors.surface,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.buttonLarge(isDark),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.buttonLarge(isDark),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        disabledColor: AppColors.surfaceVariant,
        selectedColor: AppColors.primarySurface,
        secondarySelectedColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        labelStyle: AppTextStyles.labelMedium(isDark),
        secondaryLabelStyle: AppTextStyles.labelMedium(
          isDark,
        ).copyWith(color: AppColors.primary),
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.divider),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    const isDark = true;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColorsDark.primary,
      scaffoldBackgroundColor: AppColorsDark.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColorsDark.primary,
        secondary: AppColorsDark.secondary,
        surface: AppColorsDark.surface,
        error: AppColorsDark.error,
        onPrimary: AppColorsDark.surface,
        onSecondary: Colors.white,
        onSurface: AppColorsDark.textPrimary,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge(isDark),
        displayMedium: AppTextStyles.displayMedium(isDark),
        headlineLarge: AppTextStyles.h1(isDark),
        headlineMedium: AppTextStyles.h2(isDark),
        headlineSmall: AppTextStyles.h3(isDark),
        titleLarge: AppTextStyles.h4(isDark),
        titleMedium: AppTextStyles.sectionHeader(isDark),
        bodyLarge: AppTextStyles.bodyLarge(isDark),
        bodyMedium: AppTextStyles.bodyMedium(isDark),
        bodySmall: AppTextStyles.bodySmall(isDark),
        labelLarge: AppTextStyles.labelLarge(isDark),
        labelMedium: AppTextStyles.labelMedium(isDark),
        labelSmall: AppTextStyles.caption(isDark),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColorsDark.background,
        iconTheme: IconThemeData(color: AppColorsDark.textPrimary),
        centerTitle: false,
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColorsDark.divider),
        ),
        color: AppColorsDark.surface,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorsDark.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColorsDark.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColorsDark.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColorsDark.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorsDark.primary,
          foregroundColor: AppColorsDark.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.buttonLarge(isDark),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColorsDark.primary,
          side: const BorderSide(color: AppColorsDark.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.buttonLarge(isDark),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColorsDark.surface,
        selectedItemColor: AppColorsDark.primary,
        unselectedItemColor: AppColorsDark.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColorsDark.surface,
        disabledColor: AppColorsDark.surfaceVariant,
        selectedColor: AppColorsDark.primarySurface,
        secondarySelectedColor: AppColorsDark.primary,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        labelStyle: AppTextStyles.labelMedium(isDark),
        secondaryLabelStyle: AppTextStyles.labelMedium(
          isDark,
        ).copyWith(color: AppColorsDark.primary),
        brightness: Brightness.dark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColorsDark.divider),
        ),
      ),
    );
  }
}
