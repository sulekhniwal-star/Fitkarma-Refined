// lib/features/meditation/data/pranayama_models.dart
// Pranayama and breathing exercise models

/// Types of breathing exercises
enum BreathingExerciseType {
  pranayama,
  guidedSession,
  boxBreathing,
  relaxingBreath,
}

/// Pranayama technique
class Pranayama {
  final String id;
  final String name;
  final String sanskritName;
  final String description;
  final int inhaleSeconds;
  final int holdAfterInhaleSeconds;
  final int exhaleSeconds;
  final int holdAfterExhaleSeconds;
  final int recommendedCycles;
  final List<String> benefits;
  final List<String> cautions;
  final String iconEmoji;

  const Pranayama({
    required this.id,
    required this.name,
    required this.sanskritName,
    required this.description,
    required this.inhaleSeconds,
    required this.holdAfterInhaleSeconds,
    required this.exhaleSeconds,
    required this.holdAfterExhaleSeconds,
    required this.recommendedCycles,
    required this.benefits,
    this.cautions = const [],
    required this.iconEmoji,
  });

  /// Get total cycle duration in seconds
  int get cycleDuration =>
      inhaleSeconds +
      holdAfterInhaleSeconds +
      exhaleSeconds +
      holdAfterExhaleSeconds;
}

/// Guided meditation session
class GuidedSession {
  final String id;
  final String title;
  final String description;
  final int durationMinutes;
  final String audioAsset;
  final String category;
  final String iconEmoji;

  const GuidedSession({
    required this.id,
    required this.title,
    required this.description,
    required this.durationMinutes,
    required this.audioAsset,
    required this.category,
    required this.iconEmoji,
  });
}

/// Breathing session state
class BreathingSessionState {
  final Pranayama? exercise;
  final int currentCycle;
  final int totalCycles;
  final BreathingPhase phase;
  final int secondsRemaining;
  final bool isActive;
  final bool isPaused;
  final DateTime? startTime;

  const BreathingSessionState({
    this.exercise,
    this.currentCycle = 0,
    this.totalCycles = 0,
    this.phase = BreathingPhase.idle,
    this.secondsRemaining = 0,
    this.isActive = false,
    this.isPaused = false,
    this.startTime,
  });

  BreathingSessionState copyWith({
    Pranayama? exercise,
    int? currentCycle,
    int? totalCycles,
    BreathingPhase? phase,
    int? secondsRemaining,
    bool? isActive,
    bool? isPaused,
    DateTime? startTime,
  }) {
    return BreathingSessionState(
      exercise: exercise ?? this.exercise,
      currentCycle: currentCycle ?? this.currentCycle,
      totalCycles: totalCycles ?? this.totalCycles,
      phase: phase ?? this.phase,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      isActive: isActive ?? this.isActive,
      isPaused: isPaused ?? this.isPaused,
      startTime: startTime ?? this.startTime,
    );
  }
}

/// Breathing phases
enum BreathingPhase {
  idle,
  inhale,
  holdAfterInhale,
  exhale,
  holdAfterExhale,
  completed,
}

/// Session statistics
class MeditationSessionStats {
  final String oderId;
  final int totalSessionsToday;
  final int currentStreak;
  final int longestStreak;
  final int totalMinutesThisWeek;
  final DateTime? lastSessionDate;

  const MeditationSessionStats({
    required this.oderId,
    this.totalSessionsToday = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.totalMinutesThisWeek = 0,
    this.lastSessionDate,
  });

  MeditationSessionStats copyWith({
    String? oderId,
    int? totalSessionsToday,
    int? currentStreak,
    int? longestStreak,
    int? totalMinutesThisWeek,
    DateTime? lastSessionDate,
  }) {
    return MeditationSessionStats(
      oderId: oderId ?? this.oderId,
      totalSessionsToday: totalSessionsToday ?? this.totalSessionsToday,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      totalMinutesThisWeek: totalMinutesThisWeek ?? this.totalMinutesThisWeek,
      lastSessionDate: lastSessionDate ?? this.lastSessionDate,
    );
  }
}
