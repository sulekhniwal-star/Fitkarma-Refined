import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_spacing.dart';

import 'app_gradients.dart';

class AppTheme {
  AppTheme._();

  // ── Colors (Dark palette defaults) ─────────────────────────
  static const primary       = AppColorsDark.primary;
  static const primaryMuted  = AppColorsDark.primaryMuted;
  static const accent        = AppColorsDark.accent;
  static const secondary     = AppColorsDark.secondary;
  static const teal          = AppColorsDark.teal;
  static const success       = AppColorsDark.success;
  static const error         = AppColorsDark.error;
  static const warning       = AppColorsDark.warning;
  static const rose          = AppColorsDark.rose;
  static const purple        = AppColorsDark.purple;
  static const bg0           = AppColorsDark.bg0;
  static const bg1           = AppColorsDark.bg1;
  static const bg2           = AppColorsDark.bg2;
  static const surface0      = AppColorsDark.surface0;
  static const surface1      = AppColorsDark.surface1;
  static const surface2      = AppColorsDark.surface2;
  static const glass         = AppColorsDark.glass;
  static const glassBorder   = AppColorsDark.glassBorder;
  static const textPrimary   = AppColorsDark.textPrimary;
  static const textSecondary = AppColorsDark.textSecondary;
  static const textMuted     = AppColorsDark.textMuted;
  static const divider       = AppColorsDark.divider;

  // ── Gradients ──────────────────────────────────────────────
  static const heroPrimary   = AppGradients.heroPrimary;
  static const heroDeep      = AppGradients.heroDeep;
  static const heroDeepLight = AppGradients.heroDeepLight;
  static const heroSleep     = AppGradients.heroSleep;
  static const heroFestival  = AppGradients.heroFestival;
  static const heroWedding   = AppGradients.heroWedding;

  // ── Radius & Spacing ──────────────────────────────────────
  static const radiusSm   = AppRadius.sm;
  static const radiusMd   = AppRadius.md;
  static const radiusLg   = AppRadius.lg;
  static const radiusXl   = AppRadius.xl;
  static const radiusFull = AppRadius.full;

  static const screenPaddingH = AppSpacing.screenH;

  // ── Typography Facade ──────────────────────────────────────
  static TextStyle displayLg(BuildContext context) => AppTypography.displayLg();
  static TextStyle displayMd(BuildContext context) => AppTypography.displayMd();
  static TextStyle h1(BuildContext context)        => AppTypography.h1();
  static TextStyle h2(BuildContext context)        => AppTypography.h2();
  static TextStyle h3(BuildContext context)        => AppTypography.h3();
  static TextStyle h4(BuildContext context)        => AppTypography.h4();
  static TextStyle labelLg(BuildContext context)   => AppTypography.labelLg();
  static TextStyle labelMd(BuildContext context)   => AppTypography.labelMd();
  static TextStyle bodyLg(BuildContext context)    => AppTypography.bodyLg();
  static TextStyle bodyMd(BuildContext context)    => AppTypography.bodyMd();
  static TextStyle bodySm(BuildContext context)    => AppTypography.bodySm();
  static TextStyle caption(BuildContext context)   => AppTypography.caption();
  static TextStyle hindi(BuildContext context)     => AppTypography.hindi();
  static TextStyle heroDisplay(BuildContext context) => AppTypography.heroDisplay();
  static TextStyle metricXL(BuildContext context)    => AppTypography.metricXL();
  static TextStyle metricLg(BuildContext context)    => AppTypography.metricLg();
  static TextStyle monoXL(BuildContext context)      => AppTypography.monoXL();
  static TextStyle monoLg(BuildContext context)      => AppTypography.monoLg();
  static TextStyle monoMd(BuildContext context)      => AppTypography.monoMd();
  static TextStyle monoSm(BuildContext context)      => AppTypography.monoSm();

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
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
      useMaterial3: true,
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
