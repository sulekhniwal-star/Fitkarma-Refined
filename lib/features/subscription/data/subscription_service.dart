// lib/features/subscription/data/subscription_service.dart
// Appwrite service for subscription management

import 'package:flutter/foundation.dart';
import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:fitkarma/core/network/appwrite_client.dart';
import 'package:fitkarma/core/constants/api_endpoints.dart';
import 'subscription_models.dart';

/// Collection IDs for subscription features
class SubscriptionCollectionIds {
  static const String databaseId = 'fitkarma';
  static const String subscriptions = 'subscriptions';
  static const String workoutPackPurchases = 'workout_pack_purchases';
  static const String archivedData = 'archived_data';
}

/// Appwrite service for subscription features
class SubscriptionService {
  final appwrite.Databases _databases = AppwriteClient.databases;

  /// Get current user's subscription
  Future<UserSubscription?> getCurrentSubscription(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SubscriptionCollectionIds.databaseId,
        collectionId: SubscriptionCollectionIds.subscriptions,
        queries: [
          appwrite.Query.equal('userId', userId),
          appwrite.Query.orderDesc('createdAt'),
          appwrite.Query.limit(1),
        ],
      );

      if (response.documents.isEmpty) {
        return null;
      }

      return UserSubscription.fromMap(response.documents.first.data);
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get subscription failed: ${e.message}');
      return null;
    }
  }

  /// Create a new subscription
  Future<UserSubscription> createSubscription({
    required String userId,
    required SubscriptionPlanType plan,
    required SubscriptionStatus status,
    required DateTime startDate,
    DateTime? endDate,
    String? razorpaySubscriptionId,
    String? razorpayPaymentId,
  }) async {
    final id = UserSubscription.generateId();
    final now = DateTime.now();

    final subscription = UserSubscription(
      id: id,
      userId: userId,
      plan: plan,
      status: status,
      startDate: startDate,
      endDate: endDate,
      razorpaySubscriptionId: razorpaySubscriptionId,
      razorpayPaymentId: razorpayPaymentId,
      createdAt: now,
      updatedAt: now,
    );

    try {
      await _databases.createDocument(
        databaseId: SubscriptionCollectionIds.databaseId,
        collectionId: SubscriptionCollectionIds.subscriptions,
        documentId: id,
        data: subscription.toMap(),
        permissions: [
          appwrite.Permission.read(appwrite.Role.user(userId)),
          appwrite.Permission.write(appwrite.Role.user(userId)),
        ],
      );
      return subscription;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Create subscription failed: ${e.message}');
      rethrow;
    }
  }

  /// Update subscription status
  Future<void> updateSubscriptionStatus({
    required String subscriptionId,
    required SubscriptionStatus status,
    DateTime? endDate,
  }) async {
    try {
      await _databases.updateDocument(
        databaseId: SubscriptionCollectionIds.databaseId,
        collectionId: SubscriptionCollectionIds.subscriptions,
        documentId: subscriptionId,
        data: {
          'status': status.name,
          'endDate': endDate?.toIso8601String(),
          'updatedAt': DateTime.now().toIso8601String(),
        },
      );
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Update subscription failed: ${e.message}');
      rethrow;
    }
  }

  /// Check if user has active premium subscription
  Future<bool> hasActivePremium(String userId) async {
    final subscription = await getCurrentSubscription(userId);
    if (subscription == null) return false;

    if (subscription.status != SubscriptionStatus.active) return false;

    // Check if expired
    if (subscription.endDate != null &&
        DateTime.now().isAfter(subscription.endDate!)) {
      return false;
    }

    // Free plan is not premium
    if (subscription.plan == SubscriptionPlanType.free) return false;

    return true;
  }

  /// Get workout pack purchases for user
  Future<List<WorkoutPackPurchase>> getWorkoutPackPurchases(
    String userId,
  ) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SubscriptionCollectionIds.databaseId,
        collectionId: SubscriptionCollectionIds.workoutPackPurchases,
        queries: [
          appwrite.Query.equal('userId', userId),
          appwrite.Query.equal('status', 'completed'),
          appwrite.Query.orderDesc('purchasedAt'),
        ],
      );

      return response.documents
          .map((doc) => WorkoutPackPurchase.fromMap(doc.data))
          .toList();
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get workout pack purchases failed: ${e.message}');
      return [];
    }
  }

  /// Create a workout pack purchase record
  Future<WorkoutPackPurchase> createWorkoutPackPurchase({
    required String userId,
    required WorkoutPackType packType,
    required List<String> workouts,
    String? razorpayPaymentId,
  }) async {
    final id = WorkoutPackPurchase.generateId();
    final now = DateTime.now();

    final purchase = WorkoutPackPurchase(
      id: id,
      userId: userId,
      packType: packType,
      status: 'pending',
      razorpayPaymentId: razorpayPaymentId,
      purchasedWorkouts: workouts,
      purchasedAt: now,
    );

    try {
      await _databases.createDocument(
        databaseId: SubscriptionCollectionIds.databaseId,
        collectionId: SubscriptionCollectionIds.workoutPackPurchases,
        documentId: id,
        data: purchase.toMap(),
        permissions: [
          appwrite.Permission.read(appwrite.Role.user(userId)),
          appwrite.Permission.write(appwrite.Role.user(userId)),
        ],
      );
      return purchase;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Create workout pack purchase failed: ${e.message}');
      rethrow;
    }
  }

  /// Update workout pack purchase status
  Future<void> updateWorkoutPackPurchaseStatus({
    required String purchaseId,
    required String status,
  }) async {
    try {
      await _databases.updateDocument(
        databaseId: SubscriptionCollectionIds.databaseId,
        collectionId: SubscriptionCollectionIds.workoutPackPurchases,
        documentId: purchaseId,
        data: {'status': status},
      );
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Update workout pack purchase failed: ${e.message}');
      rethrow;
    }
  }

  /// Check if user owns a specific workout pack
  Future<bool> hasWorkoutPack(String userId, WorkoutPackType packType) async {
    final purchases = await getWorkoutPackPurchases(userId);
    return purchases.any((p) => p.packType == packType && p.isCompleted);
  }

  /// Archive old data for free tier users
  Future<void> archiveOldData({
    required String userId,
    required String dataType,
    required List<Map<String, dynamic>> dataToArchive,
  }) async {
    try {
      final id = 'arch_${DateTime.now().millisecondsSinceEpoch}';
      await _databases.createDocument(
        databaseId: SubscriptionCollectionIds.databaseId,
        collectionId: SubscriptionCollectionIds.archivedData,
        documentId: id,
        data: {
          'id': id,
          'userId': userId,
          'dataType': dataType,
          'data': dataToArchive,
          'archivedAt': DateTime.now().toIso8601String(),
        },
        permissions: [
          appwrite.Permission.read(appwrite.Role.user(userId)),
          appwrite.Permission.write(appwrite.Role.user(userId)),
        ],
      );
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Archive old data failed: ${e.message}');
    }
  }

  /// Get archived data
  Future<List<Map<String, dynamic>>> getArchivedData(
    String userId,
    String dataType,
  ) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SubscriptionCollectionIds.databaseId,
        collectionId: SubscriptionCollectionIds.archivedData,
        queries: [
          appwrite.Query.equal('userId', userId),
          appwrite.Query.equal('dataType', dataType),
        ],
      );

      final List<Map<String, dynamic>> result = [];
      for (final doc in response.documents) {
        final data = doc.data['data'];
        if (data is List) {
          result.addAll(data.cast<Map<String, dynamic>>());
        }
      }
      return result;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get archived data failed: ${e.message}');
      return [];
    }
  }

  /// Delete archived data (when user upgrades)
  Future<void> deleteArchivedData(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: SubscriptionCollectionIds.databaseId,
        collectionId: SubscriptionCollectionIds.archivedData,
        queries: [appwrite.Query.equal('userId', userId)],
      );

      for (final doc in response.documents) {
        await _databases.deleteDocument(
          databaseId: SubscriptionCollectionIds.databaseId,
          collectionId: SubscriptionCollectionIds.archivedData,
          documentId: doc.$id,
        );
      }
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Delete archived data failed: ${e.message}');
    }
  }
}
