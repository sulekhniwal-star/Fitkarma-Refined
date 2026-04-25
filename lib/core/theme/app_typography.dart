import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static const String _body  = 'PlusJakartaSans';
  static const String _mono  = 'JetBrainsMono';

  // ── Hero / Metric ──────────────────────────────────────────
  /// 72sp · ExtraBold — Step count, fasting timer (one per screen max)
  static TextStyle heroDisplay({Color color = AppColorsDark.textPrimary}) =>
      TextStyle(fontFamily: _body, fontSize: 72, fontWeight: FontWeight.w800,
                letterSpacing: -2.5, color: color);

  /// 56sp · Bold — Primary screen metric (BP, Glucose, Sleep)
  static TextStyle metricXL({Color color = AppColorsDark.textPrimary}) =>
      TextStyle(fontFamily: _body, fontSize: 56, fontWeight: FontWeight.w700,
                letterSpacing: -2.0, color: color);

  /// 40sp · Bold — Dashboard ring center (rings only)
  static TextStyle metricLg({Color color = AppColorsDark.textPrimary}) =>
      TextStyle(fontFamily: _body, fontSize: 40, fontWeight: FontWeight.w700,
                letterSpacing: -1.5, color: color);

  // ── Display ────────────────────────────────────────────────
  static TextStyle displayLg({Color color = AppColorsDark.textPrimary}) =>
      TextStyle(fontFamily: _body, fontSize: 32, fontWeight: FontWeight.w700,
                letterSpacing: -1.0, color: color);

  static TextStyle displayMd({Color color = AppColorsDark.textPrimary}) =>
      TextStyle(fontFamily: _body, fontSize: 28, fontWeight: FontWeight.w600,
                letterSpacing: -0.5, color: color);

  // ── Headings ───────────────────────────────────────────────
  static TextStyle h1({Color color = AppColorsDark.textPrimary}) =>
      TextStyle(fontFamily: _body, fontSize: 24, fontWeight: FontWeight.w600,
                letterSpacing: -0.3, color: color);

  static TextStyle h2({Color color = AppColorsDark.textPrimary}) =>
      TextStyle(fontFamily: _body, fontSize: 20, fontWeight: FontWeight.w600,
                letterSpacing: -0.2, color: color);

  static TextStyle h3({Color color = AppColorsDark.textPrimary}) =>
      TextStyle(fontFamily: _body, fontSize: 18, fontWeight: FontWeight.w500,
                letterSpacing: 0, color: color);

  static TextStyle h4({Color color = AppColorsDark.textPrimary}) =>
      TextStyle(fontFamily: _body, fontSize: 16, fontWeight: FontWeight.w500,
                letterSpacing: 0, color: color);

  // ── Labels ─────────────────────────────────────────────────
  static TextStyle labelLg({Color color = AppColorsDark.textPrimary}) =>
      TextStyle(fontFamily: _body, fontSize: 15, fontWeight: FontWeight.w600,
                letterSpacing: 0.2, color: color);

  static TextStyle labelMd({Color color = AppColorsDark.textSecondary}) =>
      TextStyle(fontFamily: _body, fontSize: 13, fontWeight: FontWeight.w500,
                letterSpacing: 0.1, color: color);

  // ── Body ───────────────────────────────────────────────────
  static TextStyle bodyLg({Color color = AppColorsDark.textPrimary}) =>
      TextStyle(fontFamily: _body, fontSize: 16, fontWeight: FontWeight.w400,
                letterSpacing: 0, color: color);

  static TextStyle bodyMd({Color color = AppColorsDark.textSecondary}) =>
      TextStyle(fontFamily: _body, fontSize: 14, fontWeight: FontWeight.w400,
                letterSpacing: 0, color: color);

  static TextStyle bodySm({Color color = AppColorsDark.textMuted}) =>
      TextStyle(fontFamily: _body, fontSize: 12, fontWeight: FontWeight.w400,
                letterSpacing: 0.1, color: color);

  // ── Monospace / Stats ──────────────────────────────────────
  /// 48sp — Live readings only (active HR, CGM glucose)
  static TextStyle monoXL({Color color = AppColorsDark.textPrimary}) =>
      TextStyle(fontFamily: _mono, fontSize: 48, fontWeight: FontWeight.w700,
                letterSpacing: -1.0, color: color);

  /// 28sp — Chart axis, counters, secondary stats
  static TextStyle monoLg({Color color = AppColorsDark.textPrimary}) =>
      TextStyle(fontFamily: _mono, fontSize: 28, fontWeight: FontWeight.w600,
                letterSpacing: -0.5, color: color);

  /// 14sp — Stats labels, small metrics
  static TextStyle monoMd({Color color = AppColorsDark.textSecondary}) =>
      TextStyle(fontFamily: _mono, fontSize: 14, fontWeight: FontWeight.w500,
                letterSpacing: 0, color: color);

  /// 12sp — Smallest data points, timestamps
  static TextStyle monoSm({Color color = AppColorsDark.textMuted}) =>
      TextStyle(fontFamily: _mono, fontSize: 12, fontWeight: FontWeight.w400,
                letterSpacing: 0, color: color);

  // ── Utility ────────────────────────────────────────────────
  static TextStyle caption({Color color = AppColorsDark.textMuted}) =>
      TextStyle(fontFamily: _body, fontSize: 11, fontWeight: FontWeight.w400,
                letterSpacing: 0.3, color: color);

  /// Hindi / Devanagari — system Noto Sans Devanagari
  static TextStyle hindi({Color color = AppColorsDark.textSecondary}) =>
      TextStyle(fontFamily: 'NotoSansDevanagari', fontSize: 12,
                fontWeight: FontWeight.w500, letterSpacing: 0, color: color);

  // ── ThemeData text themes ──────────────────────────────────
  static TextTheme darkTextTheme() => TextTheme(
    displayLarge:  heroDisplay(),
    displayMedium: metricXL(),
    displaySmall:  metricLg(),
    headlineLarge: displayLg(),
    headlineMedium: displayMd(),
    headlineSmall: h1(),
    titleLarge:    h2(),
    titleMedium:   h3(),
    titleSmall:    h4(),
    labelLarge:    labelLg(),
    labelMedium:   labelMd(),
    bodyLarge:     bodyLg(),
    bodyMedium:    bodyMd(),
    bodySmall:     bodySm(),
  );

  static TextTheme lightTextTheme() => TextTheme(
    displayLarge:  heroDisplay(color: AppColorsLight.textPrimary),
    displayMedium: metricXL(color: AppColorsLight.textPrimary),
    displaySmall:  metricLg(color: AppColorsLight.textPrimary),
    headlineLarge: displayLg(color: AppColorsLight.textPrimary),
    headlineMedium: displayMd(color: AppColorsLight.textPrimary),
    headlineSmall: h1(color: AppColorsLight.textPrimary),
    titleLarge:    h2(color: AppColorsLight.textPrimary),
    titleMedium:   h3(color: AppColorsLight.textPrimary),
    titleSmall:    h4(color: AppColorsLight.textPrimary),
    labelLarge:    labelLg(color: AppColorsLight.textPrimary),
    labelMedium:   labelMd(color: AppColorsLight.textSecondary),
    bodyLarge:     bodyLg(color: AppColorsLight.textPrimary),
    bodyMedium:    bodyMd(color: AppColorsLight.textSecondary),
    bodySmall:     bodySm(color: AppColorsLight.textMuted),
  );
}





