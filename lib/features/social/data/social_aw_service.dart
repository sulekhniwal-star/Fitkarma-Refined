// lib/features/social/data/social_aw_service.dart
// Appwrite service for Social features

import 'package:flutter/foundation.dart';
import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:fitkarma/core/network/appwrite_client.dart'
    show AppwriteClient, client;
import 'social_models.dart';

/// Collection IDs for social features
class SocialCollectionIds {
  static const String posts = 'social_posts';
  static const String comments = 'social_comments';
  static const String likes = 'social_likes';
  static const String follows = 'social_follows';
  static const String groups = 'community_groups';
  static const String groupMembers = 'group_members';
  static const String groupChallenges = 'group_challenges';
  static const String challengeParticipants = 'challenge_participants';
  static const String conversations = 'dm_conversations';
  static const String messages = 'dm_messages';
  static const String festivalLeaderboards = 'festival_leaderboards';
  static const String userProfiles =
      'user_profiles'; // Extended with verified badge
  static const String databaseId = 'fitkarma';
}

/// Appwrite service for social features
class SocialAwService {
  appwrite.Databases get _databases => AppwriteClient.databases;
  appwrite.Realtime get _realtime => AppwriteClient.realtime;

  // ================== POSTS ==================

  /// Create a new social post
  Future<String> createPost({
    required String userId,
    required PostType type,
    required String content,
    String? imageUrl,
    String? workoutLogId,
    String? foodLogId,
    String? milestoneType,
    int? milestoneValue,
  }) async {
    try {
      final id = SocialIdGenerator.postId();
      final now = DateTime.now().toIso8601String();

      await _databases.createDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.posts,
        documentId: id,
        data: {
          'id': id,
          'userId': userId,
          'type': type.name,
          'content': content,
          'imageUrl': imageUrl,
          'workoutLogId': workoutLogId,
          'foodLogId': foodLogId,
          'milestoneType': milestoneType,
          'milestoneValue': milestoneValue,
          'likesCount': 0,
          'commentsCount': 0,
          'createdAt': now,
          'updatedAt': now,
        },
        permissions: [
          appwrite.Permission.read(appwrite.Role.users()),
          appwrite.Permission.write(appwrite.Role.user(userId)),
        ],
      );

      return id;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Create post failed: ${e.message}');
      rethrow;
    }
  }

  /// Get feed posts (from followed users + public)
  Future<List<SocialPost>> getFeed({
    required String userId,
    int limit = 20,
    String? cursor,
  }) async {
    try {
      final queries = [
        appwrite.Query.orderDesc('createdAt'),
        appwrite.Query.limit(limit),
      ];
      if (cursor != null) {
        queries.add(appwrite.Query.cursorAfter(cursor));
      }

      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.posts,
        queries: queries,
      );

      final posts = <SocialPost>[];
      for (final doc in response.documents) {
        final userProfile = await _getUserProfile(doc.data['userId'] as String);
        posts.add(
          SocialPost(
            id: doc.$id,
            userId: doc.data['userId'] as String,
            userName: userProfile?.name ?? 'Unknown',
            userAvatarUrl: userProfile?.avatarUrl,
            isVerified: userProfile?.isVerified ?? false,
            type: PostType.values.firstWhere(
              (e) => e.name == doc.data['type'],
              orElse: () => PostType.general,
            ),
            content: doc.data['content'] as String? ?? '',
            imageUrl: doc.data['imageUrl'] as String?,
            workoutLogId: doc.data['workoutLogId'] as String?,
            foodLogId: doc.data['foodLogId'] as String?,
            likesCount: doc.data['likesCount'] as int? ?? 0,
            commentsCount: doc.data['commentsCount'] as int? ?? 0,
            createdAt: DateTime.parse(doc.data['createdAt'] as String),
            milestoneType: doc.data['milestoneType'] as String?,
            milestoneValue: doc.data['milestoneValue'] as int?,
          ),
        );
      }

      // Filter: only posts from followed users or public
      final followService = FollowAwService();
      final following = await followService.getFollowing(userId);
      final followingIds = following.map((f) => f.followingId).toSet();

      return posts
          .where(
            (p) =>
                p.userId == userId || // Own posts
                followingIds.contains(p.userId) || // Following
                true, // Public posts (for now show all)
          )
          .toList();
    } catch (e) {
      debugPrint('Get feed failed: $e');
      return [];
    }
  }

  /// Get user's own posts
  Future<List<SocialPost>> getUserPosts(String userId, {int limit = 20}) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.posts,
        queries: [
          appwrite.Query.equal('userId', userId),
          appwrite.Query.orderDesc('createdAt'),
          appwrite.Query.limit(limit),
        ],
      );

      final posts = <SocialPost>[];
      for (final doc in response.documents) {
        final userProfile = await _getUserProfile(doc.data['userId'] as String);
        posts.add(
          SocialPost(
            id: doc.$id,
            userId: doc.data['userId'] as String,
            userName: userProfile?.name ?? 'Unknown',
            userAvatarUrl: userProfile?.avatarUrl,
            isVerified: userProfile?.isVerified ?? false,
            type: PostType.values.firstWhere(
              (e) => e.name == doc.data['type'],
              orElse: () => PostType.general,
            ),
            content: doc.data['content'] as String? ?? '',
            imageUrl: doc.data['imageUrl'] as String?,
            likesCount: doc.data['likesCount'] as int? ?? 0,
            commentsCount: doc.data['commentsCount'] as int? ?? 0,
            createdAt: DateTime.parse(doc.data['createdAt'] as String),
          ),
        );
      }
      return posts;
    } catch (e) {
      debugPrint('Get user posts failed: $e');
      return [];
    }
  }

  /// Delete a post
  Future<void> deletePost(String postId, String userId) async {
    try {
      await _databases.deleteDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.posts,
        documentId: postId,
      );
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Delete post failed: ${e.message}');
      rethrow;
    }
  }

  // ================== LIKES ==================

  /// Like a post
  Future<void> likePost(String postId, String userId) async {
    try {
      final id = SocialIdGenerator.likeId();

      await _databases.createDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.likes,
        documentId: id,
        data: {
          'id': id,
          'postId': postId,
          'userId': userId,
          'createdAt': DateTime.now().toIso8601String(),
        },
        permissions: [
          appwrite.Permission.read(appwrite.Role.users()),
          appwrite.Permission.write(appwrite.Role.user(userId)),
        ],
      );

      // Update post likes count
      await _incrementPostLikesCount(postId);
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Like post failed: ${e.message}');
      rethrow;
    }
  }

  /// Unlike a post
  Future<void> unlikePost(String postId, String userId) async {
    try {
      // Find the like
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.likes,
        queries: [
          appwrite.Query.equal('postId', postId),
          appwrite.Query.equal('userId', userId),
        ],
      );

      if (response.documents.isNotEmpty) {
        await _databases.deleteDocument(
          databaseId: SocialCollectionIds.databaseId,
          collectionId: SocialCollectionIds.likes,
          documentId: response.documents.first.$id,
        );

        // Update post likes count
        await _decrementPostLikesCount(postId);
      }
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Unlike post failed: ${e.message}');
      rethrow;
    }
  }

  /// Check if user liked a post
  Future<bool> isPostLiked(String postId, String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.likes,
        queries: [
          appwrite.Query.equal('postId', postId),
          appwrite.Query.equal('userId', userId),
        ],
      );
      return response.documents.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> _incrementPostLikesCount(String postId) async {
    try {
      final doc = await _databases.getDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.posts,
        documentId: postId,
      );
      final currentCount = doc.data['likesCount'] as int? ?? 0;
      await _databases.updateDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.posts,
        documentId: postId,
        data: {'likesCount': currentCount + 1},
      );
    } catch (e) {
      debugPrint('Increment likes failed: $e');
    }
  }

  Future<void> _decrementPostLikesCount(String postId) async {
    try {
      final doc = await _databases.getDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.posts,
        documentId: postId,
      );
      final currentCount = doc.data['likesCount'] as int? ?? 0;
      await _databases.updateDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.posts,
        documentId: postId,
        data: {'likesCount': currentCount > 0 ? currentCount - 1 : 0},
      );
    } catch (e) {
      debugPrint('Decrement likes failed: $e');
    }
  }

  // ================== COMMENTS ==================

  /// Add comment to a post
  Future<String> addComment({
    required String postId,
    required String userId,
    required String content,
  }) async {
    try {
      final id = SocialIdGenerator.commentId();
      final now = DateTime.now().toIso8601String();

      await _databases.createDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.comments,
        documentId: id,
        data: {
          'id': id,
          'postId': postId,
          'userId': userId,
          'content': content,
          'createdAt': now,
        },
        permissions: [
          appwrite.Permission.read(appwrite.Role.users()),
          appwrite.Permission.write(appwrite.Role.user(userId)),
        ],
      );

      // Update post comments count
      await _incrementPostCommentsCount(postId);

      return id;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Add comment failed: ${e.message}');
      rethrow;
    }
  }

  /// Get comments for a post
  Future<List<PostComment>> getComments(String postId, {int limit = 50}) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.comments,
        queries: [
          appwrite.Query.equal('postId', postId),
          appwrite.Query.orderDesc('createdAt'),
          appwrite.Query.limit(limit),
        ],
      );

      final comments = <PostComment>[];
      for (final doc in response.documents) {
        final userProfile = await _getUserProfile(doc.data['userId'] as String);
        comments.add(
          PostComment(
            id: doc.$id,
            postId: doc.data['postId'] as String,
            userId: doc.data['userId'] as String,
            userName: userProfile?.name ?? 'Unknown',
            userAvatarUrl: userProfile?.avatarUrl,
            isVerified: userProfile?.isVerified ?? false,
            content: doc.data['content'] as String? ?? '',
            createdAt: DateTime.parse(doc.data['createdAt'] as String),
          ),
        );
      }
      return comments;
    } catch (e) {
      debugPrint('Get comments failed: $e');
      return [];
    }
  }

  /// Delete comment
  Future<void> deleteComment(String commentId, String postId) async {
    try {
      await _databases.deleteDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.comments,
        documentId: commentId,
      );

      // Update post comments count
      await _decrementPostCommentsCount(postId);
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Delete comment failed: ${e.message}');
      rethrow;
    }
  }

  Future<void> _incrementPostCommentsCount(String postId) async {
    try {
      final doc = await _databases.getDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.posts,
        documentId: postId,
      );
      final currentCount = doc.data['commentsCount'] as int? ?? 0;
      await _databases.updateDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.posts,
        documentId: postId,
        data: {'commentsCount': currentCount + 1},
      );
    } catch (e) {
      debugPrint('Increment comments failed: $e');
    }
  }

  Future<void> _decrementPostCommentsCount(String postId) async {
    try {
      final doc = await _databases.getDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.posts,
        documentId: postId,
      );
      final currentCount = doc.data['commentsCount'] as int? ?? 0;
      await _databases.updateDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.posts,
        documentId: postId,
        data: {'commentsCount': currentCount > 0 ? currentCount - 1 : 0},
      );
    } catch (e) {
      debugPrint('Decrement comments failed: $e');
    }
  }

  // ================== HELPERS ==================

  /// Get user profile for display
  Future<SocialUserProfile?> _getUserProfile(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.userProfiles,
        queries: [
          appwrite.Query.equal('userId', userId),
          appwrite.Query.limit(1),
        ],
      );

      if (response.documents.isEmpty) return null;

      final doc = response.documents.first;
      return SocialUserProfile(
        userId: doc.data['userId'] as String? ?? userId,
        name: doc.data['name'] as String? ?? 'Unknown',
        avatarUrl: doc.data['avatarUrl'] as String?,
        isVerified: doc.data['isVerified'] as bool? ?? false,
        profession: doc.data['profession'] as String?,
        followersCount: doc.data['followersCount'] as int? ?? 0,
        followingCount: doc.data['followingCount'] as int? ?? 0,
        postsCount: doc.data['postsCount'] as int? ?? 0,
      );
    } catch (e) {
      return null;
    }
  }
}

/// Follow service
class FollowAwService {
  appwrite.Databases get _databases => AppwriteClient.databases;

  /// Follow a user
  Future<void> followUser(String followerId, String followingId) async {
    try {
      final id = SocialIdGenerator.followId();

      await _databases.createDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.follows,
        documentId: id,
        data: {
          'id': id,
          'followerId': followerId,
          'followingId': followingId,
          'createdAt': DateTime.now().toIso8601String(),
        },
        permissions: [
          appwrite.Permission.read(appwrite.Role.users()),
          appwrite.Permission.write(appwrite.Role.user(followerId)),
        ],
      );

      // Update follower/following counts
      await _updateFollowCounts(followerId, followingId);
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Follow user failed: ${e.message}');
      rethrow;
    }
  }

  /// Unfollow a user
  Future<void> unfollowUser(String followerId, String followingId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.follows,
        queries: [
          appwrite.Query.equal('followerId', followerId),
          appwrite.Query.equal('followingId', followingId),
        ],
      );

      if (response.documents.isNotEmpty) {
        await _databases.deleteDocument(
          databaseId: SocialCollectionIds.databaseId,
          collectionId: SocialCollectionIds.follows,
          documentId: response.documents.first.$id,
        );

        // Update follower/following counts
        await _updateFollowCounts(followerId, followingId, isUnfollow: true);
      }
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Unfollow user failed: ${e.message}');
      rethrow;
    }
  }

  /// Get followers for a user
  Future<List<UserFollow>> getFollowers(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.follows,
        queries: [appwrite.Query.equal('followingId', userId)],
      );

      return response.documents
          .map((doc) => UserFollow.fromMap({'id': doc.$id, ...doc.data}))
          .toList();
    } catch (e) {
      debugPrint('Get followers failed: $e');
      return [];
    }
  }

  /// Get following for a user
  Future<List<UserFollow>> getFollowing(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.follows,
        queries: [appwrite.Query.equal('followerId', userId)],
      );

      return response.documents
          .map((doc) => UserFollow.fromMap({'id': doc.$id, ...doc.data}))
          .toList();
    } catch (e) {
      debugPrint('Get following failed: $e');
      return [];
    }
  }

  /// Check if following
  Future<bool> isFollowing(String followerId, String followingId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.follows,
        queries: [
          appwrite.Query.equal('followerId', followerId),
          appwrite.Query.equal('followingId', followingId),
        ],
      );
      return response.documents.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Get follower/following count
  Future<(int followers, int following)> getFollowCounts(String userId) async {
    try {
      final followers = await getFollowers(userId);
      final following = await getFollowing(userId);
      return (followers.length, following.length);
    } catch (e) {
      return (0, 0);
    }
  }

  Future<void> _updateFollowCounts(
    String followerId,
    String followingId, {
    bool isUnfollow = false,
  }) async {
    try {
      final delta = isUnfollow ? -1 : 1;

      // Update follower's following count
      final followerProfile = await _getProfileWithRetry(followerId);
      if (followerProfile != null) {
        final followingCount = followerProfile['followingCount'] as int? ?? 0;
        await _updateProfileCount(
          followerId,
          'followingCount',
          followingCount + delta,
        );
      }

      // Update following's follower count
      final followingProfile = await _getProfileWithRetry(followingId);
      if (followingProfile != null) {
        final followersCount = followingProfile['followersCount'] as int? ?? 0;
        await _updateProfileCount(
          followingId,
          'followersCount',
          followersCount + delta,
        );
      }
    } catch (e) {
      debugPrint('Update follow counts failed: $e');
    }
  }

  Future<Map<String, dynamic>?> _getProfileWithRetry(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.userProfiles,
        queries: [
          appwrite.Query.equal('userId', userId),
          appwrite.Query.limit(1),
        ],
      );
      if (response.documents.isEmpty) return null;
      return response.documents.first.data;
    } catch (e) {
      return null;
    }
  }

  Future<void> _updateProfileCount(
    String userId,
    String field,
    int count,
  ) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.userProfiles,
        queries: [
          appwrite.Query.equal('userId', userId),
          appwrite.Query.limit(1),
        ],
      );
      if (response.documents.isNotEmpty) {
        await _databases.updateDocument(
          databaseId: SocialCollectionIds.databaseId,
          collectionId: SocialCollectionIds.userProfiles,
          documentId: response.documents.first.$id,
          data: {field: count},
        );
      }
    } catch (e) {
      debugPrint('Update profile count failed: $e');
    }
  }
}

/// Groups service
class GroupsAwService {
  appwrite.Databases get _databases => AppwriteClient.databases;

  /// Create a group
  Future<String> createGroup({
    required String creatorId,
    required String name,
    required String description,
    required GroupType type,
    bool isPrivate = false,
    String? imageUrl,
  }) async {
    try {
      final id = SocialIdGenerator.groupId();

      await _databases.createDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.groups,
        documentId: id,
        data: {
          'id': id,
          'name': name,
          'description': description,
          'type': type.name,
          'creatorId': creatorId,
          'isPrivate': isPrivate,
          'imageUrl': imageUrl,
          'membersCount': 1,
          'createdAt': DateTime.now().toIso8601String(),
        },
        permissions: [
          appwrite.Permission.read(appwrite.Role.users()),
          appwrite.Permission.write(appwrite.Role.user(creatorId)),
        ],
      );

      // Add creator as first member
      await joinGroup(id, creatorId);

      return id;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Create group failed: ${e.message}');
      rethrow;
    }
  }

  /// Get all groups
  Future<List<CommunityGroup>> getGroups({int limit = 50}) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.groups,
        queries: [
          appwrite.Query.orderDesc('membersCount'),
          appwrite.Query.limit(limit),
        ],
      );

      return response.documents
          .map((doc) => CommunityGroup.fromMap(doc.data))
          .toList();
    } catch (e) {
      debugPrint('Get groups failed: $e');
      return [];
    }
  }

  /// Get groups by type
  Future<List<CommunityGroup>> getGroupsByType(
    GroupType type, {
    int limit = 50,
  }) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.groups,
        queries: [
          appwrite.Query.equal('type', type.name),
          appwrite.Query.orderDesc('membersCount'),
          appwrite.Query.limit(limit),
        ],
      );

      return response.documents
          .map((doc) => CommunityGroup.fromMap(doc.data))
          .toList();
    } catch (e) {
      debugPrint('Get groups by type failed: $e');
      return [];
    }
  }

  /// Get user's joined groups
  Future<List<CommunityGroup>> getJoinedGroups(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.groupMembers,
        queries: [appwrite.Query.equal('userId', userId)],
      );

      final groups = <CommunityGroup>[];
      for (final doc in response.documents) {
        final groupId = doc.data['groupId'] as String;
        final group = await getGroup(groupId);
        if (group != null) {
          groups.add(group.copyWith(isJoinedByMe: true));
        }
      }
      return groups;
    } catch (e) {
      debugPrint('Get joined groups failed: $e');
      return [];
    }
  }

  /// Get single group
  Future<CommunityGroup?> getGroup(String groupId) async {
    try {
      final doc = await _databases.getDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.groups,
        documentId: groupId,
      );
      return CommunityGroup.fromMap(doc.data);
    } catch (e) {
      return null;
    }
  }

  /// Join a group
  Future<void> joinGroup(String groupId, String userId) async {
    try {
      final id = 'gm_${groupId}_$userId';

      await _databases.createDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.groupMembers,
        documentId: id,
        data: {
          'id': id,
          'groupId': groupId,
          'userId': userId,
          'joinedAt': DateTime.now().toIso8601String(),
        },
        permissions: [
          appwrite.Permission.read(appwrite.Role.users()),
          appwrite.Permission.write(appwrite.Role.user(userId)),
        ],
      );

      // Increment members count
      await _incrementMembersCount(groupId);
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Join group failed: ${e.message}');
      rethrow;
    }
  }

  /// Leave a group
  Future<void> leaveGroup(String groupId, String userId) async {
    try {
      final id = 'gm_${groupId}_$userId';

      await _databases.deleteDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.groupMembers,
        documentId: id,
      );

      // Decrement members count
      await _decrementMembersCount(groupId);
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Leave group failed: ${e.message}');
      rethrow;
    }
  }

  /// Check if user is member
  Future<bool> isGroupMember(String groupId, String userId) async {
    try {
      final id = 'gm_${groupId}_$userId';
      await _databases.getDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.groupMembers,
        documentId: id,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _incrementMembersCount(String groupId) async {
    try {
      final doc = await _databases.getDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.groups,
        documentId: groupId,
      );
      final currentCount = doc.data['membersCount'] as int? ?? 0;
      await _databases.updateDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.groups,
        documentId: groupId,
        data: {'membersCount': currentCount + 1},
      );
    } catch (e) {
      debugPrint('Increment members failed: $e');
    }
  }

  Future<void> _decrementMembersCount(String groupId) async {
    try {
      final doc = await _databases.getDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.groups,
        documentId: groupId,
      );
      final currentCount = doc.data['membersCount'] as int? ?? 0;
      await _databases.updateDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.groups,
        documentId: groupId,
        data: {'membersCount': currentCount > 0 ? currentCount - 1 : 0},
      );
    } catch (e) {
      debugPrint('Decrement members failed: $e');
    }
  }

  /// Get group posts (feed)
  Future<List<SocialPost>> getGroupPosts(
    String groupId, {
    int limit = 20,
  }) async {
    try {
      // For now, group posts are just regular posts tagged with group
      // In a full implementation, you'd have a separate group_posts collection
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.posts,
        queries: [
          appwrite.Query.equal('groupId', groupId),
          appwrite.Query.orderDesc('createdAt'),
          appwrite.Query.limit(limit),
        ],
      );

      return response.documents
          .map((doc) => SocialPost.fromMap(doc.data))
          .toList();
    } catch (e) {
      debugPrint('Get group posts failed: $e');
      return [];
    }
  }
}

/// Group Challenges service
class GroupChallengesAwService {
  appwrite.Databases get _databases => AppwriteClient.databases;

  /// Create a challenge
  Future<String> createChallenge({
    required String groupId,
    required String creatorId,
    required String title,
    required String description,
    required String challengeType,
    required int targetValue,
    required String targetUnit,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final id = SocialIdGenerator.challengeId();

      await _databases.createDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.groupChallenges,
        documentId: id,
        data: {
          'id': id,
          'groupId': groupId,
          'creatorId': creatorId,
          'title': title,
          'description': description,
          'challengeType': challengeType,
          'targetValue': targetValue,
          'targetUnit': targetUnit,
          'startDate': startDate.toIso8601String(),
          'endDate': endDate.toIso8601String(),
          'participantsCount': 0,
          'createdAt': DateTime.now().toIso8601String(),
        },
        permissions: [
          appwrite.Permission.read(appwrite.Role.users()),
          appwrite.Permission.write(appwrite.Role.user(creatorId)),
        ],
      );

      return id;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Create challenge failed: ${e.message}');
      rethrow;
    }
  }

  /// Get group challenges
  Future<List<GroupChallenge>> getGroupChallenges(String groupId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.groupChallenges,
        queries: [
          appwrite.Query.equal('groupId', groupId),
          appwrite.Query.orderDesc('startDate'),
        ],
      );

      return response.documents
          .map((doc) => GroupChallenge.fromMap(doc.data))
          .toList();
    } catch (e) {
      debugPrint('Get group challenges failed: $e');
      return [];
    }
  }

  /// Join a challenge
  Future<void> joinChallenge(String challengeId, String userId) async {
    try {
      final id = 'cp_${challengeId}_$userId';

      await _databases.createDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.challengeParticipants,
        documentId: id,
        data: {
          'id': id,
          'challengeId': challengeId,
          'userId': userId,
          'progress': 0,
          'joinedAt': DateTime.now().toIso8601String(),
        },
        permissions: [
          appwrite.Permission.read(appwrite.Role.users()),
          appwrite.Permission.write(appwrite.Role.user(userId)),
        ],
      );

      // Increment participants count
      await _incrementParticipantsCount(challengeId);
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Join challenge failed: ${e.message}');
      rethrow;
    }
  }

  /// Update challenge progress
  Future<void> updateProgress(
    String challengeId,
    String userId,
    int progress,
  ) async {
    try {
      final id = 'cp_${challengeId}_$userId';

      await _databases.updateDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.challengeParticipants,
        documentId: id,
        data: {
          'progress': progress,
          'updatedAt': DateTime.now().toIso8601String(),
        },
      );
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Update progress failed: ${e.message}');
      rethrow;
    }
  }

  /// Get challenge leaderboard
  Future<List<Map<String, dynamic>>> getChallengeLeaderboard(
    String challengeId, {
    int limit = 10,
  }) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.challengeParticipants,
        queries: [
          appwrite.Query.equal('challengeId', challengeId),
          appwrite.Query.orderDesc('progress'),
          appwrite.Query.limit(limit),
        ],
      );

      final leaderboard = <Map<String, dynamic>>[];
      for (final doc in response.documents) {
        final userProfile = await _getUserProfile(doc.data['userId'] as String);
        leaderboard.add({
          'userId': doc.data['userId'],
          'userName': userProfile?.name ?? 'Unknown',
          'avatarUrl': userProfile?.avatarUrl,
          'progress': doc.data['progress'],
        });
      }
      return leaderboard;
    } catch (e) {
      debugPrint('Get challenge leaderboard failed: $e');
      return [];
    }
  }

  Future<void> _incrementParticipantsCount(String challengeId) async {
    try {
      final doc = await _databases.getDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.groupChallenges,
        documentId: challengeId,
      );
      final currentCount = doc.data['participantsCount'] as int? ?? 0;
      await _databases.updateDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.groupChallenges,
        documentId: challengeId,
        data: {'participantsCount': currentCount + 1},
      );
    } catch (e) {
      debugPrint('Increment participants failed: $e');
    }
  }

  Future<SocialUserProfile?> _getUserProfile(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.userProfiles,
        queries: [
          appwrite.Query.equal('userId', userId),
          appwrite.Query.limit(1),
        ],
      );
      if (response.documents.isEmpty) return null;
      return SocialUserProfile.fromMap(response.documents.first.data);
    } catch (e) {
      return null;
    }
  }
}

/// Direct Messages service
class DmAwService {
  appwrite.Databases get _databases => AppwriteClient.databases;

  /// Get or create conversation
  Future<String> getOrCreateConversation(String userId1, String userId2) async {
    try {
      // Check if conversation exists
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.conversations,
        queries: [
          appwrite.Query.or([
            appwrite.Query.and([
              appwrite.Query.equal('participant1', userId1),
              appwrite.Query.equal('participant2', userId2),
            ]),
            appwrite.Query.and([
              appwrite.Query.equal('participant1', userId2),
              appwrite.Query.equal('participant2', userId1),
            ]),
          ]),
        ],
      );

      if (response.documents.isNotEmpty) {
        return response.documents.first.$id;
      }

      // Create new conversation
      final id = SocialIdGenerator.conversationId();
      await _databases.createDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.conversations,
        documentId: id,
        data: {
          'id': id,
          'participant1': userId1,
          'participant2': userId2,
          'createdAt': DateTime.now().toIso8601String(),
        },
        permissions: [
          appwrite.Permission.read(appwrite.Role.user(userId1)),
          appwrite.Permission.read(appwrite.Role.user(userId2)),
          appwrite.Permission.write(appwrite.Role.user(userId1)),
          appwrite.Permission.write(appwrite.Role.user(userId2)),
        ],
      );

      return id;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get or create conversation failed: ${e.message}');
      rethrow;
    }
  }

  /// Get user's conversations
  Future<List<DMConversation>> getConversations(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.conversations,
        queries: [
          appwrite.Query.or([
            appwrite.Query.equal('participant1', userId),
            appwrite.Query.equal('participant2', userId),
          ]),
          appwrite.Query.orderDesc('updatedAt'),
        ],
      );

      final conversations = <DMConversation>[];
      for (final doc in response.documents) {
        final participant1 = doc.data['participant1'] as String;
        final participant2 = doc.data['participant2'] as String;
        final otherUserId = participant1 == userId
            ? participant2
            : participant1;
        final otherUser = await _getUserProfile(otherUserId);
        final lastMessage = await _getLastMessage(doc.$id);

        conversations.add(
          DMConversation(
            id: doc.$id,
            participantId: otherUserId,
            participantName: otherUser?.name ?? 'Unknown',
            participantAvatarUrl: otherUser?.avatarUrl,
            isVerified: otherUser?.isVerified ?? false,
            lastMessage: lastMessage?.content,
            lastMessageAt: lastMessage?.createdAt,
            unreadCount: 0, // Would need separate tracking
          ),
        );
      }
      return conversations;
    } catch (e) {
      debugPrint('Get conversations failed: $e');
      return [];
    }
  }

  /// Send a message
  Future<String> sendMessage({
    required String conversationId,
    required String senderId,
    required String content,
  }) async {
    try {
      final id = SocialIdGenerator.messageId();

      await _databases.createDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.messages,
        documentId: id,
        data: {
          'id': id,
          'conversationId': conversationId,
          'senderId': senderId,
          'content': content,
          'isRead': false,
          'createdAt': DateTime.now().toIso8601String(),
        },
        permissions: [
          appwrite.Permission.read(appwrite.Role.users()),
          appwrite.Permission.write(appwrite.Role.user(senderId)),
        ],
      );

      // Update conversation's updatedAt
      await _databases.updateDocument(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.conversations,
        documentId: conversationId,
        data: {'updatedAt': DateTime.now().toIso8601String()},
      );

      return id;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Send message failed: ${e.message}');
      rethrow;
    }
  }

  /// Get messages in a conversation
  Future<List<DirectMessage>> getMessages(
    String conversationId, {
    int limit = 50,
  }) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.messages,
        queries: [
          appwrite.Query.equal('conversationId', conversationId),
          appwrite.Query.orderAsc('createdAt'),
          appwrite.Query.limit(limit),
        ],
      );

      return response.documents
          .map((doc) => DirectMessage.fromMap(doc.data))
          .toList();
    } catch (e) {
      debugPrint('Get messages failed: $e');
      return [];
    }
  }

  /// Mark messages as read
  Future<void> markAsRead(String conversationId, String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.messages,
        queries: [
          appwrite.Query.equal('conversationId', conversationId),
          appwrite.Query.notEqual('senderId', userId),
          appwrite.Query.equal('isRead', false),
        ],
      );

      for (final doc in response.documents) {
        await _databases.updateDocument(
          databaseId: SocialCollectionIds.databaseId,
          collectionId: SocialCollectionIds.messages,
          documentId: doc.$id,
          data: {'isRead': true},
        );
      }
    } catch (e) {
      debugPrint('Mark as read failed: $e');
    }
  }

  Future<DirectMessage?> _getLastMessage(String conversationId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.messages,
        queries: [
          appwrite.Query.equal('conversationId', conversationId),
          appwrite.Query.orderDesc('createdAt'),
          appwrite.Query.limit(1),
        ],
      );
      if (response.documents.isEmpty) return null;
      return DirectMessage.fromMap(response.documents.first.data);
    } catch (e) {
      return null;
    }
  }

  Future<SocialUserProfile?> _getUserProfile(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.userProfiles,
        queries: [
          appwrite.Query.equal('userId', userId),
          appwrite.Query.limit(1),
        ],
      );
      if (response.documents.isEmpty) return null;
      return SocialUserProfile.fromMap(response.documents.first.data);
    } catch (e) {
      return null;
    }
  }
}

/// Festival Leaderboard service
class FestivalLeaderboardAwService {
  appwrite.Databases get _databases => AppwriteClient.databases;

  /// Get active festival leaderboards
  Future<List<FestivalInfo>> getActiveFestivals() async {
    try {
      final nowStr = DateTime.now().toIso8601String();

      // For now, just get all festivals and filter in Dart
      // In production, you'd use Appwrite's query syntax
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId:
            'festival_calendar', // Would need to create this collection
        queries: [appwrite.Query.limit(50)],
      );

      // Filter active festivals
      final now = DateTime.now();
      final festivals = response.documents
          .map((doc) => FestivalInfo.fromMap(doc.data))
          .where((f) => f.isActive)
          .toList();

      // If no active festivals, return defaults
      if (festivals.isEmpty) {
        return _getDefaultIndianFestivals().where((f) => f.isActive).toList();
      }

      return festivals;
    } catch (e) {
      debugPrint('Get active festivals failed: $e');
      return _getDefaultIndianFestivals();
    }
  }

  /// Get festival leaderboard
  Future<List<FestivalLeaderboardEntry>> getFestivalLeaderboard(
    String festivalId, {
    int limit = 10,
  }) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.festivalLeaderboards,
        queries: [
          appwrite.Query.equal('festivalId', festivalId),
          appwrite.Query.orderDesc('score'),
          appwrite.Query.limit(limit),
        ],
      );

      return response.documents.asMap().entries.map((entry) {
        final doc = entry.value;
        final rank = entry.key + 1;
        return FestivalLeaderboardEntry(
          oderId: doc.data['userId'] as String,
          userName: doc.data['userName'] as String? ?? 'Unknown',
          avatarUrl: doc.data['avatarUrl'] as String?,
          isVerified: doc.data['isVerified'] as bool? ?? false,
          rank: rank,
          score: doc.data['score'] as int? ?? 0,
        );
      }).toList();
    } catch (e) {
      debugPrint('Get festival leaderboard failed: $e');
      return [];
    }
  }

  /// Update user's festival score
  Future<void> updateScore({
    required String festivalId,
    required String userId,
    required int score,
  }) async {
    try {
      // Try to find existing entry
      final existing = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.festivalLeaderboards,
        queries: [
          appwrite.Query.equal('festivalId', festivalId),
          appwrite.Query.equal('userId', userId),
        ],
      );

      if (existing.documents.isNotEmpty) {
        // Update existing
        await _databases.updateDocument(
          databaseId: SocialCollectionIds.databaseId,
          collectionId: SocialCollectionIds.festivalLeaderboards,
          documentId: existing.documents.first.$id,
          data: {'score': score},
        );
      } else {
        // Create new entry
        final id = SocialIdGenerator.festivalLeaderboardId();
        final userProfile = await _getUserProfile(userId);

        await _databases.createDocument(
          databaseId: SocialCollectionIds.databaseId,
          collectionId: SocialCollectionIds.festivalLeaderboards,
          documentId: id,
          data: {
            'id': id,
            'festivalId': festivalId,
            'userId': userId,
            'userName': userProfile?.name ?? 'Unknown',
            'avatarUrl': userProfile?.avatarUrl,
            'isVerified': userProfile?.isVerified ?? false,
            'score': score,
            'updatedAt': DateTime.now().toIso8601String(),
          },
          permissions: [
            appwrite.Permission.read(appwrite.Role.users()),
            appwrite.Permission.write(appwrite.Role.user(userId)),
          ],
        );
      }
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Update festival score failed: ${e.message}');
    }
  }

  /// Get user's rank in festival
  Future<int?> getUserRank(String festivalId, String userId) async {
    try {
      final leaderboard = await getFestivalLeaderboard(festivalId, limit: 1000);
      final index = leaderboard.indexWhere((e) => e.oderId == userId);
      return index >= 0 ? index + 1 : null;
    } catch (e) {
      return null;
    }
  }

  /// Default Indian festivals for seasonal leaderboards
  List<FestivalInfo> _getDefaultIndianFestivals() {
    final now = DateTime.now();
    final year = now.year;

    return [
      // Navratri (typically October)
      FestivalInfo(
        id: 'navratri_$year',
        name: 'Navratri Wellness Challenge',
        startDate: DateTime(year, 10, 1),
        endDate: DateTime(year, 10, 10),
        description: '9 days of wellness - yoga, fasting, and devotion',
        leaderboardType: 'steps',
        targetValue: 90000, // 10k steps per day
      ),
      // Diwali (typically November)
      FestivalInfo(
        id: 'diwali_$year',
        name: 'Diwali Step Challenge',
        startDate: DateTime(year, 11, 1),
        endDate: DateTime(year, 11, 5),
        description: 'Light up your health this Diwali',
        leaderboardType: 'steps',
        targetValue: 50000,
      ),
      // Holi (typically March)
      FestivalInfo(
        id: 'holi_$year',
        name: 'Holi Fitness Challenge',
        startDate: DateTime(year, 3, 1),
        endDate: DateTime(year, 3, 31),
        description: 'Active Holi - stay fit while celebrating',
        leaderboardType: 'workout',
        targetValue: 10, // 10 workouts
      ),
      // Independence Day
      FestivalInfo(
        id: 'independence_$year',
        name: 'Independence Day Fitness',
        startDate: DateTime(year, 8, 10),
        endDate: DateTime(year, 8, 15),
        description: '15 days of freedom - 15k steps daily',
        leaderboardType: 'steps',
        targetValue: 225000,
      ),
      // New Year
      FestivalInfo(
        id: 'newyear_$year',
        name: 'New Year Resolution',
        startDate: DateTime(year, 1, 1),
        endDate: DateTime(year, 1, 31),
        description: 'Start your year right with daily fitness',
        leaderboardType: 'calories',
        targetValue: 20000, // calories
      ),
    ];
  }

  Future<SocialUserProfile?> _getUserProfile(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SocialCollectionIds.databaseId,
        collectionId: SocialCollectionIds.userProfiles,
        queries: [
          appwrite.Query.equal('userId', userId),
          appwrite.Query.limit(1),
        ],
      );
      if (response.documents.isEmpty) return null;
      return SocialUserProfile.fromMap(response.documents.first.data);
    } catch (e) {
      return null;
    }
  }
}
