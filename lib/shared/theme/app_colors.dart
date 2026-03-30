import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Brand ─────────────────────────────────────────────────────
  static const Color primary = Color(0xFF6C5CE7);
  static const Color primaryLight = Color(0xFF8B7CF6);
  static const Color primaryDark = Color(0xFF4A3DB5);
  static const Color secondary = Color(0xFF00CEC9);
  static const Color secondaryLight = Color(0xFF55EFC4);
  static const Color secondaryDark = Color(0xFF00A8A3);

  // ── Semantic ──────────────────────────────────────────────────
  static const Color success = Color(0xFF00B894);
  static const Color warning = Color(0xFFFDCB6E);
  static const Color error = Color(0xFFFF6B6B);
  static const Color info = Color(0xFF74B9FF);

  // ── Karma ─────────────────────────────────────────────────────
  static const Color karmaGold = Color(0xFFF9CA24);
  static const Color karmaSilver = Color(0xFFB2BEC3);
  static const Color karmaBronze = Color(0xFFE17055);

  // ═══════════════════════════════════════════════════════════════
  // Light Theme
  // ═══════════════════════════════════════════════════════════════

  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF1F3F5);
  static const Color lightOnBackground = Color(0xFF1A1A2E);
  static const Color lightOnSurface = Color(0xFF2D3436);
  static const Color lightOnSurfaceVariant = Color(0xFF636E72);
  static const Color lightOutline = Color(0xFFDFE6E9);
  static const Color lightOutlineVariant = Color(0xFFECF0F1);
  static const Color lightShadow = Color(0x1A000000);
  static const Color lightScrim = Color(0x80000000);

  // Light Gradients
  static const LinearGradient lightHeroGradient = LinearGradient(
    colors: [primary, primaryLight, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient lightCardGradient = LinearGradient(
    colors: [Color(0xFFF8F9FA), Color(0xFFFFFFFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ═══════════════════════════════════════════════════════════════
  // Dark Theme
  // ═══════════════════════════════════════════════════════════════

  static const Color darkBackground = Color(0xFF0D1117);
  static const Color darkSurface = Color(0xFF161B22);
  static const Color darkSurfaceVariant = Color(0xFF21262D);
  static const Color darkOnBackground = Color(0xFFE6EDF3);
  static const Color darkOnSurface = Color(0xFFC9D1D9);
  static const Color darkOnSurfaceVariant = Color(0xFF8B949E);
  static const Color darkOutline = Color(0xFF30363D);
  static const Color darkOutlineVariant = Color(0xFF21262D);
  static const Color darkShadow = Color(0x40000000);
  static const Color darkScrim = Color(0x80000000);

  // Dark Gradients — revised navy hero
  static const LinearGradient darkHeroGradient = LinearGradient(
    colors: [Color(0xFF1A1464), Color(0xFF2D1B69), Color(0xFF134E5E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    colors: [Color(0xFF161B22), Color(0xFF21262D)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ═══════════════════════════════════════════════════════════════
  // Health Card Colours (theme-independent tints)
  // ═══════════════════════════════════════════════════════════════

  static const Color stepsBlue = Color(0xFF0984E3);
  static const Color caloriesOrange = Color(0xFFE17055);
  static const Color sleepPurple = Color(0xFF6C5CE7);
  static const Color heartRed = Color(0xFFD63031);
  static const Color waterCyan = Color(0xFF00CEC9);
  static const Color moodYellow = Color(0xFFFDCB6E);
  static const Color weightGreen = Color(0xFF00B894);

  // ═══════════════════════════════════════════════════════════════
  // Meal Type Colours
  // ═══════════════════════════════════════════════════════════════

  static const Color breakfastYellow = Color(0xFFF9CA24);
  static const Color lunchGreen = Color(0xFF00B894);
  static const Color dinnerBlue = Color(0xFF0984E3);
  static const Color snackPurple = Color(0xFF6C5CE7);
}
