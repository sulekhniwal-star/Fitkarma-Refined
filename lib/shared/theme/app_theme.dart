import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  // ═══════════════════════════════════════════════════════════════
  // Light
  // ═══════════════════════════════════════════════════════════════

  static ThemeData get light {
    final colorScheme = ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primaryLight,
      onPrimaryContainer: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.secondaryLight,
      onSecondaryContainer: const Color(0xFF1A1A2E),
      tertiary: AppColors.warning,
      onTertiary: const Color(0xFF1A1A2E),
      error: AppColors.error,
      onError: Colors.white,
      errorContainer: const Color(0xFFFFE0E0),
      onErrorContainer: const Color(0xFF8B0000),
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightOnSurface,
      surfaceContainerHighest: AppColors.lightSurfaceVariant,
      onSurfaceVariant: AppColors.lightOnSurfaceVariant,
      outline: AppColors.lightOutline,
      outlineVariant: AppColors.lightOutlineVariant,
      shadow: AppColors.lightShadow,
      scrim: AppColors.lightScrim,
      inverseSurface: const Color(0xFF2D3436),
      onInverseSurface: Colors.white,
      inversePrimary: AppColors.primaryLight,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: AppColors.lightBackground,
      textTheme: _buildTextTheme(AppColors.lightOnBackground),
      appBarTheme: _buildAppBarTheme(
        colorScheme: colorScheme,
        foregroundColor: AppColors.lightOnBackground,
        backgroundColor: AppColors.lightSurface,
      ),
      cardTheme: _buildCardTheme(
        color: AppColors.lightSurface,
        shadowColor: AppColors.lightShadow,
      ),
      elevatedButtonTheme: _buildElevatedButtonTheme(colorScheme),
      outlinedButtonTheme: _buildOutlinedButtonTheme(colorScheme),
      filledButtonTheme: _buildFilledButtonTheme(colorScheme),
      inputDecorationTheme: _buildInputDecorationTheme(colorScheme, false),
      bottomNavigationBarTheme: _buildBottomNavTheme(
        colorScheme: colorScheme,
        backgroundColor: AppColors.lightSurface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.lightOnSurfaceVariant,
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.lightOutline,
        thickness: 1,
        space: 1,
      ),
      chipTheme: _buildChipTheme(colorScheme, false),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.lightSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titleTextStyle: AppTextStyles.headlineMedium.copyWith(
          color: AppColors.lightOnBackground,
        ),
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.lightOnSurface,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.lightSurface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.lightOnBackground,
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.lightBackground,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // Dark
  // ═══════════════════════════════════════════════════════════════

  static ThemeData get dark {
    final colorScheme = ColorScheme.dark(
      primary: AppColors.primaryLight,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primary,
      onPrimaryContainer: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: const Color(0xFF0D1117),
      secondaryContainer: AppColors.secondaryDark,
      onSecondaryContainer: Colors.white,
      tertiary: AppColors.warning,
      onTertiary: const Color(0xFF0D1117),
      error: AppColors.error,
      onError: Colors.white,
      errorContainer: const Color(0xFF5C1010),
      onErrorContainer: const Color(0xFFFFE0E0),
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkOnSurface,
      surfaceContainerHighest: AppColors.darkSurfaceVariant,
      onSurfaceVariant: AppColors.darkOnSurfaceVariant,
      outline: AppColors.darkOutline,
      outlineVariant: AppColors.darkOutlineVariant,
      shadow: AppColors.darkShadow,
      scrim: AppColors.darkScrim,
      inverseSurface: const Color(0xFFE6EDF3),
      onInverseSurface: const Color(0xFF0D1117),
      inversePrimary: AppColors.primary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: AppColors.darkBackground,
      textTheme: _buildTextTheme(AppColors.darkOnBackground),
      appBarTheme: _buildAppBarTheme(
        colorScheme: colorScheme,
        foregroundColor: AppColors.darkOnBackground,
        backgroundColor: AppColors.darkSurface,
      ),
      cardTheme: _buildCardTheme(
        color: AppColors.darkSurface,
        shadowColor: AppColors.darkShadow,
      ),
      elevatedButtonTheme: _buildElevatedButtonTheme(colorScheme),
      outlinedButtonTheme: _buildOutlinedButtonTheme(colorScheme),
      filledButtonTheme: _buildFilledButtonTheme(colorScheme),
      inputDecorationTheme: _buildInputDecorationTheme(colorScheme, true),
      bottomNavigationBarTheme: _buildBottomNavTheme(
        colorScheme: colorScheme,
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.darkOnSurfaceVariant,
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.darkOutline,
        thickness: 1,
        space: 1,
      ),
      chipTheme: _buildChipTheme(colorScheme, true),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.darkSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titleTextStyle: AppTextStyles.headlineMedium.copyWith(
          color: AppColors.darkOnBackground,
        ),
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.darkOnSurface,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.darkSurface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.darkSurfaceVariant,
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.darkOnSurface,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // Shared Builders
  // ═══════════════════════════════════════════════════════════════

  static TextTheme _buildTextTheme(Color baseColor) {
    return TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(color: baseColor),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: baseColor),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: baseColor),
      headlineLarge: AppTextStyles.headlineLarge.copyWith(color: baseColor),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: baseColor),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(color: baseColor),
      titleLarge: AppTextStyles.titleLarge.copyWith(color: baseColor),
      titleMedium: AppTextStyles.titleMedium.copyWith(color: baseColor),
      titleSmall: AppTextStyles.titleSmall.copyWith(color: baseColor),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: baseColor),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: baseColor),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: baseColor),
      labelLarge: AppTextStyles.labelLarge.copyWith(color: baseColor),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: baseColor),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: baseColor),
    );
  }

  static AppBarTheme _buildAppBarTheme({
    required ColorScheme colorScheme,
    required Color foregroundColor,
    required Color backgroundColor,
  }) {
    return AppBarTheme(
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      elevation: 0,
      scrolledUnderElevation: 2,
      centerTitle: true,
      titleTextStyle: AppTextStyles.titleLarge.copyWith(
        color: foregroundColor,
      ),
      iconTheme: IconThemeData(color: foregroundColor, size: 24),
      systemOverlayStyle: colorScheme.brightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
    );
  }

  static CardThemeData _buildCardTheme({
    required Color color,
    required Color shadowColor,
  }) {
    return CardThemeData(
      color: color,
      shadowColor: shadowColor,
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme(
    ColorScheme colorScheme,
  ) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: colorScheme.onPrimary,
        backgroundColor: colorScheme.primary,
        textStyle: AppTextStyles.buttonMedium,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme(
    ColorScheme colorScheme,
  ) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        textStyle: AppTextStyles.buttonMedium,
        side: BorderSide(color: colorScheme.outline),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static FilledButtonThemeData _buildFilledButtonTheme(
    ColorScheme colorScheme,
  ) {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        foregroundColor: colorScheme.onPrimary,
        backgroundColor: colorScheme.primary,
        textStyle: AppTextStyles.buttonMedium,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme(
    ColorScheme colorScheme,
    bool isDark,
  ) {
    return InputDecorationTheme(
      filled: true,
      fillColor: isDark
          ? AppColors.darkSurfaceVariant
          : AppColors.lightSurfaceVariant,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.error),
      ),
      labelStyle: AppTextStyles.bodyMedium.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
      ),
    );
  }

  static BottomNavigationBarThemeData _buildBottomNavTheme({
    required ColorScheme colorScheme,
    required Color backgroundColor,
    required Color selectedItemColor,
    required Color unselectedItemColor,
  }) {
    return BottomNavigationBarThemeData(
      backgroundColor: backgroundColor,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: AppTextStyles.labelSmall,
      unselectedLabelStyle: AppTextStyles.labelSmall,
    );
  }

  static ChipThemeData _buildChipTheme(
    ColorScheme colorScheme,
    bool isDark,
  ) {
    return ChipThemeData(
      backgroundColor: isDark
          ? AppColors.darkSurfaceVariant
          : AppColors.lightSurfaceVariant,
      selectedColor: colorScheme.primary.withValues(alpha: 0.2),
      labelStyle: AppTextStyles.labelMedium,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      side: BorderSide(color: colorScheme.outline),
    );
  }
}
