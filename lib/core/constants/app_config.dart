class AppConfig {
  static const appwriteEndpoint = String.fromEnvironment('APPWRITE_ENDPOINT');
  static const appwriteProjectId = String.fromEnvironment('APPWRITE_PROJECT_ID');
  static const appwriteDatabaseId = String.fromEnvironment('APPWRITE_DATABASE_ID');

  static const razorpayKeyId = String.fromEnvironment('RAZORPAY_KEY_ID');

  static const fitbitClientId = String.fromEnvironment('FITBIT_CLIENT_ID');
  static const fitbitClientSecret = String.fromEnvironment('FITBIT_CLIENT_SECRET');
  static const garminClientId = String.fromEnvironment('GARMIN_CLIENT_ID');
  static const garminClientSecret = String.fromEnvironment('GARMIN_CLIENT_SECRET');

  static const whatsappBotNumber = String.fromEnvironment('WHATSAPP_BOT_NUMBER');
  static const whatsappApiKey = String.fromEnvironment('WHATSAPP_API_KEY');

  static const sentryDsn = String.fromEnvironment('SENTRY_DSN');

  static const abhaApiEndpoint = String.fromEnvironment('ABHA_API_ENDPOINT');
  static const abhaClientId = String.fromEnvironment('ABHA_CLIENT_ID');
  static const abhaClientSecret = String.fromEnvironment('ABHA_CLIENT_SECRET');
}
