# ✅ FitKarma — Revised Project TODO
> **Beginner-friendly task checklist** · Incorporates architecture review + feature improvements · Work through phases in order
>
> **Legend:** 🟢 Easy · 🟡 Medium · 🔴 Hard · 🔒 Security-critical · ⚡ Do this first in the phase · 🆕 New (added from architecture/feature review)

---

## 📋 How to Use This File

- Work **top to bottom** — later phases depend on earlier ones.
- Mark tasks done with `[x]` in your editor.
- Each phase can be a separate **Git branch** (e.g. `feat/phase-1-setup`).
- Don't skip the 🔒 tasks — they protect user data.
- Tasks marked 🆕 are new additions from the architecture and feature review.
- Stuck? The section number links back to the developer docs.

---

## Phase 0 — Developer Environment Setup
> *Get your machine ready before writing a single line of app code.*

- [ ] ⚡🟢 Install **Flutter 3.x stable** — follow [flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
- [ ] 🟢 Run `flutter doctor` and fix every ❌ shown
- [ ] 🟢 Install **Android Studio** (for Android emulator) and/or **Xcode** (Mac only, for iOS simulator)
- [ ] 🟢 Install **VS Code** + Flutter & Dart extensions (or use Android Studio)
- [ ] 🟢 Install **Git** and create a GitHub account if you don't have one
- [ ] 🟢 Install **Node.js 18+** — needed later for Appwrite Functions
- [ ] 🟢 Install the **Appwrite CLI**: `npm install -g appwrite-cli`
- [ ] 🟡 Create a free account at [cloud.appwrite.io](https://cloud.appwrite.io) (your backend lives here)
- [ ] 🟡 Create a new Appwrite **project** — note down the `Project ID`
- [ ] 🆕🟡 Create **two separate Appwrite projects**: one for `staging` and one for `production` — never share a single backend across both environments

---

## Phase 1 — Project Scaffold

> *Create the Flutter project and set up the folder structure from the docs.*

### 1.1 Flutter Project
- [ ] ⚡🟢 Run `flutter create --org com.fitkarma fitkarma` to create the project
- [ ] 🟢 Delete the default counter app code from `lib/main.dart`
- [ ] 🟢 Add `.env` to your `.gitignore` file immediately — **before your first commit** 🔒
- [ ] 🟢 Create the `.env` file and fill in your Appwrite `Project ID` and `Endpoint`
- [ ] 🆕🟢 Create separate `.env.staging` and `.env.prod` files — never commit either 🔒

### 1.2 Folder Structure
> Create these folders inside `lib/` — they can be empty for now
- [ ] 🟢 Create `lib/core/constants/`
- [ ] 🟢 Create `lib/core/di/`
- [ ] 🟢 Create `lib/core/errors/`
- [ ] 🟢 Create `lib/core/network/`
- [ ] 🟢 Create `lib/core/security/`
- [ ] 🟢 Create `lib/core/storage/`
- [ ] 🟢 Create `lib/core/utils/`
- [ ] 🟢 Create `lib/core/config/` — 🆕 for Remote Config layer
- [ ] 🟢 Create `lib/features/` (all feature subfolders come later — add them as you build)
- [ ] 🟢 Create `lib/shared/widgets/` and `lib/shared/theme/`
- [ ] 🟢 Create `lib/l10n/` for language files

### 1.3 Dependencies
> Add these to `pubspec.yaml` — copy from Section 23 of the docs; additions marked 🆕

- [x] ⚡🟡 Add all packages from the original `pubspec.yaml` section of the docs
- [x] ⚡🟡 Set up **`drift`** + `drift_flutter` for ALL data storage:
  - [x] Add: `drift: ^2.x`, `drift_flutter: ^0.x`, `sqlite3_flutter_libs: ^0.x`, `sqlcipher_flutter_libs: ^0.x`
- [x] 🆕🟢 Add `home_widget: ^0.x` — Android/iOS home screen widgets
- [x] 🆕🟢 Add `flutter_map_tile_caching: ^9.x` — offline GPS map tiles
- [x] 🆕🟢 Add `cryptography: ^2.x` — for HKDF key derivation
- [x] 🆕🟢 Add `drift_dev: ^2.x` and `build_runner` update to dev_dependencies
- [x] 🟢 Run `flutter pub get` — fix any version conflicts shown in the terminal
- [x] 🟡 Run `dart run build_runner build` — generates Drift and Riverpod code (you'll re-run this often)

### 1.4 Architecture Fixes (Critical)
> ⚠️ These fixes address critical issues identified in the architecture review — do NOT skip

- [x] 🔴🟡 Create `lib/core/storage/app_database.dart` — copy the full `AppDatabase` class from Section 7.2 of the docs (includes `_openConnection`, `MigrationStrategy` through v5, FTS5 setup)
  - [x] Define DAOs for all 23 tables:
    - Core: `FoodLogsDao`, `FoodItemsDao`, `WorkoutLogsDao`, `StepLogsDao`, `SleepLogsDao`, `MoodLogsDao`
    - Lifestyle: `HabitsDao`, `HabitCompletionsDao`, `BodyMeasurementsDao`, `MedicationsDao`, `FastingLogsDao`, `MealPlansDao`, `RecipesDao`
    - Health (encrypted): `BloodPressureLogsDao`, `GlucoseLogsDao`, `Spo2LogsDao`, `PeriodLogsDao`, `JournalEntriesDao`, `DoctorAppointmentsDao`
    - India ecosystem: `LabReportsDao`, `AbhaLinksDao`
    - Platform: `EmergencyCardDao`, `FestivalCalendarDao`, `RemoteConfigCacheDao`
    - Infrastructure: `KarmaTransactionsDao`, `NutritionGoalsDao`, `PersonalRecordsDao`, `SyncQueueDao`, `SyncDeadLetterDao`
  - [x] Implement FTS5 virtual table (`food_items_fts`) + triggers as shown in Section 7.4
  - [x] Run `dart run build_runner build` after each DAO addition
- [x] 🟡 Add **composite Drift indices** — critical for dashboard < 1s load:
  - [x] `food_logs`: `(userId, loggedAt DESC)`
  - [x] `step_logs`: `(userId, date DESC)`
  - [x] `workout_logs`: `(userId, loggedAt DESC)`
  - [x] `mood_logs`: `(userId, loggedAt DESC)`
  - [x] `sleep_logs`: `(userId, date DESC)`
  - [x] `blood_pressure_logs`: `(userId, loggedAt DESC)`
  - [x] `glucose_logs`: `(userId, loggedAt DESC)`

### 1.5 App Config
- [x] Create `lib/core/constants/app_config.dart` — copy the `AppConfig` class from the docs (Section 23)
- [x] Create `lib/core/constants/api_endpoints.dart` — copy the `AW` constants class from the docs (Section 5.3)
- [x] 🆕🟡 Create `lib/core/config/remote_config.dart` — Remote Config provider
  - [x] Reads a `remote_config` document from Appwrite on app start (non-blocking)
  - [x] Caches locally in Drift; serves cached version on all subsequent reads
  - [x] Schema: `{ "feature.X": bool, "ab.X": { "rollout_pct": int, "seed": str }, "kill_switch.X": bool }`
  - [x] Expose as a Riverpod provider; UI reads flags from this — never hardcoded

---

## Phase 2 — Theme & Design System
> *Build the shared UI components once so you never have to repeat styling.*

### 2.1 Colours & Typography
- [x] ⚡ Create `lib/shared/theme/app_colors.dart` — added all colour constants and dark mode overrides
- [x] Create `lib/shared/theme/app_text_styles.dart` — defined all type styles from Section 3
- [x] Create `lib/shared/theme/app_theme.dart` — wired colours and fonts into a `ThemeData`
- [x] **Complete dark mode token set** — implemented deep navy background and revised hero gradients
- [x] Apply both light and dark themes in `lib/app.dart` using `ThemeMode.system`

### 2.2 Shared Widgets
- [x] `shimmer_loader.dart` — loading placeholder
- [x] `async_value_widget.dart` — generic `AsyncValue<T>` wrapper
- [x] `error_retry_widget.dart` — error state with Retry button
- [x] `bilingual_label.dart` — stacked English + Hindi `Text` widget
- [x] `activity_rings.dart` — four concentric rings (orange, green, teal, purple)
- [x] `insight_card.dart` — amber card with lightbulb icon and 👍/👎 buttons
- [x] `correlation_insight_card.dart` — multi-module insight with per-module pill links
- [x] `food_item_card.dart` — photo, bilingual name, portion, kcal, `+` button
- [x] `karma_level_card.dart` — dark purple gradient card with progress bar
- [x] `dosha_chart.dart` — three-segment donut using `fl_chart`
- [ ] `challenge_card.dart` — horizontally scrollable challenge card
- [x] `quick_log_fab.dart` — speed-dial orange FAB with 6 sub-actions
- [x] `meal_tab_bar.dart` — Breakfast / Lunch / Dinner / Snacks tab bar
- [x] `encryption_badge.dart` — 🔒 AES-256 pill badge for sensitive data
- [x] `sync_status_banner.dart` — DLQ banner + offline status indicator
- [x] `micronutrient_bar.dart` — compact progress bar for Iron / B12 / Vit D / Calcium
- [x] `lab_value_row.dart` — extracted lab metric with inline field and confirm checkbox
- [x] `abha_badge.dart` — ABHA linked (green) / unlinked (amber) indicator
- [ ] `health_share_card.dart` — shareable doctor link card with countdown
- [x] `home_widget_preview.dart` — scaled preview of Android/iOS home screen widgets
- [x] 🆕🟡 `festival_card.dart` — festival name (bilingual), date range, fasting pill, region pill, reminder + diet plan CTAs
- [x] 🆕🟡 `festival_countdown_banner.dart` — active festival dashboard banner; festival-colour gradient; fasting mode indicator; quick action buttons
- [x] 🆕🟡 `wedding_countdown_card.dart` — gold gradient card; days to wedding + next event; role badge; link to wedding planner
- [x] 🆕🟡 `wedding_role_chip.dart` — large illustrated role selection card (Bride/Groom/Guest/Relative) for onboarding
- [x] 🆕🟡 `event_day_card.dart` — individual wedding event card with energy demand badge and meal plan summary
- [x] 🆕🟢 `festival_diet_badge.dart` — fasting type pill badge (Nirjala / Phalahar / Roza / Feast / Sattvic)

### 2.3 Navigation
- [x] Create `lib/app.dart` with `GoRouter` — added all routes from the Route Map in Section 19
- [x] Add the 5-tab `BottomNavigationBar` (Home · Food · Workout · Steps · Me) with bilingual labels
- [x] Implement **deferred module loading** for heavy features — load library only on first navigation:
  - [x] Wearables screen — `deferred as wearables`
  - [x] Community/Social feed — `deferred as social`
  - [x] GPS workout map screen — `deferred as gps_workout`
  - [x] Mental health module — `deferred as mental_health`
  - [x] Meditation audio player — `deferred as meditation`

---

## Phase 3 — Core Infrastructure
> *The plumbing that every feature depends on. Get this solid before features.*

### 3.1 Appwrite Client
- [x] ⚡🟡 Create `lib/core/network/appwrite_client.dart` — copy the singleton from Section 5.2
- [x] 🟢 Test the connection: call `AppwriteClient.account.get()` and log the result
- [x] 🆕🔒🟡 **Add certificate pinning** to the Appwrite client — pin the leaf certificate SHA-256 hash
  - [x] Use `dio` with a custom `HttpClient` that validates the server certificate on every request
  - [x] Update pinned cert in a Remote Config flag when cert rotation is needed
- [x] **Add root/jailbreak detection** — added warning banner in `RootShell`

### 3.2 Local Storage — Drift (SQLCipher)
- [x] ⚡🟡 Create `lib/core/storage/drift_database.dart` — opens the Drift database with SQLCipher encryption
- [x] 🟢 Verify all DAOs work with a simple insert + select test
- [x] 🔒🔴 Implement field-level encryption for sensitive tables within Drift companion classes

### 3.3 Encryption Service
- [x] 🔒🔴 Create `lib/core/security/encryption_service.dart` — AES-256-GCM encryption/decryption
- [x] 🔒🔴 Create `lib/core/security/key_manager.dart` — derives and stores the master device key
  - [x] Derive master key from: `device_id + app_install_uuid + stored_random_salt` using **PBKDF2 (200,000 iterations)** — do NOT tie to the user password
  - [x] Store the master key in `flutter_secure_storage` with `AndroidKeyStore` / iOS `SecureEnclave` backing
  - [x] Store the random salt separately in `flutter_secure_storage`
  - [x] Password changes must NOT invalidate existing encrypted data
  - [x] OAuth-only users (no password) must still have working encryption
- [x] 🆕🔒🔴 **Derive a separate encryption key per data class** using HKDF — prevents lateral exposure if one key leaks:
  - [x] `HkdfKey.bp = HKDF(masterKey, info: "fitkarma_bp_glucose")`
  - [x] `HkdfKey.period = HKDF(masterKey, info: "fitkarma_period")`
  - [x] `HkdfKey.journal = HKDF(masterKey, info: "fitkarma_journal")`
  - [x] `HkdfKey.appointments = HKDF(masterKey, info: "fitkarma_appointments")`
  - [x] Use the `cryptography` package's `Hkdf` class for this
- [x] 🔒🟡 Store the salt in `flutter_secure_storage` — never in Drift or plaintext files

### 3.4 Connectivity & Sync Queue
- [x] 🟡 Create `lib/core/network/connectivity_service.dart` — wraps `connectivity_plus`, exposes an `isOnline` stream
- [x] 🟡 Create the `SyncQueueItem` model in Drift — copy fields from Section 8; add new fields below
- [x] 🔴 Create `lib/core/network/sync_queue.dart`:
  - [x] Write sync items to the `sync_queue` Drift table on every local create/update/delete
  - [x] Background isolate watches connectivity; flushes queue in batches of 20 when online
  - [x] Exponential backoff: 1s → 2s → 4s → 8s → 16s, max 5 retries per item
- [x] 🆕🔴🟡 **Idempotency keys** — add to every sync queue item to prevent duplicate writes on retry:
  - [x] `idempotencyKey = sha256(userId + entityType + localId + createdAt.toIso8601String())`
  - [x] Pass as a custom header `X-Idempotency-Key` on every Appwrite document create call
- [x] 🆕🟡 **Dead-letter queue (DLQ)** — items that fail > 5 times move to a `sync_dead_letter` Drift table:
  - [x] Surface DLQ count in Settings → Data & Sync as "X items pending sync"
  - [x] Allow user to manually retry or discard dead-letter items
- [x] 🆕🟡 **Per-field version vectors for conflict resolution** — replace global last-write-wins:
  - [x] Append-only logs (food_logs, step_logs, workout_logs): no conflict — accept both writes
  - [x] Profile fields: per-field `updatedAt` map — newer field wins
  - [x] Health logs with manual edits: surface a diff UI when true conflict detected — let user pick
- [x] 🟡🔴 Add priority system to sync queue:
  - [x] `SyncPriority` enum: `critical=0, high=1, normal=2, low=3`
  - [x] Health crisis alerts (BP ≥ 180/120, glucose extremes) = critical
  - [x] Food/workout/mood logs = normal
  - [x] Step batches = low
  - [x] Process queue in priority order
- [x] 🟡 Implement delta sync: on app resume, query Appwrite for `$updatedAt > lastSyncTimestamp`

### 3.5 Background Sync — WorkManager Isolate Safety
- [x] 🆕🔴🟡 **Isolate-safe background sync entry point** — background isolates do not share the main `ProviderContainer`:
  - [x] Create `lib/core/network/background_sync_runner.dart` — standalone init that re-opens Drift, re-derives encryption keys, re-creates Appwrite client without any Flutter widget binding or Riverpod
  - [x] Annotate with `@pragma('vm:entry-point')` so the Dart compiler does not tree-shake it
  - [x] Register in `WorkManager.initialize()` in `main.dart`
- [x] 🆕🟡 Add **Doze mode awareness** — only attempt sync when the radio is already awake:
  - [x] Use `connectivity_plus` stream; fire sync only on `ConnectivityResult.mobile` or `ConnectivityResult.wifi` transition
  - [x] Respect Android battery saver — check `DeviceInfoPlugin` for power save mode before heavy sync

### 3.6 Error Handling
- [x] 🟡 Create `lib/core/errors/app_exception.dart` — custom exception types: `NetworkException`, `StorageException`, `AuthException`, `EncryptionException`, `SyncException`
- [x] 🟡 Create `lib/core/errors/error_handler.dart` — maps raw exceptions to friendly bilingual UI messages
- [ ] 🆕🟡 **Enforce `AsyncValue` error boundaries** on every Riverpod provider that touches Drift or Appwrite:
  - [ ] Every `FutureProvider` / `StreamProvider` must expose `loading`, `data`, and `error` states
  - [x] Use the shared `AsyncValueWidget` from Phase 2.2 — no ad-hoc null checks in UI code

### 3.7 Appwrite Permissions (Security Fix)
> ⚠️ Critical security fix from architecture review
- [ ] 🔴🟡 Update Appwrite Console collection permissions:
  - [ ] Remove `Create: role:users` from ALL collections
  - [ ] Set permissions ONLY at document creation time via API call
  - [ ] Document-level permissions: `Permission.read(Role.user(uid))` + `Permission.write(Role.user(uid))`
- [ ] 🆕🔴 Add **composite indices** in Appwrite Console for every high-frequency query:
  - [ ] `food_logs`: `[userId, loggedAt DESC]`
  - [ ] `step_logs`: `[userId, date DESC]`
  - [ ] `workout_logs`: `[userId, loggedAt DESC]`
  - [ ] `blood_pressure_logs`: `[userId, measuredAt DESC]`
  - [ ] `glucose_logs`: `[userId, measuredAt DESC]`
  - [ ] `mood_logs`: `[userId, loggedAt DESC]`
  - [ ] `sleep_logs`: `[userId, date DESC]`

### 3.8 Riverpod Provider Architecture
- [x] 🟡 Create `lib/core/di/providers.dart` — root-level providers (Appwrite client, Drift DB, encryption keys)
- [ ] 🟡 Document provider organisation in each feature folder:
  - [ ] `features/*/data/*_providers.dart` — repository providers
  - [ ] `features/*/presentation/*_providers.dart` — UI state providers
- [ ] 🆕🟡 **Provider scoping and disposal** — use `keepAlive: false` on non-critical providers; scope feature providers to their routes using `ProviderScope` overrides so they are GC'd on pop
- [x] 🆕🟡 **Cancellation tokens** — add `CancelToken` (via `dio`) to all long-running operations (food search, GPS route save, bulk sync) and cancel them in the provider's `dispose`

---

## Phase 4 — Authentication & Onboarding
> *Users can't do anything until they can log in. Build auth before any features.*

### 4.1 Auth Service
- [x] ⚡🟡 Create `lib/features/auth/data/auth_aw_service.dart` — copy `login()`, `register()`, `logout()`, `getCurrentUser()` from Section 9
- [x] 🟡 Store the Appwrite session JWT in `flutter_secure_storage` after login
- [x] 🟡 On app start, check for a stored session and navigate directly to Dashboard if valid (skip login screen)
- [x] 🟡 Add Google OAuth2 login — copy the `createOAuth2Session` snippet from Section 9
- [x] 🟡 Add Apple Sign-In (iOS only) via the same Appwrite OAuth2 method

### 4.2 Auth Screens
- [x] 🟡 Build `LoginScreen` — email/password fields, Google sign-in button, "Register" link
- [x] 🟡 Build `RegisterScreen` — name, email, password fields, "Already have an account?" link
- [x] 🟢 Add form validation (email format, password min 8 chars)
- [x] 🟡 Show loading state during login/register — use `ShimmerLoader`
- [x] 🟡 Show friendly error messages on failure (wrong password, network error)

### 4.3 Onboarding Flow
> Build the 6 screens in order. Each screen writes to a local `OnboardingState` object; commit everything to Drift + Appwrite only when the user completes step 6.
- [x] 🟡 **Screen 1** `/onboarding/1` — Name · Gender · Date of Birth (text input + dropdown + date picker)
- [x] 🟡 **Screen 2** `/onboarding/2` — Height / Weight (numeric cm/kg inputs) · Fitness Goal (4 option cards) · Activity Level (5 illustrated cards)
- [x] 🟡 **Screen 3** `/onboarding/3` — Chronic Conditions (optional multi-select: Diabetes · Hypertension · PCOD · Hypothyroidism · Asthma) + "Skip" link
- [x] 🟡 **Screen 4** `/onboarding/4` — Dosha Quiz (12 questions) → auto-calculate Vata/Pitta/Kapha %; show `DoshaDonutChart` mini preview on result
- [x] 🟡 **Screen 5** `/onboarding/5` — Language selection (22+ languages) + contextual health permissions (step counter · heart rate · sleep)
- [x] 🟡 **Screen 6** `/onboarding/6` — ABHA link (optional, skippable → `+100 XP` incentive) + Wearable connection (optional, skippable)
- [x] 🟢 On step 6 completion: write full user profile to Drift → enqueue Appwrite sync → award **+50 XP**
- [x] 🔒🟡 Set `Role.user(uid)` read + write permissions on the `users` Appwrite document at creation time

### 4.4 Biometric Lock
- [ ] 🟡 Add `local_auth` biometric check on app resume (not on first launch)
- [ ] 🟢 Add toggle in Settings to enable/disable biometric lock

---

## Phase 5 — Dashboard (Home Screen)
> *The first thing users see every day — must load from Drift in under 1 second.*

- [x] ⚡🟡 Build `DashboardScreen` — reads **only from Drift** on first render (no Appwrite calls)
- [x] 🟡 Add the **header** — avatar, "Namaste, [Name] 🙏", karma XP and level badge
- [x] 🟡 Add the `ActivityRingsWidget` — wire calories, steps, water, active minutes progress
- [x] 🟡 Add the `InsightCard` — show one rule result from the Insight Engine (see Phase 11)
- [x] 🟡 Add **Today's Meals section** — tab bar + meal summary cards
- [x] 🟡 Add the `QuickLogFAB` — speed-dial with: Food, Water, Mood, Workout, BP, Glucose
- [x] 🟢 Add latest workout summary card and sleep recovery score card
- [x] 🟡 Background: fetch Appwrite updates after render (delta sync) and refresh UI if new data arrives
- [ ] 🆕🔴 **Android + iOS Home Screen Widgets** — install `home_widget` package and build:
- [ ] **4×1 ring widget** — steps, calories, water, active minutes rings with today's progress
- [ ] **2×1 quick-log widget** — single "Log Food" button that deep-links to the food log bottom sheet
- [ ] **Lock screen widget (Android 13+)** — water intake counter; tap to increment by 1 glass
- [ ] Update widget data from WorkManager background task after every sync

---

## Phase 6 — Food Logging
> *The most-used feature. Build search and manual entry first, then add the fancier methods.*

### 6.1 Food Database
- [x] ⚡🟡 Seed the initial Indian food database into both Drift (local) and Appwrite `food_items` collection
- [ ] 🔴🟡 **Expand Food Database:** Research and add comprehensive regional cuisines from all Indian states (North, South, East, West, Northeast, Central)
- [x] 🆕🟡 **Add micronutrient fields** to `food_items` schema — these four are the most common deficiencies in India and must be tracked:
  - [x] `vitamin_d_mcg` (micrograms per 100g)
  - [x] `vitamin_b12_mcg` (micrograms per 100g)
  - [x] `iron_mg` (milligrams per 100g)
  - [x] `calcium_mg` (milligrams per 100g)
  - [x] Add the same fields to `FoodLog` (denormalised at log time)
- [ ] 🟡 **Community Food Submissions:** Build a feature for users to submit new local food items for review
- [x] 🟡 Include `name` (English) and `name_local` (in the local script) fields for every item
- [x] 🟡 Include region-specific `serving_sizes` JSON: e.g. `[{"name":"katori","grams":150}, {"name":"idli","grams":50}]`

### 6.2 Food Log Service
- [x] 🟡 Create `lib/features/food/data/food_drift_service.dart` — (Integrated into FoodRepository)
- [x] 🟡 Create `lib/features/food/data/food_aw_service.dart` — search food items and sync logs to Appwrite
- [x] 🟡 Create `lib/features/food/data/food_repository.dart` — Drift first, Appwrite fallback, queue sync

### 6.3 Food Log Model
- [x] 🟡 Create `lib/features/food/domain/food_log_model.dart` — Drift `DataClass`
- [x] 🟢 Run `dart run build_runner build` to generate the Drift companion and query classes

### 6.4 Food Log Screen
- [x] 🟡 Build `FoodLogScreen` (e.g. "Log Breakfast") with:
  - [x] Bilingual search bar
  - [x] Three quick-action chips: `📷 Scan Label` · `🍽 Upload Plate Photo` · `✏ Manual Entry`
  - [x] `Frequent Indian Portions` — horizontal list of frequent items
  - [x] `Recent Logs` — list of past entries for the meal type
- [x] 🟡 Implement **text search** — FTS5 virtual table query on Drift's `food_items` table (fast full-text, no Appwrite call)
- [x] 🟡 Implement **portion selection** — dynamic scaling of macro + micronutrient data
- [x] 🟡 Implement **manual entry** — dedicated sheet with macro + key micronutrient inputs
- [x] 🟡 On log: write to Drift → award +10 XP (+30 for first log) → reactive UI update via notifier
- [x] 🟡 Implement **macro + micronutrient ratios** — dynamic goals based on TDEE/fitness goal
- [x] 🆕🟢 **"Copy yesterday's meals"** button on the food home screen — one-tap re-log all of yesterday's entries (high-requested UX shortcut; sets `log_method: copied`)

### 6.5 Advanced Food Logging Methods
- [x] 🟢 **Barcode scanner** — `flutter_barcode_scanner` → OpenFoodFacts API → cache result in Drift
- [x] 🟢 **OCR (Scan Label)** — Google ML Kit `TextRecognitionV2` to read nutrition labels
- [ ] 🟢 **Photo AI (Upload Plate Photo)** — Google ML Kit `ImageLabeling` to identify food
- [ ] 🟢 **Voice logging** — `speech_to_text` → *"dal chawal"* → search → confirm screen

---

## Phase 7 — Step Tracking
- [x] ⚡🟢 Integrate the `health` package — request Health Connect (Android) / HealthKit (iOS) permissions
- [x] 🟢 Read today's step count and write to `step_logs` Drift table
- [x] 🟢 Set up background sync — WorkManager (Android) / `BGAppRefreshTask` (iOS) to batch-sync steps at 15m intervals
- [x] 🟢 Build `StepsScreen` — historical charts and today's progress visualization
- [ ] 🟢 Fallback: use `pedometer` package if health platform permissions are denied
- [ ] 🟢 Implement **adaptive goal** — daily target = 7-day rolling average
- [ ] 🟢 Add inactivity nudge — detect > 60 min phone inactivity → push gentle movement reminder
- [ ] 🟢 Award +5 XP per 1,000 steps (max 50 XP/day)
- [ ] 🟢 Build `StepsScreen` — today's count, goal ring, weekly bar chart

---

## Phase 8 — Karma System
> *XP is earned in almost every feature, so build the service early.*

- [x] ⚡🟢 Create `lib/features/karma/data/karma_drift_service.dart` — instant local XP snapshot in Drift
- [x] 🟢 Create `lib/features/karma/data/karma_aw_service.dart` — write `karma_transactions` to Appwrite; server is source of truth for balances
- [x] 🟢 Create `KarmaNotifier` (Riverpod `AsyncNotifier`) — `addXP(int amount, String action)` method
- [x] 🟢 Subscribe to Appwrite Realtime `karma_transactions` collection
- [x] 🟢 Build `KarmaHub` screen — level card, XP bar, karma history list
- [x] 🟢 Build `KarmaStore` screen — list of rewards redeemable with XP
- [x] 🟢 Build `Leaderboard` screen — Friends / City / National tabs with weekly reset
- [x] 🟢 Implement streak multipliers — ×1.5 at 7-day streak, ×2.0 at 30-day streak
- [x] 🆕🟢 **Streak recovery mechanic** — user can spend 50 Karma XP to restore a broken streak (reduces churn from missed days); limit to once per 30 days per streak type

---

## Phase 9 — Workout System
- [x] ⚡🔴 **Structured Workout Library** — add `Exercises` and `ExerciseSets` Drift tables
- [x] 🟡 **Foundational Exercise Seeding** — 100+ items including Indian regional context (Surya Namaskar)
- [x] ⚡🔴 **Workout Log Screen** — dynamic addition of sets with `Weight` · `Reps` · `RPE` inputs
- [ ] ⚡🟢 Seed workout data into the Appwrite `workouts` collection (title, YouTube ID, duration, difficulty, category)
- [x] 🟢 Build `WorkoutHomeScreen` — category grid (Yoga, HIIT, Strength, Dance, Bollywood, Pranayama…)
- [ ] 🟢 Build `WorkoutDetailScreen` — thumbnail, description, difficulty, duration, Start button
- [ ] 🟢 **YouTube player** — `youtube_player_flutter` — play workout by YouTube video ID
- [ ] 🟢 **GPS Outdoor** — `geolocator` tracks location → `flutter_map` draws the route on OpenStreetMap
- [ ] 🆕🟡 **Offline map tile caching** — use `flutter_map_tile_caching` to pre-cache tiles for the user's home region (detected from onboarding city) before first GPS workout; prevents blank map on 2G
- [ ] 🟡 **Custom Workout Builder** — add exercises with sets/reps/rest time; save as a custom workout
- [x] 🆕🟡 **Rest timer between sets** — countdown timer that auto-starts after each set is logged; configurable duration per exercise; plays a soft chime on completion
- [x] 🆕🟢 **RPE (Rate of Perceived Exertion) logging** — add a 1–10 RPE slider to the post-workout summary; store in `workout_logs.rpe`; use in the correlation engine
- [ ] 🟡 **Workout Calendar** — schedule future workouts; mark rest days
- [x] 🟢 Log completed workout to `workout_logs` Drift table → sync queue → award +20 XP
- [x] 🟡 Auto-detect **personal records** (max lift, fastest 5K, longest run) and award +100 XP

---

## Phase 10 — Nutrition Goal Engine
- [x] ⚡🟡 Implement TDEE calculator — copy the Mifflin-St Jeor formula from Section 11.7
- [x] 🟡 Calculate and store macro targets (55% carbs / 20% protein / 25% fat) in `nutrition_goals` Drift table
- [ ] 🟡 Build daily nutrition ring charts with traffic-light status 🟢🟡🔴
- [ ] 🟡 **Micronutrient tracking** — Iron, B12, Vitamin D, Calcium daily totals vs RDA targets
- [ ] 🆕🟢 **Micronutrient gap summary** — dashboard card that shows the single biggest daily gap (e.g. "You're 8 mcg Vitamin B12 short — add 1 egg or 50g paneer") using the same `InsightCard` component
- [ ] 🟡 Grocery list generator — derive shopping list from current nutrition goals
- [ ] 🟢 Weekly micronutrient gap analysis report

---

## Phase 11 — On-Device AI Insight Engine
> *Pure Dart logic — zero server calls at runtime.*

### 11.1 Engine Architecture Refactor
- [ ] ⚡🆕🔴🟡 **Modular insight engine** — replace the single `rule_engine.dart` file with a structured directory:
  ```
  lib/features/insight_engine/
  ├── engine/
  │   ├── rule_evaluator.dart        # Pure evaluation logic
  │   └── insight_scheduler.dart     # When to run, throttling, max 2 cards/day
  ├── rules/
  │   ├── nutrition_rules.dart
  │   ├── sleep_rules.dart
  │   ├── bp_rules.dart
  │   ├── glucose_rules.dart
  │   ├── workout_rules.dart
  │   ├── hydration_rules.dart
  │   ├── mood_rules.dart
  │   └── cross_module_rules.dart    # ← NEW: cross-domain correlations
  └── models/
      ├── insight_rule.dart          # Abstract: condition(), message(), priority()
      └── insight_output.dart
  ```
- [ ] 🟡 Implement all single-module rules from Section 11.13 (sleep, steps, water, workout, protein, cycle, streak, BP, fasting, glucose, burnout, BMI)
- [ ] 🟢 Evaluate rules daily — surface max 2 cards on the Dashboard
- [ ] 🟢 Store user's 👍/👎 feedback in Drift to suppress unhelpful rules

### 11.2 Cross-Module Correlation Rules (NEW)
> *These queries span multiple Drift tables.*
- [ ] 🆕🔴🟡 Implement `cross_module_rules.dart` with the following correlations:
  - [ ] **Sleep × Mood**: if `sleep_hours < 6` on day N, check if `mood_score` on day N+1 is ≤ 2; if pattern repeats ≥ 5 times in 30 days → surface insight
  - [ ] **Workout × Protein**: on days with a logged workout, check if `protein_g < goal * 0.7` → "You under-eat protein on workout days"
  - [ ] **Fasting × BP**: correlate `fasting_logs.completed = true` days with `bp_logs.systolic`; if average is ≥ 5 mmHg lower → surface positive insight
  - [ ] **Steps × Glucose**: on days with `step_count >= 8000`, check average post-meal glucose vs non-walking days
  - [ ] **Festival × Calorie spike**: cross-reference `festival_calendar` dates with `food_logs.calories`; 3 days before a festival → proactive recovery plan nudge
  - [ ] **RPE × Sleep**: if `workout.rpe >= 8` and `sleep_logs.quality <= 2` on consecutive days → burnout risk alert
  - [ ] **Screen time × Mood**: if `mood_logs.screen_time_min > 240` correlates with low mood over 7 days → screen time insight

### 11.3 Server-Delivered Rules (NEW)
- [ ] 🆕🟡 Add a `server_rules` key to Remote Config — a JSON array of simple threshold rules that can be updated without an app release (e.g. seasonal hydration thresholds, festival-specific tips)
- [ ] 🆕🟡 `RuleEvaluator` should merge local hardcoded rules with server-delivered rules before evaluation

---

## Phase 12 — Health Monitoring Modules
> *Build these together — they share the same encryption and chart patterns.*

### 12.1 Blood Pressure Tracker 🔒
- [ ] ⚡🟡 Create `BPLog` Drift table with field-level encryption for systolic/diastolic values
- [ ] 🔴 Implement `BPLogsDao` with `EncryptionService` integration using the **HKDF-derived BP key** (from Phase 3.3)
- [ ] 🟡 Build logging screen — systolic / diastolic / pulse inputs (< 20 seconds to log)
- [ ] 🟡 Implement `classify()` function — Normal / Elevated / Stage 1 / Stage 2 / Crisis
- [ ] 🔴 Emergency alert — reading ≥ 180/120 → immediate care prompt with emergency contact link
- [ ] 🟡 7/30/90-day trend chart with AHA colour bands using `fl_chart`
- [ ] 🟢 Morning/evening reminder notifications
- [ ] 🟢 Award +5 XP per BP log

### 12.2 Blood Glucose Tracker 🔒
- [ ] 🟡 Create `GlucoseLog` Drift table + encryption logic using **HKDF-derived BP/glucose key**
- [ ] 🟡 Build logging screen — reading type selector (Fasting / Post-meal / Random / Bedtime) + mg/dL input
- [ ] 🟡 Implement `classifyFasting()` and `classifyPostMeal2h()`
- [ ] 🟡 HbA1c estimator — 90-day average glucose → estimated A1c %
- [ ] 🟡 Meal correlation — link post-meal glucose to a specific food log entry (cross-module)
- [ ] 🟡 Trend chart with configurable target bands
- [ ] 🟢 Award +5 XP per glucose log

### 12.3 SpO2 Tracker
- [ ] 🟢 Create `SpO2Log` Drift table (no encryption required)
- [ ] 🟡 Build manual logging screen — SpO2 % + pulse
- [ ] 🟡 Alert when SpO2 < 95% — "Please consult your doctor"
- [ ] 🟢 30-day trend chart with 95% lower reference band

### 12.4 Doctor Appointments 🔒
- [ ] 🔴 Create `Appointment` Drift table with encrypted `notes` field using **HKDF-derived appointments key**
- [ ] 🔴 Prescription photos stored **locally only** — file path in model, never uploaded
- [ ] 🟡 Build appointments list + add/edit screens
- [ ] 🟡 24h reminder notification using `flutter_local_notifications`
- [ ] 🆕🟡 **Prescription photo → medication auto-setup** — user can photograph a prescription:
  - [ ] ML Kit OCR reads the printed text
  - [ ] Call Appwrite Function (LLM post-processing) to extract: medication name, dosage, frequency, duration
  - [ ] Pre-fill the medication form for user confirmation before saving
  - [ ] Fallback: show raw OCR text if extraction fails

### 12.5 Lab Report OCR → Auto-populate Health Metrics (NEW)
- [ ] 🆕🔴🟡 Build `LabReportScanScreen` — accessible from the Health Monitoring hub and Dashboard FAB
  - [ ] Accept photo (camera) or PDF upload
  - [ ] ML Kit OCR reads printed lab report text
  - [ ] Call Appwrite Function (LLM) to extract key-value pairs: glucose, hemoglobin, cholesterol (LDL/HDL/Total), TSH, creatinine, Vitamin D, B12
  - [ ] Present extracted values in a confirmation screen — user can edit each value before saving
  - [ ] On confirm: auto-populate the relevant tracker (glucose → glucose_log, Vitamin D → micronutrient log, etc.)
  - [ ] All extracted data treated as sensitive — encrypted at rest
- [ ] 🆕🟢 Surface a "Upload Lab Report" prompt in the insight engine after a user has been active for 30 days without any lab data

### 12.6 ABHA Integration (NEW — India-specific)
- [ ] 🆕🔴🟡 **Ayushman Bharat Health Account (ABHA)** — link the user's national health ID:
  - [ ] Add "Link ABHA ID" option in Settings → Linked Accounts
  - [ ] Implement ABHA OAuth2 flow via NHA sandbox/production API
  - [ ] On link: display ABHA profile (name, health ID) in the Profile screen with a verified badge
  - [ ] Allow user to pull verified prescription + discharge records from ABHA
  - [ ] Store ABHA token in `flutter_secure_storage` — never in Drift or plaintext files
  - [ ] Add "Unlink ABHA" with confirmation dialog — removes token and ABHA data locally

---

## Phase 13 — Lifestyle & Wellness Modules

### 13.1 Sleep Tracker
- [ ] 🟡 Build sleep logging screen — bedtime/wake time pickers, emoji quality scale (1–5)
- [ ] 🟡 Auto-sync from Health Connect / HealthKit when permission is granted
- [ ] 🟡 Weekly sleep chart + sleep debt indicator
- [ ] 🆕🟢 **Sleep debt tracker** — show cumulative weekly deficit vs target (e.g. "You owe 3h 20m sleep this week") as a persistent banner on the sleep screen
- [ ] 🆕🟢 **Chronotype detection** — after 30 days of sleep logs, classify the user as Early Bird / Night Owl / Intermediate based on median bedtime; surface in the profile and use in the insight engine for personalised nudge timing
- [ ] 🟢 Award +5 XP per sleep log

### 13.2 Mood Tracker
- [ ] 🟡 Build mood logging screen — 5-emoji selector + energy/stress sliders + tag chips
- [ ] 🟡 Voice note — record and store **locally only**, never upload
- [ ] 🟡 Mood heatmap calendar using `fl_chart`
- [ ] 🟢 Award +3 XP per mood log

### 13.3 Period Tracker 🔒
- [ ] 🔴 Create `PeriodLog` Drift table
- [ ] 🔴 All writes go through `EncryptionService` using the **HKDF-derived period key** before touching Drift
- [ ] 🔴 Sync to Appwrite is **opt-in only** — default is local-only (add a Settings toggle)
- [ ] 🟡 Cycle prediction — average of last 3 cycles
- [ ] 🟡 Ovulation window estimation
- [ ] 🟡 Symptom tracking — cramps, bloating, mood swings, headache, fatigue, spotting
- [ ] 🟡 Workout suggestions per cycle phase
- [ ] 🟡 PCOD/PCOS management mode — activate from Chronic Conditions selection

### 13.4 Medication Reminder
- [ ] 🟡 Build medication list screen + add/edit form (name, dosage, frequency, category)
- [ ] 🟡 Schedule reminder notifications with `flutter_local_notifications` — fully offline
- [ ] 🟡 Refill alert — notification 3 days before estimated refill date
- [ ] 🟢 Auto-populate active medications into the Emergency Health Card

### 13.5 Habit Tracker
- [ ] 🟡 Build preset habits — 8 glasses water, 10-min meditation, 30-min walk, read 10 pages, no sugar
- [ ] 🟡 Custom habit creator — name, emoji, target count, unit, frequency
- [ ] 🟡 Streak tracking with flame indicator per habit
- [ ] 🟡 Weekly completion heatmap (GitHub graph style)
- [ ] 🟢 Award +2 XP per habit, +10 XP for 7-day streak

### 13.6 Body Measurements Tracker
- [ ] 🟡 Build measurement logging screen — weight, chest, waist, hips, arms, thighs, body fat %
- [ ] 🟡 Auto-calculate BMI, waist-to-hip ratio, waist-to-height ratio
- [ ] 🟡 Trend charts for 30/90/180-day windows
- [ ] 🔒🟢 Progress photos stored **locally only** — never upload to Appwrite

### 13.7 Intermittent Fasting Tracker
- [ ] 🟡 Protocol selector — 16:8 / 18:6 / 5:2 / OMAD / Custom
- [ ] 🟡 Countdown timer with fasting stage ring
- [ ] 🟡 Hydration alerts during fasting window
- [ ] 🟢 Ramadan mode — Sehri/Iftar as fasting boundary
- [ ] 🟢 Award +15 XP per completed fast

### 13.8 Meal Planner — Festival & Wedding Aware
- [ ] 🟡 Build 7-day grid planner — Breakfast / Lunch / Dinner / Snacks per day
- [ ] 🟡 Rule Engine generates suggested plan from TDEE + dosha + nutrition gaps (zero server calls)
- [ ] 🟡 Indian meal templates — North Indian, South Indian, Bengali, Gujarati
- [ ] 🆕🟡 **Festival-aware meal plan integration** — detect active festival from `festival_calendar` Drift table and auto-switch meal plan template:
  - [ ] Navratri: Phalahar template (sabudana khichdi, kuttu atta, singhara atta, fruits, milk)
  - [ ] Ramadan: Replace meal tabs with Sehri + Iftar blocks; compute Iftar time from user GPS + sunset
  - [ ] Karva Chauth: Sargi pre-sunrise meal block + break-fast block at moonrise
  - [ ] Chhath Puja: Pre-fast high-nutrition plan + 3-day post-fast gentle re-feeding plan
  - [ ] Diwali/Holi/Eid/Christmas: Feast mode — flex calorie budget (+150–200 kcal/day)
  - [ ] Jain Paryushana: Root-veg-free food filter applied to entire meal plan
  - [ ] Ekadashi (twice monthly): Auto-detected from `festival_calendar`; grain-free filter activated
- [ ] 🆕🟡 **Wedding-aware meal plan integration** — when a wedding event is active (from `wedding_events` Drift table), switch to the role-based wedding diet phase:
  - [ ] Pre-Wedding phase: role-specific plan (bride lean+glow, groom lean+muscle, guest moderate)
  - [ ] Wedding Week: event-by-event meal plans per day (Haldi, Mehendi, Sangeet, Vivah, Reception)
  - [ ] Post-Wedding: 3-day detox + gradual calorie return
  - [ ] Overlap handling: if festival + wedding dates overlap, show merged insight card and use union of allowed foods
- [ ] 🟢 One-tap log — tap a planned meal to log it directly (sets `log_method: planner`)
- [ ] 🟢 Grocery list auto-generator from the week's plan

### 13.9 Recipe Builder
- [ ] 🟡 Build recipe form — add ingredients from food DB, set quantities and servings
- [ ] 🟡 Auto-calculate total macros **and micronutrients** per serving
- [ ] 🟡 Save recipe → log entire recipe as one food entry in one tap
- [ ] 🟢 Community sharing — mark recipe as public

### 13.10 Ayurveda Personalisation Engine
- [ ] 🟡 Build 12-question dosha quiz and scoring algorithm
- [ ] 🟡 `DoshaProfile` screen — `DoshaDonutChart` + vata/pitta/kapha percentages
- [ ] 🟡 `DailyRituals` checklist — Dinacharya tasks based on dosha type and current season
- [ ] 🟡 `SeasonalPlan` screen — food/activity adjustments per Indian season (Ritucharya)
- [ ] 🟢 Herbal remedies library — ashwagandha, triphala, brahmi, turmeric with evidence notes

### 13.11 Guided Meditation & Pranayama
- [ ] 🟡 Bundle audio files for 5/10/15/20-min guided sessions
- [ ] 🟡 Pranayama library — Anulom Vilom, Bhramari, Kapalbhati, Bhastrika with inhale/hold/exhale timers
- [ ] 🟡 Use `just_audio` for fully offline playback
- [ ] 🟢 Trigger 3-min breathing exercise when `stress_level > 7` in mood log
- [ ] 🟢 Award +5 XP per session, +10 XP for 7-day streak

### 13.12 Journaling 🔒
- [ ] 🔴 Build journal entry screen using `flutter_quill` for rich text
- [ ] 🔴 AES-256 encrypt content using **HKDF-derived journal key** before writing to Drift
- [ ] 🔴 Sync to Appwrite **opt-in only** — same model as period tracker
- [ ] 🟢 Weekly prompt suggestions
- [ ] 🆕🟡 **On-device sentiment analysis** — run a lightweight on-device classifier (Dart-only, no ML model download) on journal text to track emotional tone over time; feed into the mood correlation rule in the insight engine; never send journal text to any server

### 13.13 Mental Health & Stress Management
- [ ] 🟡 Build burnout detection — sustained low mood + poor sleep + low energy over 7 days → recovery flow
- [ ] 🟡 7-day CBT-lite stress program with prompts tied to user's actual logged data (not generic)
- [ ] 🟢 Surface Indian helpline resources — iCall, Vandrevala Foundation, NIMHANS
- [ ] 🟢 Gentle professional help prompt after 14 days of consistently low mood

---

## Phase 13A — Festival Calendar Module — **NEW**
> *Build the dynamic festival date engine and the Festival Calendar screens. This phase feeds into the Meal Planner (Phase 13.8), Insight Engine, and Seasonal Leaderboards (Phase 14).*

### 13A.1 Festival Date Engine — Dart Implementation
- [x] 🆕🔴🟡 Create `lib/features/festival_calendar/domain/festival_date_engine.dart` — multi-calendar algorithmic date computation:
  - [x] **Hindu lunisolar** — implement Meeus tithi algorithm (Gudi Padwa added)
  - [x] **Islamic Hijri (Umm al-Qura algorithm)** — compute Gregorian equivalent
  - [x] **Sikh Nanakshahi calendar** — Baisakhi (Apr 13/14), Guru Nanak Jayanti
  - [x] **Gregorian fixed** — Lohri, Makar Sankranti, Pongal, Republic Day, Independence Day, Christmas, Bihu, Vishu
  - [x] Compute for years: `[currentYear - 1, currentYear, currentYear + 1, currentYear + 2]`
  - [x] Write computed dates to `festival_calendar` Drift table
- [x] 🆕🟡 Create fallback static JSON asset `assets/festival_dates_2024_2030.json` — pre-computed dates for 2024–2030 for all 30+ festivals; used if algorithmic computation fails or on first launch before engine runs
- [ ] 🆕🟢 Unit test the engine for at least 5 festivals across 3 years; cross-check results against `drikpanchang.com` reference dates

### 13A.2 Annual Refresh — Appwrite Function
- [ ] 🆕🟡 Create `appwrite-functions/refresh-festival-dates/` Node.js function:
  - [ ] Re-implement the same Meeus + Umm al-Qura algorithms in JavaScript (matches Dart engine output)
  - [ ] Schedule as a cron: `0 5 1 1 *` (Jan 1, 05:00 UTC — first day of each year)
  - [ ] Writes new year's festival dates to Appwrite `festival_calendar` collection
  - [ ] App syncs on next foreground session → `festival_calendar` Drift table updated
- [ ] 🆕🟢 Add a manual trigger endpoint (admin-only) to force a refresh mid-year if a date calculation error is reported

### 13A.3 Festival Drift Table & DAO
- [x] 🆕🟡 Create `FestivalCalendar` Drift table (see Section 11.11.4 schema):
  - [x] Fields: `id, festivalKey, nameEn, nameHi, nameLocal, year, startDate, endDate, calendarSystem, dietPlanType, regionCodes, religion, isFastingDay, fastingType, allowedFoods, forbiddenFoods, workoutNote, insightMessage, karmaChallenge, computedDynamically, computedAt`
- [x] 🆕🟡 Create `WeddingEvents` Drift table (see Section 11.12.2 schema)
- [x] 🆕🟡 Create `FestivalCalendarDao` with queries:
  - [x] `getActiveFestivals(DateTime date)` — returns festivals whose range covers today
  - [x] `getUpcomingFestivals(DateTime from, int limit)` — next N festivals after `from`
  - [x] `getFestivalByKey(String key, int year)` — fetch a specific festival
  - [x] `upsertFestivals(List<FestivalCalendarCompanion> rows)` — used by the date engine on refresh
- [x] 🆕🟡 Create `WeddingEventsDao` with queries:
  - [x] `getActiveWeddingPlan(String userId)` — returns the active wedding plan if within date range
  - [x] `getWeddingPhase(String userId, DateTime date)` — returns `pre_wedding` / `wedding_week` / `post_wedding`

### 13A.4 Festival Diet Plan Engine
- [x] 🆕🔴🟡 Create `lib/features/festival_calendar/domain/festival_diet_engine.dart`:
  - [x] `FestivalDietConfig` per festival — fasting type, allowed food IDs, forbidden food IDs, calorie multiplier, workout suppression flag, insight card message
  - [x] `getActiveDietConfig(DateTime date)` — checks `FestivalCalendarDao`, returns merged config if multiple festivals active
  - [x] Expose as a `FestivalDietProvider` (Riverpod) — consumed by Meal Planner + Nutrition Goal Engine + Dashboard InsightCard
- [ ] 🆕🟡 **Iftar/Sehri time computation** — for Ramadan:
  - [ ] Compute sunset time from user GPS latitude + longitude + date using astronomical formula (Meeus)
  - [ ] Cache result in Drift per (lat, lon, date) — recompute only when date or location changes significantly (>5 km)
  - [ ] Surface as countdown widget on Dashboard and Meal Planner during Ramadan
- [ ] 🆕🟡 **Moonrise computation for Karva Chauth** — same astronomical formula; cache in Drift
- [x] 🆕🟡 **Allowed/Forbidden food filter** — when a fasting festival is active, filter `food_items` FTS5 search to show only `allowedFoods` list; show a "Not allowed during [festival]" banner on forbidden items
- [ ] 🆕🟢 **Garba calorie burn tracker** (Navratri):
  - [ ] Add "Garba" as a workout type in the workout module (MET value: 5.5 for moderate, 7.0 for vigorous Garba)
  - [ ] Surface as a quick-log shortcut from the Navratri festival banner on Dashboard

### 13A.5 Festival Calendar Screens
- [x] 🆕🟡 Build `FestivalCalendarScreen` `/festival-calendar` — upcoming festivals list + active banner + region filter + mini calendar + "Plan a Wedding" CTA (see UI spec Section 7.14)
- [x] 🆕🟡 Build `FestivalDietPlanScreen` `/festival-calendar/{festivalKey}/diet` — diet plan tabs per day; allowed foods grid; quick log CTA; workout note banner; festival-specific additions (Ramadan countdown, Karva Chauth moonrise)
- [x] 🆕🟢 Build `FestivalReminderBottomSheet` — "Set Reminder" for upcoming festivals; creates a local notification N days before start date (user-configurable: 7 days / 3 days / 1 day before)
- [x] 🆕🟢 Add **region filter persistence** — user's selected religion/region filter stored in Drift `user_preferences`; irrelevant festivals hidden by default

### 13A.6 Festival Karma Challenges
- [ ] 🆕🟡 **Seasonal Leaderboard per festival** — auto-create a `leaderboard_season` in Appwrite scoped to the festival date range:
  - [ ] Navratri Steps Challenge (9 days) — steps leaderboard + Garba session bonus XP
  - [ ] Ramadan Wellness Challenge (30 days) — Sehri + Iftar logging consistency score
  - [ ] Diwali Mithai Budget Challenge (5 days) — daily sweet calorie budget adherence
  - [ ] Holi Colour Run Challenge (1 day) — steps on Holi day
  - [ ] Onam Sadhya Smart Eating (1 day) — log a full Sadhya and stay within calorie budget
  - [ ] Chhath Mindfulness Challenge (3 days) — meditation + breathing streak
- [ ] 🆕🟢 Festival challenge cards appear automatically in the Karma tab when a festival is within 7 days; auto-hide 3 days after the festival ends

---

## Phase 13B — Wedding Planner Module — **NEW**
> *Role-based, date-range-aware, event-by-event wedding diet and fitness planner.*

### 13B.1 Wedding Data Layer
- [x] 🆕🟡 Create `WeddingEvents` Drift table and `WeddingEventsDao` (defined in Phase 13A.3)
- [x] 🆕🟡 Add wedding fields to `users` Appwrite collection (see Section 6 `users` table): `wedding_role`, `wedding_relation_type`, `wedding_start_date`, `wedding_end_date`, `wedding_prep_weeks`, `wedding_events` (JSON), `wedding_primary_goal`
- [x] 🆕🟡 Create `WeddingDietEngine` — generates phase-aware diet plans:
  - [x] `getWeddingDietPhase(userId, date)` → `pre_wedding` / `wedding_week` / `post_wedding`
  - [x] `getPreWeddingPlan(role, weeksRemaining)` → week-by-week diet plan object
  - [x] `getEventDayPlan(role, eventType)` → pre-event meal + during-event tips + post-event recovery meal per event
  - [x] `getPostWeddingPlan(role)` → 3-day detox + gradual return plan
  - [x] All computation on-device — zero server calls
- [x] 🆕🟡 Create `WeddingFitnessEngine` — generates pre-wedding workout schedule per role and prep weeks

### 13B.2 Wedding Onboarding Flow
- [x] 🆕🟡 Build `/wedding-planner/setup` — 6-step onboarding (see UI spec Section 7.14):
  - [x] **Step 1** — Role selection: Bride / Groom / Guest / Relative (illustrated 4-card grid)
  - [x] **Step 1b** — Relation type (shown only if Relative selected): Father/Mother of Bride/Groom / Sibling / Close Family
  - [x] **Step 2** — Wedding date range picker (`DateRangePicker`, max 14 days, validates end ≥ start)
    - [x] Show warning if date range overlaps with an active festival (amber notice, not a blocker)
  - [x] **Step 3** — Event multi-select: Haldi / Mehendi / Sangeet / Baraat / Vivah / Reception (checkbox grid)
  - [x] **Step 4** — Prep time: 1 week / 2 weeks / 4 weeks / 8 weeks / Already wedding week
  - [x] **Step 5** — Primary goal (role-aware options): Look my best / Feel energised / Manage stress (Bride/Groom) OR Manage indulgence / Stay active / Maintain routine (Guest/Relative)
  - [x] **Step 6** — Summary confirmation screen with "Start My Wedding Plan" CTA
  - [x] On completion: write `WeddingEvents` record to Drift → enqueue Appwrite sync → award `+100 XP`

### 13B.3 Wedding Planner Screens
- [x] 🆕🟡 Build `WeddingPlannerHomeScreen` `/wedding-planner` — gold gradient hero; phase progress card; today's diet + workout card; event countdown strip; wedding tips InsightCard variant; grocery list CTA (see UI spec Section 7.14)
- [x] 🆕🟡 Build `WeddingEventDayScreen` `/wedding-planner/event/{eventKey}` — pre-event meal plan; during-event tips; post-event recovery meal; calorie budget + dance burn estimate; quick log CTA (see UI spec Section 7.14)
- [x] 🆕🟡 Build `WeddingFitnessPlanScreen` `/wedding-planner/fitness` — week-by-week workout schedule table; phase-appropriate workout intensity; "This week's plan" highlighted
- [x] 🆕🟡 Build `WeddingRecoveryScreen` `/wedding-planner/recovery` — 3-day detox plan; gradual calorie return chart; gentle workout plan; archive CTA (see UI spec Section 7.14)
- [x] 🆕🟢 Build `WeddingGroceryListScreen` `/wedding-planner/groceries` — auto-generated shopping list for wedding week meals; Swiggy/Blinkit deep-links

### 13B.4 Wedding Dashboard Integration
- [x] 🆕🟡 When `weddingStartDate ≤ today ≤ weddingEndDate`, replace the standard `InsightCard` on the Dashboard with `WeddingCountdownCard` (gold gradient):
  - [x] Shows: days to next event + role + current phase + today's key diet tip
  - [x] "View Full Plan" → `/wedding-planner`
  - [x] "Log Today's Meals" → `/home/food`
- [ ] 🆕🟢 Push notification morning of each wedding event day — e.g. *"Today is your Sangeet! 💃 Here's your energy meal plan for the day."* Triggered by `flutter_local_notifications` scheduled at `weddingStartDate` calculation time
- [ ] 🆕🟢 Push notification 1 week before `weddingStartDate` — "Wedding countdown starts! Your pre-wedding plan is ready."
- [ ] 🆕🟢 Add **Festival/Wedding Countdown home screen widget** (2×2) — shows active festival OR wedding countdown, whichever is sooner; wedding takes priority if both active; updates daily from Drift

### 13B.5 Wedding + Festival Overlap Logic
- [x] 🆕🟡 In `FestivalDietEngine.getActiveDietConfig()` — check if a wedding plan is also active:
  - [x] If both active: wedding role plan takes precedence for calorie targets and workout plan
  - [x] Festival fasting rules shown as optional modifier (informational only, not enforced)
  - [x] Insight card merges both contexts with a combined message
  - [x] Allowed food list = union of `weddingAllowedFoods` and `festivalAllowedFoods`
- [ ] 🆕🟢 Write a unit test for each overlap scenario: Diwali+wedding, Navratri+wedding, Ramadan+wedding

---

## Phase 14 — Social & Community Modules
- [ ] 🟡 Build `SocialFeedScreen` — post workouts/meals/milestones, like and comment
- [ ] 🟡 Follow system — follow users, see their public posts in the main feed
- [ ] 🟡 Build `CommunityGroupsScreen` — create/join groups (diet, location, sport, challenge, support)
- [ ] 🟡 Group feed, group challenges, group leaderboard
- [ ] 🟡 Direct Messaging (DMs) — one-to-one messaging
- [ ] 🟢 Verified nutritionist / trainer badge on professional accounts
- [ ] 🆕🟡 **Seasonal leaderboards tied to the Indian festival calendar** — auto-create festival-scoped leaderboards from `festival_calendar` data (Phase 13A.6); Navratri Steps, Diwali Mithai Budget, Ramadan Wellness, Holi Steps, Onam Sadhya challenges; surface in Karma tab when festival is within 7 days

---

## Phase 15 — Family Health Profiles
- [ ] 🟡 Family admin can invite up to 5 members (Family plan only)
- [ ] 🟡 Admin has view-only access to each member's summary (not raw logs)
- [ ] 🟡 Weekly step leaderboard across family members
- [ ] 🟡 Family challenges — 7-day step goal, water challenge, screen-free morning
- [ ] 🟢 Group push notifications via Appwrite Functions

---

## Phase 16 — Wearable Integrations
- [ ] ⚡🟡 Health Connect (Android) + HealthKit (iOS) via `health` package — steps, sleep, HR, SpO2, BP
- [ ] 🔴 Fitbit Web API — OAuth2 flow; keep `client_secret` in Appwrite Function only 🔒
- [ ] 🔴 Garmin Connect IQ — OAuth1; keep secret in Appwrite Function only 🔒
- [ ] 🟡 Mi Band / boAt — bridge through Health Connect
- [ ] 🟡 Delta sync on app resume — only fetch data since `last_sync_at`
- [ ] 🟢 Low Data Mode: reduce wearable sync to 6-hour intervals

### 16.1 Wear OS Companion App (Android watch)
> Separate Wear OS module; communicates with phone via Wearable Data Layer API
- [ ] 🔴 Watch face complication — step ring progress + heart rate zone badge (Circular Small + Modular Small variants)
- [ ] 🔴 Activity tile — step ring, calories ring, water counter; tap opens phone app
- [ ] 🔴 Water complication — tap `+1 glass`; write to `DataClient` DataMap; phone app reads and syncs to Drift (idempotent, 5-second debounce)
- [ ] 🔴 Workout tile — Start / Stop GPS workout; live HR zone display via `ChannelClient`
- [ ] 🟡 Use `WearableListenerService` on the phone to receive watch events and write to Drift

### 16.2 watchOS Companion App (Apple Watch)
> watchOS Extension; communicates with phone via `WatchConnectivity` (`WCSession`)
- [ ] 🔴 Complication — step ring progress (Circular Small / Modular Small variants)
- [ ] 🔴 Quick-log water widget — tap to +1 glass; `WCSession.sendMessage` to phone
- [ ] 🔴 Workout widget — Start / Stop with live HR from HealthKit
- [ ] 🟡 Background stat push via `WCSession.transferUserInfo` (battery-efficient, not real-time)

---

## Phase 17 — Platform & Infrastructure

### 17.1 Emergency Health Card
- [ ] ⚡🟡 Build the Emergency Card screen — blood group, allergies, conditions, medications, emergency contact
- [ ] 🆕🟢 **Accessible from home screen widget** — link the lock screen widget directly to the Emergency Card
- [ ] 🔒🟢 Store **locally only** — no Appwrite sync ever
- [ ] 🟡 Export as PDF or QR code

### 17.2 Festival Fitness Calendar
- [ ] 🟡 Hardcode Indian festival database — Navratri, Ramadan, Diwali, Karwa Chauth, Holi (zero API dependency)
- [ ] 🟡 Navratri: 9-day fasting guide + Garba calorie tracker
- [ ] 🟡 Ramadan: Sehri/Iftar planner (integrates with Fasting Tracker)
- [ ] 🟡 Diwali: sweet calorie tracker + healthy alternatives
- [ ] 🟢 Auto push notification 3 days before each festival

### 17.3 Automated Health Reports
- [ ] 🟡 Auto-generate weekly/monthly PDF reports using the `pdf` package in a Dart isolate
- [ ] 🔒🟡 Save PDF **locally only** — never upload to Appwrite Storage
- [ ] 🟢 Doctor-friendly format — medical metrics with reference ranges clearly labelled
- [ ] 🟢 Share/print PDF from the Reports screen
- [ ] 🆕🟡 **Doctor shareable health link** — generates a time-limited, read-only summary URL:
  - [ ] Appwrite Function creates a temporary public document (expires in 7 days) with a clean read-only health summary: 30-day BP trend, glucose log, weight trend, key lab values
  - [ ] User taps "Share with Doctor" → copies or WhatsApp-shares the URL
  - [ ] Doctor opens it in any browser — no login required
  - [ ] URL auto-expires; user can revoke early from Reports screen
  - [ ] Only aggregate stats are shared — no raw log entries, no journal, no period data 🔒

### 17.4 Personal Records Tracker
- [ ] 🟡 Auto-detect new PRs from workout logs (max lift per exercise, fastest 5K, longest run)
- [ ] 🟡 PR celebration notification
- [ ] 🟡 PR history chart per exercise
- [ ] 🟢 Award +100 XP for any new PR

### 17.5 Referral Program
- [ ] 🟡 Generate unique referral code at registration — store in `users.referral_code`
- [ ] 🟡 Referrer receives +500 XP when referred user completes onboarding
- [ ] 🟡 Referred user receives +100 XP on signup
- [ ] 🟢 Referral leaderboard in Karma Hub

### 17.6 Low Data Mode
- [ ] 🟡 Toggle in Settings — disable image loading, reduce sync to every 6 hours
- [ ] 🟢 Auto-detect connection speed and enable automatically on slow connections
- [ ] 🟢 Compress images to ≤ 200 KB before upload when in Low Data Mode

---

## Phase 18 — Appwrite Backend Setup
> *Most of this is done in the Appwrite Console, not in Flutter code.*

- [ ] ⚡🟡 Create the **two** Appwrite Databases — one for staging, one for production — note both `DATABASE_ID`s
- [ ] 🟡 Create all **core collections**: `users`, `food_logs`, `food_items`, `workout_logs`, `step_logs`, `sleep_logs`, `mood_logs`, `period_logs`, `medications`, `habits`, `body_measurements`, `karma_transactions`, `nutrition_goals`, `posts`, `challenges`, `subscriptions`, `family_groups`, `workouts`
- [ ] 🟡 Create all **extended collections**: `blood_pressure_logs`, `glucose_logs`, `spo2_logs`, `doctor_appointments`, `fasting_logs`, `meal_plans`, `recipes`, `journal_entries`, `personal_records`, `community_groups`, `health_reports`, `community_dms`
- [ ] 🆕🟡 Create `remote_config` collection — single document with feature flags and rule overrides (readable by all authenticated users; writable only by admin role)
- [ ] 🔒🔴 Set `Role.user({userId})` read + write permissions on **every collection** — no admin read on sensitive collections
- [ ] 🆕🔴 Add all composite indices listed in Phase 3.7 — do this in the Appwrite Console before seeding any data
- [ ] 🟡 Enable Google OAuth2 in Auth → OAuth2 Providers
- [ ] 🟡 Enable SMTP in Settings → SMTP (for password reset emails)
- [ ] 🟡 Create Storage buckets: `avatars` and `posts_media`
- [ ] 🆕🟡 Create Storage bucket: `health_reports_share` — public read (for shareable doctor links), write via Function only; TTL 7 days enforced by a scheduled cleanup Function. Matches `AW.healthReportsBucket` constant in the app.
- [ ] 🔴 Deploy Appwrite Function: **FCM Push Notifications**
- [ ] 🔴 Deploy Appwrite Function: **Razorpay Webhook**
- [ ] 🔴 Deploy Appwrite Function: **Fitbit Token Exchange** 🔒
- [ ] 🔴 Deploy Appwrite Function: **Garmin Token Exchange** 🔒
- [ ] 🆕🔴 Deploy Appwrite Function: **Lab Report Extractor** — receives OCR text, calls LLM API, returns structured health key-value pairs 🔒
- [ ] 🆕🔴 Deploy Appwrite Function: **Doctor Share Link Generator** — creates time-limited public document, schedules cleanup 🔒
- [ ] 🔒🟡 Store all secrets as Appwrite Function environment variables — **never in the Flutter app**
- [ ] 🟡 Configure API rate limiting in the Appwrite Console
- [ ] 🟡 Set up daily database export cron for disaster recovery → Backblaze B2

---

## Phase 19 — Monetization (Razorpay)
- [ ] 🟡 Add Razorpay keys (`RAZORPAY_KEY_ID`) to `.env` — key secret goes to Appwrite Function only 🔒
- [ ] 🟡 Build `SubscriptionScreen` — show Free / Monthly / Quarterly / Yearly / Family plan cards
- [ ] 🔴 Implement subscription purchase flow
- [ ] 🔴 Implement Razorpay webhook in Appwrite Function — verify HMAC signature before updating `subscriptions` collection
- [ ] 🟡 Implement free-tier data archival — show data for 7 days, archive older records, restore on upgrade
- [ ] 🟢 À la carte workout pack purchases (one-time payment)
- [ ] 🆕🟢 **UPI deep-link shortcut** — add a "Pay with UPI" button that constructs a `upi://pay?...` deep-link to bypass the Razorpay checkout modal for users who prefer direct UPI app payment

---

## Phase 20 — Localisation (22+ Indian Languages)
- [ ] 🟡 Configure `flutter_localizations` in `pubspec.yaml` and `app.dart`
- [ ] 🔴 Create `.arb` files for all 22 scheduled languages: `app_en.arb`, `app_as.arb`, `app_bn.arb`, `app_brx.arb`, `app_doi.arb`, `app_gu.arb`, `app_hi.arb`, `app_kn.arb`, `app_ks.arb`, `app_kok.arb`, `app_mai.arb`, `app_ml.arb`, `app_mni.arb`, `app_mr.arb`, `app_ne.arb`, `app_or.arb`, `app_pa.arb`, `app_sa.arb`, `app_sat.arb`, `app_sd.arb`, `app_ta.arb`, `app_te.arb`, `app_ur.arb`
- [ ] 🟡 Add all string keys to `app_en.arb` first
- [ ] 🔴 Translate all strings — use professional translators or community contributors (not just Google Translate) for all 22 languages
- [ ] 🟡 Verify rendering for all major Indian scripts (Devanagari, Bengali, Tamil, Telugu, Kannada, etc.) on both Android and iOS

---

## Phase 21 — Accessibility
- [ ] 🟡 Add `Semantics` widgets to all interactive elements — screen reader support
- [ ] 🟢 Test with TalkBack (Android) and VoiceOver (iOS)
- [ ] 🟢 Ensure all text scales correctly when the system font size is increased to 200%
- [ ] 🟢 Build high-contrast mode — add a toggle in Settings (black/white with orange accents only; no gradients)
- [ ] 🆕🟢 **Verify dark mode** on all 35+ screens — the dark token set from Phase 2.1 must render without white-on-white or invisible-text issues
- [ ] 🟡 **Enhanced Media Accessibility:** Provide descriptive audio tracks for all workout videos
- [ ] 🔴 **Voice Commands:** Implement comprehensive voice commands for hands-free logging and navigation
- [ ] 🟡 **Advanced UI Customization:** Add options for a dyslexia-friendly font and user-adjustable colour contrasts

---

## Phase 22 — Testing
> *Write tests alongside the feature, not after the whole app is done.*

### Unit Tests (target ≥ 60% coverage for `/data/` and `/domain/`)
- [ ] 🟡 TDEE / BMR formula — all goal types and activity factors
- [ ] 🟡 Blood pressure `classify()` — all AHA threshold boundaries
- [ ] 🟡 Glucose `classifyFasting()` and `classifyPostMeal2h()`
- [ ] 🟡 Dosha quiz scoring algorithm
- [ ] 🔴 AES-256 round-trip — encrypt then decrypt all sensitive models (period, journal, BP, glucose, appointments)
- [ ] 🆕🟡 **HKDF key derivation** — verify that each data class produces a unique, deterministic key from the same master key; verify no two class keys are equal
- [ ] 🟡 Karma XP accumulation with streak multipliers
- [ ] 🟡 Fasting stage machine — in-progress, completed, broken states
- [ ] 🟡 Recipe calorie + micronutrient auto-calculation from ingredient list
- [ ] 🟡 Sync conflict resolution for all tiers from the conflict matrix
- [ ] 🟢 Referral code uniqueness (collision probability test)
- [ ] 🆕🟡 **Idempotency key generation** — same input always produces same key; different inputs always produce different keys
- [ ] 🆕🟢 **Cross-module correlation rules** — mock Drift data for a known pattern (e.g. 5 nights of poor sleep + low mood) and verify the correct insight fires

### Widget Tests
- [ ] 🟡 `ActivityRingsWidget` — various progress levels (0%, 50%, 100%, overflow)
- [ ] 🟡 `BPTrendChart` — correct colour banding for all AHA classifications
- [ ] 🟡 `FastingProgressRing` — correct phase labels and countdown
- [ ] 🟡 `GlucoseHistoryChart` — target bands per reading type
- [ ] 🟡 `DoshaDonutChart` — segment proportions for all dosha combinations
- [ ] 🟢 `ShimmerLoader` and `AsyncValueWidget` — render in all async states
- [ ] 🟢 `MoodEmojiSelector` — tap selection and slider interactions

### Integration Tests
- [ ] 🔴 Full food log flow — search (FTS5 on Drift) → select → confirm → verify Drift write → verify sync queue entry
- [ ] 🔴 Offline → online sync — log items offline, restore connectivity, verify Appwrite document created with correct idempotency key
- [ ] 🔴 Auth flow — register → onboarding → dashboard loads from Drift
- [ ] 🔴 Period encryption — log entry → read back → verify decryption → verify raw database bytes are not plaintext
- [ ] 🔴 BP log flow — log → AES encryption with HKDF key → correct AHA classification displayed
- [ ] 🔴 Fasting flow — start → advance time → eat → verify completion and XP awarded
- [ ] 🟡 Recipe builder — add ingredients → calculate macros + micronutrients → save → log → verify totals
- [ ] 🟡 Meal planner → food log — plan a meal → log it → verify `log_method: planner`
- [ ] 🟡 Referral flow — generate code → sign up with code → verify XP awarded to both parties
- [ ] 🆕🔴 **DLQ flow** — simulate 5 failed sync retries; verify item moves to dead-letter table; verify it surfaces in Settings
- [ ] 🆕🟡 **Doctor share link** — trigger share → verify Appwrite Function creates document → verify URL expires after 7 days

### Performance Benchmarks
- [ ] 🟡 Dashboard cold start < 2s on a 3 GB RAM device
- [ ] 🆕🟡 Drift food FTS5 search < 200ms against a 10,000-item database (target matches Section 18 performance contract)
- [ ] 🟡 Sync queue flush — 20 records < 5s on a 3G connection
- [ ] 🟡 PDF report generation < 3s for a 30-day report
- [ ] 🟢 BP/Glucose chart render < 300ms with 90 data points
- [ ] 🟢 Memory leak check — food log screen after 50 entries
- [ ] 🆕🟢 Cross-module correlation query < 50ms (single Drift SQL join across 3 tables, 90 days of data)

---

## Phase 23 — CI/CD Pipeline
- [ ] ⚡🟡 Create `.github/workflows/ci.yml` — copy the GitHub Actions workflow from Section 24
- [ ] 🆕🟡 Add `dart fix --apply` step **before** `flutter analyze` in the CI workflow
- [ ] 🟡 Add `APPWRITE_PROJECT_ID`, `APPWRITE_DATABASE_ID` as GitHub repository secrets — **two sets: staging and production**
- [ ] 🟡 Add `RAZORPAY_KEY_ID`, Fitbit/Garmin client IDs as GitHub secrets
- [ ] 🔴 Add `.env.prod` to GitHub secrets (never commit the file itself)
- [ ] 🆕🟡 **Separate staging and production deploy jobs**:
  - [ ] `develop` branch → deploy to Appwrite staging project
  - [ ] `main` branch → deploy to Appwrite production project (requires manual approval gate)
- [ ] 🆕🟡 **App bundle size gate** — add a CI step that fails the build if the release AAB exceeds 50 MB:
  ```bash
  flutter build appbundle --release --dart-define-from-file=.env.prod
  size=$(stat -c%s build/app/outputs/bundle/release/app-release.aab)
  [ $size -le 52428800 ] || (echo "AAB exceeds 50 MB: $size bytes" && exit 1)
  ```
- [ ] 🆕🟢 **Semantic versioning automation** — use `standard-version` or `semantic-release` so `CHANGELOG.md` and `pubspec.yaml` version are auto-bumped from conventional commit messages
- [ ] 🟡 Configure Codecov to track test coverage (target ≥ 60% for data + domain layers)
- [ ] 🟡 Deploy Appwrite Functions via CLI in CI
- [ ] 🟢 Set up the daily backup cron (Appwrite DB export → Backblaze B2)
- [ ] 🆕🟡 **iOS code signing** — add provisioning profile setup to the `build_ios` job:
  - [ ] Store `PROVISIONING_PROFILE_BASE64` and `CERTIFICATE_BASE64` as GitHub secrets
  - [ ] Decode and install in the macOS runner before `flutter build ipa`

---

## Phase 24 — Pre-Launch Checklist
- [ ] 🔒🔴 Final security audit — check every Appwrite collection has correct `Role.user(uid)` permissions
- [ ] 🔒🔴 Verify no secrets are hardcoded in Flutter source: `grep -rn "client_secret\|api_key\|private_key" lib/`
- [ ] 🔒🟡 Verify `.env` is in `.gitignore` — run `git log --all -- .env` to confirm it was never committed
- [ ] 🆕🔒🔴 **Verify HKDF key separation** — decrypt a BP record with the period key and confirm it fails; decrypt with the BP key and confirm it succeeds
- [ ] 🔴 Verify sensitive data in Drift is actually encrypted — read raw database bytes and confirm they are not plaintext JSON
- [ ] 🔴 Test payment flow end-to-end in Razorpay **test mode** before enabling live keys
- [ ] 🟡 Verify installed app size < 50 MB — run `flutter build appbundle --release` and check output
- [ ] 🟡 Cold start benchmark < 2s on a real mid-range device (not a simulator)
- [ ] 🟡 Test offline mode thoroughly — enable airplane mode and use every core feature
- [ ] 🟡 Test on a real 2G/3G connection with Low Data Mode enabled
- [ ] 🟢 Verify all 8+ language `.arb` files are complete — no missing keys
- [ ] 🟢 Test with TalkBack / VoiceOver — all interactive elements reachable
- [ ] 🆕🟡 **Verify dark mode** on a real device — check all 35+ screens with system dark mode enabled
- [ ] 🆕🟡 **Certificate pinning smoke test** — intercept traffic with a proxy (e.g. Charles); confirm the app refuses connections when the pinned cert does not match
- [ ] 🆕🟢 **Verify home screen widgets** render correctly on Android 12+ and iOS 16+
- [ ] 🟢 Submit to Google Play (internal track first) and Apple App Store (TestFlight first)
- [ ] 🟢 Set up Sentry DSN and verify crash reports are coming through from the production build

---

## Phase 25 — Advanced AI & Personalisation
> *Evolve the on-device rule engine into a learning-based system for deeper personalisation.*
- [ ] 🔴 **ML Insight Engine:** Transition the `RuleEvaluator` to support a true ML-based model alongside the rule engine
  - [ ] 🟡 **Predictive Insights:** Develop models to predict potential burnout, workout plateaus, and fatigue using the cross-module data from Drift
  - [ ] 🔴 **Dynamic Plan Adjustments:** Automatically adjust nutrition and workout plans based on logged mood, sleep, RPE, and performance data
  - [ ] 🔴 **Smart Recipe Suggestions:** AI-powered recipe suggestion based on user goals, preferences, micronutrient gaps, and a new 'pantry' feature
- [ ] 🟡 **Expanded Integrations:**
  - [ ] 🟡 Integrate with smart kitchen scales for automatic food weight logging
  - [ ] 🟢 Allow users to connect Spotify/Apple Music for workout playlists
  - [ ] 🟡 Sync workout schedules with the user's native calendar app

---

## Phase 26 — Community & Gamification V2
> *Increase user engagement and retention with more dynamic social and reward features.*
- [ ] 🟡 **Advanced Group Challenges:** Implement "Team vs. Team" and "Region vs. Region" challenges
- [ ] 🟡 **Social Rewards:** Grant Karma XP for positive social interactions (receiving likes, helpful comments)
- [ ] 🟡 **Expanded Achievement System:** Introduce a wider variety of achievement badges for specific milestones
- [ ] 🟡 **Real-World Rewards:** Form partnerships to offer real-world discounts in the Karma Store
- [ ] 🟡 **Targeted Leaderboards:** More specific niche leaderboards (e.g. "Most Consistent Yogi," "Top Stepper in Mumbai")
- [ ] 🆕🟡 **WhatsApp logging bot** (lower priority — implement after Phase 22 test coverage is solid):
  - [ ] Appwrite Function connected to WhatsApp Cloud API webhook
  - [ ] User sends "dal rice lunch" → bot calls food search → returns calorie info + logs entry
  - [ ] Responses bilingual — detect user's preferred language from profile

---

## 📌 Quick Reference

| Phase | What you're building | Rough effort |
|-------|---------------------|-------------|
| 0–1 | Environment + scaffold (with Drift + staging env) | 2–3 days |
| 2 | Theme + dark mode + shared widgets | 3–5 days |
| 3 | Core infrastructure (Drift, HKDF encryption, sync queue, cert pinning) | 4–6 days |
| 4 | Auth + onboarding | 3–5 days |
| 5 | Dashboard + home screen widgets | 3–4 days |
| 6 | Food logging + micronutrients + FTS5 search | 1–2 weeks |
| 7–8 | Steps + Karma (with streak recovery) | 3–5 days |
| 9–10 | Workouts (+ rest timer, RPE, offline maps) + Nutrition | 1–2 weeks |
| 11 | Insight Engine (modular + cross-module correlations) | 1–2 weeks |
| 12 | Health modules (+ lab OCR, prescription scan, ABHA) | 2–3 weeks |
| 13 | Lifestyle & wellness (+ sleep debt, chronotype, journal sentiment) | 2–3 weeks |
| **13A** | **Festival Calendar — dynamic dates engine, 30+ festivals, diet configs, Garba tracker** | **1–2 weeks** |
| **13B** | **Wedding Planner — role setup, date range, event plans, bride/groom/guest/relative diets** | **1–2 weeks** |
| 14–15 | Social + Family | 2–3 weeks |
| 16 | Wearables (+ Wear OS + watchOS companion apps) | 3–4 weeks |
| 17 | Platform + infrastructure (+ doctor share links) | 1–2 weeks |
| 18–19 | Appwrite backend + Razorpay + UPI deep-link | 1 week |
| 20–21 | i18n + Accessibility (+ dark mode verification) | 1–2 weeks |
| 22–24 | Testing + CI/CD (+ size gate, iOS signing) + Launch | 1–2 weeks |
| 25–26 | Advanced AI & Community V2 | 2–3 weeks |

---

## 📐 Architecture Decisions Summary

> Quick reference for key architectural decisions in FitKarma.

| Area | Decision | Rationale |
|------|----------|-----------|
| Local data storage | **Drift (SQLite)** for all structured and encrypted data | Type-safe DAOs, FTS5 full-text search, reactive streams, migration support, cross-module SQL joins |
| Encrypted local storage | **SQLCipher field-level encryption** (Drift) + HKDF per-class keys | Per-class key isolation — compromise of one key does not expose other data classes |
| Sync reliability | Idempotency keys + dead-letter queue + per-field version vectors | Prevents duplicate writes on retry; surfaces unresolvable failures; avoids full-record overwrites |
| Encryption key derivation | **Device-anchored** (device_id + install_uuid + salt via PBKDF2) | Password changes do not invalidate encrypted data; OAuth-only users still get encrypted storage |
| Certificate pinning | SHA-256 fingerprint on Appwrite domain; cert rotatable via Remote Config | Prevents MITM attacks; cert rotation without an app release |
| Feature flags | **First-class `RemoteConfig` layer** with A/B + staged rollout + kill-switch | Toggle any feature, update insight rules, or kill-switch a module — no app update required |
| Insight engine | **Modular rule registry** + cross-module correlation rules + server-delivered rules | Rules are isolated, testable, and updatable independently without touching the evaluator |
| Provider architecture | `keepAlive: false` + route-scoped providers + `CancelToken` on long operations | Prevents provider accumulation across 35+ modules; GC on pop; cancels in-flight requests |
| Background sync | WorkManager + **isolate-safe init** + Doze mode awareness | Background isolates do not share the main ProviderContainer; avoids waking radio unnecessarily |
| Database indices | **Composite indices** on all log collections (Appwrite + Drift) | Required for dashboard < 1s load with real user data at scale |
| App bundle size | **Deferred loading** for 5 heavy modules | Keeps install size < 50 MB; enforced as a CI gate |
| CI/CD | Staging/prod split + 50 MB size gate + iOS signing + semantic versioning | Prevents unvalidated deploys; enforces size contract; automates release notes |
| Dark mode | **Complete dark token set** for all 35+ screens | Dark mode is designed alongside light mode — never auto-inverted |
| Festival dates | **Algorithmic computation** (Meeus Hindu lunisolar + Umm al-Qura Islamic + Gregorian computus) pre-computed for ±2 years; cached in Drift `festival_calendar`; refreshed Jan 1 via Appwrite Function | Zero runtime API dependency; dynamic dates — never stale hardcoded strings; fallback static JSON for 2024–2030 |
| Wedding planner | **Role-based, phase-aware, event-by-event** diet and fitness plans; stored in `wedding_events` Drift table; all plan computation on-device via `WeddingDietEngine` | Covers Bride, Groom, Guest, and 6 Relative types; multi-event support (Haldi, Mehendi, Sangeet, Baraat, Vivah, Reception); festival+wedding overlap handled gracefully |

---

*FitKarma · Flutter · Riverpod · Drift (SQLCipher) · Appwrite · Built for India*
*Offline-first · Privacy-centric · 30+ modules · Full bilingual UI*