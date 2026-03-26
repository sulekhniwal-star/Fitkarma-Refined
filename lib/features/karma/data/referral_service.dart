import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:drift/drift.dart';
import 'package:fitkarma/core/network/appwrite_client.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/core/utils/referral_code_generator.dart';

/// Service for handling referral system logic
class ReferralService {
  final AppDatabase db;

  ReferralService(this.db);

  /// Generate a unique referral code for a user
  String generateReferralCode() {
    return ReferralCodeGenerator.generateCode();
  }

  /// Create a referral record when a user signs up with a referral code
  /// Returns the referrer's userId if found, null otherwise
  Future<String?> processReferral(
    String referredUserId,
    String referralCode,
  ) async {
    try {
      // Find the referrer by their referral code
      final referrerProfile =
          await (db.select(db.userProfiles)
                ..where((tbl) => tbl.referralCode.equals(referralCode)))
              .getSingleOrNull();

      if (referrerProfile == null) {
        // Invalid referral code - return null
        return null;
      }

      // Update the referred user's profile with the referrer info
      await (db.update(
        db.userProfiles,
      )..where((tbl) => tbl.userId.equals(referredUserId))).write(
        UserProfilesCompanion(referredBy: Value(referrerProfile.userId)),
      );

      // Award 100 XP to the referred user for signing up
      await _awardXpToUser(referredUserId, 100, 'referral_signup');

      return referrerProfile.userId;
    } catch (e) {
      print('Error processing referral: $e');
      return null;
    }
  }

  /// Called when a referred user completes onboarding
  /// Awards 500 XP to the referrer
  Future<void> onReferredUserOnboarded(String referredUserId) async {
    try {
      // Get the referred user's profile to find who referred them
      final referredProfile = await (db.select(
        db.userProfiles,
      )..where((tbl) => tbl.userId.equals(referredUserId))).getSingleOrNull();

      if (referredProfile == null || referredProfile.referredBy == null) {
        // No referrer found
        return;
      }

      final referrerUserId = referredProfile.referredBy!;

      // Award 500 XP to the referrer
      await _awardXpToUser(referrerUserId, 500, 'referral_completed');

      // Update referrer's referral count and XP earned
      final referrerProfile = await (db.select(
        db.userProfiles,
      )..where((tbl) => tbl.userId.equals(referrerUserId))).getSingleOrNull();

      if (referrerProfile != null) {
        await (db.update(
          db.userProfiles,
        )..where((tbl) => tbl.userId.equals(referrerUserId))).write(
          UserProfilesCompanion(
            referralCount: Value(referrerProfile.referralCount + 1),
            referralXpEarned: Value(referrerProfile.referralXpEarned + 500),
          ),
        );
      }
    } catch (e) {
      print('Error processing referral onboarding bonus: $e');
    }
  }

  /// Award XP to a user and create a karma transaction
  Future<void> _awardXpToUser(String userId, int amount, String action) async {
    try {
      // Get current karma profile
      final karmaProfile = await (db.select(
        db.karmaProfiles,
      )..where((tbl) => tbl.userId.equals(userId))).getSingleOrNull();

      final newBalance = (karmaProfile?.totalXp ?? 0) + amount;
      final now = DateTime.now();

      // Create karma transaction
      final transactionId = 'txn_${now.millisecondsSinceEpoch}';
      await db
          .into(db.karmaTransactions)
          .insert(
            KarmaTransactionsCompanion.insert(
              id: transactionId,
              userId: userId,
              amount: amount,
              action: action,
              description: const Value('Referral bonus'),
              balanceAfter: newBalance,
              createdAt: now,
            ),
          );

      // Update karma profile
      if (karmaProfile != null) {
        await (db.update(
          db.karmaProfiles,
        )..where((tbl) => tbl.userId.equals(userId))).write(
          KarmaProfilesCompanion(
            totalXp: Value(newBalance),
            updatedAt: Value(now),
          ),
        );
      }

      // Also sync to Appwrite if possible
      await _syncXpToAppwrite(userId, newBalance);
    } catch (e) {
      print('Error awarding XP: $e');
    }
  }

  /// Sync XP to Appwrite
  Future<void> _syncXpToAppwrite(String userId, int totalXp) async {
    try {
      final databases = AppwriteClient.databases;
      const databaseId = 'fitkarma';
      const collectionId = 'users';

      // Find the user document by userId
      final response = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
        queries: [appwrite.Query.equal('userId', userId)],
      );

      if (response.documents.isNotEmpty) {
        final docId = response.documents.first.$id;
        await databases.updateDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: docId,
          data: {'xpPoints': totalXp},
        );
      }
    } catch (e) {
      print('Error syncing XP to Appwrite: $e');
    }
  }

  /// Get referral stats for a user
  Future<Map<String, int>> getReferralStats(String userId) async {
    try {
      final profile = await (db.select(
        db.userProfiles,
      )..where((tbl) => tbl.userId.equals(userId))).getSingleOrNull();

      if (profile == null) {
        return {'count': 0, 'xpEarned': 0};
      }

      return {
        'count': profile.referralCount,
        'xpEarned': profile.referralXpEarned,
      };
    } catch (e) {
      return {'count': 0, 'xpEarned': 0};
    }
  }

  /// Validate a referral code
  Future<bool> isValidReferralCode(String code) async {
    if (!ReferralCodeGenerator.isValidCode(code)) {
      return false;
    }

    try {
      // Check if a user with this code exists
      final profile = await (db.select(
        db.userProfiles,
      )..where((tbl) => tbl.referralCode.equals(code))).getSingleOrNull();

      return profile != null;
    } catch (e) {
      return false;
    }
  }
}
