class AW {
  // Appwrite Project Configuration (Initialized from Environment Variables)
  static const String endpoint = String.fromEnvironment('APPWRITE_ENDPOINT');
  static const String projectId = String.fromEnvironment('APPWRITE_PROJECT_ID');
  static const String dbId = String.fromEnvironment('APPWRITE_DATABASE_ID');

  // Collection IDs
  static const String users = String.fromEnvironment('COLLECTION_USERS', defaultValue: 'users_v1');
  static const String foodLogs = String.fromEnvironment('COLLECTION_FOOD_LOGS', defaultValue: 'food_logs');
  static const String foodItems = String.fromEnvironment('COLLECTION_FOOD_ITEMS', defaultValue: 'food_items');
  static const String workoutLogs = String.fromEnvironment('COLLECTION_WORKOUT_LOGS', defaultValue: 'workout_logs');
  static const String stepLogs = String.fromEnvironment('COLLECTION_STEP_LOGS', defaultValue: 'step_logs');
  static const String sleepLogs = String.fromEnvironment('COLLECTION_SLEEP_LOGS', defaultValue: 'sleep_logs');
  static const String moodLogs = String.fromEnvironment('COLLECTION_MOOD_LOGS', defaultValue: 'mood_logs');
  static const String periodLogs = String.fromEnvironment('COLLECTION_PERIOD_LOGS', defaultValue: 'period_logs');
  static const String medications = String.fromEnvironment('COLLECTION_MEDICATIONS', defaultValue: 'medications');
  static const String habits = String.fromEnvironment('COLLECTION_HABITS', defaultValue: 'habits');
  static const String bodyMeasurements = String.fromEnvironment('COLLECTION_BODY_MEASUREMENTS', defaultValue: 'body_measurements');
  static const String karmaTx = String.fromEnvironment('COLLECTION_KARMA_TX', defaultValue: 'karma_transactions');
  static const String nutritionGoals = String.fromEnvironment('COLLECTION_NUTRITION_GOALS', defaultValue: 'nutrition_goals');
  static const String posts = String.fromEnvironment('COLLECTION_POSTS', defaultValue: 'posts');
  static const String challenges = String.fromEnvironment('COLLECTION_CHALLENGES', defaultValue: 'challenges');
  static const String subscriptions = String.fromEnvironment('COLLECTION_SUBSCRIPTIONS', defaultValue: 'subscriptions');
  static const String familyGroups = String.fromEnvironment('COLLECTION_FAMILY_GROUPS', defaultValue: 'family_groups');
  static const String workouts = String.fromEnvironment('COLLECTION_WORKOUTS', defaultValue: 'workouts');
  static const String bloodPressureLogs = String.fromEnvironment('COLLECTION_BP_LOGS', defaultValue: 'blood_pressure_logs');
  static const String glucoseLogs = String.fromEnvironment('COLLECTION_GLUCOSE_LOGS', defaultValue: 'glucose_logs');
  static const String spo2Logs = String.fromEnvironment('COLLECTION_SPO2_LOGS', defaultValue: 'spo2_logs');
  static const String doctorAppointments = String.fromEnvironment('COLLECTION_APPOINTMENTS', defaultValue: 'doctor_appointments');
  static const String fastingLogs = String.fromEnvironment('COLLECTION_FASTING_LOGS', defaultValue: 'fasting_logs');
  static const String mealPlans = String.fromEnvironment('COLLECTION_MEAL_PLANS', defaultValue: 'meal_plans');
  static const String recipes = String.fromEnvironment('COLLECTION_RECIPES', defaultValue: 'recipes');
  static const String journalEntries = String.fromEnvironment('COLLECTION_JOURNALS', defaultValue: 'journal_entries');
  static const String personalRecords = String.fromEnvironment('COLLECTION_PRS', defaultValue: 'personal_records');
  static const String communityGroups = String.fromEnvironment('COLLECTION_COMMUNITY_GROUPS', defaultValue: 'community_groups');
  static const String healthReports = String.fromEnvironment('COLLECTION_HEALTH_REPORTS', defaultValue: 'health_reports');
  static const String communityDms = String.fromEnvironment('COLLECTION_COMMUNITY_DMS', defaultValue: 'community_dms');
  static const String labReports = String.fromEnvironment('COLLECTION_LAB_REPORTS', defaultValue: 'lab_reports');
  static const String abhaLinks = String.fromEnvironment('COLLECTION_ABHA', defaultValue: 'abha_links');
  static const String remoteConfig = String.fromEnvironment('COLLECTION_REMOTE_CONFIG', defaultValue: 'remote_config');
  static const String waterLogs = String.fromEnvironment('COLLECTION_WATER_LOGS', defaultValue: 'water_logs');
  static const String syncDeadLetter = String.fromEnvironment('COLLECTION_DEAD_LETTER', defaultValue: 'sync_dead_letter');

  // Storage Buckets
  static const String filesBucket = String.fromEnvironment('BUCKET_FILES', defaultValue: 'fitkarma_files');
}

