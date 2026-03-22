// lib/features/karma/data/karma_models.dart
// Models for Karma feature

/// Level configuration with XP thresholds
class KarmaLevelConfig {
  final int level;
  final int xpRequired;
  final String title;
  final String icon;

  const KarmaLevelConfig({
    required this.level,
    required this.xpRequired,
    required this.title,
    required this.icon,
  });

  /// Get all level configurations
  static const List<KarmaLevelConfig> levels = [
    KarmaLevelConfig(level: 1, xpRequired: 0, title: 'Beginner', icon: '🌱'),
    KarmaLevelConfig(
      level: 2,
      xpRequired: 100,
      title: 'Apprentice',
      icon: '🌿',
    ),
    KarmaLevelConfig(level: 3, xpRequired: 300, title: 'Explorer', icon: '🌳'),
    KarmaLevelConfig(level: 4, xpRequired: 600, title: 'Achiever', icon: '⭐'),
    KarmaLevelConfig(level: 5, xpRequired: 1000, title: 'Champion', icon: '🏆'),
    KarmaLevelConfig(level: 6, xpRequired: 1500, title: 'Master', icon: '💎'),
    KarmaLevelConfig(level: 7, xpRequired: 2200, title: 'Legend', icon: '🔥'),
    KarmaLevelConfig(level: 8, xpRequired: 3000, title: 'Sage', icon: '🌙'),
    KarmaLevelConfig(level: 9, xpRequired: 4000, title: 'Guru', icon: '☀️'),
    KarmaLevelConfig(
      level: 10,
      xpRequired: 5500,
      title: 'Enlightened',
      icon: '✨',
    ),
  ];

  /// Get level for given XP
  static KarmaLevelConfig getLevelForXp(int xp) {
    KarmaLevelConfig current = levels.first;
    for (final level in levels) {
      if (xp >= level.xpRequired) {
        current = level;
      } else {
        break;
      }
    }
    return current;
  }

  /// Get XP required for next level
  static int? getXpForNextLevel(int currentLevel) {
    if (currentLevel >= levels.length) return null;
    return levels[currentLevel].xpRequired;
  }

  /// Get progress to next level (0.0 - 1.0)
  static double getProgressToNextLevel(int xp) {
    final current = getLevelForXp(xp);
    if (current.level >= levels.length) return 1.0;

    final nextLevel = levels[current.level];
    final currentLevelXp = current.xpRequired;
    final xpInCurrentLevel = xp - currentLevelXp;
    final xpNeeded = nextLevel.xpRequired - currentLevelXp;

    return xpInCurrentLevel / xpNeeded;
  }
}

/// Karma action types and their XP rewards
class KarmaAction {
  final String id;
  final String name;
  final String description;
  final int baseXp;
  final bool isDaily;
  final String category;

  const KarmaAction({
    required this.id,
    required this.name,
    required this.description,
    required this.baseXp,
    required this.isDaily,
    required this.category,
  });

  /// Get all available karma actions
  static const List<KarmaAction> actions = [
    // Food actions
    KarmaAction(
      id: 'log_breakfast',
      name: 'Log Breakfast',
      description: 'Log your morning meal',
      baseXp: 10,
      isDaily: true,
      category: 'food',
    ),
    KarmaAction(
      id: 'log_lunch',
      name: 'Log Lunch',
      description: 'Log your midday meal',
      baseXp: 10,
      isDaily: true,
      category: 'food',
    ),
    KarmaAction(
      id: 'log_dinner',
      name: 'Log Dinner',
      description: 'Log your evening meal',
      baseXp: 10,
      isDaily: true,
      category: 'food',
    ),
    KarmaAction(
      id: 'log_snack',
      name: 'Log Snack',
      description: 'Log a snack',
      baseXp: 5,
      isDaily: true,
      category: 'food',
    ),
    // Workout actions
    KarmaAction(
      id: 'log_workout',
      name: 'Log Workout',
      description: 'Log a workout session',
      baseXp: 25,
      isDaily: true,
      category: 'workout',
    ),
    KarmaAction(
      id: 'complete_goal',
      name: 'Goal Complete',
      description: 'Complete a daily goal',
      baseXp: 50,
      isDaily: false,
      category: 'workout',
    ),
    // Steps actions
    KarmaAction(
      id: 'log_steps',
      name: 'Log Steps',
      description: 'Sync your daily steps',
      baseXp: 10,
      isDaily: true,
      category: 'steps',
    ),
    KarmaAction(
      id: 'steps_goal',
      name: 'Steps Goal',
      description: 'Reach 10,000 steps',
      baseXp: 30,
      isDaily: true,
      category: 'steps',
    ),
    // Health actions
    KarmaAction(
      id: 'log_water',
      name: 'Log Water',
      description: 'Log water intake',
      baseXp: 5,
      isDaily: true,
      category: 'health',
    ),
    KarmaAction(
      id: 'log_sleep',
      name: 'Log Sleep',
      description: 'Log your sleep',
      baseXp: 15,
      isDaily: true,
      category: 'health',
    ),
    KarmaAction(
      id: 'log_mood',
      name: 'Log Mood',
      description: 'Log your mood',
      baseXp: 10,
      isDaily: true,
      category: 'health',
    ),
    // BP actions
    KarmaAction(
      id: 'log_bp',
      name: 'Log Blood Pressure',
      description: 'Log your blood pressure reading',
      baseXp: 5,
      isDaily: true,
      category: 'health',
    ),
    // Glucose actions
    KarmaAction(
      id: 'log_glucose',
      name: 'Log Glucose',
      description: 'Log your blood glucose reading',
      baseXp: 5,
      isDaily: true,
      category: 'health',
    ),
    // Habits
    KarmaAction(
      id: 'complete_habit',
      name: 'Complete Habit',
      description: 'Complete a habit',
      baseXp: 15,
      isDaily: true,
      category: 'habits',
    ),
    // Streak bonuses
    KarmaAction(
      id: 'streak_7',
      name: '7-Day Streak',
      description: 'Maintain a 7-day streak',
      baseXp: 100,
      isDaily: false,
      category: 'streak',
    ),
    KarmaAction(
      id: 'streak_30',
      name: '30-Day Streak',
      description: 'Maintain a 30-day streak',
      baseXp: 500,
      isDaily: false,
      category: 'streak',
    ),
  ];

  /// Get action by ID
  static KarmaAction? getById(String id) {
    try {
      return actions.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }
}

/// Reward item for the karma store
class KarmaReward {
  final String id;
  final String name;
  final String description;
  final int xpCost;
  final String icon;
  final bool isAvailable;

  const KarmaReward({
    required this.id,
    required this.name,
    required this.description,
    required this.xpCost,
    required this.icon,
    this.isAvailable = true,
  });

  /// Get available rewards
  static const List<KarmaReward> rewards = [
    KarmaReward(
      id: 'theme_blue',
      name: 'Ocean Theme',
      description: 'Unlock blue theme',
      xpCost: 200,
      icon: '🌊',
    ),
    KarmaReward(
      id: 'theme_sunset',
      name: 'Sunset Theme',
      description: 'Unlock sunset theme',
      xpCost: 300,
      icon: '🌅',
    ),
    KarmaReward(
      id: 'theme_forest',
      name: 'Forest Theme',
      description: 'Unlock forest theme',
      xpCost: 300,
      icon: '🌲',
    ),
    KarmaReward(
      id: 'avatar_wings',
      name: 'Angel Wings',
      description: 'Wings avatar accessory',
      xpCost: 150,
      icon: '👼',
    ),
    KarmaReward(
      id: 'avatar_crown',
      name: 'Royal Crown',
      description: 'Crown avatar accessory',
      xpCost: 250,
      icon: '👑',
    ),
    KarmaReward(
      id: 'badge_first_week',
      name: 'First Week Badge',
      description: 'Complete 7 days',
      xpCost: 100,
      icon: '🎖️',
    ),
    KarmaReward(
      id: 'badge_month',
      name: 'Monthly Badge',
      description: 'Complete 30 days',
      xpCost: 300,
      icon: '🏅',
    ),
    KarmaReward(
      id: 'streak_shield',
      name: 'Streak Shield',
      description: 'Protect streak for 1 day',
      xpCost: 50,
      icon: '🛡️',
    ),
  ];
}

/// Leaderboard entry
class LeaderboardEntry {
  final String oderId;
  final String userName;
  final String? avatarUrl;
  final int level;
  final int weeklyXp;
  final int rank;

  const LeaderboardEntry({
    required this.oderId,
    required this.userName,
    this.avatarUrl,
    required this.level,
    required this.weeklyXp,
    required this.rank,
  });
}

/// Karma transaction record
class KarmaTransactionRecord {
  final String id;
  final String userId;
  final int amount;
  final String action;
  final String? description;
  final int balanceAfter;
  final DateTime createdAt;

  const KarmaTransactionRecord({
    required this.id,
    required this.userId,
    required this.amount,
    required this.action,
    this.description,
    required this.balanceAfter,
    required this.createdAt,
  });

  factory KarmaTransactionRecord.fromMap(Map<String, dynamic> map) {
    return KarmaTransactionRecord(
      id: map['id'] as String,
      userId: map['userId'] as String,
      amount: map['amount'] as int,
      action: map['action'] as String,
      description: map['description'] as String?,
      balanceAfter: map['balanceAfter'] as int,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}

/// User karma profile
class KarmaProfile {
  final String id;
  final String userId;
  final int totalXp;
  final int level;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastActivityDate;
  final DateTime? streakStartDate;
  final int weeklyXp;
  final DateTime? weekStartDate;
  final bool streakRecoveryUsed7Day;
  final bool streakRecoveryUsed30Day;
  final DateTime? lastStreakRecovery7Day;
  final DateTime? lastStreakRecovery30Day;
  final DateTime createdAt;
  final DateTime updatedAt;

  const KarmaProfile({
    required this.id,
    required this.userId,
    required this.totalXp,
    required this.level,
    required this.currentStreak,
    required this.longestStreak,
    this.lastActivityDate,
    this.streakStartDate,
    required this.weeklyXp,
    this.weekStartDate,
    required this.streakRecoveryUsed7Day,
    required this.streakRecoveryUsed30Day,
    this.lastStreakRecovery7Day,
    this.lastStreakRecovery30Day,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Get level config for current level
  KarmaLevelConfig get levelConfig => KarmaLevelConfig.getLevelForXp(totalXp);

  /// Get progress to next level
  double get progressToNextLevel =>
      KarmaLevelConfig.getProgressToNextLevel(totalXp);

  /// Get XP needed for next level
  int? get xpForNextLevel => KarmaLevelConfig.getXpForNextLevel(level);

  /// Get current streak multiplier
  double get streakMultiplier {
    if (currentStreak >= 30) return 2.0;
    if (currentStreak >= 7) return 1.5;
    return 1.0;
  }

  /// Check if streak recovery is available for 7-day streak
  bool get canRecover7DayStreak {
    if (streakRecoveryUsed7Day && lastStreakRecovery7Day != null) {
      final daysSinceRecovery = DateTime.now()
          .difference(lastStreakRecovery7Day!)
          .inDays;
      return daysSinceRecovery >= 30;
    }
    return true;
  }

  /// Check if streak recovery is available for 30-day streak
  bool get canRecover30DayStreak {
    if (streakRecoveryUsed30Day && lastStreakRecovery30Day != null) {
      final daysSinceRecovery = DateTime.now()
          .difference(lastStreakRecovery30Day!)
          .inDays;
      return daysSinceRecovery >= 30;
    }
    return true;
  }

  KarmaProfile copyWith({
    String? id,
    String? userId,
    int? totalXp,
    int? level,
    int? currentStreak,
    int? longestStreak,
    DateTime? lastActivityDate,
    DateTime? streakStartDate,
    int? weeklyXp,
    DateTime? weekStartDate,
    bool? streakRecoveryUsed7Day,
    bool? streakRecoveryUsed30Day,
    DateTime? lastStreakRecovery7Day,
    DateTime? lastStreakRecovery30Day,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return KarmaProfile(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      totalXp: totalXp ?? this.totalXp,
      level: level ?? this.level,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastActivityDate: lastActivityDate ?? this.lastActivityDate,
      streakStartDate: streakStartDate ?? this.streakStartDate,
      weeklyXp: weeklyXp ?? this.weeklyXp,
      weekStartDate: weekStartDate ?? this.weekStartDate,
      streakRecoveryUsed7Day:
          streakRecoveryUsed7Day ?? this.streakRecoveryUsed7Day,
      streakRecoveryUsed30Day:
          streakRecoveryUsed30Day ?? this.streakRecoveryUsed30Day,
      lastStreakRecovery7Day:
          lastStreakRecovery7Day ?? this.lastStreakRecovery7Day,
      lastStreakRecovery30Day:
          lastStreakRecovery30Day ?? this.lastStreakRecovery30Day,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
