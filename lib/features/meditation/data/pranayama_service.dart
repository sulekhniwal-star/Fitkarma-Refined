// lib/features/meditation/data/pranayama_service.dart
// Breathing session service with timer management

import 'dart:async';
import 'package:fitkarma/features/meditation/data/pranayama_models.dart';
import 'package:fitkarma/features/meditation/data/pranayama_data.dart';

/// Service to manage breathing exercise sessions
class PranayamaService {
  Timer? _timer;
  BreathingSessionState _state = const BreathingSessionState();

  /// Callback for state updates
  void Function(BreathingSessionState)? onStateChange;

  /// Get current state
  BreathingSessionState get currentState => _state;

  /// Start a breathing exercise
  void startExercise(Pranayama exercise, {int? cycles}) {
    final totalCycles = cycles ?? exercise.recommendedCycles;

    _state = BreathingSessionState(
      exercise: exercise,
      currentCycle: 1,
      totalCycles: totalCycles,
      phase: BreathingPhase.inhale,
      secondsRemaining: exercise.inhaleSeconds,
      isActive: true,
      isPaused: false,
      startTime: DateTime.now(),
    );

    onStateChange?.call(_state);
    _startTimer();
  }

  /// Pause the session
  void pause() {
    _timer?.cancel();
    _state = _state.copyWith(isPaused: true);
    onStateChange?.call(_state);
  }

  /// Resume the session
  void resume() {
    _state = _state.copyWith(isPaused: false);
    onStateChange?.call(_state);
    _startTimer();
  }

  /// Stop and reset the session
  void stop() {
    _timer?.cancel();
    _state = const BreathingSessionState();
    onStateChange?.call(_state);
  }

  /// Skip to next phase
  void skipToNextPhase() {
    _timer?.cancel();
    _moveToNextPhase();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    if (_state.isPaused || _state.exercise == null) return;

    final exercise = _state.exercise!;
    int newSeconds = _state.secondsRemaining - 1;

    if (newSeconds <= 0) {
      _moveToNextPhase();
    } else {
      _state = _state.copyWith(secondsRemaining: newSeconds);
      onStateChange?.call(_state);
    }
  }

  void _moveToNextPhase() {
    final exercise = _state.exercise!;
    BreathingPhase nextPhase;
    int nextSeconds;
    int newCycle = _state.currentCycle;

    switch (_state.phase) {
      case BreathingPhase.inhale:
        if (exercise.holdAfterInhaleSeconds > 0) {
          nextPhase = BreathingPhase.holdAfterInhale;
          nextSeconds = exercise.holdAfterInhaleSeconds;
        } else {
          nextPhase = BreathingPhase.exhale;
          nextSeconds = exercise.exhaleSeconds;
        }
        break;

      case BreathingPhase.holdAfterInhale:
        nextPhase = BreathingPhase.exhale;
        nextSeconds = exercise.exhaleSeconds;
        break;

      case BreathingPhase.exhale:
        if (exercise.holdAfterExhaleSeconds > 0) {
          nextPhase = BreathingPhase.holdAfterExhale;
          nextSeconds = exercise.holdAfterExhaleSeconds;
        } else {
          // Cycle complete
          if (_state.currentCycle >= _state.totalCycles) {
            _completeSession();
            return;
          }
          nextPhase = BreathingPhase.inhale;
          nextSeconds = exercise.inhaleSeconds;
          newCycle = _state.currentCycle + 1;
        }
        break;

      case BreathingPhase.holdAfterExhale:
        // Cycle complete
        if (_state.currentCycle >= _state.totalCycles) {
          _completeSession();
          return;
        }
        nextPhase = BreathingPhase.inhale;
        nextSeconds = exercise.inhaleSeconds;
        newCycle = _state.currentCycle + 1;
        break;

      default:
        return;
    }

    _state = _state.copyWith(
      phase: nextPhase,
      secondsRemaining: nextSeconds,
      currentCycle: newCycle,
    );
    onStateChange?.call(_state);
    _startTimer();
  }

  void _completeSession() {
    _timer?.cancel();
    _state = _state.copyWith(phase: BreathingPhase.completed, isActive: false);
    onStateChange?.call(_state);
  }

  /// Get phase display text
  static String getPhaseText(BreathingPhase phase, int seconds) {
    switch (phase) {
      case BreathingPhase.inhale:
        return 'Inhale';
      case BreathingPhase.holdAfterInhale:
        return 'Hold';
      case BreathingPhase.exhale:
        return 'Exhale';
      case BreathingPhase.holdAfterExhale:
        return 'Hold';
      case BreathingPhase.completed:
        return 'Complete!';
      case BreathingPhase.idle:
        return 'Ready';
    }
  }

  /// Get phase instruction
  static String getPhaseInstruction(BreathingPhase phase) {
    switch (phase) {
      case BreathingPhase.inhale:
        return 'Breathe in slowly through your nose';
      case BreathingPhase.holdAfterInhale:
        return 'Hold your breath gently';
      case BreathingPhase.exhale:
        return 'Exhale slowly through your mouth';
      case BreathingPhase.holdAfterExhale:
        return 'Hold with empty lungs';
      case BreathingPhase.completed:
        return 'Great job! Session complete';
      case BreathingPhase.idle:
        return 'Tap Start to begin';
    }
  }

  /// Get countdown text for display
  static String getCountdownText(BreathingPhase phase, int seconds) {
    switch (phase) {
      case BreathingPhase.inhale:
      case BreathingPhase.exhale:
      case BreathingPhase.holdAfterInhale:
      case BreathingPhase.holdAfterExhale:
        return '$seconds';
      default:
        return '';
    }
  }

  /// Dispose resources
  void dispose() {
    _timer?.cancel();
  }
}

/// Statistics service for tracking meditation sessions
class MeditationStatsService {
  final Map<String, MeditationSessionStats> _stats = {};

  /// Get stats for user
  MeditationSessionStats getStats(String odUserId) {
    return _stats[odUserId] ?? MeditationSessionStats(oderId: odUserId);
  }

  /// Record a completed session
  void recordSession(String odUserId, int durationMinutes) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    var stats = getStats(odUserId);

    // Check streak
    int newStreak = stats.currentStreak;
    if (stats.lastSessionDate != null) {
      final lastDate = DateTime(
        stats.lastSessionDate!.year,
        stats.lastSessionDate!.month,
        stats.lastSessionDate!.day,
      );
      final difference = today.difference(lastDate).inDays;

      if (difference == 1) {
        newStreak += 1;
      } else if (difference > 1) {
        newStreak = 1;
      }
    } else {
      newStreak = 1;
    }

    final newLongest = newStreak > stats.longestStreak
        ? newStreak
        : stats.longestStreak;

    _stats[odUserId] = stats.copyWith(
      totalSessionsToday: stats.totalSessionsToday + 1,
      currentStreak: newStreak,
      longestStreak: newLongest,
      lastSessionDate: now,
    );
  }

  /// Get XP to award for session
  int calculateXp(int durationMinutes, int streak) {
    int baseXp = durationMinutes >= 10 ? 10 : 5;
    if (streak >= 7) baseXp += 10;
    return baseXp;
  }
}
