/// Appwrite API endpoint constants.
///
/// All collection/database/storage IDs reference the staging project.
/// Production IDs are resolved at runtime via [RemoteConfig] or
/// environment-specific overrides.
class AW {
  AW._();

  // ── Project ───────────────────────────────────────────────────
  static const String projectIdStaging = 'fitkarma-staging';
  static const String projectIdProduction = 'fitkarma-production';
  static const String endpoint = 'https://cloud.appwrite.io/v1';

  // ── Database ──────────────────────────────────────────────────
  static const String databaseId = 'fitkarma_main';

  // ── Collections — Core ────────────────────────────────────────
  static const String colUsers = 'users';
  static const String colProfiles = 'profiles';
  static const String colFoodLogs = 'food_logs';
  static const String colFoodItems = 'food_items';
  static const String colWorkoutLogs = 'workout_logs';
  static const String colStepLogs = 'step_logs';

  // ── Collections — Lifestyle ───────────────────────────────────
  static const String colSleepLogs = 'sleep_logs';
  static const String colMoodLogs = 'mood_logs';
  static const String colHabits = 'habits';
  static const String colHabitCompletions = 'habit_completions';
  static const String colBodyMeasurements = 'body_measurements';
  static const String colMedications = 'medications';
  static const String colFastingLogs = 'fasting_logs';
  static const String colMealPlans = 'meal_plans';
  static const String colRecipes = 'recipes';

  // ── Collections — Health (encrypted) ──────────────────────────
  static const String colBloodPressureLogs = 'blood_pressure_logs';
  static const String colGlucoseLogs = 'glucose_logs';
  static const String colSpo2Logs = 'spo2_logs';
  static const String colPeriodLogs = 'period_logs';
  static const String colJournalEntries = 'journal_entries';
  static const String colDoctorAppointments = 'doctor_appointments';

  // ── Collections — India Ecosystem ─────────────────────────────
  static const String colLabReports = 'lab_reports';
  static const String colAbhaLinks = 'abha_links';

  // ── Collections — Platform ────────────────────────────────────
  static const String colEmergencyCard = 'emergency_card';
  static const String colFestivalCalendar = 'festival_calendar';
  static const String colRemoteConfig = 'remote_config';
  static const String colAppSettings = 'app_settings';

  // ── Collections — Infrastructure ──────────────────────────────
  static const String colKarmaTransactions = 'karma_transactions';
  static const String colNutritionGoals = 'nutrition_goals';
  static const String colPersonalRecords = 'personal_records';
  static const String colChallenges = 'challenges';
  static const String colChallengeParticipants = 'challenge_participants';

  // ── Storage Buckets ───────────────────────────────────────────
  static const String bucketProfilePhotos = 'profile_photos';
  static const String bucketFoodPhotos = 'food_photos';
  static const String bucketLabReports = 'lab_reports';
  static const String bucketJournalAttachments = 'journal_attachments';

  // ── Functions ─────────────────────────────────────────────────
  static const String fnSyncProcessor = 'sync-processor';
  static const String fnKarmaCalculator = 'karma-calculator';
  static const String fnNotificationSender = 'notification-sender';
  static const String fnAbhaVerifier = 'abha-verifier';
  static const String fnFestivalUpdater = 'festival-updater';
  static const String fnNutritionAnalyzer = 'nutrition-analyzer';

  // ── Messaging Topics ──────────────────────────────────────────
  static const String topicDailyReminder = 'daily-reminder';
  static const String topicWorkoutReminder = 'workout-reminder';
  static const String topicMedicationReminder = 'medication-reminder';
  static const String topicChallengeUpdates = 'challenge-updates';
  static const String topicHealthAlerts = 'health-alerts';

  // ── Remote Config Keys ────────────────────────────────────────
  static const String rcFeatureFoodScan = 'feature.food_scan';
  static const String rcFeatureAbhaSync = 'feature.abha_sync';
  static const String rcFeatureSocialFeed = 'feature.social_feed';
  static const String rcFeatureAiCoach = 'feature.ai_coach';
  static const String rcAbFoodScan = 'ab.food_scan_v2';
  static const String rcAbDashboardLayout = 'ab.dashboard_layout';
  static const String rcKillSwitchSync = 'kill_switch.sync';
  static const String rcKillSwitchPayments = 'kill_switch.payments';
}
