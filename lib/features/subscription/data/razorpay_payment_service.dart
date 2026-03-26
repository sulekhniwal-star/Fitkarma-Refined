// lib/features/subscription/data/razorpay_payment_service.dart
// Razorpay payment integration service

import 'package:flutter/foundation.dart';
import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:fitkarma/core/constants/app_config.dart';
import 'subscription_models.dart';

/// Razorpay payment service for handling payments
class RazorpayPaymentService {
  /// Create a payment order for subscription
  ///
  /// In production, this would call your backend to create a Razorpay order
  /// For now, we'll simulate the flow
  static Future<RazorpayOrderResult> createSubscriptionOrder({
    required SubscriptionPlanType plan,
    required String userId,
  }) async {
    final planData = SubscriptionPlan.fromType(plan);

    // In production: Call your backend API to create Razorpay order
    // The backend would use Razorpay SDK to create an order
    //
    // Example backend call:
    // final response = await dio.post(
    //   'https://your-api.com/create-order',
    //   data: {
    //     'amount': planData.priceInr * 100, // Razorpay expects paise
    //     'currency': 'INR',
    //     'receipt': 'sub_${userId}_${DateTime.now().millisecondsSinceEpoch}',
    //     'notes': {
    //       'userId': userId,
    //       'plan': plan.name,
    //     },
    //   },
    // );

    // Simulated response for development
    return RazorpayOrderResult(
      orderId: 'order_sim_${DateTime.now().millisecondsSinceEpoch}',
      amount: (planData.priceInr * 100).toInt(),
      currency: 'INR',
      receipt: 'sub_$userId',
    );
  }

  /// Create a payment order for workout pack (one-time purchase)
  static Future<RazorpayOrderResult> createWorkoutPackOrder({
    required WorkoutPackType packType,
    required String userId,
  }) async {
    final pack = _getWorkoutPack(packType);

    return RazorpayOrderResult(
      orderId: 'order_sim_${DateTime.now().millisecondsSinceEpoch}',
      amount: (pack.priceInr * 100).toInt(),
      currency: 'INR',
      receipt: 'wpp_$userId',
    );
  }

  /// Verify payment signature (should be done on backend)
  ///
  /// In production, this verification MUST happen on your server
  /// to prevent tampering
  static bool verifyPaymentSignature({
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
    required String secret,
  }) {
    // HMAC-SHA256 signature verification
    // In production: Use Razorpay's official SDK or verify on backend

    // This is a simplified version - in production use proper HMAC verification
    final message = '$razorpayOrderId|$razorpayPaymentId';

    // Note: This should be done on backend with the secret key
    // Client-side verification is not secure

    debugPrint('Payment verification called for: $message');
    return true; // Should be verified on backend
  }

  /// Get checkout options for Razorpay checkout
  static Map<String, dynamic> getCheckoutOptions({
    required String orderId,
    required String name,
    required String email,
    required String? mobile,
    String? upiVpa, // Allow UPI payments
  }) {
    return {
      'key': AppConfig.razorpayKeyId, // Public key only
      'order_id': orderId,
      'name': 'Fitkarma',
      'description': name,
      'prefill': {
        'contact': mobile,
        'email': email,
        'method': 'upi', // Prefer UPI
      },
      'theme': {
        'color': '#4CAF50', // Fitkarma green
      },
      'options': {
        'payment': {
          'upi': {'allow_duplicates': true},
          'card': {'emit': false},
          'netbanking': {
            'displayBanks': ['SBIN', 'HDFC', 'ICICI'],
          },
        },
      },
    };
  }

  /// Handle payment success
  static void onPaymentSuccess(Map<String, dynamic> response) {
    final paymentId = response['razorpay_payment_id'];
    final orderId = response['razorpay_order_id'];
    final signature = response['razorpay_signature'];

    debugPrint('Payment Success: PaymentID=$paymentId, OrderID=$orderId');

    // TODO: Verify signature on backend and update subscription status
  }

  /// Handle payment failure
  static void onPaymentError(Map<String, dynamic> response) {
    final code = response['code'];
    final description = response['description'];

    debugPrint('Payment Error: Code=$code, Description=$description');
  }

  /// Handle payment cancel
  static void onPaymentCancel() {
    debugPrint('Payment cancelled by user');
  }

  static WorkoutPack _getWorkoutPack(WorkoutPackType type) {
    switch (type) {
      case WorkoutPackType.beginner5Workouts:
        return WorkoutPack.beginner5;
      case WorkoutPackType.intermediate10Workouts:
        return WorkoutPack.intermediate10;
      case WorkoutPackType.advanced20Workouts:
        return WorkoutPack.advanced20;
      case WorkoutPackType.customWorkouts10:
        return WorkoutPack.intermediate10; // Placeholder
    }
  }
}

/// Result from creating a Razorpay order
class RazorpayOrderResult {
  final String orderId;
  final int amount;
  final String currency;
  final String receipt;

  RazorpayOrderResult({
    required this.orderId,
    required this.amount,
    required this.currency,
    required this.receipt,
  });
}
