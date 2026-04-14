import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xFFFF5722);
  static const Color primaryLight = Color(0xFFFF8A65);
  static const Color primarySurface = Color(0xFFFFF3EF);

  static const Color secondary = Color(0xFF3F3D8F);
  static const Color secondaryDark = Color(0xFF2C2A6B);
  static const Color secondarySurface = Color(0xFFE8E7F6);

  static const Color accent = Color(0xFFFFC107);
  static const Color accentLight = Color(0xFFFFECB3);
  static const Color accentDark = Color(0xFFFF8F00);

  static const Color background = Color(0xFFFDF6EC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);

  static const Color divider = Color(0xFFEEE8E4);
  static const Color success = Color(0xFF4CAF50);
  static const Color teal = Color(0xFF009688);
  static const Color purple = Color(0xFF9C27B0);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color rose = Color(0xFFE91E63);

  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B6B8A);
  static const Color textMuted = Color(0xFFB0AECB);

  // Wedding Planner gold
  static const Color weddingGoldStart = Color(0xFFD4A017);
  static const Color weddingGoldEnd = Color(0xFFB8860B);

  // Named gradients
  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF3F3D8F), Color(0xFF2C2A6B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient heroGradientDark = LinearGradient(
    colors: [Color(0xFF1A1035), Color(0xFF2C2A6B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient orangeGradient = LinearGradient(
    colors: [Color(0xFFFF5722), Color(0xFFFF8A65)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient amberGradient = LinearGradient(
    colors: [Color(0xFFFFC107), Color(0xFFFFD54F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient weddingGoldGradient = LinearGradient(
    colors: [Color(0xFFD4A017), Color(0xFFB8860B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient sleepGradient = LinearGradient(
    colors: [Color(0xFF1A1A3E), Color(0xFF2C2A6B), Color(0xFFFDF6EC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

abstract class AppColorsDark {
  static const Color background = Color(0xFF121218);
  static const Color surface = Color(0xFF1E1E2C);
  static const Color surfaceVariant = Color(0xFF252535);
  static const Color divider = Color(0xFF2C2C3E);

  static const Color primary = Color(0xFFFF7043);
  static const Color primarySurface = Color(0xFF2A1E1A);

  static const Color secondary = Color(0xFF5C59C4);
  static const Color secondaryDark = Color(0xFF3D3BA0);
  static const Color secondarySurface = Color(0xFF1E1D3A);

  static const Color accent = Color(0xFFFFD54F);
  static const Color accentLight = Color(0xFF2C2200);
  static const Color accentDark = Color(0xFFFFCA28);

  static const Color textPrimary = Color(0xFFF0EEF8);
  static const Color textSecondary = Color(0xFF9D9BBC);
  static const Color textMuted = Color(0xFF4A4860);

  static const Color success = Color(0xFF66BB6A);
  static const Color teal = Color(0xFF26C6DA);
  static const Color purple = Color(0xFFCE93D8);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFEF5350);
}
