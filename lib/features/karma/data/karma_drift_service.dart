// lib/features/karma/data/karma_drift_service.dart
// Local XP snapshot service - uses in-memory storage for instant access
// Can be connected to Drift database once generated

import 'package:fitkarma/features/karma/data/karma_models.dart';

/// Local karma data store - instant access for UI
/// This uses in-memory storage for speed; data syncs with Appwrite
class KarmaDriftService {
  // In-memory cache for karma profiles
  final Map<String, KarmaProfile> _profiles = {};

  // In-memory cache for transactions
  final Map<String, List<KarmaTransactionRecord>> _transactions = {};

  /// Get karma profile for a user
  KarmaProfile? getKarmaProfile(String userId) {
    return _profiles[userId];
  }

  /// Create a new karma profile for a user
  String createKarmaProfile(String userId) {
    final id = 'karma_$userId';
    final now = DateTime.now();

    _profiles[userId] = KarmaProfile(
      id: id,
      userId: userId,
      totalXp: 0,
      level: 1,
      currentStreak: 0,
      longestStreak: 0,
      lastActivityDate: null,
      streakStartDate: null,
      weeklyXp: 0,
      weekStartDate: null,
      streakRecoveryUsed7Day: false,
      streakRecoveryUsed30Day: false,
      lastStreakRecovery7Day: null,
      lastStreakRecovery30Day: null,
      createdAt: now,
      updatedAt: now,
    );

    _transactions[userId] = [];

    return id;
  }

  /// Get or create karma profile
  KarmaProfile getOrCreateKarmaProfile(String userId) {
    var profile = getKarmaProfile(userId);
    if (profile == null) {
      createKarmaProfile(userId);
      profile = getKarmaProfile(userId)!;
    }
    return profile;
  }

  /// Add XP to user's karma (called after successful action)
  KarmaProfile addXp({
    required String userId,
    required int baseXp,
    required String action,
    String? description,
  }) {
    var profile = getOrCreateKarmaProfile(userId);
    final now = DateTime.now();

    // Calculate streak multiplier
    double multiplier = 1.0;
    if (profile.currentStreak >= 30) {
      multiplier = 2.0;
    } else if (profile.currentStreak >= 7) {
      multiplier = 1.5;
    }

    final earnedXp = (baseXp * multiplier).round();
    final newTotalXp = profile.totalXp + earnedXp;
    final newLevel = _calculateLevel(newTotalXp);

    // Check if it's a new day for streak
    int newStreak = profile.currentStreak;
    DateTime? streakStartDate = profile.streakStartDate;

    if (profile.lastActivityDate != null) {
      final lastDate = DateTime(
        profile.lastActivityDate!.year,
        profile.lastActivityDate!.month,
        profile.lastActivityDate!.day,
      );
      final today = DateTime(now.year, now.month, now.day);
      final difference = today.difference(lastDate).inDays;

      if (difference == 0) {
        // Same day, streak unchanged
      } else if (difference == 1) {
        // Consecutive day, increment streak
        newStreak++;
        if (streakStartDate == null) {
          streakStartDate = profile.lastActivityDate;
        }
      } else {
        // Streak broken
        newStreak = 1;
        streakStartDate = now;
      }
    } else {
      // First activity
      newStreak = 1;
      streakStartDate = now;
    }

    // Update longest streak
    final newLongestStreak = newStreak > profile.longestStreak
        ? newStreak
        : profile.longestStreak;

    // Check weekly XP reset
    int weeklyXp = profile.weeklyXp;
    DateTime? weekStartDate = profile.weekStartDate;

    if (weekStartDate != null) {
      final weeksSinceStart = now.difference(weekStartDate).inDays ~/ 7;
      if (weeksSinceStart > 0) {
        // Reset weekly XP
        weeklyXp = earnedXp;
        weekStartDate = now;
      } else {
        weeklyXp += earnedXp;
      }
    } else {
      weeklyXp = earnedXp;
      weekStartDate = now;
    }

    // Update profile
    profile = profile.copyWith(
      totalXp: newTotalXp,
      level: newLevel,
      currentStreak: newStreak,
      longestStreak: newLongestStreak,
      lastActivityDate: now,
      streakStartDate: streakStartDate,
      weeklyXp: weeklyXp,
      weekStartDate: weekStartDate,
      updatedAt: now,
    );

    _profiles[userId] = profile;

    // Create transaction record
    final transactionId = 'txn_${now.millisecondsSinceEpoch}';
    final transaction = KarmaTransactionRecord(
      id: transactionId,
      userId: userId,
      amount: earnedXp,
      action: action,
      description: description,
      balanceAfter: newTotalXp,
      createdAt: now,
    );

    _transactions[userId] = [transaction, ...(_transactions[userId] ?? [])];

    return profile;
  }

  /// Calculate level based on XP
  int _calculateLevel(int xp) {
    if (xp >= 5500) return 10;
    if (xp >= 4000) return 9;
    if (xp >= 3000) return 8;
    if (xp >= 2200) return 7;
    if (xp >= 1500) return 6;
    if (xp >= 1000) return 5;
    if (xp >= 600) return 4;
    if (xp >= 300) return 3;
    if (xp >= 100) return 2;
    return 1;
  }

  /// Use streak recovery (costs 50 XP)
  KarmaProfile? useStreakRecovery(String userId, bool is7Day) {
    var profile = getKarmaProfile(userId);
    if (profile == null) return null;

    // Check if recovery is available
    if (is7Day && !profile.canRecover7DayStreak) return null;
    if (!is7Day && !profile.canRecover30DayStreak) return null;

    // Deduct 50 XP
    final newTotalXp = profile.totalXp - 50;
    if (newTotalXp < 0) return null;

    final now = DateTime.now();

    // Restore streak (set to 1 less than the broken streak type)
    final restoredStreak = is7Day ? 6 : 29;

    profile = profile.copyWith(
      totalXp: newTotalXp,
      currentStreak: restoredStreak,
      streakRecoveryUsed7Day: is7Day ? true : profile.streakRecoveryUsed7Day,
      streakRecoveryUsed30Day: !is7Day ? true : profile.streakRecoveryUsed30Day,
      lastStreakRecovery7Day: is7Day ? now : profile.lastStreakRecovery7Day,
      lastStreakRecovery30Day: !is7Day ? now : profile.lastStreakRecovery30Day,
      updatedAt: now,
    );

    _profiles[userId] = profile;

    // Create transaction for the deduction
    final transactionId = 'txn_${now.millisecondsSinceEpoch}';
    final transaction = KarmaTransactionRecord(
      id: transactionId,
      userId: userId,
      amount: -50,
      action: is7Day ? 'streak_recovery_7' : 'streak_recovery_30',
      description: 'Streak recovery used',
      balanceAfter: newTotalXp,
      createdAt: now,
    );

    _transactions[userId] = [transaction, ...(_transactions[userId] ?? [])];

    return profile;
  }

  /// Get karma transaction history for a user
  List<KarmaTransactionRecord> getTransactionHistory(
    String userId, {
    int limit = 50,
  }) {
    final transactions = _transactions[userId] ?? [];
    return transactions.take(limit).toList();
  }

  /// Get user's current balance (from local cache)
  int getCurrentBalance(String userId) {
    final profile = getKarmaProfile(userId);
    return profile?.totalXp ?? 0;
  }

  /// Sync profile from Appwrite (server is source of truth)
  void syncFromServer({
    required String userId,
    required int totalXp,
    required int level,
    required int currentStreak,
    required int longestStreak,
    DateTime? lastActivityDate,
  }) {
    final now = DateTime.now();

    if (_profiles[userId] == null) {
      createKarmaProfile(userId);
    }

    _profiles[userId] = _profiles[userId]!.copyWith(
      totalXp: totalXp,
      level: level,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      lastActivityDate: lastActivityDate,
      updatedAt: now,
    );
  }

  /// Update entire profile from server data
  void updateProfile(KarmaProfile profile) {
    _profiles[profile.userId] = profile;
  }
}
