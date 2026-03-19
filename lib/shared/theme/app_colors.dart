import 'package:flutter/material.dart';

class AppColors {
  // --- Light Mode Palette ---
  static const primary = Color(0xFFFF5722);
  static const primaryLight = Color(0xFFFF8A65);
  static const primarySurface = Color(0xFFFFF3EF);
  
  static const secondary = Color(0xFF3F3D8F);
  static const secondaryDark = Color(0xFF2C2A6B);
  static const secondarySurface = Color(0xFFE8E7F6);
  
  static const accent = Color(0xFFFFC107);
  static const accentLight = Color(0xFFFFECB3);
  static const accentDark = Color(0xFFFF8F00);
  
  static const background = Color(0xFFFDF6EC);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFF5F5F5);
  static const divider = Color(0xFFEEE8E4);
  
  static const success = Color(0xFF4CAF50);
  static const teal = Color(0xFF009688);
  static const purple = Color(0xFF9C27B0);
  static const warning = Color(0xFFFF9800);
  static const error = Color(0xFFF44336);
  static const rose = Color(0xFFE91E63);
  
  static const textPrimary = Color(0xFF1A1A2E);
  static const textSecondary = Color(0xFF6B6B8A);
  static const textMuted = Color(0xFFB0AECB);

  // --- Dark Mode Palette (Overrides as per Step 235 prompt) ---
  static const darkBackground = Color(0xFF1A1A2E);
  static const darkSurface = Color(0xFF24243E);
  static const darkSurfaceVariant = Color(0xFF2C2C3E);
  static const darkPrimarySurface = Color(0xFF3A1A10);
  static const darkAccentLight = Color(0xFF2A2000);
  
  // Additional Dark Mode Tokens from UI Doc (Section 2.2)
  static const darkDivider = Color(0xFF2C2C3E);
  static const darkPrimary = Color(0xFFFF7043);
  static const darkSecondary = Color(0xFF5C59C4);
  static const darkSecondaryDark = Color(0xFF3D3BA0);
  static const darkSecondarySurface = Color(0xFF1E1D3A);
  
  static const darkTextPrimary = Color(0xFFF0EEF8);
  static const darkTextSecondary = Color(0xFF9D9BBC);
  static const darkTextMuted = Color(0xFF4A4860);
  
  static const darkSuccess = Color(0xFF66BB6A);
  static const darkTeal = Color(0xFF26C6DA);
  static const darkPurple = Color(0xFFCE93D8);
  static const darkWarning = Color(0xFFFFA726);
  static const darkError = Color(0xFFEF5350);

  // --- Gradients ---
  static const heroGradientLightStart = secondary;
  static const heroGradientLightEnd = secondaryDark;
  
  // Hero gradient overrides as per Step 235
  static const heroGradientDarkStart = Color(0xFF1A1A2E); 
  static const heroGradientDarkEnd = Color(0xFF0D0D1A);
}
