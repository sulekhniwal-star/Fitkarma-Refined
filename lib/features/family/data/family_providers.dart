// lib/features/family/data/family_providers.dart
// Providers for Family features

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'family_aw_service.dart';
import 'family_models.dart';

/// Provider for FamilyAwService
final familyAwServiceProvider = Provider<FamilyAwService>((ref) {
  return FamilyAwService();
});

/// Provider for current user's family
final currentFamilyProvider = FutureProvider.family<Family?, String>((
  ref,
  userId,
) async {
  final service = ref.read(familyAwServiceProvider);
  return await service.getUserFamily(userId);
});

/// Provider for family members
final familyMembersProvider = FutureProvider.family<List<FamilyMember>, String>(
  (ref, familyId) async {
    final service = ref.read(familyAwServiceProvider);
    return await service.getFamilyMembers(familyId);
  },
);

/// Provider for family members with summary (admin view)
final familyMembersWithSummaryProvider =
    FutureProvider.family<List<FamilyMember>, (String, String)>((
      ref,
      params,
    ) async {
      final (familyId, adminId) = params;
      final service = ref.read(familyAwServiceProvider);
      return await service.getMembersWithSummary(familyId, adminId);
    });

/// Provider for family challenges
final familyChallengesProvider =
    FutureProvider.family<List<FamilyChallenge>, String>((ref, familyId) async {
      final service = ref.read(familyAwServiceProvider);
      return await service.getFamilyChallenges(familyId);
    });

/// Provider for weekly leaderboard
final familyLeaderboardProvider =
    FutureProvider.family<List<FamilyLeaderboardEntry>, (String, String)>((
      ref,
      params,
    ) async {
      final (familyId, currentUserId) = params;
      final service = ref.read(familyAwServiceProvider);
      return await service.getWeeklyLeaderboard(familyId, currentUserId);
    });

/// Provider for pending invitations
final pendingInvitationsProvider =
    FutureProvider.family<List<FamilyInvitation>, String>((ref, email) async {
      final service = ref.read(familyAwServiceProvider);
      return await service.getPendingInvitations(email);
    });

/// Provider for challenge participants
final challengeParticipantsProvider =
    FutureProvider.family<List<ChallengeParticipant>, String>((
      ref,
      challengeId,
    ) async {
      final service = ref.read(familyAwServiceProvider);
      return await service.getChallengeParticipants(challengeId);
    });

/// Family data for display
class FamilyData {
  final Family? family;
  final List<FamilyMember> members;
  final List<FamilyChallenge> challenges;
  final bool isLoading;
  final String? error;

  FamilyData({
    this.family,
    this.members = const [],
    this.challenges = const [],
    this.isLoading = false,
    this.error,
  });

  bool get hasFamily => family != null;
  bool get isAdmin => family?.adminId != null;
  bool get canInvite => hasFamily && family!.canInviteMore;
}

/// Provider to get all family data at once
final familyDataProvider = FutureProvider.family<FamilyData, String>((
  ref,
  userId,
) async {
  final service = ref.read(familyAwServiceProvider);

  try {
    final family = await service.getUserFamily(userId);
    if (family == null) {
      return FamilyData(family: null);
    }

    final members = await service.getFamilyMembers(family.id);
    final challenges = await service.getFamilyChallenges(family.id);

    return FamilyData(family: family, members: members, challenges: challenges);
  } catch (e) {
    return FamilyData(error: e.toString());
  }
});

/// Provider to create a new family
final createFamilyProvider =
    FutureProvider.family<
      Family?,
      (String, String, String, String, SubscriptionPlan)
    >((ref, params) async {
      final (userId, userName, familyName, email, plan) = params;
      final service = ref.read(familyAwServiceProvider);

      final familyId = await service.createFamily(
        adminId: userId,
        adminName: userName,
        familyName: familyName,
        plan: plan,
      );

      return await service.getFamily(familyId);
    });

/// Provider to send family invitation
final sendInvitationProvider =
    FutureProvider.family<
      void,
      (String, String, String, String, String, String)
    >((ref, params) async {
      final (
        familyId,
        familyName,
        inviterId,
        inviterName,
        inviteeEmail,
        userEmail,
      ) = params;
      final service = ref.read(familyAwServiceProvider);

      await service.sendInvitation(
        familyId: familyId,
        familyName: familyName,
        inviterId: inviterId,
        inviterName: inviterName,
        inviteeEmail: inviteeEmail,
      );
    });

/// Provider to accept invitation
final acceptInvitationProvider =
    FutureProvider.family<Family?, (String, String, String, String, String)>((
      ref,
      params,
    ) async {
      final (invitationId, familyId, userId, userName, userEmail) = params;
      final service = ref.read(familyAwServiceProvider);

      await service.acceptInvitation(
        invitationId: invitationId,
        familyId: familyId,
        userId: userId,
        userName: userName,
        userEmail: userEmail,
      );

      return await service.getUserFamily(userId);
    });

/// Provider to join a challenge
final joinChallengeProvider =
    FutureProvider.family<void, (String, String, String, String, String, int)>((
      ref,
      params,
    ) async {
      final (
        challengeId,
        familyId,
        userId,
        userName,
        userAvatarUrl,
        targetValue,
      ) = params;
      final service = ref.read(familyAwServiceProvider);

      await service.joinChallenge(
        challengeId: challengeId,
        familyId: familyId,
        userId: userId,
        userName: userName,
        userAvatarUrl: userAvatarUrl,
        targetValue: targetValue,
      );
    });

/// Provider to remove a member
final removeMemberProvider = FutureProvider.family<void, (String, String)>((
  ref,
  params,
) async {
  final (memberId, familyId) = params;
  final service = ref.read(familyAwServiceProvider);

  await service.removeMember(memberId, familyId);
});

/// Provider to upgrade to family plan
final upgradeToFamilyPlanProvider =
    FutureProvider.family<Family?, (String, String)>((ref, params) async {
      final (familyId, adminId) = params;
      final service = ref.read(familyAwServiceProvider);

      await service.upgradeToFamilyPlan(familyId, adminId);
      return await service.getFamily(familyId);
    });
