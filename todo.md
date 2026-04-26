# FitKarma — Master TODO

> Tracks every screen, module, function, widget, provider, collection, and asset defined in the documentation.
> Check off items as they are implemented. Every unchecked item is a gap between docs and code.

**Legend:** `[ ]` Not started · `[~]` In progress · `[ ]` Done · `[!]` Blocked

---

## Table of Contents

1. [Project Bootstrap](#1-project-bootstrap)
2. [Core Layer](#2-core-layer)
3. [Appwrite Backend — CLI Setup](#3-appwrite-backend--cli-setup)
4. [Appwrite Functions](#4-appwrite-functions)
5. [Database — Drift Local Tables](#5-database--drift-local-tables)
6. [State Management — Providers & Notifiers](#6-state-management--providers--notifiers)
7. [Sync Engine](#7-sync-engine)
8. [Shared Widget Library](#8-shared-widget-library)
9. [Navigation & Routing](#9-navigation--routing)
10. [Screens — Onboarding & Auth](#10-screens--onboarding--auth)
11. [Screens — Core Dashboard & Karma](#11-screens--core-dashboard--karma)
12. [Screens — Food & Nutrition](#12-screens--food--nutrition)
13. [Screens — Workout](#13-screens--workout)
14. [Screens — Steps & Activity](#14-screens--steps--activity)
15. [Screens — Health Monitoring](#15-screens--health-monitoring)
16. [Screens — Lab Reports & ABHA](#16-screens--lab-reports--abha)
17. [Screens — Lifestyle Trackers](#17-screens--lifestyle-trackers)
18. [Screens — Wellness](#18-screens--wellness)
19. [Screens — Social & Community](#19-screens--social--community)
20. [Screens — Reports & Wearables](#20-screens--reports--wearables)
21. [Screens — Family & Emergency](#21-screens--family--emergency)
22. [Screens — Settings & Profile](#22-screens--settings--profile)
23. [Screens — Festival & Wedding](#23-screens--festival--wedding)
24. [Screens — Home Widgets](#24-screens--home-widgets)
25. [Health Integrations](#25-health-integrations)
26. [Security & Encryption](#26-security--encryption)
27. [Notifications](#27-notifications)
28. [Assets — Lottie & Rive](#28-assets--lottie--rive)
29. [Assets — Fonts](#29-assets--fonts)
30. [Accessibility & Bilingual](#30-accessibility--bilingual)
31. [Testing](#31-testing)
32. [CI/CD](#32-cicd)
33. [Performance & Device Tier](#33-performance--device-tier)
34. [Data Seeding](#34-data-seeding)

---

## 1. Project Bootstrap

### 1.1 Flutter Project Init

- [x] `flutter create fitkarma --org com.fitkarma --platforms android,ios`
- [x] Set `minSdkVersion 26` in `android/app/build.gradle` (Health Connect requires API 26+)
- [x] Set iOS deployment target to 14.0 in `ios/Podfile`
- [x] Add all dependencies to `pubspec.yaml` (30+ packages as per §18)
- [x] Run `flutter pub get`
- [x] Run initial `dart run build_runner build --delete-conflicting-outputs`
- [x] Commit baseline with passing `flutter analyze`

### 1.2 Appwrite CLI Bootstrap

- [x] Install Appwrite CLI (`curl -sL https://appwrite.io/cli/install.sh | bash`)
- [x] `appwrite login` (interactive, store session)
- [x] `appwrite init project` — create `appwrite.json` in repo root
- [x] Commit `appwrite.json`

### 1.3 Environment & Secrets

- [x] Create `.env.local` with `APPWRITE_ENDPOINT`, `APPWRITE_PROJECT_ID`, `APPWRITE_DB_ID`
- [x] Add `.env.local` to `.gitignore`
- [x] Configure `AppConfig` dart-define values (§23.2)
- [ ] Add GitHub Actions secrets: `APPWRITE_ENDPOINT`, `APPWRITE_PROJECT_ID`, `APPWRITE_API_KEY`
- [ ] Add GitHub Actions secrets: `ABHA_CLIENT_ID`, `ABHA_CLIENT_SECRET`

### 1.4 Android Manifest

- [x] `INTERNET` permission
- [x] `ACCESS_NETWORK_STATE` permission
- [x] `health.READ_STEPS` permission
- [x] `health.READ_HEART_RATE` permission
- [x] `health.READ_SLEEP_SESSION` permission
- [x] `ACCESS_FINE_LOCATION` permission (GPS workouts)
- [x] `ACCESS_COARSE_LOCATION` permission
- [x] Health Connect `<queries>` package declaration
- [x] Home widget `<receiver>` declaration for `StepsWidgetProvider`
- [x] Home widget `<meta-data>` pointing to `@xml/steps_widget_info`

### 1.5 iOS `Info.plist`

- [x] `NSHealthShareUsageDescription`
- [x] `NSHealthUpdateUsageDescription`
- [x] `NSLocationWhenInUseUsageDescription`
- [x] `NSCameraUsageDescription` (OCR lab scan)
- [x] `NSPhotoLibraryUsageDescription`
- [x] `NSFaceIDUsageDescription` (biometric lock)

---

## 2. Core Layer

### 2.1 Theme System — `lib/core/theme/`

- [x] `app_colors.dart` — `AppColorsDark` class (all 24 dark tokens)
- [x] `app_colors.dart` — `AppColorsLight` class (all 14 light tokens)
- [x] `app_typography.dart` — all 17 named `TextStyle` builders
- [x] `app_typography.dart` — `darkTextTheme()` and `lightTextTheme()` wired to `ThemeData`
- [x] `app_spacing.dart` — `AppSpacing` and `AppRadius` constants
- [x] `app_gradients.dart` — `heroDeep`, `heroSleep`, `heroFestival`, `heroWedding`, `heroPrimary`, `glassHero`
- [x] `app_springs.dart` — `light`, `standard`, `dramatic` spring descriptions
- [x] `app_theme.dart` — `AppTheme.dark()` full `ThemeData`
- [x] `app_theme.dart` — `AppTheme.light()` full `ThemeData`

### 2.2 Configuration — `lib/core/config/`

- [x] `app_config.dart` — dart-define constants for endpoint, project ID, DB ID
- [x] `device_tier.dart` — `DeviceTier` enum (`low`, `mid`, `high`)
- [x] `user_experience_stage.dart` — `UXStage` enum + `getUXStage(DateTime)` function

### 2.3 Providers — `lib/core/providers/`

- [ ] `core_providers.dart` — `appwriteClientProvider` (singleton `Client`)
- [ ] `core_providers.dart` — `appwriteAccountProvider`
- [ ] `core_providers.dart` — `appwriteDatabasesProvider`
- [ ] `core_providers.dart` — `appwriteStorageProvider`
- [ ] `core_providers.dart` — `appDatabaseProvider` (override in `ProviderScope`)
- [ ] `device_tier_provider.dart` — `deviceTierProvider`
- [ ] `ux_stage_provider.dart` — `uxStageProvider` (mocked for now)
- [ ] `low_data_mode_provider.dart` — `LowDataModeNotifier` + `lowDataModeProvider`

### 2.4 Router — `lib/core/router/`

- [ ] `app_router.dart` — `GoRouter` with all 25 registered routes
- [ ] `app_router.dart` — `redirect` guard: unauthenticated → `/auth/login`, authenticated + auth screen → `/home/dashboard`
- [ ] `transitions.dart` — `VerticalSlideTransition` (fade + 6% Y shift, 320ms)
- [ ] `transitions.dart` — `CardTapAnimation` widget (scale 1.0 → 0.97 → 1.0)

### 2.5 Security — `lib/core/security/`

- [ ] `biometric_service.dart` — `BiometricService.authenticate()` with `local_auth`
- [ ] `sensitive_screen_guard.dart` — `SensitiveScreenGuard` wrapper widget

### 2.6 Database — `lib/core/storage/`

- [ ] `app_database.dart` — `AppDatabase` class annotated with `@DriftDatabase`
- [ ] `app_database.dart` — `_openConnection` with SQLCipher + secure key
- [ ] `app_database.dart` — schema version + `MigrationStrategy`
- [ ] Run `dart run build_runner build` to generate `app_database.g.dart`

---

## 3. Appwrite Backend — CLI Setup

### 3.1 Database

- [ ] `appwrite databases create --databaseId "fitkarma-db" --name "FitKarma Database"`

### 3.2 Collections — Creation

- [ ] `users` collection
- [ ] `food_logs` collection
- [ ] `bp_readings` collection
- [ ] `glucose_readings` collection
- [ ] `sleep_logs` collection
- [ ] `workouts` collection
- [ ] `habits` collection
- [ ] `journal` collection
- [ ] `lab_reports` collection
- [ ] `karma_events` collection
- [ ] `festivals` collection
- [ ] `medications` collection
- [ ] `water_logs` collection
- [ ] `social_posts` collection
- [ ] `groups` collection
- [ ] `share_tokens` collection *(used by report-share function)*
- [ ] `wedding_plans` collection *(derived from Drift tables — add remote collection)*

### 3.3 Collections — Attributes (run all CLI attribute commands per §24.3)

- [ ] All `users` attributes (16 fields: userId, name, email, gender, dob, heightCm, weightKg, bloodGroup, fitnessGoal, activityLevel, dominantDosha, language, abhaId, abhaLinked, karmaLevel, karmaXP, conditions, firstLaunchTs)
- [ ] All `food_logs` attributes (15 fields)
- [ ] All `bp_readings` attributes (10 fields)
- [ ] All `glucose_readings` attributes (9 fields)
- [ ] All `sleep_logs` attributes (9 fields)
- [ ] All `workouts` attributes (12 fields)
- [ ] All `habits` attributes (9 fields)
- [ ] All `journal` attributes (10 fields)
- [ ] All `lab_reports` attributes (8 fields)
- [ ] All `karma_events` attributes (5 fields)
- [ ] All `festivals` attributes (10 fields)
- [ ] All `medications` attributes (8 fields)
- [ ] All `water_logs` attributes (4 fields)
- [ ] All `social_posts` attributes (7 fields)
- [ ] All `groups` attributes (5 fields)
- [ ] `share_tokens` attributes (token, reportId, userId, expiresAt, used)

### 3.4 Collections — Indexes

- [ ] `users` → `userId_idx` (unique, on `userId`)
- [ ] `food_logs` → `user_date_idx` (key, on `userId, loggedAt`)
- [ ] `bp_readings` → `user_time_idx` (key, on `userId, measuredAt`)
- [ ] `social_posts` → `feed_idx` (key, on `postedAt`)
- [ ] `festivals` → index on `startDate` (for range queries)
- [ ] `karma_events` → index on `userId, occurredAt`

### 3.5 Storage Buckets

- [ ] `lab-reports` bucket (10 MB max, PDF/JPG/PNG, encryption ON, antivirus ON)
- [ ] `avatars` bucket (2 MB max, JPG/PNG/WebP, gzip compression)
- [ ] `social-media` bucket (for social post images, 5 MB, JPG/PNG)

### 3.6 Appwrite Functions — Scaffolding

- [ ] `appwrite functions create --functionId "xp-calculator" --runtime node-20.0`
- [ ] `appwrite functions create --functionId "abha-verify" --runtime node-20.0`
- [ ] `appwrite functions create --functionId "report-share" --runtime node-20.0`

### 3.7 Function Environment Variables

- [ ] `abha-verify` → `ABHA_API_ENDPOINT`
- [ ] `abha-verify` → `ABHA_CLIENT_ID`
- [ ] `abha-verify` → `ABHA_CLIENT_SECRET`
- [ ] `report-share` → `APP_BASE_URL`

### 3.8 Messaging Topics

- [ ] `appwrite messaging createTopic --topicId "health-reminders"`
- [ ] `appwrite messaging createTopic --topicId "karma-events"`
- [ ] `appwrite messaging createTopic --topicId "social-activity"`

### 3.9 Platform Registration

- [ ] Register Android platform (`com.fitkarma.app`)
- [ ] Register iOS platform (`com.fitkarma.app`)

### 3.10 Deploy

- [ ] `appwrite deploy collection --all`
- [ ] `appwrite deploy bucket --all`
- [ ] `appwrite deploy function --all`

---

## 4. Appwrite Functions

### 4.1 XP Calculator — `functions/xp-calculator/`

- [ ] `package.json` with `node-appwrite` dependency
- [ ] `src/main.js` — XP_TABLE constant (all 13 event types defined)
- [ ] `src/main.js` — Input validation (userId, eventType required)
- [ ] `src/main.js` — Create `karma_events` document
- [ ] `src/main.js` — Fetch user's current XP from `users` collection
- [ ] `src/main.js` — `_computeLevel(totalXP)` — all 13 level thresholds + names
- [ ] `src/main.js` — Update user `karmaXP` and `karmaLevel`
- [ ] `src/main.js` — Structured JSON response `{ ok, xpAwarded, totalXP, level }`
- [ ] `src/main.js` — Error logging via `error()` callback

### 4.2 ABHA Verify — `functions/abha-verify/`

- [ ] `package.json` with `node-appwrite` dependency
- [ ] `src/main.js` — ABHA ID format validation (14 digits, strips dashes)
- [ ] `src/main.js` — Step 1: Fetch ABDM OAuth2 token
- [ ] `src/main.js` — Step 1: POST OTP request to ABDM enrollment endpoint
- [ ] `src/main.js` — Step 2: Verify OTP (call ABDM verify endpoint)
- [ ] `src/main.js` — Step 2: Update `users` collection (`abhaId`, `abhaLinked: true`)
- [ ] `src/main.js` — Two-step response: `{ ok, step: 'otp_sent' }` and `{ ok, step: 'linked' }`
- [ ] `src/main.js` — Never log full ABHA ID — mask in logs

### 4.3 Report Share — `functions/report-share/`

- [ ] `package.json` with `node-appwrite` dependency
- [ ] `src/main.js` — Input validation (reportId, userId required)
- [ ] `src/main.js` — `crypto.randomBytes(32).toString('hex')` token generation
- [ ] `src/main.js` — Compute `expiresAt` from `expiryHours` (default 168 = 7 days)
- [ ] `src/main.js` — Create `share_tokens` document
- [ ] `src/main.js` — Construct `shareUrl` from `APP_BASE_URL`
- [ ] `src/main.js` — Response `{ ok, shareUrl, expiresAt }`

---

## 5. Database — Drift Local Tables

### 5.1 Table Definitions — `lib/core/database/app_database.dart`

- [ ] `FoodLogs` table (id, userId, foodName, foodNameLocal, mealType, loggedAt, calories, proteinG, carbsG, fatG, portionUnit, portionQty, source, syncStatus, remoteId, failedAttempts)
- [ ] `BpReadings` table (id, userId, systolic, diastolic, pulse, measuredAt, notes, classification, syncStatus, remoteId, failedAttempts)
- [ ] `GlucoseReadings` table (id, userId, valueMgDl, readingType, measuredAt, classification, linkedFoodLogId, syncStatus, remoteId, failedAttempts)
- [ ] `SleepLogs` table (id, userId, sleepStart, sleepEnd, durationMinutes, qualityScore, source, syncStatus, remoteId, failedAttempts)
- [ ] `Workouts` table (id, userId, name, type, startedAt, durationMinutes, caloriesBurned, distanceKm, avgHeartRate, exercisesJson, syncStatus, remoteId, failedAttempts)
- [ ] `Habits` table (id, userId, name, icon, currentStreak, longestStreak, completedDates JSON, syncStatus, remoteId, failedAttempts)
- [ ] `JournalEntries` table (id, userId, title, body, moodEmoji, moodScore, tags JSON, createdAt, syncStatus, remoteId, failedAttempts)
- [ ] `WeddingPlans` table (id, userId, role, relation, firstEventTs, lastEventTs, eventsJson, prepWeeks, primaryGoal, currentPhase, syncStatus)
- [ ] `WeddingMealLogs` table (id, userId, planId, eventTag, timing, loggedAt, calories, notes, syncStatus)
- [ ] `@DriftDatabase(tables: [...])` annotation includes all tables
- [ ] `schemaVersion = 1`
- [ ] `MigrationStrategy` with `onCreate` and `onUpgrade` stubs

### 5.2 Database Queries — DAOs or extension methods

- [ ] `watchTodayFoodLogs(int userId, DateTime date)` — stream, filtered by date range
- [ ] `watchTodaySteps()` — from Health Connect, not Drift (but cache result)
- [ ] `getPendingRecords(TableInfo table)` — syncStatus = 'pending', failedAttempts < 3
- [ ] `getDLQRecords(TableInfo table)` — syncStatus = 'dlq'
- [ ] `markSynced(String localId, String remoteId, TableInfo table)`
- [ ] `incrementFailedAttempts(String localId, TableInfo table)`
- [ ] `watchHabitById(String id)` — stream for live habit detail
- [ ] `getJournalEntries(String userId, {int limit = 20})` — paginated
- [ ] `getBpHistory(String userId, int days)` — for chart
- [ ] `getGlucoseHistory(String userId, String readingType, int days)` — for chart
- [ ] `getSleepLogs(String userId, int days)` — for chart + debt calculation

---

## 6. State Management — Providers & Notifiers

### 6.1 Auth

- [ ] `AuthNotifier` — `build()` calls `account.get()`, returns `User?`
- [ ] `AuthNotifier.login(email, password)` — `createEmailPasswordSession`
- [ ] `AuthNotifier.register(name, email, password)` — `create` + session
- [ ] `AuthNotifier.loginWithGoogle()` — `createOAuth2Session`
- [ ] `AuthNotifier.logout()` — `deleteSession('current')`

### 6.2 Food

- [ ] `FoodLogNotifier` — `build(DateTime date)` watches today's food logs from Drift
- [ ] `FoodLogNotifier.logFood(FoodLogsCompanion)` — local write first, then `_pushToRemote`
- [ ] `FoodLogNotifier._pushToRemote(String localId)` — (Handled by FoodRepository + SyncQueue)
- [ ] `todayCaloriesProvider` — narrow provider summing today's kcal
- [ ] `foodSearchProvider(String query)` — searches local DB + remote food API

### 6.3 Health Metrics

- [ ] `BPNotifier` — CRUD for `bp_readings` with same optimistic pattern
- [ ] `BPNotifier.logReading(systolic, diastolic, pulse, notes)`
- [ ] `latestBpReadingProvider` — stream of most recent BpReading
- [ ] `bpHistoryProvider(int days)` — (Handled in UI/Domain via bpLogsProvider)
- [ ] `GlucoseNotifier` — CRUD for `glucose_readings`
- [ ] `GlucoseNotifier.logReading(value, readingType, linkedFoodLogId?)`
- [ ] `latestGlucoseProvider` — most recent reading
- [ ] `glucoseHistoryProvider(String type, int days)` — (Handled in UI/Domain)
- [ ] `SpO2Notifier` — log SpO2 + pulse (stored in `workouts` or separate table)
- [ ] `SleepNotifier` — CRUD for `sleep_logs`
- [ ] `SleepNotifier.logSleep(start, end, source)`
- [ ] `sleepHistoryProvider(int days)` — for chart
- [ ] `sleepDebtProvider` — calculates weekly deficit/surplus vs 7h target

### 6.4 Workout

- [ ] `WorkoutNotifier` — CRUD for `workouts`
- [ ] `WorkoutNotifier.startWorkout(Workout)` — writes in-progress record
- [ ] `WorkoutNotifier.finishWorkout(String id, duration, calories)` — completes record
- [ ] `activeWorkoutProvider` — current in-progress workout (if any)
- [ ] `workoutHistoryProvider(int limit)`
- [ ] `personalRecordsProvider` — max weight/reps per exercise across all workouts

### 6.5 Habit

- [ ] `HabitNotifier` — CRUD for `habits`
- [ ] `HabitNotifier.completeHabit(String habitId)` — add today to completedDates, increment streak
- [ ] `HabitNotifier.recoverStreak(String habitId, String userId)` — once/month, costs 50 XP
- [ ] `todayHabitsProvider` — all habits with today's completion status

### 6.6 Steps

- [ ] `stepsProvider` — reads from Health Connect via `HealthService.todaySteps()`
- [ ] `stepHistoryProvider(int days)` — 7-day bar chart data
- [ ] `adaptiveGoalProvider` — 7-day average + suggested new goal

### 6.7 Karma

- [ ] `KarmaService.awardXP(userId, eventType)` — calls `xp-calculator` function
- [ ] `xpFloatNotifierProvider` — shows floating "+X XP" animation
- [ ] `leaderboardProvider(LeaderboardType)` — friends/city/national/seasonal
- [ ] `userKarmaProvider` — streams user's current XP + level from Drift-cached user

### 6.8 Fasting

- [ ] `FastingTimerNotifier` — manages start/pause/stop with `Stopwatch`
- [ ] `fastingStageProvider` — computes current stage from elapsed hours
- [ ] `activeFastProvider` — persists timer state across app restarts (store start time in `flutter_secure_storage`)

### 6.9 Body Metrics

- [ ] `bodyMetricsProvider` — latest weight, BMI from user profile
- [ ] `weightHistoryProvider(int days)`
- [ ] `BodyMetricsNotifier.logWeight(double kg)`

### 6.10 Mood

- [ ] `MoodNotifier` — stores mood entry to `journal` table (moodScore + moodEmoji + tags)
- [ ] `todayMoodProvider` — today's logged mood if exists
- [ ] `moodHistoryProvider(int days)` — for 7-day heatmap

### 6.11 Journal

- [ ] `JournalNotifier` — CRUD for `journal_entries`
- [ ] `JournalNotifier.createEntry(title, body, moodScore, tags)`
- [ ] `journalEntriesProvider` — paginated list
- [ ] `journalPromptProvider` — generates prompt from logged data patterns

### 6.12 Festival

- [ ] `activeFestivalProvider` — queries `festivals` by current timestamp range
- [ ] `upcomingFestivalsProvider` — next 30 days
- [ ] `festivalDietProvider(String festivalKey)` — diet plan for specific festival
- [ ] `userFestivalFilterProvider` — user's religion/region preference for filtering

### 6.13 Wedding

- [ ] `WeddingPlanNotifier` — CRUD for `WeddingPlans` Drift table
- [ ] `WeddingPlanNotifier.createPlan(role, dates, events, prepWeeks, goal)`
- [ ] `activeWeddingPlanProvider` — current user's active wedding plan
- [ ] `weddingPhaseProvider` — computes current phase (pre/wedding week/post)
- [ ] `weddingEventDietProvider(String eventKey)` — per-event meal plan

### 6.14 Social

- [ ] `SocialFeedNotifier` — paginated social posts
- [ ] `SocialFeedNotifier.createPost(content, mediaFileId?)`
- [ ] `SocialFeedNotifier.likePost(String postId)`
- [ ] `socialRealtimeProvider` — Appwrite Realtime subscription for live feed updates
- [ ] `groupsProvider` — community groups list
- [ ] `myGroupsProvider` — user's joined groups

### 6.15 Reports

- [ ] `labReportsProvider` — list of imported lab reports
- [ ] `LabReportNotifier.importFromOCR(File imageOrPdf)`
- [ ] `LabReportNotifier.uploadFile(File)` → Appwrite Storage → returns `fileId`
- [ ] `shareLinkProvider(String reportId)` — calls `report-share` function
- [ ] `healthReportProvider(String period)` — weekly/monthly summary

### 6.16 Settings

- [ ] `ThemeNotifier` — light/dark/system, persisted to `flutter_secure_storage`
- [ ] `LanguageNotifier` — 22-language selector, persisted
- [ ] `FontSizeNotifier` — slider value, drives `textScaleFactor`
- [ ] `DyslexiaFontNotifier` — toggles `OpenDyslexic`, persisted
- [ ] `BiometricLockNotifier` — enabled/disabled toggle, persisted
- [ ] `NotificationPrefsNotifier` — per-module notification toggles
- [ ] `wearablesProvider` — list of connected wearables
- [ ] `subscriptionStatusProvider` — free/monthly/quarterly/yearly/family

### 6.17 Correlation Engine

- [ ] `CorrelationEngine.sleepMoodInsight(userId)` — requires 14+ days both datasets
- [ ] `CorrelationEngine.foodGlucoseInsight(userId)` — post-meal glucose vs food
- [ ] `CorrelationEngine.stepsEnergyInsight(userId)` — steps vs mood score
- [ ] `dashboardInsightProvider` — selects best available insight for the day

---

## 7. Sync Engine

- [ ] `SyncWorker` class — `syncPending()` iterates all pending Drift rows
- [ ] `SyncWorker._syncTable<T>()` — generic sync per table with error handling
- [ ] `SyncWorker` — DLQ promotion after 3 failed attempts (`failedAttempts >= 3` → `syncStatus = 'dlq'`)
- [ ] `connectivityStreamProvider` — `Connectivity().onConnectivityChanged` stream
- [ ] Listener in `ProviderScope` — calls `syncWorker.syncPending()` on connectivity restored
- [ ] Periodic background sync via `Workmanager` at tier-appropriate interval (6h / 30m / 15m)
- [ ] `dlqCountProvider` — `FutureProvider<int>` summing DLQ rows across all tables
- [ ] `SyncStatusBanner` widget reads `dlqCountProvider` and `connectivityStreamProvider`
- [ ] `pendingSyncCountProvider` — badge count for Settings → Data & Sync

---

## 8. Shared Widget Library

All in `lib/shared/widgets/`. Every widget must be tier-aware via `deviceTierProvider`.

- [ ] `GlassCard` — backdrop blur (mid/high), solid surface1 (low), optional glow
- [ ] `BentoCard` — `BentoSize` enum, `_resolvedSize()` auto-promotion on 360dp screens
- [ ] `AmbientBlobs` — 3 blobs (high), 1 blob (mid), none (low)
- [ ] `ActivityRingsWidget` — 4 concentric rings, neon glow, animated arc fill, `metricLg` center
- [ ] `GlowingMetric` — CountUp animation, per-digit spring (high), whole-number (mid), static (low)
- [ ] `InsightCard` — lightbulb icon, amber glow border, 👍/👎 haptic rating
- [ ] `CorrelationInsightCard` — module icon pills, secondary glow border, 👍/👎
- [ ] `BilingualLabel` — English h3 + Devanagari hindi, 3px primary left border
- [ ] `EncryptionBadge` — AES-256 pill, teal glow, animated pulse on sensitive reveal
- [ ] `ABHALinkBadge` — large + compact variants, linked=success glow, unlinked=warning
- [ ] `ShimmerLoader` — `surface0` base + shimmer, dark/light aware
- [ ] `TrendChip` — ▲/▼/→ with appropriate color per direction
- [ ] `PulseRing` — animated pulsing ring for live metrics (HR, SpO2 alert)
- [ ] `StreakFlameWidget` — Lottie `streak_fire.json`, scale grows with streak count
- [ ] `QuickLogFAB` — orange FAB, speed-dial 6 sub-actions (Food, Water, Mood, Workout, BP, Glucose)
- [ ] `MealTypeTabBar` — floating pill tabs, glow on active, spring indicator
- [ ] `FoodItemCard` — glassmorphic, blurred food photo bg, bilingual name, portion, kcal, `+` spring tap
- [ ] `KarmaLevelCard` — `heroDeep` gradient, animated XP bar, level badge
- [ ] `DoshaDonutChart` — 3-segment `fl_chart` donut, animated draw, per-segment glow
- [ ] `ChallengeCarouselCard` — horizontal scroll, progress bar, XP reward, festival tag
- [ ] `MicronutrientBar` — compact animated bar (Iron/B12/VitD/Calcium), color-coded
- [ ] `LabValueRow` — metric row, inline edit field, classification pill, confirm checkbox
- [ ] `ErrorRetryWidget` — Lottie `error_state.json` + message + retry button
- [ ] `SyncStatusBanner` — DLQ amber / offline teal / low-data teal pill
- [ ] `FestivalCard` — gradient left border, bilingual name, fasting pill, region pill, CTA buttons
- [ ] `FestivalCountdownBanner` — full-width active festival, fasting mode badge, quick actions
- [ ] `WeddingCountdownCard` — gold gradient glass, days countdown, next event pill
- [ ] `WeddingRoleChip` — 150×160px illustrated card, spring select
- [ ] `EventDayCard` — wedding event, energy demand badge, pre/post meal
- [ ] `FestivalDietBadge` — fasting type pill (Nirjala/Phalahar/Roza/Feast), glow per type
- [ ] `GlassAppBar` — gains blur + glass bg on scroll
- [ ] `EmptyState` — Lottie asset + message + optional CTA (never text-only)
- [ ] `HealthShareCard` — expiry countdown ring, WhatsApp CTA, copy link, delete
- [ ] `HomeWidgetPreview` — phone mockup SVG, 60% scaled, live widget content inside
- [ ] `CardTapAnimation` — scale press feedback (1.0 → 0.97 → 1.0)
- [ ] `FitKarmaBottomNav` — glass pill nav bar, UXStage-aware label visibility
- [ ] `DLQAlertBanner` — (Integrated into SyncStatusBanner)
- [ ] `HealthScreen` error boundary pattern (via AsyncValueWidget)

---

## 9. Navigation & Routing

- [ ] `GoRouter` registered in `appRouterProvider`
- [ ] All 25 routes registered (splash, auth/login, auth/register, onboarding, home/dashboard, home/food, home/workout, home/steps, profile, blood-pressure, glucose, sleep, karma, journal, lab-reports, abha, settings, emergency, festival-calendar, wedding-planner, wearables, reports, subscription, home-widgets, spo2)
- [ ] Additional sub-routes: `/home/food/log/:mealType`, `/home/food/detail/:id`, `/home/food/lab-scan`
- [ ] Additional sub-routes: `/home/workout/:id`, `/home/workout/:id/active`, `/home/workout/gps`, `/home/workout/custom`
- [ ] Additional sub-routes: `/festival-calendar/:festivalKey/diet`
- [ ] Additional sub-routes: `/wedding-planner/setup`, `/wedding-planner/event/:eventKey`, `/wedding-planner/recovery`
- [ ] Additional sub-routes: `/mental-health`, `/mood`, `/body-metrics`, `/fasting`, `/ayurveda`, `/habits`
- [ ] `redirect` guard wired to `authNotifierProvider`
- [ ] Biometric re-auth for sensitive routes: Journal, Period tracker, BP logs, Glucose logs

---

## 10. Screens — Onboarding & Auth

- [ ] **SplashScreen** — Rive `logo_reveal.riv`, tagline fade, linear progress bar; always dark
- [ ] **OnboardingFlow** — 6-step segmented progress bar (4px, radiusFull), swipe gesture + Next/Back buttons
- [ ] **Onboarding Step 1** — Name field, gender chip selector (4 chips, 44px tap targets), DOB date picker
- [ ] **Onboarding Step 2** — Height ruler widget, weight drum-roll picker, metric/imperial toggle, 4-card fitness goal grid, 5-card activity level stack
- [ ] **Onboarding Step 3** — 3-column condition chip grid, amber glass info card, Continue + Skip
- [ ] **Onboarding Step 4** — 12-question dosha quiz carousel, auto-advance 400ms, `DoshaDonutChart` result
- [ ] **Onboarding Step 5** — 22-language grid (4-column), health permission toggles (custom pill, not Material), privacy caption
- [ ] **Onboarding Step 6** — `ABHALinkBadge` large, ABHA 14-digit input, OTP 6-box input (spring slide-in), wearable row, Finish Setup
- [ ] **LoginScreen** — logo + tagline, glass card with email/password fields, Google + Apple OAuth buttons
- [ ] **RegisterScreen** — same as login + Name + Confirm Password fields

---

## 11. Screens — Core Dashboard & Karma

- [ ] **DashboardScreen** (`/home/dashboard`) — Pattern B scaffold, `heroDeep` gradient hero
  - [ ] Hero: avatar (48px, primary ring), namaste greeting, bilingual, XP amber pill, level indigo pill
  - [ ] Hero: `ABHALinkBadge` compact if ABHA not linked
  - [ ] Body bento grid: Row 1 `ActivityRingsWidget` full width
  - [ ] Body bento grid: Row 2 two half-cards (Latest Workout + Sleep Recovery)
  - [ ] Body bento grid: Row 3 `InsightCard` OR `CorrelationInsightCard` (max 1)
  - [ ] Body bento grid: Row 4+ Today's Meals with `MealTypeTabBar`
  - [ ] `QuickLogFAB` fixed bottom-right, 20px from nav bar
  - [ ] UXStage.firstWeek: only Steps + Food + 1 Insight visible by default
  - [ ] Dark mode glow blobs active; light mode warm glass cards

- [ ] **KarmaHubScreen** (`/karma`) — Pattern B, `heroDeep`
  - [ ] Hero: `displayLg` XP total, animated XP progress bar, level badge, coin Lottie on tap
  - [ ] Daily Rituals checklist glass cards (dosha-driven, green tick / empty ring)
  - [ ] Active Challenges `ChallengeCarouselCard` horizontal scroll
  - [ ] Leaderboard: pill tab bar (Friends/City/National/Seasonal), top-5 with gold/silver/bronze glow ranks
  - [ ] Karma Store glass card, Streak Recovery amber pill option

---

## 12. Screens — Food & Nutrition

- [ ] **FoodHomeScreen** (`/home/food`) — Pattern A
  - [ ] `MealTypeTabBar` sticky below app bar (not inside app bar)
  - [ ] Macro Summary full-width glass card: 4 animated rings (Calories/Protein/Carbs/Fat)
  - [ ] `MicronutrientBar` row: Iron, B12, Vitamin D, Calcium
  - [ ] "Copy Yesterday" amber glass banner (if today's log is empty)
  - [ ] Logged Meals by selected tab, swipe left → delete

- [ ] **FoodLogScreen** (`/home/food/log/:mealType`) — Pattern A
  - [ ] Glass search bar (radiusFull), mic icon, barcode icon
  - [ ] Quick-action chip row: Scan Label, Upload Plate, Lab/Rx Scan, Manual
  - [ ] "Frequent Indian Portions" 2×N bento grid of `FoodItemCard`
  - [ ] "Restaurant Results" section with Swiggy/Zomato attribution pills
  - [ ] "Recent Logs" list with re-log button
  - [ ] `[Confirm Meal]` full-width primary button (replaces FAB)

- [ ] **FoodDetailScreen** (`/home/food/detail/:id`) — Pattern B (food photo hero)
  - [ ] Hero: blurred food photo, bilingual name, kcal with primary glow
  - [ ] Indian serving size drum-roll picker (katori/piece/glass/tbsp)
  - [ ] Full macro table with animated bar fills
  - [ ] Micronutrient table: Iron, B12, VitD, Calcium with RDA %
  - [ ] `[Add to Log]` primary full-width

- [ ] **LabScanScreen** (`/home/food/lab-scan`) — Pattern A (Calm Zone)
  - [ ] Two half glass cards: Take Photo, Upload PDF
  - [ ] `ShimmerLoader` processing state with "Extracting health values..."
  - [ ] Extracted values scroll with `LabValueRow` per metric
  - [ ] Classification pill colors: green=Normal, amber=Borderline, red=High/Low
  - [ ] `EncryptionBadge` + privacy caption
  - [ ] `[Import to Health Data]` primary, `[Discard]` error text

---

## 13. Screens — Workout

- [ ] **WorkoutHomeScreen** (`/home/workout`) — Pattern A
  - [ ] `StreakFlameWidget` + "Day N Streak!" banner (orangeGradient bg, if active)
  - [ ] Featured workout card (Pattern B mini, photo hero, Start button)
  - [ ] Category chips horizontal scroll (Yoga/HIIT/Strength/Cardio/Dance/Bollywood/Cricket/Kabaddi/Pranayama)
  - [ ] WorkoutCard 2-column bento grid (photo bg, title, duration, premium lock)

- [ ] **WorkoutDetailScreen** (`/home/workout/:id`) — Pattern B (thumbnail hero)
  - [ ] Hero: title displayLg, Duration badge, Difficulty badge, `[Start Workout]`
  - [ ] Description, equipment chips, exercise list glass cards
  - [ ] Exercise: name, Sets×Reps, RPE target, superset bracket letter (A/B/C left accent)
  - [ ] Similar workouts horizontal scroll

- [ ] **ActiveWorkoutScreen** (`/home/workout/:id/active`) — Pattern C
  - [ ] Exercise name h1 centered
  - [ ] Set counter `monoXL` primary glow
  - [ ] Rep target `bodyLg`
  - [ ] Rest Timer: `PulseRing` countdown, configurable seconds, haptic + audio on complete, Skip button
  - [ ] HR Zone badge from wearable
  - [ ] RPE selector (1–10 gradient slider, haptic per notch)
  - [ ] Pause · Next · Finish glass dock (bottom)

- [ ] **GPSWorkoutScreen** (`/home/workout/gps`) — Pattern C
  - [ ] `flutter_map` full-bleed with custom dark tiles
  - [ ] Offline tile cache indicator teal pill
  - [ ] Stats overlay glass card: Distance `monoXL`, Duration, Pace `monoLg`, Avg HR `monoLg`

- [ ] **CustomWorkoutBuilderScreen** (`/home/workout/custom`) — Pattern A
  - [ ] `ReorderableListView` drag-and-drop exercise rows
  - [ ] Each row: name, sets/reps/rest inline inputs, RPE input, superset A/B/C pills, drag handle
  - [ ] `[+ Add Exercise]` outlined full-width
  - [ ] `[Save Plan]` primary

---

## 14. Screens — Steps & Activity

- [ ] **StepsScreen** (`/home/steps`) — Pattern B (`heroPrimary`)
  - [ ] Hero: step count `heroDisplay` 72sp white with success glow
  - [ ] `PulseRing` progress behind count
  - [ ] Goal label, confetti Lottie on goal completion
  - [ ] Hourly bar chart glass card (animated fill, success color)
  - [ ] 7-day trend line chart (area fill, success20)
  - [ ] Distance + Calories two half-cards `monoLg`
  - [ ] Adaptive goal card (teal border, Accept/Keep buttons)
  - [ ] Inactivity nudge card (amber glass, if >60 min inactive, `[Start Walk]` teal button)

---

## 15. Screens — Health Monitoring

- [ ] **BPScreen** (`/blood-pressure`) — Pattern B (`heroDeep`)
  - [ ] Hero: latest `metricXL` reading (e.g. "128/82"), neon white glow per number
  - [ ] AHA classification badge (color-coded glass pill)
  - [ ] Pulse `bodyLg`, `EncryptionBadge` in hero
  - [ ] BP Trend Chart: 7/30/90 day toggle, AHA reference bands, animated draw on tab switch
  - [ ] Log BP FAB → bottom sheet (Systolic, Diastolic, Pulse, Notes, EncryptionBadge, Save)
  - [ ] Morning/evening reminder glass card with edit toggle

- [ ] **GlucoseScreen** (`/glucose`) — Pattern B (`heroDeep`)
  - [ ] Hero: latest `metricXL`, reading type tag, classification badge, `EncryptionBadge`
  - [ ] Reading type selector pills: Fasting/Post-meal/Random/Bedtime
  - [ ] Glucose history chart with target band per reading type, animated draw
  - [ ] HbA1c estimator card (glass, secondary glow, shown if ≥30 readings, with disclaimer)
  - [ ] Meal correlation row (linked food log for post-meal)
  - [ ] "Import from Lab Report →" row

- [ ] **SpO2Screen** (`/spo2`) — Pattern B (`heroDeep`)
  - [ ] Hero: latest SpO2 % `metricXL` teal glow, pulse `bodyLg`, timestamp caption
  - [ ] Alert banner if <95%: error glass, warning text, `PulseRing` error color
  - [ ] 7-day history chart (teal line, 95–100% target band)
  - [ ] Log SpO2 bottom sheet (% field, pulse optional, EncryptionBadge)

- [ ] **FastingTimerScreen** (`/fasting`) — Pattern B (`heroDeep`)
  - [ ] Hero: stage name `displayMd`, countdown `heroDisplay` with glow, `PulseRing` behind
  - [ ] Stage progress linear bar
  - [ ] Stage timeline horizontal glass card (Fed→Fasted 12h→Fat Burn 16h→Ketosis 24h→Autophagy 48h+)
  - [ ] Start/Pause/Stop glass buttons; fasting type chips when not started
  - [ ] Last fasting log glass card with TrendChip
  - [ ] Active festival link banner (if applicable)

- [ ] **BodyMetricsScreen** (`/body-metrics`) — Pattern B (`heroDeep`)
  - [ ] Hero: weight `metricXL`, BMI `monoLg` + classification badge
  - [ ] 30-day weight trend chart, target dashed line
  - [ ] Body composition half-cards (if wearable data available)
  - [ ] BMI history chart 90-day
  - [ ] Measurement log card (Waist/Chest/Hips, inline edit)
  - [ ] Log Weight FAB

---

## 16. Screens — Lab Reports & ABHA

- [ ] **LabReportsScreen** (`/lab-reports`) — Pattern A (Calm Zone)
  - [ ] "Scan New Report" neon CTA card with Lottie scan icon loop
  - [ ] Imported reports glass list (lab name, date, metrics count, View)
  - [ ] Swipe right → share, swipe left → delete
  - [ ] "Import from ABHA" glass card (if ABHA linked)
  - [ ] Privacy footnote glass card, `EncryptionBadge`

- [ ] **ABHAScreen** (`/abha`) — Pattern A (Calm Zone)
  - [ ] `ABHALinkBadge` large: linked state (success glow, masked ID, sync timestamp) OR unlinked (warning glow, CTA)
  - [ ] Benefits card if not linked (why link ABHA)
  - [ ] Link flow: 14-digit input + "Verify via OTP →" → calls `abha-verify` function
  - [ ] Linked records list (source, type, date, Import button)
  - [ ] Consent note `bodyMd italic`, `EncryptionBadge` pulsing teal glow

---

## 17. Screens — Lifestyle Trackers

- [ ] **SleepScreen** (`/sleep`) — Pattern B (`heroSleep` 3-stop gradient)
  - [ ] Hero: duration `metricXL`, quality emoji animated float, "Good/Poor Sleep" badge
  - [ ] 7-day sleep bar chart (green ≥7h / amber 6-7h / red <6h)
  - [ ] Sleep Debt card (secondary glow, deficit/credit animated bars)
  - [ ] Chronotype card (shown after 30+ days: Owl/Lark + optimal window)
  - [ ] Ayurvedic sleep tip (if avg <6h, teal border)
  - [ ] Log Sleep FAB

- [ ] **HabitTrackerScreen** (`/habits`) — Pattern A
  - [ ] Today's habits glass card stack (icon, name, target bar, `StreakFlameWidget`)
  - [ ] Streak Recovery amber pill (if streak broken ≤24h, once/month)
  - [ ] Weekly heatmap GitHub-style (surface1 → primary50 → primary100)
  - [ ] Streak stats: current vs longest, monoLg, side-by-side glass card

- [ ] **MoodTrackerScreen** (`/mood`) — Pattern A
  - [ ] Today's mood: 5 emoji buttons (spring pop, primary ring on select)
  - [ ] Energy level slider (0–10, gradient)
  - [ ] Tags multi-select chips (Stressed/Happy/Tired/Calm/Anxious/Energised/Focused)
  - [ ] `[Save Today's Mood]` primary full-width
  - [ ] 7-day mood heatmap (tap day → detail overlay)
  - [ ] Mood-Sleep `CorrelationInsightCard` (shown after 14+ data points)
  - [ ] Mood trend spline chart (purple fill)

---

## 18. Screens — Wellness

- [ ] **JournalScreen** (`/journal`) — Pattern A (Calm Zone, EncryptionBadge in app bar)
  - [ ] Today's prompt amber glass card (data-driven prompt)
  - [ ] `flutter_quill` rich text editor (glass card, formatting toolbar, min 200px)
  - [ ] Mood emoji row (5 buttons, spring pop) + tags chips
  - [ ] Sentiment summary card (shown after 30+ entries, indigo glass, TrendChip, on-device only)
  - [ ] Past entries list (date, first line, mood emoji, slide transition on tap)

- [ ] **MentalHealthHubScreen** (`/mental-health`) — Pattern A
  - [ ] CBT Insight `CorrelationInsightCard` (Sleep → Mood)
  - [ ] Stress Programs horizontal scroll glass cards (7-day plan)
  - [ ] Breathing exercise card (Rive animated circle, 4-7-8 / Box options)
  - [ ] Burnout risk semicircle gauge (if score > 40)
  - [ ] Indian helplines glass card (iCall, Vandrevala, NIMHANS with `[📞 Call]` buttons)

- [ ] **AyurvedaHubScreen** (`/ayurveda`) — Pattern A
  - [ ] `DoshaDonutChart` large (180px), dominant dosha `displayMd`, Retake Quiz link
  - [ ] Daily Rituals glass list (dosha-specific, bilingual, completion toggle)
  - [ ] Seasonal Recommendations glass card (6 Indian seasons)
  - [ ] Ayurvedic Food Guide: Good (teal chips) / Avoid (error chips) for dominant dosha

---

## 19. Screens — Social & Community

- [ ] **SocialFeedScreen** (`/home/social`) — Pattern A
  - [ ] Stories row horizontal scroll (48px avatars, primary glow = active, dimmed = viewed)
  - [ ] Post glass cards (avatar, name, timestamp, content, media)
  - [ ] Media hidden in Low Data Mode
  - [ ] `+5 XP` amber float animation on like received (coin_burst Lottie)
  - [ ] Create post FAB (primary, glowing)

- [ ] **CommunityGroupsScreen** (`/home/social/groups`) — Pattern A
  - [ ] My Groups horizontal scroll (glass group cards)
  - [ ] Discover Groups categorised list (Diet/Location/Sport/Support)
  - [ ] Team vs Team challenge banner (full-width, primary border, progress bars, countdown)

---

## 20. Screens — Reports & Wearables

- [ ] **HealthReportsScreen** (`/reports`) — Pattern A
  - [ ] Period tabs: Weekly / Monthly pill tab bar
  - [ ] Most recent report glass card with summary stats `monoLg`
  - [ ] `[View PDF]` outlined, `[Share with Doctor →]` primary outlined
  - [ ] Share flow: loading card → `HealthShareCard` spring slide-in (7-day expiry ring, WhatsApp green, Copy, Delete)
  - [ ] Past reports list (date, period, status pill, view arrow)

- [ ] **WearablesScreen** (`/wearables`) — Pattern A
  - [ ] Connected device glass cards (logo, name, last sync, status pill)
  - [ ] Sync status: success glow / warning glow / error glow
  - [ ] `[Disconnect]` error text button per device
  - [ ] `[+ Add Wearable]` outlined primary (Fitbit, Garmin, Health Connect, HealthKit)

---

## 21. Screens — Family & Emergency

- [ ] **EmergencyCardScreen** (`/emergency`) — Pattern A (Calm Zone, error stripe top)
  - [ ] Blood Group `metricLg` chip, ABO-color-coded bg (A=teal, B=purple, AB=primary, O=success)
  - [ ] Allergies error-outlined chips, Conditions warning-outlined chips
  - [ ] Medications glass list (auto-pulled)
  - [ ] Emergency Contact glass card: name, `[📞 Call Now]` error button
  - [ ] Doctor glass card (teal glow)
  - [ ] Insurance glass card
  - [ ] `[Export PDF]` / `[Show QR]` action row, QR bottom sheet

---

## 22. Screens — Settings & Profile

- [ ] **ProfileScreen** (`/profile`) — Pattern B (`heroDeep`)
  - [ ] Hero: avatar 80px with primary glow ring + edit badge, name `displayMd`, email caption
  - [ ] `KarmaLevelCard` compact overlapping hero bottom
  - [ ] `DoshaDonutChart` glass card (animated on enter)
  - [ ] Personal info editable rows (Goal, Height/Weight, DOB, Blood Group, Language)
  - [ ] `ABHALinkBadge` compact row
  - [ ] Achievements 3-column bento (earned = color + glow, locked = grey + 🔒)
  - [ ] Referral amber gradient card + Share button

- [ ] **SettingsScreen** (`/settings`) — Pattern A (Calm Zone)
  - [ ] Grouped glass section cards (not legacy list tiles)
  - [ ] Account section: Edit Profile, Subscription badge, Change Password, Linked accounts, ABHA
  - [ ] Preferences: Language, Theme (Light/Dark/System), Font size slider, Dyslexia font toggle
  - [ ] Notifications: per-module toggles (Meal/Step/BP/Glucose/Lab/Social/Challenges/Morning briefing)
  - [ ] Privacy & Security: Biometric toggle, Data Export JSON, Account Deletion (error)
  - [ ] Data & Sync: Low Data Mode, Sync interval, Wearables, Pending sync count, View failed items
  - [ ] Health Permissions: status rows (Step/HR/Sleep/Location)
  - [ ] Home Widgets → link
  - [ ] About: version, Privacy, Terms, Contact
  - [ ] Logout: error text button, bottom, separated by Divider
  - [ ] All toggles: custom pill (not Material switch), spring animation, primary ON

- [ ] **SubscriptionScreen** (`/subscription`) — Pattern A (Calm Zone)
  - [ ] Hero amber gradient glass card with 3 feature highlights
  - [ ] Plan cards: Monthly ₹99 / Quarterly ₹249 / Yearly ₹899 / Family ₹1,499
  - [ ] "Most Popular" secondary glow badge on Quarterly
  - [ ] "Best Value" amber ribbon on Yearly
  - [ ] `[Pay via UPI]` secondary outlined per plan
  - [ ] Feature comparison table glass card (Free vs Premium)
  - [ ] Restore purchase + trial disclaimer

---

## 23. Screens — Festival & Wedding

- [ ] **FestivalCalendarScreen** (`/festival-calendar`) — Pattern A
  - [ ] Active Festival Banner (if active: glass, gradient left border, diet badge, quick actions)
  - [ ] Upcoming festivals list of `FestivalCard` (swipe left → hide)
  - [ ] Region Filter chip row (All/Hindu/Muslim/Sikh/Christian/Jain/Buddhist/National)
  - [ ] Calendar month view (mini, festival dots, tap → scroll to card)
  - [ ] "Plan a Wedding" amber CTA card

- [ ] **FestivalDietScreen** (`/festival-calendar/:festivalKey/diet`) — Pattern B (festival gradient)
  - [ ] Hero: festival name bilingual, `FestivalDietBadge`
  - [ ] Fasting Overview glass card (duration, type, restrictions)
  - [ ] Allowed Foods 2×N `FoodItemCard` grid (filtered)
  - [ ] Forbidden Foods error-outlined pill list
  - [ ] Meal Plan tabs (Day 1…N), Breakfast/Lunch/Dinner/Snacks suggestions
  - [ ] Quick Log FAB label changes per festival (e.g. "Log Phalahar Meal", "Log Sehri")
  - [ ] Festival Insight cards (festival tint variant)
  - [ ] Workout Note amber glass banner
  - [ ] Ramadan specifics: Sehri Countdown `PulseRing`, Iftar Countdown, 30-day heatmap
  - [ ] Karva Chauth specifics: Sargi Plan, Moonrise Countdown `PulseRing`, Break-fast plan

- [ ] **WeddingPlannerSetupFlow** (`/wedding-planner/setup`) — 6 steps, Pattern A
  - [ ] Step 1: Role 2×2 `WeddingRoleChip` grid (Bride/Groom/Guest/Relative)
  - [ ] Step 1b: Relation pill-chip (if Relative)
  - [ ] Step 2: First Event + Last Event `DateRangePicker`, festival overlap amber notice, validation
  - [ ] Step 3: Event checkbox 2-column bento (Haldi/Mehendi/Sangeet/Baraat/Vivah/Reception)
  - [ ] Step 4: Prep time horizontal scroll chips (1w/2w/4w/8w/Already wedding week)
  - [ ] Step 5: Primary goal glass chips (role-aware: Bride/Groom vs Guest/Relative options)
  - [ ] Step 6: Summary glass card, plan preview list, `[Start My Wedding Plan]` primary glow

- [ ] **WeddingPlannerHomeScreen** (`/wedding-planner`) — Pattern B (`heroWedding`)
  - [ ] Hero: "💍 Your Wedding Plan", Role + Phase display
  - [ ] Phase Progress glass card with animated progress bar + sub-phase pill
  - [ ] Today's Plan glass card (primary border glow, diet phase, meals, workout, CTAs)
  - [ ] Event Countdown strip horizontal scroll chips (Haldi/Mehendi/Vivah with days)
  - [ ] Wedding Tips `InsightCard` amber variant (role-specific)
  - [ ] Pre-Wedding Fitness Plan compact card
  - [ ] Wedding Grocery List glass card

- [ ] **WeddingEventDayScreen** (`/wedding-planner/event/:eventKey`) — Pattern A
  - [ ] `EventDayCard` (time, duration, energy badge Low/Medium/High glow)
  - [ ] Pre-Event Meal Plan (timed rows, ❌ Avoid list)
  - [ ] During-Event Tips chip cards (glass, accent border)
  - [ ] Post-Event Recovery Meal glass card with timestamp
  - [ ] `[Log Sangeet Meal]` primary → food log with event tag
  - [ ] Calorie Budget glass card

- [ ] **WeddingRecoveryScreen** (`/wedding-planner/recovery`) — Pattern A
  - [ ] Celebration amber gradient card
  - [ ] 3-Day Detox Plan timeline glass card
  - [ ] Return to Normal 5-day calorie chart (line, animated)
  - [ ] Workout recovery plan glass card
  - [ ] `[Mark Wedding as Complete]` teal outlined → archives in Drift

---

## 24. Screens — Home Widgets

- [ ] **HomeWidgetsScreen** (`/home-widgets`) — Pattern A
  - [ ] `HomeWidgetPreview` phone mockup SVG, live preview updates on selection
  - [ ] Activity Rings 4×1 widget + `[Add to Home Screen]`
  - [ ] Quick Log 2×1 widget + `[Add to Home Screen]`
  - [ ] Water Counter 2×2 widget + `[Add to Home Screen]`
  - [ ] Festival/Wedding Countdown 2×2 widget + `[Add to Home Screen]`
  - [ ] Lock Screen: Emergency Card widget (blood group + emergency number)
  - [ ] "How to add widgets" collapsible glass card (Android + iOS 3-step)

- [ ] **Android Glance Widget** — `StepsHomeWidget`
  - [ ] `home_widget` package integration
  - [ ] `saveWidgetData` for steps, goal, progress
  - [ ] `StepsWidgetProvider` receiver in `AndroidManifest.xml`
  - [ ] `@xml/steps_widget_info` resource file
  - [ ] `WorkManager` periodic task registration (30-min)
  - [ ] `callbackDispatcher()` entry point (opens DB in isolation, no ProviderScope)

---

## 25. Health Integrations

- [ ] `HealthService.requestPermissions()` — all 7 health types
- [ ] `HealthService.todaySteps()` — aggregated from Health Connect
- [ ] `HealthService.sleepData(DateTime date)` — session data for prior night
- [ ] `HealthService.heartRateReadings(DateTime start, DateTime end)` — for active workout HR zone
- [ ] `HealthService.spo2Readings(DateTime start, DateTime end)`
- [ ] `HealthService.bloodPressureReadings(DateTime start, DateTime end)` — if wearable supports
- [ ] Wearable sync: Fitbit, Garmin via their respective SDKs / Health Connect
- [ ] Health Connect `<queries>` package declaration in manifest
- [ ] iOS HealthKit entitlement in `ios/Runner/Runner.entitlements`

---

## 26. Security & Encryption

- [ ] SQLCipher AES-256 key generation (32-byte random, stored in platform keychain)
- [ ] `FlutterSecureStorage` with `AndroidOptions(encryptedSharedPreferences: true)`
- [ ] All Appwrite health documents created with `Permission.read(Role.user(userId))` only (no `any` or `users`)
- [ ] `SensitiveScreenGuard` applied to: Journal, Period tracker, BP logs, Glucose logs
- [ ] ABHA ID masked in all logs and UI (show XX-****-****-XXXX only)
- [ ] Lab report files in Appwrite Storage with user-scoped permissions
- [ ] No sensitive data in crash logs (no plaintext readings in error payloads)
- [ ] ABDM credentials stored ONLY in Appwrite Function env vars — never in Flutter app binary

---

## 27. Notifications

- [ ] `LocalNotifications.initialize()` called in `main()`
- [ ] `scheduleMealReminder()` for Breakfast, Lunch, Dinner (user-configurable times)
- [ ] `scheduleInactivityNudge()` — triggers if >60 min with no step data
- [ ] BP reading reminder (morning + evening, glass card in BP screen)
- [ ] Glucose reading reminder (per reading type schedule)
- [ ] Lab report reminder (if last import >30 days ago)
- [ ] Social activity notification (via Appwrite Messaging topic)
- [ ] Karma event notification ("You've reached Level 9!")
- [ ] Streak at-risk notification (if habit not completed by 9pm)
- [ ] Festival reminder (Set Reminder button on `FestivalCard`)
- [ ] All notifications respect per-module toggles from Settings
- [ ] FCM token registered with Appwrite Messaging on login
- [ ] Notification channels registered (Android 8+): meal_reminders, activity_nudge, health_alerts, karma_events, social_activity

---

## 28. Assets — Lottie & Rive

### Lottie Files (`assets/lottie/`)

- [ ] `confetti_orange.json` — step goal celebration
- [ ] `streak_fire.json` — habit streak flame (size scales with count)
- [ ] `coin_burst.json` — XP collection animation
- [ ] `sync_check.json` — sync success
- [ ] `error_state.json` — error state
- [ ] `empty_food_log.json`
- [ ] `empty_search.json`
- [ ] `empty_workout.json`
- [ ] `empty_steps.json`
- [ ] `empty_sleep.json`
- [ ] `empty_mood.json`
- [ ] `empty_bp.json`
- [ ] `empty_glucose.json`
- [ ] `empty_lab.json`
- [ ] `empty_habits.json`
- [ ] `empty_journal.json`
- [ ] `empty_social.json`
- [ ] `empty_challenges.json`
- [ ] `empty_medication.json`
- [ ] `empty_water.json`
- [ ] `empty_records.json`
- [ ] `empty_appointments.json`
- [ ] `empty_rituals.json`
- [ ] `empty_festivals.json`
- [ ] `empty_family.json`
- [ ] `empty_generic.json` — fallback (must never be the only empty state shown)

### Rive Files (`assets/rive/`)

- [ ] `logo_reveal.riv` — splash screen wordmark draw + flame ignite
- [ ] `levelup.riv` — full-screen level-up celebration
- [ ] `loading_rings.riv` — pulsing rings loader
- [ ] Breathing circle animation for Mental Health Hub (expand→hold→contract→hold)

---

## 29. Assets — Fonts

- [ ] `PlusJakartaSans[wght].ttf` — variable weight font, bundled in `assets/fonts/`
- [ ] `JetBrainsMono[wght].ttf` — variable weight monospace, bundled
- [ ] `OpenDyslexic-Regular.ttf` — dyslexia-friendly body font, bundled
- [ ] Noto Sans Devanagari — system font (no bundling needed; verify renders correctly on Android 6+)
- [ ] All three fonts declared under `flutter: fonts:` in `pubspec.yaml`
- [ ] Verify variable font renders correctly at all named weights (400, 500, 600, 700, 800)

---

## 30. Accessibility & Bilingual

### Bilingual — Required Elements

- [ ] Bottom nav labels (active tab): English 10sp SemiBold + Hindi 9sp below
- [ ] Screen app bar titles: English h1 + Hindi sub-label
- [ ] Section headers: `BilingualLabel` component used everywhere
- [ ] Food names in cards: `name` (English) + `name_local` (Devanagari)
- [ ] Search bar placeholder: bilingual string
- [ ] Lab value names (e.g. "Glucose / शर्करा")
- [ ] All 6 onboarding screen titles
- [ ] All festival card names

### Accessibility

- [ ] All interactive elements have minimum 44×44px tap target
- [ ] All `IconButton` widgets have `Semantics(label: ...)` 
- [ ] All images have `Semantics(label: ...)` descriptions
- [ ] All glass cards have `Semantics(container: true)`
- [ ] `textMuted` used ONLY for decorative / placeholder text — never for readable informational text
- [ ] `textSecondary` used for all secondary readable content
- [ ] Color contrast ≥ 4.5:1 for all text (WCAG AA)
- [ ] Glow effects are supplementary — never sole conveyor of meaning
- [ ] Font scaling: no hardcoded `textScaleFactor` overrides
- [ ] Dyslexia font toggle in Settings switches body text to OpenDyslexic (not metric/mono)
- [ ] High contrast mode: Settings → Theme → black/white + orange accents, zero gradients/blur
- [ ] Motion reduction: all springs → cross-fade when `MediaQuery.disableAnimations` is true
- [ ] Dark mode ring track uses `divider` dark token (not invisible black-on-black)
- [ ] UXStage.firstWeek: all 5 nav tabs show labels (not just active)
- [ ] First-launch tooltip on long-press for each inactive nav tab (dismissed once per tab)

---

## 31. Testing

### Unit Tests

- [ ] `FoodLogNotifier` — local write with pending sync status
- [ ] `FoodLogNotifier._pushToRemote` — successful sync marks `synced` + sets `remoteId`
- [ ] `FoodLogNotifier._pushToRemote` — failed sync increments `failedAttempts`
- [ ] `FoodLogNotifier._pushToRemote` — DLQ promotion after 3 failures
- [ ] `SyncWorker.syncPending()` — skips DLQ rows, only processes pending
- [ ] `_computeLevel(totalXP)` (XP Calculator function) — all 13 threshold boundaries
- [ ] `DoshaQuiz.computeDosha()` — tie-breaking, edge cases
- [ ] `getUXStage()` — day 0, day 6, day 7, day 29, day 30 boundaries
- [ ] `BentoCard._resolvedSize()` — auto-promotion on 360dp screen
- [ ] `CorrelationEngine.sleepMoodInsight()` — returns null when <14 data points
- [ ] `CorrelationEngine.sleepMoodInsight()` — returns null when mood diff < 0.5
- [ ] `BiometricLock.authenticate()` — falls through when no biometric hardware
- [ ] `KarmaService.awardXP()` — correct function ID and body payload
- [ ] `activeFestivalProvider` — returns null when no active festival in range

### Widget Tests

- [ ] `GlassCard` — uses `surface1` solid + no `BackdropFilter` on `DeviceTier.low`
- [ ] `GlassCard` — uses `BackdropFilter blur(12)` on `DeviceTier.mid` and `.high`
- [ ] `GlassCard` — no glow shadow when `glowColor` is null
- [ ] `BentoCard` — renders correct width for `BentoSize.half` on 360dp screen
- [ ] `BentoCard` — promotes `quarter` → `third` on 360dp screen
- [ ] `TrendChip` — renders ▲ with success color for `TrendDirection.up`
- [ ] `EncryptionBadge` — renders teal text and icon
- [ ] `EmptyState` — renders Lottie + message + CTA when all provided
- [ ] `FitKarmaBottomNav` — shows all labels during `UXStage.firstWeek`
- [ ] `FitKarmaBottomNav` — shows only active label after `firstWeek`
- [ ] `ShimmerLoader` — uses `surface0` base on dark, `surface0Light` on light

### Integration Tests

- [ ] Full food log flow: log meal → verify Drift write → verify Appwrite sync → verify UI update
- [ ] Offline food log: log meal offline → verify pending status → restore connectivity → verify auto-sync
- [ ] Auth flow: register → onboarding → dashboard redirect
- [ ] BP log + alert: log <120/80 → verify classification badge → verify no alert; log >140/90 → verify alert

---

## 32. CI/CD

- [ ] `.github/workflows/ci.yml` — `test` job (flutter analyze + flutter test --coverage)
- [ ] `.github/workflows/ci.yml` — `deploy-appwrite` job (runs on `main` only, deploys all functions)
- [ ] `.github/workflows/ci.yml` — `build-android` job (APK with all dart-defines)
- [ ] Appwrite API key created with correct scopes (databases.read/write, collections, functions, buckets)
- [ ] `appwrite client --key` non-interactive login for CI (no `appwrite login`)
- [ ] GitHub Actions secrets configured: `APPWRITE_ENDPOINT`, `APPWRITE_PROJECT_ID`, `APPWRITE_API_KEY`, `ABHA_CLIENT_ID`, `ABHA_CLIENT_SECRET`, `APP_BASE_URL`
- [ ] `codecov/codecov-action` for coverage upload
- [ ] `build_runner` code generation runs in CI before `flutter test`
- [ ] APK artifact uploaded on `build-android` job

---

## 33. Performance & Device Tier

- [ ] `DeviceTierProvider` initialized at app start, available root-level
- [ ] Every widget using blur/glow reads from `deviceTierProvider` — no hardcoded effects
- [ ] `BackdropFilter` gated: disabled on low, cards-only on mid, full on high
- [ ] Ambient glow blobs: 0 on low, 1 on mid, 3 on high
- [ ] Glow box-shadows: disabled on low, active element only on mid, full on high
- [ ] Lottie: essential-only on low (streak fire, confetti), all on mid, all+Rive on high
- [ ] Spring animations: cross-fade on low, standard spring on mid, full physics on high
- [ ] Per-digit CountUp: disabled on low, whole-number spring on mid, per-digit on high
- [ ] `ListView.builder` used everywhere — never `ListView(children: [...])`
- [ ] `CachedNetworkImage` for all network images with placeholder box fallback
- [ ] Drift queries use `.watch()` streams (not polling) for live data
- [ ] Narrow providers (one metric per provider) — no wide `dashboardState` super-provider
- [ ] Sync intervals: 6h (low), 30m (mid), 15m (high) via `Workmanager`
- [ ] Low Data Mode: disables all `BackdropFilter`, replaces images with color placeholder

---

## 34. Data Seeding

- [ ] `scripts/seed_festivals.mjs` — Node.js script using `node-appwrite`
- [ ] Festival data for 2025/2026: Navratri, Diwali, Ramadan, Karva Chauth, Ganesh Chaturthi
- [ ] Festival data includes: startDate/endDate (Unix timestamps), allowedFoods JSON, forbiddenFoods JSON
- [ ] Seed script reads `APPWRITE_ENDPOINT`, `APPWRITE_PROJECT_ID`, `APPWRITE_API_KEY` from env
- [ ] Instructions in `README.md`: how to run seed script
- [ ] Yearly festival date update process documented (astronomically computed for recurring festivals)
- [ ] Default food database seeded (common Indian foods with nutritional data, bilingual names)
- [ ] Default workout plans seeded (Yoga beginner, HIIT 20-min, Bollywood dance)
- [ ] Default habit presets seeded (Morning walk, Drink water, Meditate, Sleep by 10pm)

---

## Progress Summary

> Update these counts as items are checked off.

| Area | Total Items | Done | In Progress | Remaining |
|---|---|---|---|---|
| Project Bootstrap | 28 | 7 | 0 | 21 |
| Core Layer | 37 | 16 | 0 | 21 |
| Appwrite Backend | 51 | 0 | 5 | 46 |
| Appwrite Functions | 21 | 0 | 1 | 20 |
| Drift Tables | 26 | 12 | 0 | 14 |
| State / Providers | 62 | 0 | 10 | 52 |
| Sync Engine | 10 | 0 | 2 | 8 |
| Shared Widgets | 42 | 34 | 0 | 8 |
| Navigation | 12 | 8 | 0 | 4 |
| Screens (all) | 147 | 45 | 0 | 102 |
| Health Integrations | 10 | 0 | 0 | 10 |
| Security | 8 | 0 | 0 | 8 |
| Notifications | 15 | 0 | 0 | 15 |
| Assets — Lottie | 26 | 0 | 0 | 26 |
| Assets — Rive | 4 | 0 | 0 | 4 |
| Assets — Fonts | 6 | 0 | 0 | 6 |
| Accessibility | 20 | 0 | 0 | 20 |
| Testing | 30 | 0 | 0 | 30 |
| CI/CD | 9 | 0 | 0 | 9 |
| Performance | 15 | 0 | 0 | 15 |
| Data Seeding | 9 | 0 | 0 | 9 |
| **TOTAL** | **592** | **122** | **18** | **452** |

---

*FitKarma Master TODO — generated from Complete Documentation v2.0*
*592 trackable items across 34 categories*
*Flutter 3.x · Riverpod 2.x · Drift · Appwrite CLI*