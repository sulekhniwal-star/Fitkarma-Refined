# FitKarma — Developer Documentation (Revised v2.0)

> **Offline-First · Privacy-Centric · Built for India**
> Flutter 3.x · Riverpod 2.x · Drift (SQLite) · Appwrite
>
> **Changelog from v1.0:** Sync engine upgraded with idempotency keys, dead-letter queue, and per-field version vectors. Encryption re-architected with HKDF per data class stored in Drift (SQLCipher). First-class RemoteConfig system added. Insight engine modularised. New India-specific features: ABHA, Lab Report OCR, shareable doctor reports, home screen widgets, WhatsApp bot. Full dark mode token set. Offline map tile caching. 25+ additional improvements throughout.

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [UI Design Reference](#2-ui-design-reference)
3. [Application Architecture](#3-application-architecture)
4. [Folder Structure](#4-folder-structure)
5. [Appwrite Setup](#5-appwrite-setup)
6. [Database Schema](#6-database-schema)
7. [Local Storage — Drift (SQLite)](#7-local-storage--drift-sqlite)
8. [Offline Sync Architecture](#8-offline-sync-architecture)
9. [Authentication & Onboarding](#9-authentication--onboarding)
10. [Core Feature Modules](#10-core-feature-modules)
11. [Advanced Feature Modules](#11-advanced-feature-modules)
12. [Health Monitoring Modules](#12-health-monitoring-modules)
13. [Lifestyle & Wellness Modules](#13-lifestyle--wellness-modules)
14. [Social & Community Modules](#14-social--community-modules)
15. [Platform & Infrastructure Modules](#15-platform--infrastructure-modules)
16. [Security & Privacy](#16-security--privacy)
17. [External API Integrations](#17-external-api-integrations)
18. [Performance Contracts](#18-performance-contracts)
19. [State Management](#19-state-management)
20. [Monetization & Subscriptions](#20-monetization--subscriptions)
21. [Testing Strategy](#21-testing-strategy)
22. [Coding Standards](#22-coding-standards)
23. [Environment Configuration](#23-environment-configuration)
24. [CI/CD Pipeline](#24-cicd-pipeline)

---

## 1. Project Overview

| Property              | Value                                                         |
|-----------------------|---------------------------------------------------------------|
| App Name              | FitKarma                                                      |
| Tagline               | India's Most Affordable, Culturally-Rich Fitness App          |
| Bundle ID             | `com.fitkarma.app`                                            |
| Architecture          | Offline-first, server-synced via Appwrite                     |
| Tech Stack            | Flutter 3.x · Riverpod 2.x · Drift (SQLite) · Appwrite        |
| Target Market         | Indian users across all connectivity tiers (2G–5G)            |
| Languages             | English + 22 Indian regional languages                        |
| App Size Target       | < 50 MB (enforced in CI/CD)                                   |
| Dashboard Load        | < 1 second                                                    |
| Total Feature Modules | 35+                                                           |

### Design Principles

- **Offline-first** — All writes go to Drift instantly; Appwrite is only touched during sync. Zero loading states for core actions.
- **Zero recurring API costs** — Critical data paths never depend on external APIs at runtime.
- **Privacy-first** — AES-256-GCM encrypted medical and reproductive health data with HKDF per data class. No advertising SDKs. No data sold to third parties.
- **Culturally rich** — Indian food database, Ayurveda engine, ABHA integration, festival calendar, and regional language support baked in.
- **Performance** — Sub-50 MB install size, < 2s cold start, < 1s dashboard render, < 3% battery drain per hour during background tracking.
- **Single backend** — Appwrite replaces all Firebase dependencies. No Firebase SDK except `firebase_messaging` for push tokens.
- **Comprehensive health coverage** — Blood pressure, glucose, lab report OCR, mental health, wearable sync, meal planning, and chronic disease management modules.
- **Accessible** — Screen reader, font scaling, full dark mode, and high-contrast mode support built in.
- **India-ecosystem integrated** — ABHA health ID linking, UPI deep-links, WhatsApp bot logging, Zomato/Swiggy restaurant calories, lab report OCR.

---

## 2. UI Design Reference

> The following describes the UI design language established by the reference mockups. All screens and components must conform to these specifications.

### 2.1 Screen Inventory from Reference Mockups

#### Dashboard Screen
- **Header** — Avatar, greeting text ("Namaste, [Name] 🙏"), karma coin indicator (e.g. `1,250 XP`) and level badge (`Level 12 Warrior`) overlaid on the avatar.
- **Activity Rings** — Four concentric ring widgets arranged in a compact circle:
  - Ring 1 (outermost, orange): Calories — e.g. `1200 / 2000 kcal`
  - Ring 2 (green): Steps — e.g. `8,500 / 10,000`
  - Ring 3 (teal): Water — e.g. `4 / 8 glasses`
  - Ring 4 (purple): Active minutes — e.g. `35 / 60 mins`
- **Insight Card** — Amber/yellow card with a lightbulb icon and actionable nudge text (e.g. *"You're 18g protein short today. Adding a katori of dal to dinner will help!"*). Thumbs-up / thumbs-down rating buttons at the bottom right.
- **Today's Meals Section** — Horizontal row of meal-type tabs (Breakfast · Lunch · Dinner · Snacks). Each tab shows a food category icon and label.
- **Quick-Log FAB** — Orange circular floating action button with `+` icon, positioned at the bottom-right above the nav bar.
- **Bottom Navigation Bar** — 5 tabs with icons and bilingual labels (English + Hindi): Home · Food · Workout · Steps · Me.

#### Food Logging Screen (`Log Breakfast`)
- **App bar** — Back arrow + screen title (e.g. `Log Breakfast`).
- **Search bar** — Bilingual placeholder (`Search food, or tap the mic... / खाना खोजें / स्कैन करें`), microphone icon on the right, barcode icon on the far right.
- **Quick-action chips** — Four pill-shaped buttons below the search bar: `📷 Scan Label` · `🍽 Upload Plate Photo` · `📋 Lab/Rx Scan` · `✏ Manual Entry`.
- **Frequent Indian Portions section** — `2 × N` grid of food cards. Each card shows food photo, food name, portion in Indian units, calorie count, and `+` circular button.
- **Recent Logs section** — List of past entries with thumbnail, name, portion, and a `+` button to re-log.
- **"Copy Yesterday's Meals"** — Quick-action button at the top of Recent Logs for one-tap duplication.

#### Karma & Ayurveda Screen (Me / Profile tab)
- **Karma Level card** — Dark purple/indigo gradient card showing level, XP bar, and title (e.g. `Warrior`).
- **Dosha Profile card** — White card with donut chart and `View Seasonal Guidelines (Ritucharya)` button.
- **Daily Rituals (Dinacharya) section** — Checklist with checkbox + ritual name + completion indicator.
- **Challenges Carousel** — Horizontally scrollable cards showing active challenges.

### 2.2 Visual Design System

| Token             | Value / Specification                                              |
|-------------------|--------------------------------------------------------------------|
| Primary colour    | Deep orange `#FF5722`                                              |
| Secondary colour  | Indigo / deep purple `#3F3D8F`                                     |
| Accent            | Amber `#FFC107` (insight cards, karma coins)                       |
| Background (light)| Warm off-white `#FDF6EC`                                           |
| Background (dark) | Deep indigo-black `#121218`                                        |
| Surface (light)   | Pure white `#FFFFFF` cards, `8px` radius, soft shadow              |
| Surface (dark)    | `#1E1E2C` cards, `8px` radius                                      |
| Hero bg (dark)    | `#1A1035` gradient top stop                                        |
| Typography        | System default (Roboto on Android, SF Pro on iOS)                  |
| Ring stroke width | `10px` with `lineCap: round`                                       |
| Card elevation    | `2dp` shadow, `borderRadius: 12px`                                 |
| FAB colour        | Orange `#FF5722`, white `+` icon                                   |
| Bottom nav        | White / `#1E1E2C` dark, active icon in primary orange              |
| Chip / pill style | Outlined, `borderRadius: 20px`, icon prefix                        |
| Food card images  | `72 × 72px` rounded thumbnails                                     |

### 2.3 Dark Mode Tokens

All screens must support light and dark modes via `ThemeMode.system` + explicit user toggle.

| Light Token       | Dark Equivalent             | Usage                          |
|-------------------|-----------------------------|--------------------------------|
| `#FDF6EC`         | `#121218`                   | Scaffold background            |
| `#FFFFFF`         | `#1E1E2C`                   | Cards and surfaces             |
| `#3F3D8F`         | `#5C59C4`                   | Hero sections                  |
| `#FF5722`         | `#FF7043`                   | Primary CTA (slightly lighter) |
| `#FFC107`         | `#FFD54F`                   | Accent / karma coins           |
| `#1A1A2E`         | `#F0EEF8`                   | Primary text                   |
| `#6B6B8A`         | `#9D9BBC`                   | Secondary text                 |
| `#EEE8E4`         | `#2C2C3E`                   | Dividers and borders           |
| `#FFF3EF`         | `#2A1E1A`                   | Selected chip background       |

### 2.4 Bilingual UI Requirements

- All primary navigation labels, screen titles, and section headers must include the local language translation rendered beneath the English text.
- Food names in the Indian food database must include `name` (English) and `name_local` (in the appropriate local script).
- Search bars on food-related screens display bilingual placeholder text.
- The bottom navigation bar renders bilingual labels using a two-line `Text` widget styled at `10sp` for the local language sub-label.

### 2.5 Component Library

All widgets below are part of the shared design system in `lib/shared/widgets/` and must not be re-implemented per screen.

| Component                  | Location                                     | Notes                                                       |
|----------------------------|----------------------------------------------|-------------------------------------------------------------|
| `ActivityRingsWidget`      | `shared/widgets/activity_rings.dart`         | Four concentric rings, accepts progress 0.0–1.0             |
| `InsightCard`              | `shared/widgets/insight_card.dart`           | Amber background, lightbulb icon, thumbs rating             |
| `CorrelationInsightCard`   | `shared/widgets/correlation_insight_card.dart` | Cross-module insight with per-module pill links            |
| `FoodItemCard`             | `shared/widgets/food_item_card.dart`         | Photo, bilingual name, portion, kcal, `+` tap handler       |
| `KarmaLevelCard`           | `shared/widgets/karma_level_card.dart`       | Dark gradient, progress bar, level title                    |
| `DoshaDonutChart`          | `shared/widgets/dosha_chart.dart`            | Three-segment donut using `fl_chart`                        |
| `ChallengeCarouselCard`    | `shared/widgets/challenge_card.dart`         | Horizontally scrollable, progress + XP reward               |
| `QuickLogFAB`              | `shared/widgets/quick_log_fab.dart`          | Speed-dial FAB; sub-actions: Food · Water · Mood · Workout · BP · Glucose |
| `MealTypeTabBar`           | `shared/widgets/meal_tab_bar.dart`           | Breakfast / Lunch / Dinner / Snacks                         |
| `ShimmerLoader`            | `shared/widgets/shimmer_loader.dart`         | All async loading states                                    |
| `BilingualLabel`           | `shared/widgets/bilingual_label.dart`        | English + Hindi stacked `Text` widgets                      |
| `EncryptionBadge`          | `shared/widgets/encryption_badge.dart`       | 🔒 AES-256 badge for sensitive data screens                 |
| `HealthShareCard`          | `shared/widgets/health_share_card.dart`      | Shareable doctor report link card with expiry countdown     |
| `ABHALinkBadge`            | `shared/widgets/abha_badge.dart`             | ABHA ID linked / unlinked status indicator                  |
| `HomeWidgetPreview`        | `shared/widgets/home_widget_preview.dart`    | Scaled preview of Android/iOS home screen widget            |
| `MicronutrientBar`         | `shared/widgets/micronutrient_bar.dart`      | Compact progress bar for Iron / B12 / Vit D / Calcium       |
| `LabValueRow`              | `shared/widgets/lab_value_row.dart`          | Extracted lab metric with inline edit field + confirm toggle |
| `ErrorRetryWidget`         | `shared/widgets/error_retry_widget.dart`     | Error state with Retry button; use instead of bare `ErrorWidget` |
| `SyncStatusBanner`         | `shared/widgets/sync_status_banner.dart`     | Top banner for DLQ items (amber) and offline state (teal)   |
| `AsyncValueWidget`         | `shared/widgets/async_value_widget.dart`     | Generic `AsyncValue<T>` wrapper — loading / error / data states; use on every async screen |

---

## 3. Application Architecture

### 3.1 Frontend

| Concern          | Choice                                                               |
|------------------|-----------------------------------------------------------------------|
| Framework        | Flutter 3.x — single codebase for Android and iOS                   |
| Architecture     | Modular, feature-based Clean Architecture                            |
| State Management | Riverpod 2.x with scoped `ProviderScope`, disposal, error boundaries |
| Local Storage    | **Drift (SQLite)** for all data including encrypted fields — full-text search, typed queries, migrations |
| Encrypted Storage| **Drift + SQLCipher** for AES-256-GCM encrypted sensitive records             |
| Navigation       | GoRouter with deep-link support and route-scoped providers           |
| UI               | Custom design system with Indian cultural theming; full dark mode     |
| Accessibility    | Screen reader, font scaling, high-contrast mode, dark mode           |

### 3.2 Backend (Appwrite)

| Concern          | Detail                                                              |
|------------------|----------------------------------------------------------------------|
| Auth             | Email/password, OAuth2, JWT sessions                                |
| Database         | Appwrite Databases — document-level permissions per user + composite indices |
| File Storage     | Appwrite Storage — avatars, post media, shareable health reports    |
| Real-time        | Appwrite Realtime (WebSocket) — live karma and social updates        |
| Server Functions | Node.js — FCM hooks, Razorpay webhooks, Fitbit/Garmin token exchange, ABHA integration, WhatsApp bot |
| Hosting Options  | Appwrite Cloud (free tier) or self-hosted via Docker / Railway       |
| Environments     | Separate `staging` and `production` Appwrite projects               |
| Remote Config    | Key-value collection in Appwrite for feature flags, A/B, kill-switches |

### 3.3 Data Flow

```
User Action
    │
    ▼
Write to Drift (local)           ← UI updates immediately, no loading state
    │
    ▼
Add to sync_queue (idempotency key + per-field version vector)
    │
    ▼  (background WorkManager isolate, when online)
Flush queue → Appwrite Databases  (batches of 20, exponential backoff)
    │
    ├─ Success → mark synced
    ├─ Retry (≤5) → exponential backoff
    └─ Dead Letter (>5 fails) → dead_letter_queue, surface in Settings
    │
    ▼  (foreground, Appwrite Realtime)
Receive remote changes → Per-field conflict resolution → Update Drift
```

> **Sensitive data rule**: Period, medical, BP, glucose, journal, and appointment records are AES-256-GCM encrypted client-side using HKDF-derived per-class keys before any local write or Appwrite sync. The server never holds plaintext. Stored in encrypted Drift tables.

### 3.4 Storage Strategy

| Data Type                              | Storage                          | Encrypted | Reason                                    |
|----------------------------------------|----------------------------------|-----------|-------------------------------------------|
| Food / workout / step / sleep / mood logs | **Drift**                     | No        | Relational queries, cross-module joins    |
| Food items database (10k+ records)     | **Drift**                        | No        | FTS5 full-text search, fast indexed queries |
| Nutrition goals, habits, body metrics  | **Drift**                        | No        | Structured queries                        |
| Sync queue, karma, user prefs          | **Drift**                        | No        | Structured access                         |
| Remote config cache                    | **Drift** (`remote_config_cache`)| No        | Immediate load before Appwrite refresh    |
| Festival calendar                      | **Drift** (`festival_calendar`)  | No        | Zero API dependency; cross-module queries |
| Emergency card                         | **Drift** (`emergency_card`)     | No        | Local-only, no Appwrite sync, ever        |
| BP / Glucose / SpO2 logs               | **Drift**                        | Yes       | AES-256-GCM, HKDF `bp_glucose` key       |
| Period logs                            | **Drift**                        | Yes       | AES-256-GCM, HKDF `period` key           |
| Journal entries                        | **Drift**                        | Yes       | AES-256-GCM, HKDF `journal` key          |
| Doctor appointments / prescriptions    | **Drift**                        | Yes       | AES-256-GCM, HKDF `appointments` key     |
| Lab report confirmed values            | **Drift** (`lab_reports`) + Appwrite | Sensitive fields only | Raw OCR text never uploaded |
| Lab report raw OCR text                | **Drift** only (opt-in retain)   | No        | User privacy — never synced               |
| ABHA linked record metadata            | **Drift** (`abha_links`) + Appwrite `abha_links` collection | Yes | User-consented; encrypted locally |
| ABHA OAuth token                       | `flutter_secure_storage`         | Hardware  | Never in Drift or plaintext               |
| Sessions / encryption keys / salts     | `flutter_secure_storage`         | Hardware  | Android Keystore / iOS Secure Enclave     |

---

## 4. Folder Structure

```
lib/
├── main.dart
├── app.dart                               # App root, GoRouter, theme
│
├── core/
│   ├── constants/
│   │   ├── app_constants.dart
│   │   └── api_endpoints.dart             # Appwrite project/database/collection IDs
│   ├── di/
│   │   └── providers.dart                 # Root Riverpod providers
│   ├── errors/
│   │   ├── app_exception.dart
│   │   └── error_handler.dart
│   ├── network/
│   │   ├── appwrite_client.dart           # Appwrite singleton + cert pinning
│   │   ├── connectivity_service.dart
│   │   └── sync_queue.dart                # Idempotency keys + DLQ + version vectors
│   ├── config/
│   │   └── remote_config.dart             # Feature flags, A/B tests, kill-switches
│   ├── security/
│   │   ├── encryption_service.dart        # AES-256-GCM + PBKDF2
│   │   └── key_manager.dart               # HKDF per-class key derivation
│   ├── storage/
│   │   ├── drift_service.dart             # Drift database initialisation + migrations
│   │   └── secure_storage.dart
│   └── utils/
│       ├── date_utils.dart
│       ├── indian_food_utils.dart
│       └── validators.dart
│
├── features/
│   ├── auth/
│   ├── dashboard/
│   ├── food/
│   │   ├── data/
│   │   │   ├── food_repository.dart
│   │   │   ├── food_aw_service.dart
│   │   │   ├── food_drift_service.dart
│   │   │   ├── barcode_service.dart
│   │   │   ├── ocr_service.dart           # Google ML Kit — nutrition label + lab report
│   │   │   ├── lab_report_ocr_service.dart # Lab report → health metric extraction
│   │   │   └── voice_food_service.dart
│   │   ├── domain/
│   │   │   ├── food_item_model.dart
│   │   │   └── food_log_model.dart
│   │   └── presentation/
│   ├── workout/
│   ├── steps/
│   ├── sleep/
│   ├── mood/
│   ├── period/                            # data/ domain/ presentation/
│   ├── medications/
│   ├── body_metrics/
│   ├── habits/
│   ├── nutrition/
│   ├── ayurveda/
│   ├── family/
│   ├── emergency/
│   ├── festival/
│   ├── karma/
│   ├── social/
│   ├── insight_engine/
│   │   ├── engine/
│   │   │   ├── rule_evaluator.dart        # Pure evaluation logic — no rules
│   │   │   └── insight_scheduler.dart     # When to run, throttling, dedup
│   │   ├── rules/
│   │   │   ├── nutrition_rules.dart
│   │   │   ├── sleep_rules.dart
│   │   │   ├── bp_rules.dart
│   │   │   ├── glucose_rules.dart
│   │   │   ├── mood_rules.dart
│   │   │   ├── fasting_rules.dart
│   │   │   ├── correlation_rules.dart     # Cross-module correlations
│   │   │   └── server_rules.dart          # Server-delivered rules via RemoteConfig
│   │   └── models/
│   │       ├── insight_rule.dart          # Abstract: condition(), message(), priority()
│   │       └── insight_output.dart
│   ├── blood_pressure/
│   ├── glucose/
│   ├── spo2/
│   ├── doctor_appointments/
│   ├── chronic_disease/
│   ├── meal_planner/
│   ├── recipe_builder/
│   ├── fasting_tracker/
│   ├── mental_health/
│   ├── meditation/
│   ├── journal/
│   ├── community/
│   ├── wearables/
│   ├── reports/
│   ├── personal_records/
│   ├── settings/
│   ├── abha/                              # ABHA health ID integration (NEW)
│   ├── lab_reports/                       # Lab report OCR & health metric import (NEW)
│   ├── home_widgets/                      # Android/iOS home screen widgets (NEW)
│   ├── whatsapp_bot/                      # WhatsApp logging companion (NEW)
│   └── correlation_engine/                # Cross-module data correlation (NEW)
│
├── shared/
│   ├── widgets/
│   │   ├── activity_rings.dart
│   │   ├── insight_card.dart
│   │   ├── correlation_insight_card.dart
│   │   ├── food_item_card.dart
│   │   ├── karma_level_card.dart
│   │   ├── dosha_chart.dart
│   │   ├── challenge_card.dart
│   │   ├── quick_log_fab.dart
│   │   ├── meal_tab_bar.dart
│   │   ├── shimmer_loader.dart
│   │   ├── bilingual_label.dart
│   │   ├── encryption_badge.dart
│   │   ├── health_share_card.dart
│   │   ├── abha_badge.dart
│   │   ├── home_widget_preview.dart
│   │   ├── micronutrient_bar.dart
│   │   ├── lab_value_row.dart
│   │   ├── error_retry_widget.dart
│   │   ├── sync_status_banner.dart
│   │   └── async_value_widget.dart   # Generic AsyncValue<T> wrapper — use on every async screen
│   └── theme/
│       ├── app_theme.dart                 # lightTheme + darkTheme
│       ├── app_colors.dart               # Light AND dark colour tokens
│       └── app_text_styles.dart
│
└── l10n/                                  # 22+ Indian regional languages
    ├── app_en.arb
    ├── app_as.arb  # Assamese
    ├── app_bn.arb  # Bengali
    ├── app_brx.arb # Bodo
    ├── app_doi.arb # Dogri
    ├── app_gu.arb  # Gujarati
    ├── app_hi.arb  # Hindi
    ├── app_kn.arb  # Kannada
    ├── app_ks.arb  # Kashmiri
    ├── app_kok.arb # Konkani
    ├── app_mai.arb # Maithili
    ├── app_ml.arb  # Malayalam
    ├── app_mni.arb # Manipuri
    ├── app_mr.arb  # Marathi
    ├── app_ne.arb  # Nepali
    ├── app_or.arb  # Odia
    ├── app_pa.arb  # Punjabi
    ├── app_sa.arb  # Sanskrit
    ├── app_sat.arb # Santali
    ├── app_sd.arb  # Sindhi
    ├── app_ta.arb  # Tamil
    ├── app_te.arb  # Telugu
    └── app_ur.arb  # Urdu
```

> **Naming convention**: Appwrite service files use `_aw_service.dart` suffix. Drift service files use `_drift_service.dart`. All local storage uses Drift.

---

## 5. Appwrite Setup

### 5.1 Deployment Options

| Option               | Command / URL                                            | Notes                                            |
|----------------------|----------------------------------------------------------|--------------------------------------------------|
| Appwrite Cloud       | [cloud.appwrite.io](https://cloud.appwrite.io)           | Free tier, zero ops overhead                     |
| Self-hosted (Docker) | `docker run appwrite/appwrite`                           | Any VPS, single command                          |
| Railway              | Deploy via Railway Appwrite template                     | Managed hosting alternative                      |

> **Environments**: Maintain two separate Appwrite projects: one for `staging` and one for `production`. Use separate `.env` files (`.env.staging`, `.env.prod`). Never share API keys between environments.

### 5.2 Appwrite Client Singleton (with Certificate Pinning)

```dart
// lib/core/network/appwrite_client.dart
import 'package:appwrite/appwrite.dart';

class AppwriteClient {
  static final Client _client = Client()
    ..setEndpoint(AppConfig.appwriteEndpoint)
    ..setProject(AppConfig.appwriteProjectId)
    ..setSelfSigned(status: false);             // Enforce cert validation

  // Certificate pinning — add your Appwrite domain's SHA-256 fingerprint
  // Use a native channel or http_certificate_pinning package
  // static final _pinner = CertificatePinning(allowedSHAFingerprints: [...]);

  static Client    get client    => _client;
  static Account   get account   => Account(_client);
  static Databases get databases => Databases(_client);
  static Storage   get storage   => Storage(_client);
  static Realtime  get realtime  => Realtime(_client);
  static Functions get functions => Functions(_client);
}
```

### 5.3 Collection ID Constants

```dart
// lib/core/constants/api_endpoints.dart
class AW {
  static const projectId  = String.fromEnvironment('APPWRITE_PROJECT_ID');
  static const endpoint   = String.fromEnvironment('APPWRITE_ENDPOINT');
  static const dbId       = String.fromEnvironment('APPWRITE_DATABASE_ID');

  // Core collections
  static const users            = 'users';
  static const foodLogs         = 'food_logs';
  static const foodItems        = 'food_items';
  static const workoutLogs      = 'workout_logs';
  static const stepLogs         = 'step_logs';
  static const sleepLogs        = 'sleep_logs';
  static const moodLogs         = 'mood_logs';
  static const periodLogs       = 'period_logs';
  static const medications      = 'medications';
  static const habits           = 'habits';
  static const bodyMeasurements = 'body_measurements';
  static const karmaTx          = 'karma_transactions';
  static const nutritionGoals   = 'nutrition_goals';
  static const posts            = 'posts';
  static const challenges       = 'challenges';
  static const subscriptions    = 'subscriptions';
  static const familyGroups     = 'family_groups';
  static const workouts         = 'workouts';

  // Extended collections
  static const bloodPressureLogs    = 'blood_pressure_logs';
  static const glucoseLogs          = 'glucose_logs';
  static const spo2Logs             = 'spo2_logs';
  static const doctorAppointments   = 'doctor_appointments';
  static const fastingLogs          = 'fasting_logs';
  static const mealPlans            = 'meal_plans';
  static const recipes              = 'recipes';
  static const journalEntries       = 'journal_entries';
  static const personalRecords      = 'personal_records';
  static const communityGroups      = 'community_groups';
  static const healthReports        = 'health_reports';
  static const communityDms         = 'community_dms';
  static const labReports           = 'lab_reports';         // NEW
  static const abhaLinks            = 'abha_links';          // NEW
  static const remoteConfig         = 'remote_config';       // NEW
  static const syncDeadLetter       = 'sync_dead_letter';    // NEW

  // Storage Buckets
  static const avatarsBucket        = 'avatars';
  static const postsBucket          = 'posts_media';
  static const healthReportsBucket  = 'health_reports_share'; // NEW — time-limited share links
}
```

### 5.4 Required Database Indices

> ⚠️ **Critical**: All log collections must have composite indices or dashboard load times will exceed 1 second with real user data. Add these in the Appwrite Console or via the CLI provisioning script.

| Collection           | Index Fields                           | Type        |
|----------------------|----------------------------------------|-------------|
| `food_logs`          | `[user_id, logged_at DESC]`            | Composite   |
| `step_logs`          | `[user_id, date DESC]`                 | Composite   |
| `workout_logs`       | `[user_id, logged_at DESC]`            | Composite   |
| `sleep_logs`         | `[user_id, date DESC]`                 | Composite   |
| `mood_logs`          | `[user_id, logged_at DESC]`            | Composite   |
| `blood_pressure_logs`| `[user_id, measured_at DESC]`          | Composite   |
| `glucose_logs`       | `[user_id, logged_at DESC]`            | Composite   |
| `fasting_logs`       | `[user_id, fast_start DESC]`           | Composite   |
| `food_items`         | `name` full-text                       | Full-text   |
| `food_items`         | `barcode`                              | Key         |
| `challenges`         | `[start_date, end_date, is_active]`    | Composite   |

### 5.5 Console Configuration Checklist

- [ ] Create database and note the `DATABASE_ID`
- [ ] Create all core collections listed in `AW` constants above
- [ ] **Add all composite indices from Section 5.4**
- [ ] Set document-level permissions on every collection: `Role.user({userId})` for read/write
- [ ] Enable Google OAuth2 under Auth → OAuth2 Providers
- [ ] Enable Apple Sign-In (iOS) under Auth → OAuth2 Providers
- [ ] Enable SMTP under Settings → SMTP (password reset emails)
- [ ] Create Storage buckets: `avatars`, `posts_media`, `health_reports_share`
- [ ] Deploy Appwrite Functions: FCM hooks, Razorpay webhook, Fitbit token exchange, Garmin token exchange, WhatsApp bot webhook, ABHA token exchange
- [ ] Configure API rate limiting
- [ ] Set up staging environment (separate project, separate `.env`)
- [ ] Set up daily database export cron for disaster recovery

---

## 6. Database Schema

> All collections live in a single Appwrite Database. Document IDs are auto-generated via `ID.unique()`. Every collection enforces document-level permissions — users can only access their own records.

### `users`

| Field               | Type     | Notes                                                             |
|---------------------|----------|-------------------------------------------------------------------|
| `$id`               | string   | Appwrite auto ID — matches Auth `userId`                          |
| `name`              | string   | Display name                                                      |
| `email`             | email    | Unique, synced from Auth                                          |
| `dob`               | datetime |                                                                   |
| `gender`            | enum     | `male` / `female` / `other` / `prefer_not`                        |
| `height_cm`         | double   |                                                                   |
| `weight_kg`         | double   |                                                                   |
| `goal`              | enum     | `lose_weight` / `gain_muscle` / `maintain` / `endurance`          |
| `activity_level`    | enum     | `sedentary` / `light` / `moderate` / `active` / `very_active`    |
| `dosha_type`        | enum     | `vata` / `pitta` / `kapha` / compound types                       |
| `blood_group`       | enum     | `A+` / `A-` / `B+` / `B-` / `O+` / `O-` / `AB+` / `AB-`        |
| `language`          | enum     | 22 Indian language codes                                          |
| `subscription_tier` | enum     | `free` / `premium` / `family`                                     |
| `karma_total`       | integer  | Total XP accumulated                                              |
| `karma_level`       | integer  | Level 1–50                                                        |
| `is_low_data_mode`  | boolean  | Enables 2G/3G optimisations                                       |
| `chronic_conditions`| string   | JSON: `["diabetes","hypertension"]`                               |
| `wearable_source`   | enum     | `fitbit` / `garmin` / `mi_band` / `boat` / `none`                |
| `referral_code`     | string   | Unique code for referral program                                  |
| `referred_by`       | string   | Referrer `user_id` (nullable)                                     |
| `abha_id`           | string   | Ayushman Bharat Health Account ID (nullable, user-linked) — **NEW** |
| `chronotype`        | enum     | `early_bird` / `night_owl` / `intermediate` (auto-detected) — **NEW** |
| `wedding_role`      | enum     | `bride` / `groom` / `guest` / `relative` / `none` — **NEW** |
| `wedding_relation_type` | string | `father_bride` / `mother_bride` / `father_groom` / `mother_groom` / `sibling` / `close_family` (nullable) — **NEW** |
| `wedding_start_date` | datetime | Start of wedding festivities (nullable) — **NEW** |
| `wedding_end_date`  | datetime | End of wedding festivities (nullable) — **NEW** |
| `wedding_prep_weeks` | integer | Weeks of pre-wedding preparation (nullable) — **NEW** |
| `wedding_events`    | string   | JSON: `["haldi","mehendi","sangeet","vivah","reception"]` — **NEW** |
| `wedding_primary_goal` | enum | `tone_up` / `energised` / `manage_stress` / `manage_indulgence` (nullable) — **NEW** |
| `$createdAt`        | datetime | Auto                                                              |
| `$updatedAt`        | datetime | Auto                                                              |

### `food_logs`

| Field          | Type     | Notes                                                              |
|----------------|----------|--------------------------------------------------------------------|
| `$id`          | string   | Auto                                                               |
| `user_id`      | string   | Relation → `users.$id`                                             |
| `food_item_id` | string   | Relation → `food_items` (nullable)                                 |
| `recipe_id`    | string   | Relation → `recipes` (nullable)                                    |
| `food_name`    | string   | Denormalised for offline reads                                     |
| `meal_type`    | enum     | `breakfast` / `lunch` / `dinner` / `snack`                        |
| `quantity_g`   | double   | Grams consumed                                                     |
| `calories`     | double   |                                                                    |
| `protein_g`    | double   |                                                                    |
| `carbs_g`      | double   |                                                                    |
| `fat_g`        | double   |                                                                    |
| `fiber_g`      | double   | Optional                                                           |
| `vitamin_d_mcg`| double   | Micronutrient — **NEW**                                            |
| `vitamin_b12_mcg`| double | Micronutrient — **NEW**                                            |
| `iron_mg`      | double   | Micronutrient — **NEW**                                            |
| `calcium_mg`   | double   | Micronutrient — **NEW**                                            |
| `logged_at`    | datetime |                                                                    |
| `log_method`   | enum     | `search` / `barcode` / `ocr` / `voice` / `photo` / `recipe` / `planner` / `whatsapp` / `copy_yesterday` — **NEW** |
| `sync_status`  | enum     | `synced` / `pending` / `conflict`                                  |
| `idempotency_key` | string | SHA-256(userId + mealType + localId + createdAt) — **NEW**        |
| `field_versions`  | string | JSON: per-field `updatedAt` map for conflict resolution — **NEW**  |

### `food_items`

| Field                | Type    | Notes                                                              |
|----------------------|---------|--------------------------------------------------------------------|
| `$id`                | string  | Auto                                                               |
| `name`               | string  | English name                                                       |
| `name_local`         | string  | Local language script (e.g., Devanagari, Bengali)                  |
| `region`             | enum    | `north` / `south` / `east` / `west` / `northeast` / `central`     |
| `barcode`            | string  | EAN-13 (nullable)                                                  |
| `calories_per_100g`  | double  |                                                                    |
| `protein_per_100g`   | double  |                                                                    |
| `carbs_per_100g`     | double  |                                                                    |
| `fat_per_100g`       | double  |                                                                    |
| `fiber_per_100g`     | double  | Optional                                                           |
| `vitamin_d_per_100g` | double  | Micronutrient — **NEW**                                            |
| `vitamin_b12_per_100g`| double | Micronutrient — **NEW**                                            |
| `iron_per_100g`      | double  | Micronutrient — **NEW**                                            |
| `calcium_per_100g`   | double  | Micronutrient — **NEW**                                            |
| `is_indian`          | boolean | Flag for Indian food items                                         |
| `serving_sizes`      | string  | JSON: `[{"name":"katori","grams":150}]`                            |
| `source`             | enum    | `openfoodfacts` / `manual` / `community` / `restaurant`            |
| `restaurant_name`    | string  | e.g. `"Swiggy — McDonald's"` (nullable)                            |
| `swiggy_item_id`     | string  | For Swiggy deep-link (nullable) — **NEW**                          |
| `zomato_item_id`     | string  | For Zomato deep-link (nullable) — **NEW**                          |

### `lab_reports` — **NEW**

| Field              | Type     | Notes                                                         |
|--------------------|----------|---------------------------------------------------------------|
| `user_id`          | string   | Relation → `users`                                            |
| `report_date`      | datetime |                                                               |
| `lab_name`         | string   | e.g. Dr Lal PathLabs                                          |
| `extracted_values` | string   | JSON: `{"glucose_fasting":92,"hemoglobin":13.5,"cholesterol":180}` |
| `raw_text`         | string   | OCR raw text (nullable — privacy opt-in)                      |
| `confirmed_by_user`| boolean  | User confirmed extracted values before import                 |
| `source`           | enum     | `ocr_photo` / `ocr_pdf` / `manual`                            |
| `imported_metrics` | string   | JSON: list of metric types successfully imported               |

### `abha_links` — **NEW**

| Field           | Type     | Notes                                                              |
|-----------------|----------|--------------------------------------------------------------------|
| `user_id`       | string   | Relation → `users`                                                 |
| `abha_id`       | string   | 14-digit ABHA ID                                                   |
| `abha_address`  | string   | `username@abdm` health address                                     |
| `linked_at`     | datetime |                                                                    |
| `consent_granted`| boolean | User explicitly consented to ABHA data pull                       |
| `last_sync`     | datetime | Last time health records pulled from ABHA                          |

### `blood_pressure_logs`

| Field            | Type     | Notes                                                      |
|------------------|----------|------------------------------------------------------------|
| `user_id`        | string   | Relation → `users`                                         |
| `systolic`       | integer  | mmHg                                                       |
| `diastolic`      | integer  | mmHg                                                       |
| `pulse`          | integer  | bpm (optional)                                             |
| `logged_at`      | datetime |                                                            |
| `classification` | enum     | `normal` / `elevated` / `stage1` / `stage2` / `crisis`     |
| `notes`          | string   | Optional                                                   |
| `source`         | enum     | `manual` / `wearable` / `health_connect` / `lab_report`    |
| `sync_status`    | enum     | `synced` / `pending` / `conflict`                          |
| `idempotency_key`| string   | **NEW**                                                    |

### `glucose_logs`

| Field            | Type     | Notes                                                           |
|------------------|----------|-----------------------------------------------------------------|
| `user_id`        | string   | Relation → `users`                                              |
| `glucose_mgdl`   | double   | mg/dL                                                           |
| `reading_type`   | enum     | `fasting` / `post_meal` / `random` / `bedtime`                  |
| `food_log_id`    | string   | Relation → `food_logs` (nullable)                               |
| `logged_at`      | datetime |                                                                 |
| `classification` | enum     | `normal` / `prediabetic` / `diabetic`                           |
| `hba1c_estimate` | double   | Auto-estimated from 90-day rolling average (nullable) — **NEW** |
| `notes`          | string   | Optional                                                        |
| `source`         | enum     | `manual` / `wearable` / `lab_report` — **NEW**                  |
| `sync_status`    | enum     |                                                                 |
| `idempotency_key`| string   | **NEW**                                                         |

### `sleep_logs`

| Field             | Type     | Notes                                              |
|-------------------|----------|----------------------------------------------------|
| `user_id`         | string   | Relation → `users`                                 |
| `date`            | datetime |                                                    |
| `bedtime`         | string   | `HH:MM`                                            |
| `wake_time`       | string   | `HH:MM`                                            |
| `duration_min`    | integer  |                                                    |
| `quality_score`   | integer  | 1–5 emoji scale                                    |
| `deep_sleep_min`  | integer  | From HealthKit / Health Connect                    |
| `sleep_debt_min`  | integer  | Cumulative weekly deficit vs 7h target — **NEW**   |
| `notes`           | string   |                                                    |
| `source`          | enum     | `manual` / `health_connect` / `healthkit` / `wearable` |

### `habits`

| Field            | Type    | Notes                                              |
|------------------|---------|----------------------------------------------------|
| `user_id`        | string  | Relation → `users`                                 |
| `name`           | string  |                                                    |
| `icon`           | string  | Emoji or icon name                                 |
| `target_count`   | integer |                                                    |
| `unit`           | string  | `glasses` / `minutes` / `pages`                    |
| `frequency`      | enum    | `daily` / `weekdays` / `custom`                    |
| `current_streak` | integer |                                                    |
| `longest_streak` | integer |                                                    |
| `streak_recovery_used` | boolean | Whether streak-recovery was used this cycle — **NEW** |
| `reminder_time`  | string  | `HH:MM` (nullable)                                 |
| `is_preset`      | boolean |                                                    |

### `health_reports`

| Field               | Type     | Notes                                                           |
|---------------------|----------|-----------------------------------------------------------------|
| `user_id`           | string   | Relation → `users`                                              |
| `period`            | enum     | `weekly` / `monthly`                                            |
| `report_start`      | datetime |                                                                 |
| `report_end`        | datetime |                                                                 |
| `summary_data`      | string   | JSON snapshot of all metrics                                    |
| `pdf_local_path`    | string   | Generated locally                                               |
| `share_file_id`     | string   | Appwrite Storage file ID for shareable link (nullable) — **NEW**|
| `share_expires_at`  | datetime | Expiry of shareable link (7 days) — **NEW**                     |
| `share_url`         | string   | Time-limited read-only URL — **NEW**                            |
| `generated_at`      | datetime |                                                                 |

### Other Collections (Summary)

| Collection           | Key Fields                                                                         |
|----------------------|------------------------------------------------------------------------------------|
| `karma_transactions` | `user_id`, `amount`, `action`, `description`, `balance_after`                     |
| `nutrition_goals`    | `user_id`, `tdee`, `calorie_goal`, `protein_g`, `carbs_g`, `fat_g`, `goal_type`, `vit_d_mcg`, `b12_mcg`, `iron_mg`, `calcium_mg` |
| `posts`              | `user_id`, `content`, `media_file_id`, `post_type`, `likes_count`                 |
| `challenges`         | `title`, `challenge_type`, `target_value`, `start_date`, `end_date`, `karma_reward`, `festival_tag` |
| `subscriptions`      | `user_id`, `plan`, `status`, `razorpay_sub_id`, `start_date`, `end_date`, `amount_paid` |
| `family_groups`      | `admin_id`, `name`, `members` (JSON), `leaderboard_type`                          |
| `workouts`           | `title`, `youtube_id`, `duration_min`, `difficulty`, `category`, `language`, `is_premium`, `rpe_level` |
| `community_dms`      | `sender_id`, `receiver_id`, `content`, `sent_at`, `is_read`                       |
| `remote_config`      | `key`, `value`, `type`, `rollout_pct`, `ab_seed` — **NEW**                        |
| `sync_dead_letter`   | `user_id`, `original_item`, `fail_count`, `last_error`, `created_at` — **NEW**    |

---

## 7. Local Storage — Drift (SQLite)

### 7.1 Architecture Decision

**Drift (SQLite)** is used for ALL local data storage. It provides:
- Unified storage for relational and encrypted sensitive content
- Type-safe SQL queries compiled to Dart at build time
- FTS5 full-text search for the 10,000+ item food database
- Built-in migration strategies with `MigrationStrategy`
- Reactive `Stream` queries that update the UI on data change
- Join support for cross-module correlation queries
- Encryption at rest via SQLCipher integrated with Drift

### 7.2 Drift Database Schema (Key Tables)

```dart
// lib/core/storage/app_database.dart

@DriftDatabase(tables: [
  // Core logging tables
  FoodLogs, FoodItems, WorkoutLogs, StepLogs, SleepLogs,
  MoodLogs, Medications, Habits, HabitCompletions, BodyMeasurements,
  FastingLogs, MealPlans, Recipes, PersonalRecords, NutritionGoals,
  KarmaTransactions, SyncQueue, SyncDeadLetter,
  // Sensitive / encrypted tables
  BloodPressureLogs, GlucoseLogs, Spo2Logs, PeriodLogs,
  JournalEntries, DoctorAppointments,
  // India-specific tables
  LabReports, AbhaLinks,
  // Platform / infrastructure tables
  EmergencyCard, FestivalCalendar, RemoteConfigCache,
])
class AppDatabase extends _$AppDatabase {
  // encryptionKey is the AES-256 master key from KeyManager (32 bytes, base64-encoded)
  AppDatabase(String encryptionKey) : super(_openConnection(encryptionKey));

  static QueryExecutor _openConnection(String encryptionKey) {
    // SQLCipher: full database encryption using the master key
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'fitkarma.db'));
      return NativeDatabase.createInBackground(
        file,
        setup: (rawDb) {
          // Pragma must be executed before any other statement
          rawDb.execute("PRAGMA key = '$encryptionKey'");
          rawDb.execute("PRAGMA cipher_page_size = 4096");
        },
      );
    });
  }

  @override
  int get schemaVersion => 5; // Increment on every migration

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      // Fresh installs: create all tables in one pass
      onCreate: (m) async { await m.createAll(); },
      onUpgrade: (m, from, to) async {
        // v1 → v2: add sync reliability columns to food_logs
        if (from < 2) {
          await m.addColumn(foodLogs, foodLogs.idempotencyKey);
          await m.addColumn(foodLogs, foodLogs.fieldVersions);
        }
        // v2 → v3: sleep debt tracking + lab reports
        if (from < 3) {
          await m.addColumn(sleepLogs, sleepLogs.sleepDebtMin);
          await m.createTable(labReports);
        }
        // v3 → v4: encrypted health tables (BP, glucose, period, journal, appointments)
        // Note: these tables are present in the @DriftDatabase decorator so createAll()
        // on fresh installs already creates them. This block only runs for users upgrading
        // from schema v3 where these tables did not yet exist.
        if (from < 4) {
          await m.createTable(bloodPressureLogs);
          await m.createTable(glucoseLogs);
          await m.createTable(spo2Logs);
          await m.createTable(periodLogs);
          await m.createTable(journalEntries);
          await m.createTable(doctorAppointments);
        }
        // v4 → v5: India ecosystem + platform tables
        if (from < 5) {
          await m.createTable(abhaLinks);
          await m.createTable(emergencyCard);
          await m.createTable(festivalCalendar);
          await m.createTable(remoteConfigCache);
        }
      },
    );
  }
}
```

> **Sensitive data handling**: Fields in `BloodPressureLogs`, `GlucoseLogs`, `PeriodLogs`, `JournalEntries`, and `DoctorAppointments` that contain sensitive PII or health metrics are encrypted via `EncryptionService` before being passed to Drift companions for insertion/update. Read queries decrypt these fields before returning domain models.

### 7.3 Drift Encryption Configuration

Drift supports database-level encryption via `sqlcipher`. For FitKarma, we apply a two-tier approach:
1. **Database Encryption**: Full database is encrypted using the master key.
2. **Field-level Encryption**: For extremely sensitive health data, we apply a redundant layer of AES-256-GCM encryption on the field value itself using HKDF-derived keys.

### 7.4 FTS5 Full-Text Search Setup

The food search target (< 200 ms against 10,000+ items) requires an FTS5 virtual table. Add the following to `AppDatabase`:

```dart
// lib/core/storage/app_database.dart (continued)

// Step 1 — Declare the FTS5 virtual table alongside your regular tables
@DriftDatabase(tables: [...]) // same decorator as above
class AppDatabase extends _$AppDatabase {
  // ...

  // Create FTS5 virtual table and triggers in onCreate
  // (MigrationStrategy.onCreate runs AFTER m.createAll())
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      // Create FTS5 virtual table mirroring food_items.name + name_local
      await customStatement('''
        CREATE VIRTUAL TABLE food_items_fts USING fts5(
          name,
          name_local,
          content="food_items",
          content_rowid="rowid"
        )
      ''');
      // Keep FTS in sync with the base table via triggers
      await customStatement('''
        CREATE TRIGGER food_items_ai AFTER INSERT ON food_items BEGIN
          INSERT INTO food_items_fts(rowid, name, name_local)
          VALUES (new.rowid, new.name, new.name_local);
        END
      ''');
      await customStatement('''
        CREATE TRIGGER food_items_ad AFTER DELETE ON food_items BEGIN
          INSERT INTO food_items_fts(food_items_fts, rowid, name, name_local)
          VALUES ('delete', old.rowid, old.name, old.name_local);
        END
      ''');
      await customStatement('''
        CREATE TRIGGER food_items_au AFTER UPDATE ON food_items BEGIN
          INSERT INTO food_items_fts(food_items_fts, rowid, name, name_local)
          VALUES ('delete', old.rowid, old.name, old.name_local);
          INSERT INTO food_items_fts(rowid, name, name_local)
          VALUES (new.rowid, new.name, new.name_local);
        END
      ''');
    },
    // ...existing onUpgrade...
  );

  // Step 2 — FTS5 search query (used by FoodRepository.search)
  Future<List<FoodItem>> searchFoodFts(String query) {
    // FTS5 prefix search: "dal*" matches "dal", "daliya", etc.
    final ftsQuery = query.trim().split(' ').map((t) => '$t*').join(' ');
    return customSelect(
      '''
      SELECT fi.* FROM food_items fi
      JOIN food_items_fts fts ON fi.rowid = fts.rowid
      WHERE food_items_fts MATCH ?
      ORDER BY bm25(food_items_fts) -- built-in BM25 relevance ranking
      LIMIT 50
      ''',
      variables: [Variable.withString(ftsQuery)],
    ).map((row) => FoodItem.fromData(row.data)).get();
  }
}
```

> **Seeding note**: After the initial `food_items` bulk insert (via `insertAll`), run `INSERT INTO food_items_fts(food_items_fts) VALUES ('rebuild')` once to populate the FTS index. Subsequent inserts are handled automatically by the triggers above.

---

## 8. Offline Sync Architecture

### Strategy

1. **Write locally first** — all user actions write to Drift immediately; no loading state shown.
2. **Enqueue with idempotency** — a `SyncQueueItem` with a unique `idempotencyKey` is inserted into the Drift `sync_queue` table on every create/update/delete.
3. **Background flush** — a dedicated WorkManager background isolate (with its own Drift init) monitors connectivity. When online, flushes queue in batches of 20 using exponential backoff.
4. **Dead-letter queue** — items that fail more than 5 times are moved to `sync_dead_letter` and surfaced to the user in Settings → Data & Sync.
5. **Delta sync** — on app resume, only documents changed since `$updatedAt > lastSyncTimestamp` are fetched.
6. **Real-time updates** — while foregrounded, Appwrite Realtime pushes changes; merged using per-field version vectors.

### Conflict Resolution Matrix

| Data Type                       | Strategy                              | Rationale                                            |
|---------------------------------|---------------------------------------|------------------------------------------------------|
| Food / Workout / Sleep / Mood   | Append-only (no conflict)             | Logs are events — each write is unique               |
| Step counts                     | `max(client, server)`                 | Never lose steps                                     |
| User profile fields             | Per-field LWW via `field_versions`    | Avoids full overwrite when editing on two devices    |
| Karma / XP balance              | Server wins                           | Prevent client-side score manipulation               |
| Social posts / likes            | Server wins                           | Server is canonical social state                     |
| Subscription status             | Server wins                           | Razorpay is the source of truth                      |
| Period / Journal / Medical logs | Client wins                           | Only the user holds the decryption key               |
| BP / Glucose logs               | Client wins                           | Encrypted medical data — client is authoritative     |
| Wearable data                   | `max(client, server)`                 | Health data must not decrease                        |
| Workout edits (sets/reps)       | Tier-3: user-prompted diff UI         | Edits on two devices → show merge diff               |

### Sync Queue Item (Updated)

```dart
// lib/core/network/sync_queue.dart

@DataClassName('SyncQueueEntry')
class SyncQueue extends Table {
  TextColumn get id             => text()();
  TextColumn get collection     => text()();
  TextColumn get operation      => text()();     // 'create' | 'update' | 'delete'
  TextColumn get localId        => text()();
  TextColumn get appwriteDocId  => text().nullable()();
  TextColumn get payload        => text()();     // JSON
  TextColumn get idempotencyKey => text()();     // SHA-256(userId + entityType + localId + createdAt)
  TextColumn get fieldVersions  => text().nullable()(); // JSON: per-field updatedAt map
  DateTimeColumn get createdAt  => dateTime()();
  IntColumn get retryCount      => integer().withDefault(const Constant(0))();
  TextColumn get lastError      => text().nullable()();
}

// Dead-letter queue — items with retryCount > 5 move here
@DataClassName('SyncDeadLetterEntry')
class SyncDeadLetter extends Table {
  TextColumn get id             => text()();
  TextColumn get userId         => text()();
  TextColumn get originalItem   => text()(); // JSON snapshot of failed SyncQueueEntry
  IntColumn get failCount       => integer()();
  TextColumn get lastError      => text()();
  DateTimeColumn get createdAt  => dateTime()();
}

// Idempotency key generation
String generateIdempotencyKey(String userId, String entityType, String localId) {
  final input = '$userId:$entityType:$localId:${DateTime.now().millisecondsSinceEpoch}';
  return sha256.convert(utf8.encode(input)).toString();
}

// Retry schedule: 1s → 2s → 4s → 8s → 16s (exponential backoff, max 5 attempts)
// After 5 failures: move to dead_letter, stop retrying, notify user
```

### Background Isolate Safety

```dart
// Background WorkManager entry point — must re-init Drift and AppwriteClient
// independently (no shared Riverpod ProviderContainer from the UI isolate)
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // 1. Re-initialise storage
    final db = AppDatabase();

    // 2. Check connectivity before attempting sync
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) return Future.value(true);

    // 3. Only run sync when radio is already active (avoid waking radio on Doze)
    await SyncQueueProcessor(db).flushPending();
    return Future.value(true);
  });
}
```

---

## 9. Authentication & Onboarding

### Auth Configuration

| Property          | Detail                                                                 |
|-------------------|------------------------------------------------------------------------|
| Methods           | Email/password, Google OAuth2, Apple Sign-In (iOS)                     |
| Session storage   | `flutter_secure_storage` — Appwrite JWT stored encrypted               |
| Session renewal   | `account.updateSession(sessionId: 'current')` before expiry            |
| Biometric lock    | `local_auth` — guards app re-open                                      |
| Root detection    | `flutter_jailbreak_detection` — warn user, do not block                |
| Permissions model | `Permission.read(Role.user(uid))` + `Permission.write(Role.user(uid))` |
| Account merge     | Email + Google OAuth with same email → automatic merge via Appwrite    |

### Onboarding Flow

The onboarding is **6 screens**, routed as `/onboarding/1` through `/onboarding/6`. A progress pill indicator is visible on all steps.

| Step | Route | Content |
|------|-------|---------|
| 1 | `/onboarding/1` | Name · Gender · Date of Birth |
| 2 | `/onboarding/2` | Height · Weight · Fitness Goal · Activity Level |
| 3 | `/onboarding/3` | Chronic Conditions (optional multi-select — activates management modules) |
| 4 | `/onboarding/4` | Dosha Quiz (12 questions → vata/pitta/kapha % breakdown) |
| 5 | `/onboarding/5` | Language selection (22 Indian languages) · Health permissions (contextual) |
| 6 | `/onboarding/6` | ABHA Link (optional, skippable) · Wearable connection (optional, skippable) |

> **Health permissions** are requested contextually on step 5, never at first launch. Users may grant step-counter, HR, and location permissions here or defer until first use of the relevant feature.

- Dosha quiz calculates vata / pitta / kapha percentage automatically.
- Chronic condition selection activates the relevant management module immediately after onboarding.
- ABHA linking is optional but prominently encouraged for health record access.
- **Karma reward**: +50 XP for completing onboarding.

---

## 10. Core Feature Modules

### 10.1 Dashboard

- **Data source**: Drift only on launch — renders in < 1 second with no network dependency.
- **Activity rings**: Calories · Steps · Water · Active minutes.
- **Insight card**: Amber card from the on-device Rule Engine + cross-module correlations; max 2 per day; dismissable and rateable (👍/👎).
- **Karma bar**: Current XP, level badge, and progress to next level.
- **Quick-log FAB**: Orange speed-dial FAB for one-tap logging of food, water, mood, workout, BP, and glucose.
- **Today's Meals section**: Horizontal tab bar with meal summary cards below.
- **Morning briefing notification**: Today's calorie goal, weather-adjusted plan, fasting window times.
- **Android home screen widgets**: `home_widget` package — 4×1 steps+calories ring, 2×1 quick-log button, lock screen water counter. **NEW**
- **iOS home screen widgets**: Same via `home_widget` + WidgetKit bridge. **NEW**
- **Screens**: `DashboardHome`, `KarmaProgressCard`, `DailyRingWidget`, `HomeWidgetConfig`

### 10.2 Food Logging

| Method            | Implementation                                                          | Notes                                              |
|-------------------|-------------------------------------------------------------------------|---------------------------------------------------|
| Search            | Drift FTS5 (< 200ms) → Appwrite query → OpenFoodFacts fallback          | Full-text search on `name` + `name_local`         |
| Barcode           | `flutter_barcode_scanner` → OpenFoodFacts API → cache to Drift          |                                                   |
| OCR (label)       | Google ML Kit TextRecognitionV2 — nutrition label scan                   | On-device only                                    |
| Photo AI          | Google ML Kit ObjectDetection — identify food from photo                 | On-device only                                    |
| Voice             | `speech_to_text` — *"dal chawal"* → search → confirm                    | Hindi + English support                           |
| Indian DB         | Pre-seeded database with katori/piece/glass portions — all regions       | Seeded via Appwrite import                        |
| Restaurant        | Swiggy/Zomato community-seeded menu calories with deep-link buttons      | **NEW** — cache to Drift `food_items`             |
| Recipe log        | Log an entire saved recipe as one entry                                  |                                                   |
| Copy Yesterday    | One-tap duplicate of all meals from the previous day                     | **NEW** — `log_method: copy_yesterday`            |
| WhatsApp           | Log via WhatsApp Business bot (send "dal rice" → get calorie reply)     | **NEW** — see Section 17.8                        |

**Micronutrients tracked**: Iron · Vitamin B12 · Vitamin D · Calcium — the four most deficient in India. Weekly gap analysis in the Nutrition module. **NEW**

**Karma**: +10 XP per food log; +30 XP for the first log of the day.

### 10.3 Workout System

| Property          | Detail                                                                               |
|-------------------|--------------------------------------------------------------------------------------|
| YouTube           | `youtube_player_flutter` plays by video ID                                           |
| GPS Outdoor       | `geolocator` + `flutter_map` + **offline tile cache** (`flutter_map_tile_caching`)  |
| Structured        | 30-day and 12-week programs with day-by-day plans                                    |
| Categories        | Yoga · HIIT · Strength · Cardio · Dance · Bollywood Fitness · Cricket · Kabaddi · Pranayama |
| HR Zones          | Zone 1–5 integrated with wearable data                                               |
| Workout Calendar  | Schedule future workouts; rest day recommendations based on recovery score            |
| Custom Builder    | Exercise, sets, reps, rest timer, RPE, superset grouping — **NEW**                  |
| Rest Timer        | Configurable per-exercise rest timer with audio cue — **NEW**                        |
| RPE Logging       | Rate of Perceived Exertion (1–10) alongside HR zone — **NEW**                        |
| Warm-up/Cool-down | Pre/post workout guidance triggered automatically                                     |
| PRs               | Personal records tracked per exercise                                                 |
| Offline Maps      | First GPS workout triggers tile pre-cache for home region — **NEW**                  |

**Karma**: +20 XP per workout; +50 XP for completing a program day; +100 XP for a new personal record.

### 10.4 Step Tracking

- **Primary sensor**: Health Connect (Android 14+) / HealthKit (iOS).
- **Fallback**: `pedometer` package via device accelerometer.
- **Background**: WorkManager isolate (Android) / `BGAppRefreshTask` (iOS).
- **Adaptive goal**: Daily target adjusts based on 7-day rolling average.
- **Inactivity nudge**: Detects inactivity > 60 min and pushes a gentle movement reminder.
- **Karma**: +5 XP per 1,000 steps (maximum 50 XP/day).

### 10.5 Karma System

| Action                       | XP                               |
|------------------------------|----------------------------------|
| Log food                     | +10 (+30 first/day)              |
| Log workout                  | +20                              |
| Complete program day         | +50                              |
| Log sleep                    | +5                               |
| Log mood                     | +3                               |
| Complete challenge           | +50 to +200                      |
| Complete onboarding          | +50                              |
| Log BP or glucose            | +5                               |
| Complete a fast              | +15                              |
| New personal record          | +100                             |
| Link ABHA account            | +100 (one-time) — **NEW**        |
| Import lab report            | +30 — **NEW**                    |
| Positive social interaction  | +5 (likes received, helpful comment) — **NEW** |
| Successful referral          | +500 (referrer) / +100 (referee) |
| Streak recovery used         | −50 XP (cost to recover streak)  |
| 7-day streak multiplier      | ×1.5 earn rate                   |
| 30-day streak multiplier     | ×2.0 earn rate                   |

**Levels**: 50 tiers — Seedling → Warrior → Yogi → Guru → Legend
**Karma Store**: Redeem XP for premium workout packs, digital badges, profile themes, streak recoveries.
**Leaderboards**: Friends · City · National · Seasonal (festival-tied) — weekly reset. **NEW**: seasonal leaderboards tied to Indian festival calendar.
**Streak Recovery**: Users can spend 50 XP from the Karma Store to recover a broken streak — reduces day-after churn. **NEW**

---

## 11. Advanced Feature Modules

### 11.1 Sleep Tracker

| Property           | Detail                                                                         |
|--------------------|--------------------------------------------------------------------------------|
| Manual log         | Time pickers for bedtime/wake time, emoji quality scale (1–5), notes           |
| Auto-detect        | Syncs from HealthKit / Health Connect / wearable                               |
| Sleep Debt         | Cumulative weekly deficit vs 7h target — displayed as a debt/credit bar — **NEW** |
| Chronotype         | After 30 days of data, detects early bird / night owl / intermediate — **NEW** |
| Insights           | Weekly average vs recommended, sleep–workout correlation, mood correlation      |
| Tips               | Ayurvedic sleep tips triggered when avg < 6h, personalised by dosha type       |
| Burnout detection  | Sustained low mood + poor sleep + low energy over 7 days → recovery flow       |
| Karma              | +5 XP per sleep log                                                             |

### 11.2 Mood Tracker

| Property     | Detail                                                                      |
|--------------|-----------------------------------------------------------------------------|
| Logging      | 5-emoji selector, energy slider (1–10), stress slider (1–10) — < 30 sec    |
| Tags         | `anxious` · `calm` · `focused` · `tired` · `motivated` · `irritable`       |
| Voice note   | Optional 1-minute note — stored locally only, never uploaded                |
| Insights     | Mood heatmap calendar, energy/stress trend, mood–workout and sleep correlations |
| Screen time  | Correlates Digital Wellbeing / Screen Time data with mood                   |
| Karma        | +3 XP per log                                                               |

### 11.3 Period Tracker

- All data AES-256-GCM encrypted using HKDF-derived `period` key — stored in encrypted Drift tables.
- Sync to Appwrite is opt-in only — default behaviour is local-only.
- Cycle prediction based on average of the last 3 cycles; ovulation window estimation included.
- Tracked symptoms: cramps, bloating, mood swings, headache, fatigue, spotting.
- Workout suggestions adapt to cycle phase: menstrual / follicular / ovulatory / luteal.
- **PCOD/PCOS management mode**: Irregular cycle support, specialist referral prompts, hormone-friendly workout suggestions.
- **Privacy guarantee**: Period data is never used for ads or shared with any third party.

### 11.4 Medication Reminder

| Property             | Detail                                                                |
|----------------------|-----------------------------------------------------------------------|
| Reminders            | `flutter_local_notifications` — per-medication schedules, offline    |
| Refill alert         | Push notification 3 days before estimated refill date                 |
| Categories           | Prescription · OTC · Supplement · Ayurvedic                           |
| Prescription OCR     | Photograph prescription → ML Kit OCR → auto-populate name/dose/frequency — **NEW** |
| Pharmacy deep-link   | Refill reminder links directly to 1mg/PharmEasy product page — **NEW**|
| Emergency card       | Active medications auto-populate the Emergency Health Card            |

### 11.5 Body Measurements Tracker

- Tracked metrics: weight, height, chest, waist, hips, arms, thighs, body fat %.
- Auto-calculated ratios: BMI, waist-to-hip, waist-to-height.
- BMI history chart with trend lines and goal markers.
- Progress photos stored locally only — never uploaded.
- Before/after comparison slider widget.

### 11.6 Smart Habit Tracker

- **Preset habits**: 8 glasses water · 10-min meditation · 30-min walk · read 10 pages · no sugar.
- **Custom habits**: user-defined name, emoji icon, target count, unit, frequency.
- Individual streak tracking with visual flame indicator.
- **Streak Recovery**: spend 50 Karma XP to recover a broken streak (once per habit per month). **NEW**
- Weekly completion heatmap (GitHub contribution graph style).
- **Karma**: +2 XP per habit completion; +10 XP for a 7-day streak.

### 11.7 Nutrition Goal Engine

```dart
// TDEE — Mifflin-St Jeor equation
// Male:   BMR = (10 × weight_kg) + (6.25 × height_cm) − (5 × age) + 5
// Female: BMR = (10 × weight_kg) + (6.25 × height_cm) − (5 × age) − 161
// TDEE = BMR × activity_factor

const activityFactors = {
  'sedentary':   1.2,
  'light':       1.375,
  'moderate':    1.55,
  'active':      1.725,
  'very_active': 1.9,
};
```

- Daily nutrition ring charts with traffic-light status.
- Contextual smart nudges: *"You're 18g protein short today. Add a glass of lassi!"*
- **Micronutrient tracking**: Iron · B12 · Vitamin D · Calcium with weekly gap analysis. **NEW** (goals from ICMR RDA for Indian population)
- **Supplement gap report**: Weekly actionable report of micronutrient deficiencies.
- Grocery list generator: auto-generates from nutrition goals or weekly meal plan.
- Intermittent fasting integration: eating window logged against daily calorie budget.

### 11.8 Ayurveda Personalisation Engine

- 12-question dosha quiz produces a vata/pitta/kapha percentage breakdown.
- Daily rituals (Dinacharya) recommended based on dosha type and current season.
- Seasonal plans (Ritucharya) — food and activity adjustments per Indian season.
- Herbal remedies library: ashwagandha, triphala, brahmi, turmeric — with evidence-based notes.
- **Screens**: `AyurvedaHome`, `DoshaProfile`, `DailyRituals`, `SeasonalPlan`, `HerbalRemedies`

### 11.9 Family Health Profiles

- One family admin, up to 6 members (Family plan).
- Each member is an independent Appwrite account — admin has view-only access.
- Weekly step leaderboard with fun nudges.
- Family challenges: 7-day step goal, water challenge, screen-free morning.

### 11.10 Emergency Health Card

- Stored **locally only** — no Appwrite sync, accessible without network.
- Fields: blood group · allergies · chronic conditions · current medications · emergency contact · doctor · insurance policy number.
- Accessible via Android lock screen widget and iOS Home Screen widget.
- Export: PDF for printing, QR code for quick scan by medical staff.

### 11.11 Festival Fitness Calendar & Wedding Planner — **EXPANDED**

> **Architecture principle**: Festival dates are never hardcoded as static strings. They are computed algorithmically for the current year (and ±2 years) at app install and refreshed annually via an Appwrite Function. Results are cached in the local `festival_calendar` Drift table — zero network dependency at runtime.

---

#### 11.11.1 Dynamic Festival Date Engine

Indian festivals span four calendar systems — Hindu lunisolar (Panchang), Islamic Hijri lunar, Sikh Nanakshahi, and Gregorian solar. Dates shift every year in the Gregorian calendar. The engine handles all four.

```dart
// lib/features/festival_calendar/domain/festival_date_engine.dart

/// Festival calendar systems
enum CalendarSystem {
  hinduLunisolar,   // Navratri, Diwali, Holi, Janmashtami, etc.
  islamicHijri,     // Ramadan, Eid-ul-Fitr, Eid-ul-Adha
  gregorianFixed,   // Christmas, New Year, Republic Day, Independence Day
  gregorianFloating,// Easter (computus algorithm)
  solarFixed,       // Makar Sankranti, Pongal (solar ingress — varies ±1 day)
  nanakshahi,       // Guru Nanak Jayanti, Baisakhi (Sikh calendar)
}

/// The engine pre-computes dates for [year-1, year, year+2]
/// and writes them to `festival_calendar` Drift table.
/// Called once at first launch; refreshed each 1 Jan via WorkManager.
class FestivalDateEngine {
  /// Hindu lunisolar computation uses Meeus astronomical algorithms
  /// for tithi (lunar day) and paksha (lunar fortnight) calculation.
  DateTime computeHinduFestival({
    required int year,
    required int lunarMonth,  // 1=Chaitra … 12=Phalguna
    required int tithi,       // 1–30 (lunar day)
    required bool krishnaPaksha, // dark fortnight vs shukla
  }) { /* Meeus tithi algorithm */ }

  /// Islamic date computation uses Umm al-Qura calendar algorithm
  DateTime computeIslamicFestival({
    required int year,
    required int hijriMonth,  // 1=Muharram … 12=Dhu al-Hijjah
    required int hijriDay,
  }) { /* Umm al-Qura algorithm */ }

  /// Gregorian fixed — just set month/day
  DateTime computeGregorianFixed(int year, int month, int day) =>
      DateTime(year, month, day);

  /// Easter — Anonymous Gregorian computus
  DateTime computeEaster(int year) { /* standard Easter algorithm */ }

  /// Solar ingress for Makar Sankranti (Sun enters Capricorn)
  /// Typically Jan 14–15; computed from VSOP87 solar longitude
  DateTime computeSolarIngress(int year, double targetLongitudeDeg) {
    /* VSOP87-lite approximation */ }
}
```

**Fallback**: If the algorithmic computation fails for any festival (edge case), the engine falls back to a pre-seeded static lookup table covering 2024–2030, stored as a JSON asset bundled with the app.

---

#### 11.11.2 Indian Festival Database — 30+ Festivals

All festivals include: name (English), name_hi (Hindi/Devanagari), region relevance, calendar system, fasting type, diet plan type, and associated workout modifications.

| # | Festival | Hindi Name | Region | Calendar | Fasting Type | Diet Plan |
|---|----------|-----------|--------|----------|-------------|-----------|
| 1 | **Navratri** (Chaitra & Sharadiya) | नवरात्रि | All India | Hindu Lunisolar | Sattvic / Phalahar | Navratri Vrat Diet |
| 2 | **Diwali** | दीवाली | All India | Hindu Lunisolar | None (feasting) | Mithai Calorie Tracker |
| 3 | **Holi** | होली | North/Central | Hindu Lunisolar | None (feasting) | Thandai & Gujiya Guide |
| 4 | **Dussehra / Vijayadashami** | दशहरा | All India | Hindu Lunisolar | Partial fast | Light feasting plan |
| 5 | **Janmashtami** | जन्माष्टमी | All India | Hindu Lunisolar | Full-day Nirjala / Phalahar | Krishna Vrat Diet |
| 6 | **Maha Shivaratri** | महाशिवरात्रि | All India | Hindu Lunisolar | Nirjala / Phalahar | Shivaratri Vrat Plan |
| 7 | **Ram Navami** | रामनवमी | North/Central | Hindu Lunisolar | Sattvic fast | Ram Navami Diet |
| 8 | **Hanuman Jayanti** | हनुमान जयंती | All India | Hindu Lunisolar | Partial (no non-veg) | Vegetarian plan |
| 9 | **Raksha Bandhan** | रक्षाबंधन | North/West | Hindu Lunisolar | None | Moderate indulgence plan |
| 10 | **Karva Chauth** | करवा चौथ | North India | Hindu Lunisolar | Nirjala (sunrise to moonrise) | Sargi pre-fast meal + break-fast plan |
| 11 | **Teej (Hariyali & Hartalika)** | तीज | North/Rajasthan | Hindu Lunisolar | Nirjala (for Hartalika) | Teej Vrat Diet |
| 12 | **Ganesh Chaturthi** | गणेश चतुर्थी | West/South | Hindu Lunisolar | Partial | Modak calorie tracker |
| 13 | **Durga Puja** | दुर्गा पूजा | East (Bengal) | Hindu Lunisolar | None (feasting) | Bengali festive meal guide |
| 14 | **Chhath Puja** | छठ पूजा | Bihar/UP/Jharkhand | Hindu Lunisolar | 36-hour Nirjala | Chhath Vrat Plan |
| 15 | **Makar Sankranti / Pongal** | मकर संक्रांति | All India | Solar | None | Tilgul & Pongal guide |
| 16 | **Ugadi / Gudi Padwa** | उगादि / गुड़ी पड़वा | South/Maharashtra | Hindu Lunisolar | None | Regional New Year diet |
| 17 | **Onam** | ओणम | Kerala | Solar (Malayalam) | None (feasting) | Sadhya calorie tracker |
| 18 | **Bihu (Bohag / Rongali)** | बिहू | Assam/Northeast | Solar | None (feasting) | Northeast festive diet |
| 19 | **Baisakhi / Vaisakhi** | बैसाखी | Punjab/Haryana | Nanakshahi | None | Harvest festive plan |
| 20 | **Lohri** | लोहड़ी | Punjab/Haryana | Gregorian Fixed (Jan 13) | None | Winter festive diet |
| 21 | **Guru Nanak Jayanti** | गुरु नानक जयंती | Punjab / all Sikh regions | Nanakshahi | Langar (community meal) | Langar-aligned plan |
| 22 | **Ramadan / Ramzan** | रमज़ान | Muslim communities | Islamic Hijri | Roza (dawn to dusk) | Sehri & Iftar Planner |
| 23 | **Eid-ul-Fitr** | ईद-उल-फ़ित्र | Muslim communities | Islamic Hijri | None (celebration) | Eid feast guide |
| 24 | **Eid-ul-Adha / Bakrid** | ईद-उल-अज़हा | Muslim communities | Islamic Hijri | None (feast) | Bakrid diet plan |
| 25 | **Christmas** | क्रिसमस | Christian communities | Gregorian Fixed (Dec 25) | None | Festive indulgence plan |
| 26 | **Good Friday / Easter** | गुड फ्राइडे | Christian communities | Gregorian Floating | Fasting (Good Friday) | Lenten diet guide |
| 27 | **Buddha Purnima** | बुद्ध पूर्णिमा | Buddhist communities | Hindu Lunisolar | Sattvic / vegetarian | Vegetarian plan |
| 28 | **Navroze (Parsi New Year)** | नवरोज़ | Parsi community | Zoroastrian (Shahenshahi) | None | Parsi festive diet |
| 29 | **Paryushana** | पर्यूषण | Jain community | Hindu Lunisolar | Jain Vrat (no root veg) | Jain Vrat Diet |
| 30 | **Maha Ashtami / Navami** | महा अष्टमी | East India | Hindu Lunisolar | Partial | Festival plan |
| 31 | **Republic Day** | गणतंत्र दिवस | All India | Gregorian Fixed (Jan 26) | None | Patriotic wellness challenge |
| 32 | **Independence Day** | स्वतंत्रता दिवस | All India | Gregorian Fixed (Aug 15) | None | National fitness challenge |

---

#### 11.11.3 Per-Festival Diet Plan System

Each festival entry contains a `diet_plan_type` that triggers a specialised diet configuration in the Meal Planner (Section 13.1).

```dart
// lib/features/festival_calendar/domain/festival_diet_plan.dart

enum FestivalDietType {
  nirjalaFast,        // No water: Karva Chauth, Hartalika Teej, Chhath
  phalaharFast,       // Fruits + milk only: Navratri light, Janmashtami
  sattvicFast,        // No onion/garlic/non-veg: Navratri, Ram Navami
  jainFast,           // No root veg + sattvic: Paryushana
  rozaFast,           // Ramadan: sehri/iftar window
  partialFast,        // Veg only or one meal: Dussehra, Ekadashi
  feastMode,          // Full indulgence tracking: Diwali, Holi, Onam
  moderateIndulgence, // Guided splurge: Eid, Christmas, Baisakhi
  communityMeal,      // Langar or sadhya pattern: Guru Nanak, Onam
  noRestriction,      // Standard plan with festive context: Republic Day
}

class FestivalDietConfig {
  final String festivalId;
  final FestivalDietType type;

  // Navratri-specific allowed foods
  final List<String>? allowedFoodIds;    // sabudana, singhara, kuttu, etc.
  final List<String>? forbiddenFoodIds;  // grains, onion, garlic, etc.

  // Ramadan-specific windows
  final TimeOfDay? sehriCutoffTime;
  final TimeOfDay? iftarTime;           // computed from location-based sunset

  // Fasting goal modifiers
  final double calorieBudgetMultiplier; // e.g. 0.75 for fasting days
  final bool suppressWorkoutIntensity;  // reduces workout suggestions
  final String? fastBreakSuggestion;   // e.g. "Date + warm water for Karva Chauth"
  final String insightCardMessage;      // shown in dashboard during festival
}
```

**Festival-specific diet highlights:**

- **Navratri (9 days)**: Allowed foods list (sabudana khichdi, kuttu atta, singhara atta, rajgira ladoo, fruits, milk, paneer, sendha namak). Forbidden: wheat, rice, pulses, onion, garlic, alcohol. Calorie target reduced by 15–20%. Garba calorie burn tracker active (Garba = ~300–400 kcal/hour).
- **Karva Chauth**: Sargi meal plan (pre-sunrise: seviyan, mathri, dry fruits). Nirjala fast tracked from sunrise. Moon-rise time computed from user's GPS location. Break-fast plan shown at moonrise: dates + water + sherbet.
- **Chhath Puja (36-hour Nirjala)**: Electrolyte warnings. High-micronutrient pre-fast meal. Gentle post-fast re-feeding plan.
- **Ramadan (30 days)**: Sehri nutritional plan (slow-digesting: oats, eggs, dal, dates). Iftar plan (hydration priority: dates, water, sherbet, then light meal). Iftar time auto-computed from user's GPS + sunset API (cached offline). Tarawih prayer (~4 MET, 1.5 hours) as a workout activity.
- **Diwali (5 days)**: Mithai calorie database (gulab jamun, kaju katli, ladoo, barfi, jalebi). Daily sweet-calorie budget. Healthy alternatives suggested (makhana, roasted nuts, dark chocolate).
- **Onam**: Kerala Sadhya calorie tracker — 26+ side dishes, rice-based. Feast mode with awareness.
- **Maha Shivaratri**: 24-hour fasting guide. Bael fruit, milk, and thandai (without bhang) suggestions.
- **Jain Paryushana**: No root vegetables (potato, carrot, beet, onion, garlic). Sattvic-only filtered food database. Ayambil (one meal) mode.
- **Ekadashi (twice monthly)**: Auto-detected from the Hindu calendar. Grain-free fasting plan for the two monthly Ekadashi tithis.

---

#### 11.11.4 `festival_calendar` Drift Table Schema — Updated

```dart
// lib/core/storage/tables/festival_calendar_table.dart

class FestivalCalendar extends Table {
  TextColumn get id         => text()();                        // e.g. 'navratri_2025_1'
  TextColumn get festivalKey => text()();                       // slug: 'navratri', 'diwali', 'ramadan'
  TextColumn get nameEn     => text()();
  TextColumn get nameHi     => text()();
  TextColumn get nameLocal  => text().nullable()();             // regional script
  IntColumn  get year       => integer()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate   => dateTime()();                 // multi-day festivals
  TextColumn get calendarSystem => text()();                    // enum serialised
  TextColumn get dietPlanType   => text()();                    // FestivalDietType
  TextColumn get regionCodes    => text()();                    // JSON: ['north','west']
  TextColumn get religion       => text()();                    // hindu/muslim/sikh/christian/jain/buddhist/parsi/national
  BoolColumn get isFastingDay   => boolean().withDefault(const Constant(false))();
  TextColumn get fastingType    => text().nullable()();         // nirjala/phalahar/sattvic/roza
  TextColumn get allowedFoods   => text().nullable()();         // JSON food ID list
  TextColumn get forbiddenFoods => text().nullable()();
  TextColumn get workoutNote    => text().nullable()();         // e.g. "Reduce intensity on fasting days"
  TextColumn get insightMessage => text()();                    // dashboard insight card text
  TextColumn get karmaChallenge => text().nullable()();         // e.g. "Navratri Steps Challenge"
  BoolColumn get computedDynamically => boolean().withDefault(const Constant(true))();
  DateTimeColumn get computedAt => dateTime()();                // for cache invalidation
  @override
  Set<Column> get primaryKey => {id};
}
```

---

#### 11.11.5 Annual Refresh — Appwrite Function

```javascript
// appwrite-functions/refresh-festival-dates/src/index.js
// Triggered: Every year on January 1st (00:05 IST) via Appwrite scheduled functions

import { FestivalDateCalculator } from './calculators/index.js';

export default async ({ req, res, log }) => {
  const currentYear = new Date().getFullYear();
  const yearsToCompute = [currentYear - 1, currentYear, currentYear + 1, currentYear + 2];
  const calculator = new FestivalDateCalculator();

  const festivals = [];
  for (const year of yearsToCompute) {
    festivals.push(...calculator.computeAllFestivals(year));
  }

  // Write to Appwrite `festival_calendar` collection
  // App syncs on next foreground launch → updates local Drift table
  await databases.createOrUpdateDocuments(
    process.env.DATABASE_ID, 'festival_calendar', festivals
  );

  log(`Refreshed ${festivals.length} festival date entries for years ${yearsToCompute}`);
  return res.json({ success: true, count: festivals.length });
};
```

---

#### 11.11.6 Seasonal Leaderboards (Festival-Tied Challenges)

- **Navratri Steps Challenge**: Track daily steps during 9-day Navratri. Garba bonus XP (+50 XP/session logged as Garba dance).
- **Ramadan Wellness Challenge**: Consistency of Sehri logs + hydration targets.
- **Holi Colour Run Challenge**: Steps on Holi day → Karma XP multiplier.
- **Diwali Mithai Budget Challenge**: Stay within daily sweet calorie budget for 5 days.
- **Onam Sadhya Smart Eating Challenge**: Log a full Sadhya and maintain calorie awareness.
- **Chhath Yoga & Mindfulness Challenge**: Breathing and meditation streak during Chhath.
- Festival challenges are gated by user's region setting — irrelevant festivals hidden.
- **NEW** `leaderboard_season` Appwrite collection scoped to festival date range.

---

### 11.12 Wedding Planner Module — **NEW**

> An Indian wedding is a multi-day, multi-event celebration. FitKarma's Wedding Planner provides role-based, phase-aware diet and fitness plans to help every participant — Bride, Groom, or Guest/Relative — look and feel their best across the entire wedding period.

#### 11.12.1 Onboarding — Wedding Setup Flow

Triggered when user taps **"Plan for a Wedding"** from the Festival & Events tab or during initial onboarding.

```
Step 1: What is your role in this wedding?
        [ 👰 Bride ]  [ 🤵 Groom ]  [ 🎉 Guest ]  [ 👨‍👩‍👧 Relative ]

Step 2: (If Relative selected) What is your relation?
        [ Father of Bride ]  [ Mother of Bride ]
        [ Father of Groom ]  [ Mother of Groom ]
        [ Sibling ]          [ Close Family ]

Step 3: What are the wedding dates?
        Wedding Date Range:
        📅 Start Date  [Date Picker]       (e.g., Mehendi/Haldi first day)
        📅 End Date    [Date Picker]       (e.g., Reception last day)
        ⚠ Minimum 1 day, maximum 14 days range allowed.

Step 4: Select the events happening (multi-select):
        ☐ Haldi Ceremony
        ☐ Mehendi Night
        ☐ Sangeet / Garba Night
        ☐ Baraat
        ☐ Main Wedding Ceremony (Vivah / Nikah / Anand Karaj)
        ☐ Reception / Walima

Step 5: How many weeks before the wedding are you starting to prepare?
        [ 1 week ]  [ 2 weeks ]  [ 4 weeks ]  [ 8 weeks ]  [ Already wedding week ]

Step 6: What is your primary wedding goal?
        (Role-aware options shown)
        Bride/Groom: [ Look my best (tone up) ] [ Feel energised ] [ Manage stress ]
        Guest/Relative: [ Manage indulgence ] [ Stay active ] [ Maintain routine ]
```

#### 11.12.2 Wedding Event Schema — Drift Table

```dart
// lib/core/storage/tables/wedding_events_table.dart

class WeddingEvents extends Table {
  TextColumn  get id          => text()();
  TextColumn  get userId      => text()();
  TextColumn  get role        => text()();    // bride/groom/guest/relative
  TextColumn  get relationType => text().nullable()(); // father_bride, mother_groom, sibling, etc.
  DateTimeColumn get weddingStartDate => dateTime()();
  DateTimeColumn get weddingEndDate   => dateTime()();
  IntColumn   get prepWeeks   => integer()();           // weeks of pre-wedding preparation
  TextColumn  get events      => text()();              // JSON: ['haldi','mehendi','sangeet','vivah','reception']
  TextColumn  get primaryGoal => text()();              // tone_up/energised/manage_stress/manage_indulgence
  TextColumn  get dietPhase   => text()();              // pre_wedding/wedding_week/post_wedding
  BoolColumn  get isActive    => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}
```

Also add to `users` table in Appwrite:

| Field | Type | Notes |
|---|---|---|
| `wedding_role` | enum | `bride` / `groom` / `guest` / `relative` / `none` |
| `wedding_relation_type` | string | nullable — `father_bride`, `mother_groom`, `sibling`, etc. |
| `wedding_start_date` | datetime | nullable |
| `wedding_end_date` | datetime | nullable |
| `wedding_prep_weeks` | integer | nullable |
| `wedding_events` | string | JSON list of selected events |
| `wedding_primary_goal` | enum | nullable |

#### 11.12.3 Role-Based Diet Plans

Diet plans are generated by the Rule Engine (Section 11.13) and are phase-aware: **Pre-Wedding**, **Wedding Week (per event day)**, and **Post-Wedding**.

---

**👰 Bride Plan**

| Phase | Diet Focus | Calorie Strategy | Key Foods | Avoid |
|-------|-----------|-----------------|-----------|-------|
| Pre-Wedding (8–4 weeks) | Lean body composition, skin glow | Slight deficit (−200 kcal) | Dal, paneer, eggs, sprouts, haldi milk, amla, cucumber | Processed sugar, excess salt, fried food |
| Pre-Wedding (3–1 weeks) | Sustained energy, reduce bloat | Maintenance calories | Sattvic foods, moong dal, light sabzi, coconut water | Cruciferous veg (bloating risk), heavy pulses, alcohol |
| Mehendi Day | High energy for long sitting sessions | Maintenance + light snacks | Fruits, dry fruits, coconut water, small frequent meals | Heavy lunch (fatigue risk) |
| Haldi Day | Anti-inflammatory boost | Maintenance | Haldi milk, amla, papaya, light khichdi | Spicy food |
| Sangeet / Garba Night | Energy for dancing (3–4 hours) | +200 kcal (dance burn) | Pre-event: banana, dates, curd rice. Post-event: protein shake | Heavy dinner before dancing |
| Wedding Day | Sustained energy, no bloating | Maintenance, 5–6 small meals | Idli, poha, curd, fruits. Avoid skipping meals (Bride often forgets to eat!) | Skipping meals, carbonated drinks, gas-causing foods |
| Reception | Celebration with awareness | Maintenance + 150 kcal flex | Enjoy freely but log. Prioritise protein first on buffet plate | Nothing strictly — enjoy mindfully |
| Post-Wedding (1–2 weeks) | Recovery, de-stress | Return to baseline | Anti-inflammatory: turmeric, ginger, berries, dal. Hydration focus | Crash dieting |

---

**🤵 Groom Plan**

| Phase | Diet Focus | Calorie Strategy | Key Foods | Notes |
|-------|-----------|-----------------|-----------|-------|
| Pre-Wedding (8–4 weeks) | Lean muscle, jawline definition | Slight deficit (−250 kcal) + resistance training | Chicken, paneer, eggs, dal, brown rice, oats | Alcohol reduction (impacts skin + sleep) |
| Pre-Wedding (3–1 weeks) | Maintain muscle, energy boost | Maintenance + carb loading last 3 days | Complex carbs + protein balance | Hydration: 3L+/day |
| Baraat Day | High endurance (Baraat procession, dancing 2–3 hours) | +300 kcal for energy | Pre-baraat: banana, peanut butter toast. During: coconut water | Avoid heavy meal 2 hours before Baraat |
| Wedding Day | Alert, energised | Maintenance | Light breakfast. Dates + nuts during ceremony. Protein-rich lunch | Avoid alcohol before ceremony |
| Reception | Celebration | +200 kcal flex | Enjoy freely. Hydrate between alcohol drinks (if consuming) | 1 glass water per drink rule |
| Post-Wedding | Recovery, honeymoon prep | Return to baseline or mild deficit | Back to normal wholesome routine | Resume workout routine Day 2 after wedding |

---

**🎉 Guest Plan**

| Phase | Diet Focus | Strategy | Key Tips |
|-------|-----------|----------|----------|
| Pre-event (1 week) | Light clean eating | Slight deficit to create buffer | Cut processed food, increase fibre |
| Event Days | Mindful indulgence | Maintenance + 200 kcal flex/day | Protein-first buffet strategy: Fill half plate with dal/meat/paneer before sweets |
| Post-event | Reset | Return to normal within 2 days | Light detox: moong dal khichdi, coconut water, fruit |

**Guest buffet strategy card** (shown as InsightCard during wedding period):
> *"At a wedding buffet? Eat protein and vegetables first — dal makhani, tandoori paneer, salad. Save sweets for last. This reduces your total calorie intake by ~20% without feeling deprived."*

---

**👨‍👩‍👧 Relative Plans**

Role-specific plans for high-effort relatives:

| Relation | Specific Challenge | Diet Note |
|----------|-------------------|-----------|
| Mother of Bride/Groom | High stress, running around for days | Stress-nutrition plan: magnesium-rich foods, chamomile tea, small frequent meals |
| Father of Bride/Groom | Long standing, receiving guests | Joint-friendly foods: anti-inflammatory diet, comfortable snacking |
| Sibling | Active participation in all events | Stamina plan: complex carbs + protein each event day |
| Close Family | Multiple events, travel | Travel-friendly snack suggestions, hydration reminders |

#### 11.12.4 Wedding Dashboard Widgets

When a wedding is active (within `weddingStartDate – weddingEndDate`), the Dashboard shows:

```
┌─────────────────────────────────────────────────┐
│  💍 Wedding Countdown                           │
│  3 days to Vivah  ·  Sangeet tomorrow           │
│  Role: Bride  ·  Phase: Wedding Week            │
│                                                 │
│  Today's Wedding Diet Plan:                     │
│  Pre-Sangeet: Banana + Dates (4 PM snack)       │
│  Dinner: Light — Curd Rice + Dal                │
│                                                 │
│  [View Full Plan]  [Log Today's Meals]          │
└─────────────────────────────────────────────────┘
```

- Widget colour: Gold gradient (`#D4A017` → `#B8860B`) overlaid on the standard hero.
- Replaces the standard Insight Card during the active wedding period.
- **Countdown** shows days to the next wedding event, not just the main day.
- **Event-day alerts**: Push notification morning of each event with diet tip and energy plan.

#### 11.12.5 Pre-Wedding Fitness Plan

Generated by the Rule Engine based on role, prep weeks, and primary goal:

| Weeks Before | Bride / Groom Focus | Weekly Workout Structure |
|-------------|--------------------|-----------------------------|
| 8–6 weeks | Body composition | 4× strength + 2× cardio + 1× yoga/rest |
| 5–4 weeks | Toning & definition | 3× HIIT + 2× strength + 2× yoga |
| 3–2 weeks | Energy + endurance | 3× moderate cardio + 2× yoga + 2× rest |
| 1 week | Gentle maintenance | Daily 20-min walks + 2× yoga (NO new exercises) |
| Wedding week | Restorative | Yoga + breathing only — avoid soreness |

- **Guest/Relative**: Simplified plan — daily step goal (8,000) + 10-min Yoga for stress management.
- All plans generated on-device — zero server calls.
- **Karma bonus**: +100 XP for completing a "Wedding Prep" 7-day streak.

#### 11.12.6 Post-Wedding Recovery Plan

Automatically activates the day after `weddingEndDate`.

- 3-day **detox plan**: Moong dal khichdi, coconut water, fruits, light sabzi.
- Gradual calorie return to baseline over 5 days (prevents rebound bingeing).
- Celebratory Insight Card: *"You made it! 🎊 Time to restore and recharge. Your 3-day post-wedding reset starts today."*
- Workout: Walking + gentle yoga for 1 week before resuming full intensity.

#### 11.12.7 Wedding + Festival Overlap Handling

If a wedding date overlaps with an active festival (e.g., Diwali wedding, Navratri reception):

```dart
// Priority rules:
// 1. Wedding role-based plan takes precedence for calorie targets
// 2. Festival fasting rules still shown as optional modifier
// 3. Insight card merges both contexts:
//    "Diwali wedding — enjoy the mithai, but log them! 
//     Your bride plan has a +200 kcal flex today. 🪔💍"
// 3. Allowed food list = union(weddingAllowed, festivalAllowed)
```

### 11.13 Low Data Mode (2G / 3G Support)

- Toggle in Settings — can also be auto-detected by connection speed.
- When active: images disabled, sync reduced to 6 hours, social feed text-only, no video thumbnails.
- A persistent teal "Low Data Mode" banner at the top of the app.

### 11.14 On-Device AI Health Insight Engine (Modular)

All rules run in Dart on the device. Zero server calls. Modular architecture — rules are separate from the evaluator.

```
lib/features/insight_engine/
├── engine/
│   ├── rule_evaluator.dart     # Queries Drift, evaluates all loaded rules
│   └── insight_scheduler.dart  # Runs daily, max 2 cards surfaced
├── rules/
│   ├── nutrition_rules.dart
│   ├── sleep_rules.dart
│   ├── bp_rules.dart
│   ├── glucose_rules.dart
│   ├── mood_rules.dart
│   ├── fasting_rules.dart
│   ├── correlation_rules.dart  # Cross-module insights (NEW)
│   └── server_rules.dart       # RemoteConfig-delivered rules (NEW)
└── models/
    ├── insight_rule.dart        # abstract class: condition(), message(), priority()
    └── insight_output.dart
```

**Cross-module correlation rules (NEW):**
```dart
// examples of correlation-based insights
if (sleepAvg7d < 6 && moodAvg7d < 3)
    → "Your mood drops on poor sleep nights — consistent pattern over 8 days",

if (workoutDay && proteinToday < goalProtein * 0.6)
    → "You under-eat protein by 40g on workout days — add paneer or eggs post-workout",

if (fastingDay && bpReading < bpAvg - 8)
    → "Your systolic BP is ~8 mmHg lower on fasting days — consistent trend",

if (festivalWeek && calorieAvg7d > tdee + 500)
    → "You consumed 600 more kcal during Diwali week — here's a 3-day reset plan",

if (postMealGlucoseHigh3Days && stepCountPostMeal < 2000)
    → "A 20-min walk after lunch may help normalize your post-meal glucose",
```

- Server-delivered rule updates via `RemoteConfig` — no app update required. **NEW**
- Each card is dismissable. User thumbs rating stored in Drift to suppress unhelpful rules.

---

## 12. Health Monitoring Modules

### 12.1 Blood Pressure & Heart Rate Tracker

- **Manual logging**: systolic, diastolic, pulse — takes < 20 seconds.
- **Wearable auto-sync**: pulls from Health Connect / HealthKit / Fitbit / Garmin.
- **Lab report import**: Auto-populated from `LabReportOcrService` when BP values detected. **NEW**
- **AHA classification**: Normal / Elevated / Stage 1 / Stage 2 / Hypertensive Crisis.
- **Trend chart**: 7 / 30 / 90-day history with coloured reference bands.
- **Emergency alert**: Reading exceeds 180/120 mmHg → immediate care prompt.
- **Karma**: +5 XP per BP log. AES-256-GCM encrypted (Drift, HKDF key: bp).

```dart
// lib/features/blood_pressure/domain/bp_classifier.dart
enum BPClassification { normal, elevated, stage1, stage2, crisis }

BPClassification classify(int systolic, int diastolic) {
  if (systolic >= 180 || diastolic >= 120) return BPClassification.crisis;
  if (systolic >= 140 || diastolic >= 90)  return BPClassification.stage2;
  if (systolic >= 130 || diastolic >= 80)  return BPClassification.stage1;
  if (systolic >= 120 && diastolic < 80)   return BPClassification.elevated;
  return BPClassification.normal;
}
```

### 12.2 Blood Glucose Tracker

- **Reading types**: Fasting / Post-meal (1h, 2h) / Random / Bedtime.
- **Reference ranges**: Normal / Pre-diabetic / Diabetic per WHO/IDF standards.
- **HbA1c estimator**: 90-day average glucose → estimated A1c percentage.
- **Meal correlation**: Links post-meal glucose to the corresponding food log entry.
- **Lab report import**: Fasting glucose and HbA1c auto-imported from `LabReportOcrService`. **NEW**
- **Karma**: +5 XP per glucose log. AES-256-GCM encrypted (Drift, HKDF key: glucose).

### 12.3 SpO2 / Oxygen Saturation Tracker

- Manual logging: SpO2 % + pulse rate.
- Wearable sync: Health Connect / HealthKit / supported wearables.
- Alert: SpO2 < 95% triggers a consult-your-doctor nudge (high post-COVID relevance).

### 12.4 Lab Report OCR — NEW

A dedicated module for scanning printed or PDF lab reports (from Dr Lal PathLabs, SRL, Apollo Diagnostics, etc.) and auto-importing key health metrics.

```
Flow:
1. User taps "📋 Lab/Rx Scan" on the food screen or in the Lab Reports module
2. `LabReportOcrService` calls Google ML Kit TextRecognitionV2 on the photo/PDF
3. Extracted text passed to an on-device regex + keyword engine:
   - Looks for: glucose, HbA1c, hemoglobin, BP, cholesterol, vitamin D, B12, TSH, creatinine
4. Results shown as editable key-value pairs — user must confirm before import
5. Confirmed values auto-populate: glucose_logs, blood_pressure_logs, and nutrition deficiency flags
6. Raw OCR text stored locally only (privacy opt-in to retain)
7. Karma: +30 XP per confirmed import
```

```dart
// lib/features/lab_reports/data/lab_report_ocr_service.dart
class LabReportOcrService {
  final TextRecognizer _recognizer = GoogleMlKit.vision.textRecognizer();

  Future<LabReportExtraction> extractFromImage(InputImage image) async {
    final recognized = await _recognizer.processImage(image);
    return LabReportParser().parse(recognized.text);
  }
}

class LabReportParser {
  static final _glucosePattern = RegExp(r'glucose[^\d]*([\d.]+)', caseSensitive: false);
  static final _hba1cPattern   = RegExp(r'hba1c[^\d]*([\d.]+)', caseSensitive: false);
  static final _hemoglobinPattern = RegExp(r'h(?:a)?emoglobin[^\d]*([\d.]+)', caseSensitive: false);
  // ... other markers

  LabReportExtraction parse(String text) {
    return LabReportExtraction(
      glucoseFasting: _extractDouble(text, _glucosePattern),
      hba1c: _extractDouble(text, _hba1cPattern),
      hemoglobin: _extractDouble(text, _hemoglobinPattern),
      // ...
    );
  }
}
```

### 12.5 ABHA Integration — NEW

Ayushman Bharat Health Account (ABHA) is India's national digital health ID. FitKarma supports linking so users can pull verified health records.

```
Integration points:
- Onboarding: optional ABHA linking step
- Settings → Health Permissions → Link ABHA
- After linking: pull historical BP, glucose, lab values, vaccination records

Implementation via Appwrite Function (Node.js):
- ABDM (Ayushman Bharat Digital Mission) Sandbox API
- OAuth2 token exchange server-side (never expose in Flutter)
- Pulled records auto-populate relevant modules with source: 'abha'
```

### 12.6 Chronic Disease Management

Supported conditions: Diabetes Type 1 & 2 · Hypertension · PCOD/PCOS · Hypothyroidism · Asthma.

| Mode           | Modules Surfaced                                                           |
|----------------|----------------------------------------------------------------------------|
| Diabetes       | Glucose tracker + Lab OCR import + Carb-aware nutrition + Medication + BP  |
| PCOD/PCOS      | Irregular cycle support + Hormone-friendly workouts + Weight management    |
| Hypertension   | BP tracker + Sodium tracking + Stress management + Medication compliance   |
| Hypothyroidism | Weight trend + TSH lab import + Fatigue tracking + Medication reminders    |
| Asthma         | SpO2 tracker + Activity intensity limits + Medication reminders            |

### 12.7 Doctor Appointments & Shareable Health Reports — NEW

- Track upcoming doctor appointments with 24h reminder.
- Doctor notes AES-256-GCM encrypted; prescription photos stored locally only.
- **Shareable Report Link**: Generate a time-limited (7-day), read-only health summary URL to share with a doctor via WhatsApp. **NEW**

```
Shareable Report Flow:
1. User taps "Share with Doctor" on the Reports screen
2. PDF generated locally (existing flow)
3. PDF uploaded to Appwrite Storage bucket `health_reports_share`
4. Appwrite Function generates a pre-signed URL with 7-day expiry
5. URL written to health_reports.share_url — user shares via WhatsApp
6. Doctor opens the URL — sees: 30-day BP trend, glucose log, weight, key labs
7. No login required for the doctor
8. File auto-deleted from Storage after expiry
```

---

## 13. Lifestyle & Wellness Modules

### 13.1 Meal Planner

- **Weekly meal planner**: Plan breakfast, lunch, dinner, and snacks for 7 days.
- **AI-suggested plans**: Rule Engine generates a plan based on TDEE, dosha type, and micronutrient gaps — zero server calls.
- **One-tap log**: Log a planned meal directly from the planner.
- **Indian meal templates**: North Indian, South Indian, Bengali, Gujarati, and regional variants.
- **Festival-aware (30+ festivals)**: Planner auto-detects active festivals from `festival_calendar` Drift table and applies the appropriate `FestivalDietConfig`. Allowed/forbidden foods filter the food search. Calorie targets adjusted per fasting type. See Section 11.11 for the full festival diet system. Key integrations: Navratri phalahar template, Ramadan Sehri/Iftar blocks, Karva Chauth Sargi + break-fast plan, Diwali mithai flex budget, Onam Sadhya tracker.
- **Wedding-aware**: When an active wedding event is detected (Section 11.12), the Meal Planner switches to the user's role-based wedding diet phase (pre-wedding / wedding week / post-wedding). Event-day meal templates surface automatically — e.g. pre-Sangeet energy meal, wedding-day no-bloat plan. Wedding and festival plans merge gracefully when dates overlap.
- **Grocery list**: Auto-generates a shopping list from the week's meal plan with Swiggy/Blinkit deep-links. **NEW**

### 13.2 Recipe Builder

- **Create custom recipes**: Add ingredients from `food_items`, set quantities and servings.
- **Auto-calculates**: Total calories, protein, carbs, fat, **and micronutrients** per serving. **NEW**
- **Save → log**: Log the entire recipe as one food entry in one tap.
- **Community sharing**: Mark recipe as public.
- **Indian cuisine classifier**: Tag by regional cuisine for discoverability.

### 13.3 Intermittent Fasting Tracker

- **Supported protocols**: 16:8 · 18:6 · 5:2 · OMAD · Custom window.
- **Fasting timer**: Countdown to eating window with stage progress ring.
- **Ramadan mode**: Sehri/Iftar as the fasting boundary.
- **Hydration alerts** during fasting windows.
- **Streak tracking**: Consecutive successful fasting days.
- **Karma**: +15 XP per completed fast.

```dart
// lib/features/fasting_tracker/domain/fasting_stage.dart
enum FastingStage { fed, earlyFast, fatBurning, ketosis, deepFast }

FastingStage getStage(Duration elapsed) {
  final hours = elapsed.inHours;
  if (hours < 4)  return FastingStage.fed;
  if (hours < 8)  return FastingStage.earlyFast;
  if (hours < 12) return FastingStage.fatBurning;
  if (hours < 16) return FastingStage.ketosis;
  return FastingStage.deepFast;
}
```

### 13.4 Guided Meditation & Pranayama

- Guided sessions: 5 / 10 / 15 / 20-minute sessions with bundled offline audio.
- Pranayama library: Anulom Vilom · Bhramari · Kapalbhati · Bhastrika — timer-based.
- Dosha-specific sessions: calming for vata, cooling for pitta, energising for kapha.
- Stress mode: Quick 3-minute breathing exercise triggered when `stress_level > 7`.
- **Karma**: +5 XP per meditation session; +10 XP for a 7-day streak.

### 13.5 Journaling

- **Daily journal entries** with rich text via `flutter_quill`.
- **Optional mood score and tags** per entry.
- **AES-256-GCM encrypted** (Drift, HKDF key: journal) — local only by default.
- **On-device sentiment analysis**: After 30+ entries, detects mood trajectory from tag frequency and mood scores. Privacy-preserving — no text is sent anywhere. **NEW**
- **Weekly prompt suggestions** based on logged data (e.g. *"You logged 'anxious' 4 times this week — what was the common trigger?"*). **NEW**
- **Monthly journal summary**: Mood trend overlay with tag word cloud.

### 13.6 Mental Health & Stress Management

- **Stress management programs**: 7-day CBT-lite techniques, progressive muscle relaxation.
- **CBT-based prompts tied to real logged data** (not generic): e.g. *"On days you slept < 6h you logged 'irritable' — sleep may be a key lever."* **NEW**
- **Burnout detection**: Sustained low mood + poor sleep + low energy over 7 days → recovery flow.
- **Professional help prompts**: Triggered gently after 14 days of consistently low mood scores.
- **Mental health resources**: iCall, Vandrevala Foundation, NIMHANS helplines.

### 13.7 Personal Records Tracker

- **Auto-detection**: Detects new PRs from workout logs — max lift, fastest 5K, longest run.
- **Manual PR entry** for sports: cricket runs, kabaddi raid points, etc.
- **PR celebration notification**: *"New PR! You lifted 80kg on Bench Press!"*
- **PR history chart** per exercise with trend over time.
- **Karma**: +100 XP for any new personal record.

---

## 14. Social & Community Modules

### 14.1 Social Feed

- Post workouts, meals, and milestones with optional media.
- Like, comment, and share within the FitKarma community.
- Verified nutritionist / trainer badge on professional accounts.
- Follow system: follow users; see their public activity in the main feed.
- **Social Karma**: +5 XP for receiving likes or posting a helpful comment in a support group. **NEW**

### 14.2 Community Groups

- **Create or join** topic-based groups: Keto Indians · Mumbai Runners · Diabetics Support.
- **Group types**: diet / location / sport / challenge / support.
- **Group challenges**: Admin-created challenges with shared group leaderboard.
- **Team vs. Team challenges**: Two groups compete on a shared metric (steps, workouts). **NEW**
- **Region vs. Region**: City-level leaderboard challenges (e.g. *Mumbai vs Delhi 7-day steps*). **NEW**
- **Direct messaging (DMs)**: One-to-one messaging within community connections.

### 14.3 Referral & Invite Program

- Each user receives a unique referral code at registration.
- **Referrer earns** +500 Karma XP when the referred user completes onboarding.
- **Referred user earns** +100 Karma XP on signup.
- **Share via**: WhatsApp · Instagram · Copy link (WhatsApp is the primary CTA). **NEW**
- **Referral leaderboard** in Karma Hub — top referrers earn exclusive badge rewards.

### 14.4 WhatsApp Logging Companion — NEW

India is a WhatsApp-first country. A WhatsApp Business bot allows users to log food and check stats without opening the app.

```
Implementation:
- Appwrite Function (Node.js) handles WhatsApp Cloud API webhooks
- User sends: "dal rice 2 katori" → bot calls FitKarma food NLP parser
  → replies: "Logged! Dal Rice 2 katori = ~480 kcal. Daily total: 1,240 / 2,000 kcal 🍽"
- User sends: "log mood 4" → bot logs mood score 4
- User sends: "today stats" → bot replies with ring summary
- All logs written to Drift via a minimal background Appwrite Function
- log_method tagged as 'whatsapp' in food_logs
- Privacy: opt-in, phone number linked to account only with explicit user consent
```

### 14.5 Community & Gamification V2

- **Expanded Achievement System**: 100+ achievement badges for specific milestones: *"Logged 100 workouts"*, *"30-day streak"*, *"Lab Report Hero"*, *"ABHA Pioneer"*. **NEW**
- **Real-World Rewards**: Karma Store partnerships with fitness brands for product discounts. **NEW**
- **Targeted Leaderboards**: *"Most Consistent Yogi"* · *"Top Stepper in Mumbai"* · *"Navratri Champion"*. **NEW**

---

## 15. Platform & Infrastructure Modules

### 15.1 Automated Health Reports

- **Weekly and monthly reports** auto-generated every Sunday night / month end.
- **Report contents**: Steps trend · Calorie balance · Sleep quality · Mood trend · BP/Glucose (if tracked) · Workout frequency · Karma earned · **Micronutrient gaps** (NEW).
- **PDF generated locally** using the `pdf` package — never uploaded automatically.
- **Shareable doctor link**: Optional upload to Appwrite Storage with a 7-day time-limited URL for WhatsApp sharing with a doctor. **NEW** (see Section 12.7)

### 15.2 Wearable Device Integration

| Device / Platform            | Data Pulled                         | Method                         |
|------------------------------|-------------------------------------|---------------------------------|
| Health Connect (Android 14+) | Steps, sleep, HR, SpO2, BP         | `health` package                |
| HealthKit (iOS)              | Steps, sleep, HR, SpO2, BP          | `health` package                |
| Fitbit                       | Steps, sleep, HR, SpO2              | Fitbit Web API via OAuth2       |
| Garmin                       | Steps, sleep, HR, GPS workouts      | Garmin Connect IQ API           |
| Mi Band / Xiaomi             | Steps, sleep, HR                    | Health Connect bridge           |
| boAt (Wear OS)               | Steps, HR                           | Health Connect bridge           |

- All wearable data is supplementary; device sensor data takes priority.
- Wearable sync runs on app resume and every 15 minutes in background (6 hours in Low Data Mode).

#### Wear OS Companion App (Android Watch)

A standalone Wear OS tile + watch face bridged to the phone app via the Wearable Data Layer API.

| Surface              | Content                                                             |
|----------------------|---------------------------------------------------------------------|
| Watch face complication | Current step ring progress + heart rate zone badge              |
| Tile — Activity      | Step ring, calories ring, water counter — tap to open phone app     |
| Tile — Water         | Tap `+1 glass` → writes to Wear DataMap → phone app syncs to Drift |
| Tile — Workout       | Start / stop GPS workout; live HR zone display                      |

- Wear OS app communicates with the phone via `ChannelClient` for workout events and `DataClient` for background stat updates.
- Water increment messages are idempotent (debounced at 5-second intervals to avoid double-counts).

#### watchOS Companion App (Apple Watch)

A watchOS Extension bridged via `WatchConnectivity` framework.

| Surface              | Content                                                             |
|----------------------|---------------------------------------------------------------------|
| Complication         | Step ring progress (Circular Small / Modular Small variants)        |
| Widget — Water       | Tap to log +1 glass; synced to phone via `WCSession.sendMessage`   |
| Widget — Workout     | Start / stop workout with live HR zone from HealthKit               |

- watchOS app uses `WCSession.transferUserInfo` for background stat push and `sendMessage` for real-time workout events.
- All watch data ultimately writes to Drift on the phone — the watch is a capture surface only.

### 15.3 Android & iOS Home Screen Widgets — NEW

Using the `home_widget` Flutter package:

| Widget               | Size     | Content                                       |
|----------------------|----------|-----------------------------------------------|
| Activity Rings       | 4×1      | Steps, calories, water, active minutes rings  |
| Quick Log            | 2×1      | Button that deep-links to food log sheet      |
| Water Counter        | 2×2      | Tap to increment water; shows today's total   |
| Emergency Card       | Lock screen | Blood group + emergency contact (iOS/Android) |

- Widgets update via WorkManager background task (Android) or WidgetKit timeline (iOS).
- Widget data read from Drift — never makes network requests.

### 15.4 Remote Configuration System — NEW

A first-class `RemoteConfig` layer backed by an Appwrite `remote_config` collection.

```dart
// lib/core/config/remote_config.dart
@riverpod
class RemoteConfig extends _$RemoteConfig {
  @override
  Future<RemoteConfigData> build() async {
    // Load from Drift cache first (immediate), then refresh from Appwrite in background
    final cached = await ref.read(driftServiceProvider).getRemoteConfig();
    _refreshInBackground();
    return cached ?? RemoteConfigData.defaults();
  }

  void _refreshInBackground() async {
    final fresh = await AppwriteClient.databases.listDocuments(
      databaseId: AW.dbId,
      collectionId: AW.remoteConfig,
    );
    // Save to Drift cache, invalidate provider
  }
}

// Config schema:
// { "feature.abha_module": true }               → feature toggle
// { "insight.ml_model_enabled": false }         → ML upgrade flag
// { "ab.new_dashboard": { "rollout_pct": 20 }} → A/B test
// { "kill.whatsapp_bot": false }                → emergency kill-switch
// { "insight.server_rules": [...] }             → server-delivered insight rules
```

---

## 16. Security & Privacy

### 16.1 Session Management

| Property          | Detail                                                                |
|-------------------|-----------------------------------------------------------------------|
| Sessions          | Appwrite JWT — stored in `flutter_secure_storage`                    |
| Renewal           | `account.updateSession(sessionId: 'current')` before expiry          |
| OAuth2            | Handled by Appwrite — no Firebase Auth SDK in app                    |
| Biometric lock    | `local_auth` guards app re-open                                       |
| Root detection    | `flutter_jailbreak_detection` — warn user, do not block              |
| Certificate pinning | SHA-256 fingerprint check on Appwrite domain — **NEW**              |
| Doc permissions   | `Permission.read(Role.user(uid))` + `Permission.write(Role.user(uid))`|

### 16.2 Data Encryption — HKDF Per Data Class

> **Architecture change from v1.0**: Keys are now derived per data class using HKDF. They are NOT tied to the user's password. This means password changes do not affect encrypted data, and OAuth-only users can have encrypted data.

```dart
// lib/core/security/key_manager.dart

class KeyManager {
  // Master key is derived from device identity — never from user password
  static Future<Uint8List> _getMasterKey() async {
    var storedKey = await FlutterSecureStorage().read(key: 'master_key');
    if (storedKey == null) {
      // First run: derive from device_id + app_install_uuid + stored_salt
      final deviceId    = await DeviceInfo.getDeviceId();
      final installUuid = await getInstallUuid();  // persisted in secure storage
      final salt        = _generateAndStoreSalt();
      final masterKey   = await PBKDF2.derive(
        input:      '$deviceId:$installUuid',
        salt:       salt,
        iterations: 200_000,       // Doubled from v1.0 for stronger protection
        keyLength:  32,
      );
      await FlutterSecureStorage().write(
        key: 'master_key', value: base64.encode(masterKey),
      );
      return masterKey;
    }
    return base64.decode(storedKey);
  }

  // Per-class key derivation via HKDF
  // Each sensitive data type gets a cryptographically independent key
  static Future<Uint8List> getKeyFor(String dataClass) async {
    final masterKey = await _getMasterKey();
    return HKDF.expand(
      prk:    masterKey,
      info:   utf8.encode(dataClass),  // 'bp', 'glucose', 'period', 'journal', 'appt'
      length: 32,
    );
  }
}

// Usage:
// final bpKey     = await KeyManager.getKeyFor('bp_glucose');
// final periodKey = await KeyManager.getKeyFor('period');
// final journalKey= await KeyManager.getKeyFor('journal');
// Each key is independent — compromise of one does not affect others
```



### 16.3 Encryption Implementation — Drift

All sensitive fields are handled through the `EncryptionService` and stored in designated tables within the Drift database. The `AppDatabase` constructor (defined in Section 7.2) accepts the master key and passes it directly to SQLCipher via the `_openConnection` factory, so the encryption layer is transparent to all DAOs.

```dart
// lib/core/storage/drift_service.dart

class DriftService {
  static AppDatabase? _db;

  static AppDatabase get db {
    assert(_db != null, 'DriftService.init() must be called before accessing db');
    return _db!;
  }

  static Future<void> init() async {
    // Derive master key (device-anchored, not password-coupled — see KeyManager)
    final masterKey = await KeyManager.getMasterKey();
    final keyB64 = base64.encode(masterKey);

    // Open the SQLCipher-encrypted database
    _db = AppDatabase(keyB64);

    // Pre-warm the connection so the first UI query is instant
    await _db!.customSelect('SELECT 1').get();
  }
}

// Usage in main.dart:
// await DriftService.init();
// runApp(ProviderScope(
//   overrides: [driftDbProvider.overrideWithValue(DriftService.db)],
//   child: const FitKarmaApp(),
// ));
```

> **Field-level encryption**: Even though SQLCipher already encrypts the full database, sensitive columns (BP values, glucose readings, period cycle dates, journal text, doctor notes) receive an additional AES-256-GCM layer via `EncryptionService` before being written to Drift companions. This provides defence-in-depth: if the SQLCipher key is somehow recovered, individual field values remain ciphertext.

### 16.4 Appwrite Collection Permissions Template

```
// Apply to every collection in the Appwrite Console:
// Create:  role:users                — any authenticated user may create
// Read:    role:user:{userId}        — owner only
// Update:  role:user:{userId}        — owner only
// Delete:  role:user:{userId}        — owner only

// Absolute rule for sensitive collections:
// period_logs, journal_entries, blood_pressure_logs,
// glucose_logs, doctor_appointments:
//   → NO server-side admin read access — ever
//   → Even Appwrite Console shows encrypted bytes only
```

### 16.5 Privacy Commitments

| Data Type                          | Behaviour                                                            |
|------------------------------------|----------------------------------------------------------------------|
| Period / medical                   | AES-256-GCM encrypted in Drift; sync is opt-in only                 |
| Progress photos                    | Stored locally only — never uploaded to Appwrite Storage             |
| Voice notes                        | Stored locally only — auto-deleted after 30 days                     |
| Journal entries                    | AES-256-GCM encrypted in Drift; local-only by default               |
| BP / Glucose / SpO2 logs           | AES-256-GCM encrypted in Drift; user controls sync                  |
| Prescription photos                | Local only — never uploaded under any circumstance                   |
| Lab report raw OCR text            | Stored locally only — opt-in to retain after import                  |
| Lab report confirmed values        | Stored in Drift (sensitive fields encrypted); synced to Appwrite     |
| Doctor notes                       | AES-256-GCM encrypted in Drift; local only by default               |
| Emergency card                     | Stored locally in Drift only — no Appwrite sync, ever               |
| ABHA token                         | `flutter_secure_storage` only — never in Drift or plaintext          |
| ABHA linked record metadata        | Encrypted Drift (`abha_links` table); `abha_links` Appwrite collection |
| WhatsApp bot                       | Opt-in linking; phone number used only for account association        |
| User data (GDPR)                   | Full JSON export + account deletion via `account.delete()`            |
| Advertising                        | No advertising SDKs — zero ad revenue from user data                 |
| Third parties                      | No data sold or shared with any third party                           |
| Self-hosted option                 | Data stays on your own server when using Docker deployment            |

---

## 17. External API Integrations

### 17.1 Appwrite SDK — Common Operations

```dart
// Authentication
await AppwriteClient.account.createEmailPasswordSession(email: email, password: password);

// Create document with idempotency header
await AppwriteClient.databases.createDocument(
  databaseId: AW.dbId,
  collectionId: AW.foodLogs,
  documentId: ID.unique(),
  data: {
    ...foodLog.toAppwrite(),
    'idempotency_key': foodLog.idempotencyKey,  // NEW
  },
  permissions: [
    Permission.read(Role.user(uid)),
    Permission.write(Role.user(uid)),
  ],
);

// Delta sync with composite index (NEW — must have index configured)
await AppwriteClient.databases.listDocuments(
  databaseId: AW.dbId,
  collectionId: AW.stepLogs,
  queries: [
    Query.equal('user_id', uid),
    Query.greaterThan('\$updatedAt', lastSyncTimestamp),
    Query.orderDesc('\$updatedAt'),
    Query.limit(100),
  ],
);
```

### 17.2 Open Food Facts

| Property    | Value                                                               |
|-------------|---------------------------------------------------------------------|
| Endpoint    | `https://world.openfoodfacts.org/api/v2/product/{barcode}.json`    |
| Method      | `GET`                                                               |
| Parse target| `product.nutriments` — calories, protein, carbohydrates, fat, **vitamins** |
| Fallback    | Prompt manual entry if barcode not found                            |
| Caching     | Save to Drift `food_items` table                                    |

### 17.3 Fitbit Web API

```dart
// OAuth2 flow — token exchange via Appwrite Function (client_secret stays server-side)
// Scope: activity + sleep + heartrate + oxygen_saturation
// Delta-sync on app resume — only data since last_sync_at
```

### 17.4 Appwrite Function — Fitbit Token Exchange

```javascript
// Keeps client_secret server-side — never exposed to Flutter
export default async ({ req, res }) => {
  const { code } = JSON.parse(req.body);
  const tokenRes = await fetch('https://api.fitbit.com/oauth2/token', {
    method: 'POST',
    headers: {
      'Authorization': 'Basic ' + btoa(CLIENT_ID + ':' + CLIENT_SECRET),
      'Content-Type':  'application/x-www-form-urlencoded',
    },
    body: new URLSearchParams({ grant_type: 'authorization_code', code, redirect_uri: REDIRECT_URI }),
  });
  const tokens = await tokenRes.json();
  return res.json({ access_token: tokens.access_token, refresh_token: tokens.refresh_token });
};
```

### 17.5 Appwrite Function — WhatsApp Bot Webhook — NEW

```javascript
// Trigger: WhatsApp Cloud API POST webhook
// Appwrite Function receives message, parses food/mood/stats intent,
// calls internal FitKarma food search, writes log via Appwrite Databases,
// replies via WhatsApp Cloud API send_message endpoint.

export default async ({ req, res }) => {
  const body  = JSON.parse(req.body);
  const from  = body.entry[0].changes[0].value.messages[0].from;
  const text  = body.entry[0].changes[0].value.messages[0].text.body.toLowerCase();

  const userId = await getUserByPhone(from);  // Lookup by WhatsApp number in users collection
  if (!userId) return res.json({ error: 'Not linked' });

  const intent = parseIntent(text);  // 'food_log' | 'mood_log' | 'stats'
  const reply  = await handleIntent(intent, userId, text);

  await sendWhatsAppReply(from, reply);
  return res.json({ success: true });
};
```

### 17.6 Appwrite Function — Shareable Health Report — NEW

```javascript
// Generates a time-limited pre-signed URL for a locally generated PDF
// Flutter uploads the PDF bytes, Function creates the share URL
export default async ({ req, res }) => {
  const { userId, pdfBytes, reportPeriod } = JSON.parse(req.body);

  // Verify caller is the owner
  const user = await sdk.account.get();
  if (user.$id !== userId) return res.json({ error: 'Unauthorized' }, 403);

  // Upload to storage with auto-delete after 7 days
  const file = await sdk.storage.createFile(
    AW.healthReportsBucket,
    ID.unique(),
    InputFile.fromBytes(Buffer.from(pdfBytes, 'base64'), `report_${reportPeriod}.pdf`),
    [Permission.read(Role.any())],  // Public read — URL acts as the secret
  );

  const shareUrl = `${APPWRITE_ENDPOINT}/storage/buckets/${AW.healthReportsBucket}/files/${file.$id}/view`;
  const expiresAt = new Date(Date.now() + 7 * 24 * 60 * 60 * 1000).toISOString();

  return res.json({ share_url: shareUrl, expires_at: expiresAt });
};
```

### 17.7 Razorpay — Subscription & UPI Deep-link

**Standard subscription flow** (unchanged from v1.0):
1. Flutter calls Appwrite Function → creates Razorpay subscription order
2. Flutter opens `razorpay_flutter` checkout
3. Payment success → Razorpay webhook → Appwrite Function verifies HMAC → updates `subscriptions`
4. Appwrite Realtime pushes updated status to Flutter client

**UPI deep-link shortcut (NEW):** For users who prefer to skip the Razorpay checkout UI:
```dart
// Deep-link directly to a UPI app for instant payment
final upiUrl = Uri.parse(
  'upi://pay?pa=fitkarma@razorpay&pn=FitKarma&am=${plan.price}&cu=INR&tn=Premium+${plan.name}'
);
await launchUrl(upiUrl, mode: LaunchMode.externalApplication);
```

### 17.8 Other Integrations

| Integration                    | Detail                                                                |
|--------------------------------|-----------------------------------------------------------------------|
| Google ML Kit                  | TextRecognitionV2 (OCR), ObjectDetection (food photo), BarcodeScanning |
| `youtube_player_flutter`       | Plays workout videos by YouTube ID                                    |
| OpenStreetMap + `flutter_map`  | GPS workout route display — no Google Maps API key                    |
| `flutter_map_tile_caching`     | Offline tile caching for GPS workouts — **NEW**                       |
| Health Connect / HealthKit     | `health` package — steps, sleep, HR, SpO2, BP                        |
| Garmin Connect IQ              | OAuth1 — steps, sleep, HR, GPS workouts                              |
| `home_widget`                  | Android / iOS home screen and lock screen widgets — **NEW**           |
| `just_audio`                   | Bundled meditation audio playback — fully offline                     |
| WhatsApp Cloud API             | WhatsApp bot for food + mood logging — **NEW**                        |
| ABDM API (via Appwrite Fn)     | ABHA health record pull — **NEW**                                     |
| 1mg / PharmEasy deep-links     | Medication refill CTAs — **NEW**                                      |
| Sentry                         | Anonymised crash reporting — Flutter + Appwrite Functions             |
| Nominatim                      | Reverse geocoding for GPS workouts — free, no API key                 |

---

## 18. Performance Contracts

| Metric                      | Target          | Strategy                                                              |
|-----------------------------|-----------------|-----------------------------------------------------------------------|
| Cold start                  | < 2 seconds     | Drift pre-warmed; deferred Riverpod providers; deferred module loading|
| Dashboard render            | < 1 second      | Load from Drift first; lazy-load Appwrite data in background          |
| Local food search (FTS5)    | < 200 ms        | Drift FTS5 virtual table on `name` + `name_local`; BM25 relevance ranking |
| Offline write latency       | < 50 ms         | Direct Drift write — zero network calls                               |
| Sync batch flush            | < 5 seconds     | Max 20 documents per batch via Appwrite                               |
| Installed app size          | < 50 MB         | Deferred loading; tree-shaking; compressed assets; **enforced in CI** |
| Background battery drain    | < 3% / hour     | Efficient WorkManager isolate; Doze-aware sync scheduling             |
| GPS workout accuracy        | ± 10 m          | High-accuracy mode; smooth polyline rendering                         |
| PDF report generation       | < 3 seconds     | Dart isolate for PDF rendering — never blocks UI thread               |
| Wearable sync               | < 10 s on resume| Delta sync — only data since `last_sync_at`                          |
| Glucose/BP chart render     | < 300 ms        | Pre-computed chart data in Drift; recalculated only on new log        |
| Lab report OCR              | < 3 seconds     | On-device ML Kit — no server call                                     |
| Home widget update          | < 2 seconds     | WorkManager background task writes to shared preferences              |

### Flutter-Specific Optimisations

- `const` constructors on every widget possible.
- `RepaintBoundary` around animated widgets (rings, charts, fasting timer).
- `ListView.builder` for all scrolling lists — never `Column` with `map`.
- Dart isolates for CPU-heavy operations: AES encryption, PDF generation, barcode decoding, lab OCR processing, chart data pre-computation.
- Images compressed to max 1080px, WebP format before upload.
- **Deferred loading** for heavy modules: Wearables, GPS maps, Community feed, Mental health, Reports, ABHA.

---

## 19. State Management

### Provider Types

| Provider                  | Use Case                                                           |
|---------------------------|--------------------------------------------------------------------|
| `Provider`                | Synchronous, immutable values — config, constants, services         |
| `FutureProvider`          | One-time async fetch — user profile, initial food search           |
| `StateNotifierProvider`   | Mutable state with business logic — auth, food log form, sync queue |
| `StreamProvider`          | Real-time data — Appwrite Realtime, step counter, fasting timer     |
| `AsyncNotifierProvider`   | Async state with mutations — preferred for complex screens          |

### Provider Disposal & Scoping

```dart
// Feature providers are scoped to their route — auto-disposed on navigation pop
// This prevents the 30+ module providers from accumulating memory

@riverpod
class FoodSearchNotifier extends _$FoodSearchNotifier {
  @override
  bool keepAlive() => false;  // Dispose when screen pops

  // Cancellation token for long-running search
  CancelToken? _cancelToken;

  @override
  Future<List<FoodItem>> build(String query) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();
    ref.onDispose(() => _cancelToken?.cancel());

    return FoodRepository.search(query, cancelToken: _cancelToken);
  }
}
```

### Error Boundaries

```dart
// ✅ Correct — all async providers handle all three states explicitly
@override
Widget build(BuildContext context, WidgetRef ref) {
  final data = ref.watch(foodLogsProvider(today));
  return data.when(
    loading: () => const ShimmerLoader(),
    error:   (e, s) => ErrorRetryWidget(error: e, onRetry: () => ref.refresh(foodLogsProvider(today))),
    data:    (logs) => FoodLogList(logs: logs),
  );
}

// ✅ Correct — use ref.watch() in build(); ref.read() in callbacks only
// ✅ Correct — const constructors everywhere possible
// ❌ Wrong — never use setState() for business logic
// ❌ Wrong — never assume AsyncValue is data without .when()
```

### Navigation — GoRouter Route Map (Updated)

```
/                               → Splash
/onboarding/:step               → Onboarding (steps 1–6, `:step` = 1..6)
/login                          → Login
/register                       → Register
/home                           → Shell (bottom nav)
  /home/dashboard               → Dashboard
  /home/food                    → Food Home
    /home/food/log/:mealType    → Food Log (mealType: breakfast|lunch|dinner|snack)
    /home/food/search           → Food Search
    /home/food/scan             → Barcode Scanner
    /home/food/photo            → Photo Scanner
    /home/food/lab-scan         → Lab Report / Prescription OCR
    /home/food/detail/:id       → Food Detail
    /home/food/recipes          → Recipe Browser
    /home/food/recipes/new      → Recipe Builder
    /home/food/planner          → Meal Planner
  /home/workout                 → Workout Home
    /home/workout/:id           → Workout Detail
    /home/workout/:id/active    → Active Workout (replaces /play — used for all workout types)
    /home/workout/gps           → GPS Outdoor Workout
    /home/workout/custom        → Custom Workout Builder
    /home/workout/calendar      → Workout Calendar
  /home/steps                   → Steps Home
  /home/social                  → Social Feed
    /home/social/groups         → Community Groups
    /home/social/groups/:id     → Group Detail
    /home/social/dm/:userId     → Direct Messages
/karma                          → Karma Hub
/profile                        → Profile
/sleep                          → Sleep Tracker
/mood                           → Mood Tracker
/habits                         → Habit Tracker
/period                         → Period Tracker
/medications                    → Medications
/body-metrics                   → Body Measurements
/ayurveda                       → Ayurveda Hub
/family                         → Family Profiles
/emergency                      → Emergency Card
/blood-pressure                 → BP Tracker
/glucose                        → Glucose Tracker
/spo2                           → SpO2 Tracker
/lab-reports                    → Lab Reports
/abha                           → ABHA Account
/chronic-disease                → Chronic Disease Hub
/fasting                        → Fasting Tracker
/meditation                     → Meditation & Pranayama
/journal                        → Journal
/mental-health                  → Mental Health Hub
/wearables                      → Wearable Connections
/home-widgets                   → Home Widget Configuration
/reports                        → Health Reports
/personal-records               → Personal Records
/doctor-appointments            → Doctor Appointments
/referral                       → Referral Program
/settings                       → Settings
/subscription                   → Subscription Plans
```

---

## 20. Monetization & Subscriptions

### Plans (Razorpay + UPI)

| Plan               | Price (INR)      | Key Features                                                    |
|--------------------|------------------|-----------------------------------------------------------------|
| Free               | ₹0               | Core tracking, limited food DB, community access, 7-day history |
| Monthly Premium    | ₹99 / month      | Full food DB, unlimited history, all modules, micronutrient tracking |
| Quarterly Premium  | ₹249 / 3 months  | Same as Monthly — 16% saving                                    |
| Yearly Premium     | ₹899 / year      | Same as Monthly — 25% saving + priority support                 |
| Family Plan        | ₹1,499 / year    | Up to 6 members, shared leaderboard, family challenges          |

Payment methods: Razorpay checkout (cards, netbanking, wallets) + **UPI deep-link shortcut** (NEW).

### Additional Revenue Streams

- **Karma Store** — premium workout packs, badge unlocks, profile themes, streak recovery tokens redeemable with earned XP.
- **À la carte purchases** — single premium workout pack.
- **Corporate wellness** — org-level dashboard, bulk subscriptions, HR integration.
- **Expert marketplace** — certified nutritionists and trainers (planned v3.0).
- **Affiliate** — transparent Ayurveda product recommendations via tracked links.
- **Referral program** — viral growth mechanic.
- **Real-world reward partnerships** — fitness brands, healthy food brands. **NEW**

---

## 21. Testing Strategy

### Unit Tests (target ≥ 60% coverage for `/data/` and `/domain/`)

- TDEE / BMR formula — all goal types and activity factors.
- Dosha quiz scoring algorithm.
- Blood pressure AHA classification — all threshold boundaries.
- Glucose WHO classification — fasting and post-meal thresholds.
- **Fasting stage machine** — in-progress, completed, broken states.
- **AES-256 round-trip** — encrypt then decrypt all sensitive model types (period, journal, BP, glucose, appointments).
- **HKDF key derivation** — verify each data class produces a unique, deterministic key. **NEW**
- Karma XP accumulation with streak multipliers.
- Recipe calorie + micronutrient auto-calculation from ingredient list. **NEW**
- Sync conflict resolution for all tiers (append-only, per-field LWW, user-prompted). **NEW**
- Idempotency key uniqueness. **NEW**
- Lab report OCR parser — known CBC and lipid panel text inputs. **NEW**
- Dead-letter queue promotion after 5 failures. **NEW**
- Cross-module correlation queries — sleep/mood, workout/protein, fasting/BP. **NEW**

### Widget Tests

- `ActivityRingsWidget` — various progress levels (0%, 50%, 100%, overflow).
- `BPTrendChart` — correct colour banding for all AHA classifications.
- `FastingProgressRing` — correct phase labels and countdown.
- `GlucoseHistoryChart` — target bands per reading type.
- `DoshaDonutChart` — segment proportions for all dosha combinations.
- `ShimmerLoader` and `ErrorRetryWidget` — render in all async states.
- `MoodEmojiSelector` — tap selection and slider interactions.
- `CorrelationInsightCard` — renders with multi-module data links. **NEW**
- `HomeWidgetPreview` — renders all three widget sizes. **NEW**

### Integration Tests

- Full food log flow — search → select → confirm → verify Drift write → verify sync queue entry.
- **Idempotency**: retry a failed sync write → verify only one Appwrite document created. **NEW**
- Offline → online sync — log items offline, restore connectivity, verify Appwrite document created, DLQ not triggered.
- Dead-letter queue — mock 6 consecutive sync failures → verify item in DLQ, user notified. **NEW**
- Auth flow — register → onboarding → dashboard loads from Drift.
- Period encryption — log entry → read back → verify decryption → verify raw database bytes are not plaintext.
- **HKDF isolation** — compromise journal key → verify BP data still inaccessible. **NEW**
- BP log flow — log → AES encryption → correct AHA classification displayed.
- Lab report OCR — sample pathology report image → verify extracted values → verify auto-population of glucose log. **NEW**
- Fasting flow — start → advance time → eat → verify completion and XP awarded.
- Referral flow — generate code → sign up with code → verify XP awarded to both parties.
- Cross-module correlation query — insert sleep and mood logs → verify `getSleepMoodCorrelation` result. **NEW**

### Performance Benchmarks

- Dashboard cold start < 2s on a 3 GB RAM device.
- Drift FTS5 food search < 200ms against a 10,000-item database.
- Sync queue flush — 20 records < 5s on a 3G connection.
- PDF report generation < 3s for a 30-day report.
- BP/Glucose chart render < 300ms with 90 data points.
- **Lab OCR extraction < 3s on a real device**. **NEW**
- **App bundle size < 50 MB** — automated check in CI/CD. **NEW**

---

## 22. Coding Standards

### Dart / Flutter Rules

- **Riverpod only** for state management — `setState` is never used for business logic.
- **Immutable models** — all fields are `final`; use `copyWith` for updates.
- **Named constructors mandatory**: `MyModel.fromAppwrite()`, `MyModel.fromDrift()`.
- **`AsyncValue` handling mandatory** — all `FutureProvider` / `StreamProvider` widgets must handle all three states.
- **`const` constructors** on every widget and model where possible.
- **Build method limit**: max 80 lines — extract sub-widgets if exceeded.
- **No `var`** for non-obvious types.
- **Provider disposal**: set `keepAlive: false` on all feature-screen providers.
- **Drift is the only approved local storage solution.** Never use ad-hoc key-value stores for structured or relational data; all local writes go through a typed Drift DAO.

### File Naming Conventions

| Type           | Convention                          | Example                    |
|----------------|-------------------------------------|----------------------------|
| Screens        | `snake_case_screen.dart`            | `food_log_screen.dart`     |
| Widgets        | `snake_case_card.dart` / `_widget`  | `food_log_card.dart`       |
| Providers      | Grouped by feature                  | `food_providers.dart`      |
| Models         | `snake_case_model.dart`             | `food_log_model.dart`      |
| Appwrite svc   | `feature_aw_service.dart`           | `food_aw_service.dart`     |
| Drift svc      | `feature_drift_service.dart`        | `food_drift_service.dart`  |
| Repositories   | `feature_repository.dart`           | `food_repository.dart`     |
| Insight rules  | `domain_rules.dart`                 | `nutrition_rules.dart`     |

### Commit Message Format (Conventional Commits)

```
feat(food):        add "copy yesterday's meals" one-tap shortcut
feat(abha):        add ABHA health ID linking and record pull
feat(widgets):     add Wear OS activity rings tile and water complication
feat(insight):     add cross-module sleep–mood correlation rule
feat(sync):        add dead-letter queue with Settings surface
fix(sync):         prevent duplicate writes with idempotency keys
fix(bp):           correct AHA Stage 2 classification boundary
perf(search):      add FTS5 virtual table and BM25 ranking for food search
security(keys):    implement HKDF per-data-class key derivation
test(encryption):  add HKDF key isolation round-trip integration test
chore(deps):       bump appwrite SDK to 13.x
```

---

## 23. Environment Configuration

> ⚠️ **Never commit `.env` files to version control. Add `.env*` to `.gitignore` immediately. Maintain separate `.env.staging` and `.env.prod` files.**

### `.env` File

```env
# ── Appwrite ─────────────────────────────────────────────────────
APPWRITE_ENDPOINT=https://cloud.appwrite.io/v1
APPWRITE_PROJECT_ID=your_project_id
APPWRITE_DATABASE_ID=your_database_id
APPWRITE_API_KEY=your_server_api_key       # Server-side / Appwrite Functions only

# ── External APIs ─────────────────────────────────────────────────
YOUTUBE_API_KEY=your_youtube_data_api_v3_key
RAZORPAY_KEY_ID=rzp_test_xxxxxxxxxxxx
RAZORPAY_KEY_SECRET=your_secret_key        # SERVER SIDE ONLY
OPEN_FOOD_FACTS_USER_AGENT=FitKarma/1.0 (contact@fitkarma.app)
FCM_SERVER_KEY=your_fcm_server_key
SENTRY_DSN=https://xxx@sentry.io/xxx

# ── Wearable APIs ─────────────────────────────────────────────────
FITBIT_CLIENT_ID=your_fitbit_client_id
FITBIT_CLIENT_SECRET=your_fitbit_client_secret   # SERVER SIDE ONLY — Appwrite Function env var
GARMIN_CONSUMER_KEY=your_garmin_consumer_key
GARMIN_CONSUMER_SECRET=your_garmin_consumer_secret

# ── India Ecosystem ───────────────────────────────────────────────
WHATSAPP_PHONE_NUMBER_ID=your_wa_phone_number_id     # NEW
WHATSAPP_ACCESS_TOKEN=your_wa_access_token            # SERVER SIDE ONLY — Appwrite Function
ABDM_CLIENT_ID=your_abdm_client_id                    # NEW — ABHA integration
ABDM_CLIENT_SECRET=your_abdm_client_secret            # SERVER SIDE ONLY

# ── Certificate Pinning ───────────────────────────────────────────
APPWRITE_CERT_FINGERPRINT=sha256/your_appwrite_domain_fingerprint   # NEW

# ── Production overrides ──────────────────────────────────────────
# APPWRITE_ENDPOINT=https://appwrite.fitkarma.app/v1
# RAZORPAY_KEY_ID=rzp_live_xxxxxxxxxxxx
```

### `pubspec.yaml` — Key Dependencies

```yaml
dependencies:
  flutter_riverpod:              ^2.4.9
  riverpod_annotation:           ^2.3.3
  drift:                         ^2.14.1      # All local data storage
  drift_flutter:                 ^0.1.0
  sqlite3_flutter_libs:          ^0.5.0
  sqlcipher_flutter_libs:        ^0.5.0       # For Drift database encryption
  cryptography:                  ^2.7.0       # HKDF + AES-256-GCM field-level encryption
  crypto:                        ^3.0.3       # SHA-256 for idempotency key generation only
  appwrite:                      ^13.0.0
  go_router:                     ^11.0.0
  # HTTP clients — use dio everywhere (CancelToken support, interceptors);
  # http is retained solely for packages that depend on it transitively.
  dio:                           ^5.4.0       # Primary HTTP client: cancellation, retries, interceptors
  http:                          ^1.1.0       # Transitive dependency only — do not use directly
  flutter_secure_storage:        ^9.0.0
  local_auth:                    ^2.1.7
  flutter_jailbreak_detection:   ^1.9.0
  connectivity_plus:             ^5.0.2
  geolocator:                    ^10.1.0
  flutter_map:                   ^6.1.0
  flutter_map_tile_caching:      ^9.0.0       # Offline GPS map tiles
  youtube_player_flutter:        ^8.1.2
  google_mlkit_text_recognition: ^0.11.0
  google_mlkit_object_detection: ^0.11.0
  flutter_barcode_scanner:       ^1.0.0
  speech_to_text:                ^6.3.0
  health:                        ^9.0.0
  fl_chart:                      ^0.66.0
  shimmer:                       ^3.0.0
  flutter_local_notifications:   ^16.1.0
  razorpay_flutter:              ^1.3.7
  home_widget:                   ^0.4.1       # Android/iOS home screen widgets
  firebase_messaging:            ^14.7.9      # FCM token only
  sentry_flutter:                ^7.14.0
  cached_network_image:          ^3.3.1
  image_picker:                  ^1.0.4
  path_provider:                 ^2.1.1
  path:                          ^1.9.0       # p.join() for database file path
  flutter_dotenv:                ^5.1.0
  pdf:                           ^3.10.0
  flutter_quill:                 ^9.0.0
  just_audio:                    ^0.9.0
  workmanager:                   ^0.5.0
  url_launcher:                  ^6.2.5       # UPI deep-links

dev_dependencies:
  riverpod_generator: ^2.3.9
  drift_dev:          ^2.14.1      # Code generation for Drift
  build_runner:       ^2.4.7
  flutter_test:
    sdk: flutter
  mockito:            ^5.4.4
  integration_test:
    sdk: flutter
```

---

## 24. CI/CD Pipeline

### GitHub Actions Workflow

```yaml
# .github/workflows/ci.yml
name: FitKarma CI/CD

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

env:
  FLUTTER_VERSION: '3.x'

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: ${{ env.FLUTTER_VERSION }}
          channel: stable
      - run: flutter pub get
      - run: dart fix --apply
      - run: flutter analyze --fatal-infos
      - run: flutter test --coverage
      - uses: codecov/codecov-action@v3
        with:
          files: coverage/lcov.info

  check_app_size:       # NEW — enforce < 50 MB
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
      - run: flutter build apk --dart-define-from-file=.env.staging --split-per-abi
      - run: |
          SIZE=$(du -sm build/app/outputs/flutter-apk/app-arm64-v8a-release.apk | cut -f1)
          echo "APK size: ${SIZE} MB"
          if [ $SIZE -gt 50 ]; then echo "ERROR: APK exceeds 50 MB" && exit 1; fi

  build_android:
    needs: [test, check_app_size]
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
      - run: flutter build appbundle --dart-define-from-file=.env.prod
      - uses: actions/upload-artifact@v3
        with:
          name: android-release
          path: build/app/outputs/bundle/release/app-release.aab

  build_ios:
    needs: [test, check_app_size]
    runs-on: macos-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
      - uses: apple-actions/import-codesign-certs@v2    # NEW — iOS code signing
        with:
          p12-file-base64: ${{ secrets.IOS_DIST_CERT_P12 }}
          p12-password: ${{ secrets.IOS_DIST_CERT_PASSWORD }}
      - uses: apple-actions/download-provisioning-profiles@v1  # NEW
        with:
          bundle-id: com.fitkarma.app
          issuer-id: ${{ secrets.APPSTORE_ISSUER_ID }}
          api-key-id: ${{ secrets.APPSTORE_KEY_ID }}
          api-private-key: ${{ secrets.APPSTORE_PRIVATE_KEY }}
      - run: flutter build ipa --dart-define-from-file=.env.prod

  deploy_staging:       # NEW — deploy to staging Appwrite on develop branch
    needs: test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/develop'
    steps:
      - uses: actions/checkout@v4
      - run: npm install -g appwrite-cli
      - run: appwrite login --endpoint ${{ secrets.APPWRITE_STAGING_ENDPOINT }} --project-id ${{ secrets.APPWRITE_STAGING_PROJECT_ID }}
      - run: appwrite deploy function --all
```

### Required GitHub Secrets

```
APPWRITE_PROJECT_ID               — Production Appwrite project ID
APPWRITE_DATABASE_ID              — Production database ID
APPWRITE_STAGING_PROJECT_ID       — Staging project ID    (NEW)
APPWRITE_STAGING_ENDPOINT         — Staging endpoint URL  (NEW)
RAZORPAY_KEY_ID                   — Live Razorpay key
FITBIT_CLIENT_ID                  — Fitbit app client ID
IOS_DIST_CERT_P12                 — iOS distribution certificate  (NEW)
IOS_DIST_CERT_PASSWORD            — Certificate password          (NEW)
APPSTORE_ISSUER_ID                — App Store Connect issuer      (NEW)
APPSTORE_KEY_ID                   — App Store Connect key ID      (NEW)
APPSTORE_PRIVATE_KEY              — App Store Connect private key (NEW)
```

### Disaster Recovery & Backup

```bash
# Daily backup cron — 02:00 IST
0 20 * * * appwrite databases export \
  --databaseId $DATABASE_ID \
  --output /backups/fitkarma-$(date +%Y%m%d).json \
  && rclone copy /backups/ b2:fitkarma-backups/
```

- **Retention**: 30 daily backups; 12 monthly backups.
- **Storage**: Backblaze B2.
- **Recovery test**: Monthly restore drill in staging environment.
- **Staging parity**: Staging environment runs the same schema as production, seeded with anonymised test data.

### Admin Dashboard

- **Internal web app** built with Appwrite Console + custom Appwrite Functions.
- **Content management**: Add/edit workout videos, seed food items, create challenges.
- **User management**: Aggregate engagement stats, subscription management, Razorpay refund processing.
- **Monitoring**: Appwrite Console metrics + Sentry dashboard.
- **Feature flags**: Managed via `RemoteConfig` collection — toggle any feature, update server-delivered insight rules, control A/B rollouts, without an app update.

---

*FitKarma Developer Documentation v2.0*
*Flutter · Riverpod · Drift (SQLCipher) · Appwrite · Built for India*
*Offline-first · Privacy-centric · 35+ modules · Full bilingual UI · Dark mode · ABHA integrated*