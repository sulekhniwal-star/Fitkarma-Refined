enum FamilyRole { admin, member }

enum InvitationStatus { pending, accepted, rejected }

enum FamilyChallengeType { steps, water, screenFree }

class FamilyMember {
  final String userId;
  final String name;
  final String? avatarUrl;
  final FamilyRole role;
  final bool isMe;

  const FamilyMember({
    required this.userId,
    required this.name,
    this.avatarUrl,
    required this.role,
    this.isMe = false,
  });

  factory FamilyMember.fromJson(Map<String, dynamic> json, String currentUserId) {
    return FamilyMember(
      userId: json['userId'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      role: json['role'] == 'admin' ? FamilyRole.admin : FamilyRole.member,
      isMe: json['userId'] == currentUserId,
    );
  }
}

class FamilyGroup {
  final String id;
  final String name;
  final String adminUserId;
  final List<FamilyMember> members;
  final DateTime createdAt;

  const FamilyGroup({
    required this.id,
    required this.name,
    required this.adminUserId,
    required this.members,
    required this.createdAt,
  });

  bool get isFull => members.length >= 6; // Admin + 5 members
  bool isAdminMe(String currentUserId) => adminUserId == currentUserId;
}

class FamilyMemberSummary {
  final String userId;
  final String name;
  final int weeklySteps;
  final int currentStepStreak;
  final double waterIntakeLiters;
  final double weightChangeKg;
  final int workoutsCompleted;
  final int karmaXp;

  const FamilyMemberSummary({
    required this.userId,
    required this.name,
    required this.weeklySteps,
    required this.currentStepStreak,
    required this.waterIntakeLiters,
    required this.weightChangeKg,
    required this.workoutsCompleted,
    required this.karmaXp,
  });

  factory FamilyMemberSummary.fromJson(Map<String, dynamic> json) {
    return FamilyMemberSummary(
      userId: json['userId'],
      name: json['name'] ?? 'Member',
      weeklySteps: json['weeklySteps'] ?? 0,
      currentStepStreak: json['currentStepStreak'] ?? 0,
      waterIntakeLiters: (json['waterIntakeLiters'] ?? 0).toDouble(),
      weightChangeKg: (json['weightChangeKg'] ?? 0).toDouble(),
      workoutsCompleted: json['workoutsCompleted'] ?? 0,
      karmaXp: json['karmaXp'] ?? 0,
    );
  }
}

class FamilyChallenge {
  final String id;
  final String title;
  final String description;
  final FamilyChallengeType type;
  final double target;
  final DateTime startDate;
  final DateTime endDate;
  final Map<String, double> participantScores; // userId -> score

  const FamilyChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.target,
    required this.startDate,
    required this.endDate,
    required this.participantScores,
  });

  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }

  double getProgress(String userId) {
    final score = participantScores[userId] ?? 0;
    return (score / target).clamp(0.0, 1.0);
  }
}
