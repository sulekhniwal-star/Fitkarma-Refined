# FitKarma — Modern UI Design System
## Next-Gen Design Language · 45+ Screens

> **Offline-First · Privacy-Centric · Built for India**
> Flutter 3.x · Riverpod 2.x · Drift · Appwrite
>
> **Design** — Complete visual overhaul. Glassmorphism surfaces, bento-grid layouts, fluid spring animations, variable-weight typography, spatial depth layers, micro-interactions on every interactive element. Dark mode is the primary design target.

---

## Table of Contents

1. [Design Philosophy](#1-design-philosophy)
2. [Visual Language & Tokens](#2-visual-language--tokens)
3. [Typography System](#3-typography-system)
4. [Motion & Animation](#4-motion--animation)
5. [Surface & Depth System](#5-surface--depth-system)
6. [Universal Screen Rules](#6-universal-screen-rules)
7. [Scaffold Patterns](#7-scaffold-patterns)
8. [Shared Component Library](#8-shared-component-library)
9. [Screen-by-Screen UI Specifications](#9-screen-by-screen-ui-specifications)
   - [Onboarding & Auth](#91-onboarding--auth-screens)
   - [Core Dashboard & Karma](#92-core-dashboard--karma)
   - [Food & Nutrition](#93-food--nutrition-screens)
   - [Workout](#94-workout-screens)
   - [Steps & Activity](#95-steps--activity)
   - [Health Monitoring](#96-health-monitoring-screens)
   - [Lab Reports & ABHA](#97-lab-reports--abha-screens)
   - [Lifestyle Trackers](#98-lifestyle-tracker-screens)
   - [Wellness](#99-wellness-screens)
   - [Social & Community](#910-social--community-screens)
   - [Reports & Wearables](#911-reports--wearables)
   - [Family & Emergency](#912-family--emergency)
   - [Settings & Profile](#913-settings--profile-screens)
   - [Festival & Wedding](#914-festival--wedding-screens)
   - [Home Widgets](#915-home-screen-widget-ui)
10. [Bottom Navigation Bar](#10-bottom-navigation-bar)
11. [Common UI Patterns](#11-common-ui-patterns)
12. [Accessibility & Bilingual Rules](#12-accessibility--bilingual-rules)

---

## 1. Design Philosophy

FitKarma's design language is built on **six pillars** that define every pixel:

| Pillar | Expression |
|---|---|
| **Spatial Depth** | Layered surfaces with real blur, shadow, and translucency — not flat card stacks. Every screen has a clear depth hierarchy: background → mid layer → foreground. |
| **Fluid Motion** | Spring physics on all transitions. No linear tweens. Elements slide, scale, and breathe. State changes never feel abrupt. |
| **Bold Information** | Numbers are heroes. Key metrics display at `56–72sp` with variable-weight fonts. Context recedes — never competes with data. **One dominant metric per screen.** |
| **Visual Restraint** | Premium design knows when to be quiet. Not every card glows. Not every surface blurs. Calm screens make vibrant moments feel earned. Restraint is what separates premium from busy. |
| **Dark-First, Warm-Second** | Dark mode is the primary design target. Light mode is a warm, luminous inversion — not an afterthought. Both feel premium and intentional. |
| **Cultural Pulse** | The orange-indigo-saffron palette draws from Indian aesthetics. Bilingual labels, Devanagari script, Indian units, and festival context are woven in — not bolted on. Used **strategically**, not exhaustively. |

### Anti-Patterns (Never Do These)

- ❌ Plain white cards with grey text on white backgrounds
- ❌ Skeleton screens on core data (use Drift optimistic UI instead)
- ❌ Hardcoded hex values anywhere outside the token file
- ❌ Modals/dialogs when a bottom sheet suffices
- ❌ Static illustrations — use Lottie or Rive for all hero visuals
- ❌ **Glow on every card** — glow is reserved for the active metric, primary CTA, and ring fill only
- ❌ **Two competing hero elements on the same screen** — one screen, one visual champion
- ❌ **Bilingual labels on every single element** — apply only where context is ambiguous or navigation-critical
- ❌ **Blur + glow + gradient + animation on the same card** — max 2 effects per surface

---

## 2. Visual Language & Tokens

### 2.1 Dark Mode Colour Palette (Primary)

> Dark mode is the design baseline. All tokens below are for dark mode. Light mode equivalents follow in §2.2.

| Token | Hex | Usage |
|---|---|---|
| `bg0` | `#080810` | True base — deepest background layer |
| `bg1` | `#0F0F1A` | Primary scaffold background |
| `bg2` | `#161625` | Secondary/nested screen background |
| `surface0` | `#1C1C2E` | Base card surface |
| `surface1` | `#22223A` | Elevated card, bottom sheets |
| `surface2` | `#2A2A45` | Tooltip, pop-over surfaces |
| `glass` | `rgba(255,255,255,0.06)` | Glassmorphic overlay — over bg0/bg1 only |
| `glassBorder` | `rgba(255,255,255,0.10)` | Glass card border |
| `glassBlur` | `12px` | BackdropFilter blur radius for all glass surfaces |
| `primary` | `#FF6B35` | CTAs, FAB, active nav, rings — vibrant orange |
| `primaryGlow` | `rgba(255,107,53,0.25)` | Box-shadow glow beneath primary elements |
| `primaryMuted` | `#FF6B3530` | Chip selected background, subtle tints |
| `accent` | `#FFB547` | Karma XP, streaks, insight highlights |
| `accentGlow` | `rgba(255,181,71,0.20)` | Glow for amber elements |
| `secondary` | `#7B6FF0` | Hero accents, level badges, progress fills |
| `secondaryGlow` | `rgba(123,111,240,0.25)` | Glow for secondary elements |
| `teal` | `#00D4B4` | Water, SpO2, Ayurveda, Medication |
| `tealGlow` | `rgba(0,212,180,0.20)` | Teal glow |
| `success` | `#4ADE80` | Steps rings, completed habits, healthy readings |
| `successGlow` | `rgba(74,222,128,0.20)` | Success glow |
| `warning` | `#FBBF24` | Elevated readings, moderate risk |
| `error` | `#F87171` | Crisis readings, destructive actions |
| `rose` | `#FB7185` | Period cycle, menstrual accent |
| `purple` | `#C084FC` | Active minutes ring |
| `textPrimary` | `#F1F0FF` | Headings, primary body |
| `textSecondary` | `#9B99CC` | Labels, subtitles, captions |
| `textMuted` | `#6B68A0` | Placeholders, inactive states — **decorative only** (≈ 4.6:1 on bg1; do not use for informational text) |
| `divider` | `rgba(255,255,255,0.08)` | Subtle dividers — not harsh lines |

### 2.2 Light Mode Colour Palette

| Token | Hex | Notes |
|---|---|---|
| `bg0` | `#F7F0E8` | Warm parchment — deepest background |
| `bg1` | `#FDF6EC` | Primary scaffold background |
| `bg2` | `#FFF9F2` | Secondary screen background |
| `surface0` | `#FFFFFF` | Card surface |
| `surface1` | `#FFFAF5` | Elevated card |
| `surface2` | `#FFF3EF` | Tooltip surfaces |
| `glass` | `rgba(255,250,245,0.70)` | Frosted glass card in light mode |
| `glassBorder` | `rgba(255,107,53,0.15)` | Glass card border (warm tint) |
| `primary` | `#F4511E` | Slightly deeper orange — better contrast on light |
| `primaryMuted` | `#FEE8E2` | Chip selected background |
| `accent` | `#F59E0B` | Karma coins |
| `secondary` | `#5B50D4` | Hero sections, level badges |
| `teal` | `#0D9488` | Water, Ayurveda |
| `success` | `#22C55E` | Healthy readings |
| `textPrimary` | `#1A1830` | All body copy |
| `textSecondary` | `#6B6A96` | Subtitles, labels |
| `textMuted` | `#B0AEC8` | Placeholders, inactive |
| `divider` | `rgba(26,24,48,0.07)` | Subtle dividers |

### 2.3 Glow & Neon Effects

Neon glows are used on **metric numbers, active rings, and CTAs** in dark mode only. Never use glows in light mode.

```
// Shadow recipe for glowing metric numbers
textShadow: 0 0 20px {colorGlow}, 0 0 40px {colorGlow}40

// Button glow on primary CTA
boxShadow: 0 4px 24px {primaryGlow}, 0 1px 0 rgba(255,255,255,0.08) inset

// Ring glow on activity circles
filter: drop-shadow(0 0 8px {ringColorGlow})
```

### 2.4 Hero Gradients

| Name | Direction | Dark Mode | Light Mode | Used on |
|---|---|---|---|---|
| `heroDeep` | 135° | `#0A0818 → #1E1850` | `#2C2A6B → #3F3D8F` | Dashboard, Karma, Profile |
| `heroSleep` | 180° (3-stop) | `#04020F → #0D0B2E → #1C1A48` | `#1A1A3E → #2C2A6B → #4A3F8F` | Sleep screen |
| `heroFestival` | 120° | `#1A0A00 → #3D1500` | `#FF8C00 → #FF5722` | Festival screens |
| `heroWedding` | 135° | `#1A1000 → #3A2800` | `#D4A017 → #9A7100` | Wedding planner |
| `heroPrimary` | 135° | `#1A0800 → #3D1100` | `#FF5722 → #E64A19` | Workout, Steps |
| `glassHero` | — | `rgba(30,24,80,0.85)` + blur | — | Header glass cards |

### 2.5 Bento Grid System

The bento grid is **the primary layout pattern** for dashboard-style screens. Cards of varied sizes create visual rhythm.

```
// Grid definitions
bentoGap: 12px
bentoRadius: 20px          // outer cards
bentoRadiusSm: 14px        // inner/nested cards
bentoRadiusLg: 28px        // hero / full-width cards

// Size variants
full:     12 columns (full width, any height)
half:     6 columns
third:    4 columns
twoThird: 8 columns
quarter:  3 columns
```

#### Bento Min-Cell-Width Guard

> On 360dp-wide devices (common in India's ₹8–12k segment), `third` (4-col) and `quarter` (3-col) cells become dangerously narrow after subtracting padding + gaps.

```dart
// lib/shared/widgets/bento_card.dart

// Computed minimum cell width at 360dp:
//   Available width = 360 - 2×20px (padding) - gaps
//   quarter at 3-col = ~62dp  → TOO NARROW for readable content
//   third   at 4-col = ~83dp  → borderline usable

const double _minCellWidthDp = 80.0;

BentoSize _resolvedSize(BuildContext context, BentoSize requested) {
  final screenWidth = MediaQuery.of(context).size.width;
  final available = screenWidth - 40; // 20px padding each side
  final cols = 12;
  final cellWidth = (available - (bentoGap * (cols - 1))) / cols;

  // If the requested size would produce cells < 80dp, promote to next size up
  final requestedCols = _colsFor(requested);
  if ((cellWidth * requestedCols) < _minCellWidthDp) {
    if (requested == BentoSize.quarter) return BentoSize.third;
    if (requested == BentoSize.third)   return BentoSize.half;
  }
  return requested;
}
```

**Rule:** `BentoCard` always calls `_resolvedSize()` before rendering. Designers may specify `quarter` — the widget auto-promotes on small screens. No manual breakpoint handling on screen level.

### 2.6 Shape & Depth Tokens

| Token | Value | Used on |
|---|---|---|
| `radiusSm` | `10px` | Chips, pills, tags |
| `radiusMd` | `16px` | Standard cards |
| `radiusLg` | `20px` | Bottom sheets, modals |
| `radiusXl` | `28px` | Hero sections, large cards |
| `radiusFull` | `9999px` | Avatar, FAB, round buttons |
| **Elevation 0** | No shadow, glass border `1px` | Glassmorphic surfaces (dark) |
| **Elevation 1** | `0 2px 8px rgba(0,0,0,0.40)` | Floating cards (dark) |
| **Elevation 2** | `0 8px 32px rgba(0,0,0,0.50)` | Bottom sheets, modals (dark) |
| **Elevation 0 (light)** | `0 1px 3px rgba(0,0,0,0.08)` | Light mode base cards |
| **Elevation 1 (light)** | `0 4px 16px rgba(0,0,0,0.10)` | Floating cards (light) |
| **Elevation 2 (light)** | `0 8px 32px rgba(0,0,0,0.12)` | Modals (light) |

---

## 3. Typography System

**Primary Font:** [Plus Jakarta Sans](https://fonts.google.com/specimen/Plus+Jakarta+Sans) — variable weight, modern, highly legible.
**Monospace / Stats:** [JetBrains Mono](https://fonts.google.com/specimen/JetBrains+Mono) — for metric numbers only.
**Devanagari Script:** System font (Noto Sans Devanagari) — auto-activated for Hindi labels.

> All font weights use the variable font axis — no separate font files per weight.

| Style | Size | Weight | Letter-spacing | Used for |
|---|---|---|---|---|
| `heroDisplay` | 72sp | 800 ExtraBold | -2.5px | Full-screen metric dominance (e.g. step count) |
| `metricXL` | 56sp | 700 Bold | -2px | Primary screen metric (BP, Glucose, Sleep hours) |
| `metricLg` | 40sp | 700 Bold | -1.5px | Dashboard ring center numbers |
| `displayLg` | 32sp | 700 Bold | -1px | Screen hero titles |
| `displayMd` | 28sp | 600 SemiBold | -0.5px | Level titles, section hero |
| `h1` | 24sp | 600 SemiBold | -0.3px | Screen app bar titles |
| `h2` | 20sp | 600 SemiBold | -0.2px | Card headings |
| `h3` | 18sp | 500 Medium | 0 | Sub-section headings |
| `h4` | 16sp | 500 Medium | 0 | List item titles |
| `labelLg` | 15sp | 600 SemiBold | 0.2px | CTA button text, active chip |
| `labelMd` | 13sp | 500 Medium | 0.1px | Chip text, badge text |
| `bodyLg` | 16sp | 400 Regular | 0 | Main body copy |
| `bodyMd` | 14sp | 400 Regular | 0 | Cards, list subtitles |
| `bodySm` | 12sp | 400 Regular | 0.1px | Meta text, secondary notes |
| `monoXL` | 48sp | 700 Bold | -1px | Stats that feel "live" (HR, glucose readings) |
| `monoLg` | 28sp | 600 SemiBold | -0.5px | Chart axis values, step counters |
| `caption` | 11sp | 400 Regular | 0.3px | Timestamps, legal fine print |
| `hindi` | 12sp | 500 Medium | 0 | All Devanagari subtitle labels |

**On-Dark variants:** Add `textPrimary` dark token. Scale opacity: primary = 100%, secondary = 65%, muted = 40%.

### 3.1 Per-Screen Typography Enforcement

> The scale has 17 named styles. With 45+ screens, inconsistent application is a real risk. This table pins each screen's hero and secondary style to prevent swapping. **Only one `heroDisplay` or `metricXL` per visible screen area** (Single Hero Rule applies to type scale too).

| Screen | Hero Style (L1) | Secondary Style (L2) | Card Body |
|---|---|---|---|
| Dashboard | `metricLg` (ring center) | `monoLg` (calorie count) | `bodyMd` |
| Steps | `heroDisplay` (step count) | `monoLg` (distance, kcal) | `bodyMd` |
| Blood Pressure | `metricXL` (systolic/diastolic) | `monoLg` (pulse) | `bodyMd` |
| Glucose | `metricXL` (reading value) | `labelLg` (classification) | `bodyMd` |
| Sleep | `metricXL` (duration, e.g. `7h 20m`) | `monoLg` (quality score) | `bodyMd` |
| SpO2 | `metricXL` (% value) | `monoLg` (pulse) | `bodyMd` |
| Active Workout | `heroDisplay` (live timer / reps) | `monoXL` (HR zone) | `h3` |
| Fasting Timer | `heroDisplay` (countdown HH:MM:SS) | `monoLg` (stage name) | `bodyMd` |
| Karma Hub | `displayLg` (XP total) | `monoLg` (level progress) | `bodyMd` |
| Food Log | `monoLg` (daily kcal total) | `bodyLg` (food names) | `bodyMd` |
| Habit Tracker | `monoLg` (streak count) | `h3` (habit name) | `bodySm` |
| Body Metrics | `metricLg` (weight) | `monoLg` (BMI) | `bodyMd` |
| Mood Tracker | `displayMd` (emoji label) | `monoLg` (energy slider) | `bodyMd` |
| Journal Entry | `h2` (entry title) | `bodyLg` (entry body) | `bodySm` |
| Lab Reports | `monoLg` (value) | `labelLg` (classification pill) | `bodyMd` |
| Settings | `h2` (section title) | `h4` (row label) | `bodySm` |
| Emergency Card | `displayMd` (blood group) | `h3` (name) | `bodyMd` |

> **Rules:**
> - `heroDisplay` and `metricXL` must not appear on the same screen simultaneously.
> - `monoXL` (48sp) is reserved for **live / real-time** readings only (active HR monitor, live glucose CGM). Do not use on static history screens.
> - `metricLg` (40sp) is used ONLY for the dashboard ring center — not on detail screens.
> - When in doubt, use `metricXL` (56sp) for a primary reading and `monoLg` (28sp) for everything secondary.

---

## 4. Motion & Animation

> Every motion has purpose — no gratuitous animation. Interactions must feel responsive within **100ms** of touch.

### 4.1 Spring Physics Presets

```dart
// Light spring — chips, toggles, small state changes
SpringDescription.withDampingRatio(
  mass: 1.0, stiffness: 400, ratio: 0.85)

// Standard spring — cards, tab transitions, page routes
SpringDescription.withDampingRatio(
  mass: 1.0, stiffness: 250, ratio: 0.80)

// Dramatic spring — hero entrances, metric reveal, level-up
SpringDescription.withDampingRatio(
  mass: 1.0, stiffness: 180, ratio: 0.75)
```

### 4.2 Standard Transitions

| Interaction | Animation | Duration |
|---|---|---|
| Screen push/pop | Shared axis (vertical slide + fade) | 320ms standard spring |
| Bottom sheet reveal | Slide up + opacity fade | 280ms standard spring |
| Tab switch | Cross-fade + subtle Y shift (8px) | 220ms light spring |
| Card tap feedback | Scale `1.0 → 0.97` on press, `0.97 → 1.0` on release | 80ms / 160ms |
| FAB expand | Scale up + radial sub-button reveal | 300ms dramatic spring |
| Metric number change | CountUp with per-digit spring | 400ms standard spring |
| Ring progress fill | Draw arc with easeOutCubic | 600ms on mount |
| Chip select/deselect | Background color + scale (`0.95 → 1.02 → 1.0`) | 200ms light spring |
| Insight card appear | Slide up 16px + fade | 350ms standard spring |
| XP float animation | Amber text +XP floats 40px up + fades | 500ms **light spring** (not linear) |

### 4.3 Lottie / Rive Animations

| Usage | Source |
|---|---|
| Step goal confetti | `assets/lottie/confetti_orange.json` |
| Level-up celebration | `assets/rive/levelup.riv` |
| Logo reveal / splash | `assets/rive/logo_reveal.riv` |
| Loading pulsing rings | `assets/rive/loading_rings.riv` |
| Streak fire | `assets/lottie/streak_fire.json` |
| Karma coin collect | `assets/lottie/coin_burst.json` |
| Sync success | `assets/lottie/sync_check.json` |
| Error state | `assets/lottie/error_state.json` |

#### 4.3a Empty State Asset Inventory

Every screen with a potentially-empty list **must** use the correct `empty_{context}.json` Lottie. Engineers must not create ad-hoc empty states.

| Screen / Context | Lottie Key | Fallback Text |
|---|---|---|
| Food log (no meals logged) | `empty_food_log` | "No meals logged yet. Tap + to add breakfast." |
| Food search (no results) | `empty_search` | "No results. Try a different name or scan a barcode." |
| Workout list (no workouts) | `empty_workout` | "No workouts yet. Explore plans to get started." |
| Steps (no data) | `empty_steps` | "Step data not available. Check Health Connect permissions." |
| Sleep log | `empty_sleep` | "No sleep logged this week. Tap + to add last night." |
| Mood log | `empty_mood` | "No mood entries yet. Takes under 10 seconds." |
| BP history | `empty_bp` | "No readings yet. Log your first BP reading." |
| Glucose history | `empty_glucose` | "No glucose readings yet. Log your first reading." |
| Lab reports | `empty_lab` | "No lab reports imported. Tap 📋 to scan a report." |
| Habits | `empty_habits` | "No habits yet. Pick from presets or create your own." |
| Journal | `empty_journal` | "No entries yet. Start with how you're feeling today." |
| Social feed | `empty_social` | "Your feed is quiet. Follow people or join a community." |
| Challenges | `empty_challenges` | "No active challenges. Browse the Karma Hub." |
| Medication | `empty_medication` | "No medications added. Tap + to add a reminder." |
| Water log | `empty_water` | "No water logged today. Tap + to add a glass." |
| Personal records | `empty_records` | "No records yet. Complete a workout to set your first PR." |
| Doctor appointments | `empty_appointments` | "No upcoming appointments. Tap + to schedule one." |
| Ayurveda rituals | `empty_rituals` | "Complete your Dosha quiz to unlock daily rituals." |
| Festival calendar | `empty_festivals` | "No upcoming festivals in the next 30 days." |
| Family profiles | `empty_family` | "No family members added. Invite up to 5 people." |

> All `empty_{context}.json` files must be bundled with the app. If a specific context animation is not yet designed, use `empty_generic.json` as a temporary fallback — **never** use a plain text-only empty state without an illustration.

---

## 4.4 Performance Tier System

> FitKarma targets 2G–5G devices across India. The full premium experience is reserved for capable hardware. The UI must **degrade gracefully** across three tiers — never crash visually on a ₹8,000 device.

### Tier Detection

```dart
// lib/core/config/device_tier.dart
enum DeviceTier { low, mid, high }

DeviceTier detectTier() {
  final ram = DeviceInfo.ramMB;
  final isLowEnd = ram < 3000;          // < 3 GB RAM
  final isMidEnd = ram >= 3000 && ram < 6000;
  if (isLowEnd) return DeviceTier.low;
  if (isMidEnd) return DeviceTier.mid;
  return DeviceTier.high;
}
```

### Tier Capability Matrix

| Feature | Low-End (< 3GB RAM) | Mid-End (3–6GB) | High-End (6GB+) |
|---|---|---|---|
| `BackdropFilter` blur (dark) | ❌ Disabled globally | ✅ Cards only (not blobs) | ✅ Full glassmorphism |
| `BackdropFilter` blur (light) | ❌ Disabled globally | ✅ Cards, 12px max | ✅ Cards, 12px max |
| Ambient glow blobs | ❌ Disabled | ⚡ 1 blob max, reduced opacity | ✅ 3 blobs per hero |
| Glow box-shadows | ❌ Disabled | ⚡ Active element only | ✅ Full glow system |
| Lottie animations | ⚡ Essential only (streak fire, confetti) | ✅ All Lottie | ✅ All Lottie + Rive |
| Rive animations | ❌ Static fallback image | ⚡ Logo reveal only | ✅ All Rive |
| Spring animations | ⚡ Simplified cross-fade | ✅ Standard spring | ✅ Full spring physics |
| Per-digit CountUp | ❌ Single counter tween | ⚡ Whole-number spring | ✅ Per-digit spring |
| Ring glow filter | ❌ Plain stroke | ⚡ Single ring only (primary) | ✅ All ring glows |
| Bento grid layout | ✅ Same (layout, not GPU) | ✅ Same | ✅ Same |
| Card surface type | `surface1` solid colour | `surface0` + 1px border | Full glass surface |
| Sync interval | 6 hours | 30 min | 15 min |

### Low-End Card Fallback

```css
/* Replaces glassmorphism on Tier: low */
background: #22223A;          /* surface1 solid */
border: 1px solid rgba(255,255,255,0.08);
border-radius: 16px;
/* No backdrop-filter. No box-shadow glow. */
```

> **Rule:** The `DeviceTierProvider` is a root-level Riverpod provider initialised at app start. Every widget that uses blur/glow reads from it. No widget hard-codes visual effects.

---

## 5. Surface & Depth System

Three-layer depth model — every screen element lives in one of three planes:

```
┌──────────────────────────────────────────────────────┐
│  PLANE 3: Foreground                                 │
│  FAB · Bottom sheets · Tooltips · Modals             │
│  Highest elevation, max blur behind                   │
├──────────────────────────────────────────────────────┤
│  PLANE 2: Mid-layer                                  │
│  Cards · Charts · Insight panels · Bento cells       │
│  Glass surface with divider border                    │
├──────────────────────────────────────────────────────┤
│  PLANE 1: Background                                 │
│  Scaffold · Hero gradients · Ambient glow blobs      │
│  No surface — this is raw bg1 or gradient            │
└──────────────────────────────────────────────────────┘
```

### 5.1 Glassmorphism Recipe

Applied to all Plane 2 cards in dark mode:

```css
background: rgba(255, 255, 255, 0.05);
border: 1px solid rgba(255, 255, 255, 0.10);
backdrop-filter: blur(12px) saturate(180%);
border-radius: 20px;
```

In light mode, glass cards use:

```css
background: rgba(255, 252, 248, 0.80);
border: 1px solid rgba(244, 81, 30, 0.12);
backdrop-filter: blur(12px);   /* CAPPED at 12px — matches dark mode. Never exceed 12px.
                                   blur(20px) caused mid-tier jank in light mode. */
```

> **Light mode blur rule:** `blur` is capped at `12px` on all tiers and all modes. Dark mode is the same. Consistency prevents mode-switching jank on mid-range devices.

### 5.2 Ambient Glow Blobs

Hero screens and the Dashboard use ambient glow blobs positioned behind the content layer. These are blurred radial gradients:

```
// Example: Dashboard hero blob setup (dark mode)
Blob 1: position top-left, color #7B6FF020, size 280×280px, blur 80px
Blob 2: position top-right, color #FF6B3515, size 200×200px, blur 60px
Blob 3: position center, color #00D4B410, size 160×160px, blur 50px
```

This creates depth and warmth without any literal imagery.

---

## 6. Universal Screen Rules

### Layout

- Safe area insets respected on all screens (use `SafeArea` widget)
- Bottom FAB clearance: `120px` minimum bottom padding on all scrollable bodies
- Default horizontal padding: `20px` (screens) / `16px` (inside cards)
- Bento grid used for dashboard and summary screens; list layout for sequential content
- No more than 3 distinct surface levels visible simultaneously

### 6.1 Single Hero Rule

> **Every screen has exactly one visual champion.** One metric, image, or element commands attention. Everything else supports it.

```
Screen priority hierarchy:
  LEVEL 1 — The Hero:   One metric or visual (metricXL or heroDisplay)
  LEVEL 2 — Secondary:  Max 2 supporting data points (monoLg)
  LEVEL 3 — Context:    Labels, captions, trends (bodyMd, caption)
  LEVEL 4 — Supporting: Everything else — collapsed or progressively revealed
```

| Screen | Hero (L1) | Secondary (L2) | Context (L3) |
|---|---|---|---|
| Dashboard | Activity Ring (today's steps) | Calories + Sleep | Insight card, meals |
| Blood Pressure | Systolic/Diastolic reading | AHA classification | Trend chart, history |
| Sleep | Sleep duration | Quality emoji | 7-day chart, debt |
| Glucose | Latest reading | Classification badge | Meal correlation |
| Steps | Step count | Distance | Hourly chart |
| Karma Hub | Total XP | Level progress | Leaderboard |

**Never** stack two `metricXL` or `heroDisplay` elements on the same visible scroll area.

### 6.2 Glow Discipline

> Glow is a **reward for importance** — not a default style. When everything glows, nothing glows.

**Glow is permitted ONLY on:**

| Element | Glow Token | Reason |
|---|---|---|
| The single primary metric (Level 1 hero) | `{colorGlow}` matching metric color | Draw eye to the most important number |
| Primary CTA button | `primaryGlow` | Confirms the main action |
| Active/selected ring fill | ring color glow | Shows progress state |
| Active nav tab indicator | `primaryGlow` (soft, 50% opacity) | Confirms current location |
| EncryptionBadge on sensitive screens | `tealGlow` | Security signal |
| Linked ABHA status | `successGlow` | Positive confirmation |

**Glow is PROHIBITED on:**

- Secondary metric cards (use `surface1` fill + divider border instead)
- Section headers
- List items and log entries
- Empty state cards
- Settings rows
- Any card on a **Visual Calm Zone** screen

### 6.3 Visual Calm Zones

> The contrast of a calm screen makes vibrant screens feel earned and premium. Quiet screens communicate trust.

The following screens use **zero glow, minimal animation, no blur** regardless of device tier:

| Screen | Why Calm? |
|---|---|
| Settings | Trust + clarity; users making decisions need focus |
| Journal | Emotional space; animations feel intrusive |
| Emergency Card | Medical urgency; no cognitive noise |
| Lab Reports Home | Clinical context; professional tone |
| ABHA Account | Government/medical trust signal |
| Doctor Appointments | Professional context |
| Subscription Plans | Financial decision; trust required |
| Onboarding Steps 1–3 | New user; reduce overwhelm |

**Calm Zone card spec** (all tiers, overrides tier settings):
```css
background: surface0;     /* solid, no glass */
border: 1px solid divider;
border-radius: 16px;
/* No glow. No blur. No ambient blobs. */
/* Animations: fade only, 150ms, no spring bounce */
```

### 6.4 Cognitive Load Hierarchy

> A user opening the app after a run should get their primary metric in < 1 second visually. Everything deeper requires a deliberate tap.

**Three-layer disclosure model:**

```
LAYER 1 — Above the fold (visible immediately, no scroll):
  → Hero metric (metricXL or heroDisplay)
  → 2 max secondary stats
  → Primary CTA
  → NO section headers competing here

LAYER 2 — Scroll zone:
  → Charts and trends
  → Insight card (max 1)
  → Modular summary cards

LAYER 3 — On tap / progressive reveal:
  → Historical data
  → Detailed breakdowns
  → Settings and configuration
  → Advanced filters
```

**Dashboard bento grid discipline:**
```
Row 1 (above fold): ActivityRingsWidget FULL WIDTH — nothing competes
Row 2: 2 half-cards max (Latest Workout + Sleep)
Row 3: InsightCard — full width
Row 4+: Meals, history (below natural fold — user intentionally scrolls)
```

### 6.5 Progressive Disclosure for New Users

First-time users see a **Calm Mode Dashboard** for the first 7 days:

```dart
// lib/core/config/user_experience_stage.dart
enum UXStage { firstWeek, familiar, expert }

UXStage getStage(DateTime firstLaunch) {
  final daysSince = DateTime.now().difference(firstLaunch).inDays;
  if (daysSince < 7) return UXStage.firstWeek;
  if (daysSince < 30) return UXStage.familiar;
  return UXStage.expert;
}
```

| UX Stage | Visible Modules | Effects Level |
|---|---|---|
| `firstWeek` | Steps + Food + 1 Insight card only | Calm (no glow, simple springs) |
| `familiar` | All core modules, Karma, Challenges | Standard effects |
| `expert` | Full system including correlations, leaderboards | Full effects (device-tier limited) |

> All modules are **accessible at any stage** via navigation — progressive disclosure only applies to what surfaces by default on the Dashboard and Home screens.

### App Bar

```
// Standard (dark mode)
Background: transparent (overlaid on bg1)
Leading: back arrow or avatar — tinted textSecondary
Title: h1 weight in textPrimary, centred
Actions: icon buttons, 44×44 tap target, textSecondary tint

// Hero (dark mode — overlaid on gradient)
Background: transparent
Leading/Actions: white at full opacity
Title: white, h1 weight

// Standard (light mode)
Background: bg1 (#FDF6EC)
Title/icons: textPrimary (light)

// Calm Zone screens
Background: bg2 (solid, slightly elevated from scaffold)
Elevation: 0, 1px bottom divider line
```

App bar titles render **bilingual** only on these surfaces: bottom nav tabs, primary screen titles, and section headers. See §12 for full strategic bilingual rules.

### Inputs & Forms

```dart
// TextFormField standard decoration
InputDecoration:
  fillColor: surface0 (dark) | surface0Light (light)
  filled: true
  border: OutlineInputBorder(
    borderRadius: 12px,
    borderSide: BorderSide(divider, 1px)
  )
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(primary, 2px)
  ) + glow: 0 0 0 4px primaryMuted   // Tier: mid/high only
  contentPadding: 16px horizontal, 14px vertical
```

### Bottom Sheets

```
Handle: 40×4px, centered, rounded, divider color, 12px top margin
Background: surface1 (blur 20px behind — Tier: mid/high only; Tier: low = surface1 solid)
Border-top-radius: radiusLg (20px)
Max height: 85% of screen
```

---

## 7. Scaffold Patterns

### Pattern A — Standard (most screens)

```
Scaffold(
  backgroundColor: bg1,                    // #0F0F1A dark / #FDF6EC light
  appBar: transparent, elevation 0
  body: CustomScrollView or SingleChildScrollView
     → Padding(horizontal: 20px)
     → Column / ListView.builder
)
```

Dark mode: ambient glow blobs rendered as a `Stack` behind the scroll content.

### Pattern B — Immersive Hero + Layered Body

Used on metric-heavy screens (Dashboard, Karma, Sleep, Blood Pressure, Profile, Workout Detail):

```
Stack(
  ┌──────────────────────────────────────────────────────┐
  │  heroGradient container (full-width, 320px height)   │
  │    + ambient glow blobs (Positioned)                 │
  │    + transparent AppBar (overlaid)                   │
  │    + hero metric content                             │
  └──────────────────────────────────────────────────────┘
         ↕ 28px ClipRRect overlap (radius 28px top)
  ┌──────────────────────────────────────────────────────┐
  │  surface1 rounded card (overlaps hero by 28px)       │
  │    → scrollable body content                         │
  │    → nested bento grid or list items                 │
  └──────────────────────────────────────────────────────┘
)
Scaffold background: bg0 (deepest — shows at edges)
```

### Pattern C — Full-Bleed Immersive (Active Workout, GPS)

```
Scaffold(
  backgroundColor: bg0,
  extendBodyBehindAppBar: true,
  body: Stack → full-bleed content
     AppBar: transparent, white icons
)
```

---

## 8. Shared Component Library

All components live in `lib/shared/widgets/`. **Never re-implement per screen.**

| Component | File | Description |
|---|---|---|
| `BentoCard` | `bento_card.dart` | Glassmorphic card — accepts `size` enum (full/half/third), child, optional glow color |
| `ActivityRingsWidget` | `activity_rings.dart` | Four concentric rings with neon glow; animated fill on mount; centre shows primary metric with `metricLg` font |
| `GlowingMetric` | `glowing_metric.dart` | **NEW** — `monoXL` number with per-digit spring CountUp animation + optional neon glow |
| `InsightCard` | `insight_card.dart` | Glass surface; lightbulb icon in accent color; 👍/👎 haptic rating; subtle amber glow border |
| `CorrelationInsightCard` | `correlation_insight_card.dart` | Multi-module insight; connected module icon pills; glass with secondary glow border |
| `FoodItemCard` | `food_item_card.dart` | Glassmorphic card; blurred food photo bg; bilingual name; portion; kcal; `+` with spring scale |
| `KarmaLevelCard` | `karma_level_card.dart` | `heroDeep` gradient; animated XP progress bar with `primaryGlow`; level badge |
| `DoshaDonutChart` | `dosha_chart.dart` | Three-segment donut with `fl_chart`; animated draw; glow per segment |
| `ChallengeCarouselCard` | `challenge_card.dart` | Horizontal scroll; glass card; progress bar; XP reward with `coin_burst` Lottie; festival tag pill |
| `QuickLogFAB` | `quick_log_fab.dart` | Glowing orange FAB; spring speed-dial expand to 6 sub-actions (Food, Water, Mood, Workout, BP, Glucose) |
| `MealTypeTabBar` | `meal_tab_bar.dart` | Floating pill tab bar; selected tab: primary color + glow; animated indicator |
| `ShimmerLoader` | `shimmer_loader.dart` | `surface0` base + flowing shimmer gradient — matches dark/light surface colors |
| `BilingualLabel` | `bilingual_label.dart` | English `h3` + Devanagari `hindi` stacked; 3px left border in `primary` for section headers |
| `EncryptionBadge` | `encryption_badge.dart` | Glassmorphic pill; 🔒 icon; `AES-256` label; teal border glow; animated pulse on sensitive data reveal |
| `ABHALinkBadge` | `abha_badge.dart` | Link status card — linked: `success` glow, verified checkmark; unlinked: `warning` glow, CTA |
| `HealthShareCard` | `health_share_card.dart` | Share-to-doctor glass card; expiry countdown ring; WhatsApp CTA with brand green |
| `HomeWidgetPreview` | `home_widget_preview.dart` | Scaled phone-frame preview (device mockup SVG) + live widget content inside |
| `MicronutrientBar` | `micronutrient_bar.dart` | Compact animated progress bar per micronutrient; color coded (teal/orange/purple/amber) |
| `LabValueRow` | `lab_value_row.dart` | Extracted lab metric row; inline edit field; classification pill; confirm checkbox |
| `ErrorRetryWidget` | `error_retry_widget.dart` | Lottie error animation + message + retry button; never bare `ErrorWidget` |
| `SyncStatusBanner` | `sync_status_banner.dart` | Top banner: teal (low data) or amber (sync failure); animated progress dot |
| `FestivalCard` | `festival_card.dart` | Festival glass card; festival-colour gradient left border; bilingual name; fasting pill; region pill; Set Reminder + Diet Plan CTAs |
| `FestivalCountdownBanner` | `festival_countdown_banner.dart` | Full-width active festival banner; festival gradient bg; fasting mode badge; quick action buttons |
| `WeddingCountdownCard` | `wedding_countdown_card.dart` | Gold gradient glass card; days countdown; next event pill; role badge; planner link |
| `WeddingRoleChip` | `wedding_role_chip.dart` | Large illustrated role card (Bride/Groom/Guest/Relative); spring select animation |
| `EventDayCard` | `event_day_card.dart` | Wedding event card; energy demand badge (Low/Med/High); pre/post meal summary |
| `FestivalDietBadge` | `festival_diet_badge.dart` | Fasting type pill (Nirjala/Phalahar/Roza/Feast); subtle glow per type |
| `GlassAppBar` | `glass_app_bar.dart` | **NEW** — Scrolled app bar that gains `backdrop-filter: blur(16px)` + glass bg on scroll |
| `PulseRing` | `pulse_ring.dart` | **NEW** — Animated pulsing ring widget for HR / live metric indicators |
| `TrendChip` | `trend_chip.dart` | **NEW** — `▲ +3%` / `▼ -2%` animated chip with appropriate color coding |
| `StreakFlameWidget` | `streak_flame.dart` | **NEW** — Lottie streak_fire.json with streak count overlay; scale grows with streak length |

---

## 9. Screen-by-Screen UI Specifications

---

### 9.1 Onboarding & Auth Screens

#### Splash Screen

**Scaffold:** Full-bleed bg0 (`#080810`)

**Layout:**
```
Stack(
  Rive animation: 'assets/rive/logo_reveal.riv'
     → FitKarma wordmark draws in over 800ms
     → Orange karma flame ignites below wordmark
  Tagline: "Your Karma, Your Health" in bodyMd, textSecondary
     → fades in 300ms delay after logo
  Bottom: linear loading bar in primary color
)
```

**Dark/Light:** Splash is always dark — user hasn't set preference yet.

---

#### Onboarding Flow (Steps 1–6)

**Shared Scaffold:** bg1, horizontal progress bar at top (6 segments, primary fill, glass background track).

**Step indicators:** Not pills — a thin segmented progress bar (`4px` tall, full-width, `radiusFull`, glass track with primary fill per step).

**Navigation:** Swipe gesture between steps + \"Next →\" / \"← Back\" buttons. Exit button (×) top-right.

---

#### Onboarding Step 1 — Personal Info

```
Screen layout:
  ┌─────────────────────────────────────────────┐
  │  Progress bar (step 1/6)                    │
  │                                             │
  │  "Tell us about you"  (displayMd, white)    │
  │  "आपके बारे में बताएं" (hindi, textSecondary)│
  │                                             │
  │  [Name TextField]                           │
  │                                             │
  │  Gender selector:                           │
  │  [Male 🧑] [Female 👩] [Other ⚧] [Skip]   │
  │  → Pill chips, selected = primary glow      │
  │                                             │
  │  Date of Birth: Date picker card            │
  │                                             │
  │  [Next →]  (primary, full-width, glow)      │
  └─────────────────────────────────────────────┘
```

---

#### Onboarding Step 2 — Body, Goal & Activity

```
Height: Ruler-style slider widget (custom, not TextField)
   → Animated human silhouette scales with height value
Weight: Drum-roll scroll picker (iOS-style)
   → Metric/Imperial toggle pill above

Fitness Goal: 4 large illustrated glass cards in 2×2 grid:
  [🏋 Build Strength] [🤸 Lose Weight]
  [🧘 Improve Wellness] [🏃 Boost Stamina]
  Selected: primary border, primaryMuted bg, spring pop

Activity Level: Vertical stack of 5 glass cards:
  Sedentary / Lightly Active / Moderately Active / Very Active / Athlete
  Icon + label + short description each
  Selected: left border in primary (4px), primary text
```

---

#### Onboarding Step 3 — Chronic Conditions

```
Grid: 3-column chip grid
Chip style: glass card (50×40px), icon + label
Conditions: Diabetes • Hypertension • PCOD/PCOS • Hypothyroid • Asthma
           • Heart Disease • Kidney Disease
Selected: primary border glow, checkmark badge top-right

Caption card (amber glass, bottom):
"Selecting a condition activates a personalised
 management module with doctor-reviewed guidance."

[Continue]  [Skip for now]
```

---

#### Onboarding Step 4 — Dosha Quiz

```
12 questions — full-screen card carousel (swipe to advance)
Each question card:
  - Question text (h2)
  - 3 options as illustrated glass cards
  - Selected card: spring pop, primary border
  - Auto-advance after selection (400ms delayed)

Final card: DoshaDonutChart (animated draw) with:
  Vata / Pitta / Kapha percentages
  Dominant dosha name in displayMd with matching color glow
  Short description paragraph
```

---

#### Onboarding Step 5 — Language & Permissions

```
Language grid: 4-column, 22 options
  Each cell: script preview + language name
  Selected: primary background + checkmark
  Single-select

Below divider — Health Permissions:
  Three permission rows in glass cards:
  [Step counter toggle]  [Heart rate toggle]  [Sleep toggle]
  Toggle style: custom pill toggle with spring animation (not Material)

Privacy caption: italic, textMuted, centered.
"Used only for health tracking. Change in Settings anytime."
```

---

#### Onboarding Step 6 — ABHA Link & Wearable

**Title:** "Link Health ID / अपना स्वास्थ्य ID"

```
Layout (scrollable):
  ABHALinkBadge — large variant, glass card, centred

  Amber glass info card:
  "Link your ABHA ID to auto-import past health records
   from hospitals and labs across India."

  ABHA Input: 14-digit numeric field
        Format hint: XX-XXXX-XXXX-XXXX
        Below input: "Verify via OTP →" (appears after 14 digits entered)

  OTP card (slides in after ID entry, spring animation):
  6-digit OTP input (individual boxes, not one field)
  "Link ABHA Account"  → primary full-width button (+100 XP badge)

  Divider ─────────

  Wearable row: [Fitbit] [Garmin] [Health Connect] logos
  "Connect Wearable" outlined button
  "Skip for now" text link

  [Finish Setup →]  (primary, full-width, glow)
```

---

#### Login Screen

**Scaffold:** bg1, ambient glow blob top-right (secondary glow)

```
Stack(
  bg1 scaffold,

  Column(
    Logo: FitKarma wordmark (48px) + flame icon
       → tagline: "Your Karma, Your Health"

    Glass card (surface1, radius 20px, Elevation 1):
      Email TextField
      Password TextField + show/hide toggle

      [Login]  → primary full-width, glow

      "Forgot Password?"  → textSecondary, centered

    "─── or ───"  (divider with label)

    Google Sign-In glass outlined button
    Apple Sign-In glass button (iOS only)

    "New here? Register →"  → primary color link
  )
)
```

---

#### Register Screen

Same as Login — adds: Name field + Confirm Password field. Auth card is taller; rest identical.

---

### 9.2 Core Dashboard & Karma

#### Dashboard

**Route:** `/home/dashboard`
**Scaffold:** Pattern B (Hero + Layered Body)

**Hero (320px, `heroDeep` gradient + blobs):**
```
Row: Avatar (48px circle, primary ring) |
     Column(Namaste [Name] 🙏, hindi subtitle) |
     Row(Karma XP amber pill | Level badge indigo pill)

[ABHALinkBadge compact — shown if ABHA not linked]
```

**Body (scrollable, overlapping hero by 28px, glass rounded top):**

```
Bento Grid (gap 12px):

Row 1:
  [ActivityRingsWidget — full width]
  → 4 concentric rings with neon glow (orange, green, teal, purple)
  → Center: GlowingMetric (primary ring value)
  → Below rings: 4 stat labels (value / goal + ring name)

Row 2 (2-column):
  [half] Latest Workout card
    Icon (filled, glow) + title + duration
    TrendChip: ▲ vs last week
  [half] Sleep Recovery card
    Percentage in metricLg + colored indicator
    TrendChip: mood for day

Row 3:
  [InsightCard OR CorrelationInsightCard — full width]
  Max 1 insight on Dashboard

Row 4:
  [Today's Meals — full width]
  SectionHeader: "Today's Meals / आज का खाना"
  MealTypeTabBar (floating pill style)
  FoodItemCard list (compact, no photo in Low Data Mode)

[QuickLogFAB — fixed, bottom-right, 20px from nav bar]
Bottom Nav
```

**Dark mode specifics:**
- bg1 scaffold, glow blobs active
- Ring tracks: `divider` dark
- Cards: glassmorphic surface0 + divider border
- Avatar ring: primary glow

---

#### Karma Hub

**Route:** `/karma`
**Scaffold:** Pattern B (heroDeep gradient)

**Hero:**
```
Level title: displayLg white + GlowingMetric for total XP
XP progress bar: animated, primary fill, glass track
  → "1,250 / 2,000 XP to Level 13 Warrior"
Karma coin icon with coin_burst Lottie on tap
```

**Body (scrollable):**

```
1. SectionHeader: "Daily Rituals / दैनिक अनुष्ठान"
   Checklist glass cards — ritual + completion indicator
   (green glow tick when complete, empty ring when not)
   Dosha-driven ritual suggestions per user

2. SectionHeader: "Active Challenges / चुनौतियाँ"
   ChallengeCarouselCard — horizontal scroll
   (festival-tagged challenges get festival color border)

3. SectionHeader: "Leaderboards / लीडरबोर्ड"
   Floating pill tab bar: Friends · City · National · Seasonal
   Top 5 list per tab:
     Rank badge (gold/silver/bronze glow for top 3)
     Avatar + name + XP

4. Karma Store glass card
   "Redeem XP" with reward previews
   Streak Recovery option (amber pill)
```

> **Architecture note:** `DoshaDonutChart` lives on the Profile screen and Ayurveda Hub — not here.

---

### 9.3 Food & Nutrition Screens

#### Food Home

**Route:** `/home/food`
**Scaffold:** Pattern A (standard, bg1)

**App bar:** "Food / खाना" + `MealTypeTabBar` pinned as floating pill tab below app bar (not in app bar itself — it has its own sticky container)

**Body (bento grid):**

```
Row 1 — Macro Summary (full width glass card):
  4 mini animated rings: Calories · Protein · Carbs · Fat
  Each ring: value / goal below ring (monoLg)
  Ring colors: primary / teal / accent / purple

Row 2 — Micronutrient row (full width):
  4 MicronutrientBar:  Iron · B12 · Vitamin D · Calcium
  Animated fill on mount, color-coded (teal/orange/purple/amber)

Row 3 — Copy Yesterday banner (full width, amber glass card):
  "Copy Yesterday's Meals → 1,840 kcal"
  [Copy all] orange button (right aligned)
  Shown ONLY if today's log is empty

Row 4 — Logged Meals (full width):
  Grouped by meal type matching selected tab
  FoodItemCard compact — swipe left → delete (red destructive)
  Empty state: Lottie empty_food.json + "Log your first meal"
```

---

#### Food Log Screen

**Route:** `/home/food/log/:mealType`
**Scaffold:** Pattern A

**Body:**
```
Search bar (glass surface, full-width, radiusFull):
  Placeholder bilingual "Search food / खाना खोजें"
  Trailing: mic icon (voice search) | barcode icon

Quick-action chip row (horizontal scroll):
  [📷 Scan Label]  [🍽 Upload Plate]  [📋 Lab/Rx Scan]  [✏ Manual]
  Glass chips, primary-outlined, spring tap feedback

Section: "Frequent Indian Portions"
  2×N bento grid of FoodItemCard (glass, blurred food photo bg)
  Photo · bilingual name · Indian portion · kcal · [+] button

Section: "Restaurant Results" (shown when restaurant searched)
  Swiggy/Zomato sourced cards with:
  [🍴 Swiggy] or [🍴 Zomato] attribution pill (brand colors)
  Deep-link icon button on each card

Section: "Recent Logs"
  List + [+] re-log button per row

Bottom: [Confirm Meal] full-width primary button (replaces FAB in this context)
```

---

#### Food Detail Screen

**Route:** `/home/food/detail/:id`
**Scaffold:** Pattern B (food photo as hero bg — blurred, darkened)

**Hero:**
```
Food photo (full-bleed, blur 8px, darkness overlay 60%)
Food name: displayLg white | Hindi name: hindi textSecondary
kcal: metricLg white with primary glow
```

**Body:**
```
Indian serving size selector: drum-roll picker (katori / piece / glass / tbsp)
Full macro table: glass card with animated bar fills
Micronutrient table (NEW): Iron · B12 · VitD · Calcium with RDA %
[Add to Log]  primary full-width button
```

---

#### Lab Report / Prescription OCR Screen (NEW)

**Route:** `/home/food/lab-scan`
**Scaffold:** Pattern A
**Title:** "Scan Lab Report / लैब रिपोर्ट स्कैन करें"

**Layout:**
```
Two glass cards side by side (half each):
  [📷 Take Photo]     [🗂 Upload PDF]
  Each: 100px tall, icon center, labelMd below

Processing state (ShimmerLoader):
  Glass card pulsing with "Extracting health values..." caption

Extracted Values glass card (scrollable):
  Each row: LabValueRow component
    🩸 Glucose (Fasting / शर्करा)   [ 92 ] mg/dL   ● Normal (green)
    ✏ Edit → inline TextField slide in
    ☑ Confirm toggle per value
  EncryptionBadge at bottom of card

[Import to Health Data] primary full-width button
[Discard] text link, error color

Privacy caption: "Raw text stored locally only. Values go to
your encrypted health logs."  — italic, textMuted
EncryptionBadge centered below caption
```

**Classification pill colors:**
- 🟢 Normal → `success` glow
- 🟡 Borderline → `warning` glow
- 🔴 High/Low → `error` glow

---

### 9.4 Workout Screens

#### Workout Home

**Route:** `/home/workout`
**Scaffold:** Pattern A

**Body:**
```
Streak banner (if active):
  Full-width glass card, orangeGradient bg
  StreakFlameWidget (Lottie) + "🔥 Day 12 Streak!" displayMd white

SectionHeader: "Today's Workout / आज का वर्कआउट"
Featured workout card (full-width, Pattern B mini):
  Workout photo hero (blurred + dark overlay)
  Title displayMd white · Duration badge · Difficulty badge
  [Start] primary button (bottom of card)

Category chips (horizontal scroll, glass pill chips):
  Yoga · HIIT · Strength · Cardio · Dance · Bollywood ·
  Cricket · Kabaddi · Pranayama

WorkoutCard grid (2-column bento):
  Glass card · blurred photo bg · title · duration · premium lock
```

---

#### Workout Detail Screen

**Route:** `/home/workout/:id`
**Scaffold:** Pattern B (workout thumbnail as hero bg)

**Hero:** Title `displayLg white` · Duration badge · Difficulty badge · [Start Workout] primary CTA

**Body:**
```
Description paragraph (bodyMd)
Equipment list: glass chip row
Exercise list (glass cards per exercise):
  Name · Sets × Reps · RPE target  [NEW]
  Superset bracket letter (A/B/C) left accent [NEW]
Similar workouts horizontal scroll (WorkoutCard compact)
```

---

#### Active Workout Screen

**Route:** `/home/workout/:id/active`
**Scaffold:** Pattern C (full-bleed immersive)
**Background:** bg0, hero gradient strip at top

**Full-bleed UI:**
```
Exercise name: h1, white, centered, top area
Set counter: monoXL primary glow
Rep target: bodyLg white

Rest Timer widget [NEW]:
  Countdown ring (PulseRing) with animated arc drain
  Configurable seconds, haptic + audio cue on completion
  Skip Rest button (outlined, small)

HR Zone badge from wearable (PulseRing + zone label)

RPE selector slider [NEW]:
  1–10 scale, shown after each set
  Gradient fill: green(1) → amber(5) → red(10)
  Haptic feedback per notch

Pause · Next · Finish buttons (bottom dock, glass row)
```

---

#### GPS Workout Screen

**Route:** `/home/workout/gps`
**Scaffold:** Pattern C

```
flutter_map: full-bleed, custom dark tile style
Offline tile cache: shows cached tiles without connectivity

Stats overlay glass card (bottom half):
  Distance (monoXL primary) · Duration · Pace (monoLg)
  Avg HR (monoLg rose) · HR Zone badge (PulseRing mini)

Offline indicator: teal glass pill "Offline Map"
  → shown when tile cache is active
```

---

#### Custom Workout Builder

**Route:** `/home/workout/custom`
**Scaffold:** Pattern A

**Body:**
```
Drag-and-drop exercise list (ReorderableListView):
  Each row glass card:
    Exercise name (h4)
    Sets / Reps inputs (compact inline)
    Rest timer input
    RPE input [NEW]
    Superset group selector (A/B/C pills) [NEW]
    Drag handle (right, 24×24, textMuted)

[+ Add Exercise] full-width outlined button (bottom)
[Save Plan] primary button
```

---

### 9.5 Steps & Activity

#### Steps Home

**Route:** `/home/steps`
**Scaffold:** Pattern B (`heroPrimary` gradient)

**Hero:**
```
Step count: heroDisplay (72sp) white with success glow
Circular PulseRing progress (success color)
Goal: bodyLg white70  "10,000 steps"
"Daily Goal Reached 🎉" → confetti Lottie on completion
```

**Body:**
```
Hourly step bar chart: glass card, animated bar fill, success color
7-day step trend: line chart, fl_chart, area fill with success20

Distance + Calories: side-by-side BentoCard (half each)
  monoLg value + label (bodyMd textSecondary)

Adaptive goal card (glass, teal border glow):
  "Your 7-day avg: 7,200 steps. New suggested goal: 8,000"
  [Accept ✓] [Keep current] pill buttons

Inactivity nudge card (amber glass, if >60 min inactive):
  "Time to move! 10-min walk? 🚶"
  [Start Walk] teal outlined button
```

---

### 9.6 Health Monitoring Screens

#### Blood Pressure Tracker

**Route:** `/blood-pressure`
**Scaffold:** Pattern B (`heroDeep` gradient)

**Hero:**
```
Latest reading: metricXL white (e.g. "128/82")
  → Each number has neon white glow
AHA classification badge: color-coded glass pill
Pulse: bodyOnDark
EncryptionBadge (glass, teal glow, bottom of hero)
```

**Body:**
```
BPTrendChart glass card:
  7 / 30 / 90 day toggle (pill tabs)
  Colored reference bands per AHA category
  Line chart with animated draw-in on tab switch

Log BP: floating primary FAB (glow)

Log Bottom Sheet:
  [Systolic ___] mmHg
  [Diastolic ___] mmHg
  [Pulse ___] bpm (optional)
  [Notes textarea]
  EncryptionBadge
  [Save BP Reading] primary full-width

Morning/evening reminder row (glass card):
  Clock icon + reminder time + edit toggle
```

---

#### Blood Glucose Tracker

**Route:** `/glucose`
**Scaffold:** Pattern B (`heroDeep`)

**Hero:**
```
Latest value: metricXL white + reading type tag
Classification badge (color-coded pill)
EncryptionBadge in hero
```

**Body:**
```
Reading type selector pills: Fasting · Post-meal · Random · Bedtime

GlucoseHistoryChart glass card:
  Target band per reading type (colored region)
  Line chart with animated draw-in

HbA1c estimator card [NEW] (glass, secondary glow):
  Shown if ≥30 readings
  "Estimated HbA1c: 5.8% (Normal)"
  Note: "Based on 90-day average. Confirm with lab test."

Meal correlation row: linked food log for post-meal readings
"Import from Lab Report →" row (links to /home/food/lab-scan)
```

---

#### SpO2 Tracker

**Route:** `/spo2`
**Scaffold:** Pattern B (`heroDeep`)

**Hero:**
```
Latest SpO2 %: metricXL white with teal glow
Pulse: bodyOnDark
Timestamp: caption white54
Alert banner (if <95%): error glass card, "⚠ SpO2 is low.
  Seek medical attention if this persists."  PulseRing (error color)
```

---

### 9.7 Lab Reports & ABHA Screens

#### Lab Reports Home

**Route:** `/lab-reports`
**Scaffold:** Pattern A
**Title:** "Lab Reports / लैब रिपोर्ट्स"

**Layout:**
```
"Scan New Report" — full-width neon CTA card:
  Scan icon (Lottie loop) centered
  primaryGlow border
  [📷 Scan New Report] white text on primary bg

Imported Reports glass list:
  Each row: lab name · date · imported metrics count · [View →]
  Swipe right → share, swipe left → delete

"Import from ABHA" glass card (if ABHA linked):
  Pulls verified lab records from national health system
  [Import Records] teal outlined button

Privacy footnote (glass card, teal border):
  🔒 "All imported values stored encrypted on your device only."
  EncryptionBadge centered
```

---

#### ABHA Account Screen

**Route:** `/abha`
**Scaffold:** Pattern A
**Title:** "ABHA Health ID / आयुष्मान भारत"

**Layout:**
```
ABHALinkBadge — large, full-width glass card:
  If linked: success glow, ABHA ID (masked XX-****-****-XXXX),
             last sync timestamp, verified ✓ badge
  If not linked: warning glow, "Link your national health ID"

Benefits card (if not linked) — glass, secondary border:
  "Why link ABHA?" header
  List: ✓ Verified lab history  ✓ Hospital records  ✓ Vaccination records

Link ABHA section (if not linked):
  14-digit input field + "Verify via OTP →" primary button

Linked Records (if linked):
  Glass list rows: source institution · record type · date · [Import] button

Consent note: bodyMd italic, textSecondary
  "You control what data is pulled. FitKarma never shares your ABHA data."

EncryptionBadge centered — pulsing teal glow
```

---

### 9.8 Lifestyle Tracker Screens

#### Sleep Tracker

**Route:** `/sleep`
**Scaffold:** Pattern B (`heroSleep` gradient — darkest, 3-stop)

**Hero:**
```
Last night's duration: metricXL white
Quality emoji: 😊 / 😐 / 😴 (large, animated float)
"Good Sleep" / "Poor Sleep" glass badge
```

**Body:**
```
7-day sleep bar chart: glass card, animated fill
  Bars color-coded: green (≥7h) / amber (6-7h) / red (<6h)

Sleep Debt card [NEW] glass (secondary glow):
  "You're 2h 40min in sleep debt this week"
  Debt: red deficit bar | Credit: green surplus bar
  Animated bar fill on mount

Chronotype card [NEW] (appears after 30+ days):
  "You're an 🦉 Night Owl"
  "Optimal sleep window: 11:30pm – 7:30am"
  Indigo glass card with moon icon animation

Ayurvedic sleep tip (if avg <6h):
  Glass card, teal border, 🌿 icon

[Log Sleep] primary floating FAB
```

---

#### Habit Tracker

**Route:** `/habits`
**Scaffold:** Pattern A

**Body:**
```
Today's Habits — stack of glass habit cards:
  Habit icon (colored, matches category)
  Habit name (h4) + target count completion bar (animated)
  Streak badge (StreakFlameWidget — size scales with streak)

  Streak Recovery button [NEW] (if streak broken ≤24h ago):
  "🔥 Recover streak · 50 XP" — amber outlined pill button
  → amber confirmation bottom sheet

Weekly heatmap (GitHub-style):
  Glass card, one row per habit
  Cell color: surface1 (none) → primary50 → primary100 (full)

Streak stats: current streak vs. longest streak per habit
  monoLg for both numbers, side-by-side glass card
```

---

### 9.9 Wellness Screens

#### Journaling

**Route:** `/journal`
**Scaffold:** Pattern A
**App bar:** "Journal / जर्नल" + EncryptionBadge (right of title)

**Body:**
```
Today's prompt card (amber glass card):
  "📝 [Prompt driven by logged data]"
  e.g. "You logged 'anxious' 4 times this week —
        what was the common trigger?"

flutter_quill rich text editor (full-screen glass card):
  Formatting toolbar: Bold · Italic · Bullet · Heading
  Min height: 200px, expands to fill

Mood score selector row:
  5 emoji buttons (😡 😟 😐 😊 🤩)
  Selected emoji: scale pop + primary ring
  Tags row: glass chips (Stressed · Happy · Tired · Calm...)

Sentiment summary card [NEW] (appears after 30+ entries):
  Indigo glass card + TrendChip
  "Your mood has been trending 📈 upward this month"
  On-device analysis, no cloud processing

Past entries list:
  Glass list cards: date · first line · mood emoji
  Tap → full-screen read view with slide transition
```

---

#### Mental Health Hub

**Route:** `/mental-health`
**Scaffold:** Pattern A

**Body:**
```
CBT Insight card [NEW] (CorrelationInsightCard variant):
  "On days you slept <6h, you logged 'irritable'.
   Better sleep may help."
  Sleep → Mood module icons

Stress Programs: horizontal scroll, glass cards
  7-day plan cards: program name · day count · start button

Breathing exercise quick-start:
  Glass card with animated breathing circle (Rive: expand/contract)
  4-7-8 or Box breathing option pills

Burnout risk gauge (if applicable):
  Semicircle gauge, color bands (green→amber→red)
  Current level marker with drop shadow

Indian helplines glass card (critical, always visible):
  iCall · Vandrevala Foundation · NIMHANS
  Each: name + phone + [📞 Call] teal button
```

---

### 9.10 Social & Community Screens

#### Social Feed

**Route:** `/home/social`
**Scaffold:** Pattern A

**Body:**
```
Stories row: horizontal scroll, avatar circles (48px)
  Active story: primary ring glow, pulsing animation
  Viewed: dimmed ring

Post cards (glass, full-width):
  Avatar · name · timestamp
  Content text (bodyMd)
  Media: full-width inside card (hidden in Low Data Mode)
  Likes · comments row (icon + count)

Social Karma indicator [NEW]:
  "+5 XP" amber text float animation (coin_burst Lottie)
  Triggers when user's post receives a like

Create post FAB (primary, glowing)
```

---

#### Community Groups

**Route:** `/home/social/groups`
**Scaffold:** Pattern A

**Body:**
```
My Groups: horizontal scroll, glass group cards
  Group name · member count · category pill

Discover Groups: categorised glass list
  Diet · Location · Sport · Support

Team vs Team challenge banner [NEW]:
  Full-width glass card, primary border glow
  "Mumbai Runners vs Delhi Pacers — Steps challenge"
  Progress bars for both teams, ends in countdown
```

---

### 9.11 Reports & Wearables

#### Health Reports

**Route:** `/reports`
**Scaffold:** Pattern A

**Body:**
```
Period tabs: Weekly · Monthly (pill tab bar)

Most recent report glass card:
  Summary stats (monoLg values)
  [View PDF] outlined | [Share with Doctor →] primary outlined [NEW]

Share with Doctor flow [NEW]:
  → Loading card: "Generating shareable link..."
     HealthShareCard appears (spring slide in):
     "Link expires in 7 days" — countdown ring (TrendChip)
     [Share via WhatsApp] — green primary button (brand)
     [Copy Link] — glass outlined
     [Delete Link] — error text button

Past reports list: date · period · status pill · view arrow
```

---

#### Wearable Connections

**Route:** `/wearables`
**Scaffold:** Pattern A

**Body:**
```
Connected device glass cards (full-width):
  Device logo + name + last sync time
  Sync status pill (success/warning/error glow)
  [Disconnect] text button (error color)

[+ Add Wearable] outlined primary button (bottom)
Device logos: Fitbit · Garmin · Health Connect · HealthKit
```

---

### 9.12 Family & Emergency

#### Emergency Health Card

**Route:** `/emergency`
**Scaffold:** Pattern A with **error-colored app bar accent stripe** (5px top border, error color)
**Title:** "Emergency Card / आपातकाल कार्ड"
**Access:** No biometric lock override — accessible during emergencies

**Body:**
```
Blood Group: metricLg chip, ABO-color-coded background
  (A=teal, B=purple, AB=primary, O=success, +/- modifier pill)

Allergies: error-outlined glass chips (red glow)
Conditions: warning-outlined glass chips (amber glow)
Medications: glass list (auto-pulled from medication module)

Emergency Contact glass card:
  👤 Name + 📞 Phone
  [📞 Call Now] → full-width error button (red glow)

Doctor glass card: same layout, teal glow

Insurance: glass card — policy number + insurer name

Bottom action row:
  [Export PDF] outlined | [Show QR] outlined
  QR code bottom sheet on "Show QR" tap
```

---

### 9.13 Settings & Profile Screens

#### Profile Screen

**Route:** `/profile`
**Scaffold:** Pattern B (`heroDeep` gradient)

**Hero:**
```
Avatar: 80px circle, primary glow ring, upload tap handler
Name: displayMd white
Email: caption white54
KarmaLevelCard compact variant (overlaps hero bottom)
```

**Body:**
```
DoshaDonutChart glass card (animated draw on enter):
  120px donut + percentage legend (Vata/Pitta/Kapha)

Personal info glass section:
  Editable rows: Goal · Height/Weight · DOB · Blood Group · Language
  Each row: icon + label + value + edit icon (pencil)

ABHA status row [NEW]:
  ABHALinkBadge compact
  "Linked 🟢" or "Link now →" amber CTA

Achievements bento grid:
  Earned: color icon, glow
  Unearned: grey icon, surface0 bg, 🔒 lock overlay

Referral glass card (amber gradient):
  "Refer friends, earn 500 XP each! 🎁"
  [Share Referral] primary button
```

---

#### Settings Screen

**Route:** `/settings`
**Scaffold:** Pattern A
**Title:** "Settings / सेटिंग्स"
**Background:** bg2 (slightly lighter than bg1 for contrast)

**Layout:** Grouped glass section cards (not legacy list tiles)

| Section | Settings |
|---|---|
| **Account** | Edit Profile · Subscription status badge · Change Password · Linked accounts · ABHA account |
| **Preferences** | Language (22 options) · **Theme (Light / Dark / System)** · Font size slider · **Dyslexia-friendly font toggle** |
| **Notifications** | Per-module slides: Meal reminders · Step nudges · BP/Glucose reminders · Lab report reminder · Social activity · Challenges · Morning briefing |
| **Privacy & Security** | Biometric lock toggle · Data Export JSON · **Account Deletion** (error text) |
| **Data & Sync** | Low Data Mode · Sync interval · Wearable connections · **Pending sync items** (DLQ count) · **View failed sync items** |
| **Health Permissions** | Status rows: Step counter · Heart rate · Sleep · Location (GPS) |
| **Home Widgets** | → links to `/home-widgets` |
| **About** | App version · Privacy Policy · Terms · Contact support |

**Each section:** Glass card with `radiusLg`, section header `BilingualLabel` above.

**Toggle style:** Custom pill toggle (not Material switch) — spring animation, primary fill when ON.

**Logout:** Error-colored text button, horizontally centered, separated by `Divider`, bottom of screen.

---

#### Subscription Plans

**Route:** `/subscription`
**Scaffold:** Pattern A

**Layout:**
```
Hero glass card (amber gradient bg):
  "Unlock Full FitKarma ⚡" — displayLg white
  3 key feature highlights (icon + label rows)

Plan cards (vertical stack of glass cards):
  Monthly ₹99 · Quarterly ₹249 · Yearly ₹899 · Family ₹1,499
  "Most Popular" — secondary glow badge on Quarterly
  "Best Value" — amber ribbon on Yearly
  [Start Plan] primary button per card
  [Pay via UPI] secondary outlined button

Feature comparison table (glass card):
  Free vs Premium checkmark columns

[Restore purchase] text button
"7-day free trial, cancel anytime" — caption, centered, textMuted
```

---

### 9.14 Festival & Wedding Screens

#### Festival Calendar Home

**Route:** `/festival-calendar`
**Scaffold:** Pattern A
**Title:** "Festivals & Events / त्योहार & आयोजन"

**Layout:**
```
Active Festival Banner (shown only during active festival):
  Glass card, festival-specific gradient left border (5px)
  "🪔 Navratri — Day 5 of 9  ·  नवरात्रि"
  "Phalahar diet active"  FestivalDietBadge
  [View Diet Plan]  [Garba Tracker 💃]  pill buttons
  Replaces InsightCard during festival

Upcoming Festivals list — FestivalCard widgets:
  Glass card, festival icon, bilingual name
  Date range + fasting type pill + region pill
  [Set Reminder]  [View Diet Plan]
  Swipe-left → "Hide festival" (filters by religion/region)

Region Filter chips (horizontal scroll):
  All · Hindu · Muslim · Sikh · Christian · Jain · Buddhist · National
  Glass pills, primary-selected

Calendar Month View (glass card):
  mini calendar with festival dots per date
  Tap date → scroll to that festival card

Past Festivals (collapsible glass card):
  Completed festivals + logged data summary

"Plan a Wedding 💍" CTA card (amber glass):
  "Planning for a Wedding?"
  "Get a personalised diet & fitness plan tailored to your role."
  [Start Wedding Planner →] primary button
```

---

#### Festival Diet Plan Detail

**Route:** `/festival-calendar/{festivalKey}/diet`
**Scaffold:** Pattern B (festival-specific gradient hero)
**Hero:** Festival name bilingual · Fasting type `FestivalDietBadge`

**Body:**
```
Fasting Overview glass card:
  Duration · fasting type · restrictions summary

Allowed Foods grid (if fasting active):
  2×N FoodItemCard grid filtered to allowed items
  Tap → food log with pre-filtered search

Forbidden Foods glass card:
  Error-outlined pill list (grains, onion, garlic etc.)

Meal Plan tabs (Day 1 … Day N):
  FestivalDietBadge per day + Breakfast/Lunch/Dinner/Snacks suggestions

Quick Log FAB:
  "Log Phalahar Meal" (Navratri)
  "Log Sehri" / "Log Iftar" (Ramadan)
  Label changes per active festival

Festival Insight cards (InsightCard variant, festival tint):
  "Sabudana khichdi gives slow-release carbs — ideal for Navratri."

Workout Note banner (amber glass):
  "Reduce workout intensity during Nirjala fast. Gentle yoga recommended."
```

**Ramadan specifics:**
```
Sehri Countdown: PulseRing countdown clock (pre-sunrise)
Iftar Countdown: PulseRing countdown (sunset, GPS-computed)
30-Day Log: Calendar heatmap of Sehri/Iftar logging fidelity
```

**Karva Chauth specifics:**
```
Sargi Plan glass card: pre-sunrise meal plan
Moonrise Countdown: PulseRing (astronomical formula + GPS)
Break-fast Plan: appears 30 min before moonrise
  Dates · water · puja prasad calories
```

---

#### Wedding Planner Onboarding Flow

**Route:** `/wedding-planner/setup`
**Scaffold:** Pattern A
**Title:** "Wedding Planner / विवाह योजनाकार"
**Progress:** Segmented bar (Steps 1–6, same as onboarding)

**Step 1 — Role Selection:**
```
"Who are you in this wedding?"
"इस विवाह में आपकी भूमिका क्या है?"

2×2 WeddingRoleChip grid:
  [👰 Bride / दुल्हन]   [🤵 Groom / दूल्हा]
  [🎉 Guest / मेहमान]  [👨‍👩‍👧 Relative / रिश्तेदार]

Each chip: 150×160px glass card, center illustration
Selected: primary border (glow), checkmark badge, spring pop
```

**Step 1b — Relation (if Relative selected):**
```
Pill-chip multi-select (single-select):
[Father of Bride] [Mother of Bride]
[Father of Groom] [Mother of Groom]
[Sibling]        [Close Family]
```

**Step 2 — Wedding Dates:**
```
"When is the wedding? / विवाह कब है?"

Two date picker cards side by side:
  [📅 First Event]  [📅 Last Event]
  Material3 DateRangePicker (theme: primary color)

Below: "Wedding Period: Oct 15 – Oct 18 · 4 days"
  glass card, animated appearance

Auto-detect: amber notice if dates overlap with a festival
Validation: End ≥ Start, max 14-day range
```

**Step 3 — Events:**
```
"Which events are happening? / कौन सा कार्यक्रम है?"
Checkbox tile cards, 2-column bento:

  ☑ 🟡 Haldi     ☑ 💃 Mehendi
  ☐ 🎵 Sangeet   ☐ 🐴 Baraat
  ☑ 💍 Vivah     ☐ 🎊 Reception

Selected: orange checkbox (filled) + primaryMuted bg + spring
```

**Step 4 — Prep Time:**
```
Horizontal scroll chips (single-select):
[1 week] [2 weeks] [4 weeks] [8 weeks] [Already wedding week]

"Already wedding week" → skips fitness plan, goes to wedding-week diet
```

**Step 5 — Primary Goal (role-aware):**
```
Bride / Groom:           Guest / Relative:
[💪 Look my best]        [🍽 Manage indulgence]
[⚡ Feel energised]      [🏃 Stay active]
[🧘 Manage stress]       [📅 Maintain routine]

Glass chips, icon + label, single-select, spring pop
```

**Step 6 — Summary:**
```
Glass card summary:
  "Your Wedding Plan is Ready! 🎊"
  Role · Dates · Events · Prep · Goal rows

"📋 Your personalised plan includes:" list:
  • 4-week pre-wedding diet & fitness schedule
  • Event-by-event meal plans
  • Bloat-free wedding day nutrition guide
  • Post-wedding recovery plan

[🚀 Start My Wedding Plan →]  primary, full-width, glow
[Edit Details]  text link
```

---

#### Wedding Planner Home

**Route:** `/wedding-planner`
**Scaffold:** Pattern B (`heroWedding` gold gradient)

**Hero:**
```
"💍 Your Wedding Plan"  displayMd white
"Role: Bride  ·  Phase: Pre-Wedding (Week 3 of 4)"
"Wedding in 18 days  ·  Main ceremony: Oct 18"
```

**Body:**
```
Phase Progress glass card:
  "Pre-Wedding Week 3 of 4" + animated progress bar
  Sub-phase pill: Pre-wedding → Wedding Week → Post-Wedding

Today's Plan glass card (primary border glow):
  "📅 Today · Week 3, Day 4"
  Diet Phase: Lean & Glow
  Breakfast / Lunch / Dinner rows
  Workout: 30 min HIIT + 15 min yoga
  [Log Today's Meals]  [Start Workout]

Event Countdown strip (horizontal scroll):
  [🟡 Haldi · 5d]  [💃 Mehendi · 6d]  [💍 Vivah · 7d]
  Glass pill chips, tap → event detail screen

Wedding Tips (InsightCard amber variant):
  Role-specific tips. Bride: "Avoid cruciferous veggies this week..."

Pre-Wedding Fitness Plan glass card (compact):
  Current week workout schedule
  [View Full Plan →] text link

Wedding Grocery List glass card:
  "Generate shopping list for wedding week"
  [Generate List] primary outlined button
```

---

#### Wedding Event Day Screen

**Route:** `/wedding-planner/event/{eventKey}`
**Scaffold:** Pattern A
**Title:** e.g., "Sangeet Night / संगीत रात"

**Body:**
```
Event EventDayCard:
  Time · Duration · Energy demand badge (Low/Medium/High glow)
  Role-specific note

Pre-Event Meal Plan glass card:
  ⏰ Timed meal rows (icon + time + meal + kcal)
  ❌ Avoid list (error-outlined chips)

During-Event Tips: scrollable tip chip cards (glass, accent border)

Post-Event Recovery Meal glass card:
  "Post-Sangeet: Warm milk + banana..."
  Timestamp: "Best before 1 AM"

[Log Sangeet Meal] primary button → food log with event tag

Calorie Budget glass card:
  Event-day target (monoLg) · Dance burn estimate (monoLg success)
```

---

#### Wedding Post-Event Recovery

**Route:** `/wedding-planner/recovery`
**Scaffold:** Pattern A
**Title:** "Post-Wedding Recovery / विवाह के बाद"

**Body:**
```
Celebration glass card (amber gradient):
  "You made it! 🎊 Time to restore and recharge."

3-Day Detox Plan — timeline glass card:
  Day-by-day: moong dal khichdi · coconut water · fruits

Return to Normal: 5-day calorie increase chart (line, animated)

Workout plan glass card:
  "Walking + gentle yoga for 7 days. No high-intensity until Day 8."

"Share your wedding fitness journey" social CTA (optional, glass)

[Mark Wedding as Complete] — teal outlined button
  → Archives plan history in Drift
```

---

### 9.15 Home Screen Widget UI

#### Home Widget Configuration Screen

**Route:** `/home-widgets`
**Scaffold:** Pattern A
**Title:** "Home Widgets / होम स्क्रीन विजेट"

**Layout:**
```
Preview section:
  Phone mockup SVG (device-neutral) with HomeWidgetPreview inside
  Scaled 60% — updates live as user selects widgets

Widget catalogue (glass cards, full-width):
  Activity Rings (4×1): preview + [Add to Home Screen] primary button
  Quick Log (2×1):      preview + [Add to Home Screen] primary button
  Water Counter (2×2):  preview + [Add to Home Screen] primary button
  Festival/Wedding Countdown (2×2) [NEW]:
    preview + [Add to Home Screen] primary button
    Updates daily from Drift

Lock Screen section (glass card):
  Emergency Card widget (blood group chip + emergency number)
  [Add to Lock Screen] outlined button

"How to add widgets" collapsible glass card:
  3-step instructions (Android + iOS)
  Step illustrations (Lottie or static SVG)
```

---

## 10. Bottom Navigation Bar

Applies to all `/home/*` routes.

**Design:** Floating pill nav bar — not a traditional bottom bar.

```
Container:
  Background: glass (surface1 + blur 16px)
  Border: 1px glassBorder
  Margin: 12px from bottom safe area, 16px horizontal
  Border-radius: radiusFull (9999px)
  Height: 64px
  Elevation 2 shadow
```

| Tab | Icon | English | Hindi | Route |
|---|---|---|---|---|
| 1 | `home_outlined` / `home` filled | Home | मुख्यपृष्ठ | `/home/dashboard` |
| 2 | `restaurant_outlined` / filled | Food | खाना | `/home/food` |
| 3 | `fitness_center_outlined` / filled | Workout | वर्कआउट | `/home/workout` |
| 4 | `directions_walk_outlined` / filled | Steps | कदम | `/home/steps` |
| 5 | `person_outline` / `person` filled | Me | मैं | `/profile` |

**Active tab:** Icon + label visible, primary color, soft primary glow behind icon (Tier: mid/high; glow off Tier: low).
**Inactive tab:** Icon only (no label), textMuted.
**Active tab indicator:** Soft pill highlight behind active icon (primaryMuted, `radiusFull`).
**Transition:** Icon morphs on select (spring scale 0.8 → 1.1 → 1.0 + color transition — light spring).

**Dark mode:** Glass blur visible against bg1 backdrop.
**Light mode:** Glass with warm tint, divider border.

#### UXStage.firstWeek — All-Labels Mode

During the first 7 days (`UXStage.firstWeek`), **all 5 tabs show their label** regardless of active state. This solves the icon-only discoverability problem for new users unfamiliar with the navigation pattern.

```dart
// lib/shared/widgets/bottom_nav_bar.dart
final stage = ref.watch(uxStageProvider);
final showAllLabels = stage == UXStage.firstWeek;

// If showAllLabels: render label beneath every tab icon (not just active)
// Label style for inactive tabs in all-labels mode:
//   style: caption (11sp), color: textMuted
// After firstWeek → standard behaviour (active label only)
```

**Additionally:** On first launch only (day 0), a one-time tooltip-on-long-press is registered for each tab: long-pressing any inactive tab shows a `Tooltip` with the tab name for 1.5 seconds. Tooltip is dismissed once per tab and never shown again.

```dart
// Tooltip spec
Tooltip(
  message: tabLabel,
  preferBelow: false,
  decoration: BoxDecoration(
    color: surface2, borderRadius: BorderRadius.circular(8),
  ),
  textStyle: TextStyle(color: textPrimary, fontSize: 12),
)
```

---

## 11. Common UI Patterns

### Log Bottom Sheet

All "Log [metric]" actions open a bottom sheet — consistent structure:

```
Drag handle: 40×4px, centered, divider color, 12px top margin
  → spring bounce on first appearance

Title row: BilingualLabel (English h2 + Hindi)
           EncryptionBadge right-aligned (sensitive screens)

Form fields (glass surfaces): stacked with 12px gap
  Focus: primary border glow (0 0 0 4px primaryMuted)

Primary CTA: full-width, primaryGlow, radiusMd
  → haptic feedback on tap
  → CountUp animation on success
```

### Inline Metric Cards

All health metric screens show a summary glass card at the top:

```
Latest value: GlowingMetric (metricLg or monoXL)
Classification: color-coded pill with matching glow
Trend: TrendChip (▲ rising / ▼ falling / → stable)
```

### Correlation Insight Card

```
Glass card (secondary border glow):
  "🔗 Sleep + Mood Insight"    — h4 textPrimary
  "Your mood drops on nights with <6h sleep."
  "Pattern detected over 8 days."
  Module pills: [💤 Sleep] → [😊 Mood]   👍 👎
  → Module pills link to respective module on tap
```

### Streak & Gamification Elements

- **Streak banners:** StreakFlameWidget (Lottie, size scales with count) + bold white text, orangeGradient bg
- **XP float animations:** Amber "+X XP" text floats 48px up, fades (coin_burst Lottie, 500ms)
- **Level-up:** Full-screen indigo overlay + confetti Lottie + new level title in displayLg (spring entrance)
- **Streak recovery sheet:** Amber glass bottom sheet — "Recover streak for 50 XP? Once per month per habit." — Confirm / Cancel

### Sync Status Patterns

- **DLQ warning banner:** Amber glass top banner, `syncDeadLetterCount > 0`. "⚠ 2 items failed to sync. Tap to review." → Settings → Data & Sync
- **Offline banner:** Teal glass pill "Offline — changes saved locally" (non-blocking toast style)
- **Low Data Mode banner:** Persistent teal glass pill at top of scaffold

### Section Headers

```dart
// BilingualLabel component (used as section header)
Row:
  Container(width: 3px, height: 18px, color: primary, radius: radiusFull)
  SizedBox(8px)
  Column:
    Text(english, style: h3)
    Text(hindi, style: hindi)
  Spacer()
  [Optional: "See all →" text button]
```

### Navigation Pattern for Detail Screens

- Always accessible via back arrow (GestureDetector + hero transition where applicable)
- `extendBodyBehindAppBar: true` on hero screens
- Sensitive screens (journal, period, BP logs): biometric re-auth if `biometricLock` enabled
- Bottom safe area respected — no CTAs hidden behind home indicator

---

## 12. Accessibility & Bilingual Rules

### 12.1 Strategic Bilingual Requirements

> Bilingual labelling is a **differentiator**, not a requirement on every element. Applying it everywhere doubles text density, clutters small screens, and dilutes its impact. Apply bilingual **only where it adds genuine comprehension value**.

**✅ Bilingual REQUIRED:**

| Location | Format | Reason |
|---|---|---|
| Bottom nav labels (active tab only) | English 10sp SemiBold + Hindi 9sp Regular below | Primary navigation — high-frequency, all users |
| Screen app bar titles | English `h1` + Hindi `hindi` sub-label (smaller, muted) | Screen identity — seen on every entry |
| Section headers | English `h3` + Hindi 11sp (via `BilingualLabel`) | Structural wayfinding |
| Food names in food cards | `name` (English) + `name_local` (Devanagari, smaller) | Indian food recognition — critical for logging |
| Search bar placeholder | Bilingual placeholder string | Hindi-first users benefit greatly here |
| Lab value names | English + common Hindi term | Medical literacy — e.g., "Glucose / शर्करा" |
| Onboarding screen titles | English + Hindi — sets language tone early | First impression for regional users |
| Festival card names | English + Hindi — both are the identity | Festival names ARE bilingual in Indian culture |

**❌ Bilingual NOT applied:**

| Location | Reason |
|---|---|
| Primary CTA button labels | Adds no comprehension — clutters the action |
| Metric values and numbers | Numbers are universal — no translation needed |
| Chart axis labels | Too small; bilingual doubles clutter |
| Settings row labels | English is expected in settings; adds noise |
| Chip/pill filter labels | Too compact; truncation risk |
| Error messages | Detected by system locale — handled by l10n, not manual bilingual |
| Badge text (XP, Level, etc.) | Universal gaming vocabulary |
| Timestamps and captions | Space-constrained; use l10n entirely |

### Accessibility Standards

- **Minimum tap target:** 44×44px for ALL interactive elements (including LabValueRow edit icons, glass chip pills)
- **Color contrast:** All text meets **WCAG AA** (4.5:1 minimum). Glow effects do not count toward contrast ratio.
- **`textMuted` usage constraint:** `textMuted` (`#6B68A0` dark / `#B0AEC8` light) achieves ≈ 4.6:1 on `bg1` — just above WCAG AA. It **must only be used for decorative or placeholder text** (inactive icons, empty input hints, timestamps). Never use `textMuted` for informational text that a user must read to complete a task — use `textSecondary` instead.
- **Screen reader:** All `IconButton` widgets have `Semantics` labels. All images have `Semantics` descriptions. Glass cards have `Semantics(container: true)`.
- **Font scaling:** All text respects system font size settings. No hardcoded `textScaleFactor` overrides.
- **Dyslexia-friendly font:** Toggle in Settings → Preferences → switches body text to OpenDyslexic (bundled asset). Does NOT affect metric/mono font styles.
- **High contrast mode:** black/white with orange accents only, zero gradients, zero glass blur. Toggle in Settings → Theme.
- **Motion reduce:** All spring animations simplified to cross-fade when `AccessibilityFeatures.disableAnimations` is true.

### Dark Mode Accessibility

- All dark surfaces meet WCAG AA contrast against `#0F0F1A` background
- Glow effects are supplementary — never the sole conveyor of meaning
- Dark mode ring track: `divider` dark (`rgba(255,255,255,0.08)`) — not black-on-black invisible
- Amber/warning elements in dark mode: `#FFD54F` (lightened) for 4.5:1 minimum contrast
- `textMuted` on `bg1` passes at ≈ 4.6:1 — within AA but must remain decorative-only (see above)

### Low Data Mode UI Adaptations

- All `Image.network` → `#2C2C3E` (dark) / `#EEE8E4` (light) placeholder squares
- Social feed: text-only glass cards
- Food card thumbnails: food emoji placeholder instead of photo
- No video thumbnails in workout grid — glass text-only cards
- Lab Report OCR: still works (on-device, zero network required)
- Backdrop blur: **disabled** in Low Data Mode (GPU-intensive — degrades performance on low-end devices). Glass cards fall back to `surface1` solid background.
- Persistent teal glass pill "Low Data Mode" at top of scaffold

---

*FitKarma UI Design System*
*Flutter 3.x · Riverpod 2.x · Drift · Appwrite*
*Offline-first · Privacy-centric · Built for India*
*45+ screens · Full bilingual UI · Dark-first design · 28 shared components · Spring physics throughout*