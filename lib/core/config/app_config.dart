class AppConfig {
  AppConfig._();

  static const String appwriteEndpoint =
      String.fromEnvironment('APPWRITE_ENDPOINT',
          defaultValue: 'https://cloud.appwrite.io/v1');

  static const String appwriteProjectId =
      String.fromEnvironment('APPWRITE_PROJECT_ID');

  // DB IDs (initialized from environment variables)
  static const String dbId = String.fromEnvironment('APPWRITE_DB_ID');
  
  // Feature Flags
  static const bool enableGlow = !bool.fromEnvironment('LOW_END_DEVICE');
  static const bool isStaging = String.fromEnvironment('FLAVOR') == 'staging';
}
