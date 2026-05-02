import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../auth/providers/auth_provider.dart';

part 'mood_provider.g.dart';

@riverpod
class MoodNotifier extends _$MoodNotifier {
  @override
  void build() {}

  Future<void> logMood({
    required int score,
    required String emoji,
    List<String>? tags,
  }) async {
    final authState = ref.read(authProvider);
    final user = authState.asData?.value;
    if (user == null) return;

    final db = ref.read(appDatabaseProvider);
    final id = const Uuid().v4();
    
    final companion = JournalEntriesCompanion.insert(
      id: id,
      userId: user.$id,
      body: '[{"insert":"Mood logged\\n"}]', // Empty Quill Delta
      moodEmoji: Value(emoji),
      moodScore: Value(score),
      tagsJson: Value(tags != null ? jsonEncode(tags) : null),
      createdAt: DateTime.now(),
    );

    await db.into(db.journalEntries).insert(companion);
  }
}

@riverpod
Stream<JournalEntry?> todayMood(Ref ref) {
  final authState = ref.watch(authProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value(null);

  return ref.watch(appDatabaseProvider).watchTodayMood(user.$id);
}

@riverpod
Stream<List<JournalEntry>> moodHistory(Ref ref, int days) {
  final authState = ref.watch(authProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value([]);

  return ref.watch(appDatabaseProvider).watchMoodHistory(user.$id, days);
}
