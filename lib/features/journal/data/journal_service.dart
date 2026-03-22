import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/journal/core/sentiment_analyzer.dart';

/// Service for managing journal entries with encryption and sentiment analysis.
/// All content is encrypted using HKDF-derived journal key.
class JournalService {
  final AppDatabase db;
  final SentimentAnalyzer _sentimentAnalyzer = SentimentAnalyzer();

  JournalService(this.db);

  // =============================================================================
  // CRUD Operations
  // =============================================================================

  /// Create a new journal entry with encryption and sentiment analysis
  Future<JournalEntry> createEntry({
    required String userId,
    required String contentJson, // Quill Delta JSON
    String? title,
    String? promptId,
  }) async {
    final now = DateTime.now();
    final id = 'journal_${userId}_${now.millisecondsSinceEpoch}';
    final idempotencyKey = '${userId}_journal_${now.millisecondsSinceEpoch}';

    // Analyze sentiment from plain text content
    final plainText = _extractPlainText(contentJson);
    final sentiment = _sentimentAnalyzer.analyze(plainText);

    final entry = JournalEntriesCompanion.insert(
      id: id,
      userId: userId,
      title: Value(title),
      content: contentJson, // Will be encrypted via converter
      promptId: Value(promptId),
      sentimentScore: Value(sentiment.score),
      moodTag: Value(sentiment.label),
      createdAt: now,
      updatedAt: Value(null),
      syncStatus: 'pending',
      idempotencyKey: idempotencyKey,
    );

    await db.into(db.journalEntries).insert(entry);

    // Return the created entry
    final created = await (db.select(
      db.journalEntries,
    )..where((t) => t.id.equals(id))).getSingle();
    return created;
  }

  /// Update an existing journal entry
  Future<void> updateEntry({
    required String id,
    String? contentJson,
    String? title,
  }) async {
    final now = DateTime.now();

    String? sentimentScore;
    String? moodTag;

    if (contentJson != null) {
      final plainText = _extractPlainText(contentJson);
      final sentiment = _sentimentAnalyzer.analyze(plainText);
      sentimentScore = sentiment.score.toString();
      moodTag = sentiment.label;
    }

    await (db.update(db.journalEntries)..where((t) => t.id.equals(id))).write(
      JournalEntriesCompanion(
        title: title != null ? Value(title) : const Value.absent(),
        content: contentJson != null
            ? Value(contentJson)
            : const Value.absent(),
        sentimentScore: sentimentScore != null
            ? Value(double.tryParse(sentimentScore))
            : const Value.absent(),
        moodTag: moodTag != null ? Value(moodTag) : const Value.absent(),
        updatedAt: Value(now),
        syncStatus: const Value('pending'),
      ),
    );
  }

  /// Delete a journal entry
  Future<void> deleteEntry(String id) async {
    await (db.delete(db.journalEntries)..where((t) => t.id.equals(id))).go();
  }

  /// Get all journal entries for a user
  Future<List<JournalEntry>> getEntries(String userId, {int? limit}) async {
    final query = db.select(db.journalEntries)
      ..where((t) => t.userId.equals(userId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);

    if (limit != null) {
      query.limit(limit);
    }

    return query.get();
  }

  /// Get a single journal entry by ID
  Future<JournalEntry?> getEntry(String id) async {
    final query = db.select(db.journalEntries)..where((t) => t.id.equals(id));

    try {
      return await query.getSingle();
    } catch (e) {
      return null;
    }
  }

  /// Get journal entries for a specific date range
  Future<List<JournalEntry>> getEntriesInRange(
    String userId,
    DateTime start,
    DateTime end,
  ) async {
    return (db.select(db.journalEntries)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.createdAt.isBiggerOrEqualValue(start) &
                t.createdAt.isSmallerOrEqualValue(end),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  /// Get journal entries by mood tag
  Future<List<JournalEntry>> getEntriesByMood(
    String userId,
    String moodTag,
  ) async {
    return (db.select(db.journalEntries)
          ..where((t) => t.userId.equals(userId) & t.moodTag.equals(moodTag))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  /// Get entries from a specific prompt
  Future<List<JournalEntry>> getEntriesByPrompt(
    String userId,
    String promptId,
  ) async {
    return (db.select(db.journalEntries)
          ..where((t) => t.userId.equals(userId) & t.promptId.equals(promptId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  /// Get recent entries with sentiment scores for insights
  Future<List<JournalEntry>> getRecentEntriesWithSentiment(
    String userId, {
    int days = 30,
  }) async {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    return (db.select(db.journalEntries)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.createdAt.isBiggerOrEqualValue(cutoff) &
                t.sentimentScore.isNotNull(),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  /// Mark entry as synced
  Future<void> markAsSynced(String id, {String? appwriteDocId}) async {
    await (db.update(db.journalEntries)..where((t) => t.id.equals(id))).write(
      JournalEntriesCompanion(
        syncStatus: const Value('synced'),
        fieldVersions: const Value.absent(),
      ),
    );
  }

  /// Get pending entries for sync
  Future<List<JournalEntry>> getPendingEntries() async {
    return (db.select(
      db.journalEntries,
    )..where((t) => t.syncStatus.equals('pending'))).get();
  }

  // =============================================================================
  // Helper Methods
  // =============================================================================

  /// Extract plain text from Quill Delta JSON
  String _extractPlainText(String deltaJson) {
    try {
      final List<dynamic> delta = json.decode(deltaJson);
      final buffer = StringBuffer();

      for (final op in delta) {
        if (op is Map && op.containsKey('insert')) {
          final insert = op['insert'];
          if (insert is String) {
            buffer.write(insert);
          }
        }
      }

      return buffer.toString().trim();
    } catch (e) {
      // If not valid delta, treat as plain text
      return deltaJson;
    }
  }

  /// Get weekly prompt for the current week
  static String getWeeklyPromptId() {
    final now = DateTime.now();
    // Use week number of year to cycle through prompts
    final weekNumber = _weekNumber(now);
    final promptIndex = weekNumber % _weeklyPrompts.length;
    return _weeklyPrompts[promptIndex]['id']!;
  }

  static int _weekNumber(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysDiff = date.difference(firstDayOfYear).inDays;
    return ((daysDiff + firstDayOfYear.weekday - 1) / 7).ceil();
  }

  static final List<Map<String, String>> _weeklyPrompts = [
    {
      'id': 'prompt_gratitude',
      'title': 'Gratitude',
      'text': 'What are you grateful for today?',
    },
    {
      'id': 'prompt_self_care',
      'title': 'Self-Care',
      'text': 'How did you take care of yourself today?',
    },
    {
      'id': 'prompt_goals',
      'title': 'Goals',
      'text': 'What progress did you make towards your goals?',
    },
    {
      'id': 'prompt_emotions',
      'title': 'Emotions',
      'text': 'How are you feeling right now? What caused these feelings?',
    },
    {
      'id': 'prompt_memories',
      'title': 'Memories',
      'text': 'What is a positive memory from this week?',
    },
    {
      'id': 'prompt_learnings',
      'title': 'Learnings',
      'text': 'What did you learn this week?',
    },
    {
      'id': 'prompt_relationships',
      'title': 'Relationships',
      'text': 'How did you connect with others this week?',
    },
    {
      'id': 'prompt_challenges',
      'title': 'Challenges',
      'text': 'What challenges did you face and how did you handle them?',
    },
    {
      'id': 'prompt_joy',
      'title': 'Joy',
      'text': 'What brought you joy this week?',
    },
    {
      'id': 'prompt_growth',
      'title': 'Growth',
      'text': 'How have you grown or changed recently?',
    },
    {
      'id': 'prompt_dreams',
      'title': 'Dreams',
      'text': 'What are you dreaming about lately?',
    },
    {
      'id': 'prompt_mindfulness',
      'title': 'Mindfulness',
      'text': 'What moments of peace did you experience today?',
    },
  ];

  /// Get all weekly prompts
  static List<Map<String, String>> getWeeklyPrompts() => _weeklyPrompts;

  /// Get prompt by ID
  static Map<String, String>? getPromptById(String id) {
    try {
      return _weeklyPrompts.firstWhere((p) => p['id'] == id);
    } catch (e) {
      return null;
    }
  }
}
