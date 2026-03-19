import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/network/appwrite_client.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/core/storage/drift_service.dart';
import 'package:fitkarma/core/security/encryption_service.dart';
import 'package:fitkarma/core/security/key_manager.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Appwrite Client
  AppwriteClient.init();

  // Test connection (non-blocking)
  AppwriteClient.testConnection();

  // Initialize Core Storage & Encryption
  // Step 1: Get the master key (derives from device_id + app_install_uuid + salt using PBKDF2)
  final masterKeyBase64 = await KeyManager.getMasterKey();

  // Step 2: Initialize the encryption service with the master key
  EncryptionService.instance.init(masterKeyBase64);

  // Step 3: Initialize per-data-class HKDF mode for lateral movement protection
  // This derives separate keys for BP, Period, Journal, Appointments, LabReports
  final masterKeyBytes = base64.decode(masterKeyBase64);
  EncryptionService.instance.initDataClassModeSync(masterKeyBytes);

  // Initialize database with encryption key
  final db = AppDatabase(masterKeyBase64);
  final driftServiceInstance = DriftService(db);

  // Verify DAOs (Health Check)
  await AppDatabase.verifyDaos(db);

  runApp(
    ProviderScope(
      overrides: [driftServiceProvider.overrideWithValue(driftServiceInstance)],
      child: const FitKarmaApp(),
    ),
  );
}
