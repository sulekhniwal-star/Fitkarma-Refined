class AppConfig {
  AppConfig._();

  static const String appwriteEndpoint =
      String.fromEnvironment('APPWRITE_ENDPOINT',
          defaultValue: 'https://cloud.appwrite.io/v1');

  static const String appwriteProjectId =
      String.fromEnvironment('APPWRITE_PROJECT_ID');

  // DB IDs (set after CLI creates them)
  static const String dbId     = 'fitkarma-db';
  
  // Collection IDs
  static const String usersCol          = 'users';
  static const String foodLogsCol       = 'food_logs';
  static const String bpReadingsCol     = 'bp_readings';
  static const String glucoseReadingsCol = 'glucose_readings';
  static const String sleepLogsCol      = 'sleep_logs';
  static const String waterLogsCol      = 'water_logs';
  static const String medicationLogsCol = 'medication_logs';
  static const String labReportsCol     = 'lab_reports';
  static const String karmaEventsCol    = 'karma_events';
  static const String spo2ReadingsCol   = 'spo2_readings';
  static const String workoutsCol       = 'workouts';
  static const String habitsCol         = 'habits';
  static const String stepLogsCol       = 'step_logs';

  // Storage Buckets (Consolidated)
  static const String mediaBucket       = 'fitkarma-media';
}
