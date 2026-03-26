// lib/features/subscription/data/subscription_providers.dart
// Riverpod providers for subscription features

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'subscription_service.dart';
import 'subscription_models.dart';

/// Provider for SubscriptionService
final subscriptionServiceProvider = Provider<SubscriptionService>((ref) {
  return SubscriptionService();
});

/// Provider for current user's subscription
final currentSubscriptionProvider =
    FutureProvider.family<UserSubscription?, String>((ref, userId) async {
      final service = ref.read(subscriptionServiceProvider);
      return await service.getCurrentSubscription(userId);
    });

/// Provider to check if user has premium
final hasPremiumProvider = FutureProvider.family<bool, String>((
  ref,
  userId,
) async {
  final service = ref.read(subscriptionServiceProvider);
  return await service.hasActivePremium(userId);
});

/// Provider for workout pack purchases
final workoutPackPurchasesProvider =
    FutureProvider.family<List<WorkoutPackPurchase>, String>((
      ref,
      userId,
    ) async {
      final service = ref.read(subscriptionServiceProvider);
      return await service.getWorkoutPackPurchases(userId);
    });

/// Provider to check if user owns a specific workout pack
final hasWorkoutPackProvider =
    FutureProvider.family<bool, (String, WorkoutPackType)>((ref, params) async {
      final (userId, packType) = params;
      final service = ref.read(subscriptionServiceProvider);
      return await service.hasWorkoutPack(userId, packType);
    });

/// Subscription state
class SubscriptionState {
  final UserSubscription? subscription;
  final bool hasPremium;
  final bool isLoading;
  final bool isProcessing;
  final String? error;

  const SubscriptionState({
    this.subscription,
    this.hasPremium = false,
    this.isLoading = false,
    this.isProcessing = false,
    this.error,
  });

  SubscriptionState copyWith({
    UserSubscription? subscription,
    bool? hasPremium,
    bool? isLoading,
    bool? isProcessing,
    String? error,
  }) {
    return SubscriptionState(
      subscription: subscription ?? this.subscription,
      hasPremium: hasPremium ?? this.hasPremium,
      isLoading: isLoading ?? this.isLoading,
      isProcessing: isProcessing ?? this.isProcessing,
      error: error,
    );
  }
}

/// Simple subscription notifier that doesn't extend Notifier
class SubscriptionNotifier {
  final Ref _ref;
  final String _userId;

  SubscriptionNotifier(this._ref, this._userId);

  SubscriptionState get state => _state;
  SubscriptionState _state = const SubscriptionState();

  void _updateState(SubscriptionState newState) {
    _state = newState;
    _ref.invalidateSelf();
  }

  SubscriptionService get _service => _ref.read(subscriptionServiceProvider);

  Future<void> loadSubscription() async {
    _updateState(_state.copyWith(isLoading: true));
    try {
      final subscription = await _service.getCurrentSubscription(_userId);
      final hasPremium = await _service.hasActivePremium(_userId);
      _updateState(
        _state.copyWith(
          subscription: subscription,
          hasPremium: hasPremium,
          isLoading: false,
        ),
      );
    } catch (e) {
      _updateState(_state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> createSubscription({
    required SubscriptionPlanType plan,
    required SubscriptionStatus status,
    required DateTime startDate,
    DateTime? endDate,
    String? razorpaySubscriptionId,
    String? razorpayPaymentId,
  }) async {
    _updateState(_state.copyWith(isProcessing: true));
    try {
      final subscription = await _service.createSubscription(
        userId: _userId,
        plan: plan,
        status: status,
        startDate: startDate,
        endDate: endDate,
        razorpaySubscriptionId: razorpaySubscriptionId,
        razorpayPaymentId: razorpayPaymentId,
      );
      _updateState(
        _state.copyWith(
          subscription: subscription,
          hasPremium: status == SubscriptionStatus.active,
          isProcessing: false,
        ),
      );
    } catch (e) {
      _updateState(_state.copyWith(error: e.toString(), isProcessing: false));
    }
  }

  Future<void> upgradeToPremium(SubscriptionPlanType plan) async {
    final planData = SubscriptionPlan.fromType(plan);
    final startDate = DateTime.now();
    final endDate = planData.validityDays > 0
        ? startDate.add(Duration(days: planData.validityDays))
        : null;

    await createSubscription(
      plan: plan,
      status: SubscriptionStatus.active,
      startDate: startDate,
      endDate: endDate,
    );
  }

  void clearError() {
    _updateState(_state.copyWith(error: null));
  }
}

/// Provider for subscription notifier family
final subscriptionNotifierProvider =
    Provider.family<SubscriptionNotifier, String>(
      (ref, userId) => SubscriptionNotifier(ref, userId),
    );

/// Provider for getting subscription state
final subscriptionStateProvider =
    FutureProvider.family<SubscriptionState, String>((ref, userId) async {
      final notifier = ref.watch(subscriptionNotifierProvider(userId));
      await notifier.loadSubscription();
      return notifier.state;
    });
