import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../core/storage/app_database.dart';
import '../../../core/di/providers.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/sync_queue.dart';
import '../../auth/data/auth_repository.dart';
import '../../karma/data/karma_service.dart';
import '../../../core/security/encryption_service.dart';

part 'lifestyle_repository.g.dart';

@Riverpod(keepAlive: true)
class LifestyleRepository extends _$LifestyleRepository {
  @override
  void build() {}

  AppDatabase get _db => ref.read(databaseProvider);

  Future<void> saveSleepLog({
    required DateTime date,
    required String bedtime,
    required String wakeTime,
    required int qualityScore,
    int? deepSleepMin,
    int? sleepDebtMin,
  }) async {
    final user = ref.read(currentUserProvider).asData?.value;
    if (user == null) return;

    final id = const Uuid().v4();
    
    // Calculate duration in minutes
    final bedParts = bedtime.split(':');
    final wakeParts = wakeTime.split(':');
    var bedHour = int.parse(bedParts[0]);
    var wakeHour = int.parse(wakeParts[0]);
    if (wakeHour < bedHour) wakeHour += 24;
    final durationMin = (wakeHour * 60 + int.parse(wakeParts[1])) - (bedHour * 60 + int.parse(bedParts[1]));

    final companion = SleepLogsCompanion.insert(
      id: id,
      userId: user.$id,
      date: date,
      bedtime: bedtime,
      wakeTime: wakeTime,
      durationMin: durationMin,
      qualityScore: qualityScore,
      deepSleepMin: Value(deepSleepMin),
      sleepDebtMin: Value(sleepDebtMin),
      source: 'manual',
    );

    await _db.into(_db.sleepLogs).insert(companion);

    await ref.read(syncQueueRepositoryProvider.notifier).addToQueue(
      collectionId: AW.sleepLogs,
      operation: 'create',
      localId: id,
      payload: {
        'userId': user.$id,
        'date': date.toIso8601String(),
        'bedtime': bedtime,
        'wakeTime': wakeTime,
        'durationMin': durationMin,
        'qualityScore': qualityScore,
        'deepSleepMin': deepSleepMin,
        'sleepDebtMin': sleepDebtMin,
        'source': 'manual',
      },
      priority: SyncPriority.normal,
    );

    await ref.read(karmaServiceProvider.notifier).grantXP(KarmaAction.sleepLog);
  }

  Future<void> saveMoodLog({
    required int score,
    int? energyLevel,
    int? stressLevel,
    int? screenTimeMin,
    List<String>? tags,
    String? notes,
  }) async {
    final user = ref.read(currentUserProvider).asData?.value;
    if (user == null) return;

    final id = const Uuid().v4();
    final companion = MoodLogsCompanion.insert(
      id: id,
      userId: user.$id,
      score: score,
      energyLevel: Value(energyLevel),
      stressLevel: Value(stressLevel),
      screenTimeMin: Value(screenTimeMin),
      tags: Value(tags != null ? jsonEncode(tags) : null),
      notes: Value(notes),
      loggedAt: DateTime.now(),
    );

    await _db.into(_db.moodLogs).insert(companion);

    await ref.read(syncQueueRepositoryProvider.notifier).addToQueue(
      collectionId: AW.moodLogs,
      operation: 'create',
      localId: id,
      payload: {
        'userId': user.$id,
        'score': score,
        'energyLevel': energyLevel,
        'stressLevel': stressLevel,
        'screenTimeMin': screenTimeMin,
        'tags': tags,
        'notes': notes,
        'loggedAt': DateTime.now().toIso8601String(),
      },
      priority: SyncPriority.normal,
    );

    await ref.read(karmaServiceProvider.notifier).grantXP(KarmaAction.moodLog);
  }

  Future<void> saveMedication({
    required String name,
    String? dosage,
    String? frequency,
    required DateTime startDate,
    DateTime? endDate,
  }) async {
    final user = ref.read(currentUserProvider).asData?.value;
    if (user == null) return;

    final id = const Uuid().v4();
    final companion = MedicationsCompanion.insert(
      id: id,
      userId: user.$id,
      name: name,
      dosage: Value(dosage),
      frequency: Value(frequency),
      startDate: startDate,
      endDate: Value(endDate),
      isActive: const Value(true),
    );

    await _db.into(_db.medications).insert(companion);

    await ref.read(syncQueueRepositoryProvider.notifier).addToQueue(
      collectionId: AW.medications,
      operation: 'create',
      localId: id,
      payload: {
        'userId': user.$id,
        'name': name,
        'dosage': dosage,
        'frequency': frequency,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'isActive': true,
      },
      priority: SyncPriority.normal,
    );
  }

  Future<void> completeHabit(String habitId, {int count = 1}) async {
    final id = const Uuid().v4();
    final now = DateTime.now();

    final companion = HabitCompletionsCompanion.insert(
      id: id,
      habitId: habitId,
      completedDate: now,
      count: Value(count),
    );

    await _db.into(_db.habitCompletions).insert(companion);

    await ref.read(karmaServiceProvider.notifier).grantXP(KarmaAction.habitComplete);
  }

  Future<void> saveFastingLog({
    required DateTime startTime,
    DateTime? endTime,
    required String fastingType,
    bool isCompleted = false,
  }) async {
    final user = ref.read(currentUserProvider).asData?.value;
    if (user == null) return;

    final id = const Uuid().v4();
    final companion = FastingLogsCompanion.insert(
      id: id,
      userId: user.$id,
      startTime: startTime,
      endTime: Value(endTime),
      fastingType: fastingType,
      isCompleted: Value(isCompleted),
    );

    await _db.into(_db.fastingLogs).insert(companion);

    await ref.read(syncQueueRepositoryProvider.notifier).addToQueue(
      collectionId: AW.fastingLogs,
      operation: 'create',
      localId: id,
      payload: {
        'userId': user.$id,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime?.toIso8601String(),
        'fastingType': fastingType,
        'isCompleted': isCompleted,
      },
      priority: SyncPriority.normal,
    );
  }

  Future<void> saveJournalEntry({
    required String content,
    List<String>? moodTags,
  }) async {
    final user = ref.read(currentUserProvider).asData?.value;
    if (user == null) return;

    final id = const Uuid().v4();
    final encryption = ref.read(encryptionServiceProvider('journal'));
    final encryptedContent = await encryption.encrypt(content);

    final now = DateTime.now();
    final companion = JournalEntriesCompanion.insert(
      id: id,
      userId: user.$id,
      content: encryptedContent,
      moodTags: Value(moodTags != null ? jsonEncode(moodTags) : null),
      createdAt: now,
      updatedAt: now,
    );

    await _db.into(_db.journalEntries).insert(companion);

    await ref.read(syncQueueRepositoryProvider.notifier).addToQueue(
      collectionId: AW.journalEntries,
      operation: 'create',
      localId: id,
      payload: {
        'userId': user.$id,
        'content': encryptedContent,
        'moodTags': moodTags,
        'createdAt': now.toIso8601String(),
      },
      priority: SyncPriority.normal,
    );
  }
}
