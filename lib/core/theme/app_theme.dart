import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_spacing.dart';

class AppTheme {
  AppTheme._();

  static ThemeData dark() {
    const c = AppColorsDark;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: c.bg1,
      colorScheme: const ColorScheme.dark(
        primary:    c.primary,
        secondary:  c.secondary,
        surface:    c.surface0,
        error:      c.error,
        onPrimary:  Colors.white,
        onSecondary: Colors.white,
        onSurface:  c.textPrimary,
        onError:    Colors.white,
      ),
      textTheme: AppTypography.darkTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: c.textSecondary),
        titleTextStyle: TextStyle(
          color: c.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: 'PlusJakartaSans',
          letterSpacing: -0.3,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: c.divider,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surface0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: c.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: c.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: c.primary, width: 2),
        ),
        hintStyle: const TextStyle(color: c.textMuted),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: c.primary,
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
        backgroundColor: c.surface1,
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
    const c = AppColorsLight;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: c.bg1,
      colorScheme: const ColorScheme.light(
        primary:    c.primary,
        secondary:  c.secondary,
        surface:    c.surface0,
        error:      Color(0xFFD32F2F),
        onPrimary:  Colors.white,
        onSecondary: Colors.white,
        onSurface:  c.textPrimary,
      ),
      textTheme: AppTypography.lightTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: c.bg1,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: c.textSecondary),
        titleTextStyle: TextStyle(
          color: c.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: 'PlusJakartaSans',
          letterSpacing: -0.3,
        ),
      ),
      dividerTheme: const DividerThemeData(color: c.divider, thickness: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surface0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: c.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: c.primary, width: 2),
        ),
        hintStyle: const TextStyle(color: c.textMuted),
      ),
    );
  }
}
