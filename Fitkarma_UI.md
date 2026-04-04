# FitKarma — UI Design System (Revised v2.0)
## Applied Across All 45+ Screens

> **Offline-First · Privacy-Centric · Built for India**
> Flutter 3.x · Riverpod 2.x · Drift · Appwrite
>
> **v2.0 Changes:** Full dark mode token set. New screens: Lab Report OCR, ABHA, Home Widget Config, Shareable Health Report. Updated food screen with "Copy Yesterday" and restaurant deep-links. Updated Settings with dark mode toggle. New correlation insight card component. Home screen widget specifications.

---

## Table of Contents

1. [Design Principles](#1-design-principles)
2. [Global Design Tokens](#2-global-design-tokens)
3. [Typography Scale](#3-typography-scale)
4. [Universal Screen Rules](#4-universal-screen-rules)
5. [Two Base Scaffold Patterns](#5-two-base-scaffold-patterns)
6. [Shared Component Library](#6-shared-component-library)
7. [Screen-by-Screen UI Specifications](#7-screen-by-screen-ui-specifications)
   - [Onboarding & Auth](#71-onboarding--auth-screens)
   - [Core Dashboard & Karma](#72-core-dashboard--karma)
   - [Food & Nutrition](#73-food--nutrition-screens)
   - [Workout](#74-workout-screens)
   - [Steps & Activity](#75-steps--activity)
   - [Health Monitoring](#76-health-monitoring-screens)
   - [Lab Reports & ABHA](#77-lab-reports--abha-screens-new)
   - [Lifestyle Trackers](#78-lifestyle-tracker-screens)
   - [Wellness](#79-wellness-screens)
   - [Social & Community](#710-social--community-screens)
   - [Reports & Wearables](#711-reports--wearables)
   - [Family & Emergency](#712-family--emergency)
   - [Settings & Profile](#713-settings--profile-screens)
   - [Festival & Wedding](#714-festival--wedding-screens-new)
   - [Home Widgets](#715-home-screen-widget-ui--updated)
8. [Bottom Navigation Bar](#8-bottom-navigation-bar)
9. [Common UI Patterns](#9-common-ui-patterns)
10. [Accessibility & Bilingual Rules](#10-accessibility--bilingual-rules)

---

## 1. Design Principles

Every screen in FitKarma must follow these six core UI principles without exception:

| Principle | What it means in practice |
|---|---|
| **Offline-first feel** | No skeleton screens on core actions. UI updates from Drift immediately. Shimmer only for background async loads. |
| **Warm and Indian** | Light background always `#FDF6EC`. Dark background `#121218` — dark indigo, not pure black. Every screen has at least one culturally contextual element — Indian food units, Hindi sub-labels, Ayurvedic tips, or festival context. |
| **Orange drives action** | Every primary CTA, active state, FAB, and ring is Deep Orange `#FF5722`. Users learn that orange = act. This applies in both light and dark modes. |
| **Dark hero, warm body** | Screens with a strong metric to lead with (BP, Sleep, Fasting, Karma) use a dark indigo gradient hero section that transitions into the body below. In dark mode the hero becomes slightly lighter indigo to maintain contrast. |
| **Privacy visible** | Any screen that stores encrypted data shows a visible 🔒 AES-256 badge near the relevant fields. Users must never wonder whether their data is protected. |
| **Dark mode is first-class** | Every screen, component, and token has an explicit dark variant. Dark mode is not an afterthought — it is designed alongside the light mode with equal attention. |

---

## 2. Global Design Tokens

These tokens apply to **every single screen** in the app. No hardcoded hex values anywhere else.

### 2.1 Light Mode Colour Palette

| Token | Hex | Usage |
|---|---|---|
| `primary` | `#FF5722` | CTAs, FAB, active nav icons, active ring, focused borders |
| `primaryLight` | `#FF8A65` | Hover/pressed states, gradient end |
| `primarySurface` | `#FFF3EF` | Selected chip background, insight card tint |
| `secondary` | `#3F3D8F` | Hero sections, level badges, dark card gradients |
| `secondaryDark` | `#2C2A6B` | Gradient bottom stop for hero headers |
| `secondarySurface` | `#E8E7F6` | Light tint for secondary-accented chips |
| `accent` | `#FFC107` | Karma XP coins, insight card bg, recommended badge, streak reward |
| `accentLight` | `#FFECB3` | Insight card container background |
| `accentDark` | `#FF8F00` | XP text on amber bg |
| `background` | `#FDF6EC` | **All screen scaffold backgrounds (light mode)** |
| `surface` | `#FFFFFF` | Cards, bottom sheets, modals, input fields |
| `surfaceVariant` | `#F5F5F5` | Settings list backgrounds |
| `divider` | `#EEE8E4` | Card borders, list separators, input borders, shimmer base |
| `success` | `#4CAF50` | Steps ring, completed habits, normal health readings |
| `teal` | `#009688` | Water ring, SpO2 accent, ayurveda tips, medication |
| `purple` | `#9C27B0` | Active minutes ring |
| `warning` | `#FF9800` | Moderate risk readings, elevated BP |
| `error` | `#F44336` | Crisis readings, destructive actions |
| `rose` | `#E91E63` | Period cycle days, menstrual accent |
| `textPrimary` | `#1A1A2E` | All body copy, titles |
| `textSecondary` | `#6B6B8A` | Subtitles, labels, captions |
| `textMuted` | `#B0AECB` | Placeholder text, inactive nav, disabled states |

### 2.2 Dark Mode Colour Palette

> All dark mode tokens are defined in `lib/shared/theme/app_colors.dart` under `AppColorsDark`. Every token has a paired dark equivalent — never rely on the system to invert light-mode colors automatically.

| Token | Dark Hex | Notes |
|---|---|---|
| `background` | `#121218` | Deep indigo-black — not pure black |
| `surface` | `#1E1E2C` | Cards and elevated surfaces |
| `surfaceVariant` | `#252535` | Settings list backgrounds |
| `divider` | `#2C2C3E` | Borders and separators |
| `primary` | `#FF7043` | Slightly lighter orange for dark backgrounds |
| `primarySurface` | `#2A1E1A` | Selected chip background (dark) |
| `secondary` | `#5C59C4` | Hero sections in dark mode |
| `secondaryDark` | `#3D3BA0` | Gradient bottom stop (dark mode) |
| `secondarySurface` | `#1E1D3A` | Secondary-accented chips (dark) |
| `accent` | `#FFD54F` | Karma coins — slightly lighter on dark |
| `accentLight` | `#2C2200` | Insight card container (dark) |
| `accentDark` | `#FFCA28` | XP text on dark amber bg |
| `textPrimary` | `#F0EEF8` | All body copy, titles |
| `textSecondary` | `#9D9BBC` | Subtitles, labels, captions |
| `textMuted` | `#4A4860` | Placeholder text, inactive states |
| `success` | `#66BB6A` | Slightly brighter green for dark bg |
| `teal` | `#26C6DA` | Brighter teal for dark bg |
| `purple` | `#CE93D8` | Lighter purple ring on dark bg |
| `warning` | `#FFA726` | Slightly lighter amber |
| `error` | `#EF5350` | Slightly lighter red |

### 2.3 Dark Mode Hero Sections

In dark mode, hero sections use:
```
background: linear-gradient(#1A1035 → #2C2A6B)
```
This maintains the dark-hero identity while having enough contrast vs the `#121218` scaffold background.

### 2.4 Gradients

| Name | Direction | Light Colours | Dark Colours | Used on |
|---|---|---|---|---|
| `heroGradient` | Top-left → Bottom-right | `#3F3D8F` → `#2C2A6B` | `#1A1035` → `#2C2A6B` | All dark hero sections |
| `orangeGradient` | Top-left → Bottom-right | `#FF5722` → `#FF8A65` | `#E64A19` → `#FF7043` | Streak banners, CTA shimmer |
| `amberGradient` | Top-left → Bottom-right | `#FFC107` → `#FFD54F` | `#F9A825` → `#FFD54F` | Referral hero, subscription |
| `sleepGradient` | Top → Bottom (3-stop) | `#1A1A3E` → `#2C2A6B` → `#FDF6EC` | `#0D0D1E` → `#1A1A3E` → `#121218` | Sleep screen hero |

### 2.5 Shape & Elevation

| Token | Value | Used on |
|---|---|---|
| Card border radius | `12px` | All surface cards |
| Chip / pill border radius | `20px` | All filter chips, category pills |
| Bottom sheet border radius | `20px` top corners | All modal bottom sheets |
| Button border radius | `12px` | Primary and outlined buttons |
| Card elevation (light) | `2dp`, shadow `#0000001A` | Standard cards |
| Card elevation (dark) | Border `1px solid divider` | No shadows in dark mode — use borders instead |
| FAB shadow | `4dp` | QuickLogFAB |
| Input focus border | `2px solid primary` | All focused TextField inputs |
| Input default border | `1px solid divider` | All unfocused TextField inputs |

---

## 3. Typography Scale

All text uses system fonts: **Roboto** on Android, **SF Pro** on iOS. Devanagari script supported via system font on both platforms.

| Style name | Size | Weight | Light Colour | Dark Colour | Used for |
|---|---|---|---|---|---|
| `displayLarge` | 32sp | Bold 700 | `textPrimary` | `textPrimary` | Large metric numbers |
| `displayMedium` | 28sp | Bold 700 | `textPrimary` | `textPrimary` | Level titles |
| `h1` | 24sp | Bold 700 | `textPrimary` | `textPrimary` | Screen titles in hero |
| `h2` | 20sp | Bold 700 | `textPrimary` | `textPrimary` | Card headings |
| `h3` | 18sp | SemiBold 600 | `textPrimary` | `textPrimary` | App bar titles |
| `h4` | 16sp | SemiBold 600 | `textPrimary` | `textPrimary` | List item titles |
| `sectionHeader` | 14sp | Bold 700 | `textPrimary` | `textPrimary` | Section headings |
| `sectionHeaderHindi` | 11sp | Medium 500 | `textSecondary` | `textSecondary` | Hindi subtitle |
| `bodyLarge` | 16sp | Regular 400 | `textPrimary` | `textPrimary` | Main body |
| `bodyMedium` | 14sp | Regular 400 | `textPrimary` | `textPrimary` | List subtitles |
| `bodySmall` | 12sp | Regular 400 | `textSecondary` | `textSecondary` | Meta text |
| `labelLarge` | 14sp | SemiBold 600 | `textPrimary` | `textPrimary` | Card titles |
| `labelMedium` | 12sp | SemiBold 600 | `textPrimary` | `textPrimary` | Chip text |
| `caption` | 10sp | Regular 400 | `textMuted` | `textMuted` | Timestamps, fine print |
| `statLarge` | 22sp | Bold 700 | `textPrimary` | `textPrimary` | Dashboard ring stats |
| `statMedium` | 18sp | Bold 700 | `textPrimary` | `textPrimary` | Metric card values |
| `buttonLarge` | 16sp | Bold 700 | `white` | `white` | Primary button text |
| `h1OnDark` | 24sp | Bold 700 | `white` | `white` | Titles inside hero |
| `bodyOnDark` | 14sp | Regular 400 | `white70` | `white70` | Body in hero |
| `captionOnDark` | 11sp | Regular 400 | `white54` | `white54` | Fine print in hero |

---

## 4. Universal Screen Rules

These rules apply to **every screen** without exception.

### Layout
- Light scaffold background: always `#FDF6EC` unless dark hero pattern applies.
- Dark scaffold background: always `#121218` unless dark hero pattern applies.
- Bottom FAB clearance: minimum `100px` padding at the bottom of all scrollable bodies.
- Safe area insets respected on all screens.

### App Bar
- Light standard: `#FDF6EC` background, `textPrimary` icons, `h3` title, elevation 0.
- Dark standard: `#121218` background, `textPrimary` (dark variant) icons, elevation 0.
- Dark hero app bar: transparent, white icons and title, overlaid on the gradient hero — same in both themes.
- All app bar titles render bilingual where applicable.

### Inputs & Forms
- All `TextField` widgets use `InputDecoration` from the shared theme — never custom decoration per-screen.
- Focus state: `2px solid primary` border (same in both themes — primary adjusts per theme).
- Dark mode input background: `#1E1E2C` (surface).
- Autocomplete dropdowns use surface colour with divider separator rows.

### Bottom Sheets
- All log actions open bottom sheets, never new screens (except for full-page detail flows).
- Bottom sheet drag handle: `36px wide × 4px tall`, centred, `divider` colour.
- Bottom sheet background: `surface` (white in light, `#1E1E2C` in dark).

### Cards
- Light: white background, `2dp` shadow, `12px` radius.
- Dark: `#1E1E2C` background, `1px solid divider` border (no shadow), `12px` radius.

---

## 5. Two Base Scaffold Patterns

### Pattern A — Standard Light (most screens)

```
AppBar (elevation 0, background: scaffold bg)
  ↓ title: BilingualLabel (English h3 + Hindi 11sp)
  ↓ leading: back arrow or avatar
Scaffold background: #FDF6EC (light) / #121218 (dark)
Body: SingleChildScrollView → Column or ListView.builder
```

### Pattern B — Dark Hero + Warm Body (metric screens)

```
Stack(
  ┌─────────────────────────────────────────┐
  │  heroGradient container (280px)          │  ← transparent AppBar overlaid
  │    h1OnDark title                        │
  │    displayLarge metric                   │
  │    classification badge                  │
  └─────────────────────────────────────────┘
       ↕ 20px overlap
  ┌─────────────────────────────────────────┐
  │  Rounded top card (white / #1E1E2C)      │
  │    metric cards, charts, history         │
  └─────────────────────────────────────────┘
)
Scaffold background: always dark hero gradient at top, transitioning to scaffold bg
```

---

## 6. Shared Component Library

All widgets are in `lib/shared/widgets/`. Never re-implement per screen.

| Component | File | Description |
|---|---|---|
| `ActivityRingsWidget` | `activity_rings.dart` | Four concentric rings; accepts `progress 0.0–1.0` per ring; ring colours from tokens |
| `InsightCard` | `insight_card.dart` | Amber background; lightbulb icon; 👍/👎 rating; `accentLight` bg adapts to dark mode |
| `CorrelationInsightCard` | `correlation_insight_card.dart` | **NEW** — multi-module insight with icons for each contributing module |
| `FoodItemCard` | `food_item_card.dart` | Photo, bilingual name, portion, kcal, `+` tap handler; Low Data Mode emoji fallback |
| `KarmaLevelCard` | `karma_level_card.dart` | `heroGradient` bg, level progress bar, level title — same gradient in both themes |
| `DoshaDonutChart` | `dosha_chart.dart` | Three-segment donut using `fl_chart`; arc colours from tokens |
| `ChallengeCarouselCard` | `challenge_card.dart` | Horizontally scrollable; progress bar; XP reward; festival tag pill |
| `QuickLogFAB` | `quick_log_fab.dart` | Speed-dial orange FAB; sub-actions: Food, Water, Mood, Workout, BP, Glucose |
| `MealTypeTabBar` | `meal_tab_bar.dart` | Breakfast / Lunch / Dinner / Snacks tabs; icon + bilingual label |
| `ShimmerLoader` | `shimmer_loader.dart` | `divider` base colour adapts to dark mode |
| `BilingualLabel` | `bilingual_label.dart` | English `h3` + Hindi `sectionHeaderHindi` stacked |
| `EncryptionBadge` | `encryption_badge.dart` | 🔒 `AES-256` pill badge — teal fill, white text; shown on all sensitive data screens |
| `ABHALinkBadge` | `abha_badge.dart` | **NEW** — shows ABHA linked status; green when linked, amber when not |
| `HealthShareCard` | `health_share_card.dart` | **NEW** — share to doctor card; shows expiry countdown; share via WhatsApp CTA |
| `HomeWidgetPreview` | `home_widget_preview.dart` | **NEW** — scaled preview of the Android/iOS home screen widget |
| `MicronutrientBar` | `micronutrient_bar.dart` | **NEW** — compact progress bar for Iron/B12/VitD/Calcium with RDA % |
| `LabValueRow` | `lab_value_row.dart` | **NEW** — shows extracted lab metric with edit field and confirm toggle |
| `ErrorRetryWidget` | `error_retry_widget.dart` | Error state with Retry button and optional message; replaces bare `ErrorWidget` |
| `SyncStatusBanner` | `sync_status_banner.dart` | Persistent top banner for DLQ items; teal for low-data, amber for pending sync failures |
| `FestivalCard` | `festival_card.dart` | **NEW** — Festival name (bilingual), date range, fasting pill, region pill, Set Reminder + Diet Plan CTAs |
| `FestivalCountdownBanner` | `festival_countdown_banner.dart` | **NEW** — Active festival dashboard banner; festival-colour gradient; shows fasting mode + quick actions |
| `WeddingCountdownCard` | `wedding_countdown_card.dart` | **NEW** — Gold gradient card; days to wedding + next event; role badge; links to wedding planner |
| `WeddingRoleChip` | `wedding_role_chip.dart` | **NEW** — Illustrated large role card (Bride/Groom/Guest/Relative) for onboarding selection |
| `EventDayCard` | `event_day_card.dart` | **NEW** — Individual wedding event card with energy demand badge, pre/post meal plan summary |
| `FestivalDietBadge` | `festival_diet_badge.dart` | **NEW** — Pill badge showing active fasting type (Nirjala / Phalahar / Roza / Feast) |

---

## 7. Screen-by-Screen UI Specifications

---

### 7.1 Onboarding & Auth Screens

#### Splash Screen
**Scaffold:** Dark hero (no body)
**Content:** FitKarma logo centred, orange tagline, loading indicator.

#### Onboarding — Step 1: Personal Info
**Route:** `/onboarding/1`
**Scaffold:** Standard light
**Content:** Name · Gender · Date of Birth. Orange CTA "Next →". Progress pills at top (6 steps).

#### Onboarding — Step 2: Body, Goal & Activity
**Route:** `/onboarding/2`
**Content:** Height / weight inputs (metric/imperial toggle) · Fitness Goal selector chips (4 options) · Activity Level cards (5 options, illustrated).

#### Onboarding — Step 3: Chronic Conditions
**Route:** `/onboarding/3`
**Content:** Optional multi-select chip grid: Diabetes · Hypertension · PCOD/PCOS · Hypothyroidism · Asthma. Caption: "Selecting a condition activates a personalised management module." "Skip" text link.

#### Onboarding — Step 4: Dosha Quiz
**Route:** `/onboarding/4`
**Content:** 12 illustrated multiple-choice questions. Results displayed at end as `DoshaDonutChart` mini preview with vata/pitta/kapha percentages.

#### Onboarding — Step 5: Language & Permissions
**Route:** `/onboarding/5`
**Content:** Scrollable grid of 22 language options with script previews (single-select). Below language grid: Health permission consent rows for Step counter · Heart rate · Sleep — each with a toggle. Caption: "Permissions are used only for health tracking. You can change these in Settings."

#### Onboarding — Step 6: ABHA Link & Wearable
**Route:** `/onboarding/6`
**Scaffold:** Standard light
**Title:** "Link Your Health ID / अपना स्वास्थ्य ID जोड़ें"

**Layout:**
1. **`ABHALinkBadge`** — large variant, centred (shows "Not Linked" initially)
2. **Info card** — amber gradient: "Link your ABHA ID to auto-import past health records from hospitals and labs across India."
3. **ABHA ID input field** — 14-digit numeric field with format hint `XX-XXXX-XXXX-XXXX`
4. **OTP verification card** — appears after ID entry: 6-digit OTP input
5. **"Link ABHA Account"** — primary orange button (`+100 XP` badge below button)
6. **"Skip for now"** — text link below primary button
7. **Wearable connection row** (below ABHA section) — Fitbit / Garmin / Health Connect icons, "Connect Wearable" outlined button, "Skip" link

#### Login Screen
**Route:** `/login`
**Scaffold:** Standard light
**Layout:**
1. FitKarma logo + tagline
2. Email field + password field (show/hide toggle)
3. Primary orange "Login" button
4. "Forgot Password?" link
5. Divider "or"
6. Google Sign-In outlined button
7. Apple Sign-In button (iOS only)
8. "New here? Register" text link

#### Register Screen
**Route:** `/register`
**Scaffold:** Standard light
Same as Login but with name + email + password + confirm password fields.

---

### 7.2 Core Dashboard & Karma

#### Dashboard
**Route:** `/home/dashboard`
**Scaffold:** Standard light

**Layout:**
1. **Header row** — Avatar (40px circle), `BilingualLabel` greeting ("Namaste, [Name] 🙏"), karma XP chip (amber pill, `1,250 XP`), level badge (indigo pill, `Level 12 Warrior`)
2. **`ActivityRingsWidget`** — centred, four concentric rings; stats below each ring: value / goal + ring name
3. **`InsightCard`** — max 1 on dashboard; amber background; OR `CorrelationInsightCard` if a cross-module insight is active
4. **Today's Meals section** — `SectionHeader` + `MealTypeTabBar`; below the selected tab: list of `FoodItemCard` mini-variants (compact, no photo in Low Data Mode)
5. **Summary row** — two cards side by side: Latest Workout (icon + duration) + Sleep Recovery Score (coloured percentage)
6. **`ABHALinkBadge`** — compact variant, shown in header row if ABHA not yet linked
7. **`QuickLogFAB`** — orange speed-dial FAB, bottom-right above nav bar; expands to 6 sub-action buttons: Food · Water · Mood · Workout · BP · Glucose. Each sub-action opens its own dedicated log bottom sheet.
8. **Bottom Nav**

**Dark mode specifics:**
- `#121218` scaffold background
- Activity ring track fills darken to `divider` (dark) colour
- Cards: `#1E1E2C` with `1px divider` border
- Header avatar ring: `primary` (dark) instead of white

#### Karma Hub
**Route:** `/karma`
**Scaffold:** Pattern B (dark hero)
**Hero:** Level title `displayMedium white`, XP progress bar to next level, karma coin icon + total XP `displayLarge white`

**Body content:**
1. `SectionHeader` — "Daily Rituals / दैनिक अनुष्ठान"
2. Checklist — ritual name + completion indicator (green tick / empty circle) — driven by Ayurveda dosha data
3. `SectionHeader` — "Active Challenges / चुनौतियाँ"
4. `ChallengeCarouselCard` horizontally scrollable row — includes festival-tagged challenges
5. `SectionHeader` — "Leaderboards / लीडरबोर्ड"
6. Leaderboard tabs: Friends · City · National · Seasonal
7. Top 5 list per tab — avatar, name, XP, rank badge
8. Karma Store card — "Redeem XP" with available rewards + Streak Recovery option

> **Note:** The `DoshaDonutChart` is displayed on the **Profile screen** (Section 7.13) and the **Ayurveda Hub**, not on the Karma Hub. Loading Ayurveda data into the Karma provider is unnecessary coupling.

---

### 7.3 Food & Nutrition Screens

#### Food Home
**Route:** `/home/food`
**Scaffold:** Standard light
**App bar:** "Food / खाना" + `MealTypeTabBar` pinned below

**Body:**
1. **Daily macro ring summary** — 4 mini rings: calories, protein, carbs, fat
2. **Micronutrient progress row** (NEW) — 4 `MicronutrientBar` items: Iron · B12 · Vitamin D · Calcium
3. **Logged meals** — grouped by meal type matching selected tab; each entry shows `FoodItemCard` compact variant with swipe-to-delete
4. **"Copy Yesterday's Meals"** banner (NEW) — amber-tinted card: "Copy all meals from yesterday → 1,840 kcal saved". Orange `Copy` button. Shown only if today's log is empty.

#### Food Log Screen (`Log Breakfast`)
**Route:** `/home/food/log/:mealType`
**Scaffold:** Standard light
**App bar:** Back arrow + "Log [Meal Type]"

**Body:**
1. **Search bar** — bilingual placeholder; mic icon; barcode icon
2. **Quick-action chips row** (4 chips — updated):
   - `📷 Scan Label`
   - `🍽 Upload Plate Photo`
   - `📋 Lab/Rx Scan` — **NEW**
   - `✏ Manual Entry`
3. **Frequent Indian Portions** section — `2 × N` grid of `FoodItemCard`; photo, bilingual name, Indian portion, kcal, `+` button
4. **Restaurant Results** (NEW) — appears when user searches a restaurant name; shows Swiggy/Zomato sourced items with `🍴 Swiggy` or `🍴 Zomato` attribution pill; deep-link icon button on each card
5. **Recent Logs** section — list of past entries + `+` re-log button
6. **`QuickLogFAB`** — in this context becomes "Confirm Meal" full-width orange button at bottom

#### Food Detail Screen
**Route:** `/home/food/detail/:id`
**Scaffold:** Standard light
**Content:** Food photo hero, bilingual name, full macro table, micronutrient table (NEW — Iron/B12/VitD/Calcium), Indian serving size selector (katori / piece / glass), calorie result, "Add to Log" orange button.

#### Lab Report / Prescription OCR Screen (NEW)
**Route:** `/home/food/lab-scan`
**Scaffold:** Standard light
**Title:** "Scan Lab Report / लैब रिपोर्ट स्कैन करें"

**Layout:**
1. **Camera / Gallery picker** — two tall cards side by side: `📷 Take Photo` · `🗂 Upload PDF`
2. **Processing state** — `ShimmerLoader` with text "Extracting health values..."
3. **Extracted Values card** — white card, scrollable:
   - Each row: `LabValueRow` — metric name, extracted value (editable), unit, classification pill (green/amber/red)
   - `EncryptionBadge` at bottom of card
4. **"Import to Health Data"** orange full-width button
5. **"Discard"** text link
6. **Privacy note** caption: "Raw text stored locally only. Values go to your encrypted health logs."

**`LabValueRow` component:**
```
┌──────────────────────────────────────────────────────┐
│  🩸 Glucose (Fasting)      [  92  ] mg/dL    🟢 Normal │
│  ✏ Edit                                               │
└──────────────────────────────────────────────────────┘
```
- Classification pill: green (normal) / amber (borderline) / red (high/low)
- Edit icon → inline `TextField` editing
- Confirm checkbox: user must tap to confirm each imported value

---

### 7.4 Workout Screens

#### Workout Home
**Route:** `/home/workout`
**Scaffold:** Standard light
**Body:**
1. Streak banner (if active) — orange gradient, `🔥 Day 12 Streak!`
2. `SectionHeader` — "Today's Workout / आज का वर्कआउट"
3. Featured workout card — large hero image, title, duration, difficulty badge, "Start" orange button
4. Category chips row — scrollable: Yoga · HIIT · Strength · Cardio · Dance · Bollywood · Cricket · Kabaddi · Pranayama
5. Grid of `WorkoutCard` — 2-column, photo + title + duration + premium lock if applicable

#### Workout Detail Screen
**Route:** `/home/workout/:id`
**Scaffold:** Pattern B (dark hero)
**Hero:** Workout thumbnail, title `h1OnDark`, duration + difficulty badges, "Start Workout" orange CTA

**Body:**
1. Description
2. Equipment list (chips)
3. Exercise list with sets/reps/RPE per exercise (NEW — RPE column)
4. Superset grouping indicator (NEW — exercises with same bracket letter are supersets)
5. Similar workouts horizontal scroll

#### Active Workout Screen
**Route:** `/home/workout/:id/active`
**Scaffold:** Pattern B
**Live UI:** Exercise name, set counter, rep target, **Rest Timer widget** (NEW — countdown ring, configurable seconds, audio cue on completion), HR zone badge from wearable, **RPE selector slider** (NEW — 1–10 scale shown after each set), Pause / Next / Finish buttons.

#### GPS Workout Screen
**Route:** `/home/workout/gps`
**Scaffold:** Pattern B
**Map:** `flutter_map` with offline tile cache — shows cached tiles even without connectivity.
**Stats overlay:** Distance · Duration · Pace · Avg HR · HR Zone badge.
**Offline indicator:** Teal "Offline Map" pill shown when tile cache is being used.

#### Custom Workout Builder
**Route:** `/home/workout/custom`
**Scaffold:** Standard light
**Body:** Drag-and-drop exercise list. Each row: exercise name, sets/reps inputs, rest timer input, RPE input (NEW), superset group selector (NEW — A/B/C letter assignment). "Add Exercise" + button at bottom.

---

### 7.5 Steps & Activity

#### Steps Home
**Route:** `/home/steps`
**Scaffold:** Pattern B (dark hero)
**Hero:** Today's step count `displayLarge white`, circular progress ring (green), goal `bodyOnDark`, "Daily Goal Reached 🎉" confetti animation on completion

**Body:**
1. Hourly step bar chart — today's pattern
2. 7-day step trend chart
3. Distance and calories burned cards
4. Adaptive goal card — "Your 7-day average is 7,200. New daily goal: 8,000" with Accept/Keep buttons
5. Inactivity nudge card (if > 60 min inactive) — amber, "Time to move! 10-min walk?"

---

### 7.6 Health Monitoring Screens

#### Blood Pressure Tracker
**Route:** `/blood-pressure`
**Scaffold:** Pattern B (dark hero)
**Hero:** Latest reading `displayLarge white` (e.g. `128/82`), AHA classification badge (colour-coded), pulse `bodyOnDark`, `EncryptionBadge` in hero.

**Body:**
1. `BPTrendChart` — 7/30/90-day toggle, coloured reference bands per AHA category
2. Log bottom sheet trigger — "Log BP" orange FAB
3. Morning/evening reminder config row

**Log Bottom Sheet:**
```
Systolic:  [___] mmHg
Diastolic: [___] mmHg
Pulse:     [___] bpm  (optional)
Notes:     [___________]
🔒 AES-256 badge
[Save BP Reading] orange button
```

#### Blood Glucose Tracker
**Route:** `/glucose`
**Scaffold:** Pattern B (dark hero)
**Hero:** Latest value + reading type tag + classification badge, `EncryptionBadge`

**Body:**
1. Reading type selector chips: Fasting · Post-meal · Random · Bedtime
2. `GlucoseHistoryChart` — with target bands per reading type
3. HbA1c estimator card (NEW — shows 90-day estimated A1c if ≥ 30 readings)
4. Meal correlation row — linked food log for post-meal readings
5. "Import from Lab Report" row (NEW) — links to `/home/food/lab-scan`

#### SpO2 Tracker
**Route:** `/spo2`
**Scaffold:** Pattern B (dark hero)
**Hero:** Latest SpO2 %, pulse, timestamp. Alert banner if < 95%.

---

### 7.7 Lab Reports & ABHA Screens (NEW)

#### Lab Reports Home
**Route:** `/lab-reports`
**Scaffold:** Standard light
**Title:** "Lab Reports / लैब रिपोर्ट्स"

**Layout:**
1. **"Scan New Report"** — large orange CTA card with scan icon
2. **Imported Reports list** — each row: lab name, date, imported metrics count, "View" link
3. **"Import from ABHA"** card (if ABHA linked) — pulls verified lab records from the national health system
4. **Privacy note** — "All imported values are stored encrypted on your device only."

#### ABHA Account Screen
**Route:** `/abha`
**Scaffold:** Standard light
**Title:** "ABHA Health ID / आयुष्मान भारत"

**Layout:**
1. **`ABHALinkBadge`** — large, full-width card
   - If linked: green badge, ABHA ID display (masked: `XX-****-****-XXXX`), last sync timestamp
   - If not linked: amber badge, "Link your national health ID" copy
2. **Benefits card** (if not linked) — "Why link ABHA?" — list: verified lab history, hospital records, vaccination records
3. **Link ABHA section** (if not linked):
   - 14-digit ABHA ID input field
   - "Verify via OTP" orange button
4. **Linked Records** (if linked):
   - Past lab reports from hospitals and labs
   - Each row: source institution, record type, date, "Import" button
5. **Consent note** — "You control what data is pulled. FitKarma never shares your ABHA data."
6. **`EncryptionBadge`** — all ABHA data encrypted locally

---

### 7.8 Lifestyle Tracker Screens

#### Sleep Tracker
**Route:** `/sleep`
**Scaffold:** Pattern B (`sleepGradient`)
**Hero:** Last night's duration `displayLarge white`, quality emoji, "Good Sleep" / "Poor Sleep" badge

**Body:**
1. 7-day sleep bar chart
2. **Sleep Debt card** (NEW) — shows cumulative weekly sleep debt vs 7h target: e.g. "You're 2h 40min in sleep debt this week". Debt shown as a red deficit bar, credit as a green surplus bar.
3. **Chronotype card** (NEW — appears after 30+ days) — "You're an 🦉 Night Owl. Your optimal sleep window: 11:30pm – 7:30am." Indigo card.
4. Ayurvedic sleep tip card (if avg < 6h)
5. "Log Sleep" bottom sheet FAB

#### Habit Tracker
**Route:** `/habits`
**Scaffold:** Standard light

**Body:**
1. Today's habits — checklist cards with habit icon, name, target count, completion bar, streak badge
2. **Streak Recovery button** (NEW) — appears on a habit with a broken streak: "Recover streak for 50 XP" amber outlined button. Only shown if within 24h of break.
3. Weekly heatmap calendar (GitHub contribution style) — one row per habit
4. Streak stats — current streak, longest streak per habit

---

### 7.9 Wellness Screens

#### Journaling
**Route:** `/journal`
**Scaffold:** Standard light
**Title:** "Journal / जर्नल" + `EncryptionBadge` in app bar

**Body:**
1. Today's prompt card — amber, question based on logged data (NEW: *"You logged 'anxious' 4 times this week — what was the common trigger?"*)
2. `flutter_quill` rich text editor (full-screen)
3. Mood score selector row (1–5 emoji) + tags row
4. **Sentiment summary card** (NEW — appears after 30+ entries) — "Your mood has been trending 📈 upward this month" in indigo card. On-device analysis.
5. Past entries list — date, first line, mood emoji. Tap → full-screen read view.

#### Mental Health Hub
**Route:** `/mental-health`
**Scaffold:** Standard light

**Body:**
1. **CBT-based insight card** (NEW) — data-driven prompt: *"On days you slept < 6h, you logged 'irritable'. Better sleep may help."* — `CorrelationInsightCard` variant.
2. Stress programs — 7-day plans as horizontal cards
3. Breathing exercise quick-start button
4. Burnout risk gauge (if applicable) — amber/red level indicator
5. Indian helplines list (iCall, Vandrevala Foundation, NIMHANS) — each with a call CTA

---

### 7.10 Social & Community Screens

#### Social Feed
**Route:** `/home/social`
**Scaffold:** Standard light
**Body:**
1. Stories row — horizontal scroll of user avatars
2. Post cards — avatar, name, content, media (hidden in Low Data Mode), likes + comment counts
3. **Social Karma indicator** (NEW) — small "+5 XP" amber float animation when a user's post receives a like
4. Create post FAB

#### Community Groups
**Route:** `/home/social/groups`
**Scaffold:** Standard light
**Body:**
1. My Groups — horizontal scroll of joined group cards
2. Discover Groups — categorised list: Diet · Location · Sport · Support
3. **Team vs. Team challenges** banner (NEW) — "Mumbai Runners vs Delhi Pacers — 7-day steps challenge ends in 2 days"

---

### 7.11 Reports & Wearables

#### Health Reports
**Route:** `/reports`
**Scaffold:** Standard light

**Body:**
1. Report period tabs — Weekly · Monthly
2. Most recent report card — summary stats, "View PDF" button, **"Share with Doctor"** orange outlined button (NEW)
3. **Share with Doctor card** (NEW):
   - Tapped → loading → "Generating shareable link..."
   - `HealthShareCard` component shows:
     - "Link expires in 7 days" countdown badge
     - "Share via WhatsApp" primary CTA
     - "Copy Link" secondary CTA
     - "Delete Link" destructive CTA
4. Past reports list — date, period, status pill

#### Wearable Connections
**Route:** `/wearables`
**Scaffold:** Standard light
**Body:** Connected device cards (Fitbit, Garmin, Health Connect, HealthKit). Each card: device name, last sync time, sync status pill, Disconnect button. "Add Wearable" + button.

---

### 7.12 Family & Emergency

#### Emergency Health Card
**Route:** `/emergency`
**Scaffold:** Standard light with orange app bar
**Title:** "Emergency Card / आपातकाल कार्ड"
**Note:** Accessible without biometric lock (override for emergencies)

**Body:**
1. Blood group — large `displayLarge` chip, colour-coded
2. Allergies — red pill chips
3. Chronic conditions — amber pill chips
4. Current medications — list (auto-pulled from medication module)
5. Emergency contact — name + phone with "Call" CTA
6. Doctor — name + phone with "Call" CTA
7. Insurance policy number
8. "Export PDF" + "Show QR" buttons at bottom

---

### 7.13 Settings & Profile Screens

#### Profile Screen
**Route:** `/profile`
**Scaffold:** Pattern B (dark hero)
**Hero:** Avatar, name `h1 white`, email `captionOnDark`, `KarmaLevelCard` compact variant

**Body:**
1. `DoshaDonutChart` mini card (120px) with percentage legend
2. Personal info editable rows: Goal · Height/Weight · DOB · Blood Group · Language
3. **ABHA status row** (NEW) — `ABHALinkBadge` compact; "Linked" green or "Link now" amber CTA
4. Achievements grid — earned = coloured, unearned = grey outline with lock
5. Referral card — amber gradient: "Refer friends, earn 500 XP each!"

#### Settings Screen
**Route:** `/settings`
**Scaffold:** Standard light
**Title:** "Settings / सेटिंग्स"
**Background:** `surfaceVariant`

| Section | Settings inside |
|---|---|
| Account | Edit Profile · Subscription status badge · Change Password · Linked accounts · ABHA account |
| Preferences | Language (22 options) · **Theme (Light / Dark / Auto)** (UPDATED) · Font size slider · **Dyslexia-friendly font toggle** (NEW) |
| Notifications | Per-module toggle rows: Meal reminders · Step nudges · BP/Glucose reminders · Lab report reminder · Social activity · Challenges · Morning briefing |
| Privacy & Security | Biometric lock toggle · Data Export JSON · **Account Deletion** (red text) |
| Data & Sync | Low Data Mode · Sync interval selector · Wearable connections · **Pending sync items** (shows DLQ count if > 0) (NEW) · **View failed sync items** (NEW) |
| Health Permissions | Permission status rows per sensor: Step counter · Heart rate · Sleep · Location (GPS) |
| Home Widgets | **Configure home screen widgets** (NEW) → links to `/home-widgets` |
| About | App version · Privacy Policy · Terms · Contact support |

**Logout** — red text, centred, at bottom, separated by `Divider`.

#### Subscription Plans
**Route:** `/subscription`
**Scaffold:** Standard light

**Layout:**
1. **Hero banner** — amber gradient, "Unlock Full FitKarma" `h1`, 3 key features
2. **Plan cards** (vertical stack):
   - Monthly ₹99 · Quarterly ₹249 · Yearly ₹899 · Family ₹1,499
   - "Most Popular" indigo badge on Quarterly (best entry point for new users)
   - "Best Value" amber ribbon on Yearly (25% saving vs Monthly; 16% on Quarterly)
   - Orange "Start [Plan]" button
   - **"Pay via UPI"** secondary outlined button below each plan card
3. Feature comparison table — Free vs Premium checkmarks
4. **Restore purchase** TextButton
5. "7-day free trial, cancel anytime"

---

---

### 7.14 Festival & Wedding Screens — **NEW**

#### Festival Calendar Home Screen
**Route:** `/festival-calendar`
**Scaffold:** Standard light
**Title:** "Festivals & Events / त्योहार & आयोजन"

**Layout:**
1. **Active Festival Banner** (shown only during active festival period):
   ```
   ┌─────────────────────────────────────────────────────┐
   │  🪔  Navratri — Day 5 of 9              नवरात्रि   │
   │  Fasting mode active · Phalahar diet plan enabled   │
   │  [View Diet Plan]          [Garba Tracker 💃]       │
   └─────────────────────────────────────────────────────┘
   ```
   - Background: festival-specific colour (saffron for Hindu, green for Islamic, blue for Sikh).
   - Replaces standard `InsightCard` during festival period.

2. **Upcoming Festivals** — `SectionHeader` "Upcoming / आगामी". Vertical list of `FestivalCard` widgets:
   ```
   ┌─────────────────────────────────────────┐
   │  🪔  Navratri                           │
   │  नवरात्रि · 9 days · Starts Oct 2      │
   │  Phalahar fast · Garba tracker          │
   │  [Set Reminder]    [View Diet Plan]     │
   └─────────────────────────────────────────┘
   ```
   - Festival icon (emoji), English + Hindi name, date range, fasting type pill, region pill.
   - Orange "Set Reminder" outlined button.
   - "View Diet Plan" teal button.
   - Swipe-left → "Hide this festival" (filters irrelevant festivals by religion/region).

3. **Region Filter chips** — scrollable row: `All · Hindu · Muslim · Sikh · Christian · Jain · Buddhist · National`. Filters the festival list. User's religion preference auto-selects from profile.

4. **Calendar Month View** — mini `TableCalendar` widget showing festival dots on dates. Tapping a date scrolls to the festival card.

5. **Past Festivals** — collapsible section showing completed festivals with logged data (steps, meals, fasting adherence).

6. **"Plan a Wedding 💍"** CTA card — amber gradient at bottom of screen:
   ```
   ┌─────────────────────────────────────────┐
   │  💍 Planning for a Wedding?             │
   │  Get a personalised diet & fitness plan │
   │  tailored to your role.                 │
   │  [Start Wedding Planner →]              │
   └─────────────────────────────────────────┘
   ```

---

#### Festival Diet Plan Detail Screen
**Route:** `/festival-calendar/{festivalKey}/diet`
**Scaffold:** Pattern B (dark hero)
**Hero colour:** Festival-specific gradient (saffron/green/orange)
**Title:** Festival name (bilingual) + fasting type badge

**Body:**
1. **Fasting Overview card** — duration, fasting type, restrictions summary.
2. **Allowed Foods grid** (if fasting active) — 2×N grid of food cards filtered to allowed items. Tap → opens food log with pre-filtered search.
3. **Forbidden Foods** — red-outlined pill list (grains, onion, garlic etc. for Navratri).
4. **Meal Plan tabs** — `Day 1` ... `Day N` tabs for multi-day festivals. Each day shows Breakfast / Lunch / Dinner / Snacks with festival-appropriate suggestions.
5. **Quick Log CTA** — "Log Phalahar Meal" orange FAB (Navratri) or "Log Sehri" / "Log Iftar" (Ramadan).
6. **Festival Insight cards** — e.g. *"Sabudana khichdi gives you slow-release carbs — ideal for a Navratri fast day."*
7. **Workout Note** — banner: *"Reduce workout intensity during Nirjala fasting. Gentle yoga and walks recommended."*

**Ramadan-specific additions:**
- **Sehri Countdown** — clock widget showing time remaining until Sehri cutoff.
- **Iftar Countdown** — clock widget showing time remaining until Iftar (sunset-based, from user GPS).
- **30-Day Log view** — calendar heatmap of Sehri/Iftar logging consistency.

**Karva Chauth-specific additions:**
- **Sargi Plan card** — pre-sunrise meal plan for Sargi time.
- **Moonrise Countdown** — computed from user's GPS location + astronomical formula.
- **Break-fast Plan card** — shown 30 min before moonrise: dates, water, puja prasad calories.

---

#### Wedding Planner — Onboarding Flow
**Route:** `/wedding-planner/setup`
**Scaffold:** Standard light
**Title:** "Wedding Planner / विवाह योजनाकार"
**Progress indicator:** Step pills 1–6 at top

**Step 1 — Role Selection:**
```
  Who are you in this wedding?
  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌──────────┐
  │  👰     │  │  🤵     │  │  🎉     │  │  👨‍👩‍👧     │
  │  Bride  │  │  Groom  │  │  Guest  │  │ Relative │
  │  दुल्हन │  │  दूल्हा │  │ मेहमान  │  │  रिश्तेदार│
  └─────────┘  └─────────┘  └─────────┘  └──────────┘
```
- Large illustrated cards (120×140px), single-select.
- Selected card: deep orange border, `primarySurface` background, orange checkmark.
- Deselected: `divider` border, white background.

**Step 1b — Relation Type** (shown only if Relative selected):
```
  What is your relation to the couple?
  [ Father of Bride ] [ Mother of Bride ]
  [ Father of Groom ] [ Mother of Groom ]
  [ Sibling ]         [ Close Family ]
```
- Pill-style multi-select chips. Single-select.

**Step 2 — Wedding Dates:**
```
  When is the wedding?

  📅 First Event Date              📅 Last Event Date
  [ Select Date ▼ ]               [ Select Date ▼ ]

  ──────────────────────────────
  Wedding Period: Oct 15 – Oct 18 · 4 days
  ──────────────────────────────

  ⚠ For best results, enter the full date range including
    all pre-wedding events.
```
- `DateRangePicker` using Material3 calendar picker.
- Validation: End date must be ≥ start date. Max 14-day range.
- Auto-detects if dates overlap with a festival (shows amber notice).

**Step 3 — Select Events:**
```
  Which events are happening? (Select all that apply)

  ☐ 🟡 Haldi Ceremony           ☐ 💃 Mehendi Night
  ☐ 🎵 Sangeet / Garba Night    ☐ 🐴 Baraat
  ☐ 💍 Main Wedding Ceremony    ☐ 🎊 Reception / Walima
```
- Checkbox tile cards, 2-column grid.
- Each event has an icon, English + Hindi name.
- Selected: filled orange checkbox, `primarySurface` card background.

**Step 4 — Preparation Time:**
```
  How many weeks until your wedding?
  (Or how long have you to prepare?)

  [1 week] [2 weeks] [4 weeks] [8 weeks] [Already wedding week]
```
- Horizontal scrollable chips, single-select.
- If "Already wedding week" selected → skip fitness plan, go straight to wedding-week diet.

**Step 5 — Primary Goal** (role-aware options):
```
  Bride / Groom:            Guest / Relative:
  [ 💪 Look my best ]       [ 🍽 Manage indulgence ]
  [ ⚡ Feel energised ]     [ 🏃 Stay active ]
  [ 🧘 Manage stress ]      [ 📅 Maintain routine ]
```
- Icon + label chips, single-select.

**Step 6 — Summary + Confirm:**
```
  Your Wedding Plan is Ready!

  Role:      👰 Bride
  Relation:  —
  Dates:     Oct 15 – 18 (4 days)
  Events:    Haldi, Mehendi, Sangeet, Vivah, Reception
  Prep Time: 4 weeks
  Goal:      Look my best

  📋 Your personalised plan includes:
  • 4-week pre-wedding diet & fitness schedule
  • Event-by-event meal plans
  • Bloat-free wedding day nutrition guide
  • Post-wedding recovery plan

  [🚀 Start My Wedding Plan  →]   (orange primary button)
  [Edit Details]                   (text link)
```

---

#### Wedding Planner Home Screen
**Route:** `/wedding-planner`
**Scaffold:** Pattern B (dark hero)
**Hero gradient:** Gold gradient `#D4A017 → #B8860B` (unique to wedding planner)
**Hero content:**
```
  💍  Your Wedding Plan
  Role: Bride  ·  Phase: Pre-Wedding (Week 3 of 4)
  Wedding in 18 days  ·  Main ceremony: Oct 18
```

**Body:**
1. **Phase Progress card** — "Pre-Wedding Week 3 of 4" with progress bar. Sub-phases: Pre-wedding → Wedding Week → Post-Wedding.
2. **Today's Plan card** — orange card showing today's diet phase + workout plan:
   ```
   ┌─────────────────────────────────────────┐
   │  📅 Today  ·  Week 3, Day 4             │
   │  Diet Phase: Lean & Glow                │
   │  Breakfast: Moong dal chilla + curd     │
   │  Lunch: Dal + roti + sabzi (light)      │
   │  Dinner: Paneer tikka + salad           │
   │  Workout: 30 min HIIT + 15 min yoga     │
   │  [Log Today's Meals]  [Start Workout]   │
   └─────────────────────────────────────────┘
   ```
3. **Event Countdown strip** — horizontal scrollable chips for each upcoming event:
   ```
   [🟡 Haldi · 5 days] [💃 Mehendi · 6 days] [💍 Vivah · 7 days]
   ```
   Tapping an event → opens that event's specific diet plan screen.
4. **Wedding Tips card** (amber, InsightCard variant):
   - Role-specific tips. Bride: *"Avoid cruciferous veggies (broccoli, cauliflower) this week — they can cause bloating. Stick to zucchini, bottle gourd, carrots."*
5. **Pre-Wedding Fitness Plan card** — compact view of current week's workout schedule. "View Full Plan" → `/wedding-planner/fitness`.
6. **Wedding Grocery List card** — "Generate shopping list for wedding week meals" orange outlined button.

---

#### Wedding Event Day Screen
**Route:** `/wedding-planner/event/{eventKey}`
**Scaffold:** Standard light
**Title:** e.g., "Sangeet Night Diet Plan / संगीत रात"

**Body:**
1. **Event overview card** — time, duration, energy demand (Low/Medium/High), role-specific note.
2. **Pre-Event Meal Plan** — "What to eat before the event":
   ```
   For Bride (Sangeet Night):
   ⏰ 4 PM snack: Banana + 5 dates + coconut water (quick energy)
   🍽 6 PM light dinner: Curd rice + dal soup (before dancing)
   ❌ Avoid: Heavy dal makhani, fried starters, carbonated drinks
   ```
3. **During-Event Tips** — bite-sized tip cards: *"Sip water every 30 min while dancing. Coconut water is best for electrolytes."*
4. **Post-Event Recovery Meal** — *"Post-Sangeet: Warm milk + banana. Protein shake if you have one. Sleep by 1 AM if possible."*
5. **Quick Log** — "Log Sangeet Meal" button → opens food log with event tag.
6. **Calorie Budget card** — event-day calorie target + how many kcal dance burns (Garba / Bollywood dancing estimated burn).

---

#### Wedding Post-Event Recovery Screen
**Route:** `/wedding-planner/recovery`
**Scaffold:** Standard light
**Title:** "Post-Wedding Recovery / विवाह के बाद"

**Body:**
1. Celebration card — *"You made it! 🎊 The wedding is over — time to restore and recharge."*
2. **3-Day Detox Plan** — day-by-day plan: moong dal khichdi, coconut water, fruits.
3. **Return to Normal** — 5-day gradual calorie increase chart.
4. **Workout plan** — "Walking + gentle yoga for 7 days. No high-intensity until Day 8."
5. "Share your wedding fitness journey" social CTA (optional).
6. **Archive wedding plan** — "Mark Wedding as Complete" — stores plan history in Drift.

---

### 7.15 Home Screen Widget UI — **UPDATED**

*(Previously section 7.14)*

#### Home Widget Configuration Screen
**Route:** `/home-widgets`
**Scaffold:** Standard light
**Title:** "Home Screen Widgets / होम स्क्रीन विजेट"

**Layout:**
1. **Preview section** — shows `HomeWidgetPreview` for each widget size on a phone mockup background
2. **Widget catalogue** (4 cards):
   - **Activity Rings (4×1)** — preview: 4 mini rings + stat labels. "Add to Home Screen" orange button.
   - **Quick Log (2×1)** — preview: orange "Log Meal" button. "Add to Home Screen" button.
   - **Water Counter (2×2)** — preview: water glass icon, tap-to-increment counter. "Add to Home Screen" button.
   - **Festival / Wedding Countdown (2×2)** — **NEW** — preview: festival name + days remaining. Updates daily from Drift.
3. **Lock Screen section** (iOS Dynamic Island / Android):
   - Emergency Card widget — blood group chip + emergency number
   - "Add to Lock Screen" button
4. **"How to add widgets"** collapse-expand card with 3-step illustrated instructions for Android and iOS.

#### Widget Designs

**Activity Rings Widget (4×1):**
```
┌────────────────────────────────────────────────────┐
│  🟠 8,500/10k steps  🟢 1,200/2,000 kcal  💧 4/8  │
│  FitKarma                                  Level 12 │
└────────────────────────────────────────────────────┘
```
- Background: `background` (light) / `#1E1E2C` (dark)
- Ring colours: orange/green/teal/purple (same as app)
- Tap → opens app to Dashboard

**Quick Log Widget (2×1):**
```
┌───────────────────────────┐
│  🍽 Log Meal              │
│  FitKarma  1,200 kcal today│
└───────────────────────────┘
```
- Orange CTA button
- Tap → deep-links to `/home/food` log sheet

**Water Counter Widget (2×2):**
```
┌───────────────────────────┐
│  💧 Water                 │
│  4 / 8 glasses            │
│  ████████░░░░░░░░  50%    │
│  [+1 glass]               │
└───────────────────────────┘
```
- Tap `+1 glass` → increments counter + writes to Drift via shared preferences
- Tap anywhere else → opens full app

---

## 8. Bottom Navigation Bar

Applies to all `/home/*` routes. 5 tabs, `surface` background, `8dp` elevation.

| Tab | Icon | English label | Hindi label | Route |
|---|---|---|---|---|
| 1 | `home_outlined` / `home` (filled active) | Home | मुख्यपृष्ठ | `/home/dashboard` |
| 2 | `restaurant_outlined` / filled | Food | खाना | `/home/food` |
| 3 | `fitness_center_outlined` / filled | Workout | वर्कआउट | `/home/workout` |
| 4 | `directions_walk_outlined` / filled | Steps | कदम | `/home/steps` |
| 5 | `person_outline` / `person` (filled) | Me | मैं | `/profile` |

**Dark mode:** Background `#1E1E2C`; active icon `primary` (dark variant `#FF7043`); inactive `textMuted` (dark variant).

**Label rendering:** Two-line `Text` widget. English: `navLabelEn` (10sp, SemiBold, `primary`). Hindi: `navLabelHi` (9sp, Regular, `primary`). Inactive: both in `textMuted`.

---

## 9. Common UI Patterns

### Log Bottom Sheet
All "Log [metric]" actions open a bottom sheet. Consistent structure:
1. Drag handle — 36px wide, 4px tall, `divider` colour, centred
2. Title (English) `h3` + Hindi subtitle `sectionHeaderHindi`
3. Form fields — stacked, `primary` focus ring
4. `EncryptionBadge` (on sensitive screens only)
5. Primary orange CTA button — full-width

### Inline Metric Cards
All health metric screens show a summary card at the top with:
- Latest value in `statLarge` or `displayMedium`
- Classification badge (colour-coded pill)
- Trend indicator (▲ rising / ▼ falling / → stable) in `textSecondary`

### Correlation Insight Card (NEW)
Used when an insight spans multiple modules:
```
┌──────────────────────────────────────────────────────┐
│ 🔗  Sleep + Mood insight                             │
│ Your mood drops on nights with < 6h sleep.           │
│ Pattern detected over 8 days.                        │
│ [💤 Sleep]  →  [😊 Mood]        👍  👎              │
└──────────────────────────────────────────────────────┘
```
- Background: `#E8E7F6` (light) / `#1E1D3A` (dark)
- Module pills at bottom link to the respective modules on tap
- Same 👍/👎 rating as `InsightCard`

### Streak & Gamification Elements
- Streak banners: `orangeGradient`, `🔥` emoji, bold white text
- XP earned animations: amber "+XP" text floats upward and fades (200ms)
- Level up: full-screen indigo overlay with confetti + new level title
- **Streak recovery confirmation**: amber bottom sheet — "Recover streak for 50 XP? This can only be used once per month per habit." Confirm / Cancel.

### Sync Status Patterns
- **DLQ warning banner** (NEW): amber top banner when `syncDeadLetterCount > 0`. "⚠ 2 items failed to sync. Tap to review." Tapping opens Settings → Data & Sync.
- **Offline banner**: teal "Offline — changes saved locally" when `ConnectivityService.isOnline == false`.
- **Low Data Mode banner**: teal "Low Data Mode" persistent banner.

### Navigation Pattern for Detail Screens
- Always accessible via back arrow
- Bottom safe-area respected — no CTAs hidden behind home indicator
- Sensitive detail screens (journal, period, BP logs) require biometric re-auth if `biometricLock` is enabled

---

## 10. Accessibility & Bilingual Rules

### Bilingual Requirements

| Location | Requirement |
|---|---|
| Bottom navigation labels | English primary (10sp bold) + Hindi secondary (9sp regular) |
| Screen titles (app bar) | English `h3` + Hindi `sectionHeaderHindi` sub-label |
| All section headers | English + Hindi stacked, with `3px` left border in `primary` |
| Food names in database | `name` (English) + `name_hi` (Devanagari) — both on `FoodItemCard` |
| Primary CTA buttons | English label + optional Hindi sub-label in `caption` below |
| Search bar placeholders | Bilingual placeholder on all food-related search bars |
| Lab value names (NEW) | English metric name + common Hindi term (e.g. "Glucose / शर्करा") |

### Accessibility Standards
- Minimum tap target: **44×44px** for all interactive elements (including `LabValueRow` edit icons)
- Colour contrast: all text meets **WCAG AA** (4.5:1 minimum)
- Screen reader: all `IconButton` widgets have `Semantics` labels; all images have `Semantics` descriptions
- Font scaling: all text respects system font size settings
- **Dyslexia-friendly font** (NEW): toggle in Settings → Preferences → switches body text to OpenDyslexic (bundled as asset)
- High contrast mode: black/white with orange accents only, no gradients. Toggle in Settings → Preferences → Theme.

### Dark Mode Accessibility
- All dark surfaces meet WCAG AA contrast ratios against `#121218` background
- Dark mode ring track: `divider` (dark) — not invisible against dark background
- Amber/warning elements in dark mode use `#FFD54F` (lighter) to maintain 4.5:1 contrast

### Low Data Mode UI Adaptations
When Low Data Mode is enabled:
- All network images replaced with `#EEE8E4` (light) / `#2C2C3E` (dark) placeholder squares
- Social feed switches to text-only cards
- Food card thumbnails show food emoji placeholder instead of `Image.network`
- No video thumbnails in workout grid — text cards only
- Lab report OCR still works (on-device, no network required)
- Persistent teal "Low Data Mode" banner at top of app

---

*FitKarma UI Design System — v2.0*
*Flutter 3.x · Riverpod 2.x · Drift · Appwrite*
*Offline-first · Privacy-centric · Built for India*
*45+ screens · Full bilingual UI · Full dark mode · 20 shared components*