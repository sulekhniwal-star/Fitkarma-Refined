import 'package:flutter/material.dart';

/// App color palette — both light and dark mode tokens.
/// Never hard-code colours in widgets; import from here.
abstract final class AppColors {
  AppColors._();

  // ─── Brand ─────────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF2ECC71); // FitKarma green
  static const Color primaryDark = Color(0xFF27AE60);
  static const Color primaryLight = Color(0xFFA9DFBF);
  static const Color secondary = Color(0xFF3498DB);
  static const Color accent = Color(0xFFF39C12);

  // ─── Semantic ──────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF27AE60);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE74C3C);
  static const Color info = Color(0xFF3498DB);

  // ─── Karma / gamification ──────────────────────────────────────────────────
  static const Color karmaGold = Color(0xFFFFD700);
  static const Color karmaBronze = Color(0xFFCD7F32);
  static const Color karmaSilver = Color(0xFFC0C0C0);

  // ─── Gradients ─────────────────────────────────────────────────────────────
  static const LinearGradient heroGradientLight = LinearGradient(
    colors: [Color(0xFF2ECC71), Color(0xFF3498DB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient heroGradientDark = LinearGradient(
    colors: [Color(0xFF0F3460), Color(0xFF16213E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // LIGHT MODE
  // ═══════════════════════════════════════════════════════════════════════════
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF1F3F5);
  static const Color lightOnBackground = Color(0xFF1A1A2E);
  static const Color lightOnSurface = Color(0xFF1A1A2E);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOutline = Color(0xFFDEE2E6);
  static const Color lightOutlineVariant = Color(0xFFE9ECEF);
  static const Color lightCardShadow = Color(0x1A000000);

  // ═══════════════════════════════════════════════════════════════════════════
  // DARK MODE  (deep navy)
  // ═══════════════════════════════════════════════════════════════════════════
  static const Color darkBackground = Color(0xFF0D1B2A);
  static const Color darkSurface = Color(0xFF1B2838);
  static const Color darkSurfaceVariant = Color(0xFF243447);
  static const Color darkOnBackground = Color(0xFFE9ECEF);
  static const Color darkOnSurface = Color(0xFFE9ECEF);
  static const Color darkOnPrimary = Color(0xFFFFFFFF);
  static const Color darkOutline = Color(0xFF2D3E50);
  static const Color darkOutlineVariant = Color(0xFF344955);
  static const Color darkCardShadow = Color(0x40000000);

  // ─── ColorScheme helpers ───────────────────────────────────────────────────

  static ColorScheme get lightScheme => ColorScheme.light(
        primary: primary,
        onPrimary: lightOnPrimary,
        primaryContainer: primaryLight,
        secondary: secondary,
        onSecondary: Colors.white,
        tertiary: accent,
        error: error,
        onError: Colors.white,
        surface: lightSurface,
        onSurface: lightOnSurface,
        surfaceContainerHighest: lightSurfaceVariant,
        outline: lightOutline,
        outlineVariant: lightOutlineVariant,
      );

  static ColorScheme get darkScheme => ColorScheme.dark(
        primary: primary,
        onPrimary: darkOnPrimary,
        primaryContainer: primaryDark,
        secondary: secondary,
        onSecondary: Colors.white,
        tertiary: accent,
        error: error,
        onError: Colors.white,
        surface: darkSurface,
        onSurface: darkOnSurface,
        surfaceContainerHighest: darkSurfaceVariant,
        outline: darkOutline,
        outlineVariant: darkOutlineVariant,
      );
}
