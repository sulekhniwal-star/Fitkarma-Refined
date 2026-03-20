// lib/features/karma/data/karma_aw_service.dart
// Appwrite service for Karma - server is source of truth for balances

import 'dart:async';
import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:flutter/foundation.dart';
import 'package:fitkarma/core/network/appwrite_client.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';
import 'package:fitkarma/features/karma/data/karma_models.dart';

/// Collection IDs for karma-related data
class KarmaCollectionIds {
  static const String transactions = 'karma_transactions';
  static const String profiles = 'karma_profiles';
  static const String databaseId = 'fitkarma';
}

/// Appwrite service for karma operations
/// Server is source of truth for balances
class KarmaAwService {
  final AuthAwService _authService = AuthAwService();

  // Realtime subscription
  StreamSubscription? _realtimeSubscription;
  final _realtimeController =
      StreamController<List<KarmaTransactionRecord>>.broadcast();

  /// Stream of karma transactions from realtime updates
  Stream<List<KarmaTransactionRecord>> get transactionsStream =>
      _realtimeController.stream;

  /// Get the Appwrite Databases instance
  appwrite.Databases get _databases => AppwriteClient.databases;

  /// Get current user ID
  Future<String?> _getUserId() async {
    return await _authService.getStoredUserId();
  }

  /// Create a karma transaction in Appwrite
  Future<String> createTransaction({
    required String userId,
    required int amount,
    required String action,
    String? description,
    required int balanceAfter,
  }) async {
    try {
      final id = 'karma_${DateTime.now().millisecondsSinceEpoch}';

      await _databases.createDocument(
        databaseId: KarmaCollectionIds.databaseId,
        collectionId: KarmaCollectionIds.transactions,
        documentId: id,
        data: {
          'userId': userId,
          'amount': amount,
          'type': action,
          'reason': description ?? action,
          'createdAt': DateTime.now().toIso8601String(),
        },
      );

      return id;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Create karma transaction failed: ${e.message}');
      rethrow;
    }
  }

  /// Get karma transactions for a user
  Future<List<KarmaTransactionRecord>> getTransactions(
    String userId, {
    int limit = 50,
  }) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: KarmaCollectionIds.databaseId,
        collectionId: KarmaCollectionIds.transactions,
        queries: [
          appwrite.Query.equal('userId', userId),
          appwrite.Query.orderDesc('createdAt'),
          appwrite.Query.limit(limit),
        ],
      );

      return response.documents
          .map(
            (doc) => KarmaTransactionRecord(
              id: doc.$id,
              userId: doc.data['userId'] as String,
              amount: doc.data['amount'] as int,
              action: doc.data['type'] as String,
              description: doc.data['reason'] as String?,
              balanceAfter: doc.data['amount'] as int,
              createdAt: DateTime.parse(doc.data['createdAt'] as String),
            ),
          )
          .toList();
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get karma transactions failed: ${e.message}');
      return [];
    }
  }

  /// Get user's total XP from all transactions (server is source of truth)
  Future<int> getTotalXp(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: KarmaCollectionIds.databaseId,
        collectionId: KarmaCollectionIds.transactions,
        queries: [
          appwrite.Query.equal('userId', userId),
          appwrite.Query.orderDesc('createdAt'),
          appwrite.Query.limit(1000),
        ],
      );

      int total = 0;
      for (final doc in response.documents) {
        total += doc.data['amount'] as int;
      }

      return total;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get total XP failed: ${e.message}');
      return 0;
    }
  }

  /// Sync karma profile from server
  Future<Map<String, dynamic>?> getKarmaProfile(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: KarmaCollectionIds.databaseId,
        collectionId: KarmaCollectionIds.profiles,
        queries: [appwrite.Query.equal('userId', userId)],
      );

      if (response.documents.isEmpty) {
        return null;
      }

      return response.documents.first.data;
    } on appwrite.AppwriteException catch (e) {
      if (e.code == 404) {
        return null;
      }
      debugPrint('Get karma profile failed: ${e.message}');
      return null;
    }
  }

  /// Create or update karma profile in Appwrite
  Future<void> upsertKarmaProfile({
    required String userId,
    required int totalXp,
    required int level,
    required int currentStreak,
    required int longestStreak,
    DateTime? lastActivityDate,
  }) async {
    try {
      final existing = await getKarmaProfile(userId);

      if (existing != null) {
        await _databases.updateDocument(
          databaseId: KarmaCollectionIds.databaseId,
          collectionId: KarmaCollectionIds.profiles,
          documentId: existing['\$id'] as String,
          data: {
            'totalXp': totalXp,
            'level': level,
            'currentStreak': currentStreak,
            'longestStreak': longestStreak,
            'lastActivityDate': lastActivityDate?.toIso8601String(),
            'updatedAt': DateTime.now().toIso8601String(),
          },
        );
      } else {
        await _databases.createDocument(
          databaseId: KarmaCollectionIds.databaseId,
          collectionId: KarmaCollectionIds.profiles,
          documentId: 'karma_profile_$userId',
          data: {
            'userId': userId,
            'totalXp': totalXp,
            'level': level,
            'currentStreak': currentStreak,
            'longestStreak': longestStreak,
            'lastActivityDate': lastActivityDate?.toIso8601String(),
            'createdAt': DateTime.now().toIso8601String(),
            'updatedAt': DateTime.now().toIso8601String(),
          },
        );
      }
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Upsert karma profile failed: ${e.message}');
      rethrow;
    }
  }

  /// Subscribe to realtime karma transactions
  Future<void> subscribeToKarmaTransactions(String userId) async {
    try {
      await _realtimeSubscription?.cancel();

      _realtimeSubscription = AppwriteClient.realtime
          .subscribe([
            'databases.${KarmaCollectionIds.databaseId}.collections.${KarmaCollectionIds.transactions}.documents',
          ])
          .stream
          .listen((event) async {
            final payload = event.payload;
            if (payload['userId'] == userId) {
              final transactions = await getTransactions(userId);
              _realtimeController.add(transactions);
            }
          });

      debugPrint('Subscribed to karma transactions realtime');
    } catch (e) {
      debugPrint('Failed to subscribe to karma transactions: $e');
    }
  }

  /// Unsubscribe from realtime updates
  Future<void> unsubscribeFromKarmaTransactions() async {
    await _realtimeSubscription?.cancel();
    _realtimeSubscription = null;
  }

  /// Get leaderboard data (friends, city, national)
  Future<List<LeaderboardEntry>> getLeaderboard({
    required String userId,
    required String type,
    int limit = 10,
  }) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: KarmaCollectionIds.databaseId,
        collectionId: KarmaCollectionIds.profiles,
        queries: [
          appwrite.Query.orderDesc('totalXp'),
          appwrite.Query.limit(limit),
        ],
      );

      return response.documents.asMap().entries.map((entry) {
        final doc = entry.value;
        final rank = entry.key + 1;
        return LeaderboardEntry(
          oderId: doc.$id,
          userName: doc.data['userId'] as String? ?? 'Unknown',
          level: doc.data['level'] as int? ?? 1,
          weeklyXp: doc.data['totalXp'] as int? ?? 0,
          rank: rank,
        );
      }).toList();
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get leaderboard failed: ${e.message}');
      return [];
    }
  }

  /// Dispose of resources
  void dispose() {
    _realtimeSubscription?.cancel();
    _realtimeController.close();
  }
}
