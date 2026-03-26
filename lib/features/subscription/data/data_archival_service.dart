// lib/features/subscription/data/data_archival_service.dart
// Service for managing free-tier data archival

import 'package:flutter/foundation.dart';
import 'package:fitkarma/features/subscription/data/subscription_service.dart';
import 'package:fitkarma/core/network/appwrite_client.dart';
import 'package:appwrite/appwrite.dart' as appwrite;

/// Service for managing free-tier data archival
/// Shows data for 7 days, archives older records, restores on upgrade
class DataArchivalService {
  static const int freeTierRetentionDays = 7;
  final SubscriptionService _subscriptionService = SubscriptionService();
  final appwrite.Databases _databases = AppwriteClient.databases;

  /// Check and archive old data for free tier users
  /// Should be called periodically (e.g., daily or on app startup)
  Future<void> processArchival(String userId) async {
    // Check if user has premium
    final hasPremium = await _subscriptionService.hasActivePremium(userId);

    if (hasPremium) {
      // User has premium - restore any archived data
      await restoreArchivedData(userId);
      return;
    }

    // Free tier user - archive data older than 7 days
    await archiveOldData(userId);
  }

  /// Archive data older than 7 days
  Future<void> archiveOldData(String userId) async {
    final cutoffDate = DateTime.now().subtract(
      const Duration(days: freeTierRetentionDays),
    );

    try {
      // Archive workout logs
      await _archiveCollectionData(
        userId: userId,
        databaseId: 'fitkarma',
        collectionId: 'workout_logs',
        dateField: 'loggedAt',
        cutoffDate: cutoffDate,
        dataType: 'workout_logs',
      );

      // Archive food logs
      await _archiveCollectionData(
        userId: userId,
        databaseId: 'fitkarma',
        collectionId: 'food_logs',
        dateField: 'loggedAt',
        cutoffDate: cutoffDate,
        dataType: 'food_logs',
      );

      // Archive step logs
      await _archiveCollectionData(
        userId: userId,
        databaseId: 'fitkarma',
        collectionId: 'step_logs',
        dateField: 'loggedAt',
        cutoffDate: cutoffDate,
        dataType: 'step_logs',
      );

      // Archive sleep logs
      await _archiveCollectionData(
        userId: userId,
        databaseId: 'fitkarma',
        collectionId: 'sleep_logs',
        dateField: 'loggedAt',
        cutoffDate: cutoffDate,
        dataType: 'sleep_logs',
      );

      // Archive mood logs
      await _archiveCollectionData(
        userId: userId,
        databaseId: 'fitkarma',
        collectionId: 'mood_logs',
        dateField: 'loggedAt',
        cutoffDate: cutoffDate,
        dataType: 'mood_logs',
      );

      // Archive body measurements
      await _archiveCollectionData(
        userId: userId,
        databaseId: 'fitkarma',
        collectionId: 'body_measurements',
        dateField: 'loggedAt',
        cutoffDate: cutoffDate,
        dataType: 'body_measurements',
      );

      debugPrint('Data archival completed for user: $userId');
    } catch (e) {
      debugPrint('Error archiving data: $e');
    }
  }

  /// Archive data from a specific collection
  Future<void> _archiveCollectionData({
    required String userId,
    required String databaseId,
    required String collectionId,
    required String dateField,
    required DateTime cutoffDate,
    required String dataType,
  }) async {
    try {
      // Get records older than cutoff date
      final response = await _databases.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
        queries: [
          appwrite.Query.equal('userId', userId),
          appwrite.Query.lessThan(dateField, cutoffDate.toIso8601String()),
        ],
      );

      if (response.documents.isEmpty) {
        return;
      }

      // Convert documents to map format for archival
      final List<Map<String, dynamic>> dataToArchive = [];
      final List<String> documentIds = [];

      for (final doc in response.documents) {
        dataToArchive.add(doc.data);
        documentIds.add(doc.$id);
      }

      // Create archival record
      await _subscriptionService.archiveOldData(
        userId: userId,
        dataType: dataType,
        dataToArchive: dataToArchive,
      );

      // Delete archived documents from original collection
      for (final docId in documentIds) {
        try {
          await _databases.deleteDocument(
            databaseId: databaseId,
            collectionId: collectionId,
            documentId: docId,
          );
        } catch (e) {
          debugPrint('Error deleting archived document: $e');
        }
      }

      debugPrint(
        'Archived ${dataToArchive.length} $dataType records for user $userId',
      );
    } catch (e) {
      debugPrint('Error archiving $dataType: $e');
    }
  }

  /// Restore archived data when user upgrades to premium
  Future<void> restoreArchivedData(String userId) async {
    try {
      // Get all archived data
      final archivedDataTypes = [
        'workout_logs',
        'food_logs',
        'step_logs',
        'sleep_logs',
        'mood_logs',
        'body_measurements',
      ];

      for (final dataType in archivedDataTypes) {
        await _restoreDataType(userId, dataType);
      }

      // Delete archived data after restoration
      await _subscriptionService.deleteArchivedData(userId);

      debugPrint('Archived data restored for user: $userId');
    } catch (e) {
      debugPrint('Error restoring archived data: $e');
    }
  }

  /// Restore a specific data type
  Future<void> _restoreDataType(String userId, String dataType) async {
    final collectionMap = {
      'workout_logs': 'workout_logs',
      'food_logs': 'food_logs',
      'step_logs': 'step_logs',
      'sleep_logs': 'sleep_logs',
      'mood_logs': 'mood_logs',
      'body_measurements': 'body_measurements',
    };

    final collectionId = collectionMap[dataType];
    if (collectionId == null) return;

    try {
      final archivedData = await _subscriptionService.getArchivedData(
        userId,
        dataType,
      );

      // Restore each archived record
      for (final data in archivedData) {
        // Remove the archived metadata fields if any
        final restoreData = Map<String, dynamic>.from(data);
        restoreData.remove('archivedAt');

        try {
          await _databases.createDocument(
            databaseId: 'fitkarma',
            collectionId: collectionId,
            documentId:
                'restored_${DateTime.now().millisecondsSinceEpoch}_${data['id'] ?? ''}',
            data: restoreData,
            permissions: [
              appwrite.Permission.read(appwrite.Role.user(userId)),
              appwrite.Permission.write(appwrite.Role.user(userId)),
            ],
          );
        } catch (e) {
          debugPrint('Error restoring document: $e');
        }
      }

      debugPrint('Restored ${archivedData.length} $dataType records');
    } catch (e) {
      debugPrint('Error restoring $dataType: $e');
    }
  }

  /// Get count of archived records
  Future<Map<String, int>> getArchivedDataCounts(String userId) async {
    final archivedDataTypes = [
      'workout_logs',
      'food_logs',
      'step_logs',
      'sleep_logs',
      'mood_logs',
      'body_measurements',
    ];

    final counts = <String, int>{};

    for (final dataType in archivedDataTypes) {
      try {
        final data = await _subscriptionService.getArchivedData(
          userId,
          dataType,
        );
        counts[dataType] = data.length;
      } catch (e) {
        counts[dataType] = 0;
      }
    }

    return counts;
  }

  /// Get data within retention period for free tier users
  Future<List<Map<String, dynamic>>> getActiveData({
    required String userId,
    required String collectionId,
    required String dateField,
    int limit = 100,
  }) async {
    final hasPremium = await _subscriptionService.hasActivePremium(userId);

    // Premium users get all data
    if (hasPremium) {
      try {
        final response = await _databases.listDocuments(
          databaseId: 'fitkarma',
          collectionId: collectionId,
          queries: [
            appwrite.Query.equal('userId', userId),
            appwrite.Query.orderDesc(dateField),
            appwrite.Query.limit(limit),
          ],
        );
        return response.documents.map((d) => d.data).toList();
      } catch (e) {
        debugPrint('Error fetching active data: $e');
        return [];
      }
    }

    // Free tier users only get data within 7 days
    final cutoffDate = DateTime.now().subtract(
      const Duration(days: freeTierRetentionDays),
    );

    try {
      final response = await _databases.listDocuments(
        databaseId: 'fitkarma',
        collectionId: collectionId,
        queries: [
          appwrite.Query.equal('userId', userId),
          appwrite.Query.greaterThan(dateField, cutoffDate.toIso8601String()),
          appwrite.Query.orderDesc(dateField),
          appwrite.Query.limit(limit),
        ],
      );
      return response.documents.map((d) => d.data).toList();
    } catch (e) {
      debugPrint('Error fetching active data: $e');
      return [];
    }
  }
}
