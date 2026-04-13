# FitKarma — Master Development TODO
> **Stack:** Flutter 3.x · Riverpod 2.x · Drift (SQLCipher) · Appwrite CLI (terminal only)
> **Rule:** Every Appwrite resource (databases, collections, attributes, indices, buckets, functions) is created via `appwrite` CLI — never via the web console. Access control (permissions) is strictly enforced at the application layer; backend resources are provisioned with 'any' permissions at the CLI level.
> **AI Prompt Style:** Each task below is a self-contained instruction. Paste it verbatim into your IDE AI. Tasks are ordered by dependency.

---

## PHASE 0 — Environment & Tooling Setup

- [x] **0.1 — Install Flutter & Dart SDK**
  ```
  Install Flutter 3.x stable channel. Verify with `flutter doctor`. Ensure Android SDK (API 34) and Xcode (latest) are configured. Run `flutter doctor --android-licenses`.
  (Note: Xcode skipped as user is on Windows)
  ```

- [x] **0.2 — Install Appwrite CLI**
  ```
  Install the Appwrite CLI globally: `npm install -g appwrite-cli`. Verify with `appwrite --version`. Then run `appwrite client --endpoint https://cloud.appwrite.io/v1` to configure the endpoint. Login with `appwrite login`.
  ```

- [x] **0.3 — Create Appwrite Projects and Folders via CLI**
  ```
  1. Create two folders in your project root: `appwrite/staging/` and `appwrite/production/`.
  2. Navigate into `appwrite/staging/` and run `appwrite init project` to link/create the staging project (ID: fitkarma-staging).
  3. Navigate into `appwrite/production/` and run `appwrite init project` to link/create the production project (ID: fitkarma-prod).
  This ensures separate configuration files (appwrite.json) for each environment.
  ```

- [x] **0.4 — Create Flutter project**
  ```
  Run `flutter create --org com.fitkarma --project-name fitkarma .`. Set the bundle ID to `com.fitkarma.app` in android/app/build.gradle.kts (applicationId) and ios/Runner.xcodeproj (PRODUCT_BUNDLE_IDENTIFIER). Delete the default counter app code from lib/main.dart.
  ```

- [x] **0.5 — Create .env files and .gitignore**
  ```
  In the project root, create two files: `.env.staging` and `.env.prod`. Add the following keys to both (fill in values for the appropriate environment):
  APPWRITE_ENDPOINT, APPWRITE_PROJECT_ID, APPWRITE_DATABASE_ID, APPWRITE_API_KEY,
  YOUTUBE_API_KEY, RAZORPAY_KEY_ID, RAZORPAY_KEY_SECRET,
  OPEN_FOOD_FACTS_USER_AGENT=FitKarma/1.0 (contact@fitkarma.app),
  FCM_SERVER_KEY, SENTRY_DSN,
  FITBIT_CLIENT_ID, FITBIT_CLIENT_SECRET,
  GARMIN_CONSUMER_KEY, GARMIN_CONSUMER_SECRET,
  WHATSAPP_PHONE_NUMBER_ID, WHATSAPP_ACCESS_TOKEN,
  ABDM_CLIENT_ID, ABDM_CLIENT_SECRET,
  APPWRITE_CERT_FINGERPRINT.
  Add `.env*` and `*.env` to `.gitignore` immediately.
  ```

- [x] **0.6 — Add all pubspec.yaml dependencies**
  ```
  In pubspec.yaml, add all dependencies exactly as listed below. Run `flutter pub get` after:

  dependencies:
    flutter_riverpod: ^3.3.1
    riverpod_annotation: ^4.0.2
    drift: ^2.14.1
    drift_flutter: ^0.2.8
    sqlite3_flutter_libs: ^0.5.0
    sqlcipher_flutter_libs: ^0.7.0+eol
    cryptography: ^2.7.0
    crypto: ^3.0.3
    appwrite: ^23.0.0
    go_router: ^17.2.0
    dio: ^5.4.0
    http: ^1.1.0
    flutter_secure_storage: ^10.0.0
    local_auth: ^3.0.1
    flutter_jailbreak_detection: ^1.9.0
    connectivity_plus: ^7.1.1
    geolocator: ^14.0.2
    flutter_map: ^8.2.2
    flutter_map_tile_caching: ^10.1.1
    youtube_player_flutter: ^9.1.3
    google_mlkit_text_recognition: ^0.15.1
    google_mlkit_object_detection: ^0.15.1
    flutter_barcode_scanner: ^2.0.0
    speech_to_text: ^7.3.0
    health: ^13.3.1
    fl_chart: ^1.2.0
    shimmer: ^3.0.0
    flutter_local_notifications: ^21.0.0
    razorpay_flutter: ^1.3.7
    home_widget: ^0.9.0
    firebase_messaging: ^16.1.3
    sentry_flutter: ^8.14.2
    cached_network_image: ^3.3.1
    image_picker: ^1.0.4
    path_provider: ^2.1.1
    path: ^1.9.0
    flutter_dotenv: ^6.0.0
    pdf: ^3.10.0
    flutter_quill: ^11.5.0
    just_audio: ^0.10.5
    workmanager: ^0.9.0+3
    url_launcher: ^6.2.5

  dev_dependencies:
    riverpod_generator: ^4.0.3
    drift_dev: ^2.14.1
    build_runner: ^2.4.7
    mockito: ^5.4.4
  ```

---

## PHASE 1 — Appwrite Backend Provisioning (CLI Only)

### 1A — Database & Core Collections

- [x] **1.1 — Create database via CLI**
  ```
  Using the Appwrite CLI, create a database for the staging project:
  `appwrite databases create --databaseId fitkarma-db --name "FitKarma DB" --project-id fitkarma-staging`
  Note the databaseId. Repeat for production project.
  ```

- [x] **1.2 — Create `users` collection via CLI**
  ```
  Using Appwrite CLI for project fitkarma-staging, create the `users` collection in database `fitkarma-db`:
  `appwrite databases createCollection --databaseId fitkarma-db --collectionId users --name users`
  Then add ALL of the following string/enum/boolean/datetime/integer/double attributes using `appwrite databases createStringAttribute`, `createEnumAttribute`, `createBooleanAttribute`, `createDatetimeAttribute`, `createIntegerAttribute`, `createFloatAttribute`:
  - name (string, size 255, required)
  - email (email, required)
  - dob (datetime, required)
  - gender (enum: male,female,other,prefer_not, required)
  - height_cm (double, required)
  - weight_kg (double, required)
  - goal (enum: lose_weight,gain_muscle,maintain,endurance, required)
  - activity_level (enum: sedentary,light,moderate,active,very_active, required)
  - dosha_type (enum: vata,pitta,kapha,vata_pitta,pitta_kapha,vata_kapha,tridosha, required)
  - blood_group (enum: A+,A-,B+,B-,O+,O-,AB+,AB-, optional)
  - language (string, size 10, required)
  - subscription_tier (enum: free,premium,family, default: free)
  - karma_total (integer, default: 0)
  - karma_level (integer, default: 1)
  - is_low_data_mode (boolean, default: false)
  - chronic_conditions (string, size 500, optional)
  - wearable_source (enum: fitbit,garmin,mi_band,boat,none, default: none)
  - referral_code (string, size 20, optional)
  - referred_by (string, size 36, optional)
  - abha_id (string, size 20, optional)
  - chronotype (enum: early_bird,night_owl,intermediate, optional)
  - wedding_role (enum: bride,groom,guest,relative,none, default: none)
  - wedding_relation_type (string, size 50, optional)
  - wedding_start_date (datetime, optional)
  - wedding_end_date (datetime, optional)
  - wedding_prep_weeks (integer, optional)
  - wedding_events (string, size 500, optional)
  - wedding_primary_goal (enum: tone_up,energised,manage_stress,manage_indulgence, optional)
  Then set permissions: `appwrite databases updateCollection --databaseId fitkarma-db --collectionId users --permissions 'read("any")' 'create("any")' 'update("any")' 'delete("any")'`
  Note: Access control is handled at the application layer; CLI permissions are set to 'any' for initial provisioning.
  ```

- [x] **1.3 — Create `food_items` collection via CLI**
  ```
  Using Appwrite CLI for project fitkarma-staging, create the `food_items` collection and add these attributes:
  - name (string, size 255, required)
  - name_local (string, size 255, optional)
  - region (enum: north,south,east,west,northeast,central, optional)
  - barcode (string, size 50, optional)
  - calories_per_100g (double, required)
  - protein_per_100g (double, required)
  - carbs_per_100g (double, required)
  - fat_per_100g (double, required)
  - fiber_per_100g (double, optional)
  - vitamin_d_per_100g (double, optional)
  - vitamin_b12_per_100g (double, optional)
  - iron_per_100g (double, optional)
  - calcium_per_100g (double, optional)
  - is_indian (boolean, default: false)
  - serving_sizes (string, size 1000, optional)
  - source (enum: openfoodfacts,manual,community,restaurant, required)
  - restaurant_name (string, size 255, optional)
  - swiggy_item_id (string, size 100, optional)
  - zomato_item_id (string, size 100, optional)
  Then create a full-text index on `name`:
  `appwrite databases createIndex --databaseId fitkarma-db --collectionId food_items --key name_fulltext --type fulltext --attributes name`
  And a key index on `barcode`:
  `appwrite databases createIndex --databaseId fitkarma-db --collectionId food_items --key barcode_key --type key --attributes barcode`
  ```

- [x] **1.4 — Create `food_logs` collection via CLI**
  ```
  Using Appwrite CLI, create `food_logs` collection with these attributes:
  - user_id (string, size 36, required)
  - food_item_id (string, size 36, optional)
  - recipe_id (string, size 36, optional)
  - food_name (string, size 255, required)
  - meal_type (enum: breakfast,lunch,dinner,snack, required)
  - quantity_g (double, required)
  - calories (double, required)
  - protein_g (double, required)
  - carbs_g (double, required)
  - fat_g (double, required)
  - fiber_g (double, optional)
  - vitamin_d_mcg (double, optional)
  - vitamin_b12_mcg (double, optional)
  - iron_mg (double, optional)
  - calcium_mg (double, optional)
  - logged_at (datetime, required)
  - log_method (enum: search,barcode,ocr,voice,photo,recipe,planner,whatsapp,copy_yesterday, optional)
  - sync_status (enum: synced,pending,conflict, default: pending)
  - idempotency_key (string, size 64, required)
  - field_versions (string, size 2000, optional)
  Then create a composite index:
  `appwrite databases createIndex --databaseId fitkarma-db --collectionId food_logs --key user_logged_at --type key --attributes user_id,logged_at --orders ASC,DESC`
  ```

- [x] **1.5 — Create workout, step, sleep, mood log collections via CLI**
  ```
  Using Appwrite CLI, create the following four collections in database fitkarma-db. For each, add the specified attributes and the required composite index on [user_id, date/logged_at DESC]:

  Collection: `workout_logs`
  Attributes: user_id (string,36,req), workout_id (string,36,opt), title (string,255,req), duration_min (integer,req), calories_burned (double,opt), category (string,50,opt), rpe (integer,opt), hr_zone (integer,opt), logged_at (datetime,req), sync_status (enum:synced,pending,conflict), idempotency_key (string,64,req)
  Index: [user_id, logged_at DESC]

  Collection: `step_logs`
  Attributes: user_id (string,36,req), date (datetime,req), step_count (integer,req), distance_m (double,opt), calories_burned (double,opt), source (enum:device,health_connect,healthkit,wearable), sync_status (enum:synced,pending,conflict), idempotency_key (string,64,req)
  Index: [user_id, date DESC]

  Collection: `sleep_logs`
  Attributes: user_id (string,36,req), date (datetime,req), bedtime (string,5,req), wake_time (string,5,req), duration_min (integer,req), quality_score (integer,req), deep_sleep_min (integer,opt), sleep_debt_min (integer,opt), notes (string,1000,opt), source (enum:manual,health_connect,healthkit,wearable)
  Index: [user_id, date DESC]

  Collection: `mood_logs`
  Attributes: user_id (string,36,req), mood_score (integer,req), energy_level (integer,opt), stress_level (integer,opt), tags (string,500,opt), notes (string,2000,opt), logged_at (datetime,req), sync_status (enum:synced,pending,conflict), idempotency_key (string,64,req)
  Index: [user_id, logged_at DESC]
  ```

- [x] **1.6 — Create health monitoring collections via CLI**
  ```
  Using Appwrite CLI, create these collections in fitkarma-db:

  Collection: `blood_pressure_logs`
  Attributes: user_id (string,36,req), systolic (integer,req), diastolic (integer,req), pulse (integer,opt), logged_at (datetime,req), classification (enum:normal,elevated,stage1,stage2,crisis,req), notes (string,500,opt), source (enum:manual,wearable,health_connect,lab_report), sync_status (enum:synced,pending,conflict), idempotency_key (string,64,req)
  Index: [user_id, measured_at DESC] — attribute name: measured_at

  Collection: `glucose_logs`
  Attributes: user_id (string,36,req), glucose_mgdl (double,req), reading_type (enum:fasting,post_meal,random,bedtime,req), food_log_id (string,36,opt), logged_at (datetime,req), classification (enum:normal,prediabetic,diabetic,req), hba1c_estimate (double,opt), notes (string,500,opt), source (enum:manual,wearable,lab_report), sync_status (enum:synced,pending,conflict), idempotency_key (string,64,req)
  Index: [user_id, logged_at DESC]

  Collection: `spo2_logs`
  Attributes: user_id (string,36,req), spo2_percent (double,req), pulse (integer,opt), logged_at (datetime,req), source (enum:manual,wearable,health_connect,healthkit)
  Index: [user_id, logged_at DESC]

  Collection: `period_logs`
  Attributes: user_id (string,36,req), cycle_start (datetime,req), cycle_end (datetime,opt), symptoms (string,500,opt), flow_intensity (enum:light,medium,heavy,opt), notes_encrypted (string,5000,opt), sync_status (enum:synced,pending,conflict,opt), idempotency_key (string,64,opt)
  Index: [user_id, cycle_start DESC]
  ```

- [x] **1.7 — Create remaining core collections via CLI**
  ```
  Using Appwrite CLI, create these collections in fitkarma-db:

  Collection: `medications`
  Attributes: user_id (string,36,req), name (string,255,req), dose (string,100,req), frequency (string,100,req), category (enum:prescription,otc,supplement,ayurvedic,req), reminder_times (string,200,opt), refill_date (datetime,opt), pharmacy_link (string,500,opt), is_active (boolean,default:true)

  Collection: `habits`
  Attributes: user_id (string,36,req), name (string,255,req), icon (string,50,req), target_count (integer,req), unit (string,50,req), frequency (enum:daily,weekdays,custom,req), current_streak (integer,default:0), longest_streak (integer,default:0), streak_recovery_used (boolean,default:false), reminder_time (string,5,opt), is_preset (boolean,default:false)

  Collection: `body_measurements`
  Attributes: user_id (string,36,req), weight_kg (double,opt), height_cm (double,opt), chest_cm (double,opt), waist_cm (double,opt), hips_cm (double,opt), arms_cm (double,opt), thighs_cm (double,opt), body_fat_pct (double,opt), bmi (double,opt), measured_at (datetime,req)
  Index: [user_id, measured_at DESC]

  Collection: `nutrition_goals`
  Attributes: user_id (string,36,req), tdee (double,req), calorie_goal (double,req), protein_g (double,req), carbs_g (double,req), fat_g (double,req), goal_type (enum:lose_weight,gain_muscle,maintain,endurance,req), vit_d_mcg (double,opt), b12_mcg (double,opt), iron_mg (double,opt), calcium_mg (double,opt)

  Collection: `karma_transactions`
  Attributes: user_id (string,36,req), amount (integer,req), action (string,100,req), description (string,500,opt), balance_after (integer,req), created_at (datetime,req)
  Index: [user_id, created_at DESC]
  ```

- [x] **1.8 — Create advanced feature collections via CLI**
  ```
  Using Appwrite CLI, create these collections in fitkarma-db:

  Collection: `fasting_logs`
  Attributes: user_id (string,36,req), protocol (enum:16_8,18_6,5_2,omad,ramadan,custom,req), fast_start (datetime,req), fast_end (datetime,opt), target_duration_hours (double,req), completed (boolean,default:false), broken_at (datetime,opt), notes (string,500,opt), sync_status (enum:synced,pending,conflict), idempotency_key (string,64,req)
  Index: [user_id, fast_start DESC]

  Collection: `meal_plans`
  Attributes: user_id (string,36,req), week_start (datetime,req), plan_data (string,5000,req), plan_type (enum:standard,festival,wedding,custom,req), festival_key (string,50,opt), generated_by (enum:ai,user,req)

  Collection: `recipes`
  Attributes: user_id (string,36,req), title (string,255,req), description (string,1000,opt), ingredients (string,5000,req), steps (string,5000,req), servings (integer,req), total_calories (double,req), protein_g (double,opt), carbs_g (double,opt), fat_g (double,opt), iron_mg (double,opt), vitamin_d_mcg (double,opt), calcium_mg (double,opt), b12_mcg (double,opt), cuisine_region (enum:north,south,east,west,northeast,central,opt), is_public (boolean,default:false)

  Collection: `journal_entries`
  Attributes: user_id (string,36,req), content_encrypted (string,10000,req), mood_score (integer,opt), tags (string,500,opt), prompt_used (string,500,opt), logged_at (datetime,req), sync_status (enum:synced,pending,conflict,opt)
  Index: [user_id, logged_at DESC]

  Collection: `doctor_appointments`
  Attributes: user_id (string,36,req), doctor_name_encrypted (string,500,req), speciality (string,100,opt), appointment_dt (datetime,req), notes_encrypted (string,2000,opt), reminder_sent (boolean,default:false)
  Index: [user_id, appointment_dt DESC]

  Collection: `personal_records`
  Attributes: user_id (string,36,req), exercise_name (string,255,req), record_value (double,req), unit (string,50,req), achieved_at (datetime,req)

  Collection: `workouts`
  Attributes: title (string,255,req), youtube_id (string,50,opt), duration_min (integer,req), difficulty (enum:beginner,intermediate,advanced,req), category (string,100,req), language (string,10,req), is_premium (boolean,default:false), rpe_level (integer,opt)
  ```

- [x] **1.9 — Create India-specific & social collections via CLI**
  ```
  Using Appwrite CLI, create these collections in fitkarma-db:

  Collection: `lab_reports`
  Attributes: user_id (string,36,req), report_date (datetime,req), lab_name (string,255,opt), extracted_values (string,2000,req), raw_text (string,10000,opt), confirmed_by_user (boolean,default:false), source (enum:ocr_photo,ocr_pdf,manual,req), imported_metrics (string,500,opt)

  Collection: `abha_links`
  Attributes: user_id (string,36,req), abha_id (string,20,req), abha_address (string,100,opt), linked_at (datetime,req), consent_granted (boolean,req), last_sync (datetime,opt)

  Collection: `posts`
  Attributes: user_id (string,36,req), content (string,2000,req), media_file_id (string,36,opt), post_type (enum:workout,meal,milestone,general,req), likes_count (integer,default:0), created_at (datetime,req)
  Index: [user_id, created_at DESC]

  Collection: `challenges`
  Attributes: title (string,255,req), challenge_type (string,100,req), target_value (double,req), start_date (datetime,req), end_date (datetime,req), karma_reward (integer,req), festival_tag (string,50,opt), is_active (boolean,default:true)
  Index: [start_date, end_date, is_active — composite]

  Collection: `subscriptions`
  Attributes: user_id (string,36,req), plan (enum:monthly,quarterly,yearly,family,req), status (enum:active,cancelled,expired,req), razorpay_sub_id (string,100,opt), start_date (datetime,req), end_date (datetime,req), amount_paid (double,req)

  Collection: `family_groups`
  Attributes: admin_id (string,36,req), name (string,255,req), members (string,1000,req), leaderboard_type (enum:steps,karma,workouts,req)

  Collection: `community_groups`
  Attributes: admin_id (string,36,req), name (string,255,req), description (string,1000,opt), group_type (enum:diet,location,sport,challenge,support,req), member_count (integer,default:0)

  Collection: `community_dms`
  Attributes: sender_id (string,36,req), receiver_id (string,36,req), content (string,2000,req), sent_at (datetime,req), is_read (boolean,default:false)
  Index: [sender_id, receiver_id, sent_at DESC]

  Collection: `health_reports`
  Attributes: user_id (string,36,req), period (enum:weekly,monthly,req), report_start (datetime,req), report_end (datetime,req), summary_data (string,5000,req), pdf_local_path (string,500,opt), share_file_id (string,36,opt), share_expires_at (datetime,opt), share_url (string,500,opt), generated_at (datetime,req)

  Collection: `remote_config`
  Attributes: key (string,100,req), value (string,5000,req), type (enum:boolean,string,json,integer,req), rollout_pct (integer,default:100), ab_seed (string,50,opt)

  Collection: `sync_dead_letter`
  Attributes: user_id (string,36,req), original_item (string,5000,req), fail_count (integer,req), last_error (string,1000,req), created_at (datetime,req)
  ```

### 1B — Storage Buckets

- [x] **1.10 — Create Consolidated Appwrite Storage bucket via CLI**
  ```
  Using Appwrite CLI, create a unified storage bucket for project fitkarma-staging:
  
  `appwrite storage createBucket --bucketId fitkarma_files --name "FitKarma App Files" --maximumFileSize 50000000 --allowedFileExtensions jpg,jpeg,png,webp,mp4,pdf --permissions 'read("any")' 'create("any")' 'update("any")' 'delete("any")'`
  
  Note: Permissions and specific access logic (Avatars vs Posts vs Reports) are strictly handled at the application layer. Repeat for the production project.
  ```

### 1C — Appwrite Functions

- [x] **1.11 — Scaffold Consolidated Appwrite Function directory structure**
  ```
  In the project root, create `appwrite-functions/core-engine/`. 
  Inside `src/handlers/`, scaffold modular handlers for all logic (consolidated):
  - fitbit.js, garmin.js, razorpay.js, whatsapp.js, fcm.js, festival.js, reports.js, abha.js
  Initialize the central router in `src/index.js` which routes requests based on an internal action key or header.
  ```

- [x] **1.12 — Deploy Consolidated Appwrite Function via CLI**
  ```
  Deploy the unified core engine for staging and production:
  `appwrite functions create --functionId fitkarma-core-engine --name "FitKarma Core Engine" --runtime node-18.0`
  `appwrite functions createDeployment --functionId fitkarma-core-engine --entrypoint src/index.js --commands "npm install" --activate true`
  
  Note: Logic selection is handled via the `X-FitKarma-Action` header.
  ```

- [x] **1.13 — Set Appwrite Auth providers via CLI** (Performed via Console for Security)
  ```
  Enable OAuth2 (Google, Apple) and SMTP via Appwrite Console.
  Settings -> Auth -> Google/Apple
  Settings -> SMTP
  ```

---

## PHASE 2 — Flutter Project Structure & Core Infrastructure

- [x] **2.1 — Create full folder structure**
  ```
  In the Flutter project under lib/, create the complete directory tree exactly as follows. Use `mkdir -p` commands or create them in your IDE:

  lib/core/constants/
  lib/core/di/
  lib/core/errors/
  lib/core/network/
  lib/core/config/
  lib/core/security/
  lib/core/storage/
  lib/core/utils/

  lib/features/auth/data/ lib/features/auth/domain/ lib/features/auth/presentation/
  lib/features/dashboard/data/ lib/features/dashboard/domain/ lib/features/dashboard/presentation/
  lib/features/food/data/ lib/features/food/domain/ lib/features/food/presentation/
  lib/features/workout/data/ lib/features/workout/domain/ lib/features/workout/presentation/
  lib/features/steps/ lib/features/sleep/ lib/features/mood/ lib/features/period/
  lib/features/medications/ lib/features/body_metrics/ lib/features/habits/
  lib/features/nutrition/ lib/features/ayurveda/ lib/features/family/
  lib/features/emergency/ lib/features/festival/ lib/features/karma/
  lib/features/social/ lib/features/community/
  lib/features/insight_engine/engine/ lib/features/insight_engine/rules/ lib/features/insight_engine/models/
  lib/features/blood_pressure/ lib/features/glucose/ lib/features/spo2/
  lib/features/doctor_appointments/ lib/features/chronic_disease/
  lib/features/meal_planner/ lib/features/recipe_builder/ lib/features/fasting_tracker/
  lib/features/mental_health/ lib/features/meditation/ lib/features/journal/
  lib/features/wearables/ lib/features/reports/ lib/features/personal_records/
  lib/features/settings/ lib/features/abha/ lib/features/lab_reports/
  lib/features/home_widgets/ lib/features/whatsapp_bot/ lib/features/correlation_engine/
  lib/features/wedding_planner/

  lib/shared/widgets/
  lib/shared/theme/

  lib/l10n/

  Create a .dart file named `.gitkeep` placeholder in each leaf directory so git tracks them.
  ```

- [x] **2.2 — Implement `app_colors.dart` (light + dark tokens)**
  ```
  Create lib/shared/theme/app_colors.dart. Define two abstract classes: AppColors (light mode) and AppColorsDark (dark mode). Each must define static const Color values for every token listed below. Use the exact hex values specified.

  Light tokens:
  primary = #FF5722, primaryLight = #FF8A65, primarySurface = #FFF3EF,
  secondary = #3F3D8F, secondaryDark = #2C2A6B, secondarySurface = #E8E7F6,
  accent = #FFC107, accentLight = #FFECB3, accentDark = #FF8F00,
  background = #FDF6EC, surface = #FFFFFF, surfaceVariant = #F5F5F5,
  divider = #EEE8E4, success = #4CAF50, teal = #009688, purple = #9C27B0,
  warning = #FF9800, error = #F44336, rose = #E91E63,
  textPrimary = #1A1A2E, textSecondary = #6B6B8A, textMuted = #B0AECB

  Dark tokens (class AppColorsDark):
  background = #121218, surface = #1E1E2C, surfaceVariant = #252535,
  divider = #2C2C3E, primary = #FF7043, primarySurface = #2A1E1A,
  secondary = #5C59C4, secondaryDark = #3D3BA0, secondarySurface = #1E1D3A,
  accent = #FFD54F, accentLight = #2C2200, accentDark = #FFCA28,
  textPrimary = #F0EEF8, textSecondary = #9D9BBC, textMuted = #4A4860,
  success = #66BB6A, teal = #26C6DA, purple = #CE93D8, warning = #FFA726, error = #EF5350
  ```

- [x] **2.3 — Implement `app_text_styles.dart`**
  ```
  Create lib/shared/theme/app_text_styles.dart. Define a class AppTextStyles with static TextStyle getters for every style in the typography scale:
  displayLarge (32sp, w700), displayMedium (28sp, w700), h1 (24sp, w700), h2 (20sp, w700),
  h3 (18sp, w600), h4 (16sp, w600), sectionHeader (14sp, w700), sectionHeaderHindi (11sp, w500),
  bodyLarge (16sp, w400), bodyMedium (14sp, w400), bodySmall (12sp, w400),
  labelLarge (14sp, w600), labelMedium (12sp, w600), caption (10sp, w400),
  statLarge (22sp, w700), statMedium (18sp, w700), buttonLarge (16sp, w700),
  h1OnDark (24sp, w700, color: white), bodyOnDark (14sp, w400, color: white70),
  captionOnDark (11sp, w400, color: white54), navLabelEn (10sp, w600), navLabelHi (9sp, w400)
  All styles default to system font family (no explicit fontFamily set). Colors come from AppColors for light and AppColorsDark for dark — accept a bool isDark parameter or use a static method to return the correct set.
  ```

- [x] **2.4 — Implement `app_theme.dart` (light + dark ThemeData)**
  ```
  Create lib/shared/theme/app_theme.dart. Define a class AppTheme with two static ThemeData getters: lightTheme and darkTheme. Both must use:
  - useMaterial3: true
  - ColorScheme from AppColors/AppColorsDark tokens (primary, secondary, surface, background, error)
  - TextTheme from AppTextStyles
  - AppBarTheme: elevation 0, backgroundColor matches scaffold background for each theme
  - CardTheme: elevation 2 (light) / 0 + border (dark), borderRadius 12
  - InputDecorationTheme: border OutlineInputBorder radius 12, focusedBorder 2px primary, defaultBorder 1px divider
  - ElevatedButtonTheme: borderRadius 12, primary color, buttonLarge text style
  - OutlinedButtonTheme: borderRadius 12, primary border and text
  - BottomNavigationBarThemeData: selectedItemColor primary, unselectedItemColor textMuted, backgroundColor surface
  - ChipThemeData: borderRadius 20, outlined style
  - Scaffold background: AppColors.background (light) / AppColorsDark.background (dark)
  ```

- [x] **2.5 — Implement `api_endpoints.dart` (AW constants)**
  ```
  Create lib/core/constants/api_endpoints.dart. Define a class AW with all static const String collection IDs using String.fromEnvironment for projectId, endpoint, and dbId. List every collection constant exactly:
  users, foodLogs='food_logs', foodItems='food_items', workoutLogs='workout_logs',
  stepLogs='step_logs', sleepLogs='sleep_logs', moodLogs='mood_logs',
  periodLogs='period_logs', medications, habits, bodyMeasurements='body_measurements',
  karmaTx='karma_transactions', nutritionGoals='nutrition_goals',
  posts, challenges, subscriptions, familyGroups='family_groups', workouts,
  bloodPressureLogs='blood_pressure_logs', glucoseLogs='glucose_logs',
  spo2Logs='spo2_logs', doctorAppointments='doctor_appointments',
  fastingLogs='fasting_logs', mealPlans='meal_plans', recipes,
  journalEntries='journal_entries', personalRecords='personal_records',
  communityGroups='community_groups', healthReports='health_reports',
  communityDms='community_dms', labReports='lab_reports',
  abhaLinks='abha_links', remoteConfig='remote_config',
  syncDeadLetter='sync_dead_letter'.
  Storage buckets: filesBucket='fitkarma_files'. (Consolidated; all media stored here).
  ```

- [x] **2.6 — Implement `appwrite_client.dart`**
  ```
  Create lib/core/network/appwrite_client.dart. Implement the AppwriteClient class as a singleton with a static Client initialized using the endpoint and projectId from AW constants via String.fromEnvironment. Set setSelfSigned(status: false). Expose static getters for: client (Client), account (Account), databases (Databases), storage (Storage), realtime (Realtime), functions (Functions). Add a static initialize() async method that must be called in main() before runApp(). Add a comment block explaining where to add certificate pinning via a native channel or http_certificate_pinning package.
  ```

- [x] **2.7 — Implement `key_manager.dart` (PBKDF2 + HKDF)**
  ```
  Create lib/core/security/key_manager.dart. Implement class KeyManager using the `cryptography` package. It must:
  1. getMasterKey() async → Uint8List: checks flutter_secure_storage for 'master_key'. If absent, derives via PBKDF2(input: '$deviceId:$installUuid', salt: stored 32-byte random salt, iterations: 200000, keyLength: 32). Stores result in secure storage. deviceId from device_info_plus, installUuid generated once and stored in secure storage.
  2. getKeyFor(String dataClass) async → Uint8List: calls getMasterKey() then HKDF-expand with info = utf8.encode(dataClass), length = 32. Valid dataClass values: 'bp_glucose', 'period', 'journal', 'appointments'.
  Each data class produces a cryptographically independent key — compromise of one does not affect others. Add unit-testable pure functions for PBKDF2 and HKDF separately.
  ```

- [x] **2.8 — Implement `encryption_service.dart` (AES-256-GCM)**
  ```
  Create lib/core/security/encryption_service.dart. Implement class EncryptionService using the `cryptography` package's AesCbc or AesGcm. Provide:
  - static Future<String> encrypt(String plaintext, Uint8List key): generates a random 12-byte nonce, encrypts with AES-256-GCM, returns base64(nonce + ciphertext + mac) as a single string.
  - static Future<String> decrypt(String encrypted, Uint8List key): splits the base64 string back into nonce + ciphertext + mac, decrypts, returns plaintext.
  - static Future<String> encryptField(String value, String dataClass): calls KeyManager.getKeyFor(dataClass) then encrypt().
  - static Future<String> decryptField(String value, String dataClass): calls KeyManager.getKeyFor(dataClass) then decrypt().
  Throw a typed AppException on any decryption failure. Never log plaintext or keys.
  ```

---

## PHASE 3 — Drift Local Database

- [x] **3.1 — Define all Drift table classes**
  ```
  Create lib/core/storage/tables/. Create one file per table group:

  File: core_log_tables.dart — Define Drift Table classes: FoodLogs, FoodItems, WorkoutLogs, StepLogs, SleepLogs, MoodLogs, Medications, Habits, HabitCompletions, BodyMeasurements, FastingLogs, MealPlans, Recipes, PersonalRecords, NutritionGoals, KarmaTransactions.

  File: sync_tables.dart — Define: SyncQueue (columns: id, collection, operation, localId, appwriteDocId nullable, payload, idempotencyKey, fieldVersions nullable, createdAt, retryCount default 0, lastError nullable), SyncDeadLetter (columns: id, userId, originalItem, failCount, lastError, createdAt).

  File: sensitive_tables.dart — Define: BloodPressureLogs, GlucoseLogs, Spo2Logs, PeriodLogs, JournalEntries, DoctorAppointments. Columns that hold sensitive data (BP values, glucose readings, journal text, notes) are stored as TextColumn and encrypted before insert via EncryptionService.

  File: india_platform_tables.dart — Define: LabReports, AbhaLinks, EmergencyCard, FestivalCalendar (with all columns from Section 11.11.4 of the spec), RemoteConfigCache, WeddingEvents.

  All tables must use @DataClassName annotations and override primaryKey where needed.
  ```

- [x] **3.2 — Implement `AppDatabase` class with migrations**
  ```
  Create lib/core/storage/app_database.dart. Implement the AppDatabase class annotated with @DriftDatabase listing ALL table classes from 3.1. The constructor takes an encryptionKey String and passes it to _openConnection().

  _openConnection(String encryptionKey): returns a LazyDatabase that opens 'fitkarma.db' in getApplicationDocumentsDirectory(), executes `PRAGMA key = '$encryptionKey'` and `PRAGMA cipher_page_size = 4096` before any other statement.

  schemaVersion = 5.

  MigrationStrategy:
  - onCreate: createAll() + create FTS5 virtual table food_items_fts with triggers (see below)
  - onUpgrade from < 2: add idempotencyKey and fieldVersions to foodLogs
  - onUpgrade from < 3: add sleepDebtMin to sleepLogs, createTable(labReports)
  - onUpgrade from < 4: createTable for all sensitive tables (bloodPressureLogs, glucoseLogs, spo2Logs, periodLogs, journalEntries, doctorAppointments)
  - onUpgrade from < 5: createTable for abhaLinks, emergencyCard, festivalCalendar, remoteConfigCache

  FTS5 setup in onCreate (after createAll):
  CREATE VIRTUAL TABLE food_items_fts USING fts5(name, name_local, content="food_items", content_rowid="rowid")
  Plus three triggers: food_items_ai (after insert), food_items_ad (after delete), food_items_au (after update) to keep FTS in sync.

  Add searchFoodFts(String query) method that runs prefix FTS5 query with BM25 ordering, LIMIT 50.
  Run `flutter pub run build_runner build` after implementing to generate the .g.dart file.
  ```

- [x] **3.3 — Implement `drift_service.dart` (singleton init)**
  ```
  Create lib/core/storage/drift_service.dart. Implement class DriftService with:
  - static AppDatabase? _db
  - static AppDatabase get db: assert _db != null, return _db!
  - static Future<void> init() async: calls KeyManager.getMasterKey(), base64-encodes it, instantiates AppDatabase(keyB64), stores in _db. Then calls customSelect('SELECT 1').get() to pre-warm the connection.

  In main.dart, call DriftService.init() before runApp(). Pass DriftService.db to a Riverpod provider override.
  ```

- [x] **3.4 — Implement sync queue processor**
  ```
  Create lib/core/network/sync_queue.dart. Implement:

  1. generateIdempotencyKey(String userId, String entityType, String localId) → String: SHA-256 of '$userId:$entityType:$localId:${DateTime.now().millisecondsSinceEpoch}' using the crypto package.

  2. Class SyncQueueProcessor with constructor taking AppDatabase db and AppwriteClient:
     - flushPending() async: fetches all SyncQueue entries with retryCount < 5, groups into batches of 20, for each item calls _processItem(). On success: deletes from queue. On failure: increments retryCount + updates lastError. After 5 failures: moves to SyncDeadLetter table, deletes from SyncQueue.
     - _processItem(SyncQueueEntry item) async: parses operation (create/update/delete), calls the appropriate Appwrite Databases method with the idempotencyKey header, handles 409 conflict gracefully.
     - Exponential backoff: 1s → 2s → 4s → 8s → 16s between retries.

  3. WorkManager background entry point (annotated @pragma('vm:entry-point')):
     callbackDispatcher(): re-inits DriftService and AppwriteClient independently, checks ConnectivityResult, calls SyncQueueProcessor.flushPending().
  ```

- [x] **3.5 — Implement `connectivity_service.dart` and `remote_config.dart`**
  ```
  Create lib/core/network/connectivity_service.dart: a Riverpod StreamProvider that wraps connectivity_plus's ConnectivityResult stream. Expose isOnline getter returning true if result != ConnectivityResult.none.

  Create lib/core/config/remote_config.dart: implement class RemoteConfig as an AsyncNotifierProvider. build(): loads from Drift remoteConfigCache first (immediate). Then in _refreshInBackground() fetches from Appwrite remote_config collection, saves to Drift cache, invalidates. Provide typed getters: getBool(String key), getString(String key), getJson(String key), getInt(String key). Default values in RemoteConfigData.defaults().
  ```

---

## PHASE 4 — Shared Widget Library

- [x] **4.1 — Implement `activity_rings.dart`**
  ```
  Create lib/shared/widgets/activity_rings.dart. Implement ActivityRingsWidget as a StatelessWidget. Props: List<RingData> rings where RingData has {double progress (0.0–1.0), Color color, String label, String value, String goal}. Renders four concentric CustomPaint rings using Canvas.drawArc. Ring stroke width: 10px, lineCap: round. Outer ring = index 0 (calories, orange), then steps (green), water (teal), active minutes (purple). Gap between rings: 8px. Renders stat labels below the ring cluster with value/goal text. Adapts ring track color from AppColors.divider (light) / AppColorsDark.divider (dark) via Theme.of(context).
  ```

- [x] **4.2 — Implement `insight_card.dart` and `correlation_insight_card.dart`**
  ```
  Create lib/shared/widgets/insight_card.dart. Props: String message, VoidCallback onThumbsUp, VoidCallback onThumbsDown, VoidCallback onDismiss. Background: AppColors.accentLight (light) / AppColorsDark.accentLight (dark). Left edge: 4px amber primary border. Leading: lightbulb Icon. Text: bodyMedium. Bottom-right: 👍 👎 IconButtons. Top-right: dismiss X button.

  Create lib/shared/widgets/correlation_insight_card.dart. Props: String message, List<ModuleLink> modules (each has: String label, IconData icon, VoidCallback onTap), VoidCallback onThumbsUp, VoidCallback onThumbsDown. Background: AppColors.secondarySurface (light) / AppColorsDark.secondarySurface (dark). Bottom row: module pill chips that are tappable. Renders "🔗" icon in top-left. Same 👍/👎 controls as InsightCard.
  ```

- [x] **4.3 — Implement `async_value_widget.dart`, `shimmer_loader.dart`, `error_retry_widget.dart`**
  ```
  Create lib/shared/widgets/async_value_widget.dart. A generic widget: class AsyncValueWidget<T> extends ConsumerWidget. Props: AsyncValue<T> value, Widget Function(T) data, Widget? loading, Widget? error. Uses value.when() internally. Default loading: ShimmerLoader(). Default error: ErrorRetryWidget.

  Create lib/shared/widgets/shimmer_loader.dart: wraps the shimmer package. Uses AppColors.divider as base and AppColors.surface as highlight. Renders a column of 3 shimmer rectangles by default, or accepts a child widget.

  Create lib/shared/widgets/error_retry_widget.dart: Props: Object error, VoidCallback onRetry, String? message. Shows error icon, message text, and an orange "Retry" ElevatedButton. Never shows raw exception details to the user — only a generic "Something went wrong" message.
  ```

- [x] **4.4 — Implement `bilingual_label.dart`, `encryption_badge.dart`, `sync_status_banner.dart`**
  ```
  Create lib/shared/widgets/bilingual_label.dart. Props: String english, String hindi, TextStyle? englishStyle, TextStyle? hindiStyle. Renders a Column with English text (default h3) above Hindi text (default sectionHeaderHindi, color: textSecondary). Use AppTextStyles.

  Create lib/shared/widgets/encryption_badge.dart. A small pill widget: 🔒 icon + "AES-256" text. Background: AppColors.teal with opacity 0.1, border teal. Text: caption size, teal color. Accepts an optional onTap that shows an AlertDialog explaining what is encrypted.

  Create lib/shared/widgets/sync_status_banner.dart. Props: int dlqCount, bool isOffline, bool isLowDataMode. Priority: if dlqCount > 0 → amber banner "⚠ {dlqCount} items failed to sync. Tap to review." with onTap callback. Else if isOffline → teal banner "Offline — changes saved locally". Else if isLowDataMode → teal "Low Data Mode active". Returns SizedBox.shrink() if none apply. Positioned as a top PreferredSizeWidget or pinned Column child.
  ```

- [x] **4.5 — Implement `quick_log_fab.dart`**
  ```
  Create lib/shared/widgets/quick_log_fab.dart. Implement QuickLogFAB as a StatefulWidget speed-dial FAB. The main FAB is orange (#FF5722), white + icon, 56px. On tap: expands to show 6 sub-action mini-FABs with labels and icons, stacked vertically above the main FAB with a 200ms staggered animation:
  1. 🍽 Food — opens FoodLogBottomSheet
  2. 💧 Water — opens WaterLogBottomSheet (+ 1 glass increment)
  3. 😊 Mood — opens MoodLogBottomSheet
  4. 💪 Workout — navigates to /home/workout
  5. 🩺 BP — opens BPLogBottomSheet
  6. 🩸 Glucose — opens GlucoseLogBottomSheet
  Each sub-FAB is 40px, surface colour background, primary colour icon. An overlay scrim covers the rest of the screen when expanded. Props: Map<QuickLogAction, VoidCallback> onActions.
  ```

- [x] **4.6 — Implement remaining shared widgets**
  ```
  Create the following shared widgets in lib/shared/widgets/:

  food_item_card.dart: Props: FoodItemModel food, VoidCallback onAdd. 72×72px rounded image (or emoji fallback in Low Data Mode). Bilingual food name. Indian portion text (e.g. "1 katori · 180 kcal"). Orange circular + button. Card: 8px radius, surface bg.

  karma_level_card.dart: Props: int level, String title, int currentXP, int nextLevelXP. Dark heroGradient background. Level badge (indigo pill). Level title text (h2 white). XP progress LinearProgressIndicator (amber). "Next level in X XP" caption white54.

  dosha_chart.dart: Props: double vataPct, double pittaPct, double kaphaPct. A PieChart from fl_chart with three segments: Vata (sky blue), Pitta (orange-red), Kapha (green). Centre label: dominant dosha name. Legend below the chart.

  meal_tab_bar.dart: Props: MealType selected, ValueChanged<MealType> onChanged. Four tabs: Breakfast 🌅, Lunch ☀️, Dinner 🌙, Snacks 🍎. Each tab is a pill chip with icon + bilingual label. Selected: primary color fill. Unselected: outlined.

  micronutrient_bar.dart: Props: String name, double current, double goal, Color color. A compact Row: name label (10sp), LinearProgressIndicator (flex), "Xmg / Xmg" caption (10sp). Traffic-light color: green if ≥ 80% RDA, amber if 40–79%, red if < 40%.

  festival_countdown_banner.dart: Props: String festivalName, String festivalNameHi, int daysRemaining, String fastingType, Color bannerColor, VoidCallback onViewDietPlan, VoidCallback? onSpecialAction, String? specialActionLabel. Renders a colored gradient card with festival name (bilingual), days remaining badge, fasting mode pill, and two CTA buttons.

  wedding_countdown_card.dart: Props: String role, int daysToWedding, String nextEventName, int daysToNextEvent, VoidCallback onViewPlan. Gold gradient (#D4A017 → #B8860B) card. Role badge (pill). Days countdown (displayMedium white). Next event chip. "View Plan" button.
  ```

---

## PHASE 5 — App Root, Navigation & Auth

- [x] **5.1 — Implement `main.dart` and `app.dart`**
  ```
  Create lib/main.dart: async main() that calls WidgetsFlutterBinding.ensureInitialized(), loads dotenv from the correct .env file based on build flavor, calls DriftService.init(), calls AppwriteClient.initialize(), then runApp(ProviderScope(overrides: [driftDbProvider.overrideWithValue(DriftService.db)], child: FitKarmaApp())).

  Create lib/app.dart: FitKarmaApp extends ConsumerWidget. Watches a themeProvider (StateProvider<ThemeMode> defaulting to ThemeMode.system). Returns a MaterialApp.router with:
  - routerConfig: appRouter (GoRouter from 5.2)
  - theme: AppTheme.lightTheme
  - darkTheme: AppTheme.darkTheme
  - themeMode: from themeProvider
  - localizationsDelegates and supportedLocales for all 23 locales (en + 22 Indian languages)
  - title: 'FitKarma'
  ```

- [x] **5.2 — Implement GoRouter with all routes**
  ```
  Create lib/core/di/providers.dart. Define appRouter as a GoRouter with all routes listed below. Use ShellRoute for the bottom-nav shell wrapping /home/* routes. Implement a redirect guard that checks authStateProvider — if not authenticated and route is not /login or /register or /onboarding/*, redirect to /login.

  Routes to implement (use GoRoute for each):
  / → SplashScreen
  /onboarding/:step → OnboardingScreen (steps 1–6)
  /login → LoginScreen
  /register → RegisterScreen
  ShellRoute → MainShell (BottomNavBar)
    /home/dashboard → DashboardScreen
    /home/food → FoodHomeScreen
      /home/food/log/:mealType → FoodLogScreen
      /home/food/search → FoodSearchScreen
      /home/food/scan → BarcodeScanScreen
      /home/food/photo → PhotoScanScreen
      /home/food/lab-scan → LabReportScanScreen
      /home/food/detail/:id → FoodDetailScreen
      /home/food/recipes → RecipeBrowserScreen
      /home/food/recipes/new → RecipeBuilderScreen
      /home/food/planner → MealPlannerScreen
    /home/workout → WorkoutHomeScreen
      /home/workout/:id → WorkoutDetailScreen
      /home/workout/:id/active → ActiveWorkoutScreen
      /home/workout/gps → GpsWorkoutScreen
      /home/workout/custom → CustomWorkoutBuilderScreen
      /home/workout/calendar → WorkoutCalendarScreen
    /home/steps → StepsHomeScreen
    /home/social → SocialFeedScreen
      /home/social/groups → CommunityGroupsScreen
      /home/social/groups/:id → GroupDetailScreen
      /home/social/dm/:userId → DirectMessageScreen
  /karma → KarmaHubScreen
  /profile → ProfileScreen
  /sleep → SleepTrackerScreen
  /mood → MoodTrackerScreen
  /habits → HabitTrackerScreen
  /period → PeriodTrackerScreen
  /medications → MedicationsScreen
  /body-metrics → BodyMetricsScreen
  /ayurveda → AyurvedaHubScreen
  /family → FamilyProfilesScreen
  /emergency → EmergencyCardScreen
  /blood-pressure → BPTrackerScreen
  /glucose → GlucoseTrackerScreen
  /spo2 → SpO2Screen
  /lab-reports → LabReportsHomeScreen
  /abha → ABHAScreen
  /chronic-disease → ChronicDiseaseHubScreen
  /fasting → FastingTrackerScreen
  /meditation → MeditationScreen
  /journal → JournalScreen
  /mental-health → MentalHealthHubScreen
  /wearables → WearableConnectionsScreen
  /home-widgets → HomeWidgetConfigScreen
  /reports → HealthReportsScreen
  /personal-records → PersonalRecordsScreen
  /doctor-appointments → DoctorAppointmentsScreen
  /referral → ReferralScreen
  /settings → SettingsScreen
  /subscription → SubscriptionPlansScreen
  /festival-calendar → FestivalCalendarScreen
  /festival-calendar/:festivalKey/diet → FestivalDietPlanScreen
  /wedding-planner/setup → WeddingPlannerSetupScreen
  /wedding-planner → WeddingPlannerHomeScreen
  /wedding-planner/event/:eventKey → WeddingEventDayScreen
  /wedding-planner/recovery → WeddingRecoveryScreen
  ```

- [x] **5.3 — Implement Auth feature (login, register, session)**
  ```
  Create lib/features/auth/data/auth_repository.dart. Implement AuthRepository with methods:
  - login(String email, String password) async → void: calls AppwriteClient.account.createEmailPasswordSession(). Stores the session JWT in flutter_secure_storage under key 'session_jwt'.
  - register(String email, String password, String name) async → void: calls account.create() then login().
  - loginWithGoogle() async → void: calls account.createOAuth2Session(provider: 'google').
  - logout() async → void: calls account.deleteSession('current'), clears secure storage.
  - getUser() async → models.User: calls account.get().
  - isLoggedIn() async → bool: tries getUser(), returns false on AppwriteException.
  - refreshSession() async → void: calls account.updateSession(sessionId: 'current').

  Create lib/features/auth/domain/auth_providers.dart: authStateProvider as an AsyncNotifierProvider<AuthNotifier, AppUser?>. The notifier checks isLoggedIn() on build. Exposes login(), logout(), register() mutation methods.

  Create LoginScreen and RegisterScreen in lib/features/auth/presentation/ following the UI spec in Section 7.1. Use Riverpod ConsumerWidget. All loading states use ShimmerLoader. All errors display in an ErrorSnackBar.
  ```

- [x] **5.4 — Implement bottom navigation bar**
  ```
  Create lib/shared/widgets/bottom_nav_bar.dart. Implement FitKarmaBottomNav as a StatelessWidget. Props: int currentIndex, ValueChanged<int> onTap. Five tabs defined as a list of BottomNavItem {IconData outlinedIcon, IconData filledIcon, String labelEn, String labelHi, String route}.

  Tabs in order: Home (home_outlined/home), Food (restaurant_outlined/restaurant), Workout (fitness_center_outlined/fitness_center), Steps (directions_walk_outlined/directions_walk), Me (person_outline/person).

  Each tab label renders TWO Text widgets stacked in a Column: English (navLabelEn style) and Hindi (navLabelHi style). Active: primary color icon and labels. Inactive: textMuted.

  Background: surface color. Dark mode: #1E1E2C. Elevation: 8dp. Wrap in a SyncStatusBanner above the nav bar (watches syncStatusProvider).
  ```

---

## PHASE 6 — Core Feature Screens

- [x] **6.1 — Dashboard screen**
  ```
  Create lib/features/dashboard/presentation/dashboard_screen.dart. Implement DashboardScreen as a ConsumerWidget. Uses Pattern A scaffold (standard light/dark).

  Watches these Riverpod providers:
  - todayStepsProvider → AsyncValue<int>
  - todayCaloriesProvider → AsyncValue<double>
  - todayWaterProvider → AsyncValue<int> (glasses)
  - todayActiveMinutesProvider → AsyncValue<int>
  - latestInsightProvider → AsyncValue<InsightOutput?>
  - todayMealsProvider → AsyncValue<Map<MealType, List<FoodLogModel>>>
  - karmaProvider → AsyncValue<KarmaData>
  - activeFestivalProvider → AsyncValue<FestivalData?>
  - activeWeddingProvider → AsyncValue<WeddingEventData?>

  Layout (SingleChildScrollView → Column with 16px padding):
  1. Header Row: CircleAvatar (40px), BilingualLabel greeting, Karma XP amber chip, Level indigo chip
  2. IF activeFestivalProvider has data AND is within festival dates: FestivalCountdownBanner (replaces insight card)
     ELSE IF activeWeddingProvider has data AND within wedding dates: WeddingCountdownCard
  3. ActivityRingsWidget: passes progress values derived from the four step/calorie/water/activeMin providers
  4. InsightCard OR CorrelationInsightCard (from latestInsightProvider)
  5. SectionHeader "Today's Meals / आज का खाना" + MealTypeTabBar
  6. Below selected tab: list of FoodItemCard compact variants (no photo in low data mode)
  7. QuickLogFAB at bottom-right (Positioned above BottomNav)

  All async values wrapped in AsyncValueWidget. Data is loaded from Drift first (zero network calls on initial render).
  ```

- [x] **6.2 — Food logging feature (repository + drift service + screen)**
  ```
  Create lib/features/food/data/food_drift_service.dart: implement typed Drift queries:
  - getTodayLogs(String userId, DateTime date) → Stream<List<FoodLog>>
  - insertLog(FoodLogsCompanion log) async → int
  - searchFoodFts(String query) → Future<List<FoodItem>>
  - getRecentLogs(String userId, int limit) → Future<List<FoodLog>>
  - copyYesterdayMeals(String userId) async → int: reads yesterday's logs, inserts copies for today with new idempotencyKeys and log_method = 'copy_yesterday'
  - bulkInsertFoodItems(List<FoodItemsCompanion> items) async: for seeding the 10k Indian food database

  Create lib/features/food/data/food_repository.dart: orchestrates between FoodDriftService and FoodAwService. search() calls FTS5 first, then Appwrite if < 5 results, then OpenFoodFacts as last resort. logFood() writes to Drift first, then enqueues to SyncQueue.

  Create FoodHomeScreen in lib/features/food/presentation/. Implement full UI per spec Section 7.3 including: daily macro rings, micronutrient bars, meal log list, Copy Yesterday banner. Use MealTypeTabBar for tab switching.
  ```

- [x] **6.3 — Food Log Screen (search + scan + voice)**
  ```
  Create lib/features/food/presentation/food_log_screen.dart. Receives route param mealType. Implements the full food log UI from spec Section 7.3:

  1. Search bar with bilingual placeholder, mic icon, barcode icon. On text change: debounce 300ms → call foodSearchProvider(query). Results in a ListView of FoodItemCard widgets.
  2. Four quick-action chips: Scan Label → BarcodeScanScreen, Upload Plate Photo → PhotoScanScreen, Lab/Rx Scan → LabReportScanScreen, Manual Entry → opens ManualEntryBottomSheet.
  3. "Frequent Indian Portions" 2×N grid from indianFrequentFoodsProvider (seeded Drift data).
  4. "Recent Logs" list from recentLogsProvider(userId).
  5. "Copy Yesterday's Meals" banner shown when today's logs are empty.
  6. Tapping a FoodItemCard → opens PortionSelectorBottomSheet with Indian unit selector (katori/piece/glass/gram) + quantity slider → on confirm: calls FoodRepository.logFood().
  7. Voice log via speech_to_text: on mic tap → listen → transcribe → auto-search. Show results for confirmation.
  ```

- [x] **6.4 — Barcode + Photo + Lab OCR scan screens**
  ```
  Create lib/features/food/data/barcode_service.dart: wraps flutter_barcode_scanner. scanBarcode() → Future<String?>. On result: calls OpenFoodFacts API (https://world.openfoodfacts.org/api/v2/product/{barcode}.json), parses nutrients, caches to Drift food_items.

  Create lib/features/food/data/ocr_service.dart: wraps google_mlkit_text_recognition. recognizeNutritionLabel(InputImage) → Future<NutritionData?>. Uses TextRecognitionV2. Parses common nutrition label formats (Energy, Protein, Carbohydrate, Fat fields).

  Create lib/features/food/data/lab_report_ocr_service.dart: uses TextRecognitionV2 to recognize lab report text. LabReportParser class with regex patterns for: glucose (fasting/random), HbA1c, hemoglobin, cholesterol, vitamin D, B12, TSH, creatinine. Returns LabReportExtraction model.

  Create LabReportScanScreen per spec Section 7.7: camera/gallery picker, ShimmerLoader during OCR, extracted LabValueRow list, Import button that writes to glucose_logs / blood_pressure_logs via their respective repositories.
  ```

- [x] **6.5 — Blood pressure tracker (screen + repository)**
  ```
  Create lib/features/blood_pressure/domain/bp_classifier.dart: implement classify(int systolic, int diastolic) → BPClassification enum {normal, elevated, stage1, stage2, crisis} using AHA thresholds exactly:
  - crisis: systolic >= 180 OR diastolic >= 120
  - stage2: systolic >= 140 OR diastolic >= 90
  - stage1: systolic >= 130 OR diastolic >= 80
  - elevated: systolic >= 120 AND diastolic < 80
  - normal: else

  Create BPDriftService: all BP logs read/write go through EncryptionService.encryptField/decryptField with dataClass 'bp_glucose' before any Drift companion insert.

  Create BPTrackerScreen per spec Section 7.6 — Pattern B scaffold. Hero: latest reading (systemically + diastolic), AHA classification colour-coded badge, EncryptionBadge. Body: BPTrendChart (fl_chart LineChart with 5 AHA reference bands), Log BP FAB that opens a bottom sheet with systolic/diastolic/pulse fields + save button.

  Emergency alert: if classification == crisis → show AlertDialog with red header "Seek immediate medical attention" + call emergency button.
  ```

- [x] **6.6 — Glucose tracker (screen + HbA1c estimator)**
  ```
  Create lib/features/glucose/presentation/glucose_tracker_screen.dart. Pattern B scaffold. Props from glucoseProvider: latest reading, classification, 90-day readings for HbA1c estimate.

  Implement HbA1c estimator: if readings.length >= 30 → compute 90-day rolling average glucose (mg/dL) → estimated HbA1c % = (avgGlucose + 46.7) / 28.7. Display in a card "Estimated HbA1c: X.X%".

  Reading type chips: Fasting / Post-meal / Random / Bedtime. Chart: fl_chart LineChart with coloured reference bands per reading type (fasting: normal < 100, prediabetic 100–125, diabetic ≥ 126). Meal correlation row: shows linked FoodLog for post-meal readings. "Import from Lab Report" row links to /home/food/lab-scan. All data encrypted via EncryptionService (dataClass: 'bp_glucose').
  ```

- [x] **6.7 — Sleep tracker (with sleep debt + chronotype)**
  ```
  Create lib/features/sleep/presentation/sleep_tracker_screen.dart. Pattern B (sleepGradient). Hero: last night duration, quality emoji, Good/Poor badge.

  Implement SleepDriftService:
  - getWeeklyLogs() → Stream<List<SleepLog>>
  - computeSleepDebt(List<SleepLog> logs) → int minutes: sum of (7h*60 - duration_min) across the current week, capped at 0 for nights with surplus.
  - detectChronotype(List<SleepLog> logs) → Chronotype?: requires >= 30 logs; computes average bedtime hour; earlyBird < 22:00, nightOwl > 00:00, intermediate otherwise.

  Body: 7-day bar chart (fl_chart BarChart), Sleep Debt card (red/green deficit-credit bar), Chronotype card (shows after 30 days, indigo card), Ayurvedic tip card (if avg < 6h).
  Log Sleep bottom sheet: bedtime TimePicker, wake TimePicker, quality 1–5 emoji row, notes field.
  ```

- [x] **6.8 — Mood tracker + habit tracker screens**
  ```
  Create MoodTrackerScreen in lib/features/mood/presentation/. Layout: 5-emoji mood selector (tap to select), energy slider 1–10, stress slider 1–10, scrollable tags row (anxious/calm/focused/tired/motivated/irritable), optional voice note button (records to local file, never uploaded). Log Mood button → writes to MoodDriftService → enqueues sync. Show 7-day mood heatmap calendar below (fl_chart HeatMapCalendar equivalent using a GridView).

  Create HabitTrackerScreen in lib/features/habits/presentation/. List of habit cards: each shows habit icon (emoji), name, BilingualLabel, streak flame 🔥 badge if streak > 0, daily progress bar (current/target). Tap to increment. Streak Recovery button (amber outlined): shown only if streak was broken within 24h, costs 50 XP confirmation dialog. Below list: weekly heatmap grid per habit (GitHub-style contribution graph using a CustomPaint or Table widget).
  ```

- [x] **6.9 — Nutrition goal engine + micronutrient tracking**
  ```
  Create lib/features/nutrition/domain/nutrition_calculator.dart. Implement:

  calculateBMR(double weightKg, double heightCm, int ageYears, String gender) → double:
  - Male: (10 × weight) + (6.25 × height) − (5 × age) + 5
  - Female: (10 × weight) + (6.25 × height) − (5 × age) − 161

  calculateTDEE(double bmr, String activityLevel) → double:
  - sedentary: bmr × 1.2, light: × 1.375, moderate: × 1.55, active: × 1.725, very_active: × 1.9

  Indian ICMR RDA micronutrient targets:
  - Iron: adult female 21mg, male 17mg
  - Vitamin B12: 2.2mcg
  - Vitamin D: 600 IU (15mcg)
  - Calcium: 1000mg

  computeMicronutrientGap(String userId) → Future<MicronutrientGap>: sums today's logs from Drift, computes gap vs RDA, returns a model with deficit amounts.

  In NutritionGoalScreen: show 4 MicronutrientBar widgets. Show weekly supplement gap report card if any nutrient is < 60% RDA for 5+ days.
  ```

---

## PHASE 7 — Insight Engine

- [x] **7.1 — Implement insight engine core (evaluator + scheduler)**
  ```
  Create lib/features/insight_engine/models/insight_rule.dart:
  abstract class InsightRule {
    String get id;
    int get priority; // 1 = highest
    Future<bool> condition(DriftService db, String userId);
    Future<String> message(DriftService db, String userId);
  }

  Create lib/features/insight_engine/engine/rule_evaluator.dart:
  class RuleEvaluator {
    final List<InsightRule> rules;
    // evaluateAll(): runs all rules in priority order, returns the first 2 whose condition() == true
    Future<List<InsightOutput>> evaluateAll(DriftService db, String userId) async
  }

  Create lib/features/insight_engine/engine/insight_scheduler.dart:
  - Runs daily via WorkManager (or on app foreground if last run > 20h ago)
  - Deduplicates: never shows the same insight id twice in the same day (tracked in Drift)
  - Throttles: max 2 insight cards surfaced per day
  - Stores user ratings (👍/👎) in Drift; suppresses rules with > 3 thumbs-down from the same user
  ```

- [x] **7.2 — Implement insight rules (all modules)**
  ```
  Create lib/features/insight_engine/rules/ with these files:

  nutrition_rules.dart — Rules:
  - ProteinDeficitRule: if protein_today < goal_protein * 0.8 → "You're {gap}g protein short today. Adding a katori of dal will help!"
  - MicronutrientGapRule: if any micronutrient < 40% RDA for 5+ days → "[Nutrient] is consistently low. Consider [food source]."

  sleep_rules.dart — Rules:
  - SleepDebtRule: if cumulative_sleep_debt_this_week > 3h → "You've built up {hours}h sleep debt this week. Aim for 8h tonight."
  - PoorSleepConsistencyRule: if avg_sleep_7d < 6h → "Your 7-day sleep average is under 6 hours. Consider [Ayurveda tip based on dosha]."

  bp_rules.dart — Rule:
  - ElevatedBPConsistencyRule: if last 3 BP readings classified as elevated or above → "Your BP has been elevated for 3 consecutive readings. Track sodium intake and consult your doctor."

  glucose_rules.dart — Rule:
  - PostMealSpikeRule: if post_meal_glucose > 140 for 3+ consecutive logs → "Post-meal glucose spikes detected 3 days in a row. A 20-min walk after lunch may help."

  mood_rules.dart — Rule:
  - LowMoodStreakRule: if mood_score_avg_7d < 2.5 → "Your mood has been low for a week. Consider talking to someone or trying a 10-min meditation."

  fasting_rules.dart — Rule:
  - FastingWindowRule: if fasting active and eating_window_start approaching → "Your eating window opens in 30 minutes. Prepare a hydrating first meal."

  correlation_rules.dart — Cross-module rules:
  - SleepMoodCorrelationRule: if sleep_avg_7d < 6 AND mood_avg_7d < 3 → "Your mood drops on poor sleep nights — pattern detected over 8 days."
  - WorkoutProteinRule: if on_workout_day AND protein_today < goal_protein * 0.6 → "You under-eat protein by {gap}g on workout days — add paneer or eggs post-workout."
  - FastingBPRule: if fasting_day AND bp_today < bp_avg - 8 → "Your systolic BP is ~{diff}mmHg lower on fasting days."
  - FestivalCalorieRule: if festival_week AND calorie_avg_7d > tdee + 500 → "You consumed {excess}kcal extra during {festival} week — here's a 3-day reset plan."
  - PostMealWalkRule: if post_meal_glucose_high_3days AND step_count_post_meal < 2000 → "A 20-min walk after lunch may help normalize your post-meal glucose."

  server_rules.dart — Fetches rules from RemoteConfig 'insight.server_rules' key, deserializes them, and wraps them as dynamic InsightRule implementations.
  ```

---

## PHASE 8 — Festival & Wedding Modules

- [x] **8.1 — Implement FestivalDateEngine**
  ```
  Create lib/features/festival/domain/festival_date_engine.dart. Implement class FestivalDateEngine with:

  computeHinduFestival({int year, int lunarMonth, int tithi, bool krishnaPaksha}) → DateTime: use the Meeus astronomical algorithm for lunar day calculation. Approximate approach: compute Julian Day of New Moon for the given year/month, then add tithi days, adjust for krishna/shukla paksha.

  computeIslamicFestival({int year, int hijriMonth, int hijriDay}) → DateTime: use the Umm al-Qura calendar algorithm to convert Hijri to Gregorian.

  computeGregorianFixed(int year, int month, int day) → DateTime: DateTime(year, month, day).

  computeEaster(int year) → DateTime: Anonymous Gregorian computus algorithm.

  computeSolarIngress(int year, double targetLongitudeDeg) → DateTime: simplified VSOP87-lite approximation for Makar Sankranti (Sun entering Capricorn ~Jan 14-15).

  computeAllFestivals(int year) → List<FestivalDateEntry>: calls the appropriate compute method for all 32 festivals in the spec database. Returns entries for [year-1, year, year+1, year+2].

  Fallback: if any computation throws, fall back to a bundled JSON asset 'assets/festival_dates_fallback.json' covering 2024–2030.
  ```

- [ ] **8.2 — Implement festival diet config system**
  ```
  Create lib/features/festival/domain/festival_diet_plan.dart. Implement:

  enum FestivalDietType { nirjalaFast, phalaharFast, sattvicFast, jainFast, rozaFast, partialFast, feastMode, moderateIndulgence, communityMeal, noRestriction }

  class FestivalDietConfig: festivalId, type, allowedFoodIds (nullable List<String>), forbiddenFoodIds (nullable List<String>), sehriCutoffTime (nullable), iftarTime (nullable — computed from GPS + sunset), calorieBudgetMultiplier, suppressWorkoutIntensity, fastBreakSuggestion (nullable), insightCardMessage.

  Create festivalDietConfigs constant Map<String, FestivalDietConfig> with entries for all 32 festivals. Key highlights:
  - navratri: type=sattvicFast, calorieBudgetMultiplier=0.80, allowedFoods=[sabudana, kuttu, singhara, rajgira, fruits, milk, paneer, sendha_namak], forbiddenFoods=[wheat, rice, pulses, onion, garlic]
  - karva_chauth: type=nirjalaFast, calorieBudgetMultiplier=0.5, fastBreakSuggestion="Dates + warm water + sherbet"
  - ramadan: type=rozaFast, calorieBudgetMultiplier=0.85 (TDEE split across sehri/iftar)
  - diwali: type=feastMode, calorieBudgetMultiplier=1.15
  - paryushana: type=jainFast, forbiddenFoods=[potato, carrot, beet, onion, garlic]
  ```

- [x] **8.3 — Implement FestivalCalendarScreen and FestivalDietPlanScreen**
  ```
  Create lib/features/festival/presentation/festival_calendar_screen.dart per spec Section 7.14.
  Layout:
  1. Active Festival Banner (FestivalCountdownBanner widget) if a festival is currently active — reads from activeFestivalProvider which queries festivalCalendar Drift table for today's date.
  2. Region filter chips row: All / Hindu / Muslim / Sikh / Christian / Jain / Buddhist / National.
  3. Vertical list of FestivalCard widgets for upcoming festivals. Each card: emoji icon, bilingual name, date range, fasting type pill, region pill, Set Reminder + View Diet Plan buttons.
  4. TableCalendar mini month view with festival dots.
  5. "Plan a Wedding 💍" amber CTA card at bottom linking to /wedding-planner/setup.

  Create FestivalDietPlanScreen for route /festival-calendar/:festivalKey/diet. Reads festivalKey, loads FestivalDietConfig. Pattern B scaffold with festival-specific hero color. Body: fasting overview card, allowed/forbidden food grids, day-by-day meal plan tabs, Quick Log CTA. Ramadan additions: Sehri + Iftar countdown clocks. Karva Chauth additions: moonrise countdown (compute from user GPS lat/lng + astronomical sunset formula).
  ```

- [ ] **8.4 — Implement Wedding Planner setup flow (6 steps)**
  ```
  Create lib/features/wedding_planner/presentation/wedding_setup_screen.dart. Implement a multi-step flow (6 steps) with a progress pill indicator. Use a PageView or step-by-step state machine via StateNotifierProvider<WeddingSetupNotifier>.

  Step 1: WeddingRoleChip selection (Bride/Groom/Guest/Relative) — large illustrated cards 120×140px, single-select, deep orange border when selected.
  Step 1b (if Relative): relation type pill chips (6 options).
  Step 2: DateRangePicker for weddingStartDate → weddingEndDate. Show computed duration. Validate: end >= start, max 14 days. Show amber notice if dates overlap with a festival (check festivalCalendar Drift table).
  Step 3: Multi-select checkbox grid for 6 wedding events (Haldi, Mehendi, Sangeet, Baraat, Vivah, Reception) — each with emoji, English + Hindi label.
  Step 4: Prep weeks selection chips (1w / 2w / 4w / 8w / Already wedding week).
  Step 5: Primary goal chips (role-aware: Bride/Groom vs Guest/Relative options).
  Step 6: Summary card with all selections + "Start My Wedding Plan" orange CTA.

  On completion: saves to WeddingEvents Drift table + updates user record in Appwrite via usersRepository.updateWeddingData().
  ```

- [ ] **8.5 — Implement Wedding Planner home + event day screens**
  ```
  Create lib/features/wedding_planner/presentation/wedding_planner_home_screen.dart. Pattern B scaffold with gold gradient (#D4A017 → #B8860B). Hero: role badge, "Wedding in X days", next event name.

  Body:
  1. Phase Progress card: Pre-Wedding → Wedding Week → Post-Wedding with progress bar.
  2. Today's Plan card: diet phase, today's suggested meals, workout. "Log Today's Meals" + "Start Workout" CTAs.
  3. Event countdown strip: horizontal scrollable chips for each upcoming wedding event.
  4. WeddingTipInsightCard (amber InsightCard variant) with role-specific bloat/energy tips.
  5. Pre-Wedding Fitness Plan card showing current week's workout schedule.
  6. Wedding + Festival Overlap handler: if today overlaps a festival, merge contexts in the insight card message per the priority rules in spec 11.12.7.

  Create WeddingEventDayScreen for route /wedding-planner/event/:eventKey. Reads the event config for that role. Shows: event overview card, pre-event meal plan, during-event tips, post-event recovery meal, Quick Log CTA, calorie budget card with dance/activity burn estimate.

  Create WeddingRecoveryScreen for route /wedding-planner/recovery. Shows 3-day detox plan, 5-day calorie return chart, yoga-only workout plan, social share CTA.
  ```

---

## PHASE 9 — Remaining Feature Modules

- [ ] **9.1 — Karma system + leaderboards**
  ```
  Create lib/features/karma/data/karma_repository.dart. Implement:
  - awardXP(String userId, int amount, String action, String description) async: writes to karma_transactions Drift table + enqueues sync. Updates user's karma_total and karma_level in Drift.
  - computeLevel(int totalXP) → int: 50 tiers, exponential XP thresholds (define the curve: level 1=0 XP, level 50=100,000 XP with exponential spacing).
  - getLevelTitle(int level) → String: returns title from the 50-tier list (Seedling → Warrior → Yogi → Guru → Legend and 46 intermediate titles).
  - applyStreakMultiplier(int baseXP, int streakDays) → int: ×1.5 if streak >= 7 days, ×2.0 if streak >= 30 days.
  - recoverStreak(String userId, String habitId) async → bool: checks if streak_recovery_used is false for this month for this habit, deducts 50 XP, sets streak_recovery_used = true.

  KarmaHubScreen per spec Section 7.2 with leaderboard tabs (Friends/City/National/Seasonal), ChallengeCarouselCard scroll, DailyRituals checklist, Karma Store section.
  ```

- [ ] **9.2 — Period tracker (fully encrypted)**
  ```
  Create lib/features/period/data/period_drift_service.dart. ALL reads and writes must go through EncryptionService.encryptField/decryptField with dataClass 'period'. The raw Drift columns store only ciphertext.

  Implement:
  - logCycle(PeriodLogModel log) async: encrypts cycle_start, cycle_end, symptoms, notes before Drift insert. Sync to Appwrite is OPT-IN only — default is local-only (no sync queue entry by default).
  - predictNextCycle() → Future<DateTime?>: reads last 3 cycles (decrypts), computes average length, returns predicted start.
  - getCurrentPhase(DateTime cycleStart, int avgCycleLength) → CyclePhase {menstrual, follicular, ovulatory, luteal}: based on days since cycle start.

  PeriodTrackerScreen: EncryptionBadge prominent at top. Cycle calendar view. Current phase indicator card. Symptom logging. Workout suggestions adapted to phase. PCOD/PCOS mode toggle (if enabled in chronic conditions). Privacy disclaimer: "This data is AES-256 encrypted and never shared."
  ```

- [ ] **9.3 — Fasting tracker**
  ```
  Create lib/features/fasting_tracker/domain/fasting_stage.dart:
  enum FastingStage { fed, earlyFast, fatBurning, ketosis, deepFast }
  FastingStage getStage(Duration elapsed): fed < 4h, earlyFast < 8h, fatBurning < 12h, ketosis < 16h, deepFast >= 16h.

  Create FastingTrackerScreen: large circular countdown ring (CustomPaint). Current stage label + description card. Hydration reminder notification (every 2h while fasting). Supported protocols: 16:8, 18:6, 5:2, OMAD, Ramadan, Custom. Ramadan mode uses Sehri/Iftar times as boundaries. "Break Fast" button shows a confirmation + recommended break-fast foods. Streak tracking. +15 XP on completion.
  ```

- [ ] **9.4 — Lab reports home + ABHA screen**
  ```
  Create LabReportsHomeScreen per spec Section 7.7. List of imported lab reports from Drift. "Scan New Report" orange CTA. "Import from ABHA" card (if ABHA linked). Privacy note. Each report row shows lab name, date, imported metric count, View link.

  Create ABHAScreen per spec Section 7.7. ABHALinkBadge large variant. If not linked: 14-digit ABHA ID input + "Verify via OTP" button. If linked: masked ID, last sync time, list of linked records with Import buttons. Consent note. EncryptionBadge.

  Create lib/features/abha/data/abha_repository.dart: ABHA linking flow calls the consolidated Appwrite Function (action: abha-token-exchange) server-side with the ABHA ID + OTP. The returned OAuth token is stored ONLY in flutter_secure_storage, never in Drift or plaintext. Linked metadata (abha_id, abha_address, linked_at) stored in encrypted AbhaLinks Drift table.
  ```

- [ ] **9.5 — Wearable integration + health connect**
  ```
  Create lib/features/wearables/data/health_connect_service.dart: uses the health package. Request permissions for: steps, sleep, heartRate, bloodOxygen, bloodPressure. Implement:
  - syncSteps(DateTime from, DateTime to) → Future<int>: reads step data, writes to Drift step_logs with source='health_connect'.
  - syncSleep(DateTime from, DateTime to) → Future<List<SleepData>>: reads sleep sessions, writes to sleep_logs.
  - syncHeartRate(DateTime from) → Future<List<HRData>>: stores in workout_logs or a dedicated hr_logs table.

  Create WearableConnectionsScreen: per spec Section 7.11. Connected device cards for Fitbit, Garmin, Health Connect, HealthKit. Each shows device name, last sync time, sync status pill, Disconnect button. Fitbit and Garmin OAuth flow via the consolidated Appwrite Function (actions: fitbit-token-exchange, garmin-token-exchange). Stored tokens in flutter_secure_storage only.
  ```

- [ ] **9.6 — Doctor appointments + shareable health reports**
  ```
  Create DoctorAppointmentsScreen: list of upcoming appointments (from DoctorAppointments Drift table, all fields decrypted via EncryptionService dataClass:'appointments'). Add Appointment bottom sheet: doctor name, speciality, datetime picker, notes. 24h reminder via flutter_local_notifications. EncryptionBadge visible.

  Create HealthReportsScreen per spec Section 7.11: auto-generated weekly/monthly report cards. Each shows summary stats. "Share with Doctor" button flow: calls the consolidated Appwrite Function (action: shareable-health-report) with PDF bytes → receives share_url + expires_at → shows HealthShareCard widget with WhatsApp share CTA and 7-day expiry countdown. "Delete Link" button calls Appwrite storage.deleteFile().
  ```

- [ ] **9.7 — Emergency health card**
  ```
  Create EmergencyCardScreen per spec Section 7.12. This screen must be accessible WITHOUT biometric re-auth (override biometric lock for emergencies). Reads from EmergencyCard Drift table (LOCAL ONLY — never synced to Appwrite). Fields: blood group (large coloured chip), allergies (red pills), chronic conditions (amber pills), current medications (auto-pulled from medications Drift table), emergency contact name + phone (Call CTA), doctor name + phone (Call CTA), insurance policy number. Export PDF button and Show QR button. QR encodes all fields as a JSON string for quick medical staff scan.
  ```

- [ ] **9.8 — Home screen widgets**
  ```
  Create lib/features/home_widgets/data/home_widget_service.dart: uses the home_widget package. Implements:
  - updateActivityRings(): reads today's steps/calories/water/activeMin from Drift, writes to shared prefs (Android) / App Group (iOS) for widget consumption.
  - updateWaterCounter(): reads today's water count from Drift.
  - updateFestivalCountdown(): reads next festival from Drift festivalCalendar table.

  Register a WorkManager periodic task to call updateActivityRings() every 15 minutes.

  Create HomeWidgetConfigScreen per spec Section 7.15. Shows HomeWidgetPreview for each widget. Add to Home Screen buttons. Festival/Wedding Countdown widget (2×2) shows next active event. Instructions card for Android and iOS setup.

  Implement Android widget files in android/app/src/main/res/layout/ and configure in AndroidManifest. Implement iOS WidgetKit extension via the home_widget WidgetKit bridge.
  ```

- [ ] **9.9 — Ayurveda module**
  ```
  Create lib/features/ayurveda/domain/dosha_calculator.dart: takes quiz answers (12 questions, each scored 0-2 for vata/pitta/kapha) → returns {vataScore, pittaScore, kaphaScore} as percentages.

  Create AyurvedaHubScreen per spec Section 7.2 (Me tab flow). Screens: AyurvedaHome, DoshaProfile (with DoshaDonutChart), DailyRituals checklist (Dinacharya items based on dosha type), SeasonalPlan (Ritucharya — 6 Indian seasons with food + activity recommendations), HerbalRemedies library (ashwagandha, triphala, brahmi, turmeric — each with evidence-based notes, NOT medical advice disclaimer).

  Daily rituals + seasonal plans are static data bundled in the app as Dart constants — zero server calls.
  ```

- [ ] **9.10 — Social feed + community + referral**
  ```
  Create SocialFeedScreen per spec Section 7.10. Posts from AppwriteClient.databases with realtime updates via AppwriteClient.realtime subscription. Low Data Mode: text-only cards, no media. Like/comment interactions. +5 XP social karma animation on receiving a like (amber float animation).

  Create CommunityGroupsScreen: My Groups horizontal scroll, Discover Groups list with type filters. Team vs. Team challenge banner.

  Create ReferralScreen: user's unique referral_code displayed prominently. WhatsApp share CTA (primary), Copy Link (secondary). Referral leaderboard top 10. Reward explanation: +500 XP referrer, +100 XP new user. On app startup: if launched with a referral deep link, auto-populate referred_by field during registration.
  ```

---

## PHASE 10 — WhatsApp Bot + Push Notifications

- [ ] **10.1 — Integrate WhatsApp bot into Consolidated Function**
  ```
  In `appwrite-functions/core-engine/src/handlers/whatsapp.js`, implement the WhatsApp Cloud API webhook handler logic:
  1. Verify webhook challenge (GET request from Meta).
  2. On POST: extract sender phone number, message text from the WhatsApp Cloud API payload.
  3. Look up user by phone number in Appwrite users collection.
  4. Parse intent (Food log, Mood log, Stats) and update database.
  This handler is triggered by the main function router when the request originates from WhatsApp/Meta.
  ```

- [ ] **10.2 — FCM push notification setup**
  ```
  In lib/core/network/: configure firebase_messaging for FCM token retrieval only (no Firebase Auth, no Firestore — just FCM). On app start: get FCM token → save to Appwrite users document under field 'fcm_token'.

  Create lib/core/notifications/notification_service.dart using flutter_local_notifications. Implement:
  - scheduleMediacationReminder(Medication med) → schedules a daily notification at med.reminderTime
  - scheduleBPReminder(TimeOfDay time) → daily reminder
  - scheduleMorningBriefing(TimeOfDay time) → daily morning briefing notification with today's calorie goal
  - scheduleHabitReminder(Habit habit) → per-habit reminder
  - showInactivityNudge() → one-off notification for 60+ min inactivity
  - cancelAll() → cancels all scheduled notifications

  In `appwrite-functions/core-engine/src/handlers/fcm.js`: implement logic triggered by Appwrite database events (consolidated into the core engine) that sends FCM push via the Firebase Admin SDK. Use the user's fcm_token from the users collection.
  ```

---

## PHASE 11 — Settings, Onboarding & Profile

- [ ] **11.1 — Implement all 6 onboarding screens**
  ```
  Create lib/features/auth/presentation/onboarding/ with OnboardingScreen that manages step routing. Implement all 6 steps as separate widgets: OnboardingStep1 through OnboardingStep6. Progress pill indicator at top (6 pills, active = orange filled, inactive = grey outline). "Next →" orange primary button. "Back" text link on steps 2–6.

  Step 4 (Dosha Quiz): 12 questions with illustrated multiple-choice answers. Each answer scores vata/pitta/kapha. On completion, show result with DoshaDonutChart preview. Save to user profile.
  Step 5 (Language): LazyGridView of 22 language options showing language name in its own script. Single-select.
  Step 6 (ABHA + Wearable): full spec from Section 7.1. "Skip" links for both ABHA and wearable. On ABHA link: calls ABHARepository.linkAccount().

  On onboarding completion: awards +50 XP, updates user.onboarding_completed = true, navigates to /home/dashboard.
  ```

- [ ] **11.2 — Implement Settings screen**
  ```
  Create lib/features/settings/presentation/settings_screen.dart per spec Section 7.13. Use a ListView of ListTile sections with dividers. Implement all sections:

  Account: Edit Profile (opens profile edit bottom sheet), Subscription status badge (from subscriptionProvider), Change Password, ABHA account row.
  Preferences: Language picker (22 options), Theme (Light/Dark/Auto via themeProvider StateProvider), Font size slider (affects textScaleFactor), Dyslexia-friendly font toggle (switches body text to OpenDyslexic — bundle OpenDyslexic as a font asset).
  Notifications: Toggle rows for each notification type, each backed by a Drift preference record.
  Privacy & Security: Biometric lock toggle (uses local_auth), Data Export JSON button (calls exportAllUserData() → generates JSON of all Drift tables for this user → share via Share.share()), Account Deletion (red text → confirmation dialog → calls account.delete() → clears all Drift data → navigates to /login).
  Data & Sync: Low Data Mode toggle, Sync interval selector, Wearable connections link, Pending sync items count (DLQ badge from syncDeadLetterCountProvider), "View failed sync items" link.
  Home Widgets: navigates to /home-widgets.
  ```

- [ ] **11.3 — Implement Profile screen + Subscription screen**
  ```
  Create ProfileScreen per spec Section 7.13. Pattern B (dark hero). Hero: avatar (tappable → image_picker for photo, stored locally only), name h1OnDark, email captionOnDark, KarmaLevelCard compact. Body: DoshaDonutChart mini card, editable personal info rows, ABHALinkBadge compact, Achievements grid (100+ achievements from a static list — earned=coloured, unearned=grey), Referral card.

  Create SubscriptionPlansScreen per spec Section 7.13. Amber gradient hero. Four plan cards (Monthly ₹99, Quarterly ₹249, Yearly ₹899, Family ₹1,499). "Most Popular" badge on Quarterly. "Best Value" badge on Yearly. Each plan card: "Start [Plan]" orange button → opens razorpay_flutter checkout. "Pay via UPI" outlined button → constructs UPI deep link `upi://pay?pa=fitkarma@razorpay&pn=FitKarma&am={price}&cu=INR` → launches via url_launcher. Feature comparison table. Restore purchase TextButton.
  ```

---

## PHASE 12 — Localization (22 Indian Languages)

- [ ] **12.1 — Set up l10n infrastructure**
  ```
  In pubspec.yaml, add flutter_localizations to dependencies and set generate: true. Configure flutter.l10n section: arb-dir: lib/l10n, template-arb-file: app_en.arb, output-localization-file: app_localizations.dart.

  Create lib/l10n/app_en.arb with all required string keys (minimum 50 keys covering: app name, bottom nav labels, screen titles, common actions, all section headers, error messages, onboarding text, greeting, insight card template strings, festival names for all 32 festivals, wedding event names).

  Create stub .arb files for all 22 languages: app_hi.arb, app_bn.arb, app_ta.arb, app_te.arb, app_mr.arb, app_gu.arb, app_kn.arb, app_ml.arb, app_pa.arb, app_or.arb, app_as.arb, app_ur.arb, app_ne.arb, app_sa.arb, app_kok.arb, app_mai.arb, app_mni.arb, app_brx.arb, app_doi.arb, app_ks.arb, app_sat.arb, app_sd.arb.

  For Hindi (app_hi.arb), provide full translations for all keys. For other languages, provide at minimum: app name, bottom nav labels, common CTAs, and all 32 festival names in their native scripts.

  Run `flutter gen-l10n` to generate AppLocalizations.
  ```

---

## PHASE 13 — Testing

- [ ] **13.1 — Unit tests: core domain logic**
  ```
  Create test/unit/nutrition_calculator_test.dart: test calculateBMR and calculateTDEE with known inputs for both genders and all 5 activity levels. Verify TDEE formula outputs. Test micronutrient RDA computations.

  Create test/unit/bp_classifier_test.dart: test classify() for ALL boundary conditions — exactly at each threshold (normal/elevated boundary at 120mmHg systolic, stage1 at 130, stage2 at 140, crisis at 180 and 120 diastolic). Test both systolic-dominant and diastolic-dominant classifications.

  Create test/unit/dosha_calculator_test.dart: test dosha score computation with known quiz answers producing a pure-vata profile, pure-pitta, pure-kapha, and mixed profiles.

  Create test/unit/fasting_stage_test.dart: test getStage() for elapsed durations of exactly 0h, 3h59m, 4h, 7h59m, 8h, 11h59m, 12h, 15h59m, 16h, 20h.

  Create test/unit/karma_test.dart: test awardXP streak multipliers (no streak, 7-day streak ×1.5, 30-day streak ×2.0), level computation from total XP, level title lookup.

  Create test/unit/festival_diet_test.dart: test FestivalDietConfig lookup for navratri (sattvic fast), ramadan (roza fast), diwali (feast mode). Verify calorieBudgetMultiplier values.
  ```

- [ ] **13.2 — Unit tests: encryption + sync**
  ```
  Create test/unit/encryption_test.dart:
  - AES-256-GCM round-trip: encrypt('test plaintext', key) → decrypt(result, key) == 'test plaintext' for 100 random keys.
  - Test that changing any byte in the ciphertext causes decryption to throw.
  - HKDF key isolation: getKeyFor('bp_glucose') != getKeyFor('period') != getKeyFor('journal') — all three must be different for the same master key.
  - Determinism: getKeyFor('journal') called twice returns the same key.

  Create test/unit/sync_queue_test.dart:
  - generateIdempotencyKey produces unique values for different inputs.
  - generateIdempotencyKey is NOT fully deterministic (includes timestamp) — verify format is a 64-char hex string.
  - SyncQueueProcessor moves item to dead_letter after 5 failures (mock Appwrite to always throw).
  - Idempotency: processing the same SyncQueueEntry twice does not create two Appwrite documents (mock to verify createDocument is called with the same idempotency_key).

  Create test/unit/lab_report_parser_test.dart:
  - Test LabReportParser.parse() against 3 sample OCR text strings:
    1. A CBC report: expects hemoglobin, WBC extracted.
    2. A lipid panel: expects cholesterol, triglycerides, HDL extracted.
    3. A diabetes panel: expects fasting glucose, HbA1c extracted.
  - Verify extracted values are within expected ranges (type and magnitude).
  ```

- [ ] **13.3 — Widget tests**
  ```
  Create test/widget/activity_rings_test.dart: render ActivityRingsWidget with progress=[0.0, 0.5, 1.0, 1.2] (overflow case). Verify it renders without overflow errors and paints four arcs using CustomPaint.

  Create test/widget/async_value_widget_test.dart: render AsyncValueWidget with AsyncValue.loading() → verify ShimmerLoader visible. With AsyncValue.error(e, s) → verify ErrorRetryWidget with Retry button visible. With AsyncValue.data(42) → verify data builder called.

  Create test/widget/insight_card_test.dart: render InsightCard, tap 👍 → verify onThumbsUp callback called. Tap dismiss → verify onDismiss called.

  Create test/widget/bp_trend_chart_test.dart: render BPTrendChart with mock data including readings in all 5 AHA classifications. Verify chart renders without error and the 5 reference bands are present.

  Create test/widget/micronutrient_bar_test.dart: test at 0%, 40% (red threshold), 79% (amber threshold), 100% (green), 120% (over-goal). Verify correct colors rendered.
  ```

- [ ] **13.4 — Integration tests**
  ```
  Create integration_test/food_log_flow_test.dart: full food log integration test using a real in-memory Drift database (use DriftDatabase with NativeDatabase.memory()). Steps: search for food → select → confirm portion → verify FoodLog written to Drift → verify SyncQueueEntry created with correct idempotency_key → verify log_method matches input method.

  Create integration_test/offline_sync_test.dart: log food while mocking Appwrite to be offline (mock AppwriteClient.databases to throw NetworkException) → verify data in Drift → mock connectivity restore → flush SyncQueueProcessor → mock Appwrite to succeed → verify SyncQueue is empty and dead_letter is empty.

  Create integration_test/dlq_test.dart: mock Appwrite to always fail → process SyncQueueProcessor 6 times → verify item moved to SyncDeadLetter → verify SyncQueue is empty.

  Create integration_test/period_encryption_test.dart: insert a PeriodLog via PeriodDriftService → read raw Drift bytes via customSelect → verify raw bytes are NOT the plaintext (cannot decode without the key) → read via PeriodDriftService → verify decrypted values match originals.

  Create integration_test/hkdf_isolation_test.dart: derive journal key and bp_glucose key from same master key → verify they differ → simulate "compromise" of journal key (use journal key to try decrypting bp data) → verify decryption throws AppException.
  ```

---

## PHASE 14 — Performance & App Size

- [ ] **14.1 — Implement deferred loading for heavy modules**
  ```
  Configure deferred loading (dart:mirrors-free deferred imports) for these heavy feature modules to reduce initial bundle size:

  In lib/app.dart or the relevant route files, use `deferred as` imports for:
  - Wearables module (flutter_map, flutter_map_tile_caching)
  - GPS workout screen (geolocator, flutter_map)
  - Community feed (social media-heavy)
  - Mental health module
  - Health reports (pdf package)
  - ABHA module

  Wrap each deferred screen in a FutureBuilder that calls the loadLibrary() future before building the route. Show ShimmerLoader during deferred load. Test that the initial cold start is not blocked by these modules.
  ```

- [ ] **14.2 — Seed Indian food database (10,000+ items)**
  ```
  Create lib/core/utils/food_database_seeder.dart. This class runs ONCE on first install (tracked by a 'db_seeded_v1' flag in flutter_secure_storage).

  Seed strategy:
  1. Bundle a compressed JSON asset (assets/food_db_seed.json.gz) containing 10,000+ Indian food items with all fields from the food_items schema. This file should be prepared separately as a JSON covering items from all regions with Indian portion sizes (katori, piece, glass, ladle).
  2. On first install: gunzip the asset, parse JSON, insert all items via AppDatabase.foodItems.insertAll() in batches of 500 to avoid memory spikes.
  3. After insertion: run `INSERT INTO food_items_fts(food_items_fts) VALUES ('rebuild')` to populate the FTS5 index.
  4. Set 'db_seeded_v1' = true in secure storage.

  Call FoodDatabaseSeeder.seedIfNeeded() from DriftService.init() before returning.
  ```

- [ ] **14.3 — Performance audit & optimization pass**
  ```
  Run the following performance optimizations across all screens:

  1. Add `const` constructors to every StatelessWidget and its children where possible. Run `dart fix --apply` which auto-applies some const fixes.
  2. Wrap all animated widgets (ActivityRingsWidget, fasting countdown ring, karma XP animation) in RepaintBoundary.
  3. Replace every `Column(children: items.map((i) => Widget(i)).toList())` pattern in scrollable areas with ListView.builder or SliverList.
  4. Move AES encryption/decryption off the main isolate: wrap EncryptionService calls in compute() for bulk operations (e.g., decrypting a list of 90 BP readings for the chart).
  5. Move PDF generation (HealthReportsScreen) into a Dart isolate using Isolate.spawn or compute().
  6. Move lab OCR processing (LabReportScanScreen) into a Dart isolate.
  7. Profile with `flutter run --profile` and flutter DevTools Timeline. Identify and fix any jank in the dashboard scroll and food search.
  8. Compress all bundled image assets to WebP format, max 1080px.
  ```

---

## PHASE 15 — CI/CD Pipeline

- [ ] **15.1 — Create GitHub Actions CI workflow**
  ```
  Create .github/workflows/ci.yml with the full workflow from spec Section 24:

  Trigger: push to main/develop, PR to main.

  Jobs:
  1. test: flutter pub get → dart fix --apply → flutter analyze --fatal-infos → flutter test --coverage → upload coverage to Codecov.
  2. check_app_size (needs: test): flutter build apk --dart-define-from-file=.env.staging --split-per-abi. Check arm64-v8a APK size: fail CI if > 50 MB.
  3. build_android (needs: test + check_app_size, only on main): flutter build appbundle --dart-define-from-file=.env.prod. Upload AAB as artifact.
  4. build_ios (needs: test + check_app_size, only on main, macos-latest): Import iOS distribution cert from secret IOS_DIST_CERT_P12, download provisioning profile for com.fitkarma.app. flutter build ipa --dart-define-from-file=.env.prod.
  5. deploy_staging (needs: test, only on develop): npm install -g appwrite-cli → appwrite login → appwrite deploy function --all for staging project.

  Add all required GitHub Secrets as documented in spec Section 24.
  ```

- [ ] **15.2 — Create backup cron and disaster recovery script**
  ```
  Create scripts/backup.sh:
  #!/bin/bash
  # Daily backup — run at 02:00 IST (20:30 UTC previous day)
  # Schedule via cron: 30 20 * * * /path/to/backup.sh
  DATE=$(date +%Y%m%d)
  appwrite databases export \
    --project-id $APPWRITE_PROD_PROJECT_ID \
    --databaseId $APPWRITE_DATABASE_ID \
    --output /backups/fitkarma-$DATE.json
  # Compress
  gzip /backups/fitkarma-$DATE.json
  # Upload to Backblaze B2 (requires rclone configured with b2 remote)
  rclone copy /backups/fitkarma-$DATE.json.gz b2:fitkarma-backups/daily/
  # Delete local backup older than 7 days
  find /backups/ -name "fitkarma-*.json.gz" -mtime +7 -delete
  echo "Backup completed: fitkarma-$DATE.json.gz"

  Create scripts/restore.sh for disaster recovery drill: downloads latest backup from B2, imports to staging Appwrite project for verification.

  Document retention policy in README: 30 daily backups, 12 monthly backups on Backblaze B2.
  ```

---

## PHASE 16 — Final Polish & Launch Checklist

- [ ] **16.1 — Accessibility audit**
  ```
  Run accessibility audit on all 45+ screens:
  1. Enable TalkBack (Android) / VoiceOver (iOS). Navigate every screen. Add Semantics labels to any IconButton, Image, or CustomPaint that lacks them.
  2. Enable the largest font size in system settings. Verify no text is clipped or overflows on any screen. Fix any overflow with Flexible/Expanded wrappers.
  3. Enable high contrast mode in Settings → Preferences → Theme. Verify all text meets WCAG AA (4.5:1 contrast ratio). Fix any failing colors by using the defined high-contrast palette (black/white + orange accents, no gradients).
  4. Enable Dyslexia-friendly font toggle. Verify OpenDyslexic loads correctly for body text. Section headers and nav labels remain system font.
  5. Verify all tap targets are >= 44×44px. Add padding to any LabValueRow edit icons or small metric chips that fall below this.
  ```

- [ ] **16.2 — Dark mode full audit**
  ```
  Toggle system to dark mode. Navigate ALL 45+ screens. For each screen verify:
  - Scaffold background is #121218 (not pure black, not white)
  - All cards are #1E1E2C with 1px divider border (no box shadow)
  - Hero sections use #1A1035 → #2C2A6B gradient
  - Primary CTAs use #FF7043 (slightly lighter orange)
  - Accent/karma coins use #FFD54F
  - Text primary is #F0EEF8, secondary #9D9BBC
  - ShimmerLoader uses dark divider (#2C2C3E) as base
  - ActivityRings track color uses dark divider, not invisible
  - InsightCard uses #2C2200 background (not transparent)
  - Bottom nav background is #1E1E2C
  Fix any screen that still shows light-mode tokens in dark mode.
  ```

- [ ] **16.3 — Low Data Mode audit**
  ```
  Enable Low Data Mode in Settings. Navigate through all screens. Verify:
  - All CachedNetworkImage widgets replaced with emoji/color placeholder boxes
  - Social feed shows text-only post cards (no image loading)
  - Workout grid shows text cards instead of video thumbnails
  - FoodItemCard shows food emoji instead of food photo
  - SyncStatusBanner shows the teal "Low Data Mode" banner at all times
  - No network requests are made for media content
  - Sync interval has changed to 6 hours (verify in WorkManager task config)
  - Lab Report OCR still works (on-device ML Kit, no network)
  - YouTube player is disabled (shows "Low Data Mode — videos disabled" placeholder)
  ```

- [ ] **16.4 — Security final checklist**
  ```
  Run through this security checklist and fix any gaps:
  [ ] .env* files are in .gitignore and NOT committed to git (run `git log --all -- .env` to verify)
  [ ] RAZORPAY_KEY_SECRET is ONLY in Appwrite Function env vars — never in Flutter code or .env files committed to git
  [ ] FITBIT_CLIENT_SECRET, GARMIN_CONSUMER_SECRET, WHATSAPP_ACCESS_TOKEN, ABDM_CLIENT_SECRET — same as above
  [ ] flutter_secure_storage is used for ALL tokens, session JWTs, and the master encryption key
  [ ] No sensitive values are logged via print() or debugPrint() — search codebase for any print of tokens/keys/health data
  [ ] flutter_jailbreak_detection is initialized at app start — shows a warning dialog on rooted/jailbroken devices (does NOT block the app)
  [ ] AppwriteClient has setSelfSigned(status: false) — certificate validation is enforced
  [ ] EmergencyCard Drift table has no SyncQueue entries ever created — verify in code that emergency_card data never appears in sync_queue
  [ ] Period data default sync behavior is OPT-IN only — verify that PeriodDriftService never creates a SyncQueueEntry by default
  [ ] Progress photos (body metrics) are stored locally in app documents directory — verify no upload code path exists
  [ ] Voice notes (mood tracker) auto-delete after 30 days — implement a cleanup job in WorkManager
  [ ] Prescription photos (medications) have no upload path — verify
  [ ] All Appwrite collection/bucket permissions set to 'any' for public/initial provisioning, with access restricted via application-layer checks — verify that repo methods enforce ownership.
  ```

- [ ] **16.5 — App Store & Play Store preparation**
  ```
  Android:
  1. In android/app/build.gradle: set applicationId = 'com.fitkarma.app', versionCode from CI env, versionName from pubspec.
  2. Create a release keystore: `keytool -genkey -v -keystore fitkarma-release.jks -keyAlias fitkarma -keyalg RSA -keysize 2048 -validity 10000`. Store in CI secret IOS_DIST_CERT_P12 equivalent for Android.
  3. Configure signing in build.gradle using env vars (never hardcode the keystore password).
  4. Enable ProGuard/R8: add proguard-rules.pro with rules to keep Drift, Appwrite SDK, and Riverpod reflection targets.
  5. Build: `flutter build appbundle --release`.

  iOS:
  1. In ios/Runner/Info.plist: add NSHealthShareUsageDescription, NSHealthUpdateUsageDescription, NSLocationWhenInUseUsageDescription, NSMicrophoneUsageDescription, NSCameraUsageDescription, NSSpeechRecognitionUsageDescription.
  2. Enable HealthKit capability in the Xcode project (required for HealthKit integration).
  3. Create App Store Connect record with bundle ID com.fitkarma.app.
  4. Build: `flutter build ipa --release`.

  Metadata:
  5. Write App Store description (4000 chars), screenshots for 6.7" and 6.5" iPhones, iPad, Android phones and tablets.
  6. Privacy policy URL: must document all data collection (health data, location, camera, microphone) and confirm no ad tracking.
  ```

---

## Quick Reference — Key Architecture Decisions

| Decision | Choice | Reason |
|---|---|---|
| All Appwrite setup | CLI only | Reproducible, version-controlled infra |
| Local storage | Drift (SQLCipher) | Type-safe queries, FTS5, migrations, encryption |
| Sensitive field encryption | AES-256-GCM + HKDF per class | Independent key compromise isolation |
| HTTP client | dio (not http) | CancelToken support, interceptors, retries |
| State management | Riverpod 2.x only | Never setState() for business logic |
| All local writes | Drift first, then sync queue | Zero loading states for core actions |
| Period/journal sync | Opt-in only | Privacy-first |
| Emergency card | Local only, never synced | Offline accessible, maximum privacy |
| Festival dates | Algorithmically computed | Dynamic, never hardcoded |
| Indian food DB | FTS5, BM25 ranking, < 200ms | Zero network dependency at runtime |

---

*FitKarma Developer TODO v2.0*
*158 tasks across 16 phases*
*Flutter 3.x · Riverpod 2.x · Drift (SQLCipher) · Appwrite CLI*
