import '../config/app_config.dart';

class AW {
  // Appwrite Project Configuration (Centralized in AppConfig)
  static const String endpoint = AppConfig.appwriteEndpoint;
  static const String projectId = AppConfig.appwriteProjectId;
  static const String dbId = AppConfig.dbId;

  // Collection IDs (Aligned with appwrite.config.json)
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
  static const String glucoseLogs = 'glucose_readings'; // Matches appwrite.config.json
  static const String spo2Logs = 'spo2_logs';
  static const String doctorAppointments = 'doctor_appointments';
  static const String fastingLogs = 'fasting_logs';
  static const String mealPlans = 'meal_plans';
  static const String recipes = 'recipes';
  static const String journalEntries = 'journal'; // Matches appwrite.config.json
  static const String personalRecords = 'personal_records';
  static const String communityGroups = 'community_groups';
  static const String healthReports = 'health_reports';
  static const String communityDms = 'community_dms';
  static const String labReports = 'lab_reports';
  static const String abhaLinks = 'abha_links';
  static const String remoteConfig = 'remote_config';
  static const String waterLogs = 'water_logs';
  static const String syncDeadLetter = 'sync_dead_letter';

  // Storage Buckets
  static const String filesBucket = 'fitkarma_files';
}


