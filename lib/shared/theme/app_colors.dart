import 'package:flutter/material.dart';

class AppColors {
  // Light Mode Tokens
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

  // Dark Mode Tokens
  static const backgroundDark = Color(0xFF121218);
  static const surfaceDark = Color(0xFF1E1E2C);
  static const surfaceVariantDark = Color(0xFF252535);
  static const dividerDark = Color(0xFF2C2C3E);
  
  static const primaryDark = Color(0xFFFF7043);
  static const primarySurfaceDark = Color(0xFF2A1E1A);
  
  static const secondaryDarkMod = Color(0xFF5C59C4);
  static const secondaryDarkDark = Color(0xFF3D3BA0);
  static const secondarySurfaceDark = Color(0xFF1E1D3A);
  
  static const accentDarkMod = Color(0xFFFFD54F);
  static const accentLightDark = Color(0xFF2C2200);
  static const accentDarkDark = Color(0xFFFFCA28);
  
  static const textPrimaryDark = Color(0xFFF0EEF8);
  static const textSecondaryDark = Color(0xFF9D9BBC);
  static const textMutedDark = Color(0xFF4A4860);
  
  static const successDark = Color(0xFF66BB6A);
  static const tealDark = Color(0xFF26C6DA);
  static const purpleDark = Color(0xFFCE93D8);
}

class AppGradients {
  static const heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.secondary, AppColors.secondaryDark],
  );

  static const heroGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A1035), AppColors.secondaryDark],
  );

  static const orangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primary, AppColors.primaryLight],
  );

  static const amberGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.accent, Color(0xFFFFD54F)],
  );
}
