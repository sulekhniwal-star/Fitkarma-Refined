class AppConfig {
  AppConfig._();

  static const String appwriteEndpoint =
      String.fromEnvironment('APPWRITE_ENDPOINT',
          defaultValue: 'https://cloud.appwrite.io/v1');

  static const String appwriteProjectId =
      String.fromEnvironment('APPWRITE_PROJECT_ID');

  // DB IDs (set after CLI creates them)
  static const String dbId     = String.fromEnvironment('APPWRITE_DB_ID');
  
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

  // Storage Buckets
  static const String labReportsBucket  = 'lab-reports';
  static const String avatarsBucket     = 'avatars';
}
