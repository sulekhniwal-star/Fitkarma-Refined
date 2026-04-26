import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_spacing.dart';

class AppTheme {
  AppTheme._();

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColorsDark.bg1,
      colorScheme: const ColorScheme.dark(
        primary:    AppColorsDark.primary,
        secondary:  AppColorsDark.secondary,
        surface:    AppColorsDark.surface0,
        error:      AppColorsDark.error,
        onPrimary:  Colors.white,
        onSecondary: Colors.white,
        onSurface:  AppColorsDark.textPrimary,
        onError:    Colors.white,
      ),
      textTheme: AppTypography.darkTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColorsDark.textSecondary),
        titleTextStyle: TextStyle(
          color: AppColorsDark.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: 'PlusJakartaSans',
          letterSpacing: -0.3,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColorsDark.divider,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorsDark.surface0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColorsDark.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColorsDark.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColorsDark.primary, width: 2),
        ),
        hintStyle: const TextStyle(color: AppColorsDark.textMuted),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorsDark.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColorsDark.surface1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.lg),
          ),
        ),
        elevation: 8,
      ),
    );
  }

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColorsLight.bg1,
      colorScheme: const ColorScheme.light(
        primary:    AppColorsLight.primary,
        secondary:  AppColorsLight.secondary,
        surface:    AppColorsLight.surface0,
        error:      Color(0xFFD32F2F),
        onPrimary:  Colors.white,
        onSecondary: Colors.white,
        onSurface:  AppColorsLight.textPrimary,
      ),
      textTheme: AppTypography.lightTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColorsLight.bg1,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColorsLight.textSecondary),
        titleTextStyle: TextStyle(
          color: AppColorsLight.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: 'PlusJakartaSans',
          letterSpacing: -0.3,
        ),
      ),
      dividerTheme: const DividerThemeData(color: AppColorsLight.divider, thickness: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorsLight.surface0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColorsLight.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColorsLight.primary, width: 2),
        ),
        hintStyle: const TextStyle(color: AppColorsLight.textMuted),
      ),
    );
  }
}
