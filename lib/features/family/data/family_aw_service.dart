// lib/features/family/data/family_aw_service.dart
// Appwrite service for Family features

import 'package:flutter/foundation.dart';
import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:fitkarma/core/network/appwrite_client.dart' show AppwriteClient;
import 'family_models.dart';

/// Collection IDs for family features
class FamilyCollectionIds {
  static const String families = 'families';
  static const String familyMembers = 'family_members';
  static const String familyInvitations = 'family_invitations';
  static const String familyChallenges = 'family_challenges';
  static const String challengeParticipants = 'family_challenge_participants';
  static const String databaseId = 'fitkarma';
}

/// Appwrite service for family features
class FamilyAwService {
  appwrite.Databases get _databases => AppwriteClient.databases;
  appwrite.Functions get _functions => AppwriteClient.functions;

  // ==================== FAMILY ====================

  /// Create a new family group
  Future<String> createFamily({
    required String adminId,
    required String adminName,
    required String familyName,
    required SubscriptionPlan plan,
    int maxMembers = 5,
  }) async {
    try {
      final id = FamilyIdGenerator.familyId();
      final now = DateTime.now().toIso8601String();

      await _databases.createDocument(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.families,
        documentId: id,
        data: {
          'id': id,
          'name': familyName,
          'adminId': adminId,
          'adminName': adminName,
          'plan': plan.name,
          'maxMembers': maxMembers,
          'membersCount': 1,
          'createdAt': now,
          'updatedAt': now,
        },
        permissions: [
          appwrite.Permission.read(appwrite.Role.user(adminId)),
          appwrite.Permission.write(appwrite.Role.user(adminId)),
          appwrite.Permission.read(appwrite.Role.team('family_$id')),
        ],
      );

      // Add admin as first member
      await addMember(
        familyId: id,
        userId: adminId,
        userName: adminName,
        role: FamilyRole.admin,
      );

      return id;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Create family failed: ${e.message}');
      rethrow;
    }
  }

  /// Get family by ID
  Future<Family?> getFamily(String familyId) async {
    try {
      final response = await _databases.getDocument(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.families,
        documentId: familyId,
      );

      return Family.fromMap(response.data);
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get family failed: ${e.message}');
      return null;
    }
  }

  /// Get user's family (as admin or member)
  Future<Family?> getUserFamily(String userId) async {
    try {
      // First check if user is admin
      final adminResponse = await _databases.listDocuments(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.families,
        queries: [appwrite.Query.equal('adminId', userId)],
      );

      if (adminResponse.documents.isNotEmpty) {
        return Family.fromMap(adminResponse.documents.first.data);
      }

      // Check if user is a member
      final memberResponse = await _databases.listDocuments(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.familyMembers,
        queries: [
          appwrite.Query.equal('userId', userId),
          appwrite.Query.equal(
            'invitationStatus',
            InvitationStatus.accepted.name,
          ),
        ],
      );

      if (memberResponse.documents.isNotEmpty) {
        final member = FamilyMember.fromMap(
          memberResponse.documents.first.data,
        );
        return getFamily(member.familyId);
      }

      return null;
    } catch (e) {
      debugPrint('Get user family failed: $e');
      return null;
    }
  }

  /// Update family (admin only)
  Future<void> updateFamily({
    required String familyId,
    required String adminId,
    String? name,
    SubscriptionPlan? plan,
  }) async {
    try {
      final updateData = <String, dynamic>{
        'updatedAt': DateTime.now().toIso8601String(),
      };

      if (name != null) updateData['name'] = name;
      if (plan != null) updateData['plan'] = plan.name;

      await _databases.updateDocument(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.families,
        documentId: familyId,
        data: updateData,
      );
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Update family failed: ${e.message}');
      rethrow;
    }
  }

  /// Upgrade family to Family plan
  Future<void> upgradeToFamilyPlan(String familyId, String adminId) async {
    await updateFamily(
      familyId: familyId,
      adminId: adminId,
      plan: SubscriptionPlan.family,
    );
  }

  // ==================== MEMBERS ====================

  /// Add member to family
  Future<String> addMember({
    required String familyId,
    required String userId,
    required String userName,
    String? userEmail,
    String? userAvatarUrl,
    FamilyRole role = FamilyRole.member,
  }) async {
    try {
      final id = FamilyIdGenerator.memberId();
      final now = DateTime.now().toIso8601String();

      await _databases.createDocument(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.familyMembers,
        documentId: id,
        data: {
          'id': id,
          'familyId': familyId,
          'userId': userId,
          'userName': userName,
          'userEmail': userEmail,
          'userAvatarUrl': userAvatarUrl,
          'role': role.name,
          'invitationStatus': InvitationStatus.accepted.name,
          'joinedAt': now,
          'lastActiveAt': now,
        },
        permissions: [
          appwrite.Permission.read(appwrite.Role.user(userId)),
          appwrite.Permission.write(appwrite.Role.user(userId)),
        ],
      );

      // Update family members count
      await _updateFamilyMembersCount(familyId, 1);

      return id;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Add member failed: ${e.message}');
      rethrow;
    }
  }

  /// Get family members
  Future<List<FamilyMember>> getFamilyMembers(String familyId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.familyMembers,
        queries: [
          appwrite.Query.equal('familyId', familyId),
          appwrite.Query.equal(
            'invitationStatus',
            InvitationStatus.accepted.name,
          ),
        ],
      );

      return response.documents
          .map((doc) => FamilyMember.fromMap(doc.data))
          .toList();
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get family members failed: ${e.message}');
      return [];
    }
  }

  /// Get member with summary data (for admin view)
  Future<List<FamilyMember>> getMembersWithSummary(
    String familyId,
    String adminId,
  ) async {
    try {
      final members = await getFamilyMembers(familyId);

      // For each member, get their weekly summary
      // This would typically aggregate from step logs and other data
      return members.map((member) {
        return member.copyWith(
          weeklySteps: _generateMockWeeklySteps(),
          weeklyWaterGlasses: _generateMockWeeklyWater(),
          currentStreak: _generateMockStreak(),
        );
      }).toList();
    } catch (e) {
      debugPrint('Get members with summary failed: $e');
      return [];
    }
  }

  /// Remove member from family
  Future<void> removeMember(String memberId, String familyId) async {
    try {
      await _databases.deleteDocument(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.familyMembers,
        documentId: memberId,
      );

      await _updateFamilyMembersCount(familyId, -1);
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Remove member failed: ${e.message}');
      rethrow;
    }
  }

  /// Update last active time
  Future<void> updateMemberActivity(String memberId) async {
    try {
      await _databases.updateDocument(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.familyMembers,
        documentId: memberId,
        data: {'lastActiveAt': DateTime.now().toIso8601String()},
      );
    } catch (e) {
      debugPrint('Update member activity failed: $e');
    }
  }

  // ==================== INVITATIONS ====================

  /// Send invitation to join family
  Future<String> sendInvitation({
    required String familyId,
    required String familyName,
    required String inviterId,
    required String inviterName,
    required String inviteeEmail,
  }) async {
    try {
      final id = FamilyIdGenerator.invitationId();
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(days: 7));

      await _databases.createDocument(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.familyInvitations,
        documentId: id,
        data: {
          'id': id,
          'familyId': familyId,
          'familyName': familyName,
          'inviterId': inviterId,
          'inviterName': inviterName,
          'inviteeEmail': inviteeEmail,
          'status': InvitationStatus.pending.name,
          'createdAt': now.toIso8601String(),
          'expiresAt': expiresAt.toIso8601String(),
        },
        permissions: [
          appwrite.Permission.read(appwrite.Role.user(inviterId)),
          appwrite.Permission.write(appwrite.Role.user(inviterId)),
        ],
      );

      // TODO: Send email notification via Appwrite Function

      return id;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Send invitation failed: ${e.message}');
      rethrow;
    }
  }

  /// Get pending invitations for user
  Future<List<FamilyInvitation>> getPendingInvitations(String email) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.familyInvitations,
        queries: [
          appwrite.Query.equal('inviteeEmail', email),
          appwrite.Query.equal('status', InvitationStatus.pending.name),
        ],
      );

      return response.documents
          .map((doc) => FamilyInvitation.fromMap(doc.data))
          .where((inv) => !inv.isExpired)
          .toList();
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get pending invitations failed: ${e.message}');
      return [];
    }
  }

  /// Accept invitation
  Future<void> acceptInvitation({
    required String invitationId,
    required String familyId,
    required String userId,
    required String userName,
    String? userEmail,
  }) async {
    try {
      // Update invitation status
      await _databases.updateDocument(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.familyInvitations,
        documentId: invitationId,
        data: {'status': InvitationStatus.accepted.name},
      );

      // Add user as member
      await addMember(
        familyId: familyId,
        userId: userId,
        userName: userName,
        userEmail: userEmail,
      );

      // TODO: Add user to family team in Appwrite
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Accept invitation failed: ${e.message}');
      rethrow;
    }
  }

  /// Reject invitation
  Future<void> rejectInvitation(String invitationId) async {
    try {
      await _databases.updateDocument(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.familyInvitations,
        documentId: invitationId,
        data: {'status': InvitationStatus.rejected.name},
      );
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Reject invitation failed: ${e.message}');
      rethrow;
    }
  }

  // ==================== CHALLENGES ====================

  /// Create a family challenge
  Future<String> createChallenge({
    required String familyId,
    required String title,
    required String description,
    required FamilyChallengeType type,
    required int targetValue,
    required String targetUnit,
    required DateTime startDate,
    required DateTime endDate,
    required String createdBy,
    required String createdByName,
  }) async {
    try {
      final id = FamilyIdGenerator.challengeId();

      await _databases.createDocument(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.familyChallenges,
        documentId: id,
        data: {
          'id': id,
          'familyId': familyId,
          'title': title,
          'description': description,
          'type': type.name,
          'targetValue': targetValue,
          'targetUnit': targetUnit,
          'startDate': startDate.toIso8601String(),
          'endDate': endDate.toIso8601String(),
          'createdBy': createdBy,
          'createdByName': createdByName,
          'status': FamilyChallengeStatus.upcoming.name,
          'participantsCount': 0,
          'isJoinedByMe': false,
        },
        permissions: [
          appwrite.Permission.read(appwrite.Role.team('family_$familyId')),
          appwrite.Permission.write(appwrite.Role.team('family_$familyId')),
        ],
      );

      return id;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Create challenge failed: ${e.message}');
      rethrow;
    }
  }

  /// Get family challenges
  Future<List<FamilyChallenge>> getFamilyChallenges(String familyId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.familyChallenges,
        queries: [
          appwrite.Query.equal('familyId', familyId),
          appwrite.Query.orderDesc('createdAt'),
        ],
      );

      final now = DateTime.now();
      return response.documents.map((doc) {
        final data = doc.data;
        final startDate = DateTime.parse(data['startDate'] as String);
        final endDate = DateTime.parse(data['endDate'] as String);

        FamilyChallengeStatus status;
        if (now.isBefore(startDate)) {
          status = FamilyChallengeStatus.upcoming;
        } else if (now.isAfter(endDate)) {
          status = FamilyChallengeStatus.completed;
        } else {
          status = FamilyChallengeStatus.active;
        }

        return FamilyChallenge.fromMap({...data, 'status': status.name});
      }).toList();
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get family challenges failed: ${e.message}');
      return [];
    }
  }

  /// Join a challenge
  Future<void> joinChallenge({
    required String challengeId,
    required String familyId,
    required String userId,
    required String userName,
    String? userAvatarUrl,
    required int targetValue,
  }) async {
    try {
      final id = FamilyIdGenerator.participantId();

      await _databases.createDocument(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.challengeParticipants,
        documentId: id,
        data: {
          'id': id,
          'challengeId': challengeId,
          'userId': userId,
          'userName': userName,
          'userAvatarUrl': userAvatarUrl,
          'progress': 0,
          'targetValue': targetValue,
          'isCompleted': false,
          'joinedAt': DateTime.now().toIso8601String(),
        },
        permissions: [
          appwrite.Permission.read(appwrite.Role.user(userId)),
          appwrite.Permission.write(appwrite.Role.user(userId)),
        ],
      );

      // Update challenge participants count
      await _updateChallengeParticipantsCount(challengeId, 1);
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Join challenge failed: ${e.message}');
      rethrow;
    }
  }

  /// Get challenge participants
  Future<List<ChallengeParticipant>> getChallengeParticipants(
    String challengeId,
  ) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.challengeParticipants,
        queries: [
          appwrite.Query.equal('challengeId', challengeId),
          appwrite.Query.orderDesc('progress'),
        ],
      );

      return response.documents
          .map((doc) => ChallengeParticipant.fromMap(doc.data))
          .toList();
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get challenge participants failed: ${e.message}');
      return [];
    }
  }

  /// Update challenge progress
  Future<void> updateChallengeProgress({
    required String participantId,
    required int progress,
  }) async {
    try {
      await _databases.updateDocument(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.challengeParticipants,
        documentId: participantId,
        data: {'progress': progress},
      );
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Update challenge progress failed: ${e.message}');
      rethrow;
    }
  }

  // ==================== LEADERBOARD ====================

  /// Get weekly leaderboard for family
  Future<List<FamilyLeaderboardEntry>> getWeeklyLeaderboard(
    String familyId,
    String currentUserId,
  ) async {
    try {
      final members = await getFamilyMembers(familyId);

      // Generate leaderboard with weekly data
      final entries = <FamilyLeaderboardEntry>[];

      for (int i = 0; i < members.length; i++) {
        final member = members[i];
        entries.add(
          FamilyLeaderboardEntry(
            oduserId: member.userId,
            oduserName: member.userName,
            oduserAvatarUrl: member.userAvatarUrl,
            rank: i + 1,
            weeklySteps: _generateMockWeeklySteps(),
            distanceKm: _generateMockDistance(),
            activeMinutes: _generateMockActiveMinutes(),
            streak: _generateMockStreak(),
          ),
        );
      }

      // Sort by weekly steps
      entries.sort((a, b) => b.weeklySteps.compareTo(a.weeklySteps));

      // Update ranks
      for (int i = 0; i < entries.length; i++) {
        entries[i] = FamilyLeaderboardEntry(
          oduserId: entries[i].oduserId,
          oduserName: entries[i].oduserName,
          oduserAvatarUrl: entries[i].oduserAvatarUrl,
          rank: i + 1,
          weeklySteps: entries[i].weeklySteps,
          distanceKm: entries[i].distanceKm,
          activeMinutes: entries[i].activeMinutes,
          streak: entries[i].streak,
        );
      }

      return entries;
    } catch (e) {
      debugPrint('Get weekly leaderboard failed: $e');
      return [];
    }
  }

  // ==================== NOTIFICATIONS ====================

  /// Send group push notification via Appwrite Function
  Future<void> sendGroupNotification({
    required String familyId,
    required String title,
    required String body,
    required String senderId,
    String? data,
  }) async {
    try {
      await _functions.createExecution(
        functionId: 'send-family-notification',
        data: {
          'familyId': familyId,
          'title': title,
          'body': body,
          'senderId': senderId,
          'data': data,
        }.toString(),
      );
    } catch (e) {
      debugPrint('Send group notification failed: $e');
      // Don't rethrow - notifications are non-critical
    }
  }

  // ==================== HELPERS ====================

  Future<void> _updateFamilyMembersCount(String familyId, int delta) async {
    try {
      final family = await getFamily(familyId);
      if (family == null) return;

      await _databases.updateDocument(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.families,
        documentId: familyId,
        data: {
          'membersCount': family.membersCount + delta,
          'updatedAt': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      debugPrint('Update family members count failed: $e');
    }
  }

  Future<void> _updateChallengeParticipantsCount(
    String challengeId,
    int delta,
  ) async {
    try {
      final response = await _databases.getDocument(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.familyChallenges,
        documentId: challengeId,
      );

      final currentCount = response.data['participantsCount'] as int? ?? 0;

      await _databases.updateDocument(
        databaseId: FamilyCollectionIds.databaseId,
        collectionId: FamilyCollectionIds.familyChallenges,
        documentId: challengeId,
        data: {'participantsCount': currentCount + delta},
      );
    } catch (e) {
      debugPrint('Update challenge participants count failed: $e');
    }
  }

  // Mock data generators (replace with actual data aggregation)
  int _generateMockWeeklySteps() {
    return 20000 + (DateTime.now().millisecond % 50000);
  }

  int _generateMockWeeklyWater() {
    return 20 + (DateTime.now().millisecond % 30);
  }

  int _generateMockStreak() {
    return 1 + (DateTime.now().millisecond % 14);
  }

  double _generateMockDistance() {
    return 10.0 + (DateTime.now().millisecond % 100) / 10;
  }

  int _generateMockActiveMinutes() {
    return 100 + (DateTime.now().millisecond % 300);
  }
}
