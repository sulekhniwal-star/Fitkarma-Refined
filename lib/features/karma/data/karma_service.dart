import 'package:appwrite/appwrite.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../core/storage/app_database.dart';
import '../../../core/di/providers.dart';
import '../../../core/network/appwrite_service.dart';
import '../../../core/network/sync_queue.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../auth/data/auth_repository.dart';

part 'karma_service.g.dart';

enum KarmaAction {
  foodLog(5, 'Food Logged'),
  stepGoal(50, 'Daily Step Goal Reached'),
  workout(20, 'Workout Completed'),
  waterGoal(20, 'Water Intake Goal Reached'),
  moodLog(5, 'Mood Tracked'),
  bpLog(5, 'BP Logged'),
  glucoseLog(5, 'Glucose Logged'),
  periodLog(10, 'Period Tracked'),
  sleepLog(5, 'Sleep Tracked'),
  habitComplete(2, 'Habit Completed'),
  labReport(100, 'Lab Report Imported'),
  referral(500, 'New Referral Joined');

  final int xp;
  final String description;
  const KarmaAction(this.xp, this.description);
}

@riverpod
class KarmaService extends _$KarmaService {
  @override
  void build() {
    // Initialize Realtime listener for Karma transactions
    _initRealtimeListener();
  }

  AppDatabase get _db => ref.read(databaseProvider);
  Realtime get _realtime => ref.read(appwriteRealtimeProvider);

  void _initRealtimeListener() {
    final userAsync = ref.read(currentUserProvider);
    final user = userAsync.asData?.value;
    if (user == null) return;

    // Listen for new transactions from other devices
    final subscription = _realtime.subscribe([
      'databases.${AW.dbId}.collections.${AW.karmaTx}.documents'
    ]);

    subscription.stream.listen((event) async {
      if (event.events.contains('databases.*.collections.*.documents.*.create')) {
        final data = event.payload;
        // Verify it's for this user
        if (data['userId'] == user.$id) {
          // Add to local DB if not exists (Appwrite is source of truth)
          final docId = data['\$id'] as String;
          final existing = await (_db.select(_db.karmaTransactions)..where((t) => t.id.equals(docId))).getSingleOrNull();
          
          if (existing == null) {
            await _db.into(_db.karmaTransactions).insert(
              KarmaTransactionsCompanion.insert(
                id: docId,
                userId: user.$id,
                amount: data['amount'] as int,
                activityType: data['activityType'] as String,
                createdAt: DateTime.parse(data['createdAt'] as String),
                syncStatus: const Value('synced'),
              ),
            );
          }
        }
      }
    });
  }

  Future<void> grantXP(KarmaAction action) async {
    final user = ref.read(currentUserProvider).asData?.value;
    if (user == null) return;

    // Calculate multiplier from StreakService
    double multiplier = 1.0;
    final activityKey = _getActivityKeyForAction(action);
    if (activityKey != null) {
      final streak = await _db.streaksDao.getStreak(user.$id, activityKey);
      if (streak != null) {
        if (streak.streakCount >= 30) {
          multiplier = 2.0;
        } else if (streak.streakCount >= 7) multiplier = 1.5;
      }
    }

    final finalXp = (action.xp * multiplier).round();
    final id = const Uuid().v4();
    final now = DateTime.now();

    final payload = {
      'userId': user.$id,
      'amount': finalXp,
      'activityType': action.name,
      'createdAt': now.toIso8601String(),
    };

    // 1. Write locally
    await _db.into(_db.karmaTransactions).insert(
      KarmaTransactionsCompanion.insert(
        id: id,
        userId: user.$id,
        amount: finalXp,
        activityType: action.name,
        createdAt: now,
      ),
    );

    await ref.read(syncQueueRepositoryProvider.notifier).addToQueue(
      collectionId: AW.karmaTx,
      operation: 'create',
      localId: id,
      payload: payload,
      priority: SyncPriority.normal,
    );
  }

  Future<void> grantXPCustom(int amount, String activityType) async {
    final user = ref.read(currentUserProvider).asData?.value;
    if (user == null) return;

    final id = const Uuid().v4();
    final payload = {
      'userId': user.$id,
      'amount': amount,
      'activityType': activityType,
      'createdAt': DateTime.now().toIso8601String(),
    };

    // 1. Write locally
    await _db.into(_db.karmaTransactions).insert(
      KarmaTransactionsCompanion.insert(
        id: id,
        userId: user.$id,
        amount: amount,
        activityType: activityType,
        createdAt: DateTime.now(),
      ),
    );

    // 2. Add to Sync Queue
    await ref.read(syncQueueRepositoryProvider.notifier).addToQueue(
      collectionId: AW.karmaTx,
      operation: 'create',
      localId: id,
      payload: payload,
      priority: SyncPriority.normal,
    );
  }

  Stream<int> watchTotalXP() {
    return ref.watch(currentUserProvider).when(
      data: (user) {
        if (user == null) return Stream.value(0);
        
        final amountSum = _db.karmaTransactions.amount.sum();
        final query = _db.selectOnly(_db.karmaTransactions)
          ..addColumns([amountSum])
          ..where(_db.karmaTransactions.userId.equals(user.$id));
          
        return query.watchSingle().map((row) => row.read(amountSum) ?? 0);
      },
      loading: () => Stream.value(0),
      error: (_, _) => Stream.value(0),
    );
  }

  int calculateLevel(int totalXP) {
    if (totalXP < 100) return 1;
    // Progression: sqrt based Leveling
    return (num.parse((totalXP / 100).toString()).toInt()).truncate() + 1;
  }

  String? _getActivityKeyForAction(KarmaAction action) {
    switch (action) {
      case KarmaAction.foodLog: return 'food';
      case KarmaAction.stepGoal: return 'steps';
      case KarmaAction.workout: return 'workout';
      case KarmaAction.waterGoal: return 'water';
      default: return null;
    }
  }
}
