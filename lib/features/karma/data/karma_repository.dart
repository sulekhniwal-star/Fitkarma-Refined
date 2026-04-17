import 'dart:convert';
import 'dart:math';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/storage/drift_service.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/network/sync_queue.dart';

class KarmaRepository {
  final AppDatabase db;

  KarmaRepository({required this.db});

  /// Awards XP to a user, updates local DB and enqueues sync.
  Future<void> awardXP({
    required String userId,
    required int amount,
    required String action,
    String? description,
  }) async {
    final now = DateTime.now();

    // 1. Get current balance from Users table
    final user = await (db.select(db.users)..where((t) => t.id.equals(userId))).getSingleOrNull();
    final currentTotal = user?.karmaTotal ?? 0;
    final newTotal = currentTotal + amount;
    final newLevel = computeLevel(newTotal);

    // 2. Insert transaction
    await db.into(db.karmaTransactions).insert(
          KarmaTransactionsCompanion.insert(
            userId: userId,
            amount: amount,
            action: action,
            description: Value(description),
            balanceAfter: newTotal,
            createdAt: now,
          ),
        );

    // 3. Update User record in Drift
    await (db.update(db.users)..where((t) => t.id.equals(userId))).write(
      UsersCompanion(
        karmaTotal: Value(newTotal),
        karmaLevel: Value(newLevel),
      ),
    );

    // 4. Enqueue sync for Appwrite
    final idempotencyKey = generateIdempotencyKey(userId, 'karma', now.millisecondsSinceEpoch.toString());
    await db.into(db.syncQueue).insert(
          SyncQueueCompanion.insert(
            collection: 'karma_transactions',
            operation: 'create',
            localId: idempotencyKey, // Transactions don't have a stable local integer ID usually, using key
            payload: jsonEncode({
              'userId': userId,
              'amount': amount,
              'action': action,
              'description': description,
              'balance_after': newTotal,
              'created_at': now.toIso8601String(),
            }),
            idempotencyKey: idempotencyKey,
            createdAt: now,
          ),
        );
  }

  /// Computes level based on total XP using a quadratic curve up to 100k for L50.
  int computeLevel(int totalXP) {
    if (totalXP <= 0) return 1;
    // threshold = 41.65 * (level - 1)^2
    // sqrt(totalXP / 41.65) = level - 1
    // level = sqrt(totalXP / 41.65) + 1
    final level = (sqrt(totalXP / 41.65) + 1).floor();
    return max(1, min(50, level));
  }

  /// Returns the title associated with a level (50 tiers).
  String getLevelTitle(int level) {
    const titles = [
      'Seedling', 'Sprout', 'Bud', 'Bloom', 'Leaf', 
      'Branch', 'Sapling', 'Tree', 'Grove', 'Forest',
      'Wood', 'Timber', 'Root', 'Vine', 'Willow',
      'Oak', 'Banyan', 'Lotus', 'Jasmine', 'Rose',
      'Marigold', 'Sunflower', 'Peony', 'Orchid', 'Lily',
      'Lavender', 'Sage', 'Healer', 'Guide', 'Mentor',
      'Teacher', 'Scholar', 'Monk', 'Yogi', 'Ascetic',
      'Seeker', 'Pathmaker', 'Wayfinder', 'Pioneer', 'Warrior',
      'Champion', 'Hero', 'Guardian', 'Protector', 'Warden',
      'Sentinel', 'Custodian', 'Watcher', 'Observer', 'Guru',
      'Legend'
    ];
    if (level < 1) return titles[0];
    if (level > titles.length) return titles.last;
    return titles[level - 1];
  }

  /// Applies multipliers for streaks: 7d (x1.5), 30d (x2.0).
  int applyStreakMultiplier(int baseXP, int streakDays) {
    if (streakDays >= 30) return (baseXP * 2.0).toInt();
    if (streakDays >= 7) return (baseXP * 1.5).toInt();
    return baseXP;
  }

  /// Recovers a streak if not used this month.
  Future<bool> recoverStreak(String userId, int habitId) async {
    final habit = await (db.select(db.habits)..where((t) => t.id.equals(habitId))).getSingleOrNull();
    if (habit == null) return false;

    // Check if streak recovery was already used (reset monthly logic would go here)
    // For now, we use the boolean flag in the table.
    if (habit.streakRecoveryUsed) return false;

    final user = await (db.select(db.users)..where((t) => t.id.equals(userId))).getSingleOrNull();
    final currentTotal = user?.karmaTotal ?? 0;

    if (currentTotal < 50) return false;

    // Deduct 50 XP
    await awardXP(
      userId: userId,
      amount: -50,
      action: 'streak_recovery',
      description: 'Used 50 XP to recover streak for habit ${habit.name}',
    );

    // Mark as used
    await (db.update(db.habits)..where((t) => t.id.equals(habitId))).write(
      const HabitsCompanion(streakRecoveryUsed: Value(true)),
    );

    return true;
  }
}

final karmaRepositoryProvider = Provider<KarmaRepository>((ref) {
  return KarmaRepository(db: DriftService.db);
});

