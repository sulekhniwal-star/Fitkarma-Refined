class AppConfig {
  AppConfig._();

  static const String appwriteEndpoint =
      String.fromEnvironment('APPWRITE_ENDPOINT',
          defaultValue: 'https://cloud.appwrite.io/v1');

  static const String appwriteProjectId =
      String.fromEnvironment('APPWRITE_PROJECT_ID');

  // DB IDs (set after CLI creates them)
  static const String dbId     = String.fromEnvironment('APPWRITE_DB_ID');
  static const String usersCol = 'users';
  static const String foodCol  = 'food_logs';
  static const String bpCol    = 'bp_readings';
  // ... other collection IDs
}
