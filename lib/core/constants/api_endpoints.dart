class AW {
  // Appwrite Project Configuration (Initialized from Environment Variables)
  static const String endpoint = String.fromEnvironment('APPWRITE_ENDPOINT');
  static const String projectId = String.fromEnvironment('APPWRITE_PROJECT_ID');
  static const String dbId = String.fromEnvironment('APPWRITE_DATABASE_ID');

  // Collection IDs
  static const String users = 'users';
  static const String foodLogs = 'food_logs';
  static const String foodItems = 'food_items';
  static const String workoutLogs = 'workout_logs';
  static const String stepLogs = 'step_logs';
  static const String sleepLogs = 'sleep_logs';
  static const String moodLogs = 'mood_logs';
  static const String periodLogs = 'period_logs';
  static const String medications = 'medications';
  static const String habits = 'habits';
  static const String bodyMeasurements = 'body_measurements';
  static const String karmaTx = 'karma_transactions';
  static const String nutritionGoals = 'nutrition_goals';
  static const String posts = 'posts';
  static const String challenges = 'challenges';
  static const String subscriptions = 'subscriptions';
  static const String familyGroups = 'family_groups';
  static const String workouts = 'workouts';
  static const String bloodPressureLogs = 'blood_pressure_logs';
  static const String glucoseLogs = 'glucose_logs';
  static const String spo2Logs = 'spo2_logs';
  static const String doctorAppointments = 'doctor_appointments';
  static const String fastingLogs = 'fasting_logs';
  static const String mealPlans = 'meal_plans';
  static const String recipes = 'recipes';
  static const String journalEntries = 'journal_entries';
  static const String personalRecords = 'personal_records';
  static const String communityGroups = 'community_groups';
  static const String healthReports = 'health_reports';
  static const String communityDms = 'community_dms';
  static const String labReports = 'lab_reports';
  static const String abhaLinks = 'abha_links';
  static const String remoteConfig = 'remote_config';
  static const String syncDeadLetter = 'sync_dead_letter';

  // Storage Buckets
  static const String filesBucket = 'fitkarma_files';
}

