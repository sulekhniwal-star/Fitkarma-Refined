// lib/features/social/data/social_providers.dart
// Riverpod providers for Social features

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'social_models.dart';
import 'social_aw_service.dart';

// ================== SERVICE PROVIDERS ==================

/// Provider for the social Appwrite service
final socialAwServiceProvider = Provider<SocialAwService>((ref) {
  return SocialAwService();
});

/// Provider for the follow service
final followAwServiceProvider = Provider<FollowAwService>((ref) {
  return FollowAwService();
});

/// Provider for the groups service
final groupsAwServiceProvider = Provider<GroupsAwService>((ref) {
  return GroupsAwService();
});

/// Provider for the group challenges service
final groupChallengesAwServiceProvider = Provider<GroupChallengesAwService>((
  ref,
) {
  return GroupChallengesAwService();
});

/// Provider for the DM service
final dmAwServiceProvider = Provider<DmAwService>((ref) {
  return DmAwService();
});

/// Provider for the festival leaderboard service
final festivalLeaderboardAwServiceProvider =
    Provider<FestivalLeaderboardAwService>((ref) {
      return FestivalLeaderboardAwService();
    });

// ================== POSTS PROVIDERS ==================

/// Provider for social feed posts
final socialFeedProvider = FutureProvider.family<List<SocialPost>, String>((
  ref,
  userId,
) async {
  final service = ref.watch(socialAwServiceProvider);
  return service.getFeed(userId: userId);
});

/// Provider for user's posts
final userPostsProvider = FutureProvider.family<List<SocialPost>, String>((
  ref,
  userId,
) async {
  final service = ref.watch(socialAwServiceProvider);
  return service.getUserPosts(userId);
});

/// Provider for post comments
final postCommentsProvider = FutureProvider.family<List<PostComment>, String>((
  ref,
  postId,
) async {
  final service = ref.watch(socialAwServiceProvider);
  return service.getComments(postId);
});

// ================== FOLLOW PROVIDERS ==================

/// Provider for user's followers
final userFollowersProvider = FutureProvider.family<List<UserFollow>, String>((
  ref,
  userId,
) async {
  final service = ref.watch(followAwServiceProvider);
  return service.getFollowers(userId);
});

/// Provider for user's following
final userFollowingProvider = FutureProvider.family<List<UserFollow>, String>((
  ref,
  userId,
) async {
  final service = ref.watch(followAwServiceProvider);
  return service.getFollowing(userId);
});

/// Provider for follow status
final isFollowingProvider = FutureProvider.family<bool, (String, String)>((
  ref,
  params,
) async {
  final (followerId, followingId) = params;
  final service = ref.watch(followAwServiceProvider);
  return service.isFollowing(followerId, followingId);
});

/// Provider for follow counts
final followCountsProvider = FutureProvider.family<(int, int), String>((
  ref,
  userId,
) async {
  final service = ref.watch(followAwServiceProvider);
  return service.getFollowCounts(userId);
});

// ================== GROUPS PROVIDERS ==================

/// Provider for all groups
final allGroupsProvider = FutureProvider<List<CommunityGroup>>((ref) async {
  final service = ref.watch(groupsAwServiceProvider);
  return service.getGroups();
});

/// Provider for groups by type
final groupsByTypeProvider =
    FutureProvider.family<List<CommunityGroup>, GroupType>((ref, type) async {
      final service = ref.watch(groupsAwServiceProvider);
      return service.getGroupsByType(type);
    });

/// Provider for user's joined groups
final joinedGroupsProvider =
    FutureProvider.family<List<CommunityGroup>, String>((ref, userId) async {
      final service = ref.watch(groupsAwServiceProvider);
      return service.getJoinedGroups(userId);
    });

/// Provider for single group
final groupProvider = FutureProvider.family<CommunityGroup?, String>((
  ref,
  groupId,
) async {
  final service = ref.watch(groupsAwServiceProvider);
  return service.getGroup(groupId);
});

/// Provider for group membership status
final isGroupMemberProvider = FutureProvider.family<bool, (String, String)>((
  ref,
  params,
) async {
  final (groupId, userId) = params;
  final service = ref.watch(groupsAwServiceProvider);
  return service.isGroupMember(groupId, userId);
});

// ================== GROUP CHALLENGES PROVIDERS ==================

/// Provider for group challenges
final groupChallengesProvider =
    FutureProvider.family<List<GroupChallenge>, String>((ref, groupId) async {
      final service = ref.watch(groupChallengesAwServiceProvider);
      return service.getGroupChallenges(groupId);
    });

/// Provider for challenge leaderboard
final challengeLeaderboardProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>((
      ref,
      challengeId,
    ) async {
      final service = ref.watch(groupChallengesAwServiceProvider);
      return service.getChallengeLeaderboard(challengeId);
    });

// ================== DM PROVIDERS ==================

/// Provider for user's conversations
final dmConversationsProvider =
    FutureProvider.family<List<DMConversation>, String>((ref, userId) async {
      final service = ref.watch(dmAwServiceProvider);
      return service.getConversations(userId);
    });

/// Provider for messages in a conversation
final dmMessagesProvider = FutureProvider.family<List<DirectMessage>, String>((
  ref,
  conversationId,
) async {
  final service = ref.watch(dmAwServiceProvider);
  return service.getMessages(conversationId);
});

// ================== FESTIVAL LEADERBOARD PROVIDERS ==================

/// Provider for active festivals
final activeFestivalsProvider = FutureProvider<List<FestivalInfo>>((ref) async {
  final service = ref.watch(festivalLeaderboardAwServiceProvider);
  return service.getActiveFestivals();
});

/// Provider for festival leaderboard
final festivalLeaderboardProvider =
    FutureProvider.family<List<FestivalLeaderboardEntry>, String>((
      ref,
      festivalId,
    ) async {
      final service = ref.watch(festivalLeaderboardAwServiceProvider);
      return service.getFestivalLeaderboard(festivalId);
    });

/// Provider for user's festival rank
final userFestivalRankProvider = FutureProvider.family<int?, (String, String)>((
  ref,
  params,
) async {
  final (festivalId, userId) = params;
  final service = ref.watch(festivalLeaderboardAwServiceProvider);
  return service.getUserRank(festivalId, userId);
});
