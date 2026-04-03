import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/di/providers.dart';
import 'package:fitkarma/core/storage/app_database.dart';

final karmaDriftServiceProvider = Provider<KarmaDriftService>((ref) {
  final db = ref.watch(driftDatabaseProvider);
  return KarmaDriftService(db);
});

class KarmaDriftService {
  final AppDatabase _db;

  KarmaDriftService(this._db);

  Future<int> addKarmaTransaction({
    required String odUserId,
    required int amount,
    String? description,
  }) async {
    final now = DateTime.now();
    final transaction = KarmaTransactionsCompanion.insert(
      userId: odUserId,
      amount: amount,
      createdAt: now,
    );

    return _db.into(_db.karmaTransactions).insert(transaction);
  }

  Future<int> getTotalKarma(String odUserId) async {
    final result = await (_db.selectOnly(_db.karmaTransactions)
      ..addColumns([_db.karmaTransactions.amount.sum()])
      ..where(_db.karmaTransactions.userId.equals(odUserId)))
        .getSingle();

    return result?.read(_db.karmaTransactions.amount.sum()) ?? 0;
  }

  Future<List<KarmaTransaction>> getKarmaHistory(String odUserId, {int limit = 20}) {
    return (_db.select(_db.karmaTransactions)
      ..where((t) => t.userId.equals(odUserId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
      ..limit(limit))
        .get();
  }

  Stream<List<KarmaTransaction>> watchKarmaHistory(String odUserId, {int limit = 20}) {
    return (_db.select(_db.karmaTransactions)
      ..where((t) => t.userId.equals(odUserId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
      ..limit(limit))
        .watch();
  }

  Future<int> getStreak(String odUserId) async {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    
    final transactions = await (_db.select(_db.karmaTransactions)
      ..where((t) => t.userId.equals(odUserId) & 
          t.createdAt.isBiggerOrEqualValue(sevenDaysAgo) &
          t.amount.isBiggerThanValue(0)))
        .get();

    return transactions.length;
  }

  double getStreakMultiplier(int streak) {
    if (streak >= 30) return 2.0;
    if (streak >= 7) return 1.5;
    return 1.0;
  }

  Future<int> getStreakRecoveryCount(String odUserId) async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    final transactions = await (_db.select(_db.karmaTransactions)
      ..where((t) => 
          t.userId.equals(odUserId) &
          t.amount.equals(-50) &
          t.createdAt.isBiggerOrEqualValue(thirtyDaysAgo)))
        .get();
    return transactions.length;
  }

  Future<bool> canRecoverStreak(String odUserId) async {
    final recoveryCount = await getStreakRecoveryCount(odUserId);
    return recoveryCount < 1;
  }

  Future<int> recoverStreak(String odUserId) async {
    final canRecover = await canRecoverStreak(odUserId);
    if (!canRecover) {
      throw Exception('Streak recovery not available. Limit: 1 per 30 days.');
    }

    final now = DateTime.now();
    final transaction = KarmaTransactionsCompanion.insert(
      userId: odUserId,
      amount: -50,
      createdAt: now,
    );

    return _db.into(_db.karmaTransactions).insert(transaction);
  }

  Future<KarmaSnapshot> getSnapshot(String odUserId) async {
    final totalKarma = await getTotalKarma(odUserId);
    final streak = await getStreak(odUserId);
    final multiplier = getStreakMultiplier(streak);
    final canRecover = await canRecoverStreak(odUserId);
    final history = await getKarmaHistory(odUserId, limit: 50);
    final recentEarnings = await _getRecentEarnings(odUserId);

    return KarmaSnapshot(
      totalKarma: totalKarma,
      streak: streak,
      multiplier: multiplier,
      canRecoverStreak: canRecover,
      recentEarnings: recentEarnings,
      level: (totalKarma / 100).floor() + 1,
      xpInCurrentLevel: totalKarma % 100,
      xpToNextLevel: 100 - (totalKarma % 100),
    );
  }

  Future<int> _getRecentEarnings(String odUserId) async {
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    final result = await (_db.selectOnly(_db.karmaTransactions)
      ..addColumns([_db.karmaTransactions.amount.sum()])
      ..where(_db.karmaTransactions.userId.equals(odUserId) &
          _db.karmaTransactions.createdAt.isBiggerOrEqualValue(sevenDaysAgo) &
          _db.karmaTransactions.amount.isBiggerThanValue(0)))
        .getSingle();
    return result?.read(_db.karmaTransactions.amount.sum()) ?? 0;
  }

  Future<void> applyXPMultiplier(String odUserId, int baseXP) async {
    final streak = await getStreak(odUserId);
    final multiplier = getStreakMultiplier(streak);
    final finalXP = (baseXP * multiplier).round();
    
    await addKarmaTransaction(
      odUserId: odUserId,
      amount: finalXP,
      description: 'XP with multiplier ×$multiplier',
    );
  }
}

class KarmaSnapshot {
  final int totalKarma;
  final int streak;
  final double multiplier;
  final bool canRecoverStreak;
  final int recentEarnings;
  final int level;
  final int xpInCurrentLevel;
  final int xpToNextLevel;

  KarmaSnapshot({
    required this.totalKarma,
    required this.streak,
    required this.multiplier,
    required this.canRecoverStreak,
    required this.recentEarnings,
    required this.level,
    required this.xpInCurrentLevel,
    required this.xpToNextLevel,
  });
}