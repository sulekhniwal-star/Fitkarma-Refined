// lib/features/mental_health/data/mood_service.dart
// Mood Service for managing mood logs

import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// Mood Service for managing mood logs in the database
class MoodService {
  final AppDatabase db;
  final _uuid = const Uuid();

  MoodService(this.db);

  /// Get voice note path for a mood log (predictable naming convention)
  Future<String> getVoiceNotePath(String moodLogId) async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/voice_notes/$moodLogId.m4a';
  }

  /// Check if voice note exists for a mood log
  Future<bool> hasVoiceNote(String moodLogId) async {
    final path = await getVoiceNotePath(moodLogId);
    return File(path).exists();
  }

  /// Delete voice note file
  Future<void> deleteVoiceNote(String moodLogId) async {
    final path = await getVoiceNotePath(moodLogId);
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Log mood for a specific time
  Future<MoodLog> logMood({
    required String userId,
    required int moodScore, // 1-5 scale
    int? energyLevel, // 1-10 scale
    int? stressLevel, // 1-10 scale
    List<String>? tags,
    String? voiceNotePath, // Temporarily passed for moving the file
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();

    await db
        .into(db.moodLogs)
        .insert(
          MoodLogsCompanion.insert(
            id: id,
            userId: userId,
            loggedAt: now,
            moodScore: moodScore,
            energyLevel: Value(energyLevel),
            stressLevel: Value(stressLevel),
            tags: Value(tags != null ? jsonEncode(tags) : null),
          ),
        );

    // If voice note path provided, move it to the expected location
    if (voiceNotePath != null) {
      final newPath = await getVoiceNotePath(id);
      await Directory(
        '${(await getApplicationDocumentsDirectory()).path}/voice_notes',
      ).create(recursive: true);
      await File(voiceNotePath).rename(newPath);
    }

    final result = await (db.select(
      db.moodLogs,
    )..where((t) => t.id.equals(id))).getSingle();
    return result;
  }

  /// Update an existing mood log
  Future<void> updateMoodLog({
    required String logId,
    int? moodScore,
    int? energyLevel,
    int? stressLevel,
    List<String>? tags,
  }) async {
    final updates = <MoodLogsCompanion>{
      if (moodScore != null) MoodLogsCompanion(moodScore: Value(moodScore)),
      if (energyLevel != null)
        MoodLogsCompanion(energyLevel: Value(energyLevel)),
      if (stressLevel != null)
        MoodLogsCompanion(stressLevel: Value(stressLevel)),
      if (tags != null) MoodLogsCompanion(tags: Value(jsonEncode(tags))),
    };

    if (updates.isNotEmpty) {
      await (db.update(db.moodLogs)..where((t) => t.id.equals(logId))).write(
        updates.reduce(
          (a, b) => MoodLogsCompanion(
            id: a.id,
            moodScore: a.moodScore,
            energyLevel: a.energyLevel,
            stressLevel: a.stressLevel,
            tags: a.tags,
          ),
        ),
      );
    }
  }

  /// Delete a mood log
  Future<void> deleteMoodLog(String logId) async {
    // Delete associated voice note if exists
    await deleteVoiceNote(logId);
    await (db.delete(db.moodLogs)..where((t) => t.id.equals(logId))).go();
  }

  /// Get mood log by ID
  Future<MoodLog?> getMoodLog(String logId) async {
    return (await (db.select(
      db.moodLogs,
    )..where((t) => t.id.equals(logId))).getSingleOrNull());
  }

  /// Get all mood logs for a user
  Future<List<MoodLog>> getMoodLogs(String userId) async {
    return (await (db.select(db.moodLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .get());
  }

  /// Get mood logs for a date range
  Future<List<MoodLog>> getMoodLogsInRange(
    String userId,
    DateTime start,
    DateTime end,
  ) async {
    return (await (db.select(db.moodLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.loggedAt.isBiggerOrEqualValue(start))
          ..where((t) => t.loggedAt.isSmallerThanValue(end))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .get());
  }

  /// Get mood logs for a specific date
  Future<List<MoodLog>> getMoodLogsForDate(String userId, DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    return getMoodLogsInRange(userId, startOfDay, endOfDay);
  }

  /// Get average mood score for a date range
  Future<double?> getAverageMoodInRange(
    String userId,
    DateTime start,
    DateTime end,
  ) async {
    final logs = await getMoodLogsInRange(userId, start, end);
    if (logs.isEmpty) return null;

    final total = logs.fold<int>(0, (sum, log) => sum + log.moodScore);
    return total / logs.length;
  }

  /// Get mood distribution for a date range (count of each mood score)
  Future<Map<int, int>> getMoodDistributionInRange(
    String userId,
    DateTime start,
    DateTime end,
  ) async {
    final logs = await getMoodLogsInRange(userId, start, end);
    final distribution = <int, int>{1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

    for (final log in logs) {
      distribution[log.moodScore] = (distribution[log.moodScore] ?? 0) + 1;
    }

    return distribution;
  }

  /// Parse tags from JSON string
  List<String>? parseTags(String? tagsJson) {
    if (tagsJson == null) return null;
    try {
      return List<String>.from(jsonDecode(tagsJson));
    } catch (e) {
      return null;
    }
  }
}
