import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// Builds [ThemeData] for light and dark mode.
/// Import this in `app.dart` — never inline `ThemeData` elsewhere.
abstract final class AppTheme {
  AppTheme._();

  // ─── Component shapes ──────────────────────────────────────────────────────
  static const double _radius = 12.0;
  static const RoundedRectangleBorder _roundedRect =
      RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(_radius)),
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // LIGHT
  // ═══════════════════════════════════════════════════════════════════════════
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: AppColors.lightScheme,
        scaffoldBackgroundColor: AppColors.lightBackground,
        textTheme: AppTextStyles.textTheme.apply(
          bodyColor: AppColors.lightOnBackground,
          displayColor: AppColors.lightOnBackground,
        ),

        // AppBar
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 2,
          backgroundColor: AppColors.lightSurface,
          foregroundColor: AppColors.lightOnSurface,
          titleTextStyle: AppTextStyles.titleLarge,
        ),

        // Cards
        cardTheme: CardThemeData(
          elevation: 0,
          shape: _roundedRect,
          color: AppColors.lightSurface,
          shadowColor: AppColors.lightCardShadow,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        ),

        // Buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: _roundedRect,
            textStyle: AppTextStyles.button,
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.lightOnPrimary,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: _roundedRect,
            textStyle: AppTextStyles.button,
            side: const BorderSide(color: AppColors.primary),
            foregroundColor: AppColors.primary,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: AppTextStyles.button,
            foregroundColor: AppColors.primary,
          ),
        ),

        // FAB
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 2,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.lightOnPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),

        // Input
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.lightSurfaceVariant,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_radius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_radius),
            borderSide: const BorderSide(color: AppColors.lightOutline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_radius),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_radius),
            borderSide: const BorderSide(color: AppColors.error),
          ),
          labelStyle: AppTextStyles.bodyMedium,
          hintStyle: AppTextStyles.bodyMedium
              .copyWith(color: AppColors.lightOutline),
        ),

        // Chips
        chipTheme: ChipThemeData(
          shape: _roundedRect,
          backgroundColor: AppColors.lightSurfaceVariant,
          selectedColor: AppColors.primaryLight,
          labelStyle: AppTextStyles.labelMedium,
          side: BorderSide.none,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),

        // Bottom nav
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.lightSurface,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.lightOutline,
          selectedLabelStyle: AppTextStyles.labelSmall,
          unselectedLabelStyle: AppTextStyles.labelSmall,
          elevation: 8,
        ),

        // Dividers
        dividerTheme: const DividerThemeData(
          color: AppColors.lightOutlineVariant,
          thickness: 1,
          space: 1,
        ),

        // Snack bar
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: _roundedRect,
          backgroundColor: AppColors.lightOnBackground,
          contentTextStyle:
              AppTextStyles.bodyMedium.copyWith(color: Colors.white),
        ),
      );

  // ═══════════════════════════════════════════════════════════════════════════
  // DARK  (deep navy)
  // ═══════════════════════════════════════════════════════════════════════════
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: AppColors.darkScheme,
        scaffoldBackgroundColor: AppColors.darkBackground,
        textTheme: AppTextStyles.textTheme.apply(
          bodyColor: AppColors.darkOnBackground,
          displayColor: AppColors.darkOnBackground,
        ),

        // AppBar
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 2,
          backgroundColor: AppColors.darkSurface,
          foregroundColor: AppColors.darkOnSurface,
          titleTextStyle: AppTextStyles.titleLarge,
        ),

        // Cards
        cardTheme: CardThemeData(
          elevation: 0,
          shape: _roundedRect,
          color: AppColors.darkSurface,
          shadowColor: AppColors.darkCardShadow,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        ),

        // Buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: _roundedRect,
            textStyle: AppTextStyles.button,
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.darkOnPrimary,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: _roundedRect,
            textStyle: AppTextStyles.button,
            side: const BorderSide(color: AppColors.primary),
            foregroundColor: AppColors.primary,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: AppTextStyles.button,
            foregroundColor: AppColors.primary,
          ),
        ),

        // FAB
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 2,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.darkOnPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),

        // Input
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkSurfaceVariant,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_radius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_radius),
            borderSide: const BorderSide(color: AppColors.darkOutline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_radius),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_radius),
            borderSide: const BorderSide(color: AppColors.error),
          ),
          labelStyle: AppTextStyles.bodyMedium,
          hintStyle: AppTextStyles.bodyMedium
              .copyWith(color: AppColors.darkOutline),
        ),

        // Chips
        chipTheme: ChipThemeData(
          shape: _roundedRect,
          backgroundColor: AppColors.darkSurfaceVariant,
          selectedColor: AppColors.primaryDark,
          labelStyle: AppTextStyles.labelMedium,
          side: BorderSide.none,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),

        // Bottom nav
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.darkSurface,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.darkOutline,
          selectedLabelStyle: AppTextStyles.labelSmall,
          unselectedLabelStyle: AppTextStyles.labelSmall,
          elevation: 8,
        ),

        // Dividers
        dividerTheme: const DividerThemeData(
          color: AppColors.darkOutlineVariant,
          thickness: 1,
          space: 1,
        ),

        // Snack bar
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: _roundedRect,
          backgroundColor: AppColors.darkSurfaceVariant,
          contentTextStyle:
              AppTextStyles.bodyMedium.copyWith(color: AppColors.darkOnSurface),
        ),
      );
}
