// lib/features/mental_health/data/mood_providers.dart
// Mood Providers - State management for mood logging

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/drift_service.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/mental_health/data/mood_service.dart';
import 'package:fitkarma/features/karma/data/karma_providers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:uuid/uuid.dart';

// Mood service provider
final moodServiceProvider = Provider<MoodService>((ref) {
  final driftService = ref.watch(driftServiceProvider);
  return MoodService(driftService.db);
});

// Mood state
class MoodState {
  final List<MoodLog> logs;
  final bool isLoading;
  final String? error;
  final DateTime selectedDate;

  MoodState({
    this.logs = const [],
    this.isLoading = false,
    this.error,
    DateTime? selectedDate,
  }) : selectedDate = selectedDate ?? DateTime.now();

  MoodState copyWith({
    List<MoodLog>? logs,
    bool? isLoading,
    String? error,
    DateTime? selectedDate,
  }) {
    return MoodState(
      logs: logs ?? this.logs,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

// Simple mood notifier that can be used with Provider
class MoodNotifierSimple {
  final MoodService _service;
  final Ref _ref;
  final _uuid = const Uuid();

  MoodNotifierSimple(this._ref)
    : _service = MoodService(_ref.read(driftServiceProvider).db);

  Future<void> loadMoodLogs(String userId) async {
    // This would update state through the provider
    // For now we'll use a simple approach
  }

  Future<bool> logMood({
    required String userId,
    required int moodScore,
    int? energyLevel,
    int? stressLevel,
    List<String>? tags,
    String? voiceNotePath,
  }) async {
    try {
      await _service.logMood(
        userId: userId,
        moodScore: moodScore,
        energyLevel: energyLevel,
        stressLevel: stressLevel,
        tags: tags,
        voiceNotePath: voiceNotePath,
      );

      // Award +3 XP for mood log
      try {
        final karmaNotifier = _ref.read(karmaNotifierProvider);
        await karmaNotifier.addXp(3, 'mood_log', description: 'Logged mood');
      } catch (e) {
        debugPrint('Failed to award XP: $e');
      }

      return true;
    } catch (e) {
      debugPrint('Failed to log mood: $e');
      return false;
    }
  }

  Future<List<MoodLog>> getMoodLogs(String userId) async {
    return _service.getMoodLogs(userId);
  }

  Future<List<MoodLog>> getMoodLogsInRange(
    String userId,
    DateTime start,
    DateTime end,
  ) async {
    return _service.getMoodLogsInRange(userId, start, end);
  }

  Future<Map<int, int>> getMoodDistributionInRange(
    String userId,
    DateTime start,
    DateTime end,
  ) async {
    return _service.getMoodDistributionInRange(userId, start, end);
  }

  Future<void> deleteMoodLog(String userId, String logId) async {
    await _service.deleteMoodLog(logId);
  }
}

// Mood provider
final moodNotifierProvider = Provider<MoodNotifierSimple>((ref) {
  return MoodNotifierSimple(ref);
});

// Current user ID provider for mood
final moodUserIdProvider = FutureProvider<String?>((ref) async {
  final authService = ref.read(authServiceProvider);
  return authService.getStoredUserId();
});

// Voice note recorder state
enum RecordingState { idle, recording, paused }

class VoiceNoteState {
  final RecordingState recordingState;
  final String? recordedPath;
  final Duration recordingDuration;
  final bool isPlaying;
  final String? error;

  VoiceNoteState({
    this.recordingState = RecordingState.idle,
    this.recordedPath,
    this.recordingDuration = Duration.zero,
    this.isPlaying = false,
    this.error,
  });

  VoiceNoteState copyWith({
    RecordingState? recordingState,
    String? recordedPath,
    Duration? recordingDuration,
    bool? isPlaying,
    String? error,
  }) {
    return VoiceNoteState(
      recordingState: recordingState ?? this.recordingState,
      recordedPath: recordedPath ?? this.recordedPath,
      recordingDuration: recordingDuration ?? this.recordingDuration,
      isPlaying: isPlaying ?? this.isPlaying,
      error: error,
    );
  }
}

// Voice note notifier - manages recording and playback locally only
class VoiceNoteNotifierSimple {
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();
  final _uuid = const Uuid();

  VoiceNoteState _state = VoiceNoteState();
  VoiceNoteState get state => _state;

  VoiceNoteNotifierSimple() {
    _player.onPlayerComplete.listen((_) {
      _state = _state.copyWith(isPlaying: false);
    });
  }

  VoiceNoteState get voiceNoteState => _state;

  Future<void> startRecording() async {
    try {
      if (await _recorder.hasPermission()) {
        final dir = await getApplicationDocumentsDirectory();
        final path = '${dir.path}/voice_notes/${_uuid.v4()}.m4a';

        // Ensure directory exists
        await Directory('${dir.path}/voice_notes').create(recursive: true);

        await _recorder.start(
          const RecordConfig(encoder: AudioEncoder.aacLc),
          path: path,
        );

        _state = _state.copyWith(
          recordingState: RecordingState.recording,
          recordedPath: path,
          recordingDuration: Duration.zero,
        );

        // Start duration tracking
        _updateDuration();
      } else {
        _state = _state.copyWith(error: 'Microphone permission denied');
      }
    } catch (e) {
      _state = _state.copyWith(error: 'Failed to start recording: $e');
    }
  }

  void _updateDuration() async {
    while (_state.recordingState == RecordingState.recording) {
      await Future.delayed(const Duration(seconds: 1));
      if (_state.recordingState == RecordingState.recording) {
        _state = _state.copyWith(
          recordingDuration:
              _state.recordingDuration + const Duration(seconds: 1),
        );
      }
    }
  }

  Future<String?> stopRecording() async {
    try {
      final path = await _recorder.stop();
      _state = _state.copyWith(
        recordingState: RecordingState.idle,
        recordedPath: path,
      );
      return path;
    } catch (e) {
      _state = _state.copyWith(error: 'Failed to stop recording: $e');
      return null;
    }
  }

  Future<void> playRecording() async {
    try {
      if (_state.recordedPath != null) {
        await _player.play(DeviceFileSource(_state.recordedPath!));
        _state = _state.copyWith(isPlaying: true);
      }
    } catch (e) {
      _state = _state.copyWith(error: 'Failed to play recording: $e');
    }
  }

  Future<void> stopPlayback() async {
    await _player.stop();
    _state = _state.copyWith(isPlaying: false);
  }

  void clearRecording() {
    if (_state.recordedPath != null) {
      try {
        File(_state.recordedPath!).deleteSync();
      } catch (_) {}
    }
    _state = VoiceNoteState();
  }

  void dispose() {
    _recorder.dispose();
    _player.dispose();
  }
}

// Voice note provider
final voiceNoteProvider = Provider<VoiceNoteNotifierSimple>((ref) {
  final notifier = VoiceNoteNotifierSimple();
  ref.onDispose(() => notifier.dispose());
  return notifier;
});

// Predefined mood tags
const List<String> moodTags = [
  'Happy',
  'Grateful',
  'Calm',
  'Anxious',
  'Stressed',
  'Sad',
  'Tired',
  'Energetic',
  'Motivated',
  'Frustrated',
  'Peaceful',
  'Hopeful',
  'Lonely',
  'Excited',
  'Relaxed',
];

// Mood emoji mappings
const Map<int, String> moodEmojis = {
  1: '😢',
  2: '😔',
  3: '😐',
  4: '🙂',
  5: '😄',
};

const Map<int, String> moodLabels = {
  1: 'Very Sad',
  2: 'Sad',
  3: 'Neutral',
  4: 'Good',
  5: 'Great',
};
