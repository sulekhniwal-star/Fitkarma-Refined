// lib/features/family/data/family_models.dart
// Data models for Family features

import 'package:uuid/uuid.dart';

/// Subscription plan types
enum SubscriptionPlan { free, family }

/// Family member role
enum FamilyRole { admin, member }

/// Family member invitation status
enum InvitationStatus { pending, accepted, rejected, expired }

/// Family group model
class Family {
  final String id;
  final String name;
  final String adminId;
  final String adminName;
  final SubscriptionPlan plan;
  final int maxMembers;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int membersCount;

  const Family({
    required this.id,
    required this.name,
    required this.adminId,
    required this.adminName,
    required this.plan,
    this.maxMembers = 5,
    required this.createdAt,
    this.updatedAt,
    this.membersCount = 1,
  });

  bool get isFamilyPlan => plan == SubscriptionPlan.family;
  bool get canInviteMore => membersCount < maxMembers;

  factory Family.fromMap(Map<String, dynamic> map) {
    return Family(
      id: map['id'] as String,
      name: map['name'] as String,
      adminId: map['adminId'] as String,
      adminName: map['adminName'] as String? ?? 'Unknown',
      plan: SubscriptionPlan.values.firstWhere(
        (e) => e.name == map['plan'],
        orElse: () => SubscriptionPlan.free,
      ),
      maxMembers: map['maxMembers'] as int? ?? 5,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
      membersCount: map['membersCount'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'adminId': adminId,
      'adminName': adminName,
      'plan': plan.name,
      'maxMembers': maxMembers,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'membersCount': membersCount,
    };
  }

  Family copyWith({
    String? id,
    String? name,
    String? adminId,
    String? adminName,
    SubscriptionPlan? plan,
    int? maxMembers,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? membersCount,
  }) {
    return Family(
      id: id ?? this.id,
      name: name ?? this.name,
      adminId: adminId ?? this.adminId,
      adminName: adminName ?? this.adminName,
      plan: plan ?? this.plan,
      maxMembers: maxMembers ?? this.maxMembers,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      membersCount: membersCount ?? this.membersCount,
    );
  }
}

/// Family member model
class FamilyMember {
  final String id;
  final String familyId;
  final String userId;
  final String userName;
  final String? userEmail;
  final String? userAvatarUrl;
  final FamilyRole role;
  final InvitationStatus invitationStatus;
  final DateTime joinedAt;
  final DateTime? lastActiveAt;

  // Aggregated summary data (for admin view)
  final int? weeklySteps;
  final int? weeklyWaterGlasses;
  final double? weeklyActiveMinutes;
  final int? currentStreak;

  const FamilyMember({
    required this.id,
    required this.familyId,
    required this.userId,
    required this.userName,
    this.userEmail,
    this.userAvatarUrl,
    required this.role,
    required this.invitationStatus,
    required this.joinedAt,
    this.lastActiveAt,
    this.weeklySteps,
    this.weeklyWaterGlasses,
    this.currentStreak,
    this.weeklyActiveMinutes,
  });

  bool get isAdmin => role == FamilyRole.admin;
  bool get isActive => invitationStatus == InvitationStatus.accepted;

  factory FamilyMember.fromMap(Map<String, dynamic> map) {
    return FamilyMember(
      id: map['id'] as String,
      familyId: map['familyId'] as String,
      userId: map['userId'] as String,
      userName: map['userName'] as String? ?? 'Unknown',
      userEmail: map['userEmail'] as String?,
      userAvatarUrl: map['userAvatarUrl'] as String?,
      role: FamilyRole.values.firstWhere(
        (e) => e.name == map['role'],
        orElse: () => FamilyRole.member,
      ),
      invitationStatus: InvitationStatus.values.firstWhere(
        (e) => e.name == map['invitationStatus'],
        orElse: () => InvitationStatus.pending,
      ),
      joinedAt: DateTime.parse(map['joinedAt'] as String),
      lastActiveAt: map['lastActiveAt'] != null
          ? DateTime.parse(map['lastActiveAt'] as String)
          : null,
      weeklySteps: map['weeklySteps'] as int?,
      weeklyWaterGlasses: map['weeklyWaterGlasses'] as int?,
      currentStreak: map['currentStreak'] as int?,
      weeklyActiveMinutes: (map['weeklyActiveMinutes'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'familyId': familyId,
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userAvatarUrl': userAvatarUrl,
      'role': role.name,
      'invitationStatus': invitationStatus.name,
      'joinedAt': joinedAt.toIso8601String(),
      'lastActiveAt': lastActiveAt?.toIso8601String(),
      'weeklySteps': weeklySteps,
      'weeklyWaterGlasses': weeklyWaterGlasses,
      'currentStreak': currentStreak,
      'weeklyActiveMinutes': weeklyActiveMinutes,
    };
  }

  FamilyMember copyWith({
    String? id,
    String? familyId,
    String? userId,
    String? userName,
    String? userEmail,
    String? userAvatarUrl,
    FamilyRole? role,
    InvitationStatus? invitationStatus,
    DateTime? joinedAt,
    DateTime? lastActiveAt,
    int? weeklySteps,
    int? weeklyWaterGlasses,
    double? weeklyActiveMinutes,
    int? currentStreak,
  }) {
    return FamilyMember(
      id: id ?? this.id,
      familyId: familyId ?? this.familyId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userAvatarUrl: userAvatarUrl ?? this.userAvatarUrl,
      role: role ?? this.role,
      invitationStatus: invitationStatus ?? this.invitationStatus,
      joinedAt: joinedAt ?? this.joinedAt,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      weeklySteps: weeklySteps ?? this.weeklySteps,
      weeklyWaterGlasses: weeklyWaterGlasses ?? this.weeklyWaterGlasses,
      weeklyActiveMinutes: weeklyActiveMinutes ?? this.weeklyActiveMinutes,
      currentStreak: currentStreak ?? this.currentStreak,
    );
  }
}

/// Family invitation model
class FamilyInvitation {
  final String id;
  final String familyId;
  final String familyName;
  final String inviterId;
  final String inviterName;
  final String inviteeEmail;
  final InvitationStatus status;
  final DateTime createdAt;
  final DateTime expiresAt;

  const FamilyInvitation({
    required this.id,
    required this.familyId,
    required this.familyName,
    required this.inviterId,
    required this.inviterName,
    required this.inviteeEmail,
    required this.status,
    required this.createdAt,
    required this.expiresAt,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  bool get isPending => status == InvitationStatus.pending;

  factory FamilyInvitation.fromMap(Map<String, dynamic> map) {
    return FamilyInvitation(
      id: map['id'] as String,
      familyId: map['familyId'] as String,
      familyName: map['familyName'] as String? ?? 'Family',
      inviterId: map['inviterId'] as String,
      inviterName: map['inviterName'] as String? ?? 'Unknown',
      inviteeEmail: map['inviteeEmail'] as String,
      status: InvitationStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => InvitationStatus.pending,
      ),
      createdAt: DateTime.parse(map['createdAt'] as String),
      expiresAt: DateTime.parse(map['expiresAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'familyId': familyId,
      'familyName': familyName,
      'inviterId': inviterId,
      'inviterName': inviterName,
      'inviteeEmail': inviteeEmail,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'expiresAt': expiresAt.toIso8601String(),
    };
  }
}

/// Types of family challenges
enum FamilyChallengeType {
  steps7Day,
  waterChallenge,
  screenFreeMorning,
  combined,
}

/// Family challenge status
enum FamilyChallengeStatus { upcoming, active, completed }

/// Family challenge model
class FamilyChallenge {
  final String id;
  final String familyId;
  final String title;
  final String description;
  final FamilyChallengeType type;
  final int targetValue;
  final String targetUnit;
  final DateTime startDate;
  final DateTime endDate;
  final String createdBy;
  final String createdByName;
  final FamilyChallengeStatus status;
  final int participantsCount;
  final bool isJoinedByMe;
  final int? myProgress;
  final int? myTargetValue;

  const FamilyChallenge({
    required this.id,
    required this.familyId,
    required this.title,
    required this.description,
    required this.type,
    required this.targetValue,
    required this.targetUnit,
    required this.startDate,
    required this.endDate,
    required this.createdBy,
    required this.createdByName,
    required this.status,
    this.participantsCount = 0,
    this.isJoinedByMe = false,
    this.myProgress,
    this.myTargetValue,
  });

  double get progressPercent {
    if (myTargetValue == null || myTargetValue == 0) return 0;
    return ((myProgress ?? 0) / myTargetValue!).clamp(0.0, 1.0);
  }

  bool get isActive => status == FamilyChallengeStatus.active;
  bool get isCompleted => status == FamilyChallengeStatus.completed;

  factory FamilyChallenge.fromMap(Map<String, dynamic> map) {
    return FamilyChallenge(
      id: map['id'] as String,
      familyId: map['familyId'] as String,
      title: map['title'] as String,
      description: map['description'] as String? ?? '',
      type: FamilyChallengeType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => FamilyChallengeType.steps7Day,
      ),
      targetValue: map['targetValue'] as int? ?? 0,
      targetUnit: map['targetUnit'] as String? ?? 'steps',
      startDate: DateTime.parse(map['startDate'] as String),
      endDate: DateTime.parse(map['endDate'] as String),
      createdBy: map['createdBy'] as String,
      createdByName: map['createdByName'] as String? ?? 'Unknown',
      status: FamilyChallengeStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => FamilyChallengeStatus.upcoming,
      ),
      participantsCount: map['participantsCount'] as int? ?? 0,
      isJoinedByMe: map['isJoinedByMe'] as bool? ?? false,
      myProgress: map['myProgress'] as int?,
      myTargetValue: map['myTargetValue'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
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
      'status': status.name,
      'participantsCount': participantsCount,
      'isJoinedByMe': isJoinedByMe,
      'myProgress': myProgress,
      'myTargetValue': myTargetValue,
    };
  }

  FamilyChallenge copyWith({
    String? id,
    String? familyId,
    String? title,
    String? description,
    FamilyChallengeType? type,
    int? targetValue,
    String? targetUnit,
    DateTime? startDate,
    DateTime? endDate,
    String? createdBy,
    String? createdByName,
    FamilyChallengeStatus? status,
    int? participantsCount,
    bool? isJoinedByMe,
    int? myProgress,
    int? myTargetValue,
  }) {
    return FamilyChallenge(
      id: id ?? this.id,
      familyId: familyId ?? this.familyId,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      targetValue: targetValue ?? this.targetValue,
      targetUnit: targetUnit ?? this.targetUnit,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdBy: createdBy ?? this.createdBy,
      createdByName: createdByName ?? this.createdByName,
      status: status ?? this.status,
      participantsCount: participantsCount ?? this.participantsCount,
      isJoinedByMe: isJoinedByMe ?? this.isJoinedByMe,
      myProgress: myProgress ?? this.myProgress,
      myTargetValue: myTargetValue ?? this.myTargetValue,
    );
  }
}

/// Challenge participant model
class ChallengeParticipant {
  final String id;
  final String challengeId;
  final String userId;
  final String userName;
  final String? userAvatarUrl;
  final int progress;
  final int targetValue;
  final bool isCompleted;
  final DateTime joinedAt;
  final DateTime? completedAt;

  const ChallengeParticipant({
    required this.id,
    required this.challengeId,
    required this.userId,
    required this.userName,
    this.userAvatarUrl,
    required this.progress,
    required this.targetValue,
    this.isCompleted = false,
    required this.joinedAt,
    this.completedAt,
  });

  double get progressPercent => (progress / targetValue).clamp(0.0, 1.0);

  factory ChallengeParticipant.fromMap(Map<String, dynamic> map) {
    return ChallengeParticipant(
      id: map['id'] as String,
      challengeId: map['challengeId'] as String,
      userId: map['userId'] as String,
      userName: map['userName'] as String? ?? 'Unknown',
      userAvatarUrl: map['userAvatarUrl'] as String?,
      progress: map['progress'] as int? ?? 0,
      targetValue: map['targetValue'] as int? ?? 0,
      isCompleted: map['isCompleted'] as bool? ?? false,
      joinedAt: DateTime.parse(map['joinedAt'] as String),
      completedAt: map['completedAt'] != null
          ? DateTime.parse(map['completedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'challengeId': challengeId,
      'userId': userId,
      'userName': userName,
      'userAvatarUrl': userAvatarUrl,
      'progress': progress,
      'targetValue': targetValue,
      'isCompleted': isCompleted,
      'joinedAt': joinedAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }
}

/// Leaderboard entry for family members
class FamilyLeaderboardEntry {
  final String oduserId;
  final String oduserName;
  final String? oduserAvatarUrl;
  final int rank;
  final int weeklySteps;
  final double? distanceKm;
  final int activeMinutes;
  final int streak;

  const FamilyLeaderboardEntry({
    required this.oduserId,
    required this.oduserName,
    this.oduserAvatarUrl,
    required this.rank,
    required this.weeklySteps,
    this.distanceKm,
    this.activeMinutes = 0,
    this.streak = 0,
  });

  factory FamilyLeaderboardEntry.fromMap(Map<String, dynamic> map, int rank) {
    return FamilyLeaderboardEntry(
      oduserId: map['userId'] as String,
      oduserName: map['userName'] as String? ?? 'Unknown',
      oduserAvatarUrl: map['userAvatarUrl'] as String?,
      rank: rank,
      weeklySteps: map['weeklySteps'] as int? ?? 0,
      distanceKm: (map['distanceKm'] as num?)?.toDouble(),
      activeMinutes: map['activeMinutes'] as int? ?? 0,
      streak: map['streak'] as int? ?? 0,
    );
  }
}

/// ID Generator for family entities
class FamilyIdGenerator {
  static String familyId() => 'fam_${const Uuid().v4()}';
  static String memberId() => 'fmem_${const Uuid().v4()}';
  static String invitationId() => 'finv_${const Uuid().v4()}';
  static String challengeId() => 'fch_${const Uuid().v4()}';
  static String participantId() => 'fpart_${const Uuid().v4()}';
}
