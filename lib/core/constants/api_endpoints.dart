/// Appwrite resource IDs — match staging/appwrite.config.json.
/// Use these constants everywhere instead of raw strings.
abstract final class AW {
  AW._();

  // ─── Database ──────────────────────────────────────────────────────────────
  static const String dbFitkarma = 'fitkarma';

  // ─── Core Tables ───────────────────────────────────────────────────────────
  static const String foodLogs = 'food_logs';
  static const String foodItems = 'food_items';
  static const String workoutLogs = 'workout_logs';
  static const String stepLogs = 'step_logs';
  static const String sleepLogs = 'sleep_logs';
  static const String moodLogs = 'mood_logs';
  static const String bloodPressureLogs = 'blood_pressure_logs';
  static const String glucoseLogs = 'glucose_logs';
  static const String spo2Logs = 'spo2_logs';
  static const String periodLogs = 'period_logs';

  // ─── Lifestyle Tables ──────────────────────────────────────────────────────
  static const String habits = 'habits';
  static const String bodyMeasurements = 'body_measurements';
  static const String medications = 'medications';
  static const String fastingLogs = 'fasting_logs';
  static const String mealPlans = 'meal_plans';
  static const String recipes = 'recipes';

  // ─── Mental & Social Tables ────────────────────────────────────────────────
  static const String journalEntries = 'journal_entries';
  static const String doctorAppointments = 'doctor_appointments';
  static const String posts = 'posts';
  static const String communityDms = 'community_dms';
  static const String communityGroups = 'community_groups';

  // ─── India Ecosystem Tables ────────────────────────────────────────────────
  static const String labReports = 'lab_reports';
  static const String abhaLinks = 'abha_links';

  // ─── Platform Tables ───────────────────────────────────────────────────────
  static const String remoteConfig = 'remote_config';
  static const String users = 'users';
  static const String subscriptions = 'subscriptions';
  static const String challenges = 'challenges';
  static const String workouts = 'workouts';
  static const String nutritionGoals = 'nutrition_goals';
  static const String personalRecords = 'personal_records';
  static const String healthReports = 'health_reports';
  static const String familyGroups = 'family_groups';
  static const String karmaTransactions = 'karma_transactions';
  static const String foodItemsFts = 'food_items_fts';

  // ─── Functions ─────────────────────────────────────────────────────────────
  static const String fnCoreServices = 'core-services';
  static const String fnWearableSync = 'wearable-sync';
  static const String fnLabProcessor = 'lab-processor';

  // ─── Storage ───────────────────────────────────────────────────────────────
  static const String bucketAssets = 'assets';

  // ─── Auth Methods ──────────────────────────────────────────────────────────
  static const String authEmailPassword = 'email-password';
  static const String authEmailOtp = 'email-otp';
  static const String authMagicUrl = 'magic-url';
  static const String authPhone = 'phone';
  static const String authAnonymous = 'anonymous';
  static const String authJwt = 'jwt';
}
