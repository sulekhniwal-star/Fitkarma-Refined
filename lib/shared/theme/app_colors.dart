import 'package:flutter/material.dart';

abstract class AppColors {
  // --- Light Mode Tokens ---
  static const Color bg0 = Color(0xFFF7F0E8);
  static const Color bg1 = Color(0xFFFDF6EC);
  static const Color surface0 = Color(0xFFFFFFFF);
  
  static const Color primary = Color(0xFFF4511E);
  static const Color primaryMuted = Color(0xFFFEE8E2);
  static const Color accent = Color(0xFFF59E0B);
  static const Color secondary = Color(0xFF5B50D4);
  
  static const Color teal = Color(0xFF0D9488);
  static const Color success = Color(0xFF22C55E);
  
  static const Color textPrimary = Color(0xFF1A1830);
  static const Color textSecondary = Color(0xFF6B6A96);
  static const Color textMuted = Color(0xFF9B99CC);

  // Legacy/Shared
  static const Color divider = Color(0xFFEEE8E4);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color rose = Color(0xFFE91E63);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color accentDark = Color(0xFFFF8F00);

  // Wedding Planner gold
  static const Color weddingGoldStart = Color(0xFFD4A017);
  static const Color weddingGoldEnd = Color(0xFFB8860B);

  // Named gradients
  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF5B50D4), Color(0xFF3D3BA0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient orangeGradient = LinearGradient(
    colors: [Color(0xFFF4511E), Color(0xFFFF8A65)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient amberGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFFFD54F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient weddingGoldGradient = LinearGradient(
    colors: [Color(0xFFD4A017), Color(0xFFB8860B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

abstract class AppColorsDark {
  // --- Dark Mode Tokens ---
  static const Color bg0 = Color(0xFF080810);
  static const Color bg1 = Color(0xFF0F0F1A);
  static const Color bg2 = Color(0xFF161625);
  
  static const Color surface0 = Color(0xFF1C1C2E);
  static const Color surface1 = Color(0xFF22223A);
  static const Color surface2 = Color(0xFF2A2A45);
  
  static const Color primary = Color(0xFFFF6B35);
  static const Color accent = Color(0xFFFFB547);
  static const Color secondary = Color(0xFF7B6FF0);
  
  static const Color teal = Color(0xFF00D4B4);
  static const Color success = Color(0xFF4ADE80);
  static const Color warning = Color(0xFFFBBF24);
  static const Color error = Color(0xFFF87171);
  static const Color rose = Color(0xFFFB7185);
  static const Color purple = Color(0xFFC084FC);
  
  static const Color textPrimary = Color(0xFFF1F0FF);
  static const Color textSecondary = Color(0xFF9B99CC);
  static const Color textMuted = Color(0xFF6B68A0);

  // Legacy/Alias
  static const Color background = bg1;
  static const Color surface = surface0;
  static const Color divider = Color(0xFF2C2C3E);

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF0A0818), Color(0xFF1E1850)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}


