import 'dart:convert';
import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'onboarding_state.dart';

/// Service for saving user profile to Drift and syncing to Appwrite
class UserProfileService {
  final AppDatabase db;

  UserProfileService(this.db);

  /// Save user profile to local Drift database
  Future<void> saveToDrift(OnboardingState state, String userId) async {
    final now = DateTime.now();

    // Convert JSON fields
    final chronicConditionsJson = json.encode(state.chronicConditions);
    final doshaQuizAnswersJson = state.doshaQuizAnswers.isNotEmpty
        ? json.encode(
            state.doshaQuizAnswers.map((k, v) => MapEntry(k.toString(), v)),
          )
        : null;
    final connectedWearablesJson = json.encode(state.connectedWearables);

    // Calculate XP
    int xpEarned = 50; // Base XP for completing onboarding
    if (state.abhaLinked) xpEarned += 100; // Bonus for ABHA link

    final profileId = 'profile_$userId';

    // Check if profile already exists
    final existing = await (db.select(
      db.userProfiles,
    )..where((tbl) => tbl.userId.equals(userId))).getSingleOrNull();

    if (existing != null) {
      // Update existing profile
      await (db.update(
        db.userProfiles,
      )..where((tbl) => tbl.id.equals(profileId))).write(
        UserProfilesCompanion(
          name: Value(state.name ?? ''),
          gender: Value(state.gender),
          dateOfBirth: Value(state.dateOfBirth),
          heightCm: Value(state.heightCm),
          weightKg: Value(state.weightKg),
          fitnessGoal: Value(state.fitnessGoal),
          activityLevel: Value(state.activityLevel),
          chronicConditions: Value(chronicConditionsJson),
          doshaQuizAnswers: Value(doshaQuizAnswersJson),
          vataPercentage: Value(state.vataPercentage),
          pittaPercentage: Value(state.pittaPercentage),
          kaphaPercentage: Value(state.kaphaPercentage),
          dominantDosha: Value(state.dominantDosha),
          languageCode: Value(state.languageCode),
          permissionStepCounter: Value(state.permissionStepCounter),
          permissionHeartRate: Value(state.permissionHeartRate),
          permissionSleep: Value(state.permissionSleep),
          abhaNumber: Value(state.abhaNumber),
          abhaLinked: Value(state.abhaLinked),
          connectedWearables: Value(connectedWearablesJson),
          xpPoints: Value(xpEarned),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
    } else {
      // Insert new profile
      await db
          .into(db.userProfiles)
          .insert(
            UserProfilesCompanion.insert(
              id: profileId,
              userId: userId,
              name: state.name ?? '',
              gender: Value(state.gender),
              dateOfBirth: Value(state.dateOfBirth),
              heightCm: Value(state.heightCm),
              weightKg: Value(state.weightKg),
              fitnessGoal: Value(state.fitnessGoal),
              activityLevel: Value(state.activityLevel),
              chronicConditions: Value(chronicConditionsJson),
              doshaQuizAnswers: Value(doshaQuizAnswersJson),
              vataPercentage: Value(state.vataPercentage),
              pittaPercentage: Value(state.pittaPercentage),
              kaphaPercentage: Value(state.kaphaPercentage),
              dominantDosha: Value(state.dominantDosha),
              languageCode: Value(state.languageCode),
              permissionStepCounter: Value(state.permissionStepCounter),
              permissionHeartRate: Value(state.permissionHeartRate),
              permissionSleep: Value(state.permissionSleep),
              abhaNumber: Value(state.abhaNumber),
              abhaLinked: Value(state.abhaLinked),
              connectedWearables: Value(connectedWearablesJson),
              xpPoints: Value(xpEarned),
              createdAt: now,
              updatedAt: now,
              syncStatus: const Value('pending'),
            ),
          );
    }
  }

  /// Enqueue Appwrite sync for the user profile
  Future<void> enqueueAppwriteSync(
    OnboardingState state,
    String userId,
    dynamic databases,
  ) async {
    const databaseId = 'fitkarma';
    const collectionId = 'users';

    // Prepare the document data
    final Map<String, dynamic> documentData = {
      'userId': userId,
      'name': state.name,
      'gender': state.gender,
      'dateOfBirth': state.dateOfBirth?.toIso8601String(),
      'heightCm': state.heightCm,
      'weightKg': state.weightKg,
      'fitnessGoal': state.fitnessGoal,
      'activityLevel': state.activityLevel,
      'chronicConditions': state.chronicConditions,
      'vataPercentage': state.vataPercentage,
      'pittaPercentage': state.pittaPercentage,
      'kaphaPercentage': state.kaphaPercentage,
      'dominantDosha': state.dominantDosha,
      'languageCode': state.languageCode,
      'permissionStepCounter': state.permissionStepCounter,
      'permissionHeartRate': state.permissionHeartRate,
      'permissionSleep': state.permissionSleep,
      'abhaLinked': state.abhaLinked,
      'connectedWearables': state.connectedWearables,
      'xpPoints': state.abhaLinked ? 150 : 50,
      'onboardingCompleted': true,
    };

    try {
      // Try to create the document in Appwrite
      // Note: This requires the 'users' collection to exist in Appwrite
      // and proper permissions to be set
      await databases.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: appwrite.ID.unique(),
        data: documentData,
        permissions: [
          // Set Role.user(uid) read + write permissions
          appwrite.Permission.read(appwrite.Role.user(userId)),
          appwrite.Permission.write(appwrite.Role.user(userId)),
        ],
      );
    } catch (e) {
      // If collection doesn't exist or other error, log and continue
      // The sync queue will handle retry when collection is created
      print('Appwrite sync warning: $e');

      // Add to sync queue for later retry
      await _addToSyncQueue(userId, documentData);
    }
  }

  /// Add sync entry to local queue for retry
  Future<void> _addToSyncQueue(String userId, Map<String, dynamic> data) async {
    final now = DateTime.now();
    final id = 'sync_${now.millisecondsSinceEpoch}';

    await db
        .into(db.syncQueue)
        .insert(
          SyncQueueCompanion.insert(
            id: id,
            collection: 'users',
            operation: 'create',
            localId: 'profile_$userId',
            payload: json.encode(data),
            idempotencyKey:
                '${userId}_user_profile_${now.millisecondsSinceEpoch}',
            createdAt: now,
          ),
        );
  }

  /// Complete onboarding: save to Drift, enqueue Appwrite sync, award XP
  Future<void> completeOnboarding(
    OnboardingState state,
    String userId,
    dynamic databases,
  ) async {
    // 1. Save to Drift
    await saveToDrift(state, userId);

    // 2. Enqueue Appwrite sync
    await enqueueAppwriteSync(state, userId, databases);

    // 3. XP is already saved in step 1 via xpPoints field
    print('Onboarding complete! XP earned: ${state.abhaLinked ? 150 : 50}');
  }
}
