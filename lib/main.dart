import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/network/appwrite_client.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Appwrite Client
  AppwriteClient.init();
  
  // Test connection (non-blocking)
  AppwriteClient.testConnection();

  runApp(
    const ProviderScope(
      child: FitKarmaApp(),
    ),
  );
}
