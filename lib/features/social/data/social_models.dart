// lib/features/social/data/social_models.dart
// Data models for Social features

import 'package:uuid/uuid.dart';

/// Types of posts that can be shared
enum PostType { workout, meal, milestone, general }

/// Social post model
class SocialPost {
  final String id;
  final String userId;
  final String userName;
  final String? userAvatarUrl;
  final bool isVerified;
  final PostType type;
  final String content;
  final String? imageUrl;
  final String? workoutLogId;
  final String? foodLogId;
  final int likesCount;
  final int commentsCount;
  final bool isLikedByMe;
  final DateTime createdAt;
  final String? milestoneType;
  final int? milestoneValue;

  const SocialPost({
    required this.id,
    required this.userId,
    required this.userName,
    this.userAvatarUrl,
    this.isVerified = false,
    required this.type,
    required this.content,
    this.imageUrl,
    this.workoutLogId,
    this.foodLogId,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.isLikedByMe = false,
    required this.createdAt,
    this.milestoneType,
    this.milestoneValue,
  });

  factory SocialPost.fromMap(Map<String, dynamic> map) {
    return SocialPost(
      id: map['id'] as String,
      userId: map['userId'] as String,
      userName: map['userName'] as String? ?? 'Unknown',
      userAvatarUrl: map['userAvatarUrl'] as String?,
      isVerified: map['isVerified'] as bool? ?? false,
      type: PostType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => PostType.general,
      ),
      content: map['content'] as String? ?? '',
      imageUrl: map['imageUrl'] as String?,
      workoutLogId: map['workoutLogId'] as String?,
      foodLogId: map['foodLogId'] as String?,
      likesCount: map['likesCount'] as int? ?? 0,
      commentsCount: map['commentsCount'] as int? ?? 0,
      isLikedByMe: map['isLikedByMe'] as bool? ?? false,
      createdAt: DateTime.parse(map['createdAt'] as String),
      milestoneType: map['milestoneType'] as String?,
      milestoneValue: map['milestoneValue'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userAvatarUrl': userAvatarUrl,
      'isVerified': isVerified,
      'type': type.name,
      'content': content,
      'imageUrl': imageUrl,
      'workoutLogId': workoutLogId,
      'foodLogId': foodLogId,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'isLikedByMe': isLikedByMe,
      'createdAt': createdAt.toIso8601String(),
      'milestoneType': milestoneType,
      'milestoneValue': milestoneValue,
    };
  }

  SocialPost copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userAvatarUrl,
    bool? isVerified,
    PostType? type,
    String? content,
    String? imageUrl,
    String? workoutLogId,
    String? foodLogId,
    int? likesCount,
    int? commentsCount,
    bool? isLikedByMe,
    DateTime? createdAt,
    String? milestoneType,
    int? milestoneValue,
  }) {
    return SocialPost(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatarUrl: userAvatarUrl ?? this.userAvatarUrl,
      isVerified: isVerified ?? this.isVerified,
      type: type ?? this.type,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      workoutLogId: workoutLogId ?? this.workoutLogId,
      foodLogId: foodLogId ?? this.foodLogId,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      isLikedByMe: isLikedByMe ?? this.isLikedByMe,
      createdAt: createdAt ?? this.createdAt,
      milestoneType: milestoneType ?? this.milestoneType,
      milestoneValue: milestoneValue ?? this.milestoneValue,
    );
  }
}

/// Comment on a post
class PostComment {
  final String id;
  final String postId;
  final String userId;
  final String userName;
  final String? userAvatarUrl;
  final bool isVerified;
  final String content;
  final DateTime createdAt;

  const PostComment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.userName,
    this.userAvatarUrl,
    this.isVerified = false,
    required this.content,
    required this.createdAt,
  });

  factory PostComment.fromMap(Map<String, dynamic> map) {
    return PostComment(
      id: map['id'] as String,
      postId: map['postId'] as String,
      userId: map['userId'] as String,
      userName: map['userName'] as String? ?? 'Unknown',
      userAvatarUrl: map['userAvatarUrl'] as String?,
      isVerified: map['isVerified'] as bool? ?? false,
      content: map['content'] as String? ?? '',
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'postId': postId,
      'userId': userId,
      'userName': userName,
      'userAvatarUrl': userAvatarUrl,
      'isVerified': isVerified,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

/// Follow relationship between users
class UserFollow {
  final String id;
  final String followerId;
  final String followingId;
  final DateTime createdAt;

  const UserFollow({
    required this.id,
    required this.followerId,
    required this.followingId,
    required this.createdAt,
  });

  factory UserFollow.fromMap(Map<String, dynamic> map) {
    return UserFollow(
      id: map['id'] as String,
      followerId: map['followerId'] as String,
      followingId: map['followingId'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'followerId': followerId,
      'followingId': followingId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

/// Types of community groups
enum GroupType { diet, location, sport, challenge, support }

/// Community group model
class CommunityGroup {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final GroupType type;
  final String creatorId;
  final int membersCount;
  final bool isPrivate;
  final DateTime createdAt;
  final bool isJoinedByMe;

  const CommunityGroup({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.type,
    required this.creatorId,
    this.membersCount = 0,
    this.isPrivate = false,
    required this.createdAt,
    this.isJoinedByMe = false,
  });

  factory CommunityGroup.fromMap(Map<String, dynamic> map) {
    return CommunityGroup(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String? ?? '',
      imageUrl: map['imageUrl'] as String?,
      type: GroupType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => GroupType.support,
      ),
      creatorId: map['creatorId'] as String,
      membersCount: map['membersCount'] as int? ?? 0,
      isPrivate: map['isPrivate'] as bool? ?? false,
      createdAt: DateTime.parse(map['createdAt'] as String),
      isJoinedByMe: map['isJoinedByMe'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'type': type.name,
      'creatorId': creatorId,
      'membersCount': membersCount,
      'isPrivate': isPrivate,
      'createdAt': createdAt.toIso8601String(),
      'isJoinedByMe': isJoinedByMe,
    };
  }

  CommunityGroup copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    GroupType? type,
    String? creatorId,
    int? membersCount,
    bool? isPrivate,
    DateTime? createdAt,
    bool? isJoinedByMe,
  }) {
    return CommunityGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      type: type ?? this.type,
      creatorId: creatorId ?? this.creatorId,
      membersCount: membersCount ?? this.membersCount,
      isPrivate: isPrivate ?? this.isPrivate,
      createdAt: createdAt ?? this.createdAt,
      isJoinedByMe: isJoinedByMe ?? this.isJoinedByMe,
    );
  }
}

/// Group challenge model
class GroupChallenge {
  final String id;
  final String groupId;
  final String title;
  final String description;
  final String challengeType; // steps, calories, workout, streak
  final int targetValue;
  final String targetUnit;
  final DateTime startDate;
  final DateTime endDate;
  final int participantsCount;
  final bool isJoinedByMe;
  final int? myProgress;

  const GroupChallenge({
    required this.id,
    required this.groupId,
    required this.title,
    required this.description,
    required this.challengeType,
    required this.targetValue,
    required this.targetUnit,
    required this.startDate,
    required this.endDate,
    this.participantsCount = 0,
    this.isJoinedByMe = false,
    this.myProgress,
  });

  factory GroupChallenge.fromMap(Map<String, dynamic> map) {
    return GroupChallenge(
      id: map['id'] as String,
      groupId: map['groupId'] as String,
      title: map['title'] as String,
      description: map['description'] as String? ?? '',
      challengeType: map['challengeType'] as String? ?? 'steps',
      targetValue: map['targetValue'] as int? ?? 0,
      targetUnit: map['targetUnit'] as String? ?? 'steps',
      startDate: DateTime.parse(map['startDate'] as String),
      endDate: DateTime.parse(map['endDate'] as String),
      participantsCount: map['participantsCount'] as int? ?? 0,
      isJoinedByMe: map['isJoinedByMe'] as bool? ?? false,
      myProgress: map['myProgress'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groupId': groupId,
      'title': title,
      'description': description,
      'challengeType': challengeType,
      'targetValue': targetValue,
      'targetUnit': targetUnit,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'participantsCount': participantsCount,
      'isJoinedByMe': isJoinedByMe,
      'myProgress': myProgress,
    };
  }
}

/// Direct message conversation
class DMConversation {
  final String id;
  final String participantId;
  final String participantName;
  final String? participantAvatarUrl;
  final bool isVerified;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final int unreadCount;

  const DMConversation({
    required this.id,
    required this.participantId,
    required this.participantName,
    this.participantAvatarUrl,
    this.isVerified = false,
    this.lastMessage,
    this.lastMessageAt,
    this.unreadCount = 0,
  });

  factory DMConversation.fromMap(Map<String, dynamic> map) {
    return DMConversation(
      id: map['id'] as String,
      participantId: map['participantId'] as String,
      participantName: map['participantName'] as String? ?? 'Unknown',
      participantAvatarUrl: map['participantAvatarUrl'] as String?,
      isVerified: map['isVerified'] as bool? ?? false,
      lastMessage: map['lastMessage'] as String?,
      lastMessageAt: map['lastMessageAt'] != null
          ? DateTime.parse(map['lastMessageAt'] as String)
          : null,
      unreadCount: map['unreadCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'participantId': participantId,
      'participantName': participantName,
      'participantAvatarUrl': participantAvatarUrl,
      'isVerified': isVerified,
      'lastMessage': lastMessage,
      'lastMessageAt': lastMessageAt?.toIso8601String(),
      'unreadCount': unreadCount,
    };
  }
}

/// Direct message
class DirectMessage {
  final String id;
  final String conversationId;
  final String senderId;
  final String content;
  final bool isRead;
  final DateTime createdAt;

  const DirectMessage({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    this.isRead = false,
    required this.createdAt,
  });

  factory DirectMessage.fromMap(Map<String, dynamic> map) {
    return DirectMessage(
      id: map['id'] as String,
      conversationId: map['conversationId'] as String,
      senderId: map['senderId'] as String,
      content: map['content'] as String? ?? '',
      isRead: map['isRead'] as bool? ?? false,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'conversationId': conversationId,
      'senderId': senderId,
      'content': content,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

/// User profile with verification status
class SocialUserProfile {
  final String userId;
  final String name;
  final String? avatarUrl;
  final bool isVerified;
  final String? profession; // nutritionist, trainer
  final int followersCount;
  final int followingCount;
  final int postsCount;
  final bool isFollowing;

  const SocialUserProfile({
    required this.userId,
    required this.name,
    this.avatarUrl,
    this.isVerified = false,
    this.profession,
    this.followersCount = 0,
    this.followingCount = 0,
    this.postsCount = 0,
    this.isFollowing = false,
  });

  factory SocialUserProfile.fromMap(Map<String, dynamic> map) {
    return SocialUserProfile(
      userId: map['userId'] as String,
      name: map['name'] as String? ?? 'Unknown',
      avatarUrl: map['avatarUrl'] as String?,
      isVerified: map['isVerified'] as bool? ?? false,
      profession: map['profession'] as String?,
      followersCount: map['followersCount'] as int? ?? 0,
      followingCount: map['followingCount'] as int? ?? 0,
      postsCount: map['postsCount'] as int? ?? 0,
      isFollowing: map['isFollowing'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'avatarUrl': avatarUrl,
      'isVerified': isVerified,
      'profession': profession,
      'followersCount': followersCount,
      'followingCount': followingCount,
      'postsCount': postsCount,
      'isFollowing': isFollowing,
    };
  }
}

/// Festival calendar data for seasonal leaderboards
class FestivalInfo {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String? description;
  final String? imageUrl;
  final String leaderboardType; // steps, calories, workout, meditation
  final int? targetValue;

  const FestivalInfo({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    this.description,
    this.imageUrl,
    this.leaderboardType = 'steps',
    this.targetValue,
  });

  factory FestivalInfo.fromMap(Map<String, dynamic> map) {
    return FestivalInfo(
      id: map['id'] as String,
      name: map['name'] as String,
      startDate: DateTime.parse(map['startDate'] as String),
      endDate: DateTime.parse(map['endDate'] as String),
      description: map['description'] as String?,
      imageUrl: map['imageUrl'] as String?,
      leaderboardType: map['leaderboardType'] as String? ?? 'steps',
      targetValue: map['targetValue'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'description': description,
      'imageUrl': imageUrl,
      'leaderboardType': leaderboardType,
      'targetValue': targetValue,
    };
  }

  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }

  bool get isUpcoming {
    return DateTime.now().isBefore(startDate);
  }
}

/// Seasonal leaderboard entry
class FestivalLeaderboardEntry {
  final String oderId;
  final String userName;
  final String? avatarUrl;
  final bool isVerified;
  final int rank;
  final int score;
  final int? previousRank;

  const FestivalLeaderboardEntry({
    required this.oderId,
    required this.userName,
    this.avatarUrl,
    this.isVerified = false,
    required this.rank,
    required this.score,
    this.previousRank,
  });

  factory FestivalLeaderboardEntry.fromMap(Map<String, dynamic> map) {
    return FestivalLeaderboardEntry(
      oderId: map['userId'] as String,
      userName: map['userName'] as String? ?? 'Unknown',
      avatarUrl: map['avatarUrl'] as String?,
      isVerified: map['isVerified'] as bool? ?? false,
      rank: map['rank'] as int? ?? 0,
      score: map['score'] as int? ?? 0,
      previousRank: map['previousRank'] as int?,
    );
  }
}

/// Helper class to generate unique IDs
class SocialIdGenerator {
  static const _uuid = Uuid();

  static String postId() => 'post_${_uuid.v4()}';
  static String commentId() => 'comment_${_uuid.v4()}';
  static String likeId() => 'like_${_uuid.v4()}';
  static String followId() => 'follow_${_uuid.v4()}';
  static String groupId() => 'group_${_uuid.v4()}';
  static String challengeId() => 'challenge_${_uuid.v4()}';
  static String conversationId() => 'conv_${_uuid.v4()}';
  static String messageId() => 'msg_${_uuid.v4()}';
  static String festivalLeaderboardId() => 'festlead_${_uuid.v4()}';
}
