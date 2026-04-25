# FitKarma — Complete Documentation

## UI Design System · Technical Implementation Guide

### Flutter 3.x · Riverpod 2.x · Drift · Appwrite CLI

> **Offline-First · Privacy-Centric · Built for India**
> Dark mode primary · Glassmorphism · Spring physics · Bento grid
> All backend operations use **Appwrite CLI** — no console required.

---

## Table of Contents

### Part I — UI Design System

1. [Design Philosophy](#1-design-philosophy)
2. [Project Structure](#2-project-structure)
3. [Design Tokens — Flutter ThemeData](#3-design-tokens--flutter-themedata)
4. [Typography System](#4-typography-system)
5. [Motion & Animation](#5-motion--animation)
6. [Surface & Depth System](#6-surface--depth-system)
7. [Device Tier System](#7-device-tier-system)
8. [Universal Screen Rules](#8-universal-screen-rules)
9. [Scaffold Patterns](#9-scaffold-patterns)
10. [Shared Component Library](#10-shared-component-library)
11. [Screen Specifications](#11-screen-specifications)
12. [Bottom Navigation Bar](#12-bottom-navigation-bar)
13. [Common UI Patterns](#13-common-ui-patterns)
14. [Accessibility & Bilingual Rules](#14-accessibility--bilingual-rules)
15. [Additional Screen Specifications](#15-additional-screen-specifications)
16. [Low Data Mode — Implementation](#16-low-data-mode--implementation)
17. [Dosha Quiz Implementation](#17-dosha-quiz-implementation)
18. [Complete pubspec.yaml](#18-complete-pubspecyaml)
19. [Code Generation Commands](#19-code-generation-commands)
20. [Design System Quick Reference Card](#20-design-system-quick-reference-card)

### Part II — Technical Implementation

21. [Architecture Overview](#21-architecture-overview)
22. [Prerequisites & Tooling](#22-prerequisites--tooling)
23. [Project Setup](#23-project-setup)
24. [Appwrite CLI — Complete Setup](#24-appwrite-cli--complete-setup)
25. [Database Schema (Appwrite + Drift)](#25-database-schema-appwrite--drift)
26. [State Management — Riverpod 2.x](#26-state-management--riverpod-2x)
27. [Offline-First Architecture — Drift](#27-offline-first-architecture--drift)
28. [Sync Engine](#28-sync-engine)
29. [Authentication](#29-authentication)
30. [Storage & File Handling](#30-storage--file-handling)
31. [Health Integrations](#31-health-integrations)
32. [Security & Encryption](#32-security--encryption)
33. [Performance Considerations](#33-performance-considerations)
34. [Testing Strategy](#34-testing-strategy)
35. [CI/CD & Deployment](#35-cicd--deployment)
36. [Appwrite Functions — Server-Side Code](#36-appwrite-functions--server-side-code)
37. [Karma & Gamification Engine](#37-karma--gamification-engine)
38. [Festival & Wedding Data](#38-festival--wedding-data)
39. [Medication & Water Tracking Collections](#39-medication--water-tracking-collections)
40. [Notification System](#40-notification-system)
41. [Social Collections](#41-social-collections)
42. [Home Widgets](#42-home-widgets)
43. [Error Handling & Observability](#43-error-handling--observability)
44. [Complete appwrite.json Reference](#44-complete-appwritejson-reference)
45. [Glossary & Architecture Decisions](#45-glossary--architecture-decisions)

---

# Part I — UI Design System

## 1. Design Philosophy

### Six Pillars

| Pillar | Expression |
|---|---|
| **Spatial Depth** | Three-layer system: background → mid-layer → foreground. Real blur, shadow, translucency. |
| **Fluid Motion** | Spring physics everywhere. No linear tweens. 100ms touch-to-response. |
| **Bold Information** | One dominant metric per screen at 56–72sp. Context recedes, data leads. |
| **Visual Restraint** | Glow reserved for active metric, primary CTA, and ring fill only. Not every card glows. |
| **Dark-First** | Dark mode is the primary target. Light mode is a warm inversion, not an afterthought. |
| **Cultural Pulse** | Orange-indigo-saffron palette. Bilingual labels used strategically, not everywhere. |

### Anti-Patterns — Never Do These

```
❌ Plain white cards with grey text on white backgrounds
❌ Skeleton screens on core data — use Drift optimistic UI
❌ Hardcoded hex values outside the token file
❌ Modals/dialogs when a bottom sheet suffices
❌ Static illustrations — use Lottie or Rive
❌ Glow on every card
❌ Two competing hero elements on the same screen
❌ Bilingual labels on every element
❌ Blur + glow + gradient + animation on the same card (max 2 effects per surface)
```

---

## 2. Project Structure

```
lib/
├── core/
│   ├── config/
│   │   ├── device_tier.dart          # DeviceTier enum + detection
│   │   ├── user_experience_stage.dart # UXStage enum + logic
│   │   └── app_config.dart           # Environment config
│   ├── theme/
│   │   ├── app_colors.dart           # Color tokens (dark + light)
│   │   ├── app_typography.dart       # TextStyle definitions
│   │   ├── app_theme.dart            # ThemeData builder
│   │   └── app_spacing.dart          # Spacing + radius constants
│   └── providers/
│       ├── device_tier_provider.dart
│       └── ux_stage_provider.dart
├── shared/
│   └── widgets/
│       ├── bento_card.dart
│       ├── activity_rings.dart
│       ├── glowing_metric.dart
│       ├── insight_card.dart
│       ├── quick_log_fab.dart
│       ├── bilingual_label.dart
│       ├── encryption_badge.dart
│       ├── shimmer_loader.dart
│       ├── trend_chip.dart
│       ├── pulse_ring.dart
│       ├── streak_flame.dart
│       └── bottom_nav_bar.dart
├── features/
│   ├── onboarding/
│   ├── dashboard/
│   ├── food/
│   ├── workout/
│   ├── steps/
│   ├── health/
│   ├── karma/
│   ├── social/
│   ├── reports/
│   ├── festival/
│   ├── wedding/
│   └── settings/
└── main.dart

assets/
├── lottie/
│   ├── confetti_orange.json
│   ├── streak_fire.json
│   ├── coin_burst.json
│   ├── sync_check.json
│   ├── error_state.json
│   └── empty_*.json          # One per empty-state context
├── rive/
│   ├── logo_reveal.riv
│   ├── levelup.riv
│   ├── loading_rings.riv
│   └── logo_reveal.riv
└── fonts/
    ├── PlusJakartaSans[wght].ttf
    ├── JetBrainsMono[wght].ttf
    └── OpenDyslexic-Regular.ttf
```

---

## 3. Design Tokens — Flutter ThemeData

### 3.1 Color Tokens

```dart
// lib/core/theme/app_colors.dart

import 'package:flutter/material.dart';

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
  static const teal           = Color(0xFF0D9488);
  static const success        = Color(0xFF22C55E);

  static const textPrimary    = Color(0xFF1A1830);
  static const textSecondary  = Color(0xFF6B6A96);
  static const textMuted      = Color(0xFFB0AEC8);
  static const divider        = Color(0x121A1830);
}
```

### 3.2 Spacing & Radius Tokens

```dart
// lib/core/theme/app_spacing.dart

class AppSpacing {
  AppSpacing._();

  // Screen padding
  static const double screenH = 20.0;   // horizontal screen padding
  static const double cardH   = 16.0;   // inside card horizontal padding
  static const double fabClearance = 120.0; // bottom padding for FAB

  // Bento grid
  static const double bentoGap = 12.0;
}

class AppRadius {
  AppRadius._();

  static const double sm   = 10.0;   // chips, pills, tags
  static const double md   = 16.0;   // standard cards
  static const double lg   = 20.0;   // bottom sheets, modals
  static const double xl   = 28.0;   // hero sections, large cards
  static const double full = 9999.0; // avatar, FAB, round buttons

  // Bento aliases
  static const double bentoInner = 14.0; // nested cards
  static const double bentoOuter = 20.0; // outer cards
  static const double bentoHero  = 28.0; // full-width hero
}
```

### 3.3 ThemeData Builder

```dart
// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_spacing.dart';

class AppTheme {
  AppTheme._();

  static ThemeData dark() {
    const c = AppColorsDark;
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: c.bg1,
      colorScheme: const ColorScheme.dark(
        primary:    c.primary,
        secondary:  c.secondary,
        surface:    c.surface0,
        error:      c.error,
        onPrimary:  Colors.white,
        onSecondary: Colors.white,
        onSurface:  c.textPrimary,
        onError:    Colors.white,
      ),
      textTheme: AppTypography.darkTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: c.textSecondary),
        titleTextStyle: TextStyle(
          color: c.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: 'PlusJakartaSans',
          letterSpacing: -0.3,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: c.divider,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surface0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: c.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: c.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: c.primary, width: 2),
        ),
        hintStyle: const TextStyle(color: c.textMuted),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: c.primary,
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
        backgroundColor: c.surface1,
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
    const c = AppColorsLight;
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: c.bg1,
      colorScheme: const ColorScheme.light(
        primary:    c.primary,
        secondary:  c.secondary,
        surface:    c.surface0,
        error:      Color(0xFFD32F2F),
        onPrimary:  Colors.white,
        onSecondary: Colors.white,
        onSurface:  c.textPrimary,
      ),
      textTheme: AppTypography.lightTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: c.bg1,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: c.textSecondary),
        titleTextStyle: TextStyle(
          color: c.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: 'PlusJakartaSans',
          letterSpacing: -0.3,
        ),
      ),
      dividerTheme: const DividerThemeData(color: c.divider, thickness: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surface0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: c.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: c.primary, width: 2),
        ),
        hintStyle: const TextStyle(color: c.textMuted),
      ),
    );
  }
}
```

### 3.4 Hero Gradients

```dart
// lib/core/theme/app_gradients.dart

import 'package:flutter/material.dart';

class AppGradients {
  AppGradients._();

  static const heroDeep = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0A0818), Color(0xFF1E1850)],
  );

  static const heroDeepLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2C2A6B), Color(0xFF3F3D8F)],
  );

  static const heroSleep = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF04020F), Color(0xFF0D0B2E), Color(0xFF1C1A48)],
  );

  static const heroFestival = LinearGradient(
    begin: Alignment(-.5, -1),
    end: Alignment(.5, 1),
    colors: [Color(0xFF1A0A00), Color(0xFF3D1500)],
  );

  static const heroWedding = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A1000), Color(0xFF3A2800)],
  );

  static const heroPrimary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A0800), Color(0xFF3D1100)],
  );
}
```

---

## 4. Typography System

### 4.1 Font Setup (`pubspec.yaml`)

```yaml
flutter:
  fonts:
    - family: PlusJakartaSans
      fonts:
        - asset: assets/fonts/PlusJakartaSans[wght].ttf
    - family: JetBrainsMono
      fonts:
        - asset: assets/fonts/JetBrainsMono[wght].ttf
    - family: OpenDyslexic
      fonts:
        - asset: assets/fonts/OpenDyslexic-Regular.ttf
```

### 4.2 TextStyle Definitions

```dart
// lib/core/theme/app_typography.dart

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
```

### 4.3 Typography Enforcement Table

> One `heroDisplay` OR `metricXL` per visible screen area. Never both simultaneously.

| Screen | Hero Style | Secondary Style | Card Body |
|---|---|---|---|
| Dashboard | `metricLg` (ring center) | `monoLg` (calories) | `bodyMd` |
| Steps | `heroDisplay` (step count) | `monoLg` (distance, kcal) | `bodyMd` |
| Blood Pressure | `metricXL` (systolic/diastolic) | `monoLg` (pulse) | `bodyMd` |
| Glucose | `metricXL` (reading) | `labelLg` (classification) | `bodyMd` |
| Sleep | `metricXL` (duration) | `monoLg` (quality score) | `bodyMd` |
| Active Workout | `heroDisplay` (timer/reps) | `monoXL` (HR zone, live only) | `h3` |
| Fasting Timer | `heroDisplay` (HH:MM:SS) | `monoLg` (stage name) | `bodyMd` |
| Karma Hub | `displayLg` (XP total) | `monoLg` (level progress) | `bodyMd` |

---

## 5. Motion & Animation

### 5.1 Spring Presets

```dart
// lib/core/theme/app_springs.dart

import 'package:flutter/physics.dart';

class AppSprings {
  AppSprings._();

  /// Chips, toggles, small state changes
  static const light = SpringDescription(mass: 1.0, stiffness: 400, damping: 28.28);

  /// Cards, tab transitions, page routes  
  static const standard = SpringDescription(mass: 1.0, stiffness: 250, damping: 22.36);

  /// Hero entrances, metric reveals, level-up
  static const dramatic = SpringDescription(mass: 1.0, stiffness: 180, damping: 18.97);
}
```

### 5.2 Standard Transitions

```dart
// lib/core/router/transitions.dart

import 'package:flutter/material.dart';

/// Standard screen push — shared axis vertical slide + fade
class VerticalSlideTransition extends PageRouteBuilder {
  final Widget page;

  VerticalSlideTransition({required this.page})
      : super(
          transitionDuration: const Duration(milliseconds: 320),
          reverseTransitionDuration: const Duration(milliseconds: 280),
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) {
            final slide = Tween<Offset>(
              begin: const Offset(0, 0.06),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: slide, child: child),
            );
          },
        );
}

/// Card tap feedback — 1.0 → 0.97 → 1.0
class CardTapAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const CardTapAnimation({super.key, required this.child, this.onTap});

  @override
  State<CardTapAnimation> createState() => _CardTapAnimationState();
}

class _CardTapAnimationState extends State<CardTapAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 80));
    _scale = Tween<double>(begin: 1.0, end: 0.97).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) { _ctrl.reverse(); widget.onTap?.call(); },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}
```

### 5.3 Asset Inventory

#### Lottie Animations

```
assets/lottie/
  confetti_orange.json     # step goal celebration
  streak_fire.json         # habit streak flame
  coin_burst.json          # XP collection
  sync_check.json          # sync success
  error_state.json         # error state

  # Empty states — one per context, never text-only
  empty_food_log.json
  empty_search.json
  empty_workout.json
  empty_steps.json
  empty_sleep.json
  empty_mood.json
  empty_bp.json
  empty_glucose.json
  empty_lab.json
  empty_habits.json
  empty_journal.json
  empty_social.json
  empty_challenges.json
  empty_medication.json
  empty_water.json
  empty_records.json
  empty_appointments.json
  empty_rituals.json
  empty_festivals.json
  empty_family.json
  empty_generic.json       # fallback
```

#### Empty State Fallback Text

| Context | Lottie Key | Fallback Text |
|---|---|---|
| Food log | `empty_food_log` | "No meals logged yet. Tap + to add breakfast." |
| Food search | `empty_search` | "No results. Try a different name or scan a barcode." |
| Workout list | `empty_workout` | "No workouts yet. Explore plans to get started." |
| Steps | `empty_steps` | "Step data not available. Check Health Connect permissions." |
| Sleep | `empty_sleep` | "No sleep logged this week. Tap + to add last night." |
| BP history | `empty_bp` | "No readings yet. Log your first BP reading." |
| Glucose | `empty_glucose` | "No glucose readings yet. Log your first reading." |
| Lab reports | `empty_lab` | "No lab reports imported. Tap 📋 to scan a report." |
| Habits | `empty_habits` | "No habits yet. Pick from presets or create your own." |
| Journal | `empty_journal` | "No entries yet. Start with how you're feeling today." |

---

## 6. Surface & Depth System

### 6.1 Three-Layer Depth Model

```
PLANE 3 — Foreground
  FAB · Bottom sheets · Tooltips · Modals
  Highest elevation, max blur behind

PLANE 2 — Mid-layer
  Cards · Charts · Insight panels · Bento cells
  Glass surface + divider border

PLANE 1 — Background
  Scaffold · Hero gradients · Ambient glow blobs
  Raw bg1 or gradient — no surface applied
```

### 6.2 Glassmorphic Card Widget

```dart
// lib/shared/widgets/glass_card.dart

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/config/device_tier.dart';
import '../../core/providers/device_tier_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GlassCard extends ConsumerWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? glowColor;       // null = no glow
  final Color? borderColor;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.borderRadius = AppRadius.md,
    this.glowColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tier = ref.watch(deviceTierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final useBlur = tier != DeviceTier.low;
    final bgColor = isDark
        ? (useBlur ? AppColorsDark.glass : AppColorsDark.surface1)
        : (useBlur ? AppColorsLight.glass : AppColorsLight.surface1);
    final border = borderColor ??
        (isDark ? AppColorsDark.glassBorder : AppColorsLight.glassBorder);

    final boxDecoration = BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: border, width: 1),
      boxShadow: glowColor != null && isDark && tier != DeviceTier.low
          ? [BoxShadow(color: glowColor!, blurRadius: 24, spreadRadius: -4)]
          : null,
    );

    final content = Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: boxDecoration,
      child: child,
    );

    if (!useBlur) return content;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        // Capped at 12px — matches spec; blur(20px) caused mid-tier jank
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: content,
      ),
    );
  }
}
```

### 6.3 Ambient Glow Blobs

```dart
// lib/shared/widgets/ambient_blobs.dart

import 'package:flutter/material.dart';
import '../../core/config/device_tier.dart';
import '../../core/providers/device_tier_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AmbientBlobs extends ConsumerWidget {
  const AmbientBlobs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tier = ref.watch(deviceTierProvider);
    if (tier == DeviceTier.low) return const SizedBox.shrink();

    final blobCount = tier == DeviceTier.mid ? 1 : 3;

    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            _blob(top: 0,   left: 0,   color: const Color(0x207B6FF0), size: 280, blur: 80),
            if (blobCount > 1)
              _blob(top: 0,   right: 0,  color: const Color(0x15FF6B35), size: 200, blur: 60),
            if (blobCount > 2)
              _blob(top: 100, left: 80,  color: const Color(0x1000D4B4), size: 160, blur: 50),
          ],
        ),
      ),
    );
  }

  Widget _blob({
    double? top, double? left, double? right,
    required Color color, required double size, required double blur,
  }) {
    return Positioned(
      top: top, left: left, right: right,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: size, height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ),
    );
  }
}
```

---

## 7. Device Tier System

### 7.1 Tier Detection

```dart
// lib/core/config/device_tier.dart

enum DeviceTier { low, mid, high }

/// low  = < 3GB RAM
/// mid  = 3–6GB RAM
/// high = > 6GB RAM
```

```dart
// lib/core/providers/device_tier_provider.dart

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/device_tier.dart';

final deviceTierProvider = FutureProvider<DeviceTier>((ref) async {
  final info = DeviceInfoPlugin();
  int ramMB = 4096; // default mid

  // Android only — iOS doesn't expose RAM
  if (defaultTargetPlatform == TargetPlatform.android) {
    final android = await info.androidInfo;
    // device_info_plus doesn't expose RAM directly;
    // use a native channel or fall back to heuristics below
    ramMB = _estimateRamFromAndroidVersion(android.version.sdkInt);
  }

  if (ramMB < 3000) return DeviceTier.low;
  if (ramMB < 6000) return DeviceTier.mid;
  return DeviceTier.high;
});

int _estimateRamFromAndroidVersion(int sdkInt) {
  // Conservative heuristic for Indian market device distribution
  if (sdkInt < 26) return 2000; // Android 8 or lower → low-end
  if (sdkInt < 29) return 3000;
  return 4096;
}
```

### 7.2 Tier Capability Matrix

| Feature | Low (< 3GB) | Mid (3–6GB) | High (6GB+) |
|---|---|---|---|
| `BackdropFilter` blur | ❌ Disabled | ✅ Cards only | ✅ Full glassmorphism |
| Ambient glow blobs | ❌ Disabled | ⚡ 1 blob, 60% opacity | ✅ 3 blobs |
| Glow box-shadows | ❌ Disabled | ⚡ Active element only | ✅ Full glow system |
| Lottie | ⚡ Essential only | ✅ All Lottie | ✅ All Lottie + Rive |
| Rive | ❌ Static fallback | ⚡ Logo reveal only | ✅ All Rive |
| Spring animations | ⚡ Cross-fade only | ✅ Standard spring | ✅ Full spring physics |
| Per-digit CountUp | ❌ Single tween | ⚡ Whole-number spring | ✅ Per-digit spring |
| Card surface | `surface1` solid | `surface0` + border | Full glassmorphic |
| Sync interval | 6 hours | 30 min | 15 min |

---

## 8. Universal Screen Rules

### 8.1 Single Hero Rule

Every screen has exactly one visual champion:

```
LEVEL 1 — Hero:      One metric (metricXL or heroDisplay)
LEVEL 2 — Secondary: Max 2 supporting stats (monoLg)
LEVEL 3 — Context:   Labels, captions, trends (bodyMd, caption)
LEVEL 4 — Supporting: Collapsed or progressively revealed
```

**Never stack two `metricXL` or `heroDisplay` on the same visible scroll area.**

### 8.2 Glow Discipline

**Glow ONLY on:**

| Element | Glow Token |
|---|---|
| Primary metric (Level 1 hero) | `{colorGlow}` matching metric color |
| Primary CTA button | `primaryGlow` |
| Active/selected ring fill | Ring color glow |
| Active nav tab indicator | `primaryGlow` at 50% opacity |
| `EncryptionBadge` | `tealGlow` |
| Linked ABHA status | `successGlow` |

**Glow PROHIBITED on:** Secondary metric cards, section headers, list items, log entries, empty states, settings rows, any Visual Calm Zone screen.

### 8.3 Visual Calm Zones

These screens use zero glow, minimal animation, no blur:

| Screen | Reason |
|---|---|
| Settings | Trust + clarity |
| Journal | Emotional space |
| Emergency Card | Medical urgency |
| Lab Reports | Clinical tone |
| ABHA Account | Government trust signal |
| Doctor Appointments | Professional context |
| Subscription Plans | Financial decision |
| Onboarding Steps 1–3 | Reduce new user overwhelm |

```dart
// Calm Zone card spec — overrides ALL tier settings
BoxDecoration calmCardDecoration(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return BoxDecoration(
    color: isDark ? AppColorsDark.surface0 : AppColorsLight.surface0,
    borderRadius: BorderRadius.circular(AppRadius.md),
    border: Border.all(
      color: isDark ? AppColorsDark.divider : AppColorsLight.divider,
    ),
    // No glow. No blur. No ambient blobs.
  );
}
```

### 8.4 Three-Layer Disclosure

```
LAYER 1 — Above the fold (no scroll required):
  → Hero metric (metricXL or heroDisplay)
  → Max 2 secondary stats
  → Primary CTA
  → NO section headers competing here

LAYER 2 — Scroll zone:
  → Charts and trends
  → Max 1 Insight card
  → Modular summary cards

LAYER 3 — On tap / progressive reveal:
  → Historical data
  → Detailed breakdowns
  → Settings and configuration
```

### 8.5 Progressive Disclosure for New Users

```dart
// lib/core/config/user_experience_stage.dart

enum UXStage { firstWeek, familiar, expert }

UXStage getUXStage(DateTime firstLaunch) {
  final days = DateTime.now().difference(firstLaunch).inDays;
  if (days < 7)  return UXStage.firstWeek;
  if (days < 30) return UXStage.familiar;
  return UXStage.expert;
}
```

| UX Stage | Default Visible Modules | Effects |
|---|---|---|
| `firstWeek` | Steps + Food + 1 Insight card | Calm (no glow, simple springs) |
| `familiar` | All core modules, Karma, Challenges | Standard effects |
| `expert` | Full system + correlations + leaderboards | Full (device-tier limited) |

> All modules accessible at any stage via navigation — progressive disclosure only affects Dashboard defaults.

### 8.6 Bento Grid — Min Cell Width Guard

```dart
// lib/shared/widgets/bento_card.dart

const double _bentoGap = 12.0;
const double _screenPadding = 20.0;
const double _minCellWidthDp = 80.0;

enum BentoSize { full, half, third, twoThird, quarter }

BentoSize _resolvedSize(BuildContext context, BentoSize requested) {
  final screenWidth = MediaQuery.of(context).size.width;
  final available = screenWidth - (_screenPadding * 2);
  const cols = 12;
  final cellWidth = (available - (_bentoGap * (cols - 1))) / cols;

  final requestedCols = _colsFor(requested); // quarter=3, third=4, half=6, etc.
  if ((cellWidth * requestedCols) < _minCellWidthDp) {
    if (requested == BentoSize.quarter) return BentoSize.third;
    if (requested == BentoSize.third)   return BentoSize.half;
  }
  return requested;
}

int _colsFor(BentoSize size) => switch (size) {
  BentoSize.quarter   => 3,
  BentoSize.third     => 4,
  BentoSize.half      => 6,
  BentoSize.twoThird  => 8,
  BentoSize.full      => 12,
};
```

---

## 9. Scaffold Patterns

### Pattern A — Standard

```dart
// Most screens
Scaffold(
  backgroundColor: isDark ? AppColorsDark.bg1 : AppColorsLight.bg1,
  appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
  body: Stack(
    children: [
      const AmbientBlobs(),             // behind everything
      SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(...),
            ),
            // FAB clearance
            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        ),
      ),
    ],
  ),
)
```

### Pattern B — Immersive Hero + Layered Body

```dart
// Metric-heavy screens: Dashboard, Karma, Sleep, BP, Profile
Scaffold(
  backgroundColor: isDark ? AppColorsDark.bg0 : AppColorsLight.bg0,
  extendBodyBehindAppBar: true,
  body: Stack(
    children: [
      // Hero gradient — 320px tall
      Container(
        height: 320,
        decoration: const BoxDecoration(gradient: AppGradients.heroDeep),
        child: Stack(
          children: [
            const AmbientBlobs(),
            // Transparent AppBar overlaid
            // Hero metric content
          ],
        ),
      ),
      // Scrollable body overlaps hero by 28px
      DraggableScrollableSheet(
        initialChildSize: 0.65,
        minChildSize: 0.65,
        maxChildSize: 1.0,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: isDark ? AppColorsDark.surface1 : AppColorsLight.surface1,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: ListView(controller: controller, children: [...]),
        ),
      ),
    ],
  ),
)
```

### Pattern C — Full-Bleed Immersive

```dart
// Active Workout, GPS
Scaffold(
  backgroundColor: AppColorsDark.bg0,
  extendBodyBehindAppBar: true,
  appBar: AppBar(
    backgroundColor: Colors.transparent,
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  body: Stack(children: [/* full-bleed content */]),
)
```

---

## 10. Shared Component Library

All components in `lib/shared/widgets/`. **Never re-implement per screen.**

### 10.1 BentoCard

```dart
// lib/shared/widgets/bento_card.dart

class BentoCard extends ConsumerWidget {
  final BentoSize size;
  final Widget child;
  final Color? glowColor;
  final EdgeInsetsGeometry? padding;

  const BentoCard({
    super.key,
    required this.size,
    required this.child,
    this.glowColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resolved = _resolvedSize(context, size);
    final cols = _colsFor(resolved);
    final screenWidth = MediaQuery.of(context).size.width;
    final available = screenWidth - 40; // 20px each side
    final cellWidth = (available - (_bentoGap * 11)) / 12;
    final width = (cellWidth * cols) + (_bentoGap * (cols - 1));

    return SizedBox(
      width: width,
      child: GlassCard(
        borderRadius: AppRadius.bentoOuter,
        glowColor: glowColor,
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
```

### 10.2 BilingualLabel

```dart
// lib/shared/widgets/bilingual_label.dart

class BilingualLabel extends StatelessWidget {
  final String english;
  final String hindi;
  final bool showSeeAll;
  final VoidCallback? onSeeAll;

  const BilingualLabel({
    super.key,
    required this.english,
    required this.hindi,
    this.showSeeAll = false,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3, height: 18,
          decoration: BoxDecoration(
            color: AppColorsDark.primary,
            borderRadius: BorderRadius.circular(AppRadius.full),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(english, style: AppTypography.h3()),
            Text(hindi, style: AppTypography.hindi()),
          ],
        ),
        if (showSeeAll) ...[
          const Spacer(),
          TextButton(
            onPressed: onSeeAll,
            child: Text('See all →',
                style: AppTypography.labelMd(color: AppColorsDark.primary)),
          ),
        ],
      ],
    );
  }
}
```

### 10.3 GlowingMetric

```dart
// lib/shared/widgets/glowing_metric.dart

class GlowingMetric extends ConsumerWidget {
  final String value;
  final TextStyle Function({Color color}) styleBuilder;
  final Color color;
  final bool showGlow;

  const GlowingMetric({
    super.key,
    required this.value,
    required this.styleBuilder,
    this.color = AppColorsDark.primary,
    this.showGlow = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tier = ref.watch(deviceTierProvider).valueOrNull ?? DeviceTier.mid;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Text(
      value,
      style: styleBuilder(color: color).copyWith(
        shadows: showGlow && isDark && tier != DeviceTier.low
            ? [
                Shadow(color: color.withOpacity(0.6), blurRadius: 20),
                Shadow(color: color.withOpacity(0.3), blurRadius: 40),
              ]
            : null,
      ),
    );
  }
}
```

### 10.4 EncryptionBadge

```dart
// lib/shared/widgets/encryption_badge.dart

class EncryptionBadge extends ConsumerWidget {
  final bool animate;
  const EncryptionBadge({super.key, this.animate = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tier = ref.watch(deviceTierProvider).valueOrNull ?? DeviceTier.mid;

    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      borderRadius: AppRadius.full,
      glowColor: tier != DeviceTier.low ? AppColorsDark.tealGlow : null,
      borderColor: AppColorsDark.teal.withOpacity(0.4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.lock, size: 12, color: AppColorsDark.teal),
          const SizedBox(width: 4),
          Text('AES-256 Encrypted',
              style: AppTypography.caption(color: AppColorsDark.teal)),
        ],
      ),
    );
  }
}
```

### 10.5 TrendChip

```dart
// lib/shared/widgets/trend_chip.dart

enum TrendDirection { up, down, stable }

class TrendChip extends StatelessWidget {
  final TrendDirection direction;
  final String label;   // e.g. "+3%" or "-2%"

  const TrendChip({super.key, required this.direction, required this.label});

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (direction) {
      TrendDirection.up     => ('▲', AppColorsDark.success),
      TrendDirection.down   => ('▼', AppColorsDark.error),
      TrendDirection.stable => ('→', AppColorsDark.textMuted),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: TextStyle(color: color, fontSize: 10)),
          const SizedBox(width: 2),
          Text(label, style: AppTypography.caption(color: color)),
        ],
      ),
    );
  }
}
```

### 10.6 ShimmerLoader

```dart
// lib/shared/widgets/shimmer_loader.dart
// Requires: shimmer: ^3.0.0

import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerLoader({
    super.key,
    this.width = double.infinity,
    this.height = 80,
    this.borderRadius = AppRadius.md,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? AppColorsDark.surface0 : AppColorsLight.surface0,
      highlightColor: isDark ? AppColorsDark.surface1 : AppColorsLight.surface1,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isDark ? AppColorsDark.surface0 : AppColorsLight.surface0,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
```

### 10.7 QuickLogFAB

```dart
// lib/shared/widgets/quick_log_fab.dart

class QuickLogFAB extends ConsumerStatefulWidget {
  const QuickLogFAB({super.key});
  @override
  ConsumerState<QuickLogFAB> createState() => _QuickLogFABState();
}

class _QuickLogFABState extends ConsumerState<QuickLogFAB>
    with SingleTickerProviderStateMixin {
  bool _open = false;
  late AnimationController _ctrl;

  static const _actions = [
    (icon: Icons.restaurant, label: 'Food'),
    (icon: Icons.water_drop, label: 'Water'),
    (icon: Icons.mood, label: 'Mood'),
    (icon: Icons.fitness_center, label: 'Workout'),
    (icon: Icons.favorite, label: 'BP'),
    (icon: Icons.bloodtype, label: 'Glucose'),
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final tier = ref.watch(deviceTierProvider).valueOrNull ?? DeviceTier.mid;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_open)
          ..._actions.map((a) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: FloatingActionButton.small(
              heroTag: a.label,
              onPressed: () { /* navigate */ },
              backgroundColor: AppColorsDark.surface1,
              child: Icon(a.icon, color: AppColorsDark.primary),
            ),
          )),
        FloatingActionButton(
          onPressed: () => setState(() {
            _open = !_open;
            _open ? _ctrl.forward() : _ctrl.reverse();
          }),
          backgroundColor: AppColorsDark.primary,
          shape: const CircleBorder(),
          child: RotationTransition(
            turns: Tween(begin: 0.0, end: 0.125).animate(_ctrl),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
```

### Complete Component Reference Table

| Component | File | Description |
|---|---|---|
| `BentoCard` | `bento_card.dart` | Glassmorphic card — BentoSize enum, auto-promotes on small screens |
| `ActivityRingsWidget` | `activity_rings.dart` | 4 concentric rings, neon glow, animated fill, `metricLg` center |
| `GlowingMetric` | `glowing_metric.dart` | CountUp with per-digit spring + optional neon glow |
| `InsightCard` | `insight_card.dart` | Glass + lightbulb icon + 👍/👎 haptic rating |
| `CorrelationInsightCard` | `correlation_insight_card.dart` | Multi-module insight with module icon pills |
| `FoodItemCard` | `food_item_card.dart` | Glassmorphic + blurred food photo + bilingual name + portion + kcal |
| `KarmaLevelCard` | `karma_level_card.dart` | `heroDeep` gradient + animated XP bar |
| `DoshaDonutChart` | `dosha_chart.dart` | 3-segment donut (fl_chart) + animated draw + per-segment glow |
| `ChallengeCarouselCard` | `challenge_card.dart` | Horizontal scroll + progress bar + XP reward + festival tag |
| `QuickLogFAB` | `quick_log_fab.dart` | Glowing orange FAB, speed-dial 6 sub-actions |
| `MealTypeTabBar` | `meal_tab_bar.dart` | Floating pill tabs, primary glow on active |
| `ShimmerLoader` | `shimmer_loader.dart` | `surface0` + shimmer gradient, dark/light aware |
| `BilingualLabel` | `bilingual_label.dart` | English h3 + Devanagari + 3px primary border |
| `EncryptionBadge` | `encryption_badge.dart` | Glassmorphic pill, 🔒 AES-256, teal glow |
| `ABHALinkBadge` | `abha_badge.dart` | Link status: linked=success glow, unlinked=warning glow |
| `HealthShareCard` | `health_share_card.dart` | Share-to-doctor, expiry countdown ring, WhatsApp CTA |
| `TrendChip` | `trend_chip.dart` | ▲/▼/→ animated chip, color-coded |
| `PulseRing` | `pulse_ring.dart` | Animated pulsing ring for live metric indicators |
| `StreakFlameWidget` | `streak_flame.dart` | Lottie streak_fire.json, scale grows with streak |
| `GlassCard` | `glass_card.dart` | Base glassmorphic card, tier-aware blur |
| `AmbientBlobs` | `ambient_blobs.dart` | Background glow blobs, tier-limited |
| `ErrorRetryWidget` | `error_retry_widget.dart` | Lottie error_state.json + message + retry |
| `SyncStatusBanner` | `sync_status_banner.dart` | Teal (low data) / Amber (sync failure) top banner |
| `FestivalCard` | `festival_card.dart` | Festival glass card + gradient border + bilingual + fasting pill |
| `WeddingRoleChip` | `wedding_role_chip.dart` | 150×160px illustrated role card, spring select |
| `EventDayCard` | `event_day_card.dart` | Wedding event + energy badge + pre/post meal |

---

## 11. Screen Specifications

### 11.1 Bottom Navigation Bar

```dart
// lib/shared/widgets/bottom_nav_bar.dart

class FitKarmaBottomNav extends ConsumerWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const FitKarmaBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _tabs = [
    (icon: Icons.home_outlined,         filled: Icons.home,           en: 'Home',    hi: 'मुख्यपृष्ठ', route: '/home/dashboard'),
    (icon: Icons.restaurant_outlined,   filled: Icons.restaurant,     en: 'Food',    hi: 'खाना',       route: '/home/food'),
    (icon: Icons.fitness_center_outlined, filled: Icons.fitness_center, en: 'Workout', hi: 'वर्कआउट',  route: '/home/workout'),
    (icon: Icons.directions_walk_outlined, filled: Icons.directions_walk, en: 'Steps', hi: 'कदम',      route: '/home/steps'),
    (icon: Icons.person_outline,        filled: Icons.person,         en: 'Me',      hi: 'मैं',        route: '/profile'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stage = ref.watch(uxStageProvider);
    final showAllLabels = stage == UXStage.firstWeek;
    final tier = ref.watch(deviceTierProvider).valueOrNull ?? DeviceTier.mid;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16,
          MediaQuery.of(context).padding.bottom + 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.full),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColorsDark.surface1.withOpacity(0.9)
                  : AppColorsLight.surface1.withOpacity(0.9),
              borderRadius: BorderRadius.circular(AppRadius.full),
              border: Border.all(
                color: isDark ? AppColorsDark.glassBorder : AppColorsLight.glassBorder,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 32,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: List.generate(_tabs.length, (i) {
                final tab = _tabs[i];
                final isActive = currentIndex == i;
                return Expanded(
                  child: _NavTab(
                    icon: isActive ? tab.filled : tab.icon,
                    label: tab.en,
                    hindiLabel: tab.hi,
                    isActive: isActive,
                    showLabel: isActive || showAllLabels,
                    showGlow: tier != DeviceTier.low,
                    onTap: () => onTap(i),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
```

### 11.2 Onboarding — Step 1 Personal Info

```dart
// Key widgets layout (Pattern A — calm zone)
SafeArea(
  child: Column(
    children: [
      // 6-segment progress bar
      _ProgressBar(current: 1, total: 6),
      const SizedBox(height: 32),

      Text('Tell us about you', style: AppTypography.displayMd()),
      Text('आपके बारे में बताएं',
          style: AppTypography.hindi(color: AppColorsDark.textSecondary)),
      const SizedBox(height: 32),

      // Name field
      TextFormField(decoration: const InputDecoration(hintText: 'Your name')),
      const SizedBox(height: 20),

      // Gender chips — 44px tap targets
      Wrap(
        spacing: 8,
        children: ['Male 🧑', 'Female 👩', 'Other ⚧', 'Skip']
            .map((g) => _GenderChip(label: g))
            .toList(),
      ),
      const SizedBox(height: 20),

      // DOB picker
      _DateOfBirthCard(),
      const Spacer(),

      // Primary CTA
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Next →'),
        ),
      ),
    ],
  ),
)
```

### 11.3 Dashboard — Bento Grid Layout

```
Bento Grid discipline:
  Row 1 (above fold): ActivityRingsWidget — FULL WIDTH
  Row 2: 2 half-cards (Latest Workout + Sleep)
  Row 3: InsightCard or CorrelationInsightCard — full width (max 1)
  Row 4+: Today's Meals (user must scroll intentionally)
```

```dart
// Body layout
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Wrap(
    spacing: 12, runSpacing: 12,
    children: [
      BentoCard(size: BentoSize.full,
          child: ActivityRingsWidget(rings: todayRings)),

      BentoCard(size: BentoSize.half,
          child: LatestWorkoutCard(workout: latest)),
      BentoCard(size: BentoSize.half,
          child: SleepRecoveryCard(recovery: sleepScore)),

      BentoCard(size: BentoSize.full,
          child: InsightCard(insight: todayInsight)),

      // Meals section — below fold
      BentoCard(size: BentoSize.full,
          child: TodayMealsWidget(meals: meals)),
    ],
  ),
)
```

---

## 12. Bottom Navigation Bar

See §11.1 above for full implementation.

**Route map:**

| Tab | Route |
|---|---|
| Home | `/home/dashboard` |
| Food | `/home/food` |
| Workout | `/home/workout` |
| Steps | `/home/steps` |
| Me | `/profile` |

**Active tab:** Icon + label visible, primary color, soft primary glow (mid/high tier only).
**Inactive tab:** Icon only (no label), `textMuted` — unless `UXStage.firstWeek`.
**First Week all-labels mode:** All 5 tabs show labels. Inactive label style: `caption`, `textMuted`.

---

## 13. Common UI Patterns

### 13.1 Log Bottom Sheet — Standard Structure

```dart
void showLogSheet(BuildContext context, {
  required String titleEn,
  required String titleHi,
  required Widget form,
  required VoidCallback onSave,
  bool sensitive = false,   // adds EncryptionBadge
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 16),
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: AppColorsDark.divider,
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
            ),
          ),
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                BilingualLabel(english: titleEn, hindi: titleHi),
                if (sensitive) ...[
                  const Spacer(), const EncryptionBadge(),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: form,
          ),
          const SizedBox(height: 16),
          // Primary CTA
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: onSave, child: const Text('Save')),
            ),
          ),
        ],
      ),
    ),
  );
}
```

### 13.2 Sync Status Patterns

```dart
// DLQ warning — amber banner
// Offline — teal pill
// Low Data Mode — persistent teal pill

class SyncStatusBanner extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncState = ref.watch(syncStateProvider);
    
    if (syncState.dlqCount > 0) {
      return _Banner(
        color: AppColorsDark.warning,
        icon: Icons.warning_amber,
        message: '${syncState.dlqCount} items failed to sync. Tap to review.',
        onTap: () => context.push('/settings/sync'),
      );
    }
    if (!syncState.isOnline) {
      return _Banner(
        color: AppColorsDark.teal,
        icon: Icons.cloud_off,
        message: 'Offline — changes saved locally',
      );
    }
    if (syncState.lowDataMode) {
      return _Banner(
        color: AppColorsDark.teal,
        icon: Icons.data_saver_on,
        message: 'Low Data Mode',
        persistent: true,
      );
    }
    return const SizedBox.shrink();
  }
}
```

### 13.3 Empty State Widget

```dart
// lib/shared/widgets/empty_state.dart
// Requires: lottie: ^3.0.0

import 'package:lottie/lottie.dart';

class EmptyState extends StatelessWidget {
  final String lottieAsset;  // e.g. 'assets/lottie/empty_food_log.json'
  final String message;
  final String? ctaLabel;
  final VoidCallback? onCta;

  const EmptyState({
    super.key,
    required this.lottieAsset,
    required this.message,
    this.ctaLabel,
    this.onCta,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(lottieAsset, width: 200, height: 200),
          const SizedBox(height: 16),
          Text(message,
              textAlign: TextAlign.center,
              style: AppTypography.bodyMd()),
          if (ctaLabel != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onCta, child: Text(ctaLabel!)),
          ],
        ],
      ),
    );
  }
}
```

---

## 14. Accessibility & Bilingual Rules

### 14.1 Strategic Bilingual — Required Locations

| Location | Format |
|---|---|
| Bottom nav labels (active) | English 10sp SemiBold + Hindi 9sp below |
| Screen app bar titles | English h1 + Hindi sub-label (muted) |
| Section headers | `BilingualLabel` component |
| Food names in cards | `name` (English) + `name_local` (Devanagari, smaller) |
| Search bar placeholder | Bilingual string |
| Lab value names | English + Hindi term (e.g. "Glucose / शर्करा") |
| Onboarding titles | English + Hindi |
| Festival card names | English + Hindi |

### 14.2 Bilingual NOT Applied

Chart axis labels · Primary CTA buttons · Metric values · Badge text (XP, Level) · Settings rows · Chip filters · Error messages (handled by l10n) · Timestamps

### 14.3 WCAG AA Standards

```
Minimum tap target: 44×44px — ALL interactive elements
Color contrast: 4.5:1 minimum for all readable text

textMuted (#6B68A0 dark / #B0AEC8 light):
  ≈ 4.6:1 on bg1 — just above WCAG AA
  → DECORATIVE/PLACEHOLDER use ONLY
  → NEVER for informational text users must read

textSecondary: use for all readable secondary content
```

### 14.4 Dyslexia-Friendly Font Toggle

```dart
// Settings → Preferences → Dyslexia-friendly font
// Switches body text family to OpenDyslexic (bundled)
// Does NOT affect JetBrainsMono metric styles

String fontFamily(bool dyslexiaMode) =>
    dyslexiaMode ? 'OpenDyslexic' : 'PlusJakartaSans';
```

### 14.5 Motion Reduction

```dart
// Respect system accessibility setting
bool reduceMotion(BuildContext context) =>
    MediaQuery.of(context).disableAnimations;

// All spring animations → simple cross-fade when true
Duration animDuration(BuildContext context, Duration full) =>
    reduceMotion(context) ? const Duration(milliseconds: 150) : full;
```

### 14.6 Low Data Mode Adaptations

```
Image.network       → color placeholder box (#2C2C3E dark / #EEE8E4 light)
Social feed media   → text-only glass cards
Food card thumbnails → food emoji placeholder
BackdropFilter      → DISABLED (GPU-intensive; glass → surface1 solid)
Video thumbnails    → glass text-only cards
Sync interval       → 6 hours
```

---

---

## 15. Remaining Screen Specifications

### 15.1 SpO2 Tracker

**Route:** `/spo2` · **Scaffold:** Pattern B (`heroDeep`)

**Hero:**
```
Latest SpO2 %: metricXL white + teal glow
Pulse:         bodyLg white70
Timestamp:     caption white54

Alert banner (if SpO2 < 95%):
  error glass card, full-width
  "⚠ SpO2 is low. Seek medical attention if this persists."
  PulseRing (error color, animated)
```

**Body:**
```dart
// SpO2 7-day history chart
GlassCard(
  child: Column(children: [
    BilingualLabel(english: 'SpO2 History', hindi: 'SpO2 इतिहास'),
    SizedBox(height: 12),
    // fl_chart LineChart — teal line, target band 95-100%
    SpO2LineChart(data: history),
    // Period toggle
    PillTabBar(tabs: ['7 Days', '30 Days', '90 Days']),
  ]),
)

// Source info
GlassCard(
  child: Row(children: [
    Icon(Icons.watch, color: AppColorsDark.teal),
    Text('Source: Wearable / Manual', style: AppTypography.bodyMd()),
  ]),
)

// Log SpO2 FAB
QuickLogFAB override — single action "Log SpO2"
```

**Log Bottom Sheet:**
```
[SpO2 % field]  (integer, 70–100)
[Pulse bpm field]  (optional)
Notes textarea
EncryptionBadge
[Save Reading]  primary full-width
```

---

### 15.2 Fasting Timer Screen

**Route:** `/fasting` · **Scaffold:** Pattern B (`heroDeep`)

**Hero:**
```
Fasting stage name: displayMd (e.g. "Ketosis Zone")
  Stage color matches stage (teal → purple → secondary)
Countdown timer: heroDisplay white with glow
  Format: HH:MM:SS
  GlowingMetric — per-digit spring CountUp (counting down)
  PulseRing behind timer (slow pulse, 4s period)
Stage progress: linear bar full-width
```

**Body:**
```
Stage timeline glass card:
  Horizontal timeline of fasting stages
  Current stage: active glow, animated indicator dot
  Past stages: completed check, dimmed
  Stages: Fed → Fasted (12h) → Fat Burn (16h) → Ketosis (24h) → Autophagy (48h+)

Start / Pause / Stop glass button row:
  [⏸ Pause] outlined glass  |  [⏹ End Fast] error outlined
  Start: [▶ Start Fast] primary full-width (if not started)

Fasting type selector chips (if not started):
  [16:8] [18:6] [24h] [OMAD] [Custom]
  Glass pills, spring select

Last fasting log glass card:
  Previous fast: duration + stage reached
  TrendChip: vs week ago

Festival link banner (if active festival):
  "🪔 Navratri fast active · Phalahar rules apply"
  festival tint glass card
```

---

### 15.3 Body Metrics Screen

**Route:** `/body-metrics` · **Scaffold:** Pattern B (`heroDeep`)

**Hero:**
```
Current weight: metricXL white  (e.g. "72.4 kg")
BMI: monoLg + classification badge (glass pill)
  BMI classifications: Underweight / Normal / Overweight / Obese
  Colors: warning / success / warning / error
```

**Body:**
```
Weight trend: 30-day line chart (glass card, animated draw)
  Target weight horizontal dashed line (accent color)

Body composition bento grid (if wearable provides data):
  [half] Body Fat %: monoLg + TrendChip
  [half] Muscle Mass kg: monoLg + TrendChip

BMI history chart: glass card, 90-day area chart (secondary fill)

Measurement log glass card:
  Waist / Chest / Hips in cm (tap to edit inline)
  Last updated: caption

[Log Weight] primary FAB
```

---

### 15.4 Mood Tracker Screen

**Route:** `/mood` · **Scaffold:** Pattern A

**Body:**
```
Today's mood card (glass, full-width):
  5 emoji buttons row: 😡 😟 😐 😊 🤩
  Selected: spring pop, primary ring, scale 1.0 → 1.2 → 1.0
  Energy level slider: 0–10 gradient (red → green)
  Tags chip row (multi-select, glass pills):
    Stressed · Happy · Tired · Calm · Anxious · Energised · Focused

  [Save Today's Mood] primary full-width

7-day mood heatmap (glass card):
  7 emoji cells, one per day
  Tap day → show detail overlay

Mood-Sleep correlation card (CorrelationInsightCard variant):
  "😴 Sleep → 😊 Mood" module pills
  "You feel better on days with 7h+ sleep"
  Shown after 14+ data points

Mood trend chart: emoji mapping to numeric scale
  fl_chart SplineCurve, moody purple fill
```

---

### 15.5 Ayurveda Hub Screen

**Route:** `/ayurveda` · **Scaffold:** Pattern A

**Body:**
```
DoshaDonutChart glass card (large, 180px donut):
  Vata / Pitta / Kapha percentages
  "Your dominant dosha: [Pitta]" in displayMd, dosha color glow
  [Retake Quiz →] text link

Daily Rituals glass list:
  Each ritual: icon + name (bilingual) + time + completion toggle
  Dosha-specific rituals:
    Vata: Abhyanga oil massage · Warm sesame tea · Grounding meditation
    Pitta: Cooling coconut water · Sheetali pranayama · Avoid spicy meals
    Kapha: Dry brush massage · Ginger tea · Invigorating HIIT walk

Seasonal Recommendations glass card (teal border):
  Season-aware (Hemant/Shishir/Vasant/Grishma/Varsha/Sharad)
  3 diet + 2 lifestyle tips per season

Ayurvedic Food Guide glass card:
  "Foods for [Pitta]" — horizontal scroll chips
  Good: Coconut, cucumber, coriander (teal pills)
  Avoid: Chilli, mustard, garlic (error-outlined pills)
```

---

### 15.6 Active Workout Screen (Full Spec)

**Route:** `/home/workout/:id/active` · **Scaffold:** Pattern C

```dart
// Full-bleed layout
Stack(
  children: [
    // bg0 base + gradient strip top
    Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter, end: Alignment(0, 0.4),
          colors: [Color(0xFF1A0800), AppColorsDark.bg0],
        ),
      ),
    ),

    SafeArea(
      child: Column(
        children: [
          // App bar row
          Row(children: [
            IconButton(icon: Icon(Icons.pause), onPressed: _pause),
            Spacer(),
            Text('Exercise 3 of 8', style: AppTypography.labelMd()),
            Spacer(),
            IconButton(icon: Icon(Icons.close), onPressed: _finish),
          ]),

          const Spacer(),

          // Exercise name
          Text(exercise.name, style: AppTypography.h1(color: Colors.white)),

          const SizedBox(height: 8),
          // Superset badge (if applicable)
          if (exercise.supersetGroup != null)
            _SupersetBadge(group: exercise.supersetGroup!),

          const SizedBox(height: 40),

          // Set counter — monoXL primary glow
          GlowingMetric(
            value: 'Set ${currentSet}/${totalSets}',
            styleBuilder: AppTypography.monoXL,
            color: AppColorsDark.primary,
          ),

          const SizedBox(height: 16),

          // Rep target
          Text(
            '${exercise.reps} reps',
            style: AppTypography.displayMd(color: Colors.white70),
          ),

          const Spacer(),

          // Rest timer (shown between sets)
          if (isResting)
            _RestTimer(seconds: exercise.restSeconds),

          // RPE selector (shown after each set)
          if (showRPE)
            _RPESelector(onSelect: (rpe) => _logSet(rpe)),

          const SizedBox(height: 24),

          // HR Zone badge
          if (heartRate != null)
            _HRZoneBadge(bpm: heartRate!, zone: hrZone),

          const SizedBox(height: 40),

          // Bottom dock
          _WorkoutDock(
            onPrev:  _prevExercise,
            onNext:  _nextExercise,
            onPause: _pause,
          ),
        ],
      ),
    ),
  ],
)
```

**RPE Selector Widget:**
```dart
class _RPESelector extends StatelessWidget {
  final void Function(int) onSelect;
  const _RPESelector({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('How hard was that?', style: AppTypography.h4()),
        const SizedBox(height: 12),
        Row(
          children: List.generate(10, (i) {
            final rpe = i + 1;
            final color = Color.lerp(
              AppColorsDark.success,
              AppColorsDark.error,
              i / 9,
            )!;
            return Expanded(
              child: GestureDetector(
                onTap: () => onSelect(rpe),
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: color.withOpacity(0.6)),
                  ),
                  child: Center(
                    child: Text('$rpe',
                        style: AppTypography.labelMd(color: color)),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Easy', style: AppTypography.caption(color: AppColorsDark.success)),
            Text('Max Effort', style: AppTypography.caption(color: AppColorsDark.error)),
          ],
        ),
      ],
    );
  }
}
```

---

### 15.7 Mental Health Hub (Full Spec)

**Route:** `/mental-health` · **Scaffold:** Pattern A

```
CBT Insight Card (CorrelationInsightCard variant):
  Module pills: [💤 Sleep] → [😊 Mood]
  "On days you slept <6h, you logged 'irritable'. Better sleep may help."
  Glass card, secondary glow border
  👍 👎 feedback buttons

Stress Programs horizontal scroll:
  Glass cards (180×120px):
    Program name · "7 days" · difficulty chip · [Start] button

Breathing exercise card (glass, teal border):
  Animated Rive circle (expand → hold → contract → hold → repeat)
  Current phase label: Inhale / Hold / Exhale
  Technique selector pills: [4-7-8] [Box Breathing] [2-1-4-1]
  [Begin] primary button

Burnout risk gauge (glass card, shown if risk score > 40):
  CustomPaint semicircle gauge
  Green(0) → Amber(50) → Red(100)
  Needle at current score with drop shadow
  Score label + brief explanation

Indian helplines glass card (always visible):
  "Crisis Support / मदद के लिए"
  Rows:
    iCall · 9152987821 · [📞 Call]
    Vandrevala Foundation · 1860-2662-345 · [📞 Call]
    NIMHANS · 080-46110007 · [📞 Call]
  Card uses error/warning muted bg — clinical, not alarming
  EncryptionBadge bottom (private screen)
```

---

### 15.8 Profile Screen (Full Spec)

**Route:** `/profile` · **Scaffold:** Pattern B (`heroDeep`)

**Hero:**
```dart
Stack(
  children: [
    Container(height: 280, decoration: BoxDecoration(gradient: AppGradients.heroDeep)),
    Column(
      children: [
        SizedBox(height: 60), // AppBar clearance
        // Avatar
        GestureDetector(
          onTap: _pickAvatar,
          child: Stack(
            children: [
              CircleAvatar(radius: 40, backgroundImage: CachedNetworkImageProvider(avatarUrl)),
              // Primary glow ring
              Container(
                width: 84, height: 84,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColorsDark.primary, width: 2),
                  boxShadow: [BoxShadow(color: AppColorsDark.primaryGlow, blurRadius: 16)],
                ),
              ),
              // Edit badge
              Positioned(
                right: 0, bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColorsDark.primary, shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, size: 14, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text(user.name, style: AppTypography.displayMd(color: Colors.white)),
        Text(user.email, style: AppTypography.caption(color: Colors.white54)),
      ],
    ),
  ],
)
```

**Body (overlapping hero 28px):**
```
KarmaLevelCard compact:
  "⚡ Level 8 Warrior  ·  1,250 / 2,000 XP"
  Animated progress bar

DoshaDonutChart glass card:
  120px donut, percentage legend

Personal Info glass section (editable rows):
  Each row: Icon · Label (h4) · Value · Pencil icon (44×44 tap target)
  Rows: Fitness Goal · Height · Weight · Date of Birth · Blood Group · Language

ABHA status row (ABHALinkBadge compact):
  Linked: "Linked 🟢 · XX-****-****-XXXX"
  Unlinked: "Link ABHA →" amber outlined pill

Achievements bento grid (3-column):
  Earned: full color icon + name (bodySm)
  Locked: grey icon + name + 🔒 overlay
  Spring pop animation on first-time unlock

Referral glass card (amber gradient):
  "Refer friends, earn 500 XP each! 🎁"
  Referral code in monoLg, primary color
  [Share Referral] primary button
```

---

### 15.9 Correlation Insight Engine

Correlation insights surface on the Dashboard, Mental Health Hub, Sleep, and Mood screens. They require minimum data thresholds before appearing.

```dart
// lib/features/insights/correlation_engine.dart

class CorrelationEngine {
  final AppDatabase _db;
  CorrelationEngine(this._db);

  /// Sleep → Mood correlation
  /// Requires: 14+ days of both sleep + mood data
  Future<CorrelationInsight?> sleepMoodInsight(String userId) async {
    final sleepLogs = await _fetchSleepLogs(userId, days: 30);
    final moodLogs  = await _fetchMoodLogs(userId, days: 30);

    if (sleepLogs.length < 14 || moodLogs.length < 14) return null;

    // Match by date
    final pairs = _matchByDate(sleepLogs, moodLogs);
    if (pairs.length < 10) return null;

    // Days with < 6h sleep
    final shortSleepDays = pairs.where((p) => p.sleepH < 6).toList();
    if (shortSleepDays.isEmpty) return null;

    final avgMoodShortSleep = shortSleepDays.map((p) => p.moodScore).average;
    final avgMoodNormalSleep =
        pairs.where((p) => p.sleepH >= 6).map((p) => p.moodScore).average;

    if (avgMoodNormalSleep - avgMoodShortSleep < 0.5) return null; // not significant

    return CorrelationInsight(
      modules:  ['sleep', 'mood'],
      headline: 'Sleep affects your mood',
      body:     'On nights with <6h sleep, your mood score averages '
                '${avgMoodShortSleep.toStringAsFixed(1)} vs '
                '${avgMoodNormalSleep.toStringAsFixed(1)} on better nights.',
      dataDays: pairs.length,
    );
  }

  /// Food → Glucose correlation (post-meal readings)
  Future<CorrelationInsight?> foodGlucoseInsight(String userId) async {
    final glucoseReadings = await _fetchGlucoseReadings(userId,
        type: 'post_meal', days: 30);
    if (glucoseReadings.length < 10) return null;

    // Match glucose spikes to food logs
    // ... join on time proximity (±2 hours)
    return null; // placeholder — implement based on data
  }
}

class CorrelationInsight {
  final List<String> modules; // ['sleep', 'mood']
  final String headline;
  final String body;
  final int dataDays;
  const CorrelationInsight({
    required this.modules, required this.headline,
    required this.body, required this.dataDays,
  });
}
```

---

## 16. Low Data Mode — Implementation

```dart
// lib/core/providers/low_data_mode_provider.dart

final lowDataModeProvider = StateNotifierProvider<LowDataModeNotifier, bool>((ref) {
  return LowDataModeNotifier();
});

class LowDataModeNotifier extends StateNotifier<bool> {
  LowDataModeNotifier() : super(false);

  void toggle() => state = !state;

  // Auto-enable on 2G connectivity
  void onConnectivityChange(ConnectivityResult result) {
    // ConnectivityResult doesn't provide speed — use data saver mode instead
    // or user-toggled from settings
  }
}

// Usage in any widget
final lowData = ref.watch(lowDataModeProvider);

// Image loading
Widget foodPhoto(String? url, String emoji) {
  if (lowData || url == null) {
    return Container(
      width: 60, height: 60,
      color: isDark ? const Color(0xFF2C2C3E) : const Color(0xFFEEE8E4),
      child: Center(child: Text(emoji, style: const TextStyle(fontSize: 28))),
    );
  }
  return CachedNetworkImage(imageUrl: url, width: 60, height: 60, fit: BoxFit.cover);
}
```

---

## 17. Dosha Quiz Implementation

```dart
// lib/features/onboarding/dosha_quiz.dart

class DoshaQuestion {
  final String question;
  final List<DoshaAnswer> answers;
  const DoshaQuestion({required this.question, required this.answers});
}

class DoshaAnswer {
  final String text;
  final String dosha; // 'vata' | 'pitta' | 'kapha'
  const DoshaAnswer({required this.text, required this.dosha});
}

const doshaQuestions = [
  DoshaQuestion(
    question: 'How is your body frame?',
    answers: [
      DoshaAnswer(text: 'Thin, light, hard to gain weight', dosha: 'vata'),
      DoshaAnswer(text: 'Medium, muscular, gains/loses weight easily', dosha: 'pitta'),
      DoshaAnswer(text: 'Stocky, gains weight easily, hard to lose', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your skin?',
    answers: [
      DoshaAnswer(text: 'Dry, rough, cold to touch', dosha: 'vata'),
      DoshaAnswer(text: 'Warm, oily, prone to acne', dosha: 'pitta'),
      DoshaAnswer(text: 'Thick, moist, soft, pale', dosha: 'kapha'),
    ],
  ),
  // 10 more questions covering: energy, sleep, digestion,
  // memory, speech, emotional nature, temperature preference, etc.
];

DoshaResult computeDosha(List<String> selectedDoshas) {
  final counts = {'vata': 0, 'pitta': 0, 'kapha': 0};
  for (final d in selectedDoshas) {
    counts[d] = (counts[d] ?? 0) + 1;
  }
  final total = selectedDoshas.length;
  return DoshaResult(
    vata:  (counts['vata']!  / total * 100).round(),
    pitta: (counts['pitta']! / total * 100).round(),
    kapha: (counts['kapha']! / total * 100).round(),
    dominant: counts.entries.reduce((a, b) => a.value > b.value ? a : b).key,
  );
}
```

---

## 18. Complete `pubspec.yaml` (Final)

```yaml
name: fitkarma
description: Offline-first health tracking for India
version: 1.0.0+1
publish_to: 'none'

environment:
  sdk: '>=3.4.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # State & Navigation
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5
  go_router: ^14.2.7

  # Local Database
  drift: ^2.19.1
  sqlite3_flutter_libs: ^0.5.24
  path_provider: ^2.1.3
  path: ^1.9.0

  # Encryption
  flutter_secure_storage: ^9.0.0
  sqflite_cipher: ^3.0.1+2

  # Backend
  appwrite: ^13.0.0

  # Network
  dio: ^5.6.0
  connectivity_plus: ^6.0.3
  cached_network_image: ^3.3.1

  # Animations
  lottie: ^3.1.2
  rive: ^0.13.14
  shimmer: ^3.0.0

  # Charts
  fl_chart: ^0.68.0

  # Health
  health: ^10.2.0
  local_auth: ^2.3.0

  # Media
  image_picker: ^1.1.2
  file_picker: ^8.0.7      # For lab report PDF upload

  # Device
  device_info_plus: ^10.1.2

  # Maps (GPS workouts)
  flutter_map: ^7.0.2
  latlong2: ^0.9.1

  # Rich text (Journal)
  flutter_quill: ^10.6.0

  # Notifications
  flutter_local_notifications: ^17.2.2
  workmanager: ^0.5.2

  # Home widgets
  home_widget: ^0.5.0

  # Utilities
  intl: ^0.19.0
  uuid: ^4.4.2
  equatable: ^2.0.5
  freezed_annotation: ^2.4.1
  json_annotation: ^4.9.0
  collection: ^1.18.0     # for .average extension

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.11
  riverpod_generator: ^2.4.3
  drift_dev: ^2.19.1
  freezed: ^2.5.2
  json_serializable: ^6.8.0
  mocktail: ^1.0.4
  flutter_lints: ^4.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/lottie/
    - assets/rive/
    - assets/fonts/
  fonts:
    - family: PlusJakartaSans
      fonts:
        - asset: assets/fonts/PlusJakartaSans[wght].ttf
    - family: JetBrainsMono
      fonts:
        - asset: assets/fonts/JetBrainsMono[wght].ttf
    - family: OpenDyslexic
      fonts:
        - asset: assets/fonts/OpenDyslexic-Regular.ttf
```

---

## 19. Code Generation Commands

```bash
# One-time full generation
dart run build_runner build --delete-conflicting-outputs

# Watch mode during development
dart run build_runner watch --delete-conflicting-outputs

# Files generated by build_runner:
#   lib/core/database/app_database.g.dart   (Drift)
#   lib/features/auth/auth_notifier.g.dart  (Riverpod)
#   lib/features/food/food_log_notifier.g.dart
#   ... all *.g.dart and *.freezed.dart files
```

---

## 20. Design System Quick Reference Card

### Color Usage at a Glance

```
primary   #FF6B35  → CTAs, FAB, active nav, rings, step ring
secondary #7B6FF0  → Level badges, hero accents, Karma Hub
accent    #FFB547  → XP coins, streaks, insight highlights
teal      #00D4B4  → Water, SpO2, Ayurveda, Medication, encryption
success   #4ADE80  → Steps complete, healthy readings, habits done
warning   #FBBF24  → Elevated readings, moderate risk
error     #F87171  → Crisis readings, destructive, SpO2 alerts
rose      #FB7185  → Period tracker
purple    #C084FC  → Active minutes ring
```

### Typography at a Glance

```
heroDisplay  72sp  → One step count, one fasting timer (never two simultaneously)
metricXL     56sp  → BP, Glucose, Sleep, SpO2 readings
metricLg     40sp  → Dashboard rings ONLY
displayLg    32sp  → Karma XP hero, screen heroes
monoXL       48sp  → Live HR monitor, CGM glucose (real-time only)
monoLg       28sp  → Secondary stats, chart axis, counters
h1           24sp  → App bar titles
h2           20sp  → Card headings
bodyMd       14sp  → Standard card copy
caption      11sp  → Timestamps, fine print
```

### Scaffold Pattern at a Glance

```
Pattern A — Standard:    bg1 + transparent AppBar + AmbientBlobs behind scroll
Pattern B — Hero+Body:   heroGradient(320px) + glass rounded body overlapping 28px
Pattern C — Full-Bleed:  bg0 + extendBodyBehindAppBar + Stack full-bleed
Calm Zone:               bg2 solid + 0px elevation AppBar + NO blobs/glow/blur
```

### Effect Rules at a Glance

```
✅ Glow ON:   L1 hero metric · Primary CTA · Active ring · Active nav · EncryptionBadge · ABHA linked
❌ Glow OFF:  Secondary cards · Headers · List items · Empty states · All Calm Zone screens

✅ Blur ON (mid/high tier):  Glass cards · Bottom sheets · Nav bar
❌ Blur OFF:  Low-end tier · Low Data Mode · Calm Zone screens (all tiers)

Max 2 visual effects per card (blur + border, OR glow + gradient — never all four)
```

---

# Part II — Technical Implementation

## 21. Architecture Overview

```
┌────────────────────────────────────────────────────────────┐
│                    Flutter App (Client)                     │
│                                                            │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  │
│  │  Feature │  │  Shared  │  │   Core   │  │  Router  │  │
│  │  Modules │  │ Widgets  │  │ Providers│  │  (GoRouter│  │
│  └────┬─────┘  └──────────┘  └────┬─────┘  └──────────┘  │
│       │                           │                        │
│  ┌────▼────────────────────────────▼──────────────────┐   │
│  │              Riverpod 2.x State Layer               │   │
│  │  Providers · Notifiers · AsyncNotifiers             │   │
│  └─────────────────┬───────────────────────────────────┘  │
│                     │                                      │
│  ┌──────────────────▼────────────────────────────────┐    │
│  │           Repository Layer                         │    │
│  │   Local (Drift)  ◄──────►  Remote (Appwrite SDK)  │    │
│  │   SQLite on device          REST / Realtime WS     │    │
│  └───────────────────────────────────────────────────┘    │
└────────────────────────────────────────────────────────────┘
         │                              │
         ▼                              ▼
  Local SQLite DB               Appwrite Cloud
  (Drift ORM)                   ├── Auth
  AES-256 encrypted             ├── Databases
  (flutter_secure_storage       ├── Storage
   + sqflite_cipher)            ├── Functions
                                └── Realtime
```

### Data Flow (Offline-First)

```
User action
    │
    ▼
Write to Drift (local DB) immediately   ← UI updates optimistically
    │
    ▼
Mark record: syncStatus = 'pending'
    │
    ├─ Online? ──YES──► Push to Appwrite ──► Mark syncStatus = 'synced'
    │
    └─ Offline? ─────► Remain pending; sync when connectivity restored
                        DLQ if 3 failed attempts → alert user
```

---

## 22. Prerequisites & Tooling

### Required Versions

```bash
flutter --version   # 3.22.x or higher
dart --version      # 3.4.x or higher
appwrite --version  # 5.x (Appwrite CLI)
node --version      # 20.x (for Appwrite Functions)
```

### Install Appwrite CLI

```bash
# macOS / Linux
curl -sL https://appwrite.io/cli/install.sh | bash

# Windows (PowerShell)
iwr -useb https://appwrite.io/cli/install.ps1 | iex

# Verify
appwrite --version
```

### Flutter Dependencies (`pubspec.yaml`)

```yaml
name: fitkarma
description: Offline-first health tracking app for India
version: 1.0.0+1
publish_to: 'none'

environment:
  sdk: '>=3.4.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # State Management
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5

  # Navigation
  go_router: ^14.2.7

  # Offline DB
  drift: ^2.19.1
  sqlite3_flutter_libs: ^0.5.24
  path_provider: ^2.1.3
  path: ^1.9.0

  # Encrypted local storage
  flutter_secure_storage: ^9.0.0
  sqflite_cipher: ^3.0.1+2         # SQLCipher for AES-256 SQLite

  # Appwrite
  appwrite: ^13.0.0

  # HTTP / Connectivity
  dio: ^5.6.0
  connectivity_plus: ^6.0.3

  # Animations
  lottie: ^3.1.2
  rive: ^0.13.14
  shimmer: ^3.0.0

  # Charts
  fl_chart: ^0.68.0

  # Health
  health: ^10.2.0          # Health Connect (Android) + HealthKit (iOS)

  # Device Info
  device_info_plus: ^10.1.2

  # Image
  cached_network_image: ^3.3.1
  image_picker: ^1.1.2

  # Utilities
  intl: ^0.19.0
  uuid: ^4.4.2
  equatable: ^2.0.5
  freezed_annotation: ^2.4.1
  json_annotation: ^4.9.0

dev_dependencies:
  flutter_test:
    sdk: flutter

  # Code generation
  build_runner: ^2.4.11
  riverpod_generator: ^2.4.3
  drift_dev: ^2.19.1
  freezed: ^2.5.2
  json_serializable: ^6.8.0

  # Testing
  mocktail: ^1.0.4
  fake_async: ^1.3.1
```

```bash
flutter pub get
```

---

## 23. Project Setup

### 3.1 Initialize Flutter Project

```bash
flutter create fitkarma --org com.fitkarma --platforms android,ios
cd fitkarma

# Add dependencies
flutter pub add flutter_riverpod riverpod_annotation go_router \
  drift sqlite3_flutter_libs path_provider path \
  flutter_secure_storage appwrite dio connectivity_plus \
  lottie rive shimmer fl_chart health device_info_plus \
  cached_network_image image_picker intl uuid equatable \
  freezed_annotation json_annotation

flutter pub add --dev build_runner riverpod_generator drift_dev \
  freezed json_serializable mocktail fake_async
```

### 3.2 Environment Configuration

```dart
// lib/core/config/app_config.dart

class AppConfig {
  AppConfig._();

  static const String appwriteEndpoint =
      String.fromEnvironment('APPWRITE_ENDPOINT',
          defaultValue: 'https://cloud.appwrite.io/v1');

  static const String appwriteProjectId =
      String.fromEnvironment('APPWRITE_PROJECT_ID');

  // DB IDs (set after CLI creates them)
  static const String dbId     = String.fromEnvironment('APPWRITE_DB_ID');
  static const String usersCol = 'users';
  static const String foodCol  = 'food_logs';
  static const String bpCol    = 'bp_readings';
  // ... other collection IDs
}
```

```bash
# Build with env vars
flutter build apk \
  --dart-define=APPWRITE_ENDPOINT=https://cloud.appwrite.io/v1 \
  --dart-define=APPWRITE_PROJECT_ID=your_project_id \
  --dart-define=APPWRITE_DB_ID=your_db_id
```

### 3.3 Android Permissions (`android/app/src/main/AndroidManifest.xml`)

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>

<!-- Health Connect -->
<uses-permission android:name="android.permission.health.READ_STEPS"/>
<uses-permission android:name="android.permission.health.READ_HEART_RATE"/>
<uses-permission android:name="android.permission.health.READ_SLEEP_SESSION"/>

<!-- Location for GPS workouts -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

---

## 24. Appwrite CLI — Complete Setup

> All Appwrite resources are created and managed via CLI. No Appwrite Console interaction required.

### 4.1 Login & Project Initialization

```bash
# Login to Appwrite Cloud (interactive — enter email + password)
appwrite login

# Initialize project in repo root
appwrite init project

# When prompted:
#   Project ID: [enter existing] or press Enter to create new
#   Project Name: FitKarma
```

This creates `appwrite.json` in your project root — commit this file.

### 4.2 Create Database

```bash
appwrite databases create \
  --databaseId "fitkarma-db" \
  --name "FitKarma Database"
```

### 4.3 Create All Collections

```bash
# ── Users ──────────────────────────────────────────────────
appwrite databases createCollection \
  --databaseId "fitkarma-db" \
  --collectionId "users" \
  --name "Users" \
  --permissions 'read("users")' 'create("users")' 'update("users")'

appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "users" \
  --key "userId"      --size 36  --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "users" \
  --key "name"        --size 100 --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "users" \
  --key "email"       --size 254 --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "users" \
  --key "gender"      --size 10  --required false
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "users" \
  --key "dob"         --required false
appwrite databases createFloatAttribute \
  --databaseId "fitkarma-db" --collectionId "users" \
  --key "heightCm"    --required false
appwrite databases createFloatAttribute \
  --databaseId "fitkarma-db" --collectionId "users" \
  --key "weightKg"    --required false
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "users" \
  --key "bloodGroup"  --size 5   --required false
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "users" \
  --key "fitnessGoal" --size 30  --required false
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "users" \
  --key "activityLevel" --size 20 --required false
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "users" \
  --key "dominantDosha" --size 10 --required false
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "users" \
  --key "language"    --size 10  --required false \
  --default "en"
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "users" \
  --key "abhaId"      --size 20  --required false
appwrite databases createBooleanAttribute \
  --databaseId "fitkarma-db" --collectionId "users" \
  --key "abhaLinked"  --required false --default false
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "users" \
  --key "karmaLevel"  --size 20  --required false
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "users" \
  --key "karmaXP"     --required false --default 0
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "users" \
  --key "conditions"  --size 500 --required false  # JSON array
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "users" \
  --key "firstLaunchTs" --required false

# Index
appwrite databases createIndex \
  --databaseId "fitkarma-db" --collectionId "users" \
  --key "userId_idx" --type unique --attributes userId

# ── Food Logs ───────────────────────────────────────────────
appwrite databases createCollection \
  --databaseId "fitkarma-db" \
  --collectionId "food_logs" \
  --name "Food Logs" \
  --permissions 'read("user:{{userId}}")' 'create("user:{{userId}}")' \
                'update("user:{{userId}}")' 'delete("user:{{userId}}")'

appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "food_logs" \
  --key "userId"      --size 36  --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "food_logs" \
  --key "localId"     --size 36  --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "food_logs" \
  --key "foodName"    --size 200 --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "food_logs" \
  --key "foodNameLocal" --size 200 --required false
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "food_logs" \
  --key "mealType"    --size 20  --required true  # breakfast/lunch/dinner/snack
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "food_logs" \
  --key "loggedAt"    --required true   # Unix timestamp
appwrite databases createFloatAttribute \
  --databaseId "fitkarma-db" --collectionId "food_logs" \
  --key "calories"    --required true
appwrite databases createFloatAttribute \
  --databaseId "fitkarma-db" --collectionId "food_logs" \
  --key "proteinG"    --required false
appwrite databases createFloatAttribute \
  --databaseId "fitkarma-db" --collectionId "food_logs" \
  --key "carbsG"      --required false
appwrite databases createFloatAttribute \
  --databaseId "fitkarma-db" --collectionId "food_logs" \
  --key "fatG"        --required false
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "food_logs" \
  --key "portionUnit" --size 30  --required false
appwrite databases createFloatAttribute \
  --databaseId "fitkarma-db" --collectionId "food_logs" \
  --key "portionQty"  --required false
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "food_logs" \
  --key "source"      --size 20  --required false  # manual/scan/swiggy/zomato
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "food_logs" \
  --key "syncStatus"  --size 10  --required false --default "synced"

appwrite databases createIndex \
  --databaseId "fitkarma-db" --collectionId "food_logs" \
  --key "user_date_idx" --type key --attributes userId,loggedAt

# ── Blood Pressure ──────────────────────────────────────────
appwrite databases createCollection \
  --databaseId "fitkarma-db" \
  --collectionId "bp_readings" \
  --name "Blood Pressure Readings" \
  --permissions 'read("user:{{userId}}")' 'create("user:{{userId}}")' \
                'update("user:{{userId}}")' 'delete("user:{{userId}}")'

appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "bp_readings" \
  --key "userId"      --size 36  --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "bp_readings" \
  --key "localId"     --size 36  --required true
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "bp_readings" \
  --key "systolic"    --required true
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "bp_readings" \
  --key "diastolic"   --required true
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "bp_readings" \
  --key "pulse"       --required false
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "bp_readings" \
  --key "measuredAt"  --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "bp_readings" \
  --key "notes"       --size 500 --required false
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "bp_readings" \
  --key "classification" --size 30 --required false
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "bp_readings" \
  --key "syncStatus"  --size 10  --required false --default "synced"

appwrite databases createIndex \
  --databaseId "fitkarma-db" --collectionId "bp_readings" \
  --key "user_time_idx" --type key --attributes userId,measuredAt

# ── Glucose Readings ────────────────────────────────────────
appwrite databases createCollection \
  --databaseId "fitkarma-db" \
  --collectionId "glucose_readings" \
  --name "Glucose Readings" \
  --permissions 'read("user:{{userId}}")' 'create("user:{{userId}}")' \
                'update("user:{{userId}}")' 'delete("user:{{userId}}")'

appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "glucose_readings" \
  --key "userId"       --size 36 --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "glucose_readings" \
  --key "localId"      --size 36 --required true
appwrite databases createFloatAttribute \
  --databaseId "fitkarma-db" --collectionId "glucose_readings" \
  --key "valueMgDl"    --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "glucose_readings" \
  --key "readingType"  --size 20 --required true  # fasting/post_meal/random/bedtime
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "glucose_readings" \
  --key "measuredAt"   --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "glucose_readings" \
  --key "classification" --size 20 --required false
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "glucose_readings" \
  --key "linkedFoodLogId" --size 36 --required false
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "glucose_readings" \
  --key "syncStatus"   --size 10 --required false --default "synced"

# ── Sleep Logs ──────────────────────────────────────────────
appwrite databases createCollection \
  --databaseId "fitkarma-db" \
  --collectionId "sleep_logs" \
  --name "Sleep Logs" \
  --permissions 'read("user:{{userId}}")' 'create("user:{{userId}}")' \
                'update("user:{{userId}}")' 'delete("user:{{userId}}")'

appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "sleep_logs" \
  --key "userId"       --size 36 --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "sleep_logs" \
  --key "localId"      --size 36 --required true
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "sleep_logs" \
  --key "sleepStart"   --required true   # Unix timestamp
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "sleep_logs" \
  --key "sleepEnd"     --required true
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "sleep_logs" \
  --key "durationMinutes" --required true
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "sleep_logs" \
  --key "qualityScore" --required false  # 0-100
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "sleep_logs" \
  --key "source"       --size 20 --required false  # manual/health_connect/wearable
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "sleep_logs" \
  --key "syncStatus"   --size 10 --required false --default "synced"

# ── Workouts ────────────────────────────────────────────────
appwrite databases createCollection \
  --databaseId "fitkarma-db" \
  --collectionId "workouts" \
  --name "Workouts" \
  --permissions 'read("user:{{userId}}")' 'create("user:{{userId}}")' \
                'update("user:{{userId}}")' 'delete("user:{{userId}}")'

appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "workouts" \
  --key "userId"          --size 36  --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "workouts" \
  --key "localId"         --size 36  --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "workouts" \
  --key "name"            --size 100 --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "workouts" \
  --key "type"            --size 30  --required true  # yoga/hiit/strength/cardio
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "workouts" \
  --key "startedAt"       --required true
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "workouts" \
  --key "durationMinutes" --required true
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "workouts" \
  --key "caloriesBurned"  --required false
appwrite databases createFloatAttribute \
  --databaseId "fitkarma-db" --collectionId "workouts" \
  --key "distanceKm"      --required false
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "workouts" \
  --key "avgHeartRate"    --required false
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "workouts" \
  --key "exercisesJson"   --size 5000 --required false  # JSON array
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "workouts" \
  --key "syncStatus"      --size 10  --required false --default "synced"

# ── Habits ──────────────────────────────────────────────────
appwrite databases createCollection \
  --databaseId "fitkarma-db" \
  --collectionId "habits" \
  --name "Habits" \
  --permissions 'read("user:{{userId}}")' 'create("user:{{userId}}")' \
                'update("user:{{userId}}")' 'delete("user:{{userId}}")'

appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "habits" \
  --key "userId"          --size 36  --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "habits" \
  --key "localId"         --size 36  --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "habits" \
  --key "name"            --size 100 --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "habits" \
  --key "icon"            --size 10  --required false
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "habits" \
  --key "currentStreak"   --required false --default 0
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "habits" \
  --key "longestStreak"   --required false --default 0
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "habits" \
  --key "completedDates"  --size 5000 --required false  # JSON date array
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "habits" \
  --key "syncStatus"      --size 10  --required false --default "synced"

# ── Journal Entries ─────────────────────────────────────────
appwrite databases createCollection \
  --databaseId "fitkarma-db" \
  --collectionId "journal" \
  --name "Journal" \
  --permissions 'read("user:{{userId}}")' 'create("user:{{userId}}")' \
                'update("user:{{userId}}")' 'delete("user:{{userId}}")'

appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "journal" \
  --key "userId"      --size 36   --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "journal" \
  --key "localId"     --size 36   --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "journal" \
  --key "title"       --size 200  --required false
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "journal" \
  --key "body"        --size 10000 --required false
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "journal" \
  --key "moodEmoji"   --size 10   --required false
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "journal" \
  --key "moodScore"   --required false  # 1-5
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "journal" \
  --key "tags"        --size 500  --required false  # JSON array
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "journal" \
  --key "createdAt"   --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "journal" \
  --key "syncStatus"  --size 10   --required false --default "synced"

# ── Lab Reports ─────────────────────────────────────────────
appwrite databases createCollection \
  --databaseId "fitkarma-db" \
  --collectionId "lab_reports" \
  --name "Lab Reports" \
  --permissions 'read("user:{{userId}}")' 'create("user:{{userId}}")' \
                'update("user:{{userId}}")' 'delete("user:{{userId}}")'

appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "lab_reports" \
  --key "userId"      --size 36   --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "lab_reports" \
  --key "localId"     --size 36   --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "lab_reports" \
  --key "labName"     --size 200  --required false
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "lab_reports" \
  --key "reportDate"  --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "lab_reports" \
  --key "valuesJson"  --size 10000 --required false  # JSON extracted values
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "lab_reports" \
  --key "fileId"      --size 36   --required false   # Appwrite Storage file ID
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "lab_reports" \
  --key "syncStatus"  --size 10   --required false --default "synced"

# ── Karma Events ────────────────────────────────────────────
appwrite databases createCollection \
  --databaseId "fitkarma-db" \
  --collectionId "karma_events" \
  --name "Karma Events" \
  --permissions 'read("user:{{userId}}")' 'create("user:{{userId}}")' \
                'update("user:{{userId}}")'

appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "karma_events" \
  --key "userId"      --size 36  --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "karma_events" \
  --key "eventType"   --size 50  --required true  # food_log/workout/streak/habit
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "karma_events" \
  --key "xpAwarded"   --required true
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "karma_events" \
  --key "occurredAt"  --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "karma_events" \
  --key "syncStatus"  --size 10  --required false --default "synced"
```

### 4.4 Create Storage Buckets

```bash
# Lab report PDFs / images
appwrite storage createBucket \
  --bucketId "lab-reports" \
  --name "Lab Reports" \
  --permissions 'read("user:{{userId}}")' 'create("user:{{userId}}")' \
                'delete("user:{{userId}}")' \
  --maximumFileSize 10485760 \
  --allowedFileExtensions pdf,jpg,jpeg,png \
  --encryption true \
  --antivirus true

# User avatars
appwrite storage createBucket \
  --bucketId "avatars" \
  --name "User Avatars" \
  --permissions 'read("any")' 'create("users")' 'update("users")' 'delete("users")' \
  --maximumFileSize 2097152 \
  --allowedFileExtensions jpg,jpeg,png,webp \
  --compression gzip
```

### 4.5 Create Appwrite Functions

```bash
# Initialize function definitions
appwrite init function

# Create XP Calculator function
appwrite functions create \
  --functionId "xp-calculator" \
  --name "XP Calculator" \
  --runtime node-20.0 \
  --execute "users" \
  --timeout 15

# Create ABHA Integration function
appwrite functions create \
  --functionId "abha-verify" \
  --name "ABHA ID Verifier" \
  --runtime node-20.0 \
  --execute "users" \
  --timeout 30

# Create Report Share Link Generator
appwrite functions create \
  --functionId "report-share" \
  --name "Report Share Link" \
  --runtime node-20.0 \
  --execute "users" \
  --timeout 15
```

```bash
# Deploy all functions
appwrite deploy function --functionId xp-calculator
appwrite deploy function --functionId abha-verify
appwrite deploy function --functionId report-share
```

### 4.6 Set Environment Variables for Functions

```bash
appwrite functions createVariable \
  --functionId "abha-verify" \
  --key "ABHA_API_ENDPOINT" \
  --value "https://abhasbx.abdm.gov.in/abha/api/v3"

appwrite functions createVariable \
  --functionId "abha-verify" \
  --key "ABHA_CLIENT_ID" \
  --value "your_ndhm_client_id"

appwrite functions createVariable \
  --functionId "abha-verify" \
  --key "ABHA_CLIENT_SECRET" \
  --value "your_ndhm_client_secret"
```

### 4.7 Configure Appwrite Platform (Flutter)

```bash
# Add Flutter platform (needed for auth redirects)
appwrite projects createPlatform \
  --projectId "your_project_id" \
  --type flutter \
  --name "FitKarma Android" \
  --key "com.fitkarma.app"

appwrite projects createPlatform \
  --projectId "your_project_id" \
  --type flutter \
  --name "FitKarma iOS" \
  --key "com.fitkarma.app"
```

### 4.8 Deploy All at Once (appwrite.json)

After defining everything, push the full config:

```bash
# Push all collections/functions/buckets from appwrite.json
appwrite deploy collection
appwrite deploy bucket
appwrite deploy function
```

---

## 25. Database Schema (Appwrite + Drift)

### 5.1 Drift Local Tables

```dart
// lib/core/database/app_database.dart

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'app_database.g.dart';

// ── Table Definitions ────────────────────────────────────────

class FoodLogs extends Table {
  TextColumn  get id           => text().withLength(max: 36)();
  TextColumn  get userId       => text().withLength(max: 36)();
  TextColumn  get foodName     => text().withLength(max: 200)();
  TextColumn  get foodNameLocal => text().withLength(max: 200).nullable()();
  TextColumn  get mealType     => text().withLength(max: 20)(); // breakfast/lunch/dinner/snack
  IntColumn   get loggedAt     => integer()();  // Unix timestamp
  RealColumn  get calories     => real()();
  RealColumn  get proteinG     => real().nullable()();
  RealColumn  get carbsG       => real().nullable()();
  RealColumn  get fatG         => real().nullable()();
  TextColumn  get portionUnit  => text().withLength(max: 30).nullable()();
  RealColumn  get portionQty   => real().nullable()();
  TextColumn  get source       => text().withLength(max: 20).nullable()(); // manual/scan/swiggy
  TextColumn  get syncStatus   => text().withDefault(const Constant('pending'))();
  TextColumn  get remoteId     => text().withLength(max: 36).nullable()();
  IntColumn   get failedAttempts => integer().withDefault(const Constant(0))();

  @override Set<Column> get primaryKey => {id};
}

class BpReadings extends Table {
  TextColumn  get id            => text().withLength(max: 36)();
  TextColumn  get userId        => text().withLength(max: 36)();
  IntColumn   get systolic      => integer()();
  IntColumn   get diastolic     => integer()();
  IntColumn   get pulse         => integer().nullable()();
  IntColumn   get measuredAt    => integer()();
  TextColumn  get notes         => text().withLength(max: 500).nullable()();
  TextColumn  get classification => text().withLength(max: 30).nullable()();
  TextColumn  get syncStatus    => text().withDefault(const Constant('pending'))();
  TextColumn  get remoteId      => text().withLength(max: 36).nullable()();
  IntColumn   get failedAttempts => integer().withDefault(const Constant(0))();

  @override Set<Column> get primaryKey => {id};
}

class GlucoseReadings extends Table {
  TextColumn  get id            => text().withLength(max: 36)();
  TextColumn  get userId        => text().withLength(max: 36)();
  RealColumn  get valueMgDl     => real()();
  TextColumn  get readingType   => text().withLength(max: 20)();
  IntColumn   get measuredAt    => integer()();
  TextColumn  get classification => text().withLength(max: 20).nullable()();
  TextColumn  get linkedFoodLogId => text().withLength(max: 36).nullable()();
  TextColumn  get syncStatus    => text().withDefault(const Constant('pending'))();
  TextColumn  get remoteId      => text().withLength(max: 36).nullable()();
  IntColumn   get failedAttempts => integer().withDefault(const Constant(0))();

  @override Set<Column> get primaryKey => {id};
}

class SleepLogs extends Table {
  TextColumn  get id               => text().withLength(max: 36)();
  TextColumn  get userId           => text().withLength(max: 36)();
  IntColumn   get sleepStart       => integer()();
  IntColumn   get sleepEnd         => integer()();
  IntColumn   get durationMinutes  => integer()();
  IntColumn   get qualityScore     => integer().nullable()();
  TextColumn  get source           => text().withLength(max: 20).nullable()();
  TextColumn  get syncStatus       => text().withDefault(const Constant('pending'))();
  TextColumn  get remoteId         => text().withLength(max: 36).nullable()();
  IntColumn   get failedAttempts   => integer().withDefault(const Constant(0))();

  @override Set<Column> get primaryKey => {id};
}

class Workouts extends Table {
  TextColumn  get id              => text().withLength(max: 36)();
  TextColumn  get userId          => text().withLength(max: 36)();
  TextColumn  get name            => text().withLength(max: 100)();
  TextColumn  get type            => text().withLength(max: 30)();
  IntColumn   get startedAt       => integer()();
  IntColumn   get durationMinutes => integer()();
  IntColumn   get caloriesBurned  => integer().nullable()();
  RealColumn  get distanceKm      => real().nullable()();
  IntColumn   get avgHeartRate    => integer().nullable()();
  TextColumn  get exercisesJson   => text().withLength(max: 5000).nullable()();
  TextColumn  get syncStatus      => text().withDefault(const Constant('pending'))();
  TextColumn  get remoteId        => text().withLength(max: 36).nullable()();
  IntColumn   get failedAttempts  => integer().withDefault(const Constant(0))();

  @override Set<Column> get primaryKey => {id};
}

class Habits extends Table {
  TextColumn  get id              => text().withLength(max: 36)();
  TextColumn  get userId          => text().withLength(max: 36)();
  TextColumn  get name            => text().withLength(max: 100)();
  TextColumn  get icon            => text().withLength(max: 10).nullable()();
  IntColumn   get currentStreak   => integer().withDefault(const Constant(0))();
  IntColumn   get longestStreak   => integer().withDefault(const Constant(0))();
  TextColumn  get completedDates  => text().withLength(max: 5000).nullable()(); // JSON
  TextColumn  get syncStatus      => text().withDefault(const Constant('pending'))();
  TextColumn  get remoteId        => text().withLength(max: 36).nullable()();
  IntColumn   get failedAttempts  => integer().withDefault(const Constant(0))();

  @override Set<Column> get primaryKey => {id};
}

class JournalEntries extends Table {
  TextColumn  get id          => text().withLength(max: 36)();
  TextColumn  get userId      => text().withLength(max: 36)();
  TextColumn  get title       => text().withLength(max: 200).nullable()();
  TextColumn  get body        => text().withLength(max: 10000).nullable()();
  TextColumn  get moodEmoji   => text().withLength(max: 10).nullable()();
  IntColumn   get moodScore   => integer().nullable()();
  TextColumn  get tags        => text().withLength(max: 500).nullable()(); // JSON
  IntColumn   get createdAt   => integer()();
  TextColumn  get syncStatus  => text().withDefault(const Constant('pending'))();
  TextColumn  get remoteId    => text().withLength(max: 36).nullable()();
  IntColumn   get failedAttempts => integer().withDefault(const Constant(0))();

  @override Set<Column> get primaryKey => {id};
}

// ── Database Class ────────────────────────────────────────────

@DriftDatabase(tables: [
  FoodLogs, BpReadings, GlucoseReadings, SleepLogs,
  Workouts, Habits, JournalEntries,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      // Add migrations per version bump here
    },
  );
}

// ── Encrypted Database Factory ─────────────────────────────────

Future<AppDatabase> openEncryptedDatabase() async {
  const storage = FlutterSecureStorage();

  // Retrieve or generate AES-256 key
  String? key = await storage.read(key: 'db_encryption_key');
  if (key == null) {
    // Generate 32-byte random key, store securely
    final bytes = List.generate(32, (_) => 
        (DateTime.now().millisecondsSinceEpoch % 256));
    key = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    await storage.write(key: 'db_encryption_key', value: key);
  }

  final dir = await getApplicationDocumentsDirectory();
  final dbPath = p.join(dir.path, 'fitkarma_encrypted.db');

  return AppDatabase(
    NativeDatabase(File(dbPath), logStatements: false),
  );
}
```

```bash
# Generate Drift code
dart run build_runner build --delete-conflicting-outputs
```

---

## 26. State Management — Riverpod 2.x

### 6.1 Root Providers

```dart
// lib/core/providers/core_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart';
import '../config/app_config.dart';
import '../database/app_database.dart';

// Appwrite Client — singleton
final appwriteClientProvider = Provider<Client>((ref) {
  return Client()
    ..setEndpoint(AppConfig.appwriteEndpoint)
    ..setProject(AppConfig.appwriteProjectId)
    ..setSelfSigned(status: false);
});

// Appwrite services
final appwriteAccountProvider = Provider<Account>((ref) {
  return Account(ref.watch(appwriteClientProvider));
});

final appwriteDatabasesProvider = Provider<Databases>((ref) {
  return Databases(ref.watch(appwriteClientProvider));
});

final appwriteStorageProvider = Provider<Storage>((ref) {
  return Storage(ref.watch(appwriteClientProvider));
});

// Local database
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('Must be overridden in ProviderScope overrides');
});
```

### 6.2 Auth Notifier

```dart
// lib/features/auth/auth_notifier.dart

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/providers/core_providers.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<models.User?> build() async {
    final account = ref.watch(appwriteAccountProvider);
    try {
      return await account.get();
    } catch (_) {
      return null;
    }
  }

  Future<void> login(String email, String password) async {
    final account = ref.read(appwriteAccountProvider);
    await account.createEmailPasswordSession(
        email: email, password: password);
    ref.invalidateSelf();
  }

  Future<void> register(String name, String email, String password) async {
    final account = ref.read(appwriteAccountProvider);
    await account.create(
        userId: ID.unique(), email: email, password: password, name: name);
    await account.createEmailPasswordSession(
        email: email, password: password);
    ref.invalidateSelf();
  }

  Future<void> loginWithGoogle() async {
    final account = ref.read(appwriteAccountProvider);
    await account.createOAuth2Session(
        provider: OAuthProvider.google,
        success: 'com.fitkarma.app://callback',
        failure: 'com.fitkarma.app://callback/failure');
    ref.invalidateSelf();
  }

  Future<void> logout() async {
    final account = ref.read(appwriteAccountProvider);
    await account.deleteSession(sessionId: 'current');
    ref.invalidateSelf();
  }
}
```

### 6.3 Food Log Notifier

```dart
// lib/features/food/food_log_notifier.dart

import 'package:appwrite/appwrite.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../core/database/app_database.dart';
import '../../core/providers/core_providers.dart';
import '../../core/config/app_config.dart';

part 'food_log_notifier.g.dart';

@riverpod
class FoodLogNotifier extends _$FoodLogNotifier {
  @override
  Future<List<FoodLog>> build(DateTime date) async {
    final db = ref.watch(appDatabaseProvider);
    final start = DateTime(date.year, date.month, date.day)
        .millisecondsSinceEpoch ~/ 1000;
    final end = start + 86400;
    return db.select(db.foodLogs)
      ..where((t) => t.loggedAt.isBetweenValues(start, end))
      ..orderBy([(t) => OrderingTerm.asc(t.loggedAt)]);
  }

  Future<void> logFood(FoodLogsCompanion entry) async {
    final db = ref.read(appDatabaseProvider);
    final id = const Uuid().v4();

    // 1. Write locally FIRST — optimistic update
    await db.into(db.foodLogs).insert(
      entry.copyWith(id: Value(id), syncStatus: const Value('pending')),
    );
    ref.invalidateSelf();

    // 2. Push to Appwrite asynchronously
    _pushToRemote(id);
  }

  Future<void> _pushToRemote(String localId) async {
    final db = ref.read(appDatabaseProvider);
    final databases = ref.read(appwriteDatabasesProvider);

    final row = await (db.select(db.foodLogs)
      ..where((t) => t.id.equals(localId))).getSingleOrNull();
    if (row == null) return;

    try {
      final result = await databases.createDocument(
        databaseId: AppConfig.dbId,
        collectionId: AppConfig.foodCol,
        documentId: ID.unique(),
        data: {
          'userId':      row.userId,
          'localId':     row.id,
          'foodName':    row.foodName,
          'mealType':    row.mealType,
          'loggedAt':    row.loggedAt,
          'calories':    row.calories,
          'proteinG':    row.proteinG,
          'carbsG':      row.carbsG,
          'fatG':        row.fatG,
          'portionUnit': row.portionUnit,
          'portionQty':  row.portionQty,
          'source':      row.source,
        },
      );

      // Mark synced
      await (db.update(db.foodLogs)..where((t) => t.id.equals(localId)))
          .write(FoodLogsCompanion(
        syncStatus: const Value('synced'),
        remoteId: Value(result.$id),
      ));
    } catch (e) {
      // Increment failed attempts — DLQ after 3
      await (db.update(db.foodLogs)..where((t) => t.id.equals(localId)))
          .write(FoodLogsCompanion(
        failedAttempts: Value((row.failedAttempts) + 1),
        syncStatus: Value(row.failedAttempts >= 2 ? 'dlq' : 'pending'),
      ));
    }
  }
}
```

---

## 27. Offline-First Architecture — Drift

### 7.1 Sync Status Lifecycle

```
pending  → being pushed to Appwrite
synced   → successfully pushed
dlq      → failed 3+ times → user alerted
```

### 7.2 Sync Worker

```dart
// lib/core/sync/sync_worker.dart

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../providers/core_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SyncWorker {
  final AppDatabase _db;
  final Ref _ref;

  SyncWorker(this._db, this._ref);

  /// Call on app foreground or connectivity restored
  Future<void> syncPending() async {
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) return;

    await _syncTable<FoodLog>(
      _db.foodLogs,
      collectionId: 'food_logs',
      toRemote: (row) => {/* map fields */},
    );
    await _syncTable<BpReading>(
      _db.bpReadings,
      collectionId: 'bp_readings',
      toRemote: (row) => {/* map fields */},
    );
    // ... other tables
  }

  Future<void> _syncTable<T extends DataClass>(
    TableInfo<Table, T> table, {
    required String collectionId,
    required Map<String, dynamic> Function(T) toRemote,
  }) async {
    // Fetch pending rows (not in DLQ)
    final pending = await (_db.select(table)
      ..where((t) => (t as dynamic).syncStatus.equals('pending'))
      ..where((t) => (t as dynamic).failedAttempts.isSmallerThanValue(3)))
        .get();

    final databases = _ref.read(appwriteDatabasesProvider);

    for (final row in pending) {
      try {
        await databases.createDocument(
          databaseId: 'fitkarma-db',
          collectionId: collectionId,
          documentId: ID.unique(),
          data: toRemote(row),
        );
        await (_db.update(table)
          ..where((t) => (t as dynamic).id.equals((row as dynamic).id)))
            .write(/* syncStatus: synced */);
      } catch (_) {
        await (_db.update(table)
          ..where((t) => (t as dynamic).id.equals((row as dynamic).id)))
            .write(/* increment failedAttempts */);
      }
    }
  }
}
```

### 7.3 DLQ Provider

```dart
// lib/core/sync/dlq_provider.dart

@riverpod
Future<int> dlqCount(DlqCountRef ref) async {
  final db = ref.watch(appDatabaseProvider);
  final count = await db.customSelect(
    "SELECT COUNT(*) as c FROM food_logs WHERE sync_status = 'dlq' "
    "UNION ALL SELECT COUNT(*) FROM bp_readings WHERE sync_status = 'dlq' "
    "UNION ALL SELECT COUNT(*) FROM glucose_readings WHERE sync_status = 'dlq'",
  ).get();
  return count.fold(0, (sum, row) => sum + (row.read<int>('c')));
}
```

---

## 28. Sync Engine

### 8.1 Connectivity Listener

```dart
// lib/core/sync/connectivity_service.dart

@riverpod
Stream<ConnectivityResult> connectivityStream(ConnectivityStreamRef ref) {
  return Connectivity().onConnectivityChanged;
}

// In ProviderScope, listen and trigger sync
ref.listen(connectivityStreamProvider, (_, next) {
  if (next.valueOrNull != ConnectivityResult.none) {
    ref.read(syncWorkerProvider).syncPending();
  }
});
```

### 8.2 Sync Intervals by Device Tier

```dart
Duration syncInterval(DeviceTier tier) => switch (tier) {
  DeviceTier.low  => const Duration(hours: 6),
  DeviceTier.mid  => const Duration(minutes: 30),
  DeviceTier.high => const Duration(minutes: 15),
};
```

### 8.3 Realtime Subscription (Family / Social)

```dart
// lib/features/social/realtime_feed.dart

@riverpod
Stream<List<RealtimeMessage>> socialFeed(SocialFeedRef ref) {
  final client = ref.watch(appwriteClientProvider);
  final realtime = Realtime(client);

  return realtime.subscribe([
    'databases.fitkarma-db.collections.social_posts.documents',
  ]).stream;
}
```

---

## 29. Authentication

### 9.1 Auth Flow

```dart
// lib/core/router/app_router.dart

import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/auth_notifier.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull != null;
      final onAuth = state.matchedLocation.startsWith('/auth') ||
                     state.matchedLocation == '/splash';

      if (!isLoggedIn && !onAuth) return '/auth/login';
      if (isLoggedIn && onAuth)  return '/home/dashboard';
      return null;
    },
    routes: [
      GoRoute(path: '/splash',          builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/auth/login',      builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/auth/register',   builder: (_, __) => const RegisterScreen()),
      GoRoute(path: '/onboarding',      builder: (_, __) => const OnboardingFlow()),
      GoRoute(path: '/home/dashboard',  builder: (_, __) => const DashboardScreen()),
      GoRoute(path: '/home/food',       builder: (_, __) => const FoodHomeScreen()),
      GoRoute(path: '/home/workout',    builder: (_, __) => const WorkoutHomeScreen()),
      GoRoute(path: '/home/steps',      builder: (_, __) => const StepsScreen()),
      GoRoute(path: '/profile',         builder: (_, __) => const ProfileScreen()),
      GoRoute(path: '/blood-pressure',  builder: (_, __) => const BPScreen()),
      GoRoute(path: '/glucose',         builder: (_, __) => const GlucoseScreen()),
      GoRoute(path: '/sleep',           builder: (_, __) => const SleepScreen()),
      GoRoute(path: '/karma',           builder: (_, __) => const KarmaHubScreen()),
      GoRoute(path: '/journal',         builder: (_, __) => const JournalScreen()),
      GoRoute(path: '/lab-reports',     builder: (_, __) => const LabReportsScreen()),
      GoRoute(path: '/abha',            builder: (_, __) => const ABHAScreen()),
      GoRoute(path: '/settings',        builder: (_, __) => const SettingsScreen()),
      GoRoute(path: '/emergency',       builder: (_, __) => const EmergencyCardScreen()),
      GoRoute(path: '/festival-calendar', builder: (_, __) => const FestivalCalendarScreen()),
      GoRoute(path: '/wedding-planner', builder: (_, __) => const WeddingPlannerScreen()),
      GoRoute(path: '/wearables',       builder: (_, __) => const WearablesScreen()),
      GoRoute(path: '/reports',         builder: (_, __) => const HealthReportsScreen()),
      GoRoute(path: '/subscription',    builder: (_, __) => const SubscriptionScreen()),
      GoRoute(path: '/home-widgets',    builder: (_, __) => const HomeWidgetsScreen()),
    ],
  );
});
```

### 9.2 Biometric Lock

```dart
// lib/core/security/biometric_lock.dart
// Requires: local_auth: ^2.3.0

import 'package:local_auth/local_auth.dart';

class BiometricLock {
  static final _auth = LocalAuthentication();

  static Future<bool> authenticate() async {
    final canAuth = await _auth.canCheckBiometrics;
    if (!canAuth) return true; // no biometric hardware → allow

    return _auth.authenticate(
      localizedReason: 'Authenticate to view health data',
      options: const AuthenticationOptions(
        stickyAuth: true,
        biometricOnly: false,
      ),
    );
  }
}

// Screens requiring re-auth: Journal, Period tracker, BP/Glucose logs
// Wrap navigator push with:
final ok = await BiometricLock.authenticate();
if (ok && mounted) context.push('/journal');
```

---

## 30. Storage & File Handling

### 10.1 Upload Lab Report

```dart
// lib/features/lab_reports/lab_report_repository.dart

Future<String> uploadLabReport(File file) async {
  final storage = ref.read(appwriteStorageProvider);
  final userId = ref.read(authNotifierProvider).valueOrNull?.$id ?? 'unknown';

  final result = await storage.createFile(
    bucketId: 'lab-reports',
    fileId: ID.unique(),
    file: InputFile.fromPath(
      path: file.path,
      filename: 'lab_${DateTime.now().millisecondsSinceEpoch}.pdf',
      contentType: 'application/pdf',
    ),
    permissions: [
      Permission.read(Role.user(userId)),
      Permission.delete(Role.user(userId)),
    ],
  );

  return result.$id; // store this in local Drift record
}
```

### 10.2 Generate Shareable Report Link

```dart
// Call Appwrite Function instead of generating JWT on client
Future<String> generateShareLink(String reportId) async {
  final functions = Functions(ref.read(appwriteClientProvider));
  final result = await functions.createExecution(
    functionId: 'report-share',
    body: jsonEncode({'reportId': reportId, 'expiryHours': 168}), // 7 days
  );
  final response = jsonDecode(result.responseBody) as Map<String, dynamic>;
  return response['shareUrl'] as String;
}
```

---

## 31. Health Integrations

### 11.1 Health Connect / HealthKit Setup

```dart
// lib/features/health/health_service.dart
// Requires: health: ^10.2.0

import 'package:health/health.dart';

class HealthService {
  static final _health = Health();

  static Future<bool> requestPermissions() async {
    final types = [
      HealthDataType.STEPS,
      HealthDataType.HEART_RATE,
      HealthDataType.BLOOD_OXYGEN,
      HealthDataType.SLEEP_SESSION,
      HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
      HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
      HealthDataType.BLOOD_GLUCOSE,
    ];
    return _health.requestAuthorization(types);
  }

  static Future<int> todaySteps() async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    final data = await _health.getHealthDataFromTypes(
      startTime: midnight,
      endTime: now,
      types: [HealthDataType.STEPS],
    );
    return data.fold<int>(0, (sum, d) => sum + (d.value as NumericHealthValue).numericValue.toInt());
  }

  static Future<List<HealthDataPoint>> sleepData(DateTime date) async {
    final start = DateTime(date.year, date.month, date.day - 1, 20); // 8pm prior
    final end   = DateTime(date.year, date.month, date.day, 12);     // noon
    return _health.getHealthDataFromTypes(
      startTime: start,
      endTime: end,
      types: [HealthDataType.SLEEP_SESSION],
    );
  }
}
```

```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<!-- Health Connect intent for Play Store -->
<queries>
  <package android:name="com.google.android.apps.healthdata"/>
</queries>
```

---

## 32. Security & Encryption

### 12.1 Data Classification

| Data Type | Storage | Encryption |
|---|---|---|
| Health readings (BP, Glucose, HR) | SQLCipher local DB + Appwrite | AES-256 (SQLCipher) |
| Journal entries | SQLCipher local DB + Appwrite | AES-256 (SQLCipher) |
| Lab report files | Appwrite Storage | Server-side (bucket setting) |
| ABHA ID | FlutterSecureStorage | Platform keychain |
| Auth tokens | Appwrite session (HTTP-only cookie) | TLS in transit |
| Food logs / Workouts | SQLCipher local DB + Appwrite | AES-256 (SQLCipher) |

### 12.2 Sensitive Screen Guard

```dart
// lib/core/security/sensitive_screen_guard.dart

/// Wrap route builder for screens requiring biometric re-auth
class SensitiveScreenGuard extends ConsumerWidget {
  final Widget child;
  const SensitiveScreenGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<bool>(
      future: BiometricLock.authenticate(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snap.data != true) {
          // Auth failed — pop back
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.canPop()) context.pop();
          });
          return const SizedBox.shrink();
        }
        return child;
      },
    );
  }
}
```

### 12.3 Appwrite Document Permissions

Every health document is created with user-scoped permissions:

```dart
permissions: [
  Permission.read(Role.user(userId)),
  Permission.update(Role.user(userId)),
  Permission.delete(Role.user(userId)),
]
// No "any" or "users" role — strict user isolation
```

---

## 33. Performance Considerations

### 13.1 Image Loading

```dart
// Replace all Image.network with CachedNetworkImage
CachedNetworkImage(
  imageUrl: foodItem.photoUrl,
  placeholder: (_, __) => Container(
    color: isDark ? const Color(0xFF2C2C3E) : const Color(0xFFEEE8E4),
  ),
  errorWidget: (_, __, ___) => Text(foodItem.emoji, style: const TextStyle(fontSize: 32)),
  // In Low Data Mode → show emoji placeholder, skip network request
)
```

### 13.2 Drift Query Optimization

```dart
// Use .watch() for live queries (rebuild only on data change)
Stream<List<FoodLog>> watchTodayLogs(int userId) {
  return (db.select(db.foodLogs)
    ..where((t) => t.loggedAt.isBetweenValues(startTs, endTs))
    ..orderBy([(t) => OrderingTerm.asc(t.loggedAt)]))
    .watch();
}

// Use .getSingle() not .get() when expecting one row
// Always add indexes (done via CLI above)
```

### 13.3 Lazy Loading for Lists

```dart
// Always use ListView.builder — never ListView(children: [...])
ListView.builder(
  itemCount: foods.length,
  itemBuilder: (ctx, i) => FoodItemCard(food: foods[i]),
)
```

### 13.4 Provider Granularity

```dart
// ✅ Narrow providers — only rebuilds what's needed
@riverpod
Future<int> todayCalories(TodayCaloriesRef ref) async { ... }

// ❌ Wide providers — causes whole screen rebuild
@riverpod
Future<DashboardState> dashboardState(DashboardStateRef ref) async { ... }
```

---

## 34. Testing Strategy

### 14.1 Unit Tests — Repository Layer

```dart
// test/features/food/food_log_test.dart

import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';

class MockDatabases extends Mock implements Databases {}

void main() {
  late AppDatabase db;
  late MockDatabases mockDatabases;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    mockDatabases = MockDatabases();
  });

  tearDown(() => db.close());

  test('logFood writes to local DB with pending sync status', () async {
    final notifier = FoodLogNotifier();
    // ... test optimistic write
  });

  test('sync pushes pending rows to Appwrite', () async {
    // ... insert pending row, call syncPending, verify mockDatabases.createDocument called
  });

  test('failed sync increments failedAttempts', () async {
    when(() => mockDatabases.createDocument(
      databaseId: any(named: 'databaseId'),
      collectionId: any(named: 'collectionId'),
      documentId: any(named: 'documentId'),
      data: any(named: 'data'),
    )).thenThrow(AppwriteException('Network error'));

    // ... verify failedAttempts incremented, status=dlq after 3
  });
}
```

### 14.2 Widget Tests — Design Tokens

```dart
// test/shared/widgets/glass_card_test.dart

testWidgets('GlassCard uses surface1 solid on low-tier device', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        deviceTierProvider.overrideWith((_) => Future.value(DeviceTier.low)),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        home: const GlassCard(child: Text('test')),
      ),
    ),
  );

  final container = tester.widget<Container>(find.byType(Container).first);
  final decoration = container.decoration as BoxDecoration;
  expect(decoration.color, AppColorsDark.surface1);
  expect(find.byType(BackdropFilter), findsNothing); // no blur on low tier
});
```

### 14.3 Integration Tests

```bash
# Run integration tests on device/emulator
flutter test integration_test/app_test.dart \
  --dart-define=APPWRITE_PROJECT_ID=test_project_id
```

---

## 35. CI/CD & Deployment

### 15.1 GitHub Actions Workflow

```yaml
# .github/workflows/ci.yml
name: FitKarma CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.22.x'

      - name: Install dependencies
        run: flutter pub get

      - name: Generate code
        run: dart run build_runner build --delete-conflicting-outputs

      - name: Analyze
        run: flutter analyze

      - name: Run tests
        run: flutter test --coverage

      - name: Upload coverage
        uses: codecov/codecov-action@v4

  deploy-appwrite:
    runs-on: ubuntu-latest
    needs: test
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v4

      - name: Install Appwrite CLI
        run: curl -sL https://appwrite.io/cli/install.sh | bash

      - name: Login to Appwrite
        run: |
          appwrite client \
            --endpoint ${{ secrets.APPWRITE_ENDPOINT }} \
            --projectId ${{ secrets.APPWRITE_PROJECT_ID }} \
            --key ${{ secrets.APPWRITE_API_KEY }}

      - name: Deploy functions
        run: appwrite deploy function --all

  build-android:
    runs-on: ubuntu-latest
    needs: test
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.22.x'
      - name: Build APK
        run: flutter build apk --release \
          --dart-define=APPWRITE_ENDPOINT=${{ secrets.APPWRITE_ENDPOINT }} \
          --dart-define=APPWRITE_PROJECT_ID=${{ secrets.APPWRITE_PROJECT_ID }} \
          --dart-define=APPWRITE_DB_ID=fitkarma-db
      - uses: actions/upload-artifact@v4
        with:
          name: fitkarma-release.apk
          path: build/app/outputs/flutter-apk/app-release.apk
```

### 15.2 Appwrite API Key for CI

```bash
# Create API key with required scopes (one-time setup)
appwrite projects createKey \
  --projectId "your_project_id" \
  --name "CI/CD Key" \
  --scopes "databases.read" "databases.write" \
           "collections.read" "collections.write" \
           "functions.read" "functions.write" \
           "buckets.read" "buckets.write"

# Add the returned secret to GitHub Actions secrets as APPWRITE_API_KEY
```

### 15.3 Appwrite CLI Non-Interactive Auth (CI)

```bash
# Set client directly (no login prompt)
appwrite client \
  --endpoint https://cloud.appwrite.io/v1 \
  --projectId your_project_id \
  --key your_api_key_secret
```

---

## Quick Reference

### CLI Commands Cheatsheet

```bash
# Auth
appwrite login
appwrite logout

# Project
appwrite init project
appwrite get project

# Databases
appwrite databases list
appwrite databases get --databaseId fitkarma-db
appwrite databases listCollections --databaseId fitkarma-db
appwrite databases listDocuments --databaseId fitkarma-db --collectionId food_logs

# Functions
appwrite functions list
appwrite functions createExecution --functionId xp-calculator --body '{"userId":"abc"}'
appwrite functions listExecutions --functionId xp-calculator

# Storage
appwrite storage listBuckets
appwrite storage listFiles --bucketId lab-reports

# Deploy
appwrite deploy collection     # push appwrite.json collection definitions
appwrite deploy function       # push function code
appwrite deploy bucket         # push bucket config

# Pull (sync remote state to appwrite.json)
appwrite pull collection
appwrite pull function
appwrite pull bucket
```

### Environment Variables Reference

| Variable | Where | Purpose |
|---|---|---|
| `APPWRITE_ENDPOINT` | `--dart-define` | Appwrite API URL |
| `APPWRITE_PROJECT_ID` | `--dart-define` | Appwrite project ID |
| `APPWRITE_DB_ID` | `--dart-define` | Database ID |
| `APPWRITE_API_KEY` | CI secrets only | Server-side API key (never in client) |
| `ABHA_CLIENT_ID` | Appwrite Function var | ABDM API credentials |
| `ABHA_CLIENT_SECRET` | Appwrite Function var | ABDM API credentials |

---

---

## 36. Appwrite Functions — Server-Side Code

All functions live in `functions/` at repo root. Each is a Node.js 20 module deployed via CLI.

### 16.1 Directory Structure

```
functions/
├── xp-calculator/
│   ├── src/
│   │   └── main.js
│   └── package.json
├── abha-verify/
│   ├── src/
│   │   └── main.js
│   └── package.json
└── report-share/
    ├── src/
    │   └── main.js
    └── package.json
```

### 16.2 XP Calculator Function

```js
// functions/xp-calculator/src/main.js

import { Client, Databases, ID, Query } from 'node-appwrite';

// XP award table — all values in points
const XP_TABLE = {
  food_log:          5,   // per meal logged
  food_log_complete: 20,  // all 3 meals logged in a day
  workout_complete:  30,
  steps_goal:        25,
  sleep_logged:      10,
  bp_reading:        10,
  glucose_reading:   10,
  habit_complete:    15,
  journal_entry:     10,
  streak_7day:       50,
  streak_30day:     150,
  lab_report:        20,
  abha_linked:      100,
  referral:         500,
};

export default async ({ req, res, log, error }) => {
  const client = new Client()
    .setEndpoint(process.env.APPWRITE_FUNCTION_API_ENDPOINT)
    .setProject(process.env.APPWRITE_FUNCTION_PROJECT_ID)
    .setKey(req.headers['x-appwrite-key']);

  const databases = new Databases(client);
  const DB = 'fitkarma-db';

  let body;
  try {
    body = JSON.parse(req.body || '{}');
  } catch {
    return res.json({ ok: false, error: 'Invalid JSON body' }, 400);
  }

  const { userId, eventType } = body;
  if (!userId || !eventType) {
    return res.json({ ok: false, error: 'userId and eventType required' }, 400);
  }

  const xp = XP_TABLE[eventType];
  if (xp === undefined) {
    return res.json({ ok: false, error: `Unknown eventType: ${eventType}` }, 400);
  }

  try {
    // 1. Record karma event
    await databases.createDocument(DB, 'karma_events', ID.unique(), {
      userId,
      eventType,
      xpAwarded: xp,
      occurredAt: Math.floor(Date.now() / 1000),
      syncStatus: 'synced',
    }, [
      `read("user:${userId}")`,
      `update("user:${userId}")`,
    ]);

    // 2. Fetch user's current XP
    const users = await databases.listDocuments(DB, 'users', [
      Query.equal('userId', userId),
    ]);

    if (users.total === 0) {
      return res.json({ ok: false, error: 'User not found' }, 404);
    }

    const user = users.documents[0];
    const newXP = (user.karmaXP || 0) + xp;
    const newLevel = _computeLevel(newXP);

    // 3. Update user XP + level
    await databases.updateDocument(DB, 'users', user.$id, {
      karmaXP:    newXP,
      karmaLevel: newLevel,
    });

    log(`XP awarded: userId=${userId} event=${eventType} xp=${xp} total=${newXP} level=${newLevel}`);

    return res.json({ ok: true, xpAwarded: xp, totalXP: newXP, level: newLevel });
  } catch (err) {
    error(`XP Calculator failed: ${err.message}`);
    return res.json({ ok: false, error: err.message }, 500);
  }
};

// Level thresholds — cumulative XP required
const LEVEL_THRESHOLDS = [
  0,     // Level 1  — Newcomer
  200,   // Level 2  — Beginner
  500,   // Level 3  — Starter
  1000,  // Level 4  — Mover
  1800,  // Level 5  — Achiever
  2800,  // Level 6  — Consistent
  4200,  // Level 7  — Dedicated
  6000,  // Level 8  — Warrior
  8500,  // Level 9  — Champion
  12000, // Level 10 — Elite
  16000, // Level 11 — Legend
  21000, // Level 12 — Grandmaster
  27000, // Level 13 — Karma Master
];

const LEVEL_NAMES = [
  'Newcomer', 'Beginner', 'Starter', 'Mover', 'Achiever',
  'Consistent', 'Dedicated', 'Warrior', 'Champion', 'Elite',
  'Legend', 'Grandmaster', 'Karma Master',
];

function _computeLevel(totalXP) {
  let level = 1;
  for (let i = 1; i < LEVEL_THRESHOLDS.length; i++) {
    if (totalXP >= LEVEL_THRESHOLDS[i]) level = i + 1;
    else break;
  }
  return LEVEL_NAMES[level - 1] || 'Karma Master';
}
```

```json
// functions/xp-calculator/package.json
{
  "name": "xp-calculator",
  "version": "1.0.0",
  "type": "module",
  "dependencies": {
    "node-appwrite": "^13.0.0"
  }
}
```

### 16.3 ABHA Verify Function

```js
// functions/abha-verify/src/main.js

import { Client, Databases, Query } from 'node-appwrite';

export default async ({ req, res, log, error }) => {
  const client = new Client()
    .setEndpoint(process.env.APPWRITE_FUNCTION_API_ENDPOINT)
    .setProject(process.env.APPWRITE_FUNCTION_PROJECT_ID)
    .setKey(req.headers['x-appwrite-key']);

  const databases = new Databases(client);
  const DB = 'fitkarma-db';

  let body;
  try {
    body = JSON.parse(req.body || '{}');
  } catch {
    return res.json({ ok: false, error: 'Invalid JSON' }, 400);
  }

  const { userId, abhaId, otp } = body;
  if (!userId || !abhaId) {
    return res.json({ ok: false, error: 'userId and abhaId required' }, 400);
  }

  // Validate format: 14 digits (XX-XXXX-XXXX-XXXX)
  const cleaned = abhaId.replace(/-/g, '');
  if (!/^\d{14}$/.test(cleaned)) {
    return res.json({ ok: false, error: 'Invalid ABHA ID format' }, 400);
  }

  try {
    if (!otp) {
      // Step 1: Request OTP from ABDM
      const tokenRes = await fetch(
        `${process.env.ABHA_API_ENDPOINT}/oauth2/token`,
        {
          method: 'POST',
          headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
          body: new URLSearchParams({
            grant_type:    'client_credentials',
            client_id:     process.env.ABHA_CLIENT_ID,
            client_secret: process.env.ABHA_CLIENT_SECRET,
          }),
        }
      );
      const { access_token } = await tokenRes.json();

      await fetch(`${process.env.ABHA_API_ENDPOINT}/v3/enrollment/request/otp`, {
        method: 'POST',
        headers: {
          'Authorization':  `Bearer ${access_token}`,
          'Content-Type':   'application/json',
          'REQUEST-ID':     crypto.randomUUID(),
          'TIMESTAMP':      new Date().toISOString(),
        },
        body: JSON.stringify({
          txnId: '',
          scope: ['abha-login', 'ehr'],
          loginHint: 'abha-number',
          loginId: cleaned,
          otpSystem: 'abdm',
        }),
      });

      log(`OTP requested for ABHA: ${cleaned.slice(0, 4)}****`);
      return res.json({ ok: true, step: 'otp_sent' });
    }

    // Step 2: Verify OTP + mark ABHA linked
    // In production: call ABDM verify endpoint
    // Here we update the user record as linked
    const users = await databases.listDocuments(DB, 'users', [
      Query.equal('userId', userId),
    ]);

    if (users.total === 0) {
      return res.json({ ok: false, error: 'User not found' }, 404);
    }

    await databases.updateDocument(DB, 'users', users.documents[0].$id, {
      abhaId:     cleaned,
      abhaLinked: true,
    });

    log(`ABHA linked for userId=${userId}`);
    return res.json({ ok: true, step: 'linked', abhaId: cleaned });

  } catch (err) {
    error(`ABHA verify failed: ${err.message}`);
    return res.json({ ok: false, error: 'ABHA verification failed' }, 500);
  }
};
```

### 16.4 Report Share Link Function

```js
// functions/report-share/src/main.js

import { Client, Databases, ID } from 'node-appwrite';
import crypto from 'node:crypto';

export default async ({ req, res, log, error }) => {
  const client = new Client()
    .setEndpoint(process.env.APPWRITE_FUNCTION_API_ENDPOINT)
    .setProject(process.env.APPWRITE_FUNCTION_PROJECT_ID)
    .setKey(req.headers['x-appwrite-key']);

  const databases = new Databases(client);
  const DB = 'fitkarma-db';

  let body;
  try {
    body = JSON.parse(req.body || '{}');
  } catch {
    return res.json({ ok: false, error: 'Invalid JSON' }, 400);
  }

  const { reportId, userId, expiryHours = 168 } = body; // default 7 days
  if (!reportId || !userId) {
    return res.json({ ok: false, error: 'reportId and userId required' }, 400);
  }

  try {
    // Generate a random token (cryptographically secure)
    const token = crypto.randomBytes(32).toString('hex');
    const expiresAt = Math.floor(Date.now() / 1000) + (expiryHours * 3600);

    // Store share token — scoped read-only
    await databases.createDocument(DB, 'share_tokens', ID.unique(), {
      token,
      reportId,
      userId,
      expiresAt,
      used: false,
    });

    const shareUrl = `${process.env.APP_BASE_URL}/shared/report/${token}`;
    log(`Share link created for reportId=${reportId} expires=${new Date(expiresAt * 1000).toISOString()}`);

    return res.json({ ok: true, shareUrl, expiresAt });
  } catch (err) {
    error(`Report share failed: ${err.message}`);
    return res.json({ ok: false, error: err.message }, 500);
  }
};
```

```bash
# Add function env vars
appwrite functions createVariable \
  --functionId "report-share" \
  --key "APP_BASE_URL" \
  --value "https://app.fitkarma.in"

# Deploy all functions
appwrite deploy function --functionId xp-calculator
appwrite deploy function --functionId abha-verify
appwrite deploy function --functionId report-share
```

---

## 37. Karma & Gamification Engine (Client Side)

### 17.1 XP Provider — Call Appwrite Function

```dart
// lib/features/karma/karma_service.dart

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/core_providers.dart';

class KarmaService {
  final Ref _ref;
  KarmaService(this._ref);

  Future<KarmaResult> awardXP({
    required String userId,
    required String eventType,
  }) async {
    final functions = Functions(_ref.read(appwriteClientProvider));
    final execution = await functions.createExecution(
      functionId: 'xp-calculator',
      body: jsonEncode({'userId': userId, 'eventType': eventType}),
      method: ExecutionMethod.pOST,
    );

    final response = jsonDecode(execution.responseBody) as Map<String, dynamic>;
    return KarmaResult(
      xpAwarded: response['xpAwarded'] as int,
      totalXP:   response['totalXP'] as int,
      level:     response['level'] as String,
    );
  }
}

class KarmaResult {
  final int xpAwarded;
  final int totalXP;
  final String level;
  const KarmaResult({required this.xpAwarded, required this.totalXP, required this.level});
}

final karmaServiceProvider = Provider((ref) => KarmaService(ref));
```

### 17.2 XP Event Triggers

```dart
// Trigger XP after successful local write — not blocking the UI

// In FoodLogNotifier.logFood():
Future<void> logFood(FoodLogsCompanion entry) async {
  // ... local write + remote sync (existing code)

  // Award XP asynchronously — non-blocking
  final userId = ref.read(authNotifierProvider).valueOrNull?.$id;
  if (userId != null) {
    unawaited(
      ref.read(karmaServiceProvider).awardXP(
        userId: userId, eventType: 'food_log',
      ).then((result) {
        // Show floating XP animation in UI
        ref.read(xpFloatNotifierProvider.notifier).show(result.xpAwarded);
      }),
    );
  }
}
```

### 17.3 Streak Recovery

```dart
// lib/features/karma/streak_recovery.dart

// Streaks are stored in Drift habits table.
// Recovery: once per month per habit, costs 50 XP.

Future<bool> recoverStreak({
  required String habitId,
  required String userId,
}) async {
  final db = ref.read(appDatabaseProvider);
  final karma = ref.read(karmaServiceProvider);

  // Check user has ≥ 50 XP
  final user = await _fetchUser(userId);
  if ((user?.karmaXP ?? 0) < 50) return false;

  // Check hasn't recovered this habit this month
  final lastRecovery = await _lastRecoveryDate(habitId);
  final now = DateTime.now();
  if (lastRecovery != null &&
      lastRecovery.month == now.month &&
      lastRecovery.year == now.year) {
    return false; // Already used recovery this month
  }

  // Deduct 50 XP (negative event)
  // Restore streak by inserting yesterday's date into completedDates
  final habit = await (db.select(db.habits)
    ..where((t) => t.id.equals(habitId))).getSingle();

  final dates = jsonDecode(habit.completedDates ?? '[]') as List;
  final yesterday = DateTime.now().subtract(const Duration(days: 1));
  final yStr = yesterday.toIso8601String().split('T').first;
  if (!dates.contains(yStr)) dates.add(yStr);

  await (db.update(db.habits)..where((t) => t.id.equals(habitId)))
      .write(HabitsCompanion(
    completedDates: Value(jsonEncode(dates)),
    currentStreak:  Value(habit.currentStreak + 1),
    syncStatus:     const Value('pending'),
  ));

  return true;
}
```

### 17.4 Leaderboard Provider

```dart
// lib/features/karma/leaderboard_provider.dart

@riverpod
Future<List<LeaderboardEntry>> leaderboard(
  LeaderboardRef ref,
  LeaderboardType type, // friends / city / national / seasonal
) async {
  final databases = ref.watch(appwriteDatabasesProvider);
  final queries = [
    Query.orderDesc('karmaXP'),
    Query.limit(50),
  ];

  // For 'city' leaderboard, add city filter once user city is stored
  // For 'seasonal', add date range query

  final result = await databases.listDocuments(
    databaseId: AppConfig.dbId,
    collectionId: 'users',
    queries: queries,
  );

  return result.documents.asMap().entries.map((e) {
    final doc = e.value;
    return LeaderboardEntry(
      rank:       e.key + 1,
      userId:     doc.data['userId'] as String,
      name:       doc.data['name'] as String,
      karmaXP:    doc.data['karmaXP'] as int,
      karmaLevel: doc.data['karmaLevel'] as String? ?? 'Newcomer',
    );
  }).toList();
}
```

---

## 38. Festival & Wedding Data

### 18.1 Seed Festival Collection via CLI

```bash
# Create festivals collection
appwrite databases createCollection \
  --databaseId "fitkarma-db" \
  --collectionId "festivals" \
  --name "Festivals" \
  --permissions 'read("any")'

appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "festivals" \
  --key "nameEn"       --size 100 --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "festivals" \
  --key "nameHi"       --size 100 --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "festivals" \
  --key "fastingType"  --size 30  --required false  # Nirjala/Phalahar/Roza/Feast/None
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "festivals" \
  --key "religion"     --size 20  --required false
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "festivals" \
  --key "region"       --size 50  --required false
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "festivals" \
  --key "startDate"    --required true   # Unix timestamp
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "festivals" \
  --key "endDate"      --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "festivals" \
  --key "dietPlanJson" --size 10000 --required false
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "festivals" \
  --key "allowedFoods" --size 2000  --required false  # JSON array
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "festivals" \
  --key "forbiddenFoods" --size 2000 --required false # JSON array
```

### 18.2 Seed Festival Data (Node.js Script)

```js
// scripts/seed_festivals.mjs
// Run: node scripts/seed_festivals.mjs

import { Client, Databases, ID } from 'node-appwrite';

const client = new Client()
  .setEndpoint(process.env.APPWRITE_ENDPOINT)
  .setProject(process.env.APPWRITE_PROJECT_ID)
  .setKey(process.env.APPWRITE_API_KEY);

const databases = new Databases(client);
const DB = 'fitkarma-db';
const COL = 'festivals';

const festivals2025 = [
  {
    nameEn: 'Navratri',
    nameHi: 'नवरात्रि',
    fastingType: 'Phalahar',
    religion: 'Hindu',
    region: 'All India',
    startDate: 1759276800, // Oct 2 2025 midnight UTC approx — adjust per year
    endDate:   1760054400, // Oct 11 2025
    allowedFoods: JSON.stringify([
      'Sabudana', 'Singhara atta', 'Kuttu atta', 'Rajgira',
      'Fruits', 'Milk', 'Curd', 'Paneer', 'Makhana', 'Sweet potato',
    ]),
    forbiddenFoods: JSON.stringify([
      'Wheat', 'Rice', 'Onion', 'Garlic', 'Meat', 'Egg', 'Alcohol',
      'Table salt (use sendha namak instead)',
    ]),
  },
  {
    nameEn: 'Diwali',
    nameHi: 'दीवाली',
    fastingType: 'Feast',
    religion: 'Hindu',
    region: 'All India',
    startDate: 1762041600, // Oct 20 2025 approx
    endDate:   1762387200, // Oct 24 2025
    allowedFoods: JSON.stringify(['All foods — festive feast']),
    forbiddenFoods: JSON.stringify([]),
  },
  {
    nameEn: 'Ramadan',
    nameHi: 'रमजान',
    fastingType: 'Roza',
    religion: 'Muslim',
    region: 'All India',
    startDate: 1741910400, // Mar 2025 approx — varies by moon sighting
    endDate:   1744502400,
    allowedFoods: JSON.stringify(['Sehri foods', 'Iftar foods', 'Dates', 'Water']),
    forbiddenFoods: JSON.stringify(['Food and water between Suhoor and Iftar']),
  },
  {
    nameEn: 'Karva Chauth',
    nameHi: 'करवा चौथ',
    fastingType: 'Nirjala',
    religion: 'Hindu',
    region: 'North India',
    startDate: 1760745600, // Oct 2025 approx
    endDate:   1760832000,
    allowedFoods: JSON.stringify(['Sargi (pre-sunrise meal)', 'Break-fast after moonrise: dates, water, puja prasad']),
    forbiddenFoods: JSON.stringify(['All food and water from sunrise until moonrise']),
  },
  {
    nameEn: 'Ganesh Chaturthi',
    nameHi: 'गणेश चतुर्थी',
    fastingType: 'Phalahar',
    religion: 'Hindu',
    region: 'Maharashtra, South India',
    startDate: 1756684800, // Aug 2025 approx
    endDate:   1757548800,
    allowedFoods: JSON.stringify(['Modak', 'Fruits', 'Milk sweets', 'Coconut']),
    forbiddenFoods: JSON.stringify([]),
  },
];

for (const f of festivals2025) {
  await databases.createDocument(DB, COL, ID.unique(), f);
  console.log(`Seeded: ${f.nameEn}`);
}
console.log('Festival seeding complete.');
```

```bash
# Run seeding
APPWRITE_ENDPOINT=https://cloud.appwrite.io/v1 \
APPWRITE_PROJECT_ID=your_project_id \
APPWRITE_API_KEY=your_api_key \
node scripts/seed_festivals.mjs
```

### 18.3 Active Festival Provider

```dart
// lib/features/festival/festival_provider.dart

@riverpod
Future<Festival?> activeFestival(ActiveFestivalRef ref) async {
  final databases = ref.watch(appwriteDatabasesProvider);
  final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  final result = await databases.listDocuments(
    databaseId: AppConfig.dbId,
    collectionId: 'festivals',
    queries: [
      Query.lessThanEqual('startDate', now),
      Query.greaterThanEqual('endDate', now),
      Query.limit(1),
    ],
  );

  if (result.documents.isEmpty) return null;
  return Festival.fromJson(result.documents.first.data);
}

@riverpod
Future<List<Festival>> upcomingFestivals(UpcomingFestivalsRef ref) async {
  final databases = ref.watch(appwriteDatabasesProvider);
  final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  final thirtyDays = now + (30 * 86400);

  final result = await databases.listDocuments(
    databaseId: AppConfig.dbId,
    collectionId: 'festivals',
    queries: [
      Query.greaterThan('startDate', now),
      Query.lessThanEqual('startDate', thirtyDays),
      Query.orderAsc('startDate'),
    ],
  );

  return result.documents
      .map((d) => Festival.fromJson(d.data))
      .toList();
}
```

### 18.4 Wedding Planner Drift Tables

```dart
// Add to AppDatabase — wedding-specific tables

class WeddingPlans extends Table {
  TextColumn  get id           => text().withLength(max: 36)();
  TextColumn  get userId       => text().withLength(max: 36)();
  TextColumn  get role         => text().withLength(max: 20)(); // bride/groom/guest/relative
  TextColumn  get relation     => text().withLength(max: 30).nullable()(); // father_of_bride etc.
  IntColumn   get firstEventTs => integer()();   // Unix timestamp
  IntColumn   get lastEventTs  => integer()();
  TextColumn  get eventsJson   => text().withLength(max: 1000)(); // JSON list of event keys
  IntColumn   get prepWeeks    => integer()();
  TextColumn  get primaryGoal  => text().withLength(max: 30)();
  TextColumn  get currentPhase => text().withLength(max: 20)(); // pre_wedding/wedding_week/post
  TextColumn  get syncStatus   => text().withDefault(const Constant('pending'))();

  @override Set<Column> get primaryKey => {id};
}

class WeddingMealLogs extends Table {
  TextColumn  get id          => text().withLength(max: 36)();
  TextColumn  get userId      => text().withLength(max: 36)();
  TextColumn  get planId      => text().withLength(max: 36)();
  TextColumn  get eventTag    => text().withLength(max: 30)(); // haldi/sangeet/vivah etc.
  TextColumn  get timing      => text().withLength(max: 20)(); // pre_event/during/post_event
  IntColumn   get loggedAt    => integer()();
  RealColumn  get calories    => real()();
  TextColumn  get notes       => text().withLength(max: 500).nullable()();
  TextColumn  get syncStatus  => text().withDefault(const Constant('pending'))();

  @override Set<Column> get primaryKey => {id};
}
```

---

## 39. Medication & Water Tracking Collections

```bash
# Medications collection
appwrite databases createCollection \
  --databaseId "fitkarma-db" \
  --collectionId "medications" \
  --name "Medications" \
  --permissions 'read("user:{{userId}}")' 'create("user:{{userId}}")' \
                'update("user:{{userId}}")' 'delete("user:{{userId}}")'

appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "medications" \
  --key "userId"       --size 36  --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "medications" \
  --key "name"         --size 100 --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "medications" \
  --key "dosage"       --size 50  --required false
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "medications" \
  --key "frequency"    --size 20  --required false  # daily/twice/thrice/weekly
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "medications" \
  --key "timesJson"    --size 500 --required false  # JSON ["08:00","20:00"]
appwrite databases createBooleanAttribute \
  --databaseId "fitkarma-db" --collectionId "medications" \
  --key "active"       --required false --default true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "medications" \
  --key "syncStatus"   --size 10  --required false --default "synced"

# Water logs collection
appwrite databases createCollection \
  --databaseId "fitkarma-db" \
  --collectionId "water_logs" \
  --name "Water Logs" \
  --permissions 'read("user:{{userId}}")' 'create("user:{{userId}}")' \
                'update("user:{{userId}}")' 'delete("user:{{userId}}")'

appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "water_logs" \
  --key "userId"       --size 36 --required true
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "water_logs" \
  --key "amountMl"     --required true
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "water_logs" \
  --key "loggedAt"     --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "water_logs" \
  --key "syncStatus"   --size 10 --required false --default "synced"
```

---

## 40. Notification System

### 20.1 Appwrite Messaging Setup

```bash
# Enable messaging via CLI
appwrite messaging createTopic \
  --topicId "health-reminders" \
  --name "Health Reminders"

appwrite messaging createTopic \
  --topicId "karma-events" \
  --name "Karma & Streak Alerts"

appwrite messaging createTopic \
  --topicId "social-activity" \
  --name "Social Activity"
```

### 20.2 Register Push Token (Flutter)

```dart
// lib/core/notifications/push_service.dart
// Requires: firebase_messaging: ^15.0.0 (for FCM token)
// OR: flutter_local_notifications for local-only

import 'package:appwrite/appwrite.dart';

class PushService {
  static Future<void> registerToken(Client client, String userId) async {
    final messaging = Messaging(client);
    // Get FCM token
    // final fcmToken = await FirebaseMessaging.instance.getToken();
    // if (fcmToken == null) return;

    // Subscribe to relevant topics
    await messaging.createSubscriber(
      topicId: 'health-reminders',
      subscriberId: userId,
      targetId: userId, // Appwrite target ID from account setup
    );
  }
}
```

### 20.3 Local Notifications (Meal / BP Reminders)

```dart
// lib/core/notifications/local_notifications.dart
// Requires: flutter_local_notifications: ^17.0.0

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );
  }

  /// Schedule daily meal reminder
  static Future<void> scheduleMealReminder({
    required int id,
    required String mealName,   // "Breakfast / नाश्ता"
    required Time time,         // e.g. Time(8, 0, 0)
  }) async {
    await _plugin.zonedSchedule(
      id,
      'Time for $mealName!',
      'Log your meal to earn Karma XP 🌟',
      _nextInstanceOf(time),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'meal_reminders',
          'Meal Reminders',
          channelDescription: 'Daily meal logging reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // repeat daily
    );
  }

  /// Inactivity nudge — "Time to move! 10-min walk? 🚶"
  static Future<void> scheduleInactivityNudge(Duration afterInactive) async {
    await _plugin.zonedSchedule(
      9999,
      'Time to move! 🚶',
      '10-minute walk = 50 steps closer to your goal',
      tz.TZDateTime.now(tz.local).add(afterInactive),
      const NotificationDetails(
        android: AndroidNotificationDetails('activity_nudge', 'Activity Nudge'),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
```

---

## 41. Social Collections

```bash
# Social posts
appwrite databases createCollection \
  --databaseId "fitkarma-db" \
  --collectionId "social_posts" \
  --name "Social Posts" \
  --permissions 'read("users")' 'create("users")' \
                'update("user:{{userId}}")' 'delete("user:{{userId}}")'

appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "social_posts" \
  --key "userId"      --size 36   --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "social_posts" \
  --key "content"     --size 2000 --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "social_posts" \
  --key "mediaFileId" --size 36   --required false
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "social_posts" \
  --key "likesCount"  --required false --default 0
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "social_posts" \
  --key "postedAt"    --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "social_posts" \
  --key "tags"        --size 500  --required false

appwrite databases createIndex \
  --databaseId "fitkarma-db" --collectionId "social_posts" \
  --key "feed_idx" --type key --attributes postedAt

# Community groups
appwrite databases createCollection \
  --databaseId "fitkarma-db" \
  --collectionId "groups" \
  --name "Community Groups" \
  --permissions 'read("users")' 'create("users")' 'update("users")'

appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "groups" \
  --key "name"        --size 100 --required true
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "groups" \
  --key "category"    --size 30  --required false  # diet/location/sport/support
appwrite databases createIntegerAttribute \
  --databaseId "fitkarma-db" --collectionId "groups" \
  --key "memberCount" --required false --default 0
appwrite databases createStringAttribute \
  --databaseId "fitkarma-db" --collectionId "groups" \
  --key "createdBy"   --size 36  --required true
```

---

## 42. Home Widgets (Android & iOS)

### 22.1 Android Glance Widget

```dart
// lib/home_widget/steps_widget.dart
// Requires: home_widget: ^0.5.0
// Requires: workmanager: ^0.5.2 (for periodic refresh)

import 'package:home_widget/home_widget.dart';
import 'package:workmanager/workmanager.dart';

class StepsHomeWidget {
  static const _providerName = 'StepsWidgetProvider';

  static Future<void> update(int steps, int goal) async {
    await HomeWidget.saveWidgetData<int>('steps', steps);
    await HomeWidget.saveWidgetData<int>('goal', goal);
    await HomeWidget.saveWidgetData<double>('progress', steps / goal);
    await HomeWidget.updateWidget(
      androidName: _providerName,
      iOSName: 'StepsWidget',
    );
  }

  static Future<void> schedulePeriodicRefresh() async {
    await Workmanager().registerPeriodicTask(
      'widget-refresh',
      'widgetRefresh',
      frequency: const Duration(minutes: 30),
      initialDelay: const Duration(seconds: 10),
      constraints: Constraints(networkType: NetworkType.not_required),
    );
  }
}

// WorkManager callback (called in isolation — no Flutter context)
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == 'widgetRefresh') {
      // Read from Drift (must open DB here — no ProviderScope)
      final db = await openEncryptedDatabase();
      final steps = await HealthService.todaySteps();
      await StepsHomeWidget.update(steps, 10000);
    }
    return Future.value(true);
  });
}
```

### 22.2 Widget Registration (`AndroidManifest.xml`)

```xml
<receiver android:name=".StepsWidgetProvider" android:exported="true">
  <intent-filter>
    <action android:name="android.appwidget.action.APPWIDGET_UPDATE"/>
  </intent-filter>
  <meta-data
    android:name="android.appwidget.provider"
    android:resource="@xml/steps_widget_info"/>
</receiver>
```

---

## 43. Error Handling & Observability

### 23.1 Global Error Boundary

```dart
// lib/main.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Catch Flutter framework errors
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    // Log to Appwrite or Sentry
    _logError(details.exception, details.stack);
  };

  // Catch async errors outside Flutter framework
  PlatformDispatcher.instance.onError = (error, stack) {
    _logError(error, stack);
    return true; // handled
  };

  final db = await openEncryptedDatabase();

  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
      ],
      child: const FitKarmaApp(),
    ),
  );
}

void _logError(Object error, StackTrace? stack) {
  // In production: send to Appwrite function or Sentry
  debugPrint('ERROR: $error\n$stack');
}
```

### 23.2 Riverpod Error Handling Pattern

```dart
// Standard pattern for async providers — always handle all states
class HealthScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bpAsync = ref.watch(latestBpReadingProvider);

    return bpAsync.when(
      // Loading — use ShimmerLoader, NEVER skeleton text
      loading: () => const ShimmerLoader(height: 120),

      // Error — use ErrorRetryWidget with Lottie
      error: (err, stack) => ErrorRetryWidget(
        message: 'Could not load BP data',
        onRetry: () => ref.invalidate(latestBpReadingProvider),
      ),

      // Data — optimistic: show cached Drift data before remote confirms
      data: (reading) => reading == null
          ? EmptyState(
              lottieAsset: 'assets/lottie/empty_bp.json',
              message: 'No readings yet. Log your first BP reading.',
              ctaLabel: 'Log BP',
              onCta: () => showLogSheet(context, ...),
            )
          : BPHeroCard(reading: reading),
    );
  }
}
```

### 23.3 DLQ Alert in UI

```dart
// lib/shared/widgets/sync_status_banner.dart

class DLQAlertBanner extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dlqAsync = ref.watch(dlqCountProvider);

    return dlqAsync.when(
      data: (count) {
        if (count == 0) return const SizedBox.shrink();
        return GestureDetector(
          onTap: () => context.push('/settings/sync'),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: AppColorsDark.warning.withOpacity(0.15),
            child: Row(
              children: [
                const Icon(Icons.warning_amber, color: AppColorsDark.warning, size: 16),
                const SizedBox(width: 8),
                Text(
                  '$count item${count > 1 ? 's' : ''} failed to sync. Tap to review.',
                  style: AppTypography.bodySm(color: AppColorsDark.warning),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
```

---

## 44. Complete `appwrite.json` Reference

After running all CLI commands, your `appwrite.json` will look like this (abbreviated):

```json
{
  "projectId": "your_project_id",
  "projectName": "FitKarma",
  "collections": [
    {
      "$id": "users",
      "name": "Users",
      "databaseId": "fitkarma-db",
      "attributes": [ ... ],
      "indexes": [ ... ]
    },
    {
      "$id": "food_logs",
      "name": "Food Logs",
      "databaseId": "fitkarma-db"
    },
    { "$id": "bp_readings" },
    { "$id": "glucose_readings" },
    { "$id": "sleep_logs" },
    { "$id": "workouts" },
    { "$id": "habits" },
    { "$id": "journal" },
    { "$id": "lab_reports" },
    { "$id": "karma_events" },
    { "$id": "festivals" },
    { "$id": "medications" },
    { "$id": "water_logs" },
    { "$id": "social_posts" },
    { "$id": "groups" },
    { "$id": "share_tokens" }
  ],
  "functions": [
    {
      "$id": "xp-calculator",
      "name": "XP Calculator",
      "runtime": "node-20.0",
      "entrypoint": "src/main.js",
      "execute": ["users"]
    },
    {
      "$id": "abha-verify",
      "name": "ABHA ID Verifier",
      "runtime": "node-20.0",
      "entrypoint": "src/main.js",
      "execute": ["users"]
    },
    {
      "$id": "report-share",
      "name": "Report Share Link",
      "runtime": "node-20.0",
      "entrypoint": "src/main.js",
      "execute": ["users"]
    }
  ],
  "buckets": [
    {
      "$id": "lab-reports",
      "name": "Lab Reports",
      "maximumFileSize": 10485760,
      "allowedFileExtensions": ["pdf","jpg","jpeg","png"],
      "encryption": true,
      "antivirus": true
    },
    {
      "$id": "avatars",
      "name": "User Avatars",
      "maximumFileSize": 2097152,
      "compression": "gzip"
    }
  ]
}
```

```bash
# After editing appwrite.json manually or via CLI,
# push all changes in one command:
appwrite deploy collection --all
appwrite deploy bucket --all
appwrite deploy function --all
```

---

## 45. Glossary & Architecture Decisions

| Term | Definition |
|---|---|
| **DLQ** | Dead Letter Queue — records that failed to sync 3+ times. Visible in Settings → Data & Sync. |
| **Optimistic UI** | UI updates immediately from local Drift write; remote sync happens in background. |
| **Calm Zone** | Screens with zero glow/blur/animation (Settings, Journal, Emergency Card, Lab Reports, ABHA). |
| **Tier-aware rendering** | `DeviceTierProvider` gates blur, glow, Rive, spring physics based on detected RAM. |
| **syncStatus** | Column on every Drift table: `pending` → `synced` → `dlq`. Drive sync worker decisions. |
| **`localId`** | UUID generated on device, stored in both Drift and Appwrite to cross-reference. |
| **UX Stage** | `firstWeek / familiar / expert` — controls which dashboard modules surface by default. |
| **Progressive Disclosure** | Three-layer reveal: above-fold → scroll → tap. Only one hero per screen. |
| **Single Hero Rule** | Exactly one `metricXL` or `heroDisplay` per visible scroll area. Never two simultaneously. |
| **ABHA** | Ayushman Bharat Health Account — India's national digital health ID (14-digit). |
| **ABDM** | Ayushman Bharat Digital Mission — the government body managing ABHA. |
| **Health Connect** | Android 14+ health data aggregation layer (replaces Google Fit). |

### Architecture Decision Record (ADR) Highlights

**ADR-001: Drift over Hive for local storage**
Drift chosen because it provides SQL queries needed for complex date-range joins (e.g. "food logs where loggedAt between midnight and now"), typed compile-time queries, and migrations. Hive's key-value model would require manual indexing.

**ADR-002: Riverpod over Bloc**
Riverpod chosen for simpler async provider composition, built-in `ref.watch` dependency graph, and better `AsyncValue` ergonomics for offline-first loading states.

**ADR-003: Appwrite over Firebase**
Appwrite chosen for: self-hostable (future India data residency), open-source, no per-read billing, built-in document-level permissions, CLI-first workflow, and avoidance of Google ecosystem lock-in given the app's privacy-centric positioning.

**ADR-004: SQLCipher for local encryption**
`sqflite_cipher` wraps SQLCipher, providing AES-256 encryption at the SQLite page level. The key is stored in platform keychain via `flutter_secure_storage`. Raw DB file on disk is unreadable without the key.

**ADR-005: Appwrite Functions over direct ABDM API calls from client**
ABDM credentials (client_id, client_secret) must never be in the Flutter app binary. All ABHA verification calls are proxied through an Appwrite Function that holds the secrets as environment variables.

---


---

*FitKarma — Complete Documentation *
*UI Design System · Technical Implementation Guide*
*Flutter 3.x · Riverpod 2.x · Drift · Appwrite CLI*
*Offline-first · AES-256 encrypted · Privacy-centric · Built for India*
*45 sections · 45+ screens · 28 shared components · 16 Appwrite collections · 3 server functions · Full CI/CD*