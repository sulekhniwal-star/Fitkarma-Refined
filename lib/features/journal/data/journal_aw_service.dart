// lib/features/journal/data/journal_aw_service.dart
// Appwrite service for journal entries sync (opt-in only)

import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:flutter/foundation.dart';
import 'package:fitkarma/core/network/appwrite_client.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';

/// Service for syncing journal entries to Appwrite (opt-in only).
///
/// Sync is disabled by default and must be explicitly enabled by the user.
/// When enabled, journal entries are synced with the following rules:
/// - Only sync when user has opted-in to cloud sync
/// - Content is NOT re-encrypted for sync (already encrypted with user's key)
/// - Sentiment scores and mood tags are synced (these are non-sensitive)
/// - Sync uses the same pattern as period tracker
class JournalAwService {
  final AuthAwService _authService = AuthAwService();

  // Cache for user preference (opt-in status)
  bool? _syncEnabledCache;

  /// Get the Appwrite Databases instance
  appwrite.Databases get _databases => AppwriteClient.databases;

  /// Get the database ID
  String get _databaseId => 'fitkarma';

  /// Collection ID for journal entries
  String get _collectionId => 'journal_entries';

  /// Check if sync is enabled for journal
  /// This checks the user's sync preference (stored locally)
  Future<bool> isSyncEnabled(String userId) async {
    // TODO: Check user's sync preference from local storage or user profile
    // For now, check if there's a cached value
    if (_syncEnabledCache != null) {
      return _syncEnabledCache!;
    }

    // Default to false (opt-in only)
    return false;
  }

  /// Enable or disable journal sync (opt-in)
  Future<void> setSyncEnabled(String userId, bool enabled) async {
    // TODO: Save to local storage or user profile
    _syncEnabledCache = enabled;
  }

  /// Sync a single journal entry to Appwrite
  /// Only syncs if sync is enabled
  Future<String?> syncEntry(JournalEntry entry) async {
    final userId = entry.userId;

    if (!await isSyncEnabled(userId)) {
      return null; // Sync disabled
    }

    try {
      // Prepare the document data
      // Note: Content is already encrypted, so we just pass it through
      // We also sync sentiment data which is non-sensitive
      final data = {
        'user_id': entry.userId,
        'title': entry.title,
        'content': entry.content, // Already encrypted with HKDF-derived key
        'prompt_id': entry.promptId,
        'sentiment_score': entry.sentimentScore,
        'mood_tag': entry.moodTag,
        'created_at': entry.createdAt.toIso8601String(),
        'updated_at': entry.updatedAt?.toIso8601String(),
      };

      // Create document in Appwrite
      final result = await _databases.createDocument(
        databaseId: _databaseId,
        collectionId: _collectionId,
        documentId: entry.id,
        data: data,
        permissions: [
          appwrite.Permission.read(appwrite.Role.user(userId)),
          appwrite.Permission.write(appwrite.Role.user(userId)),
        ],
      );

      return result.$id;
    } catch (e) {
      // Log error but don't throw - sync failures should be non-blocking
      debugPrint('Failed to sync journal entry: $e');
      return null;
    }
  }

  /// Sync all pending journal entries
  /// Returns the number of entries synced
  Future<int> syncPendingEntries(List<JournalEntry> entries) async {
    int synced = 0;

    for (final entry in entries) {
      final result = await syncEntry(entry);
      if (result != null) {
        synced++;
      }
    }

    return synced;
  }

  /// Fetch journal entries from Appwrite
  Future<List<Map<String, dynamic>>> fetchEntries(String userId) async {
    if (!await isSyncEnabled(userId)) {
      return [];
    }

    try {
      final result = await _databases.listDocuments(
        databaseId: _databaseId,
        collectionId: _collectionId,
        queries: [appwrite.Query.equal('user_id', userId)],
      );

      return result.documents.map((doc) => doc.data).toList();
    } catch (e) {
      debugPrint('Failed to fetch journal entries: $e');
      return [];
    }
  }

  /// Delete a journal entry from Appwrite
  Future<bool> deleteEntry(String documentId) async {
    try {
      await _databases.deleteDocument(
        databaseId: _databaseId,
        collectionId: _collectionId,
        documentId: documentId,
      );

      return true;
    } catch (e) {
      debugPrint('Failed to delete journal entry from cloud: $e');
      return false;
    }
  }

  /// Update a journal entry in Appwrite
  Future<bool> updateEntry(JournalEntry entry) async {
    final userId = entry.userId;

    if (!await isSyncEnabled(userId)) {
      return false;
    }

    try {
      final data = {
        'title': entry.title,
        'content': entry.content,
        'prompt_id': entry.promptId,
        'sentiment_score': entry.sentimentScore,
        'mood_tag': entry.moodTag,
        'updated_at': entry.updatedAt?.toIso8601String(),
      };

      await _databases.updateDocument(
        databaseId: _databaseId,
        collectionId: _collectionId,
        documentId: entry.id,
        data: data,
      );

      return true;
    } catch (e) {
      debugPrint('Failed to update journal entry in cloud: $e');
      return false;
    }
  }

  /// Get sync status for all entries
  Future<Map<String, String>> getSyncStatus(List<String> entryIds) async {
    final Map<String, String> status = {};

    for (final id in entryIds) {
      try {
        await _databases.getDocument(
          databaseId: _databaseId,
          collectionId: _collectionId,
          documentId: id,
        );

        status[id] = 'synced';
      } catch (e) {
        status[id] = 'local_only';
      }
    }

    return status;
  }
}
