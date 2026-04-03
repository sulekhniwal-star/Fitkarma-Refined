import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class AppConfig {
  AppConfig._();

  // App
  static const String appName = 'FitKarma';
  static const String appVersion = '1.0.0';
  static const int appBuildNumber = 1;

  // Appwrite
  static const String appwriteDatabaseId = 'fitkarma';
  static const String usersCollectionId = 'users';
  static const String profilesCollectionId = 'profiles';
  static const String abhaLinksCollectionId = 'abha_links';
  static const String foodItemsCollectionId = 'food_items';
  static const String foodLogsCollectionId = 'food_logs';

  // Database
  static const String dbFilename = 'fitkarma.db';
  static const int dbSchemaVersion = 5;

  // Sync
  static const int syncBatchSize = 50;
  static const int syncMaxRetries = 5;
  static const Duration syncInterval = Duration(minutes: 5);
  static const Duration syncRetryDelay = Duration(seconds: 30);

  // Pagination
  static const int defaultPageSize = 20;
  static const int dashboardLogLimit = 7;

  // Karma
  static const int karmaPerFoodLog = 5;
  static const int karmaPerWorkoutLog = 10;
  static const int karmaPerStepGoal = 15;
  static const int karmaPerSleepLog = 5;
  static const int karmaPerMoodLog = 3;
  static const int karmaPerHabitComplete = 5;

  // Step goals
  static const int defaultDailyStepGoal = 10000;

  // Fasting
  static const int defaultFastHours = 16;

  // Env-loaded values
  static String get appwriteProjectId =>
      dotenv.env['APPWRITE_PROJECT_ID'] ?? '';

  static String get appwriteEndpoint =>
      dotenv.env['APPWRITE_ENDPOINT'] ?? '';

  static bool get isProduction => appwriteProjectId.contains('production');
}
