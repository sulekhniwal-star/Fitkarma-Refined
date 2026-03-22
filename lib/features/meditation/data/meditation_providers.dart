// lib/features/meditation/data/meditation_providers.dart
// Riverpod providers for meditation feature

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/meditation/data/pranayama_models.dart';
import 'package:fitkarma/features/meditation/data/pranayama_data.dart';
import 'package:fitkarma/features/meditation/data/pranayama_service.dart';

/// Current user ID provider (mock - would come from auth)
final meditationUserIdProvider = Provider<String>((ref) {
  return 'demo_user_123';
});

/// Pranayama service provider
final pranayamaServiceProvider = Provider<PranayamaService>((ref) {
  return PranayamaService();
});

/// Meditation stats service provider
final meditationStatsProvider = Provider<MeditationStatsService>((ref) {
  return MeditationStatsService();
});

/// All pranyamas provider
final pranyamasProvider = Provider<List<Pranayama>>((ref) {
  return PranayamaData.pranyamas;
});

/// All guided sessions provider
final guidedSessionsProvider = Provider<List<GuidedSession>>((ref) {
  return PranayamaData.guidedSessions;
});

/// Sessions by duration providers
final sessions5MinProvider = Provider<List<GuidedSession>>((ref) {
  return PranayamaData.getByDuration(5);
});

final sessions10MinProvider = Provider<List<GuidedSession>>((ref) {
  return PranayamaData.getByDuration(10);
});

final sessions15MinProvider = Provider<List<GuidedSession>>((ref) {
  return PranayamaData.getByDuration(15);
});

final sessions20MinProvider = Provider<List<GuidedSession>>((ref) {
  return PranayamaData.getByDuration(20);
});

/// User meditation stats
final userMeditationStatsProvider = Provider<MeditationSessionStats>((ref) {
  final statsService = ref.watch(meditationStatsProvider);
  final odUserId = ref.watch(meditationUserIdProvider);
  return statsService.getStats(odUserId);
});

/// Breathing session notifier
class BreathingSessionNotifier extends Notifier<BreathingSessionState> {
  late PranayamaService _service;

  @override
  BreathingSessionState build() {
    _service = ref.read(pranayamaServiceProvider);
    _service.onStateChange = (newState) {
      state = newState;
    };
    return const BreathingSessionState();
  }

  void startExercise(Pranayama exercise, {int? cycles}) {
    _service.startExercise(exercise, cycles: cycles);
  }

  void pause() {
    _service.pause();
  }

  void resume() {
    _service.resume();
  }

  void stop() {
    _service.stop();
  }

  void skip() {
    _service.skipToNextPhase();
  }

  void completeSession() {
    final statsService = ref.read(meditationStatsProvider);
    final odUserId = ref.read(meditationUserIdProvider);
    final exercise = state.exercise;
    
    if (exercise != null) {
      final duration = (exercise.cycleDuration * state.totalCycles) ~/ 60;
      statsService.recordSession(odUserId, duration);
    }
  }

  int calculateXp() {
    final statsService = ref.read(meditationStatsProvider);
    final odUserId = ref.read(meditationUserIdProvider);
    final stats = statsService.getStats(odUserId);
    final exercise = state.exercise;
    
    if (exercise == null) return 0;
    
    final duration = (exercise.cycleDuration * state.totalCycles) ~/ 60;
    return statsService.calculateXp(duration, stats.currentStreak);
  }
}

/// Breathing session provider
final breathingSessionProvider = NotifierProvider<BreathingSessionNotifier, BreathingSessionState>(
  BreathingSessionNotifier.new,
);

/// Quick 3-min stress relief exercise
final stressReliefExerciseProvider = Provider<Pranayama>((ref) {
  // Return 4-7-8 breathing for stress relief
  return PranayamaData.pranyamas.firstWhere(
    (p) => p.id == 'relaxing_breath',
    orElse: () => PranayamaData.pranyamas.first,
  );
});

/// Check if mood-triggered breathing should activate (stress_level > 7)
bool shouldTriggerBreathingExercise(int stressLevel) {
  return stressLevel > 7;
}