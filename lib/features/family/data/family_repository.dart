import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/family/data/family_aw_service.dart';
import 'package:fitkarma/features/family/data/family_models.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';

class FamilyState {
  final Future<FamilyGroup?> familyGroup;
  final List<FamilyChallenge> challenges;
  final bool isLoading;
  final String? error;

  const FamilyState({
    required this.familyGroup,
    this.challenges = const [],
    this.isLoading = false,
    this.error,
  });

  FamilyState copyWith({
    Future<FamilyGroup?>? familyGroup,
    List<FamilyChallenge>? challenges,
    bool? isLoading,
    String? error,
  }) {
    return FamilyState(
      familyGroup: familyGroup ?? this.familyGroup,
      challenges: challenges ?? this.challenges,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class FamilyRepository extends Notifier<FamilyState> {
  late final FamilyAwService _service;

  @override
  FamilyState build() {
    _service = ref.read(familyAwServiceProvider);
    return FamilyState(
      familyGroup: _loadFamilyGroup(),
      challenges: [],
    );
  }

  Future<FamilyGroup?> _loadFamilyGroup() async {
    try {
      final user = await ref.read(currentUserProvider.future);
      if (user == null) return null;

      final groups = await _service.getFamilyGroups();
      if (groups.isEmpty) return null;

      // For simplicity, take the first family group
      final team = groups.first;
      final memberships = await _service.getMembers(team.$id);

      final members = memberships.map((m) {
        return FamilyMember(
          userId: m.userId,
          name: m.userName,
          role: m.roles.contains('admin') ? FamilyRole.admin : FamilyRole.member,
          isMe: m.userId == user.$id,
        );
      }).toList();

      final challenges = await _service.getChallenges(team.$id);
      state = state.copyWith(challenges: challenges);

      return FamilyGroup(
        id: team.$id,
        name: team.name,
        adminUserId: members.firstWhere((m) => m.role == FamilyRole.admin).userId,
        members: members,
        createdAt: DateTime.parse(team.$createdAt),
      );
    } catch (e) {
      state = state.copyWith(error: 'Failed to load family: $e');
      return null;
    }
  }

  Future<void> inviteMember(String email, {String? name}) async {
    state = state.copyWith(isLoading: true);
    try {
      final group = await state.familyGroup;
      if (group == null) {
        // Create a family group first if it doesn't exist
        final newTeam = await _service.createFamilyGroup('My Family');
        await _service.inviteMember(teamId: newTeam.$id, email: email, name: name);
        refresh();
      } else {
        await _service.inviteMember(teamId: group.id, email: email, name: name);
        // We'll trust Appwrite to handle invitation list for now
        // Refetching would be cleaner but let's assume it's sent.
      }
    } catch (e) {
      state = state.copyWith(error: 'Failed to send invitation: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<FamilyMemberSummary> getMemberSummary(String userId) async {
    return await _service.getMemberSummary(userId);
  }

  Future<void> sendGroupMessage(String title, String body) async {
    final group = await state.familyGroup;
    if (group != null) {
      await _service.sendGroupNotification(teamId: group.id, title: title, body: body);
    }
  }

  void refresh() {
    state = state.copyWith(familyGroup: _loadFamilyGroup());
  }
}

final familyRepositoryProvider = NotifierProvider<FamilyRepository, FamilyState>(() {
  return FamilyRepository();
});
