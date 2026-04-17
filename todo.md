# FitKarma — Complete Implementation TODO

> **Stack:** Flutter 3.x · Riverpod 2.x · Drift (SQLCipher) · Appwrite · GoRouter
> **Target:** Offline-first, privacy-centric, India-specific fitness app
> **Bundle ID:** `com.fitkarma.app`
> **Constraint:** APK < 50 MB · Cold start < 2s · Dashboard render < 1s

---

## 0. PROJECT BOOTSTRAP

### 0.1 Flutter Project Setup
- [x] `flutter create com.fitkarma.app` with bundle ID `com.fitkarma.app`
- [x] Set `minSdkVersion 23`, `targetSdkVersion 34` (Android)
- [ ] Set iOS deployment target `iOS 14.0`
- [x] Add `.env`, `.env.staging`, `.env.prod` to `.gitignore`
- [x] Create `.env` file with all variables (see §23 of docs)
- [x] Configure `flutter_dotenv` to load `.env` at startup

### 0.2 pubspec.yaml Dependencies
- [x] Add all dependencies (exact versions from docs §23)

### 0.3 Asset Configuration
- [/] Bundle fonts (Using package per user decision)
- [ ] Add Lottie placeholders: 20+ required files
- [x] Initialize directory structure for Lottie/Rive

---

## 1. FOLDER STRUCTURE

Create the following directory tree under `lib/`:
```
lib/
├── core/
│   ├── config/          # app_config.dart, device_tier.dart, remote_config.dart
│   ├── constants/       # api_endpoints.dart (AW class), karma_constants.dart
│   ├── network/         # appwrite_client.dart (with cert pinning stub)
│   ├── security/        # key_manager.dart (HKDF), encryption_service.dart
│   ├── storage/         # app_database.dart (Drift), all Drift table definitions
│   ├── sync/            # sync_engine.dart, sync_queue.dart, dead_letter_queue.dart
│   ├── providers/       # root-level providers (connectivity, device_tier, ux_stage)
│   └── router/          # app_router.dart (GoRouter)
├── features/
│   ├── auth/
│   ├── onboarding/
│   ├── dashboard/
│   ├── food/
│   ├── workout/
│   ├── steps/
│   ├── sleep/
│   ├── mood/
│   ├── habits/
│   ├── body_measurements/
│   ├── karma/
│   ├── blood_pressure/
│   ├── glucose/
│   ├── spo2/
│   ├── period/
│   ├── medication/
│   ├── fasting/
│   ├── nutrition_goals/
│   ├── ayurveda/
│   ├── journal/
│   ├── mental_health/
│   ├── meal_planner/
│   ├── recipe_builder/
│   ├── personal_records/
│   ├── lab_reports/
│   ├── abha/
│   ├── doctor_appointments/
│   ├── health_reports/
│   ├── emergency_card/
│   ├── wearables/
│   ├── festival_calendar/
│   ├── wedding_planner/
│   ├── social/
│   ├── community/
│   ├── challenges/
│   ├── family/
│   ├── whatsapp_bot/
│   ├── home_widgets/
│   ├── subscription/
│   └── settings/
└── shared/
    ├── widgets/         # All shared UI components
    ├── models/          # Shared model classes
    └── utils/           # Date helpers, formatters, validators
```

Each feature folder follows:
```
feature/
├── data/
│   ├── feature_aw_service.dart
│   └── feature_drift_service.dart
├── domain/
│   ├── feature_model.dart
│   └── feature_rules.dart  (insight rules)
├── presentation/
│   ├── feature_screen.dart
│   ├── widgets/
│   └── feature_providers.dart
└── feature_repository.dart
```

---

## 2. CORE INFRASTRUCTURE

### 2.1 Design Token System
- [x] Create `lib/core/config/app_theme.dart` with full token set
- [x] Create `ThemeData` for dark mode (primary target) and light mode using tokens
- [x] **Hero gradients** implementation
- [x] Shape/radius tokens: `radiusSm=10`, `radiusMd=16`, `radiusLg=20`, `radiusXl=28`, `radiusFull=9999`

### 2.2 Typography System
- [x] Register `Plus Jakarta Sans` typography in `ThemeData`
- [x] Register `JetBrains Mono` for stats/metrics
- [x] Register `Noto Sans Devanagari` for Hindi labels
- [x] Define all 17 named text styles
- [ ] Enforce **Single Hero Typography Rule**

### 2.3 Device Tier System
- [x] Create `lib/core/config/device_tier.dart` with `DeviceTier` enum and detection logic
- [x] Implement `DeviceTierProvider` as root-level Riverpod provider
- [x] Define Tier feature matrix extension

### 2.4 Motion & Animation System
- [x] Create 3 spring presets in `lib/core/config/motion_presets.dart`
- [ ] Standardize Screen push/pop animations
- [ ] Standardize Bottom sheet reveal animations
- [ ] Standardize Tab switch animations
- [ ] Implement Card tap feedback (scale)
- [ ] Implement FAB expand animations
- [ ] Implement Metric CountUp (per-digit spring)
- [ ] Implement Ring progress animations
- [ ] Implement Chip select animations
- [ ] Implement XP float animation
- [ ] **Reduce-motion** support
- [ ] **Low-tier fallback** (cross-fade)

### 2.5 Surface & Depth System (3 Planes)
- [x] Implement `GlassCard` widget with Tier-gating
- [ ] Implement **Visual Calm Zone** enforcement
- [ ] **Glow Discipline** enforcement
- [ ] Implement Ambient glow blobs for hero screens (Tier-gated)

### 2.6 Scaffold Patterns
- [x] **Pattern A — Standard**: `bg1` background, transparent elevated app bar, 20px horizontal padding
- [x] **Pattern B — Immersive Hero**: `heroDeep` gradient (320px) + ambient blobs + transparent AppBar; body overlaps hero by 28px with `radiusXl` clip. `extendBodyBehindAppBar: true`
- [x] **Pattern C — Full-Bleed Immersive**: full-screen content (active workout, GPS); no AppBar; system overlay icons white

---

## 3. APPWRITE BACKEND SETUP

### 3.0 CLI Project Structure
The Appwrite backend is managed entirely via the **Appwrite CLI**. Two fully independent environment folders — each contains its own databases, buckets, and function deployments. There is **no manual Console setup** — everything is declared as code and deployed via CLI.

```
appwrite/
├── staging/
│   ├── appwrite.json              # staging project ID + endpoint
│   ├── databases/                 # collection + attribute + index definitions
│   ├── buckets/                   # staging bucket definitions
│   │   ├── avatars.json
│   │   ├── posts_media.json
│   │   └── health_reports_share.json
│   └── functions/                 # staging function deployments
│       ├── fcm-hook/
│       │   ├── src/index.js
│       │   └── appwrite.json      # function config scoped to staging project
│       ├── razorpay-webhook/
│       │   ├── src/index.js
│       │   └── appwrite.json
│       ├── fitbit-token-exchange/
│       │   ├── src/index.js
│       │   └── appwrite.json
│       ├── garmin-token-exchange/
│       │   ├── src/index.js
│       │   └── appwrite.json
│       ├── whatsapp-bot/
│       │   ├── src/index.js
│       │   └── appwrite.json
│       └── abha-token-exchange/
│           ├── src/index.js
│           └── appwrite.json
└── production/
    ├── appwrite.json              # production project ID + endpoint
    ├── databases/                 # identical schema to staging
    ├── buckets/                   # production bucket definitions (same IDs, different project)
    │   ├── avatars.json
    │   ├── posts_media.json
    │   └── health_reports_share.json
    └── functions/                 # production function deployments
        ├── fcm-hook/
        │   ├── src/index.js       # same source as staging
        │   └── appwrite.json      # function config scoped to production project
        ├── razorpay-webhook/
        │   ├── src/index.js
        │   └── appwrite.json
        ├── fitbit-token-exchange/
        │   ├── src/index.js
        │   └── appwrite.json
        ├── garmin-token-exchange/
        │   ├── src/index.js
        │   └── appwrite.json
        ├── whatsapp-bot/
        │   ├── src/index.js
        │   └── appwrite.json
        └── abha-token-exchange/
            ├── src/index.js
            └── appwrite.json
```

**Key rules:**
- `appwrite/staging/` and `appwrite/production/` are **fully independent** — each has its own project ID, endpoint, database, buckets, and function deployments
- **Database schema is always identical** across both environments — any new collection, attribute, or index must be added to both folders in the same PR
- **Buckets are separate per environment** — staging and production each declare their own `avatars`, `posts_media`, and `health_reports_share` buckets; same bucket IDs but scoped to their respective Appwrite projects
- **Functions are separate per environment** — each `functions/` subfolder has its own `appwrite.json` pointing to its project; the `src/index.js` source is identical between staging and production (keep in sync); environment-specific secrets (Razorpay live vs test key, FCM server key, ABDM credentials) are set as **Appwrite Function environment variables** in each project's Console or via CLI — never hardcoded in source
- Deploy staging only: `cd appwrite/staging && appwrite deploy --all`
- Deploy production only: `cd appwrite/production && appwrite deploy --all`
- **Never deploy staging and production in the same command** — always explicit `cd` to the target environment first
- Bucket file permissions on `health_reports_share`: read-only for `Role.any()` (pre-signed URL access by doctors), write only for authenticated users + server functions

### 3.1 Flutter Appwrite Client
- [ ] Implement `AppwriteClient` singleton (`lib/core/network/appwrite_client.dart`) exposing `Client`, `Account`, `Databases`, `Storage`, `Realtime`, `Functions`
- [ ] `setEndpoint()` + `setProject()` from `String.fromEnvironment()` — values differ between staging and production builds automatically via `--dart-define-from-file`
- [ ] Set `setSelfSigned(status: false)` for certificate validation
- [ ] Add certificate pinning stub: SHA-256 fingerprint check on Appwrite domain using `APPWRITE_CERT_FINGERPRINT` env var
- [ ] Implement `AW` constants class with every collection ID, bucket ID listed in docs §5.3 — all values from `String.fromEnvironment()`

### 3.2 Appwrite CLI Schema Definitions
Define inside both `appwrite/staging/databases/` and `appwrite/production/databases/` (must be kept identical):
- [ ] All collections: `users`, `food_logs`, `food_items`, `workout_logs`, `step_logs`, `sleep_logs`, `mood_logs`, `period_logs`, `medications`, `habits`, `body_measurements`, `karma_transactions`, `nutrition_goals`, `posts`, `challenges`, `subscriptions`, `family_groups`, `workouts`, `blood_pressure_logs`, `glucose_logs`, `spo2_logs`, `doctor_appointments`, `fasting_logs`, `meal_plans`, `recipes`, `journal_entries`, `personal_records`, `community_groups`, `health_reports`, `community_dms`, `lab_reports`, `abha_links`, `remote_config`, `sync_dead_letter`
- [ ] All **composite indices** (critical for <1s dashboard load):
  - `food_logs`: `[user_id, logged_at DESC]`
  - `step_logs`: `[user_id, date DESC]`
  - `workout_logs`: `[user_id, logged_at DESC]`
  - `sleep_logs`: `[user_id, date DESC]`
  - `mood_logs`: `[user_id, logged_at DESC]`
  - `blood_pressure_logs`: `[user_id, measured_at DESC]`
  - `glucose_logs`: `[user_id, logged_at DESC]`
  - `fasting_logs`: `[user_id, fast_start DESC]`
  - `food_items`: `name` full-text + `barcode` key index
  - `challenges`: `[start_date, end_date, is_active]`
- [ ] Document-level permissions on every collection: `Role.user({userId})` read + write
- [ ] Enable Google OAuth2 + Apple Sign-In in both projects (set in Appwrite Console manually or via CLI auth config)
- [ ] Enable SMTP for password reset emails in both projects
- [ ] Bucket definitions in `appwrite/staging/buckets/` and `appwrite/production/buckets/`: `avatars`, `posts_media`, `health_reports_share`
- [ ] Function definitions in both environments: `fcm-hook`, `razorpay-webhook`, `fitbit-token-exchange`, `garmin-token-exchange`, `whatsapp-bot`, `abha-token-exchange`
- [ ] Set function environment variables per project via CLI (never hardcode in source): Razorpay secret, FCM server key, ABDM credentials, Fitbit/Garmin secrets, WhatsApp access token

---

## 4. LOCAL STORAGE — DRIFT (SQLCipher)

### 4.1 Database Setup
- [ ] Create `lib/core/storage/app_database.dart` with `@DriftDatabase` annotation
- [ ] Implement `SQLCipher` connection with PRAGMA key from `KeyManager`
- [ ] Set `PRAGMA cipher_page_size = 4096`
- [ ] Tables list: `FoodLogs`, `FoodItems`, `WorkoutLogs`, `StepLogs`, `SleepLogs`, `MoodLogs`, `Medications`, `Habits`, `HabitCompletions`, `BodyMeasurements`, `FastingLogs`, `MealPlans`, `Recipes`, `PersonalRecords`, `NutritionGoals`, `KarmaTransactions`, `SyncQueue`, `SyncDeadLetter`, `BloodPressureLogs`, `GlucoseLogs`, `Spo2Logs`, `PeriodLogs`, `JournalEntries`, `DoctorAppointments`, `LabReports`, `AbhaLinks`, `EmergencyCard`, `FestivalCalendar`, `RemoteConfigCache`

### 4.2 Drift Table Definitions
Define typed Drift tables matching Appwrite schemas (§6 of docs). Key fields for each:

- [ ] **`FoodLogs`**: `id`, `userId`, `foodItemId` (nullable), `recipeId` (nullable), `foodName`, `mealType` enum, `quantityG`, `calories`, `proteinG`, `carbsG`, `fatG`, `fiberG`, `vitaminDMcg`, `vitaminB12Mcg`, `ironMg`, `calciumMg`, `loggedAt`, `logMethod` enum, `syncStatus` enum, `idempotencyKey`, `fieldVersions` (JSON)
- [ ] **`FoodItems`**: `id`, `name`, `nameLocal`, `region` enum, `barcode` (nullable), `caloriesPer100g`, `proteinPer100g`, `carbsPer100g`, `fatPer100g`, `fiberPer100g`, `vitaminDPer100g`, `vitaminB12Per100g`, `ironPer100g`, `calciumPer100g`, `isIndian`, `servingSizes` (JSON), `source` enum, `restaurantName`, `swigyItemId`, `zomatoItemId`
- [ ] **`WorkoutLogs`**: `id`, `userId`, `workoutId`, `title`, `durationMin`, `caloriesBurned`, `avgHrBpm`, `hrZone`, `rpeScore`, `loggedAt`, `syncStatus`, `idempotencyKey`
- [ ] **`StepLogs`**: `id`, `userId`, `date`, `stepCount`, `distanceKm`, `caloriesBurned`, `activeMinutes`, `source` enum, `syncStatus`
- [ ] **`SleepLogs`**: `id`, `userId`, `date`, `bedtime`, `wakeTime`, `durationMin`, `qualityScore`, `deepSleepMin`, `sleepDebtMin`, `notes`, `source` enum, `syncStatus`
- [ ] **`MoodLogs`**: `id`, `userId`, `moodScore` (1–5), `energyLevel` (1–10), `stressLevel` (1–10), `tags` (JSON), `loggedAt`, `syncStatus`
- [ ] **`BloodPressureLogs`** (AES-encrypted fields): `id`, `userId`, `systolic`, `diastolic`, `pulse`, `loggedAt`, `classification` enum, `notes`, `source` enum, `syncStatus`, `idempotencyKey`
- [ ] **`GlucoseLogs`** (AES-encrypted): `id`, `userId`, `glucoseMgdl`, `readingType` enum, `foodLogId` (nullable), `loggedAt`, `classification` enum, `hba1cEstimate` (nullable), `notes`, `source` enum, `syncStatus`, `idempotencyKey`
- [ ] **`Spo2Logs`**: `id`, `userId`, `spo2Pct`, `pulseBpm`, `loggedAt`, `source` enum, `syncStatus`
- [ ] **`PeriodLogs`** (AES-encrypted, local-only by default): `id`, `userId`, `cycleStart`, `cycleEnd`, `periodLength`, `cycleLength`, `symptoms` (JSON), `notes`, `flowIntensity` enum
- [ ] **`Medications`**: `id`, `userId`, `name`, `dosage`, `frequency`, `category` enum, `reminderTimes` (JSON), `refillReminderDays`, `pharmacyDeeplink`, `isActive`, `syncStatus`
- [ ] **`Habits`**: `id`, `userId`, `name`, `icon`, `targetCount`, `unit`, `frequency` enum, `currentStreak`, `longestStreak`, `streakRecoveryUsed`, `reminderTime`, `isPreset`, `syncStatus`
- [ ] **`HabitCompletions`**: `id`, `habitId`, `userId`, `completedAt`, `count`, `syncStatus`
- [ ] **`BodyMeasurements`**: `id`, `userId`, `weightKg`, `heightCm`, `chestCm`, `waistCm`, `hipsCm`, `armsCm`, `thighsCm`, `bodyFatPct`, `bmi`, `waistToHip`, `waistToHeight`, `loggedAt`, `syncStatus`
- [ ] **`FastingLogs`**: `id`, `userId`, `fastStart`, `fastEnd` (nullable), `protocol` enum, `stage` enum, `isCompleted`, `syncStatus`
- [ ] **`JournalEntries`** (AES-encrypted, local-only): `id`, `userId`, `content` (rich text delta), `moodScore`, `tags` (JSON), `sentimentScore` (nullable), `createdAt`, `updatedAt`
- [ ] **`DoctorAppointments`** (AES-encrypted): `id`, `userId`, `doctorName`, `specialty`, `dateTime`, `notes`, `prescriptionLocalPath` (nullable), `syncStatus`
- [ ] **`LabReports`**: `id`, `userId`, `reportDate`, `labName`, `extractedValues` (JSON), `rawText` (nullable), `confirmedByUser`, `source` enum, `importedMetrics` (JSON), `syncStatus`
- [ ] **`AbhaLinks`**: `id`, `userId`, `abhaId`, `abhaAddress`, `linkedAt`, `consentGranted`, `lastSync`
- [ ] **`EmergencyCard`** (local-only, never synced): `id`, `userId`, `bloodGroup`, `allergies` (JSON), `chronicConditions` (JSON), `currentMedications` (JSON), `emergencyContactName`, `emergencyContactPhone`, `doctorName`, `doctorPhone`, `insurancePolicyNumber`, `insurerName`, `updatedAt`
- [ ] **`FestivalCalendar`**: `id`, `festivalKey`, `nameEn`, `nameHi`, `region`, `calendarSystem` enum, `startDate`, `endDate`, `fastingType` enum, `dietPlanType` enum, `allowedFoodIds` (JSON), `forbiddenFoodIds` (JSON), `year`, `computedAt`
- [ ] **`RemoteConfigCache`**: `key`, `value`, `type`, `rolloutPct`, `abSeed`, `fetchedAt`
- [ ] **`SyncQueue`**: `id`, `userId`, `collection`, `documentId`, `operation` enum, `payload` (JSON), `idempotencyKey`, `retryCount`, `createdAt`
- [ ] **`SyncDeadLetter`**: `id`, `userId`, `originalItem` (JSON), `failCount`, `lastError`, `createdAt`
- [ ] **`KarmaTransactions`**: `id`, `userId`, `amount`, `action`, `description`, `balanceAfter`, `createdAt`, `syncStatus`
- [ ] **`NutritionGoals`**: `id`, `userId`, `tdee`, `calorieGoal`, `proteinG`, `carbsG`, `fatG`, `goalType` enum, `vitDMcg`, `b12Mcg`, `ironMg`, `calciumMg`, `updatedAt`
- [ ] **`MealPlans`**: `id`, `userId`, `weekStart`, `planData` (JSON), `festivalKey` (nullable), `weddingPhase` (nullable), `syncStatus`
- [ ] **`Recipes`**: `id`, `userId`, `name`, `ingredients` (JSON), `servings`, `caloriesPerServing`, `macros` (JSON), `micronutrients` (JSON), `isPublic`, `regionalCuisine`, `syncStatus`
- [ ] **`PersonalRecords`**: `id`, `userId`, `exerciseName`, `value`, `unit`, `recordedAt`, `workoutLogId` (nullable), `isAutoDetected`, `syncStatus`

### 4.3 FTS5 Full-Text Search
- [ ] Create `FoodItemsFts` virtual FTS5 table on `food_items(name, name_local)`
- [ ] Implement BM25 ranking for search results
- [ ] Benchmark: Drift FTS5 food search < 200ms against 10,000-item database

### 4.4 DAO Layer
Create typed DAOs for each feature module:
- [ ] `FoodDao` — CRUD + FTS5 search + barcode lookup + `copyYesterdayMeals()`
- [ ] `WorkoutDao` — CRUD + log queries
- [ ] `StepDao` — daily/weekly queries
- [ ] `SleepDao` — weekly trend + sleep debt calculation
- [ ] `MoodDao` — heatmap calendar query + mood–sleep correlation join
- [ ] `HabitDao` — streak calculations + completion history
- [ ] `BloodPressureDao` — AES field encryption/decryption + AHA classification
- [ ] `GlucoseDao` — AES encryption + HbA1c rolling average
- [ ] `PeriodDao` — cycle prediction + phase calculation (AES encrypted)
- [ ] `MedicationDao` — active medications list + refill alerts
- [ ] `JournalDao` — encrypted CRUD + sentiment trend query (AES)
- [ ] `KarmaDao` — balance query + transaction history
- [ ] `SyncQueueDao` — pending items + retry logic
- [ ] `FestivalCalendarDao` — upcoming festivals query + active festival detection
- [ ] `RemoteConfigDao` — key lookup with default fallback

### 4.5 Database Migrations
- [ ] Implement `MigrationStrategy` with `onCreate` and `onUpgrade`
- [ ] Version 1: baseline schema
- [ ] Future migrations: always additive (never destructive in production)

---

## 5. SECURITY & ENCRYPTION

### 5.1 HKDF Key Manager
- [ ] Implement `lib/core/security/key_manager.dart`:
  - Master key: 32 random bytes, stored in `flutter_secure_storage`
  - HKDF-derived per-data-class keys: `bp`, `glucose`, `period`, `journal`, `spo2`
  - `deriveKey(String dataClass)` → 32-byte AES-256 key
  - Keys are NOT tied to user password (OAuth users can have encrypted data)
  - Password changes do not re-encrypt data
- [ ] Implement `EncryptionService` using AES-256-GCM with HKDF-derived key per data class
- [ ] **Key isolation test**: compromising `journal` key must not expose `bp` data

### 5.2 Session Management
- [ ] Appwrite JWT stored in `flutter_secure_storage`
- [ ] Auto-renew session before expiry via `account.updateSession(sessionId: 'current')`
- [ ] Biometric lock via `local_auth` — guards app re-open
- [ ] Root/jailbreak detection via `flutter_jailbreak_detection` — warn user, do not block
- [ ] Sensitive screens (journal, period, BP logs) require biometric re-auth if enabled

---

## 6. OFFLINE SYNC ENGINE

### 6.1 Sync Architecture
- [ ] **All writes go to Drift instantly**; Appwrite is only touched during sync
- [ ] Sync queue: `SyncQueue` Drift table; every create/update/delete is enqueued
- [ ] Implement `SyncEngine` that flushes the queue when online

### 6.2 Idempotency Keys
- [ ] Generate idempotency key: `SHA-256(userId + collection + localId + createdAt)` for every log entry
- [ ] Pass `X-Idempotency-Key` header on all Appwrite mutations
- [ ] **Test**: retry a failed sync → verify only one Appwrite document created

### 6.3 Conflict Resolution
- [ ] Per-field version vectors: `fieldVersions` JSON map of `{fieldName: updatedAt}` on every synced document
- [ ] On conflict: last-write-wins per field (not per document)

### 6.4 Dead-Letter Queue (DLQ)
- [ ] After 5 consecutive failures: move item to `SyncDeadLetter` table
- [ ] Persist DLQ to Drift; survives app restarts
- [ ] Surface in Settings → Data & Sync: show count + list of failed items
- [ ] **Amber glass top banner** when `syncDeadLetterCount > 0`: "⚠ N items failed to sync. Tap to review."

### 6.5 Connectivity & UI States
- [ ] `connectivity_plus` for network state
- [ ] **Offline banner**: teal glass pill "Offline — changes saved locally" (non-blocking toast)
- [ ] **Low Data Mode banner**: persistent teal glass pill at top of scaffold when enabled
- [ ] Background sync: WorkManager (Android) / `BGAppRefreshTask` (iOS); every 15 min normal, every 6h in Low Data Mode

---

## 7. REMOTE CONFIGURATION SYSTEM

- [ ] Implement `RemoteConfig` Riverpod provider (`lib/core/config/remote_config.dart`):
  - Load from Drift cache first (immediate, zero network)
  - Refresh from Appwrite `remote_config` collection in background
  - Schema: feature toggles, ML flags, A/B test rollout percentages, kill-switches, server-delivered insight rules
- [ ] Use for: `feature.abha_module`, `insight.ml_model_enabled`, `ab.new_dashboard` (rollout_pct), `kill.whatsapp_bot`, `insight.server_rules`
- [ ] Feature flags gate features without requiring an app update

---

## 8. ROUTING (GoRouter)

- [ ] Create `lib/core/router/app_router.dart` with all routes:
  - `/splash` → Rive logo reveal
  - `/login` → Login screen
  - `/register` → Register screen
  - `/onboarding/1` through `/onboarding/6`
  - `/home/dashboard` → Dashboard (shell route with bottom nav)
  - `/home/food` → Food Home
  - `/home/food/log/:mealType` → Food Log
  - `/home/food/detail/:id` → Food Detail
  - `/home/food/lab-scan` → Lab/Rx OCR scan
  - `/home/workout` → Workout Home
  - `/home/workout/:id` → Workout Detail
  - `/home/workout/:id/active` → Active Workout
  - `/home/workout/gps` → GPS Workout
  - `/home/workout/custom` → Custom Workout Builder
  - `/home/steps` → Steps Home
  - `/sleep` · `/mood` · `/habits` · `/body-metrics` · `/fasting`
  - `/blood-pressure` · `/glucose` · `/spo2`
  - `/period` · `/medication` · `/nutrition-goals`
  - `/karma` → Karma Hub
  - `/ayurveda` · `/ayurveda/dosha` · `/ayurveda/rituals` · `/ayurveda/seasonal` · `/ayurveda/herbs`
  - `/meal-planner` · `/recipe-builder`
  - `/journal` · `/mental-health`
  - `/lab-reports` · `/abha`
  - `/doctor-appointments` · `/health-reports`
  - `/personal-records`
  - `/emergency` → Emergency Card
  - `/wearables`
  - `/home/social` · `/home/social/groups`
  - `/challenges`
  - `/family`
  - `/festival-calendar` · `/festival-calendar/:festivalKey/diet`
  - `/wedding-planner/setup` (steps 1–6) · `/wedding-planner` · `/wedding-planner/event/:eventKey` · `/wedding-planner/recovery`
  - `/home-widgets`
  - `/profile` · `/settings` · `/subscription`
- [ ] Implement redirect guards: unauthenticated → `/login`, first-launch → `/onboarding/1`
- [ ] Shell route for Bottom Nav Bar (routes under `/home/*`)

---

## 9. AUTHENTICATION & ONBOARDING

### 9.1 Auth Screens

#### Splash Screen (`/splash`)
- [ ] Rive logo reveal animation (`assets/rive/logo_reveal.riv`) — Tier-gated (static image on low tier)
- [ ] Check `flutter_secure_storage` for existing session → navigate to dashboard or login
- [ ] Sub-2s cold start target

#### Login Screen (`/login`)
- [ ] Stack: `bg1` scaffold + ambient glow blob (secondary) top-right
- [ ] Glass card (surface1, radius 20px, Elevation 1): Email field + Password field (show/hide toggle)
- [ ] `[Login]` primary full-width button with glow
- [ ] "Forgot Password?" textSecondary link
- [ ] Divider "─── or ───"
- [ ] Google Sign-In glass outlined button
- [ ] Apple Sign-In glass button (iOS only)
- [ ] "New here? Register →" primary color link

#### Register Screen (`/register`)
- [ ] Same as Login + Name field + Confirm Password field
- [ ] On success → navigate to `/onboarding/1`

#### Forgot Password
- [ ] Email input + "Send Reset Link" → Appwrite `account.createRecovery()`

### 9.2 Onboarding (6 Steps)
Progress bar: segmented 6-step indicator. **Calm Zone** (no glow, no blur, minimal animation).

- [ ] **Step 1 — Name & Goals**: Text field for display name. Goal chips: `lose_weight` / `gain_muscle` / `maintain` / `endurance`
- [ ] **Step 2 — Body Stats**: Height (cm), Weight (kg), DOB date picker, Gender selector (Male/Female/Other/Prefer not to say), Blood group selector (8 options)
- [ ] **Step 3 — Activity Level**: 5 chips: Sedentary / Light / Moderate / Active / Very Active; auto-calculates TDEE using Mifflin-St Jeor equation (shown live)
- [ ] **Step 4 — Dosha Quiz**: 12-question quiz → outputs vata/pitta/kapha percentage; stores `dosha_type` on user
- [ ] **Step 5 — Health Conditions**: Multi-select chips: Diabetes / PCOD-PCOS / Hypertension / Hypothyroidism / Asthma / None. Request health permissions (step counter, HR, sleep, location) contextually here
- [ ] **Step 6 — ABHA Link (optional)**: Amber info card. 14-digit ABHA input (XX-XXXX-XXXX-XXXX format). OTP verification card slides in (spring animation). 6-digit OTP boxes. Wearable connection options (Fitbit / Garmin / Health Connect). Skip option. "+100 XP" badge on ABHA link CTA
- [ ] On completion: write user profile to Drift + Appwrite, award +50 XP, navigate to `/home/dashboard`

---

## 10. CORE FEATURE MODULES

### 10.1 Dashboard (`/home/dashboard`)

#### Dashboard Screen
- [ ] **Scaffold**: Pattern B (heroDeep gradient, 320px) + 3 ambient glow blobs (Tier-gated)
- [ ] **Hero**: Avatar (48px circle with primary ring) + "Namaste [Name] 🙏" + Hindi subtitle + Karma XP amber pill + Level badge indigo pill + `ABHALinkBadge` (if ABHA not linked)
- [ ] **Body** (overlaps hero 28px, glass rounded top, scrollable):
  - `ActivityRingsWidget` (full width): 4 concentric rings — orange(calories), green(steps), teal(water), purple(active-minutes); ring center `metricLg` value with primary glow; 4 stat labels below
  - Latest Workout card (half bento): icon + title + duration + TrendChip (▲ vs last week)
  - Sleep Recovery card (half bento): percentage `metricLg` + colored indicator + mood TrendChip
  - `InsightCard` OR `CorrelationInsightCard` (full width, max 1 per dashboard, dismissable, rateable 👍/👎)
  - "Today's Meals / आज का खाना" section: `MealTypeTabBar` (floating pill style) + `FoodItemCard` list (compact, no photo in Low Data Mode)
- [ ] `QuickLogFAB`: Fixed bottom-right, 20px from nav bar; speed-dial to: food, water, mood, workout, BP, glucose
- [ ] All data read from Drift; renders in < 1s with no network dependency

#### TDEE / Nutrition Goal Engine
- [ ] Implement Mifflin-St Jeor BMR calculation:
  - Male: `(10 × weight_kg) + (6.25 × height_cm) − (5 × age) + 5`
  - Female: `(10 × weight_kg) + (6.25 × height_cm) − (5 × age) − 161`
  - TDEE = BMR × activity factor (sedentary:1.2, light:1.375, moderate:1.55, active:1.725, very_active:1.9)
- [ ] Store TDEE in `NutritionGoals` Drift table; update on profile change
- [ ] ICMR RDA micronutrient targets for Indian population (Iron, B12, Vitamin D, Calcium)

---

### 10.2 Food Logging

#### Food Home (`/home/food`)
- [ ] **Scaffold**: Pattern A
- [ ] App bar "Food / खाना" + `MealTypeTabBar` (sticky pill tab below app bar)
- [ ] Bento grid body:
  - Macro summary (full-width glass card): 4 animated mini rings — Calories(primary), Protein(teal), Carbs(accent), Fat(purple); monoLg values
  - Micronutrient row (full width): 4 `MicronutrientBar` — Iron(teal) · B12(orange) · Vitamin D(purple) · Calcium(amber); animated fill
  - Copy Yesterday banner (amber glass, full width): shown ONLY if today's log is empty; "Copy Yesterday's Meals → X kcal" + `[Copy all]` button; calls `FoodDao.copyYesterdayMeals()`
  - Logged Meals (full width): grouped by meal type per selected tab; `FoodItemCard` compact; swipe-left → delete; empty state Lottie

#### Food Log Screen (`/home/food/log/:mealType`)
- [ ] Full-width glass search bar (bilingual placeholder "Search food / खाना खोजें"); trailing: mic icon + barcode icon
- [ ] Quick-action chip row (horizontal scroll): 📷 Scan Label, 🍽 Upload Plate, 📋 Lab/Rx Scan, ✏ Manual
- [ ] "Frequent Indian Portions" section: 2×N bento grid of `FoodItemCard` (glass, blurred photo bg, bilingual name, Indian portion, kcal, [+] button)
- [ ] "Restaurant Results" section (when restaurant searched): Swiggy/Zomato attribution pill + deep-link icon per card
- [ ] "Recent Logs" section: list + [+] re-log button
- [ ] `[Confirm Meal]` full-width primary button at bottom

#### Food Search Implementation
- [ ] Drift FTS5 search on `food_items` (< 200ms) → Appwrite fallback → OpenFoodFacts API fallback
- [ ] Barcode: `flutter_barcode_scanner` → OpenFoodFacts → cache to Drift
- [ ] OCR (label): Google ML Kit TextRecognitionV2 — on-device only
- [ ] Photo AI: Google ML Kit ObjectDetection — on-device only
- [ ] Voice: `speech_to_text` — Hindi + English → search → confirm sheet
- [ ] Copy Yesterday: `log_method: copy_yesterday`
- [ ] WhatsApp: `log_method: whatsapp` (from bot webhook)
- [ ] **log_method enum**: `search`, `barcode`, `ocr`, `voice`, `photo`, `recipe`, `planner`, `whatsapp`, `copy_yesterday`

#### Food Detail Screen (`/home/food/detail/:id`)
- [ ] **Scaffold**: Pattern B (food photo as hero bg — blurred 8px, darkness overlay 60%)
- [ ] Hero: food name `displayLg` white + Hindi name `hindi` textSecondary + kcal `metricLg` with primary glow
- [ ] Indian serving size selector: drum-roll picker (katori / piece / glass / tbsp)
- [ ] Full macro table: glass card with animated bar fills
- [ ] Micronutrient table (NEW): Iron, B12, VitD, Calcium with ICMR RDA %
- [ ] `[Add to Log]` primary full-width button

#### Lab Report / Prescription OCR Screen (`/home/food/lab-scan`)
- [ ] **Calm Zone** (no glow, no blur)
- [ ] Two glass cards side-by-side: [📷 Take Photo] [🗂 Upload PDF]
- [ ] `ShimmerLoader` during ML Kit processing
- [ ] `LabValueRow` per extracted metric: bilingual name (e.g. "Glucose (Fasting) / शर्करा") + value input + unit + classification pill (green/amber/red) + edit toggle + confirm checkbox
- [ ] `EncryptionBadge` at bottom of extracted values card
- [ ] `[Import to Health Data]` primary button — writes to appropriate Drift logs
- [ ] `[Discard]` text link (error color)
- [ ] Privacy caption: "Raw text stored locally only. Values go to your encrypted health logs."
- [ ] Classification colors: Normal=`success`glow, Borderline=`warning`glow, High/Low=`error`glow
- [ ] OCR extraction target: < 3s on real device

#### Idempotency for Food Logs
- [ ] Generate `idempotency_key = SHA-256(userId + mealType + localId + createdAt)` on every food log create

---

### 10.3 Workout System

#### Workout Home (`/home/workout`)
- [ ] **Scaffold**: Pattern A
- [ ] Streak banner (if active): full-width orangeGradient glass card + `StreakFlameWidget` (Lottie) + "🔥 Day N Streak!" `displayMd` white
- [ ] Featured workout card (full-width, Pattern B mini): workout photo hero (blurred + dark overlay) + title `displayMd` + Duration badge + Difficulty badge + `[Start]` primary button
- [ ] Category chips (horizontal scroll): Yoga · HIIT · Strength · Cardio · Dance · Bollywood · Cricket · Kabaddi · Pranayama
- [ ] WorkoutCard grid (2-column bento): glass card, blurred photo, title, duration, premium lock icon

#### Workout Detail Screen (`/home/workout/:id`)
- [ ] **Scaffold**: Pattern B (workout thumbnail as hero)
- [ ] Hero: title `displayLg` white + Duration badge + Difficulty badge + `[Start Workout]` primary CTA
- [ ] Exercise list: glass cards with Name, Sets×Reps, RPE target, Superset bracket letter (A/B/C)
- [ ] Similar workouts horizontal scroll

#### Active Workout Screen (`/home/workout/:id/active`)
- [ ] **Scaffold**: Pattern C (full-bleed immersive, bg0)
- [ ] Exercise name `h1` white centered
- [ ] Set counter `monoXL` primary glow
- [ ] Rep target `bodyLg` white
- [ ] **Rest Timer widget**: `PulseRing` countdown arc drain + configurable seconds + haptic + audio cue on completion + "Skip Rest" outlined button
- [ ] HR Zone badge from wearable (PulseRing + zone label)
- [ ] **RPE selector slider** (shown after each set): 1–10 scale, gradient fill green→amber→red, haptic per notch
- [ ] Pause · Next · Finish buttons (bottom dock, glass row)
- [ ] Auto-detect Personal Records; award +100 XP on new PR

#### GPS Workout Screen (`/home/workout/gps`)
- [ ] **Scaffold**: Pattern C
- [ ] `flutter_map` full-bleed with custom dark tile style
- [ ] `flutter_map_tile_caching` — show cached tiles when offline; first GPS workout pre-caches home region tiles
- [ ] Stats overlay glass card (bottom half): Distance `monoXL` primary + Duration + Pace `monoLg` + Avg HR `monoLg` rose + HR Zone badge `PulseRing` mini
- [ ] Offline indicator: teal glass pill "Offline Map"

#### Custom Workout Builder (`/home/workout/custom`)
- [ ] Drag-and-drop exercise list (`ReorderableListView`)
- [ ] Per-exercise glass card: name, sets/reps inputs, rest timer input, RPE input, Superset group selector (A/B/C pills), drag handle
- [ ] `[+ Add Exercise]` full-width outlined button
- [ ] `[Save Plan]` primary button

#### Workout Data
- [ ] YouTube playback via `youtube_player_flutter` (by video ID)
- [ ] 30-day and 12-week structured programs
- [ ] Karma: +20 XP per workout, +50 XP per program day, +100 XP per new PR

---

### 10.4 Step Tracking (`/home/steps`)

- [ ] **Scaffold**: Pattern B (`heroPrimary` gradient)
- [ ] **Hero**: step count `heroDisplay` (72sp) white with success glow + circular `PulseRing` (success color) + goal label + confetti Lottie on goal reached
- [ ] **Body**: hourly step bar chart (animated fill, success color) + 7-day step trend line chart (fl_chart, area fill success20) + Distance/Calories side-by-side bento cards (monoLg)
- [ ] **Adaptive goal card** (glass, teal border): shows new suggested goal based on 7-day rolling average; `[Accept ✓]` `[Keep current]` pill buttons
- [ ] **Inactivity nudge card** (amber glass): shown when >60 min inactive; "Time to move! 10-min walk? 🚶" + `[Start Walk]` teal outlined button
- [ ] Primary sensor: Health Connect (Android 14+) / HealthKit (iOS)
- [ ] Fallback: `pedometer` package
- [ ] Background: WorkManager isolate (Android) / `BGAppRefreshTask` (iOS)
- [ ] Karma: +5 XP per 1,000 steps (max 50 XP/day)
- [ ] Empty state: Lottie `empty_steps`

---

### 10.5 Karma System (`/karma`)

#### Karma Hub
- [ ] **Scaffold**: Pattern B (`heroDeep` gradient)
- [ ] **Hero**: level title `displayLg` white + `GlowingMetric` for total XP + XP progress bar (animated, primary fill, glass track) + karma coin icon with `coin_burst` Lottie on tap
- [ ] **Body**:
  - "Daily Rituals / दैनिक अनुष्ठान" section: checklist glass cards per ritual + green glow tick when complete
  - "Active Challenges / चुनौतियाँ" section: `ChallengeCarouselCard` horizontal scroll
  - "Leaderboards / लीडरबोर्ड" section: floating pill tab bar (Friends · City · National · Seasonal); top-5 list per tab with rank badge (gold/silver/bronze glow for top 3) + avatar + name + XP
  - Karma Store glass card: "Redeem XP" + reward previews + Streak Recovery amber pill

#### XP Actions (implement all)
- [ ] Log food: +10 (+30 first/day)
- [ ] Log workout: +20
- [ ] Complete program day: +50
- [ ] Log sleep: +5
- [ ] Log mood: +3
- [ ] Complete challenge: +50 to +200
- [ ] Complete onboarding: +50
- [ ] Log BP or glucose: +5
- [ ] Complete a fast: +15
- [ ] New personal record: +100
- [ ] Link ABHA account: +100 (one-time)
- [ ] Import lab report: +30
- [ ] Positive social interaction: +5
- [ ] Successful referral: +500 (referrer) / +100 (referee)
- [ ] 7-day streak multiplier: ×1.5 earn rate
- [ ] 30-day streak multiplier: ×2.0 earn rate
- [ ] Streak recovery: −50 XP (cost)

#### Level System
- [ ] 50 levels: Seedling → Warrior → Yogi → Guru → Legend tiers
- [ ] Level-up: full-screen indigo overlay + Rive `levelup.riv` + confetti Lottie + new level title `displayLg` (spring entrance) — Tier-gated
- [ ] `XPFloatAnimation`: amber `+X XP` floats 40px up + fades (500ms, `coin_burst` Lottie)

#### Karma Store
- [ ] Redeem XP for: premium workout packs, digital badges, profile themes, streak recoveries
- [ ] **Streak Recovery**: 50 XP — recovers broken streak once per habit per month

#### Leaderboards
- [ ] Friends · City · National leaderboards (weekly reset)
- [ ] Seasonal leaderboards tied to Indian festival calendar
- [ ] Targeted leaderboards: "Most Consistent Yogi", "Top Stepper in Mumbai", "Navratri Champion"

#### Achievement Badges
- [ ] 100+ achievement badges for specific milestones
- [ ] Sample: "Logged 100 workouts", "30-day streak", "Lab Report Hero", "ABHA Pioneer"
- [ ] Profile: earned badges show color icon + glow; unearned show grey icon + lock overlay

---

## 11. ADVANCED FEATURE MODULES

### 11.1 Sleep Tracker (`/sleep`)
- [ ] Manual log: `TimePicker` for bedtime/wake time + 5-emoji quality scale + notes
- [ ] Auto-sync from HealthKit / Health Connect / wearable
- [ ] **Sleep Debt card** (glass, secondary glow): cumulative weekly deficit vs 7h target — animated red deficit / green credit bars
- [ ] **Chronotype detection** (after 30+ days): Early Bird / Night Owl / Intermediate — "You're an 🦉 Night Owl" with optimal window
- [ ] Insights: weekly average vs recommended + sleep–workout correlation + sleep–mood correlation
- [ ] Ayurvedic sleep tip (glass, teal border) when avg < 6h — personalized by dosha type
- [ ] Burnout detection: sustained low mood + poor sleep + low energy over 7 days → recovery flow
- [ ] Karma: +5 XP per log
- [ ] Empty state: Lottie `empty_sleep`

### 11.2 Mood Tracker (`/mood`)
- [ ] 5-emoji selector (😡 😟 😐 😊 🤩) — selected emoji: scale pop + primary ring
- [ ] Energy slider (1–10) + Stress slider (1–10)
- [ ] Tags (glass chips): `anxious`, `calm`, `focused`, `tired`, `motivated`, `irritable`
- [ ] Optional 1-minute voice note — stored locally only, never uploaded
- [ ] Mood heatmap calendar (GitHub contribution graph style)
- [ ] Energy/stress trend line chart
- [ ] Mood–workout and mood–sleep correlation insights
- [ ] Screen time correlation (Digital Wellbeing / Screen Time data)
- [ ] Karma: +3 XP per log
- [ ] Empty state: Lottie `empty_mood`

### 11.3 Period Tracker (`/period`)
- [ ] **All data AES-256-GCM encrypted** using HKDF-derived `period` key in Drift
- [ ] Sync to Appwrite is **opt-in only** — default is local-only
- [ ] Cycle prediction: average of last 3 cycles + ovulation window estimation
- [ ] Tracked symptoms (glass chips): cramps, bloating, mood swings, headache, fatigue, spotting
- [ ] Flow intensity selector
- [ ] Workout suggestions adapt to cycle phase (menstrual / follicular / ovulatory / luteal)
- [ ] **PCOD/PCOS management mode**: irregular cycle support + specialist referral prompts + hormone-friendly workout suggestions
- [ ] Privacy guarantee: never used for ads, never shared
- [ ] Period accent color: `rose` (#FB7185)

### 11.4 Medication Reminder (`/medication`)
- [ ] Per-medication local notifications via `flutter_local_notifications`
- [ ] Refill alert: push notification 3 days before estimated refill
- [ ] Categories: Prescription · OTC · Supplement · Ayurvedic
- [ ] **Prescription OCR**: photograph prescription → ML Kit OCR → auto-populate name/dose/frequency
- [ ] **Pharmacy deep-link**: refill reminder links to 1mg/PharmEasy product page
- [ ] Active medications auto-populate Emergency Health Card
- [ ] Empty state: Lottie `empty_medication`

### 11.5 Body Measurements Tracker (`/body-metrics`)
- [ ] Track: weight, height, chest, waist, hips, arms, thighs, body fat %
- [ ] Auto-calculated: BMI, waist-to-hip ratio, waist-to-height ratio
- [ ] BMI history chart with trend lines and goal markers
- [ ] Progress photos stored locally only — never uploaded
- [ ] Before/after comparison slider widget
- [ ] Hero style: `metricLg` for weight, `monoLg` for BMI

### 11.6 Smart Habit Tracker (`/habits`)
- [ ] Preset habits: 8 glasses water, 10-min meditation, 30-min walk, read 10 pages, no sugar
- [ ] Custom habits: name, emoji icon, target count, unit, frequency (daily/weekdays/custom)
- [ ] Per-habit streak tracking with `StreakFlameWidget` (Lottie, size scales with streak count)
- [ ] **Streak Recovery button** (shown if streak broken ≤24h ago): amber outlined pill "🔥 Recover streak · 50 XP" → amber glass confirmation bottom sheet; deducts 50 XP; once per habit per month
- [ ] Weekly completion heatmap (GitHub contribution style): glass card, one row per habit; cell colors surface1 (none) → primary50 → primary100 (full)
- [ ] Streak stats: current streak vs longest streak (monoLg side-by-side glass card)
- [ ] Karma: +2 XP per completion, +10 XP for 7-day streak
- [ ] Empty state: Lottie `empty_habits`

### 11.7 Nutrition Goal Engine
- [ ] Daily nutrition ring charts (traffic-light status)
- [ ] Smart nudges: "You're 18g protein short today. Add a glass of lassi!"
- [ ] **Micronutrient tracking**: Iron · B12 · Vitamin D · Calcium with ICMR RDA targets
- [ ] **Weekly supplement gap report**: actionable report of micronutrient deficiencies
- [ ] Grocery list generator: auto-generates from nutrition goals or weekly meal plan
- [ ] IF integration: eating window logged against daily calorie budget

### 11.8 Ayurveda Personalisation Engine (`/ayurveda`)

Screens: `AyurvedaHome`, `DoshaProfile`, `DailyRituals`, `SeasonalPlan`, `HerbalRemedies`

- [ ] 12-question dosha quiz → vata/pitta/kapha % breakdown (stored in `users.dosha_type`)
- [ ] `DoshaDonutChart`: 120px animated donut + percentage legend (Vata/Pitta/Kapha)
- [ ] Daily rituals (Dinacharya) recommended by dosha + season
- [ ] Seasonal plans (Ritucharya) — food and activity adjustments per Indian season
- [ ] Herbal remedies library: ashwagandha, triphala, brahmi, turmeric with evidence-based notes
- [ ] Ayurvedic sleep tip triggered when avg sleep < 6h
- [ ] Teal accent color for Ayurveda elements

### 11.9 Family Health Profiles (`/family`)
- [ ] One family admin, up to 6 members (Family plan)
- [ ] Each member: independent Appwrite account — admin has view-only access
- [ ] Weekly step leaderboard with fun nudges
- [ ] Family challenges: 7-day step goal, water challenge, screen-free morning

### 11.10 Emergency Health Card (`/emergency`)
- [ ] **Local-only** — no Appwrite sync, accessible without network
- [ ] **Calm Zone** — no blur, no glow, no animation
- [ ] App bar: error-colored 5px top stripe
- [ ] Blood Group `metricLg` chip (ABO-color-coded: A=teal, B=purple, AB=primary, O=success, ±modifier pill)
- [ ] Allergies: error-outlined glass chips (red glow)
- [ ] Conditions: warning-outlined glass chips (amber glow)
- [ ] Medications: glass list (auto-pulled from Medication module)
- [ ] Emergency Contact glass card: name + phone + `[📞 Call Now]` full-width error button
- [ ] Doctor glass card: teal glow
- [ ] Insurance glass card: policy number + insurer name
- [ ] Bottom actions: `[Export PDF]` + `[Show QR]` → QR code bottom sheet
- [ ] Accessible via Android lock screen widget and iOS Home Screen widget
- [ ] No biometric lock override

### 11.11 Festival Fitness Calendar & Wedding Planner

#### 11.11.1 Dynamic Festival Date Engine
- [ ] Implement `FestivalDateEngine` supporting 4 calendar systems:
  - **Hindu Lunisolar**: Meeus astronomical algorithms for tithi + paksha calculation
  - **Islamic Hijri**: Umm al-Qura algorithm
  - **Gregorian Fixed/Floating**: standard dates + Easter computus
  - **Solar Fixed**: VSOP87-lite for Makar Sankranti solar ingress
  - **Nanakshahi**: Sikh calendar for Guru Nanak Jayanti, Baisakhi
- [ ] Pre-compute dates for [year-1, year, year+2]; cache in `FestivalCalendar` Drift table
- [ ] Refresh annually via WorkManager on 1 Jan
- [ ] **Fallback**: bundled static JSON lookup table (2024–2030) if algorithm fails

#### 11.11.2 Festival Database (32 festivals)
Implement all 32 festivals with: nameEn, nameHi, region relevance, calendar system, fasting type, diet plan type:
- [ ] Navratri (Chaitra & Sharadiya), Diwali, Holi, Dussehra, Janmashtami, Maha Shivaratri, Ram Navami, Hanuman Jayanti, Raksha Bandhan, Karva Chauth, Teej (Hariyali & Hartalika), Ganesh Chaturthi, Durga Puja, Chhath Puja, Makar Sankranti/Pongal, Ugadi/Gudi Padwa, Onam, Bihu, Baisakhi, Lohri, Guru Nanak Jayanti, Ramadan, Eid-ul-Fitr, Eid-ul-Adha, Christmas, Good Friday/Easter, Buddha Purnima, Navroze, Paryushana, Maha Ashtami/Navami, Republic Day, Independence Day

#### 11.11.3 Festival Diet Plan System
- [ ] Implement `FestivalDietType` enum: `nirjalaFast`, `phalaharFast`, `sattvicFast`, `jainFast`, `rozaFast`, `partialFast`, `feastMode`, `moderateIndulgence`, `communityMeal`, `noRestriction`
- [ ] `FestivalDietConfig`: allowed/forbidden food IDs, sehri/iftar times (Ramadan), calorie budget multiplier, workout intensity suppression, fast-break suggestion, insight card message
- [ ] **Navratri**: allowed foods (sabudana, kuttu, singhara, rajgira, fruits, milk, paneer, sendha namak); forbidden (wheat, rice, pulses, onion, garlic); calorie −15–20%; Garba tracker (~300–400 kcal/hr)
- [ ] **Karva Chauth**: Sargi pre-sunrise meal plan; Nirjala fast from sunrise; moonrise countdown (astronomical formula + GPS); break-fast plan (dates + water + sherbet)
- [ ] **Ramadan**: Sehri/Iftar countdown rings (GPS-computed sunset); Roza from dawn to dusk; 30-day logging heatmap

#### Festival Calendar Home (`/festival-calendar`)
- [ ] **Active Festival Banner** (shown during active festival): glass card with festival-specific gradient left border (5px); "🪔 Navratri — Day 5 of 9 · नवरात्रि"; FestivalDietBadge; [View Diet Plan] [Garba Tracker 💃] buttons; replaces InsightCard during festival
- [ ] Upcoming Festivals list (`FestivalCard` widgets): glass card, festival icon, bilingual name, date range, fasting type pill, region pill, [Set Reminder] [View Diet Plan]; swipe-left → "Hide festival"
- [ ] Region Filter chips: All · Hindu · Muslim · Sikh · Christian · Jain · Buddhist · National
- [ ] Calendar Month View (glass card): mini calendar with festival dots; tap date → scroll to festival card
- [ ] Past Festivals (collapsible glass card)
- [ ] "Plan a Wedding 💍" CTA amber glass card → `/wedding-planner/setup`

#### Festival Diet Plan Detail (`/festival-calendar/:festivalKey/diet`)
- [ ] Pattern B hero with festival-specific gradient
- [ ] Fasting Overview glass card: duration, fasting type, restrictions
- [ ] Allowed Foods grid (FoodItemCard grid filtered to allowed items; tap → food log with pre-filtered search)
- [ ] Forbidden Foods glass card: error-outlined pill list
- [ ] Meal Plan tabs (Day 1…N) per festival day
- [ ] Quick Log FAB with festival-contextual label ("Log Phalahar Meal" / "Log Sehri" / "Log Iftar")
- [ ] Festival Insight cards
- [ ] Workout Note banner (amber glass): "Reduce intensity during Nirjala fast"
- [ ] Ramadan specifics: Sehri/Iftar `PulseRing` countdowns + 30-day log heatmap
- [ ] Karva Chauth specifics: Sargi plan + Moonrise `PulseRing` + break-fast plan at moonrise

### 11.12 Wedding Planner

#### Wedding Planner Onboarding (`/wedding-planner/setup`) — 6 Steps
**Calm Zone** scaffold; segmented 6-step progress bar

- [ ] **Step 1 — Role**: 2×2 `WeddingRoleChip` grid: Bride, Groom, Guest, Relative (150×160px glass cards with illustration, spring pop on select)
- [ ] **Step 1b — Relation** (if Relative): pill chips: Father of Bride, Mother of Bride, Father of Groom, Mother of Groom, Sibling, Close Family
- [ ] **Step 2 — Dates**: two date picker cards; "Wedding Period: X – Y · N days"; amber notice if dates overlap with festival; validation: end≥start, max 14-day range
- [ ] **Step 3 — Events**: 2-column bento checkbox cards: 🟡 Haldi, 💃 Mehendi, 🎵 Sangeet, 🐴 Baraat, 💍 Vivah, 🎊 Reception
- [ ] **Step 4 — Prep Time**: horizontal scroll chips: 1 week / 2 weeks / 4 weeks / 8 weeks / Already wedding week (last option skips fitness plan → wedding-week diet)
- [ ] **Step 5 — Primary Goal** (role-aware): Bride/Groom: Look my best / Feel energised / Manage stress; Guest/Relative: Manage indulgence / Stay active / Maintain routine
- [ ] **Step 6 — Summary**: glass card recap (Role · Dates · Events · Prep · Goal); feature list; `[🚀 Start My Wedding Plan →]` primary full-width glow button

#### Wedding Planner Home (`/wedding-planner`)
- [ ] **Scaffold**: Pattern B (`heroWedding` gold gradient)
- [ ] Hero: "💍 Your Wedding Plan" `displayMd` + role + current phase + "Wedding in N days"
- [ ] Phase Progress glass card: "Pre-Wedding Week N of 4" + animated progress bar + sub-phase pill
- [ ] Today's Plan glass card (primary border glow): diet phase + Breakfast/Lunch/Dinner rows + Workout; `[Log Today's Meals]` `[Start Workout]`
- [ ] Event Countdown strip (horizontal scroll): [🟡 Haldi · Nd] [💃 Mehendi · Nd] [💍 Vivah · Nd]
- [ ] Wedding Tips `InsightCard` (amber variant, role-specific)
- [ ] Pre-Wedding Fitness Plan glass card (compact): current week schedule + `[View Full Plan →]`
- [ ] Wedding Grocery List glass card + `[Generate List]` button

#### Wedding Event Day Screen (`/wedding-planner/event/:eventKey`)
- [ ] Event card: time, duration, Energy demand badge (Low/Medium/High glow), role-specific note
- [ ] Pre-Event Meal Plan: timed meal rows (⏰ icon + time + meal + kcal) + ❌ Avoid list
- [ ] During-Event Tips: scrollable tip chip cards
- [ ] Post-Event Recovery Meal glass card + timestamp
- [ ] `[Log [Event] Meal]` primary button → food log with event tag
- [ ] Calorie Budget glass card: event-day target (monoLg) + dance burn estimate

#### Wedding Post-Event Recovery (`/wedding-planner/recovery`)
- [ ] Celebration amber glass card
- [ ] 3-Day Detox Plan timeline glass card
- [ ] Return to Normal: 5-day calorie increase chart (animated line)
- [ ] Workout plan glass card: "Walking + gentle yoga for 7 days. No high-intensity until Day 8."
- [ ] Optional social share CTA
- [ ] `[Mark Wedding as Complete]` teal outlined button → archives plan in Drift

#### Wedding–Festival Integration
- [ ] Meal Planner auto-detects active wedding events AND active festivals from Drift
- [ ] Wedding and festival plans merge gracefully when dates overlap
- [ ] Event-day meal templates surface automatically (pre-Sangeet energy meal, wedding-day no-bloat plan)

---

## 12. HEALTH MONITORING MODULES

### 12.1 Blood Pressure Tracker (`/blood-pressure`)
- [ ] **Scaffold**: Pattern B (`heroDeep`)
- [ ] **Hero**: latest reading `metricXL` white (e.g. "128/82") with neon white glow + AHA classification badge (color-coded glass pill) + Pulse `bodyOnDark` + `EncryptionBadge` (glass, teal glow)
- [ ] `BPTrendChart` glass card: 7/30/90-day toggle (pill tabs) + AHA reference bands + animated line chart
- [ ] Log BP FAB (floating primary, glow)
- [ ] Log Bottom Sheet: Systolic, Diastolic, Pulse (optional), Notes + `EncryptionBadge` + `[Save BP Reading]`
- [ ] Morning/evening reminder row (glass card)
- [ ] **AHA Classification**:
  - Normal: systolic <120 AND diastolic <80 → `success`
  - Elevated: systolic 120–129 AND diastolic <80 → `warning`
  - Stage 1: systolic 130–139 OR diastolic 80–89 → `warning`
  - Stage 2: systolic ≥140 OR diastolic ≥90 → `error`
  - Crisis: systolic >180 OR diastolic >120 → `error` (alert with emergency CTA)
- [ ] AES-256-GCM encrypt all BP fields in Drift (HKDF key: `bp`)
- [ ] Idempotency key on every BP log
- [ ] Karma: +5 XP per log
- [ ] Empty state: Lottie `empty_bp`

### 12.2 Blood Glucose Tracker (`/glucose`)
- [ ] **Scaffold**: Pattern B (`heroDeep`)
- [ ] Hero: latest value `metricXL` + reading type tag + classification badge + `EncryptionBadge`
- [ ] Reading type pills: Fasting · Post-meal · Random · Bedtime
- [ ] `GlucoseHistoryChart` glass card: target band per reading type + animated line chart
- [ ] **HbA1c estimator card** (glass, secondary glow): estimated from 90-day rolling average
- [ ] AES-256-GCM encrypt all glucose fields (HKDF key: `glucose`)
- [ ] Idempotency key on every log
- [ ] **Classification**: Normal/Prediabetic/Diabetic per reading type
- [ ] Source: manual / wearable / lab_report
- [ ] Karma: +5 XP per log
- [ ] Empty state: Lottie `empty_glucose`

### 12.3 SpO2 Tracker (`/spo2`)
- [ ] Log SpO2 % + pulse bpm
- [ ] History chart (fl_chart)
- [ ] AES-256-GCM encrypt SpO2 fields (HKDF key: `spo2`)
- [ ] Alert when SpO2 < 95% (WHO threshold)
- [ ] Source: manual / wearable / health_connect
- [ ] Teal accent color for SpO2

### 12.4 Intermittent Fasting Tracker (`/fasting`)
- [ ] Supported protocols: 16:8 · 18:6 · 5:2 · OMAD · Custom window
- [ ] Fasting timer `heroDisplay` countdown HH:MM:SS + `FastingStage` progress ring
- [ ] Implement `FastingStage` enum: `fed` (<4h), `earlyFast` (4–8h), `fatBurning` (8–12h), `ketosis` (12–16h), `deepFast` (>16h)
- [ ] **Ramadan mode**: Sehri/Iftar as fasting boundary (GPS-computed)
- [ ] Hydration alerts during fasting windows
- [ ] Streak tracking: consecutive successful fasting days
- [ ] Karma: +15 XP per completed fast

### 12.5 Chronic Disease Management
- [ ] Activate relevant modules based on `chronic_conditions` array on user profile:
  - **Diabetes mode**: Glucose tracker + Lab OCR + Carb-aware nutrition + Medication + BP
  - **PCOD/PCOS mode**: Irregular cycle support + Hormone-friendly workouts + Weight management
  - **Hypertension mode**: BP tracker + Sodium tracking + Stress management + Medication compliance
  - **Hypothyroidism mode**: Weight trend + TSH lab import + Fatigue tracking + Medication reminders
  - **Asthma mode**: SpO2 tracker + Activity intensity limits + Medication reminders

### 12.6 Doctor Appointments & Shareable Health Reports (`/doctor-appointments`)
- [ ] Track upcoming appointments with 24h reminder
- [ ] Doctor notes AES-256-GCM encrypted; prescription photos stored locally only
- [ ] **Shareable Report Link flow**:
  1. User taps "Share with Doctor"
  2. PDF generated locally via `pdf` package
  3. PDF uploaded to Appwrite Storage `health_reports_share` bucket
  4. Appwrite Function generates pre-signed URL with 7-day expiry
  5. URL written to `health_reports.share_url`
  6. User shares via WhatsApp (no doctor login required)
  7. File auto-deleted from Storage after expiry
- [ ] `HealthShareCard` (spring slide-in): "Link expires in 7 days" countdown + `[Share via WhatsApp]` green button + `[Copy Link]` + `[Delete Link]` error button
- [ ] Empty state: Lottie `empty_appointments`

---

## 13. LIFESTYLE & WELLNESS MODULES

### 13.1 Meal Planner (`/meal-planner`)
- [ ] Weekly planner: breakfast, lunch, dinner, snacks for 7 days
- [ ] AI-suggested plans via Rule Engine (TDEE + dosha + micronutrient gaps — zero server calls)
- [ ] One-tap log: log planned meal from planner directly
- [ ] Indian meal templates: North Indian, South Indian, Bengali, Gujarati, regional variants
- [ ] **Festival-aware**: auto-detects active festival from `FestivalCalendar` Drift table; applies `FestivalDietConfig`; filters allowed/forbidden foods; adjusts calorie targets; key: Navratri phalahar, Ramadan Sehri/Iftar blocks, Karva Chauth Sargi, Diwali mithai flex budget, Onam Sadhya tracker
- [ ] **Wedding-aware**: when active wedding event detected, switches to role-based wedding diet phase (pre-wedding / wedding week / post-wedding); event-day meal templates auto-surface
- [ ] Festival + Wedding plan merge gracefully when dates overlap
- [ ] **Grocery list**: auto-generates from week's plan + Swiggy/Blinkit deep-links

### 13.2 Recipe Builder (`/recipe-builder`)
- [ ] Create custom recipes: add ingredients from `food_items`, set quantities and servings
- [ ] Auto-calculates: calories, protein, carbs, fat, and micronutrients per serving
- [ ] Save → log as one food entry in one tap
- [ ] Community sharing: mark recipe as public
- [ ] Indian cuisine classifier: tag by regional cuisine
- [ ] Empty state: `empty_generic`

### 13.3 Guided Meditation & Pranayama
- [ ] Guided sessions: 5 / 10 / 15 / 20-minute bundled offline audio (`just_audio`)
- [ ] Pranayama library: Anulom Vilom · Bhramari · Kapalbhati · Bhastrika — timer-based
- [ ] Dosha-specific sessions: calming (vata) / cooling (pitta) / energising (kapha)
- [ ] **Stress mode**: quick 3-minute breathing exercise triggered when `stressLevel > 7`
- [ ] Karma: +5 XP per session, +10 XP for 7-day streak

### 13.4 Journaling (`/journal`)
- [ ] **Calm Zone** scaffold
- [ ] App bar: "Journal / जर्नल" + `EncryptionBadge` right of title
- [ ] Today's prompt card (amber glass): data-driven prompts (e.g. "You logged 'anxious' 4 times this week")
- [ ] `flutter_quill` rich text editor (full-screen glass card): Bold, Italic, Bullet, Heading toolbar
- [ ] Mood score selector: 5 emoji buttons (selected: scale pop + primary ring)
- [ ] Tags row: glass chips (Stressed · Happy · Tired · Calm…)
- [ ] **On-device sentiment analysis** (after 30+ entries): mood trajectory from tag frequency + mood scores; shown as `CorrelationInsightCard` variant; **no text sent anywhere**
- [ ] **Weekly prompt suggestions** based on logged data
- [ ] Past entries list: date + first line + mood emoji; tap → full-screen read view with slide transition
- [ ] AES-256-GCM encrypted (HKDF key: `journal`), local-only by default
- [ ] Monthly journal summary: mood trend overlay + tag word cloud

### 13.5 Mental Health & Stress Management (`/mental-health`)
- [ ] CBT Insight card (data-driven, not generic): "On days you slept <6h you logged 'irritable' — sleep may be a key lever"
- [ ] Stress programs: 7-day CBT-lite cards, progressive muscle relaxation
- [ ] Breathing exercise quick-start: animated `Rive` circle (expand/contract) + 4-7-8 / Box breathing options
- [ ] Burnout risk gauge: semicircle gauge, green→amber→red color bands
- [ ] **Burnout detection**: sustained low mood + poor sleep + low energy over 7 days → recovery flow
- [ ] **Professional help prompts**: triggered after 14 days of consistently low mood scores
- [ ] **Indian mental health helplines** (always visible glass card): iCall · Vandrevala Foundation · NIMHANS; each with `[📞 Call]` teal button

### 13.6 Personal Records Tracker (`/personal-records`)
- [ ] Auto-detection from workout logs: max lift, fastest 5K, longest run
- [ ] Manual PR entry for sports: cricket runs, kabaddi raid points, etc.
- [ ] PR celebration notification: "New PR! You lifted 80kg on Bench Press!"
- [ ] PR history chart per exercise (fl_chart trend over time)
- [ ] Karma: +100 XP for any new PR
- [ ] Empty state: Lottie `empty_records`

---

## 14. INDIA-SPECIFIC FEATURES

### 14.1 Lab Reports OCR (`/lab-reports`)
- [ ] **Calm Zone** scaffold
- [ ] Photo capture + PDF upload → Google ML Kit OCR
- [ ] Structured value extraction (Glucose Fasting, HbA1c, Hemoglobin, Cholesterol, TSH, Creatinine, etc.)
- [ ] `LabValueRow`: bilingual name + extracted value input + unit + classification pill + inline edit + confirm toggle
- [ ] User must confirm extracted values before import
- [ ] Import → auto-populate appropriate Drift logs (glucose, BP, etc.)
- [ ] `EncryptionBadge` shown throughout
- [ ] Privacy: raw OCR text stored locally only (opt-in); values go to encrypted health logs
- [ ] Karma: +30 XP per imported lab report
- [ ] Empty state: Lottie `empty_lab`

### 14.2 ABHA Integration (`/abha`)
- [ ] **Calm Zone** scaffold
- [ ] 14-digit ABHA ID input (format: XX-XXXX-XXXX-XXXX)
- [ ] OTP verification via ABDM API (Appwrite Function handles token exchange)
- [ ] 6-digit OTP input (individual boxes)
- [ ] Store `abha_id`, `abha_address`, `linked_at`, `consent_granted` in Drift `AbhaLinks`
- [ ] `ABHALinkBadge`: compact widget shown on dashboard hero and profile (amber CTA "Link now →" if not linked)
- [ ] Post-link: pull health records from ABHA with explicit user consent
- [ ] Karma: +100 XP (one-time) on successful link
- [ ] `last_sync` tracked for re-pull

### 14.3 WhatsApp Bot Logging
- [ ] **Backend**: Appwrite Function (Node.js) handles WhatsApp Cloud API webhooks
- [ ] Supported commands:
  - `"dal rice 2 katori"` → NLP food parser → reply with kcal + daily total
  - `"log mood 4"` → log mood score 4
  - `"today stats"` → reply with ring summary
- [ ] All logs written to Drift; `log_method` tagged as `whatsapp`
- [ ] Privacy: opt-in only; phone number linked with explicit consent
- [ ] Kill-switch via `RemoteConfig` (`kill.whatsapp_bot`)

### 14.4 Referral & Invite Program
- [ ] Unique referral code generated at registration (`users.referral_code`)
- [ ] Track `referred_by` on new signups
- [ ] Referrer earns +500 XP when referred user completes onboarding
- [ ] Referred user earns +100 XP on signup
- [ ] Share via: WhatsApp (primary CTA) · Instagram · Copy link
- [ ] Referral leaderboard in Karma Hub

### 14.5 Swiggy / Zomato Restaurant Calories
- [ ] Community-seeded restaurant menu data in `food_items` (`source: restaurant`)
- [ ] `swiggy_item_id` + `zomato_item_id` fields for deep-links
- [ ] Swiggy/Zomato attribution pill with brand colors on food cards
- [ ] "Restaurant Results" section in Food Log search

### 14.6 UPI Deep-Links
- [ ] Subscription payment: `[Pay via UPI]` button on subscription plans
- [ ] `url_launcher` for UPI intent URL

---

## 15. SOCIAL & COMMUNITY MODULES

### 15.1 Social Feed (`/home/social`)
- [ ] Stories row: horizontal scroll, 48px avatar circles; active story: primary ring glow + pulsing; viewed: dimmed
- [ ] Post cards (glass, full-width): avatar + name + timestamp + content + media (hidden in Low Data Mode) + likes/comments
- [ ] **Social Karma** indicator: "+5 XP" amber text float animation on post receiving a like
- [ ] Create post FAB (primary, glowing)
- [ ] Follow system + verified badge for nutritionists/trainers
- [ ] Low Data Mode: text-only cards, no media
- [ ] Empty state: Lottie `empty_social`

### 15.2 Community Groups (`/home/social/groups`)
- [ ] Create or join topic-based groups: Keto Indians · Mumbai Runners · Diabetics Support
- [ ] Group types: diet / location / sport / challenge / support
- [ ] Group challenges: admin-created + shared leaderboard
- [ ] **Team vs Team challenges**: two groups compete on shared metric (steps, workouts)
- [ ] **Region vs Region**: city-level leaderboard challenges ("Mumbai vs Delhi 7-day steps")
- [ ] Direct messaging (DMs): one-to-one within community connections

### 15.3 Challenges (`/challenges`)
- [ ] Browse and join challenges with start/end dates
- [ ] Festival-tagged challenges get festival-color border
- [ ] Karma: +50 to +200 XP per completion
- [ ] Empty state: Lottie `empty_challenges`

---

## 16. PLATFORM & INFRASTRUCTURE MODULES

### 16.1 Automated Health Reports (`/health-reports`)
- [ ] Weekly (Sunday night) and monthly (month-end) auto-generation via WorkManager
- [ ] Report contents: Steps trend · Calorie balance · Sleep quality · Mood trend · BP/Glucose (if tracked) · Workout frequency · Karma earned · Micronutrient gaps
- [ ] PDF generated locally via `pdf` package (target: < 3s for 30-day report)
- [ ] Never uploaded automatically
- [ ] Shareable doctor link (see §12.6)
- [ ] Screen: period tabs (Weekly/Monthly) + most recent report card + past reports list
- [ ] Empty state: `empty_generic`

### 16.2 Wearable Device Integration (`/wearables`)
- [ ] **Health Connect** (Android 14+): Steps, sleep, HR, SpO2, BP — `health` package
- [ ] **HealthKit** (iOS): Steps, sleep, HR, SpO2, BP — `health` package
- [ ] **Fitbit**: Steps, sleep, HR, SpO2 — Fitbit Web API via OAuth2; token exchange in Appwrite Function
- [ ] **Garmin**: Steps, sleep, HR, GPS workouts — Garmin Connect IQ; token exchange in Appwrite Function
- [ ] **Mi Band / Xiaomi**: Steps, sleep, HR — Health Connect bridge
- [ ] **boAt (Wear OS)**: Steps, HR — Health Connect bridge
- [ ] Sync on app resume + every 15 min background (6h in Low Data Mode)
- [ ] Connected device glass cards: device logo + name + last sync time + sync status pill

#### Wear OS Companion App
- [ ] Watch face complication: step ring progress + HR zone badge
- [ ] Tile — Activity: Step ring, calories ring, water counter
- [ ] Tile — Water: tap `+1 glass` → writes to Wear DataMap → phone syncs to Drift (debounced 5s)
- [ ] Tile — Workout: start/stop GPS workout + live HR zone
- [ ] `ChannelClient` for workout events + `DataClient` for background stat updates

#### watchOS Companion App
- [ ] Complication: step ring progress (Circular Small / Modular Small)
- [ ] Widget — Water: tap +1 glass via `WCSession.sendMessage`
- [ ] Widget — Workout: start/stop with live HR from HealthKit
- [ ] `WCSession.transferUserInfo` for background push; `sendMessage` for real-time workout

### 16.3 Android & iOS Home Screen Widgets
- [ ] **Activity Rings** (4×1): Steps, calories, water, active minutes rings
- [ ] **Quick Log** (2×1): button that deep-links to food log sheet
- [ ] **Water Counter** (2×2): tap to increment water; shows today's total
- [ ] **Emergency Card** (Lock screen): blood group + emergency contact
- [ ] **Festival/Wedding Countdown** (2×2): updates daily from Drift
- [ ] Android: WorkManager background task; iOS: WidgetKit timeline
- [ ] Widget data read exclusively from Drift — no network requests
- [ ] Widget Configuration Screen (`/home-widgets`): phone mockup preview (60% scale), live updates; [Add to Home Screen] per widget; how-to instructions collapsible card

### 16.4 Push Notifications
- [ ] FCM token only via `firebase_messaging` (no other Firebase SDK)
- [ ] Appwrite Function hook on user create → store FCM token
- [ ] Per-module local notifications (settings-controlled):
  - Meal reminders (breakfast/lunch/dinner)
  - Step nudges (inactivity > 60 min)
  - BP/Glucose reminders (morning/evening)
  - Lab report reminder
  - Social activity
  - Challenges
  - Morning briefing (daily: calorie goal, fasting window, weather plan)
- [ ] Medication refill alert: 3 days before estimated refill
- [ ] PR notification
- [ ] Doctor appointment: 24h reminder

---

## 17. SHARED COMPONENT LIBRARY (`lib/shared/widgets/`)

### Core Layout Components
- [ ] **`BentoCard`**: sizes `full`/`half`/`third`/`twoThird`/`quarter`; `_resolvedSize()` auto-promotes cells < 80dp on 360dp screens (quarter→third, third→half)
- [ ] **`GlassCard`**: `ClipRRect + BackdropFilter(12px) + Container(glass bg + glassBorder)`; Tier-gated; light-mode glass variant; Light mode max blur 12px (never 20px)
- [ ] **`ScaffoldPatternA`**: standard bg1 + transparent elevated AppBar + 20px horizontal padding
- [ ] **`ScaffoldPatternB`**: hero gradient (320px) + ambient blobs + transparent AppBar + overlapping body (28px, radiusXl clip)
- [ ] **`ScaffoldPatternC`**: full-bleed immersive, no AppBar, white system icons

### Navigation Components
- [ ] **`BottomNavBar`**: floating pill (glass, surface1+blur 16px, radiusFull, height 64px, margin 12px from safe area, 16px horizontal): 5 tabs (Home/Food/Workout/Steps/Me); active tab: icon + label + primary color + soft glow (Tier-gated); inactive: icon only, textMuted; active indicator: primaryMuted pill
- [ ] **`UXStage.firstWeek`** mode: all 5 tabs show labels for first 7 days; one-time long-press tooltip per tab (day 0 only)
- [ ] **`QuickLogFAB`**: primary speed-dial; radial sub-buttons for food, water, mood, workout, BP, glucose

### Data Display Components
- [ ] **`ActivityRingsWidget`**: 4 concentric rings (orange/green/teal/purple); neon glow; center `GlowingMetric`; animated arc draw (600ms easeOutCubic); ring track = `divider` dark
- [ ] **`GlowingMetric`**: metric number with text shadow glow `0 0 20px {colorGlow}, 0 0 40px {colorGlow}40`
- [ ] **`TrendChip`**: ▲ rising / ▼ falling / → stable; color-coded
- [ ] **`PulseRing`**: animated arc drain for timers + HR zone badge
- [ ] **`MicronutrientBar`**: labeled progress bar with animated fill + RDA % + color-coded (teal/orange/purple/amber)
- [ ] **`DoshaDonutChart`**: segment proportions for all dosha combinations; animated draw on enter
- [ ] **`BPTrendChart`**: line chart with AHA reference bands; 7/30/90-day toggle
- [ ] **`GlucoseHistoryChart`**: line chart with target bands per reading type
- [ ] **`CountUp`**: per-digit spring animation (400ms standard spring) — Tier-gated
- [ ] **`MoodEmojiSelector`**: 5 emoji tap selection (scale pop + primary ring) + sliders

### Gamification Components
- [ ] **`StreakFlameWidget`**: Lottie `streak_fire.json`; size scales with streak count
- [ ] **`KarmaLevelCard`**: compact + full variants; XP progress bar (animated, primary fill, glass track)
- [ ] **`ChallengeCarouselCard`**: horizontal scroll; festival-tagged challenges get festival-color border
- [ ] **`XPFloatAnimation`**: amber `+N XP` text + `coin_burst` Lottie; floats 40px up, fades (500ms)

### India-Specific Components
- [ ] **`BilingualLabel`**: English `h3` + Hindi `hindi` (11sp) sub-label; left: 3×18px primary accent bar; optional "See all →" right; applied strategically (see §12.1 rules)
- [ ] **`EncryptionBadge`**: glass, teal glow; "AES-256 Encrypted" with lock icon; shown on all sensitive data screens
- [ ] **`ABHALinkBadge`**: compact amber pill (not linked) / green pill (linked); shown on dashboard hero + profile
- [ ] **`FestivalDietBadge`**: festival-colored pill showing fasting type
- [ ] **`FoodItemCard`**: food photo (blurred bg), bilingual name, Indian portion, kcal, [+] button; Low Data Mode: emoji placeholder
- [ ] **`LabValueRow`**: bilingual metric name + extracted value input + unit + classification pill (success/warning/error glow) + ✏ inline edit + ☑ confirm toggle
- [ ] **`WeddingRoleChip`**: 150×160px glass card + illustration + spring pop on select

### Feedback Components
- [ ] **`InsightCard`**: amber glass; dismissable; 👍/👎 rating; slide-up + fade entrance (350ms standard spring)
- [ ] **`CorrelationInsightCard`**: glass with secondary border glow; module pills that link to respective modules; `🔗` emoji header; 👍/👎 rating
- [ ] **`ShimmerLoader`**: pulsing glass card during loading states
- [ ] **`ErrorRetryWidget`**: Lottie `error_state.json` + retry button
- [ ] **`EmptyStateWidget`**: correct `empty_{context}.json` Lottie per screen + fallback text (see §4.3a of UI doc for full mapping); fallback: `empty_generic.json`
- [ ] **`HomeWidgetPreview`**: phone mockup SVG rendering all 3 widget sizes (60% scale, live update)

### Form Components
- [ ] **`LogBottomSheet`**: standard structure — drag handle (40×4px, divider, 12px top, spring bounce) + `BilingualLabel` title + `EncryptionBadge` (sensitive) + glass form fields (focus: primary glow border `0 0 0 4px primaryMuted`) + full-width primary CTA + haptic + CountUp on success
- [ ] **`IndianServingSizePicker`**: drum-roll picker (katori / piece / glass / tbsp / custom)
- [ ] Custom pill toggle (not Material Switch): spring animation, primary fill when ON

### Sync Status Components
- [ ] **Offline banner**: teal glass pill "Offline — changes saved locally" (non-blocking toast)
- [ ] **Low Data Mode banner**: persistent teal glass pill at top of scaffold
- [ ] **DLQ warning banner**: amber glass top banner when `syncDeadLetterCount > 0`; "⚠ N items failed to sync. Tap to review." → Settings → Data & Sync

---

## 18. SCREEN-BY-SCREEN IMPLEMENTATION CHECKLIST

### Onboarding & Auth (7 screens)
- [ ] Splash Screen
- [ ] Login Screen
- [ ] Register Screen
- [ ] Forgot Password Screen
- [ ] Onboarding Step 1 (Name + Goals)
- [ ] Onboarding Step 2 (Body Stats)
- [ ] Onboarding Step 3 (Activity Level)
- [ ] Onboarding Step 4 (Dosha Quiz — 12 questions)
- [ ] Onboarding Step 5 (Health Conditions + Permissions)
- [ ] Onboarding Step 6 (ABHA Link + Wearable)

### Core (7 screens)
- [ ] Dashboard
- [ ] Karma Hub
- [ ] Profile Screen (Pattern B hero + DoshaDonutChart + Achievements bento + Referral card)
- [ ] Settings Screen (Calm Zone, 8 sections, grouped glass cards, custom pill toggles)
- [ ] Subscription Plans Screen (Calm Zone; ₹99/₹249/₹899/₹1499 plan cards)
- [ ] Home Widgets Config Screen
- [ ] Emergency Health Card (Calm Zone, error AppBar stripe)

### Food & Nutrition (5 screens)
- [ ] Food Home
- [ ] Food Log Screen (with all 5 log methods)
- [ ] Food Detail Screen
- [ ] Lab Report / Rx OCR Screen (Calm Zone)
- [ ] Nutrition Goals Screen

### Workout (5 screens)
- [ ] Workout Home
- [ ] Workout Detail
- [ ] Active Workout Screen
- [ ] GPS Workout Screen
- [ ] Custom Workout Builder

### Steps & Activity (1 screen)
- [ ] Steps Home

### Health Monitoring (6 screens)
- [ ] Blood Pressure Tracker (Calm Zone hero exception for EncryptionBadge)
- [ ] Blood Glucose Tracker
- [ ] SpO2 Tracker
- [ ] Intermittent Fasting Tracker
- [ ] Sleep Tracker
- [ ] Body Measurements Tracker

### Lifestyle Trackers (4 screens)
- [ ] Mood Tracker
- [ ] Habit Tracker
- [ ] Period Tracker
- [ ] Medication Reminder

### Wellness (4 screens)
- [ ] Meal Planner
- [ ] Recipe Builder
- [ ] Journaling (Calm Zone)
- [ ] Mental Health Hub

### Health Records (4 screens, all Calm Zone)
- [ ] Lab Reports Home
- [ ] ABHA Account Screen
- [ ] Doctor Appointments
- [ ] Health Reports

### Social & Community (3 screens)
- [ ] Social Feed
- [ ] Community Groups
- [ ] Challenges

### Advanced (5 screens)
- [ ] Personal Records
- [ ] Ayurveda Home + 4 sub-screens (DoshaProfile, DailyRituals, SeasonalPlan, HerbalRemedies)
- [ ] Family Health
- [ ] Wearable Connections

### Festival & Wedding (7 screens)
- [ ] Festival Calendar Home
- [ ] Festival Diet Plan Detail
- [ ] Wedding Planner Onboarding (Steps 1–6)
- [ ] Wedding Planner Home
- [ ] Wedding Event Day Screen
- [ ] Wedding Post-Event Recovery

---

## 19. STATE MANAGEMENT (Riverpod)

- [ ] All state via `riverpod_annotation` + code generation (`build_runner`)
- [ ] `AsyncValue` handling mandatory on ALL `FutureProvider` / `StreamProvider` widgets (loading / error / data states)
- [ ] `setState` is **never** used for business logic
- [ ] All models are immutable (`final` fields + `copyWith`)
- [ ] Named constructors mandatory: `Model.fromAppwrite()`, `Model.fromDrift()`
- [ ] `keepAlive: false` on all feature-screen providers (dispose on exit)
- [ ] Root-level providers (initialised at app start): `DeviceTierProvider`, `ConnectivityProvider`, `RemoteConfigProvider`, `UXStageProvider`, `AuthStateProvider`

### Key Providers
- [ ] `authStateProvider` — auth state stream (Riverpod `StreamProvider`)
- [ ] `deviceTierProvider` — device tier detection
- [ ] `connectivityProvider` — online/offline state
- [ ] `remoteConfigProvider` — remote config with Drift cache
- [ ] `uxStageProvider` — first-week vs established user state
- [ ] `syncEngineProvider` — sync queue management + DLQ count
- [ ] `dashboardProvider` — dashboard data from Drift (Drift stream → zero-latency)
- [ ] `nutritionGoalsProvider` — TDEE + macro goals
- [ ] `karmaProvider` — XP balance + level + transaction history
- [ ] `foodLogProvider(date, mealType)` — food logs by date+meal
- [ ] `festivalCalendarProvider` — upcoming + active festivals from Drift
- [ ] `weddingPlanProvider` — active wedding plan + current phase
- [ ] `insightEngineProvider` — on-device rule engine

---

## 20. ON-DEVICE INSIGHT ENGINE

- [ ] Implement Rule Engine (`lib/features/insights/domain/`) — zero server calls
- [ ] **Cross-module correlation queries** (Drift JOIN queries):
  - `getSleepMoodCorrelation()`: JOIN `sleep_logs` + `mood_logs` on date
  - `getWorkoutMoodCorrelation()`: JOIN `workout_logs` + `mood_logs`
  - `getNutritionEnergyCorrelation()`: JOIN `food_logs` + `mood_logs` (energy)
- [ ] **Rule types**:
  - Nutrition nudges: "You're 18g protein short. Add a glass of lassi!"
  - Sleep insights: avg hours vs recommended
  - Step goal adaptive adjustments
  - BP/Glucose trend alerts
  - Micronutrient gap report (weekly)
  - HbA1c estimation (90-day rolling)
  - Chronotype detection (after 30+ days sleep data)
  - Burnout detection (sustained low mood + poor sleep + low energy 7 days)
  - Streak recovery prompt (broken ≤24h ago)
- [ ] Max 2 insight cards per day on dashboard; dismissable + rateable
- [ ] Insight cards animate in: slide-up 16px + fade (350ms standard spring)
- [ ] **Server-delivered rules**: via `RemoteConfig` `insight.server_rules` key — override/extend local rules without app update

---

## 21. MONETIZATION & SUBSCRIPTIONS

### Razorpay Integration
- [ ] `razorpay_flutter` SDK for payment processing
- [ ] Plans: Monthly ₹99 · Quarterly ₹249 · Yearly ₹899 · Family ₹1,499
- [ ] "Most Popular" badge on Quarterly (secondary glow); "Best Value" amber ribbon on Yearly
- [ ] `[Pay via UPI]` secondary outlined button on each plan card
- [ ] Razorpay webhook → Appwrite Function → update `subscriptions` collection
- [ ] `[Restore purchase]` text button
- [ ] 7-day free trial

### Feature Gating
- [ ] `subscription_tier` on user: `free` / `premium` / `family`
- [ ] Premium lock icon on locked workout cards
- [ ] `RemoteConfig` feature flags for premium feature access
- [ ] Family plan: up to 6 member profiles

---

## 22. ACCESSIBILITY & LOCALIZATION

### Accessibility
- [ ] Minimum tap target: 44×44px for ALL interactive elements
- [ ] Color contrast: WCAG AA (4.5:1 minimum) for all text
- [ ] `textMuted` rule: **ONLY** for decorative/placeholder text; never for informational text
- [ ] Glow effects are supplementary — never sole conveyor of meaning
- [ ] All `IconButton` widgets have `Semantics` labels
- [ ] All images have `Semantics` descriptions
- [ ] Glass cards have `Semantics(container: true)`
- [ ] Font scaling: all text respects system font size settings; no hardcoded `textScaleFactor`
- [ ] **Dyslexia-friendly font**: toggle in Settings → Preferences → switches body to OpenDyslexic (bundled asset); does NOT affect metric/mono fonts
- [ ] **High contrast mode**: black/white + orange accents only; zero gradients; zero glass blur
- [ ] Motion reduce: all springs → cross-fade when `AccessibilityFeatures.disableAnimations`
- [ ] Dark mode ring track: `divider` dark — not invisible black-on-black
- [ ] Amber/warning in dark mode: `#FFD54F` (lightened) for 4.5:1 contrast minimum

### Bilingual (Strategic Application Only)
Apply bilingual labels **only** to:
- [ ] Bottom nav labels (active tab): English 10sp SemiBold + Hindi 9sp Regular below
- [ ] Screen app bar titles: English `h1` + Hindi `hindi` sub-label (smaller, muted)
- [ ] Section headers (via `BilingualLabel` component)
- [ ] Food names in food cards: English name + `name_local` Devanagari (smaller)
- [ ] Search bar placeholder: bilingual
- [ ] Lab value names: English + common Hindi term (e.g. "Glucose / शर्करा")
- [ ] Onboarding screen titles
- [ ] Festival card names

**Do NOT** apply bilingual to: CTA buttons, metric values/numbers, chart axis labels, settings row labels, chip/pill filters, error messages, badge text, timestamps

### Localization
- [ ] `l10n` support for 22 Indian regional language codes (stored in `users.language`)
- [ ] Noto Sans Devanagari for Hindi script rendering

### Low Data Mode
- [ ] All `Image.network` → color placeholder squares (dark: `#2C2C3E`, light: `#EEE8E4`)
- [ ] Social feed: text-only glass cards
- [ ] Food cards: emoji placeholder instead of photo
- [ ] No video thumbnails in workout grid
- [ ] Lab Report OCR: still works (on-device, no network needed)
- [ ] Backdrop blur: **disabled** in Low Data Mode (glass cards fall back to `surface1` solid)
- [ ] Persistent teal glass pill "Low Data Mode" at top of scaffold

---

## 23. TESTING STRATEGY

### Unit Tests
- [ ] TDEE calculation (Mifflin-St Jeor) for both genders across edge cases
- [ ] AHA blood pressure classification boundaries (all 5 categories)
- [ ] Glucose classification (normal/prediabetic/diabetic per reading type)
- [ ] Karma XP calculation with multipliers (7-day ×1.5, 30-day ×2.0)
- [ ] Festival date computation for all 4 calendar systems (≥5 festivals per system)
- [ ] HbA1c rolling average estimation
- [ ] Fasting stage progression from elapsed duration
- [ ] Insight rule triggers (nutrition nudge, sleep alert, burnout detection)
- [ ] `_resolvedSize()` bento min-cell-width guard (360dp, 375dp, 411dp screen widths)
- [ ] Streak recovery eligibility check
- [ ] Food idempotency key generation (SHA-256 uniqueness)

### Widget Tests
- [ ] `ActivityRingsWidget`: 4 rings rendered, values match data, glow Tier-gated
- [ ] `BentoCard` sizes auto-promote on 360dp screen
- [ ] `BottomNavBar` shows all labels in `UXStage.firstWeek`, active label only after
- [ ] `GlassCard` BackdropFilter present (mid/high tier), absent (low tier)
- [ ] `DoshaDonutChart` renders correct segment proportions
- [ ] `ShimmerLoader` and `ErrorRetryWidget` async state rendering
- [ ] `MoodEmojiSelector` tap selection + slider interactions
- [ ] `CorrelationInsightCard` renders with multi-module data links
- [ ] `HomeWidgetPreview` renders all 3 widget sizes

### Integration Tests
- [ ] Full food log flow: search → select → confirm → verify Drift write → verify sync queue entry
- [ ] **Idempotency**: retry failed sync write → verify only one Appwrite document created
- [ ] Offline → online sync: log items offline, restore connectivity, verify Appwrite doc created, DLQ not triggered
- [ ] Dead-letter queue: mock 6 consecutive failures → verify item in DLQ, user notified
- [ ] Auth flow: register → onboarding → dashboard loads from Drift
- [ ] Period encryption: log entry → read back → verify decryption → verify raw DB bytes are not plaintext
- [ ] **HKDF isolation**: compromise journal key → verify BP data inaccessible
- [ ] BP log flow: log → AES encryption → correct AHA classification displayed
- [ ] Lab report OCR: sample pathology image → verify extracted values → verify glucose log auto-populated
- [ ] Fasting flow: start → advance time → eat → verify completion + XP awarded
- [ ] Referral flow: generate code → sign up with code → verify XP both parties
- [ ] Cross-module correlation: insert sleep + mood logs → verify `getSleepMoodCorrelation()` result

### Performance Benchmarks
- [ ] Dashboard cold start < 2s on 3 GB RAM device
- [ ] Drift FTS5 food search < 200ms against 10,000-item database
- [ ] Sync queue flush: 20 records < 5s on 3G connection
- [ ] PDF report generation < 3s for 30-day report
- [ ] BP/Glucose chart render < 300ms with 90 data points
- [ ] Lab OCR extraction < 3s on real device
- [ ] App bundle APK < 50 MB (enforced in CI/CD)
- [ ] Dashboard render < 1s (Drift only, no network dependency)

---

## 24. CI/CD PIPELINE

### GitHub Actions Workflows
- [ ] `ci.yml` — triggered on push to `main`/`develop`, PR to `main`:
  1. `flutter pub get`
  2. `dart fix --apply`
  3. `flutter analyze --fatal-infos`
  4. `flutter test --coverage`
  5. Upload coverage to Codecov

- [ ] `check_app_size` job (runs after `ci`): `flutter build apk --split-per-abi --dart-define-from-file=.env.staging` → assert arm64 APK ≤ 50 MB; fail CI if exceeded

- [ ] `build_android` job (main branch only): `flutter build appbundle --dart-define-from-file=.env.prod`

- [ ] `build_ios` job (main branch only, `macos-latest`): import codesign certs + provisioning profiles; `flutter build ipa --dart-define-from-file=.env.prod`

- [ ] `deploy_staging` job (develop branch only):
  ```yaml
  - run: npm install -g appwrite-cli
  - run: appwrite client --endpoint ${{ secrets.APPWRITE_STAGING_ENDPOINT }} --project-id ${{ secrets.APPWRITE_STAGING_PROJECT_ID }} --key ${{ secrets.APPWRITE_STAGING_API_KEY }}
  # Deploy everything inside appwrite/staging/ (databases, buckets, functions)
  - run: cd appwrite/staging && appwrite deploy --all --force
  ```

- [ ] `deploy_production` job (main branch only, requires manual approval gate):
  ```yaml
  - run: npm install -g appwrite-cli
  - run: appwrite client --endpoint ${{ secrets.APPWRITE_PROD_ENDPOINT }} --project-id ${{ secrets.APPWRITE_PROD_PROJECT_ID }} --key ${{ secrets.APPWRITE_PROD_API_KEY }}
  # Deploy everything inside appwrite/production/ (databases, buckets, functions)
  - run: cd appwrite/production && appwrite deploy --all --force
  ```

- [ ] **Schema sync guard**: add a step in CI that diffs `appwrite/staging/databases/` vs `appwrite/production/databases/` and fails the build if they diverge — prevents staging-only schema changes from being forgotten

### Required GitHub Secrets

| Secret | Used by |
|---|---|
| `APPWRITE_STAGING_ENDPOINT` | deploy_staging |
| `APPWRITE_STAGING_PROJECT_ID` | deploy_staging + Flutter .env.staging |
| `APPWRITE_STAGING_DATABASE_ID` | Flutter .env.staging |
| `APPWRITE_STAGING_API_KEY` | deploy_staging CLI auth |
| `APPWRITE_PROD_ENDPOINT` | deploy_production |
| `APPWRITE_PROD_PROJECT_ID` | deploy_production + Flutter .env.prod |
| `APPWRITE_PROD_DATABASE_ID` | Flutter .env.prod |
| `APPWRITE_PROD_API_KEY` | deploy_production CLI auth (server-side only) |
| `RAZORPAY_KEY_ID` | Flutter .env.prod build |
| `FITBIT_CLIENT_ID` | Flutter .env.prod build |
| `IOS_DIST_CERT_P12` | build_ios |
| `IOS_DIST_CERT_PASSWORD` | build_ios |
| `APPSTORE_ISSUER_ID` | build_ios |
| `APPSTORE_KEY_ID` | build_ios |
| `APPSTORE_PRIVATE_KEY` | build_ios |

> All other secrets (Razorpay secret, FCM server key, ABDM client secret, Fitbit client secret, Garmin consumer secret, WhatsApp access token) are set **directly as Appwrite Function environment variables** in each project — never in GitHub Secrets or bundled in the Flutter app.

### Disaster Recovery
- [ ] Daily backup cron at 02:00 IST: Appwrite databases export from **both** staging and production → Backblaze B2 (separate prefixes: `b2:fitkarma-backups/staging/` and `b2:fitkarma-backups/production/`)
- [ ] 30 daily + 12 monthly backup retention per environment
- [ ] Monthly restore drill using staging backup into a temporary Appwrite project

---

## 25. CODING STANDARDS ENFORCEMENT

- [ ] **Riverpod only** — `setState` forbidden for business logic
- [ ] **Immutable models** — all `final` fields + `copyWith`
- [ ] **Named constructors**: `Model.fromAppwrite()` + `Model.fromDrift()`
- [ ] **`AsyncValue` mandatory** on all async providers
- [ ] **`const` constructors** on every widget/model where possible
- [ ] **Build method limit**: 80 lines max — extract sub-widgets
- [ ] **No `var`** for non-obvious types
- [ ] **Drift is the only approved local storage** — no ad-hoc key-value for structured data
- [ ] **`dio` is primary HTTP client** — `http` package used only as transitive dependency, never directly
- [ ] File naming conventions:
  - Screens: `snake_case_screen.dart`
  - Widgets: `snake_case_card.dart` / `_widget.dart`
  - Providers: `feature_providers.dart`
  - Models: `feature_model.dart`
  - Appwrite service: `feature_aw_service.dart`
  - Drift service: `feature_drift_service.dart`
  - Repository: `feature_repository.dart`
  - Insight rules: `domain_rules.dart`

### Commit Message Format (Conventional Commits)
```
feat(food):      add copy yesterday's meals
fix(sync):       prevent duplicate writes with idempotency keys
perf(search):    add FTS5 virtual table and BM25 ranking
security(keys):  implement HKDF per-data-class key derivation
test(encryption):add HKDF isolation integration test
chore(deps):     bump appwrite SDK to 13.x
```

---

## 26. ENVIRONMENT CONFIGURATION

- [ ] Two Flutter env files at project root: `.env.staging` and `.env.prod` — both gitignored
- [ ] `flutter_dotenv` loads the correct file at startup based on build flavor
- [ ] All env vars injected via `--dart-define-from-file=.env.staging` (staging) or `--dart-define-from-file=.env.prod` (production) in build commands
- [ ] `AW` constants class uses `String.fromEnvironment()` for all Appwrite IDs — never hardcoded
- [ ] **Flutter `.env` contains only client-safe values**: Appwrite endpoint, project ID, database ID, Razorpay publishable key ID, Fitbit client ID, Sentry DSN, APPWRITE_CERT_FINGERPRINT
- [ ] **All secrets stay server-side** as Appwrite Function environment variables in each project (Razorpay secret, FCM server key, ABDM client secret, Fitbit client secret, Garmin consumer secret, WhatsApp access token) — never in the Flutter app or `.env` files
- [ ] Appwrite CLI auth credentials (`APPWRITE_API_KEY`) are CI/CD secrets only — never in app or `.env`

```
# .env.staging
APPWRITE_ENDPOINT=https://cloud.appwrite.io/v1
APPWRITE_PROJECT_ID=<staging_project_id>
APPWRITE_DATABASE_ID=<staging_database_id>
YOUTUBE_API_KEY=<key>
RAZORPAY_KEY_ID=rzp_test_xxxxxxxxxxxx
FITBIT_CLIENT_ID=<staging_fitbit_id>
SENTRY_DSN=https://xxx@sentry.io/xxx
APPWRITE_CERT_FINGERPRINT=sha256/<staging_fingerprint>

# .env.prod
APPWRITE_ENDPOINT=https://cloud.appwrite.io/v1
APPWRITE_PROJECT_ID=<prod_project_id>
APPWRITE_DATABASE_ID=<prod_database_id>
YOUTUBE_API_KEY=<key>
RAZORPAY_KEY_ID=rzp_live_xxxxxxxxxxxx
FITBIT_CLIENT_ID=<prod_fitbit_id>
SENTRY_DSN=https://xxx@sentry.io/xxx
APPWRITE_CERT_FINGERPRINT=sha256/<prod_fingerprint>
```

---

## 27. ADMIN DASHBOARD

- [ ] Internal web app: Appwrite Console + custom Appwrite Functions
- [ ] Content management: add/edit workout videos, seed food items, create challenges
- [ ] User management: engagement stats, subscription management, Razorpay refund processing
- [ ] Monitoring: Appwrite Console metrics + Sentry dashboard
- [ ] **Feature flags**: managed via `remote_config` collection — toggle any feature, update insight rules, control A/B rollouts, kill-switches

---

## 28. IMPLEMENTATION ORDER (RECOMMENDED)

### Phase 1 — Foundation (Weeks 1–2)
1. Project bootstrap + pubspec + folder structure
2. Design token system + ThemeData (dark + light)
3. Typography + spring presets
4. Device tier detection
5. Drift database schema + all table definitions
6. Security: HKDF KeyManager + EncryptionService
7. Appwrite client + AW constants
8. GoRouter setup
9. Auth screens (Login + Register + Splash)

### Phase 2 — Core Loop (Weeks 3–5)
10. Onboarding (all 6 steps)
11. Dashboard (Drift-first, all widgets)
12. Food Logging (search + barcode + manual)
13. Shared components (BentoCard, GlassCard, ActivityRings, BilingualLabel)
14. Bottom Navigation Bar
15. Karma system (XP + levels)
16. Sync engine + idempotency + DLQ

### Phase 3 — Health Modules (Weeks 6–8)
17. Steps tracking (Health Connect + fallback)
18. Sleep tracker
19. Mood tracker
20. Blood Pressure tracker (with AES encryption)
21. Glucose tracker
22. Habit tracker
23. Body measurements

### Phase 4 — Advanced Modules (Weeks 9–11)
24. Meal planner + Recipe builder
25. Intermittent fasting
26. Period tracker (AES encrypted)
27. Medication reminders
28. Journaling (AES encrypted)
29. Ayurveda engine + dosha quiz

### Phase 5 — India-Specific (Weeks 12–13)
30. Festival Calendar + Dynamic date engine (all 32 festivals)
31. Festival diet plan system
32. Wedding Planner (all 6 setup steps + main screen + events + recovery)
33. Lab Report OCR
34. ABHA integration
35. WhatsApp bot backend

### Phase 6 — Platform & Social (Weeks 14–15)
36. Home screen widgets (Android + iOS)
37. Wear OS + watchOS companion apps
38. Wearable integrations (Health Connect, Fitbit, Garmin)
39. Social feed + Community groups
40. Push notifications

### Phase 7 — Polish & Release (Week 16)
41. Automated health reports + PDF generation
42. Subscription plans + Razorpay
43. Referral program
44. Remote Config system
45. Sentry crash reporting
46. CI/CD pipeline
47. Performance profiling + benchmarks
48. Full test suite
49. App size optimisation (target < 50 MB)

---

*FitKarma TODO — Complete Feature Implementation Checklist*
*Flutter · Riverpod · Drift (SQLCipher) · Appwrite · Built for India*
*35+ modules · 45+ screens · 28 shared components · Offline-first · Privacy-centric*