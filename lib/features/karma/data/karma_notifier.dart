import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/features/karma/data/karma_drift_service.dart';
import 'package:fitkarma/features/karma/data/karma_aw_service.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';

final karmaNotifierProvider = AsyncNotifierProvider<KarmaNotifier, KarmaState>(() {
  return KarmaNotifier();
});

class KarmaNotifier extends AsyncNotifier<KarmaState> {
  StreamSubscription? _realtimeSubscription;
  String? _currentUserId;

  @override
  Future<KarmaState> build() async {
    final authService = ref.watch(authServiceProvider);
    final user = await authService.getCurrentUser();
    _currentUserId = user?.$id;
    
    if (_currentUserId == null) {
      return KarmaState.initial();
    }

    ref.onDispose(() {
      _realtimeSubscription?.cancel();
    });

    _subscribeToRealtime();

    final driftService = ref.read(karmaDriftServiceProvider);
    final snapshot = await driftService.getSnapshot(_currentUserId!);
    
    return KarmaState(
      totalKarma: snapshot.totalKarma,
      streak: snapshot.streak,
      multiplier: snapshot.multiplier,
      canRecoverStreak: snapshot.canRecoverStreak,
      recentEarnings: snapshot.recentEarnings,
      level: snapshot.level,
      xpInCurrentLevel: snapshot.xpInCurrentLevel,
      xpToNextLevel: snapshot.xpToNextLevel,
      history: await driftService.getKarmaHistory(_currentUserId!, limit: 20),
      isLoading: false,
    );
  }

  void _subscribeToRealtime() {
    if (_currentUserId == null) return;
    
    final awService = ref.read(karmaAwServiceProvider);
    _realtimeSubscription?.cancel();
    
    _realtimeSubscription = awService.subscribeToTransactions(_currentUserId!).listen(
      (message) async {
        if (message.events.any((e) => e.contains('create') || e.contains('update'))) {
          await _refreshState();
        }
      },
      onError: (e) {
        // Log error but don't crash
      },
    );
  }

  Future<void> _refreshState() async {
    if (_currentUserId == null) return;
    
    final driftService = ref.read(karmaDriftServiceProvider);
    final snapshot = await driftService.getSnapshot(_currentUserId!);
    
    state = AsyncValue.data(KarmaState(
      totalKarma: snapshot.totalKarma,
      streak: snapshot.streak,
      multiplier: snapshot.multiplier,
      canRecoverStreak: snapshot.canRecoverStreak,
      recentEarnings: snapshot.recentEarnings,
      level: snapshot.level,
      xpInCurrentLevel: snapshot.xpInCurrentLevel,
      xpToNextLevel: snapshot.xpToNextLevel,
      history: await driftService.getKarmaHistory(_currentUserId!, limit: 20),
      isLoading: false,
    ));
  }

  Future<void> addXP(int baseAmount, String action) async {
    if (_currentUserId == null) return;

    final driftService = ref.read(karmaDriftServiceProvider);
    final awService = ref.read(karmaAwServiceProvider);
    
    final streak = await driftService.getStreak(_currentUserId!);
    final multiplier = driftService.getStreakMultiplier(streak);
    final finalXP = (baseAmount * multiplier).round();

    await driftService.addKarmaTransaction(
      odUserId: _currentUserId!,
      amount: finalXP,
      description: action,
    );

    try {
      await awService.createTransaction(
        odUserId: _currentUserId!,
        amount: finalXP,
        description: action,
      );
    } catch (e) {
      // Offline: will sync later
    }

    await _refreshState();
  }

  Future<void> recoverStreak() async {
    if (_currentUserId == null) return;

    final driftService = ref.read(karmaDriftServiceProvider);
    final canRecover = await driftService.canRecoverStreak(_currentUserId!);
    
    if (!canRecover) {
      throw Exception('Streak recovery not available. Limit: 1 per 30 days.');
    }

    await driftService.recoverStreak(_currentUserId!);
    await _refreshState();
  }

  Future<bool> redeemReward(KarmaReward reward) async {
    if (_currentUserId == null) return false;

    final currentKarma = state.value?.totalKarma ?? 0;
    if (currentKarma < reward.cost) return false;

    final driftService = ref.read(karmaDriftServiceProvider);
    await driftService.addKarmaTransaction(
      odUserId: _currentUserId!,
      amount: -reward.cost,
      description: 'Redeemed: ${reward.name}',
    );

    await _refreshState();
    return true;
  }
}

class KarmaState {
  final int totalKarma;
  final int streak;
  final double multiplier;
  final bool canRecoverStreak;
  final int recentEarnings;
  final int level;
  final int xpInCurrentLevel;
  final int xpToNextLevel;
  final List<KarmaTransaction> history;
  final bool isLoading;

  KarmaState({
    required this.totalKarma,
    required this.streak,
    required this.multiplier,
    required this.canRecoverStreak,
    required this.recentEarnings,
    required this.level,
    required this.xpInCurrentLevel,
    required this.xpToNextLevel,
    required this.history,
    required this.isLoading,
  });

  factory KarmaState.initial() {
    return KarmaState(
      totalKarma: 0,
      streak: 0,
      multiplier: 1.0,
      canRecoverStreak: false,
      recentEarnings: 0,
      level: 1,
      xpInCurrentLevel: 0,
      xpToNextLevel: 100,
      history: [],
      isLoading: true,
    );
  }

  double get progress => xpToNextLevel > 0 ? (xpInCurrentLevel / 100).clamp(0.0, 1.0) : 1.0;
}