import 'package:appwrite/appwrite.dart' as aw;
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/constants/app_config.dart';
import 'package:fitkarma/core/di/providers.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/core/network/appwrite_client.dart';
import 'package:fitkarma/features/onboarding/data/onboarding_state.dart';

class OnboardingCompletionService {
  static Future<String?> completeOnboarding({
    required OnboardingState state,
    required BuildContext context,
  }) async {
    final container = ProviderContainer();
    final db = container.read(driftDatabaseProvider);
    final client = AppwriteClient.instance;

    try {
      await client.init();
      final account = client.account;
      
      final user = await account.get();
      final odUserId = user.$id;
      final now = DateTime.now();

      await db.into(db.userProfiles).insertOnConflictUpdate(
        UserProfilesCompanion.insert(
          odUserId: odUserId,
          name: state.name ?? '',
          gender: state.gender ?? '',
          dateOfBirth: state.dateOfBirth ?? now,
          heightCm: state.heightCm ?? 0,
          weightKg: state.weightKg ?? 0,
          fitnessGoal: state.fitnessGoal ?? '',
          activityLevel: state.activityLevel ?? '',
          chronicConditions: state.chronicConditions.join(','),
          vataPercent: state.vataPercent,
          pittaPercent: state.pittaPercent,
          kaphaPercent: state.kaphaPercent,
          language: state.language,
          stepCounterPermission: Value(state.stepCounterPermission),
          heartRatePermission: Value(state.heartRatePermission),
          sleepPermission: Value(state.sleepPermission),
          abhaNumber: Value(state.abhaNumber),
          wearableConnected: Value(state.wearableConnected),
          karmaXp: const Value(50),
          createdAt: now,
          updatedAt: now,
        ),
      );

      final databases = client.databases;
      
      final permissions = [
        aw.Permission.read(aw.Role.user(odUserId)),
        aw.Permission.write(aw.Role.user(odUserId)),
      ];

      try {
        await databases.createDocument(
          databaseId: AppConfig.appwriteDatabaseId,
          collectionId: AppConfig.profilesCollectionId,
          documentId: odUserId,
          data: {
            'odUserId': odUserId,
            'name': state.name,
            'gender': state.gender,
            'dateOfBirth': state.dateOfBirth?.toIso8601String(),
            'heightCm': state.heightCm,
            'weightKg': state.weightKg,
            'fitnessGoal': state.fitnessGoal,
            'activityLevel': state.activityLevel,
            'chronicConditions': state.chronicConditions,
            'vataPercent': state.vataPercent,
            'pittaPercent': state.pittaPercent,
            'kaphaPercent': state.kaphaPercent,
            'language': state.language,
            'stepCounterPermission': state.stepCounterPermission,
            'heartRatePermission': state.heartRatePermission,
            'sleepPermission': state.sleepPermission,
            'abhaNumber': state.abhaNumber,
            'wearableConnected': state.wearableConnected,
            'karmaXp': 50,
            'createdAt': now.toIso8601String(),
            'updatedAt': now.toIso8601String(),
          },
          permissions: permissions,
        );
      } catch (e) {
        debugPrint('Appwrite document creation: $e');
      }

      if (state.abhaNumber != null && state.abhaNumber!.isNotEmpty) {
        try {
          await databases.createDocument(
            databaseId: AppConfig.appwriteDatabaseId,
            collectionId: AppConfig.abhaLinksCollectionId,
            documentId: aw.ID.unique(),
            data: {
              'userId': odUserId,
              'abhaNumber': state.abhaNumber,
              'isVerified': false,
              'linkedAt': now.toIso8601String(),
            },
            permissions: permissions,
          );
          
          await _awardKarma(db, odUserId, 100);
          debugPrint('ABHA linked: +100 XP bonus awarded');
        } catch (e) {
          debugPrint('ABHA link creation: $e');
        }
      }

      debugPrint('Onboarding complete for user: $odUserId');
      return odUserId;
    } catch (e) {
      debugPrint('Onboarding completion error: $e');
      rethrow;
    } finally {
      container.dispose();
    }
  }

  static Future<void> _awardKarma(AppDatabase db, String odUserId, int amount) async {
    final now = DateTime.now();
    await db.into(db.karmaTransactions).insert(
      KarmaTransactionsCompanion.insert(
        userId: odUserId,
        amount: amount,
        createdAt: now,
      ),
    );
  }
}