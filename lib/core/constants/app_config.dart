import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  AppConfig._();

  // ── App Identity ──────────────────────────────────────────────
  static const String appName = 'Fitkarma';
  static const String packageName = 'com.fitkarma.fitkarma';
  static const String appVersion = '1.0.0+1';

  // ── Environment ───────────────────────────────────────────────
  static String get _env => dotenv.env['APPWRITE_ENDPOINT'] ?? '';

  static bool get isProduction =>
      _env.contains('cloud.appwrite.io') && !_env.contains('staging');

  static bool get isStaging => !isProduction;

  static String get environmentName => isProduction ? 'production' : 'staging';

  // ── Appwrite ──────────────────────────────────────────────────
  static String get projectId =>
      dotenv.env['APPWRITE_PROJECT_ID'] ?? 'fitkarma-staging';

  static String get endpoint =>
      dotenv.env['APPWRITE_ENDPOINT'] ?? 'https://cloud.appwrite.io/v1';

  // ── Database ──────────────────────────────────────────────────
  static const String databaseName = 'fitkarma_db';
  static const int databaseSchemaVersion = 5;

  // ── Sync ──────────────────────────────────────────────────────
  static const int syncBatchSize = 50;
  static const int syncMaxRetries = 3;
  static const Duration syncRetryDelay = Duration(seconds: 5);
  static const Duration syncCooldown = Duration(minutes: 5);

  // ── Health Thresholds ─────────────────────────────────────────
  static const int bpSystolicHigh = 140;
  static const int bpDiastolicHigh = 90;
  static const double glucoseFastingHigh = 126.0; // mg/dL
  static const int spo2Low = 94; // percent
  static const int stepsDailyGoal = 10000;

  // ── Karma ─────────────────────────────────────────────────────
  static const int karmaPerWorkout = 10;
  static const int karmaPerFoodLog = 5;
  static const int karmaPerHabitCompletion = 3;
  static const int karmaPerDailyStepsGoal = 15;
  static const int karmaStreakMultiplierCap = 5;

  // ── Cache TTLs ────────────────────────────────────────────────
  static const Duration remoteConfigTtl = Duration(hours: 6);
  static const Duration foodSearchCacheTtl = Duration(days: 7);
  static const Duration festivalCacheTtl = Duration(days: 30);

  // ── Pagination ────────────────────────────────────────────────
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
}
