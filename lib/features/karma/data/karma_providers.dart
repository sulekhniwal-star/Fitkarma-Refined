// lib/features/karma/data/karma_providers.dart
// Riverpod providers for Karma feature

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';
import 'package:fitkarma/features/karma/data/karma_models.dart';
import 'package:fitkarma/features/karma/data/karma_drift_service.dart';
import 'package:fitkarma/features/karma/data/karma_aw_service.dart';

/// Provider for the local karma drift service
final karmaDriftServiceProvider = Provider<KarmaDriftService>((ref) {
  return KarmaDriftService();
});

/// Provider for the Appwrite karma service
final karmaAwServiceProvider = Provider<KarmaAwService>((ref) {
  final service = KarmaAwService();
  ref.onDispose(() => service.dispose());
  return service;
});

/// Provider for the current user ID
final currentUserIdProvider = FutureProvider<String?>((ref) async {
  final authService = AuthAwService();
  return await authService.getStoredUserId();
});

/// Auth service provider
final authServiceProvider = Provider<AuthAwService>((ref) {
  return AuthAwService();
});

/// Karma state class
class KarmaState {
  final KarmaProfile? profile;
  final List<KarmaTransactionRecord> transactions;
  final bool isLoading;
  final String? error;
  final bool isSyncing;

  const KarmaState({
    this.profile,
    this.transactions = const [],
    this.isLoading = false,
    this.error,
    this.isSyncing = false,
  });

  KarmaState copyWith({
    KarmaProfile? profile,
    List<KarmaTransactionRecord>? transactions,
    bool? isLoading,
    String? error,
    bool? isSyncing,
  }) {
    return KarmaState(
      profile: profile ?? this.profile,
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSyncing: isSyncing ?? this.isSyncing,
    );
  }
}

/// Simple karma notifier that can be used with Provider
class KarmaNotifierSimple {
  final Ref _ref;
  KarmaState _state = const KarmaState();

  KarmaNotifierSimple(this._ref);

  KarmaState get state => _state;

  void _updateState(KarmaState newState) {
    _state = newState;
  }

  Future<void> initialize() async {
    _updateState(_state.copyWith(isLoading: true));

    try {
      final authService = _ref.read(authServiceProvider);
      final userId = await authService.getStoredUserId();

      if (userId == null) {
        _updateState(const KarmaState(error: 'Not logged in'));
        return;
      }

      final driftService = _ref.read(karmaDriftServiceProvider);
      var profile = driftService.getKarmaProfile(userId);

      if (profile == null) {
        driftService.createKarmaProfile(userId);
        profile = driftService.getKarmaProfile(userId);
      }

      final transactions = driftService.getTransactionHistory(userId);

      _updateState(
        KarmaState(
          profile: profile,
          transactions: transactions,
          isLoading: false,
        ),
      );

      await _syncWithServer(userId);
      _subscribeToRealtime(userId);
    } catch (e) {
      _updateState(KarmaState(error: e.toString()));
    }
  }

  Future<void> _syncWithServer(String userId) async {
    _updateState(_state.copyWith(isSyncing: true));

    try {
      final awService = _ref.read(karmaAwServiceProvider);
      final serverProfile = await awService.getKarmaProfile(userId);

      if (serverProfile != null) {
        final driftService = _ref.read(karmaDriftServiceProvider);

        driftService.syncFromServer(
          userId: userId,
          totalXp: serverProfile['totalXp'] as int? ?? 0,
          level: serverProfile['level'] as int? ?? 1,
          currentStreak: serverProfile['currentStreak'] as int? ?? 0,
          longestStreak: serverProfile['longestStreak'] as int? ?? 0,
          lastActivityDate: serverProfile['lastActivityDate'] != null
              ? DateTime.parse(serverProfile['lastActivityDate'] as String)
              : null,
        );

        final updatedProfile = driftService.getKarmaProfile(userId);
        final transactions = driftService.getTransactionHistory(userId);

        _updateState(
          KarmaState(
            profile: updatedProfile,
            transactions: transactions,
            isSyncing: false,
          ),
        );
      } else {
        _updateState(_state.copyWith(isSyncing: false));
      }
    } catch (e) {
      debugPrint('Sync failed: $e');
      _updateState(_state.copyWith(isSyncing: false));
    }
  }

  void _subscribeToRealtime(String userId) {
    final awService = _ref.read(karmaAwServiceProvider);
    awService.subscribeToKarmaTransactions(userId);

    awService.transactionsStream.listen((transactions) {
      final driftService = _ref.read(karmaDriftServiceProvider);
      final profile = driftService.getKarmaProfile(userId);

      _updateState(
        _state.copyWith(profile: profile, transactions: transactions),
      );
    });
  }

  Future<void> addXp(int baseXp, String action, {String? description}) async {
    try {
      final authService = _ref.read(authServiceProvider);
      final userId = await authService.getStoredUserId();
      if (userId == null) return;

      final driftService = _ref.read(karmaDriftServiceProvider);
      final updatedProfile = driftService.addXp(
        userId: userId,
        baseXp: baseXp,
        action: action,
        description: description,
      );

      final transactions = driftService.getTransactionHistory(userId);

      _updateState(
        _state.copyWith(profile: updatedProfile, transactions: transactions),
      );

      final awService = _ref.read(karmaAwServiceProvider);
      await awService.createTransaction(
        userId: userId,
        amount: baseXp,
        action: action,
        description: description,
        balanceAfter: updatedProfile.totalXp,
      );

      await awService.upsertKarmaProfile(
        userId: userId,
        totalXp: updatedProfile.totalXp,
        level: updatedProfile.level,
        currentStreak: updatedProfile.currentStreak,
        longestStreak: updatedProfile.longestStreak,
        lastActivityDate: updatedProfile.lastActivityDate,
      );
    } catch (e) {
      debugPrint('Add XP failed: $e');
    }
  }

  Future<bool> useStreakRecovery(bool is7Day) async {
    try {
      final authService = _ref.read(authServiceProvider);
      final userId = await authService.getStoredUserId();
      if (userId == null) return false;

      final driftService = _ref.read(karmaDriftServiceProvider);
      final updatedProfile = driftService.useStreakRecovery(userId, is7Day);

      if (updatedProfile == null) return false;

      final transactions = driftService.getTransactionHistory(userId);

      _updateState(
        _state.copyWith(profile: updatedProfile, transactions: transactions),
      );

      final awService = _ref.read(karmaAwServiceProvider);
      await awService.upsertKarmaProfile(
        userId: userId,
        totalXp: updatedProfile.totalXp,
        level: updatedProfile.level,
        currentStreak: updatedProfile.currentStreak,
        longestStreak: updatedProfile.longestStreak,
        lastActivityDate: updatedProfile.lastActivityDate,
      );

      return true;
    } catch (e) {
      debugPrint('Streak recovery failed: $e');
      return false;
    }
  }

  Future<bool> redeemReward(KarmaReward reward) async {
    final profile = _state.profile;
    if (profile == null) return false;

    if (profile.totalXp < reward.xpCost) return false;

    await addXp(-reward.xpCost, 'reward_redemption', description: reward.name);
    return true;
  }
}

/// Provider for karma notifier
final karmaNotifierProvider = Provider<KarmaNotifierSimple>((ref) {
  return KarmaNotifierSimple(ref);
});

/// Leaderboard provider
final leaderboardProvider =
    FutureProvider.family<List<LeaderboardEntry>, String>((ref, type) async {
      final awService = ref.read(karmaAwServiceProvider);

      try {
        final authService = ref.read(authServiceProvider);
        final userId = await authService.getStoredUserId();
        if (userId == null) return [];
        return await awService.getLeaderboard(userId: userId, type: type);
      } catch (e) {
        return [];
      }
    });
