import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/core/storage/drift_service.dart';
import 'package:fitkarma/features/journal/data/journal_service.dart';
import 'package:fitkarma/features/journal/core/sentiment_analyzer.dart';

/// Provider for journal service
final journalServiceProvider = Provider<JournalService>((ref) {
  final driftService = ref.watch(driftServiceProvider);
  return JournalService(driftService.db);
});

/// Provider for sentiment analyzer
final sentimentAnalyzerProvider = Provider<SentimentAnalyzer>((ref) {
  return SentimentAnalyzer();
});

/// Provider for getting all journal entries for a user
final journalEntriesProvider =
    FutureProvider.family<List<JournalEntry>, String>((ref, userId) async {
      final service = ref.watch(journalServiceProvider);
      return service.getEntries(userId);
    });

/// Provider for getting a single journal entry
final journalEntryProvider = FutureProvider.family<JournalEntry?, String>((
  ref,
  id,
) async {
  final service = ref.watch(journalServiceProvider);
  return service.getEntry(id);
});

/// Provider for recent journal entries with sentiment (for insights)
final recentJournalWithSentimentProvider =
    FutureProvider.family<List<JournalEntry>, String>((ref, userId) async {
      final service = ref.watch(journalServiceProvider);
      return service.getRecentEntriesWithSentiment(userId);
    });

/// Provider for the current week's prompt
final weeklyPromptProvider = Provider<Map<String, String>>((ref) {
  final promptId = JournalService.getWeeklyPromptId();
  return JournalService.getPromptById(promptId) ??
      {'id': promptId, 'title': 'Reflection', 'text': 'How was your day?'};
});

/// Provider for all weekly prompts
final allWeeklyPromptsProvider = Provider<List<Map<String, String>>>((ref) {
  return JournalService.getWeeklyPrompts();
});

/// Provider for journal entries by mood
final journalEntriesByMoodProvider =
    FutureProvider.family<List<JournalEntry>, JournalMoodRequest>((
      ref,
      request,
    ) async {
      final service = ref.watch(journalServiceProvider);
      return service.getEntriesByMood(request.userId, request.mood);
    });

/// Request model for journal entries by mood
class JournalMoodRequest {
  final String userId;
  final String mood;

  JournalMoodRequest({required this.userId, required this.mood});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalMoodRequest &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          mood == other.mood;

  @override
  int get hashCode => userId.hashCode ^ mood.hashCode;
}
