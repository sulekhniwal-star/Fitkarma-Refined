import 'package:flutter_riverpod/flutter_riverpod.dart';

// ─── Mock current user (replace with real auth) ───────────────────────────────
const kCurrentUserId = 'user_me';
const kCurrentUsername = 'You';

// ─── Post model for UI ────────────────────────────────────────────────────────
class SocialPostUi {
  final int id;
  final String userId;
  final String username;
  final String avatarInitial;
  final bool isVerified;
  final String verifiedType; // 'nutritionist' | 'trainer' | 'none'
  final String postType;     // 'workout' | 'meal' | 'milestone' | 'general'
  final String content;
  final String? mediaUrl;
  final int likesCount;
  final int commentsCount;
  final bool isLikedByMe;
  final DateTime createdAt;

  const SocialPostUi({
    required this.id,
    required this.userId,
    required this.username,
    required this.avatarInitial,
    required this.isVerified,
    required this.verifiedType,
    required this.postType,
    required this.content,
    this.mediaUrl,
    required this.likesCount,
    required this.commentsCount,
    required this.isLikedByMe,
    required this.createdAt,
  });

  SocialPostUi copyWith({int? likesCount, bool? isLikedByMe}) => SocialPostUi(
        id: id,
        userId: userId,
        username: username,
        avatarInitial: avatarInitial,
        isVerified: isVerified,
        verifiedType: verifiedType,
        postType: postType,
        content: content,
        mediaUrl: mediaUrl,
        likesCount: likesCount ?? this.likesCount,
        commentsCount: commentsCount,
        isLikedByMe: isLikedByMe ?? this.isLikedByMe,
        createdAt: createdAt,
      );
}

// ─── Seed data ────────────────────────────────────────────────────────────────
List<SocialPostUi> _buildSeedPosts() => [
  SocialPostUi(
    id: 1,
    userId: 'user_1',
    username: 'Priya K.',
    avatarInitial: 'P',
    isVerified: true,
    verifiedType: 'nutritionist',
    postType: 'meal',
    content: '🥗 Post-Navratri detox bowl: mung beans, amla, rock salt. High iron + vit C combo. Sharing the recipe in comments! #Navratri #DetoxEats',
    likesCount: 42,
    commentsCount: 8,
    isLikedByMe: false,
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  SocialPostUi(
    id: 2,
    userId: 'user_2',
    username: 'Rahul S.',
    avatarInitial: 'R',
    isVerified: false,
    verifiedType: 'none',
    postType: 'workout',
    content: "💪 Just crushed a 10km run for the Diwali Step Challenge! Day 8 of 21. Who's with me? 🏃‍♂️ #FitKarma #DiwaliChallenge",
    likesCount: 28,
    commentsCount: 5,
    isLikedByMe: true,
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
  ),
  SocialPostUi(
    id: 3,
    userId: 'user_3',
    username: 'Dr. Amit V.',
    avatarInitial: 'A',
    isVerified: true,
    verifiedType: 'trainer',
    postType: 'milestone',
    content: '🏆 100-day streak unlocked! Never missed a workout session this entire year. Milestone: lost 12kg, gained strength, found peace. Your body is your temple 🕌 #Milestone #FitnessJourney',
    likesCount: 156,
    commentsCount: 24,
    isLikedByMe: false,
    createdAt: DateTime.now().subtract(const Duration(hours: 12)),
  ),
  SocialPostUi(
    id: 4,
    userId: 'user_4',
    username: 'Sneha R.',
    avatarInitial: 'S',
    isVerified: false,
    verifiedType: 'none',
    postType: 'general',
    content: 'Morning walk at Cubbon Park 🌳 + turmeric milk to start the day. Small habits, big results. Anyone else doing the Navratri Wellness Challenge on FitKarma? 🙏',
    likesCount: 19,
    commentsCount: 3,
    isLikedByMe: false,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
];

// ─── Social Feed Notifier (Riverpod v3) ───────────────────────────────────────
class SocialFeedNotifier extends Notifier<List<SocialPostUi>> {
  @override
  List<SocialPostUi> build() => _buildSeedPosts();

  void toggleLike(int postId) {
    state = state.map((p) {
      if (p.id != postId) return p;
      return p.copyWith(
        isLikedByMe: !p.isLikedByMe,
        likesCount: p.isLikedByMe ? p.likesCount - 1 : p.likesCount + 1,
      );
    }).toList();
  }

  void addPost(SocialPostUi post) {
    state = [post, ...state];
  }
}

final socialFeedProvider =
    NotifierProvider<SocialFeedNotifier, List<SocialPostUi>>(
  SocialFeedNotifier.new,
);

// ─── Community Group model ────────────────────────────────────────────────────
class CommunityGroupUi {
  final int id;
  final String name;
  final String description;
  final String groupType; // 'diet' | 'location' | 'sport' | 'challenge' | 'support'
  final String emoji;
  final int membersCount;
  final bool isJoined;
  final bool isPrivate;

  const CommunityGroupUi({
    required this.id,
    required this.name,
    required this.description,
    required this.groupType,
    required this.emoji,
    required this.membersCount,
    required this.isJoined,
    required this.isPrivate,
  });

  CommunityGroupUi copyWith({bool? isJoined, int? membersCount}) =>
      CommunityGroupUi(
        id: id,
        name: name,
        description: description,
        groupType: groupType,
        emoji: emoji,
        membersCount: membersCount ?? this.membersCount,
        isJoined: isJoined ?? this.isJoined,
        isPrivate: isPrivate,
      );
}

List<CommunityGroupUi> _buildSeedGroups() => [
  CommunityGroupUi(id: 1, name: 'Vegetarian Warriors', description: 'Plant-based diet tips, recipes & support for Indian vegans', groupType: 'diet', emoji: '🥦', membersCount: 1240, isJoined: true, isPrivate: false),
  CommunityGroupUi(id: 2, name: 'Mumbai Runners', description: 'Running community for Mumbai locals — Marine Drive, Bandra seafront', groupType: 'location', emoji: '🏃', membersCount: 892, isJoined: false, isPrivate: false),
  CommunityGroupUi(id: 3, name: 'Diwali Step Challenge', description: '10,000 steps every day from Dussehra to Diwali. Join & compete!', groupType: 'challenge', emoji: '🪔', membersCount: 3411, isJoined: true, isPrivate: false),
  CommunityGroupUi(id: 4, name: 'PCOS Support Circle', description: 'Safe space for women managing PCOS — diet, exercise, hormones', groupType: 'support', emoji: '💜', membersCount: 678, isJoined: false, isPrivate: true),
  CommunityGroupUi(id: 5, name: 'Cricket Fitness', description: 'Fitness for cricket players — strength, agility, endurance', groupType: 'sport', emoji: '🏏', membersCount: 445, isJoined: false, isPrivate: false),
  CommunityGroupUi(id: 6, name: 'Navratri Wellness', description: 'Navratri fasting tips, sattvic recipes & guided yoga routines', groupType: 'challenge', emoji: '🙏', membersCount: 2100, isJoined: false, isPrivate: false),
];

class CommunityGroupsNotifier extends Notifier<List<CommunityGroupUi>> {
  @override
  List<CommunityGroupUi> build() => _buildSeedGroups();

  void toggleJoin(int groupId) {
    state = state.map((g) {
      if (g.id != groupId) return g;
      return g.copyWith(
        isJoined: !g.isJoined,
        membersCount: g.isJoined ? g.membersCount - 1 : g.membersCount + 1,
      );
    }).toList();
  }

  void addGroup(CommunityGroupUi group) {
    state = [...state, group];
  }
}

final communityGroupsProvider =
    NotifierProvider<CommunityGroupsNotifier, List<CommunityGroupUi>>(
  CommunityGroupsNotifier.new,
);

// ─── DM models ────────────────────────────────────────────────────────────────
class DmMessage {
  final String senderId;
  final String content;
  final DateTime sentAt;
  final bool isRead;

  const DmMessage({
    required this.senderId,
    required this.content,
    required this.sentAt,
    required this.isRead,
  });
}

class ConversationUi {
  final String participantId;
  final String participantName;
  final String avatarInitial;
  final bool isVerified;
  final String lastMessage;
  final DateTime lastMessageAt;
  final int unreadCount;
  final List<DmMessage> messages;

  const ConversationUi({
    required this.participantId,
    required this.participantName,
    required this.avatarInitial,
    required this.isVerified,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.unreadCount,
    required this.messages,
  });

  ConversationUi copyWith({
    List<DmMessage>? messages,
    String? lastMessage,
    int? unreadCount,
  }) =>
      ConversationUi(
        participantId: participantId,
        participantName: participantName,
        avatarInitial: avatarInitial,
        isVerified: isVerified,
        lastMessage: lastMessage ?? this.lastMessage,
        lastMessageAt: DateTime.now(),
        unreadCount: unreadCount ?? this.unreadCount,
        messages: messages ?? this.messages,
      );
}

List<ConversationUi> _buildSeedConversations() => [
  ConversationUi(
    participantId: 'user_1',
    participantName: 'Priya K.',
    avatarInitial: 'P',
    isVerified: true,
    lastMessage: 'Thanks for the recipe tip! 🙏',
    lastMessageAt: DateTime.now().subtract(const Duration(minutes: 15)),
    unreadCount: 2,
    messages: [
      DmMessage(senderId: 'user_1', content: 'Hey! Loved your post about the Navratri detox.', sentAt: DateTime.now().subtract(const Duration(hours: 1)), isRead: true),
      DmMessage(senderId: kCurrentUserId, content: 'Thank you! The amla + rock salt combo is amazing. Try it tomorrow morning.', sentAt: DateTime.now().subtract(const Duration(minutes: 45)), isRead: true),
      DmMessage(senderId: 'user_1', content: 'Thanks for the recipe tip! 🙏', sentAt: DateTime.now().subtract(const Duration(minutes: 15)), isRead: false),
    ],
  ),
  ConversationUi(
    participantId: 'user_2',
    participantName: 'Rahul S.',
    avatarInitial: 'R',
    isVerified: false,
    lastMessage: 'Day 8 done! Feeling amazing 💪',
    lastMessageAt: DateTime.now().subtract(const Duration(hours: 3)),
    unreadCount: 0,
    messages: [
      DmMessage(senderId: 'user_2', content: 'Are you joining the Diwali Step Challenge?', sentAt: DateTime.now().subtract(const Duration(hours: 4)), isRead: true),
      DmMessage(senderId: kCurrentUserId, content: "Already signed up! Let's race 👟", sentAt: DateTime.now().subtract(const Duration(hours: 3, minutes: 30)), isRead: true),
      DmMessage(senderId: 'user_2', content: 'Day 8 done! Feeling amazing 💪', sentAt: DateTime.now().subtract(const Duration(hours: 3)), isRead: true),
    ],
  ),
];

class DmNotifier extends Notifier<List<ConversationUi>> {
  @override
  List<ConversationUi> build() => _buildSeedConversations();

  void sendMessage(String participantId, String content) {
    state = state.map((conv) {
      if (conv.participantId != participantId) return conv;
      final newMsg = DmMessage(
        senderId: kCurrentUserId,
        content: content,
        sentAt: DateTime.now(),
        isRead: false,
      );
      return conv.copyWith(
        messages: [...conv.messages, newMsg],
        lastMessage: content,
      );
    }).toList();
  }

  void markRead(String participantId) {
    state = state.map((conv) {
      if (conv.participantId != participantId) return conv;
      return conv.copyWith(unreadCount: 0);
    }).toList();
  }
}

final dmProvider = NotifierProvider<DmNotifier, List<ConversationUi>>(
  DmNotifier.new,
);

// ─── Festival Leaderboard models ──────────────────────────────────────────────
class LeaderboardEntry {
  final int rank;
  final String userId;
  final String username;
  final String avatarInitial;
  final bool isVerified;
  final int value;
  final bool isMe;

  const LeaderboardEntry({
    required this.rank,
    required this.userId,
    required this.username,
    required this.avatarInitial,
    required this.isVerified,
    required this.value,
    required this.isMe,
  });
}

class FestivalChallengeUi {
  final int id;
  final String festivalName;
  final String festivalEmoji;
  final String title;
  final String description;
  final String metricType;
  final int targetValue;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final bool isAutoCreated;
  final List<LeaderboardEntry> leaderboard;

  const FestivalChallengeUi({
    required this.id,
    required this.festivalName,
    required this.festivalEmoji,
    required this.title,
    required this.description,
    required this.metricType,
    required this.targetValue,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.isAutoCreated,
    required this.leaderboard,
  });
}

final festivalChallengesProvider = Provider<List<FestivalChallengeUi>>((ref) => [
  FestivalChallengeUi(
    id: 1,
    festivalName: 'Navratri',
    festivalEmoji: '🙏',
    title: 'Navratri Wellness Challenge',
    description: 'Maintain daily yoga + meditation for all 9 days of Navratri. Track your wellness score!',
    metricType: 'wellness_score',
    targetValue: 9,
    startDate: DateTime(2026, 10, 2),
    endDate: DateTime(2026, 10, 11),
    isActive: true,
    isAutoCreated: true,
    leaderboard: [
      LeaderboardEntry(rank: 1, userId: 'user_3', username: 'Dr. Amit V.', avatarInitial: 'A', isVerified: true, value: 9, isMe: false),
      LeaderboardEntry(rank: 2, userId: 'user_1', username: 'Priya K.', avatarInitial: 'P', isVerified: true, value: 8, isMe: false),
      LeaderboardEntry(rank: 3, userId: kCurrentUserId, username: 'You', avatarInitial: 'Y', isVerified: false, value: 7, isMe: true),
      LeaderboardEntry(rank: 4, userId: 'user_2', username: 'Rahul S.', avatarInitial: 'R', isVerified: false, value: 6, isMe: false),
      LeaderboardEntry(rank: 5, userId: 'user_4', username: 'Sneha R.', avatarInitial: 'S', isVerified: false, value: 5, isMe: false),
    ],
  ),
  FestivalChallengeUi(
    id: 2,
    festivalName: 'Diwali',
    festivalEmoji: '🪔',
    title: 'Diwali Step Challenge',
    description: 'Walk 10,000+ steps every day from Dussehra to Diwali (21 days). Earn bonus Karma XP!',
    metricType: 'steps',
    targetValue: 210000,
    startDate: DateTime(2026, 10, 2),
    endDate: DateTime(2026, 10, 20),
    isActive: true,
    isAutoCreated: true,
    leaderboard: [
      LeaderboardEntry(rank: 1, userId: 'user_2', username: 'Rahul S.', avatarInitial: 'R', isVerified: false, value: 185200, isMe: false),
      LeaderboardEntry(rank: 2, userId: 'user_4', username: 'Sneha R.', avatarInitial: 'S', isVerified: false, value: 162400, isMe: false),
      LeaderboardEntry(rank: 3, userId: kCurrentUserId, username: 'You', avatarInitial: 'Y', isVerified: false, value: 148000, isMe: true),
      LeaderboardEntry(rank: 4, userId: 'user_1', username: 'Priya K.', avatarInitial: 'P', isVerified: true, value: 132100, isMe: false),
      LeaderboardEntry(rank: 5, userId: 'user_5', username: 'Vikram B.', avatarInitial: 'V', isVerified: false, value: 98700, isMe: false),
    ],
  ),
  FestivalChallengeUi(
    id: 3,
    festivalName: 'Holi',
    festivalEmoji: '🎨',
    title: 'Holi Fitness Sprint',
    description: '7-day HIIT sprint before Holi. Burn 3000+ calories total. Track through FitKarma!',
    metricType: 'calories_burned',
    targetValue: 3000,
    startDate: DateTime(2027, 3, 25),
    endDate: DateTime(2027, 4, 1),
    isActive: false,
    isAutoCreated: true,
    leaderboard: [],
  ),
]);
