import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';
import 'karma_service.dart';

part 'streak_service.g.dart';

@riverpod
class StreakService extends _$StreakService {
  @override
  void build() {}

  AppDatabase get _db => ref.read(databaseProvider);
  KarmaService get _karma => ref.read(karmaServiceProvider.notifier);

  /// Updates the streak for a specific activity.
  /// Should be called after a successful activity log.
  Future<void> updateStreak(String userId, String activityType) async {
    final existing = await _db.streaksDao.getStreak(userId, activityType);
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    if (existing == null) {
      // First time activity
      await _db.streaksDao.upsertStreak(UserStreaksCompanion.insert(
        userId: userId,
        activityType: activityType,
        streakCount: const Value(1),
        lastActivityDate: Value(todayDate),
      ));
      return;
    }

    final lastDate = existing.lastActivityDate;
    if (lastDate == null) {
      await _db.streaksDao.upsertStreak(UserStreaksCompanion.insert(
        userId: userId,
        activityType: activityType,
        streakCount: const Value(1),
        lastActivityDate: Value(todayDate),
      ));
      return;
    }

    if (lastDate.isAtSameMomentAs(todayDate)) {
      // Already active today, no streak change
      return;
    }

    final difference = todayDate.difference(lastDate).inDays;

    if (difference == 1) {
      // Continued streak
      final newCount = existing.streakCount + 1;
      await _db.streaksDao.upsertStreak(UserStreaksCompanion.insert(
        userId: userId,
        activityType: activityType,
        streakCount: Value(newCount),
        lastActivityDate: Value(todayDate),
        lastRecoveryDate: Value(existing.lastRecoveryDate),
      ));

      // Award XP with milestones
      _awardStreakMilestoneXP(newCount, activityType);
    } else if (difference > 1) {
      // Streak broken
      await _db.streaksDao.upsertStreak(UserStreaksCompanion.insert(
        userId: userId,
        activityType: activityType,
        streakCount: const Value(1),
        previousStreakCount: Value(existing.streakCount), // Store old streak for recovery
        lastActivityDate: Value(todayDate),
        lastRecoveryDate: Value(existing.lastRecoveryDate),
      ));
    }
  }

  /// Recovers a broken streak using Karma XP
  Future<bool> recoverStreak(String userId, String activityType) async {
    final existing = await _db.streaksDao.getStreak(userId, activityType);
    if (existing == null) return false;

    final lastDate = existing.lastActivityDate;
    if (lastDate == null) return false;
    
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final difference = todayDate.difference(lastDate).inDays;
    
    // Case 1: Streak not yet logged today, but already missed yesterday(s)
    bool canRecoverOld = difference > 1 && existing.streakCount > 0;
    // Case 2: Already logged today, and it reset the streak (prev count stored)
    bool canRecoverReset = existing.previousStreakCount > 0;

    if (!canRecoverOld && !canRecoverReset) return false;

    // Check if recovery was used in the last 30 days
    if (existing.lastRecoveryDate != null) {
      if (today.difference(existing.lastRecoveryDate!).inDays < 30) {
        return false; // Limit once per 30 days
      }
    }

    // Determine the count to restore
    final countToRestore = canRecoverReset ? existing.previousStreakCount : existing.streakCount;

    // Spend 50 Karma XP
    await _karma.grantXPCustom(-50, 'Streak Recovery ($activityType)');

    // Restore streak: set lastActivityDate to yesterday and restore count
    final yesterday = todayDate.subtract(const Duration(days: 1));
    await _db.streaksDao.upsertStreak(UserStreaksCompanion.insert(
      userId: userId,
      activityType: activityType,
      streakCount: Value(countToRestore),
      previousStreakCount: const Value(0),
      lastActivityDate: Value(yesterday),
      lastRecoveryDate: Value(today),
    ));
    
    // Call updateStreak to make it current for today (increments restored count by 1)
    await updateStreak(userId, activityType);
    
    return true;
  }

  void _awardStreakMilestoneXP(int count, String activity) {
    if (count == 7) {
      _karma.grantXPCustom(25, '7-Day Streak Bonus ($activity)');
    } else if (count == 30) {
      _karma.grantXPCustom(100, '30-Day Streak Bonus ($activity)');
    }
  }
  
  Stream<List<UserStreak>> watchStreaks(String userId) {
    return _db.streaksDao.watchAllStreaks(userId);
  }
}
