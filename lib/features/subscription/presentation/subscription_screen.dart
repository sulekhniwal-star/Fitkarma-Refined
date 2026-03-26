// lib/features/subscription/presentation/subscription_screen.dart
// Subscription Screen - Premium plan selection and purchase

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/subscription_models.dart';
import '../data/subscription_providers.dart';
import '../data/upipay_service.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class SubscriptionScreen extends ConsumerStatefulWidget {
  final String userId;
  final String? userEmail;
  final String? userMobile;

  const SubscriptionScreen({
    super.key,
    required this.userId,
    this.userEmail,
    this.userMobile,
  });

  @override
  ConsumerState<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  SubscriptionPlanType? _selectedPlan;
  WorkoutPackType? _selectedPack;
  bool _isProcessingPayment = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadSubscription();
  }

  void _loadSubscription() {
    final notifier = ref.read(subscriptionNotifierProvider(widget.userId));
    notifier.loadSubscription();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  SubscriptionState _getState() {
    final notifier = ref.read(subscriptionNotifierProvider(widget.userId));
    return notifier.state;
  }

  @override
  Widget build(BuildContext context) {
    // Watch the provider to trigger rebuilds
    ref.watch(subscriptionNotifierProvider(widget.userId));
    final subState = ref.read(subscriptionNotifierProvider(widget.userId)).state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitkarma Premium'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Subscriptions'),
            Tab(text: 'Workout Packs'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSubscriptionTab(subState),
          _buildWorkoutPacksTab(subState),
        ],
      ),
    );
  }

  Widget _buildSubscriptionTab(SubscriptionState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current plan status
          if (state.subscription != null) _buildCurrentPlanCard(state),

          const SizedBox(height: 24),

          // Plan cards
          const Text(
            'Choose Your Plan',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          ...SubscriptionPlan.allPlans
              .where((p) => p.type != SubscriptionPlanType.free)
              .map((plan) => _buildPlanCard(plan, state)),
        ],
      ),
    );
  }

  Widget _buildCurrentPlanCard(SubscriptionState state) {
    final subscription = state.subscription!;
    final plan = SubscriptionPlan.fromType(subscription.plan);

    return Card(
      color: AppColors.primary.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.check_circle, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'Current Plan: ${plan.name}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (subscription.endDate != null)
              Text(
                'Valid until: ${_formatDate(subscription.endDate!)}',
                style: TextStyle(color: Colors.grey[600]),
              ),
            if (subscription.status == SubscriptionStatus.active)
              const Text(
                '✓ Active',
                style: TextStyle(color: AppColors.primary),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(SubscriptionPlan plan, SubscriptionState state) {
    final isSelected = _selectedPlan == plan.type;
    final currentPlan = state.subscription?.plan;
    final isCurrentPlan = currentPlan == plan.type;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? AppColors.primary : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: isCurrentPlan
            ? null
            : () {
                setState(() {
                  _selectedPlan = plan.type;
                });
              },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              plan.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (plan.isPopular) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'POPULAR',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        Text(
                          plan.description,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹${plan.priceInr.toInt()}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        plan.validityDays == 365
                            ? '/year'
                            : '/${plan.validityDays} days',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              ...plan.features.map(
                (feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(feature)),
                    ],
                  ),
                ),
              ),
              if (!isCurrentPlan && isSelected) ...[
                const SizedBox(height: 16),
                _buildPaymentButtons(plan),
              ],
              if (isCurrentPlan) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Current Plan',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentButtons(SubscriptionPlan plan) {
    return Column(
      children: [
        // Razorpay checkout button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isProcessingPayment
                ? null
                : () => _processRazorpayPayment(plan),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: _isProcessingPayment
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text('Pay ₹${plan.priceInr.toInt()} with Razorpay'),
          ),
        ),
        const SizedBox(height: 12),
        // UPI deep-link button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _isProcessingPayment
                ? null
                : () => _processUpiPayment(plan),
            icon: const Icon(Icons.qr_code),
            label: const Text('Pay with UPI'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWorkoutPacksTab(SubscriptionState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'One-Time Workout Packs',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Get premium workouts without a subscription',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),

          ...WorkoutPack.allPacks.map((pack) => _buildWorkoutPackCard(pack)),
        ],
      ),
    );
  }

  Widget _buildWorkoutPackCard(WorkoutPack pack) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.fitness_center, color: AppColors.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pack.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${pack.workoutCount} workouts included',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${pack.priceInr.toInt()}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'one-time',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(pack.description, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isProcessingPayment
                    ? null
                    : () => _processWorkoutPackPayment(pack),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: Text('Buy Pack - ₹${pack.priceInr.toInt()}'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _processRazorpayPayment(SubscriptionPlan plan) async {
    // TODO: Implement actual Razorpay integration
    // This would use razorpay_flutter package

    setState(() {
      _isProcessingPayment = true;
    });

    try {
      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));

      // Create subscription in Appwrite
      final notifier = ref.read(subscriptionNotifierProvider(widget.userId));
      await notifier.upgradeToPremium(plan.type);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment successful! Welcome to Premium!'),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessingPayment = false;
        });
      }
    }
  }

  Future<void> _processUpiPayment(SubscriptionPlan plan) async {
    setState(() {
      _isProcessingPayment = true;
    });

    try {
      // Create UPI deep-link
      final upiLink = UpiPaymentService.createSubscriptionUpiLink(
        vpa: UpiPaymentService.defaultMerchantVpa,
        planName: plan.name,
        amount: plan.priceInr,
        userId: widget.userId,
      );

      // Launch UPI app
      final launched = await UpiPaymentService.launchUpiPayment(upiLink);

      if (!launched) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'No UPI app found. Please install Google Pay or PhonePe.',
              ),
              backgroundColor: Colors.orange,
            ),
          );
        }
      } else {
        // Show confirmation dialog
        if (mounted) {
          _showUpiPaymentConfirmationDialog(plan);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('UPI payment error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessingPayment = false;
        });
      }
    }
  }

  void _showUpiPaymentConfirmationDialog(SubscriptionPlan plan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Complete Payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Please complete the payment in your UPI app, then return here and confirm.',
            ),
            const SizedBox(height: 16),
            Text(
              'Amount: ₹${plan.priceInr.toInt()}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              // Verify payment and activate subscription
              // In production, this would verify with backend
              final notifier = ref.read(
                subscriptionNotifierProvider(widget.userId),
              );
              await notifier.upgradeToPremium(plan.type);

              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Payment confirmed! Welcome to Premium!'),
                    backgroundColor: AppColors.primary,
                  ),
                );
              }
            },
            child: const Text('Payment Done'),
          ),
        ],
      ),
    );
  }

  Future<void> _processWorkoutPackPayment(WorkoutPack pack) async {
    setState(() {
      _isProcessingPayment = true;
    });

    try {
      // Simulate payment
      await Future.delayed(const Duration(seconds: 2));

      // Create purchase record
      final service = ref.read(subscriptionServiceProvider);
      await service.createWorkoutPackPurchase(
        userId: widget.userId,
        packType: pack.type,
        workouts: pack.includedWorkouts,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${pack.name} purchased successfully!'),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Purchase failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessingPayment = false;
        });
      }
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
