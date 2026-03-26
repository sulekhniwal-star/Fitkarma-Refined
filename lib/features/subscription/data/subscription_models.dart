// lib/features/subscription/data/subscription_models.dart
// Subscription data models

import 'package:uuid/uuid.dart';

/// Subscription plan types with pricing
enum SubscriptionPlanType { free, monthly, quarterly, yearly, family }

/// Workout pack types for one-time purchases
enum WorkoutPackType {
  beginner5Workouts,
  intermediate10Workouts,
  advanced20Workouts,
  customWorkouts10,
}

/// Subscription plan model
class SubscriptionPlan {
  final SubscriptionPlanType type;
  final String name;
  final String description;
  final double priceInr;
  final int validityDays;
  final List<String> features;
  final bool isPopular;

  const SubscriptionPlan({
    required this.type,
    required this.name,
    required this.description,
    required this.priceInr,
    required this.validityDays,
    required this.features,
    this.isPopular = false,
  });

  /// Free plan
  static const free = SubscriptionPlan(
    type: SubscriptionPlanType.free,
    name: 'Free',
    description: 'Basic tracking features',
    priceInr: 0,
    validityDays: -1, // Unlimited
    features: [
      '7-day data retention',
      'Basic workout tracking',
      'Basic food logging',
      'Limited insights',
    ],
  );

  /// Monthly plan - ₹99/month
  static const monthly = SubscriptionPlan(
    type: SubscriptionPlanType.monthly,
    name: 'Monthly',
    description: 'Full access for a month',
    priceInr: 99,
    validityDays: 30,
    features: [
      'Unlimited data storage',
      'Advanced workout programs',
      'Lab report analysis',
      'Family sharing (1 member)',
      'Priority support',
    ],
    isPopular: false,
  );

  /// Quarterly plan - ₹249/3 months
  static const quarterly = SubscriptionPlan(
    type: SubscriptionPlanType.quarterly,
    name: 'Quarterly',
    description: 'Best value for short term',
    priceInr: 249,
    validityDays: 90,
    features: [
      'Everything in Monthly',
      'Save ₹48 vs monthly',
      'Early access to new features',
    ],
    isPopular: true,
  );

  /// Yearly plan - ₹799/year
  static const yearly = SubscriptionPlan(
    type: SubscriptionPlanType.yearly,
    name: 'Yearly',
    description: 'Best value overall',
    priceInr: 799,
    validityDays: 365,
    features: [
      'Everything in Quarterly',
      'Save ₹389 vs monthly',
      'Premium badges',
      'Exclusive webinars',
    ],
  );

  /// Family plan - ₹1499/year for up to 5 members
  static const family = SubscriptionPlan(
    type: SubscriptionPlanType.family,
    name: 'Family',
    description: 'Up to 5 family members',
    priceInr: 1499,
    validityDays: 365,
    features: [
      'Everything in Yearly',
      'Up to 5 family members',
      'Family challenges',
      'Family leaderboard',
      'Shared meal plans',
    ],
  );

  /// All available plans
  static const List<SubscriptionPlan> allPlans = [
    free,
    monthly,
    quarterly,
    yearly,
    family,
  ];

  /// Get plan by type
  static SubscriptionPlan fromType(SubscriptionPlanType type) {
    switch (type) {
      case SubscriptionPlanType.free:
        return free;
      case SubscriptionPlanType.monthly:
        return monthly;
      case SubscriptionPlanType.quarterly:
        return quarterly;
      case SubscriptionPlanType.yearly:
        return yearly;
      case SubscriptionPlanType.family:
        return family;
    }
  }
}

/// Workout pack model for one-time purchases
class WorkoutPack {
  final WorkoutPackType type;
  final String name;
  final String description;
  final double priceInr;
  final int workoutCount;
  final List<String> includedWorkouts;

  const WorkoutPack({
    required this.type,
    required this.name,
    required this.description,
    required this.priceInr,
    required this.workoutCount,
    required this.includedWorkouts,
  });

  /// Beginner pack - 5 workouts for ₹49
  static const beginner5 = WorkoutPack(
    type: WorkoutPackType.beginner5Workouts,
    name: 'Beginner Pack',
    description: 'Perfect to start your fitness journey',
    priceInr: 49,
    workoutCount: 5,
    includedWorkouts: [
      'Full Body Warmup',
      'Basic Cardio',
      'Core Starter',
      'Upper Body Basics',
      'Lower Body Intro',
    ],
  );

  /// Intermediate pack - 10 workouts for ₹149
  static const intermediate10 = WorkoutPack(
    type: WorkoutPackType.intermediate10Workouts,
    name: 'Intermediate Pack',
    description: 'Take your fitness to the next level',
    priceInr: 149,
    workoutCount: 10,
    includedWorkouts: [
      'HIIT Blast',
      'Core Crusher',
      'Upper Body Power',
      'Lower Body Strength',
      'Full Body Burn',
      'Cardio Endurance',
      'Abs Advanced',
      'Push Day',
      'Pull Day',
      'Leg Day',
    ],
  );

  /// Advanced pack - 20 workouts for ₹249
  static const advanced20 = WorkoutPack(
    type: WorkoutPackType.advanced20Workouts,
    name: 'Advanced Pack',
    description: 'For serious fitness enthusiasts',
    priceInr: 249,
    workoutCount: 20,
    includedWorkouts: [
      'High Intensity HIIT',
      'Tabata Training',
      'CrossFit Style',
      'Athletic Performance',
      'Muscle Building',
      'Endurance Training',
      'Power Yoga',
      'Strength Circuit',
      'Sport Specific',
      'Competition Prep',
      // Plus 10 more advanced workouts
    ],
  );

  /// All workout packs
  static const List<WorkoutPack> allPacks = [
    beginner5,
    intermediate10,
    advanced20,
  ];
}

/// User subscription status
enum SubscriptionStatus { active, expired, cancelled, pending }

/// Subscription model for database
class UserSubscription {
  final String id;
  final String userId;
  final SubscriptionPlanType plan;
  final SubscriptionStatus status;
  final DateTime startDate;
  final DateTime? endDate;
  final String? razorpaySubscriptionId;
  final String? razorpayPaymentId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const UserSubscription({
    required this.id,
    required this.userId,
    required this.plan,
    required this.status,
    required this.startDate,
    this.endDate,
    this.razorpaySubscriptionId,
    this.razorpayPaymentId,
    required this.createdAt,
    this.updatedAt,
  });

  bool get isActive => status == SubscriptionStatus.active;
  bool get isExpired => endDate != null && DateTime.now().isAfter(endDate!);

  factory UserSubscription.fromMap(Map<String, dynamic> map) {
    return UserSubscription(
      id: map['id'] as String,
      userId: map['userId'] as String,
      plan: SubscriptionPlanType.values.firstWhere(
        (e) => e.name == map['plan'],
        orElse: () => SubscriptionPlanType.free,
      ),
      status: SubscriptionStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => SubscriptionStatus.pending,
      ),
      startDate: DateTime.parse(map['startDate'] as String),
      endDate: map['endDate'] != null
          ? DateTime.parse(map['endDate'] as String)
          : null,
      razorpaySubscriptionId: map['razorpaySubscriptionId'] as String?,
      razorpayPaymentId: map['razorpayPaymentId'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'plan': plan.name,
      'status': status.name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'razorpaySubscriptionId': razorpaySubscriptionId,
      'razorpayPaymentId': razorpayPaymentId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  UserSubscription copyWith({
    String? id,
    String? userId,
    SubscriptionPlanType? plan,
    SubscriptionStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    String? razorpaySubscriptionId,
    String? razorpayPaymentId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserSubscription(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      plan: plan ?? this.plan,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      razorpaySubscriptionId:
          razorpaySubscriptionId ?? this.razorpaySubscriptionId,
      razorpayPaymentId: razorpayPaymentId ?? this.razorpayPaymentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static String generateId() => 'sub_${const Uuid().v4()}';
}

/// One-time purchase model
class WorkoutPackPurchase {
  final String id;
  final String userId;
  final WorkoutPackType packType;
  final String status; // 'completed', 'pending', 'failed'
  final String? razorpayPaymentId;
  final List<String> purchasedWorkouts;
  final DateTime purchasedAt;

  const WorkoutPackPurchase({
    required this.id,
    required this.userId,
    required this.packType,
    required this.status,
    this.razorpayPaymentId,
    required this.purchasedWorkouts,
    required this.purchasedAt,
  });

  bool get isCompleted => status == 'completed';

  factory WorkoutPackPurchase.fromMap(Map<String, dynamic> map) {
    return WorkoutPackPurchase(
      id: map['id'] as String,
      userId: map['userId'] as String,
      packType: WorkoutPackType.values.firstWhere(
        (e) => e.name == map['packType'],
        orElse: () => WorkoutPackType.beginner5Workouts,
      ),
      status: map['status'] as String? ?? 'pending',
      razorpayPaymentId: map['razorpayPaymentId'] as String?,
      purchasedWorkouts: List<String>.from(map['purchasedWorkouts'] ?? []),
      purchasedAt: DateTime.parse(map['purchasedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'packType': packType.name,
      'status': status,
      'razorpayPaymentId': razorpayPaymentId,
      'purchasedWorkouts': purchasedWorkouts,
      'purchasedAt': purchasedAt.toIso8601String(),
    };
  }

  static String generateId() => 'wpp_${const Uuid().v4()}';
}
