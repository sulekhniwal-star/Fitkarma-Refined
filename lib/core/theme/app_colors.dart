import 'package:flutter/material.dart';
import 'app_gradients.dart';

/// Dark mode color palette — primary design target
class AppColorsDark {
  AppColorsDark._();

  // Backgrounds
  static const bg0         = Color(0xFF080810); // deepest background
  static const bg1         = Color(0xFF0F0F1A); // primary scaffold
  static const bg2         = Color(0xFF161625); // secondary screen bg
  static const surface0    = Color(0xFF1C1C2E); // base card surface
  static const surface1    = Color(0xFF22223A); // elevated card / bottom sheets
  static const surface2    = Color(0xFF2A2A45); // tooltip / pop-over

  // Glass
  static const glass       = Color(0x0FFFFFFF); // rgba(255,255,255,0.06)
  static const glassBorder = Color(0x1AFFFFFF); // rgba(255,255,255,0.10)

  // Brand
  static const primary        = Color(0xFFFF6B35); // orange CTA
  static const primaryGlow    = Color(0x40FF6B35); // rgba(255,107,53,0.25)
  static const primaryMuted   = Color(0x30FF6B35); // chip selected bg

  // Accent
  static const accent         = Color(0xFFFFB547); // karma XP / streaks
  static const accentGlow     = Color(0x33FFB547); // rgba(255,181,71,0.20)

  // Secondary
  static const secondary      = Color(0xFF7B6FF0); // indigo — level badges
  static const secondaryGlow  = Color(0x407B6FF0);
  static const secondaryMuted = Color(0x307B6FF0);

  // Semantic
  static const teal           = Color(0xFF00D4B4); // water / SpO2 / medication
  static const tealGlow       = Color(0x3300D4B4);
  static const success        = Color(0xFF4ADE80); // steps / completed habits
  static const successGlow    = Color(0x334ADE80);
  static const warning        = Color(0xFFFBBF24); // elevated readings
  static const error          = Color(0xFFF87171); // crisis / destructive
  static const rose           = Color(0xFFFB7185); // period cycle
  static const purple         = Color(0xFFC084FC); // active minutes ring

  // Text
  static const textPrimary    = Color(0xFFF1F0FF);
  static const textSecondary  = Color(0xFF9B99CC);
  static const textMuted      = Color(0xFF6B68A0); // ≈4.6:1 — decorative only

  // Divider
  static const divider        = Color(0x14FFFFFF); // rgba(255,255,255,0.08)

  // Legacy Aliases
  static const background          = bg1;
  static const surface             = surface0;
  static const primarySurface      = surface1;
  static const accentMuted         = Color(0x30FFB547);
  static const weddingGoldStart    = Color(0xFFD4AF37);
  static const weddingGoldGradient = AppGradients.heroWedding;
  static const amberGradient       = AppGradients.heroPrimary;
  static const heroDeep            = AppGradients.heroDeep;
}

/// Light mode color palette
class AppColorsLight {
  AppColorsLight._();

  static const bg0            = Color(0xFFF7F0E8);
  static const bg1            = Color(0xFFFDF6EC);
  static const bg2            = Color(0xFFFFF9F2);
  static const surface0       = Color(0xFFFFFFFF);
  static const surface1       = Color(0xFFFFFAF5);
  static const surface2       = Color(0xFFFFF3EF);
  static const glass          = Color(0xB3FFFAF5); // rgba(255,250,245,0.70)
  static const glassBorder    = Color(0x26FF6B35); // rgba(255,107,53,0.15)

  static const primary        = Color(0xFFF4511E);
  static const primaryMuted   = Color(0xFFFEE8E2);
  static const accent         = Color(0xFFF59E0B);
  static const secondary      = Color(0xFF5B50D4);
  static const secondaryMuted = Color(0xFFE0DDF7);
  static const teal           = Color(0xFF0D9488);
  static const success        = Color(0xFF22C55E);

  static const textPrimary    = Color(0xFF1A1830);
  static const textSecondary  = Color(0xFF6B6A96);
  static const textMuted      = Color(0xFFB0AEC8);
  static const divider        = Color(0x121A1830);

  // Legacy Aliases
  static const background          = bg1;
  static const surface             = surface0;
  static const primarySurface      = surface1;
  static const accentMuted         = Color(0xFFFEF3C7);
  static const warning             = Color(0xFFFBBF24);
  static const error               = Color(0xFFF87171);
  static const weddingGoldStart    = Color(0xFFD4AF37);
  static const weddingGoldGradient = AppGradients.heroWedding;
  static const amberGradient       = AppGradients.heroPrimary;
  static const heroDeep            = AppGradients.heroDeepLight;
}

typedef AppColors = AppColorsDark;
