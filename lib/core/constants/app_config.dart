// lib/core/constants/app_config.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get appwriteEndpoint => dotenv.env['APPWRITE_ENDPOINT'] ?? '';
  static String get appwriteProjectId => dotenv.env['APPWRITE_PROJECT_ID'] ?? '';
  static String get appwriteDatabaseId => dotenv.env['APPWRITE_DATABASE_ID'] ?? '';
  
  static const String appName = 'FitKarma';
  static const String bundleId = 'com.fitkarma';
  
  // Design targets
  static const double maxAppSizeMB = 50.0;
  static const Duration dashboardLoadTarget = Duration(seconds: 1);
}
