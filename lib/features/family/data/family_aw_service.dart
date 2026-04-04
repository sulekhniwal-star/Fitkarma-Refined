import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:fitkarma/core/network/appwrite_client.dart';
import 'package:fitkarma/core/constants/api_endpoints.dart';
import 'package:fitkarma/features/family/data/family_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyAwService {
  final Teams _teams;
  final Functions _functions;

  FamilyAwService(Client client)
      : _teams = Teams(client),
        _functions = Functions(client);

  /// Create a new family group (Team in Appwrite)
  Future<models.Team> createFamilyGroup(String name) async {
    return await _teams.create(
      teamId: ID.unique(),
      name: name,
    );
  }

  /// Invite a member to the family group by email
  Future<models.Membership> inviteMember({
    required String teamId,
    required String email,
    String? name,
    List<String> roles = const ['member'],
  }) async {
    return await _teams.createMembership(
      teamId: teamId,
      email: email,
      roles: roles,
      url: 'https://fitkarma.app/verify/family-invite', // Redirection URL
      name: name,
    );
  }

  /// Fetch all family groups (Teams) the user belongs to
  Future<List<models.Team>> getFamilyGroups() async {
    final result = await _teams.list();
    return result.teams;
  }

  /// Fetch members of a specific family group
  Future<List<models.Membership>> getMembers(String teamId) async {
    final result = await _teams.listMemberships(teamId: teamId);
    return result.memberships;
  }

  /// Remove a member from the family group
  Future<void> removeMember(String teamId, String membershipId) async {
    await _teams.deleteMembership(teamId: teamId, membershipId: membershipId);
  }

  /// Fetch summary for a specific member (view-only admin access)
  /// This would likely call a server-side function or query a shared collection
  Future<FamilyMemberSummary> getMemberSummary(String userId) async {
    // Mocking for now — in production, this calls a secure Appwrite Function
    // that aggregates data from the member's private collections.
    await Future.delayed(const Duration(milliseconds: 500));
    return FamilyMemberSummary(
      userId: userId,
      name: 'Member Name',
      weeklySteps: 45000,
      currentStepStreak: 5,
      waterIntakeLiters: 2.1,
      weightChangeKg: -0.5,
      workoutsCompleted: 3,
      karmaXp: 1250,
    );
  }

  /// Fetch family challenges from the database
  Future<List<FamilyChallenge>> getChallenges(String teamId) async {
    // Placeholder — in production, this queries the 'challenges' collection
    // filtered by teamId.
    return [
      FamilyChallenge(
        id: 'step_7day_1',
        title: '7-Day Step Marathon',
        description: 'Complete 10,000 steps daily for 7 days.',
        type: FamilyChallengeType.steps,
        target: 70000,
        startDate: DateTime.now().subtract(const Duration(days: 2)),
        endDate: DateTime.now().add(const Duration(days: 5)),
        participantScores: {
          'me': 24000,
          'user_2': 18000,
          'user_3': 32000,
        },
      ),
      FamilyChallenge(
        id: 'water_7day_1',
        title: 'Hydration Hero',
        description: 'Drink 2.5L of water daily.',
        type: FamilyChallengeType.water,
        target: 17.5, // 2.5L * 7 days
        startDate: DateTime.now().add(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 8)),
        participantScores: {},
      ),
    ];
  }

  /// Trigger a group push notification via Appwrite Function
  Future<void> sendGroupNotification({
    required String teamId,
    required String title,
    required String body,
  }) async {
    await _functions.createExecution(
      functionId: AW.fnCoreServices,
      body: '{"action": "send_family_notification", "teamId": "$teamId", "title": "$title", "body": "$body"}',
    );
  }
}

final familyAwServiceProvider = Provider<FamilyAwService>((ref) {
  final client = AppwriteClient.instance.client;
  return FamilyAwService(client);
});
