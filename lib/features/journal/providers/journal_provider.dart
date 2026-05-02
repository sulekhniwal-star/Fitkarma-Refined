import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../auth/providers/auth_provider.dart';
import '../../habit/providers/habit_provider.dart';
import '../../steps/providers/steps_provider.dart';

part 'journal_provider.g.dart';

@riverpod
class JournalNotifier extends _$JournalNotifier {
  @override
  FutureOr<List<JournalEntry>> build() async {
    final authState = ref.watch(authProvider);
    final user = authState.asData?.value;
    if (user == null) return [];

    return ref.read(appDatabaseProvider).getJournalEntries(user.$id);
  }

  Future<void> createEntry({
    String? title,
    required String body,
    int? moodScore,
    String? moodEmoji,
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
      title: Value(title),
      body: body,
      moodEmoji: Value(moodEmoji),
      moodScore: Value(moodScore),
      tagsJson: Value(tags != null ? jsonEncode(tags) : null),
      createdAt: DateTime.now(),
    );

    await db.into(db.journalEntries).insert(companion);
    ref.invalidateSelf();
  }

  Future<void> updateEntry(String id, {String? title, String? body}) async {
    final db = ref.read(appDatabaseProvider);
    await (db.update(db.journalEntries)..where((t) => t.id.equals(id))).write(
      JournalEntriesCompanion(
        title: title != null ? Value(title) : const Value.absent(),
        body: body != null ? Value(body) : const Value.absent(),
      ),
    );
    ref.invalidateSelf();
  }

  Future<void> deleteEntry(String id) async {
    final db = ref.read(appDatabaseProvider);
    await (db.delete(db.journalEntries)..where((t) => t.id.equals(id))).go();
    ref.invalidateSelf();
  }
}

@riverpod
Future<List<JournalEntry>> journalEntries(Ref ref, {int limit = 20, int offset = 0}) async {
  final authState = ref.watch(authProvider);
  final user = authState.asData?.value;
  if (user == null) return [];

  return ref.watch(appDatabaseProvider).getJournalEntries(user.$id, limit: limit, offset: offset);
}

@riverpod
String journalPrompt(Ref ref) {
  final steps = ref.watch(stepsProvider).asData?.value ?? 0;
  final habits = ref.watch(todayHabitsProvider).asData?.value ?? [];
  
  final todayStr = DateTime.now().toIso8601String().substring(0, 10);
  final completedHabits = habits.where((h) {
    if (h.completedDatesJson == null) return false;
    return h.completedDatesJson!.contains(todayStr);
  }).length;

  if (steps > 10000) {
    return "You've walked over 10,000 steps today! How do your legs feel, and what was the best part of your walk?";
  }
  
  if (completedHabits > 3) {
    return "You're on a roll with your habits today! Which one felt the most rewarding to complete?";
  }

  if (completedHabits == 0 && habits.isNotEmpty) {
    return "It's been a slow day for habits. Is there one small thing you could do now to feel better?";
  }

  return "How are you feeling today? What's one thing you're grateful for?";
}
