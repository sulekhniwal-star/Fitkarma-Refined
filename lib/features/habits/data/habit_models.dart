// lib/features/habits/data/habit_models.dart
// Models for Habits feature

/// Preset habit definitions
class PresetHabit {
  final String id;
  final String name;
  final String emoji;
  final int targetCount;
  final String unit;
  final String frequency;

  const PresetHabit({
    required this.id,
    required this.name,
    required this.emoji,
    required this.targetCount,
    required this.unit,
    required this.frequency,
  });

  /// Get all preset habits
  static const List<PresetHabit> presets = [
    PresetHabit(
      id: 'preset_water',
      name: 'Drink 8 Glasses Water',
      emoji: '💧',
      targetCount: 8,
      unit: 'glasses',
      frequency: 'daily',
    ),
    PresetHabit(
      id: 'preset_meditation',
      name: '10-Min Meditation',
      emoji: '🧘',
      targetCount: 10,
      unit: 'minutes',
      frequency: 'daily',
    ),
    PresetHabit(
      id: 'preset_walk',
      name: '30-Min Walk',
      emoji: '🚶',
      targetCount: 30,
      unit: 'minutes',
      frequency: 'daily',
    ),
    PresetHabit(
      id: 'preset_read',
      name: 'Read 10 Pages',
      emoji: '📖',
      targetCount: 10,
      unit: 'pages',
      frequency: 'daily',
    ),
    PresetHabit(
      id: 'preset_no_sugar',
      name: 'No Sugar',
      emoji: '🍬',
      targetCount: 1,
      unit: 'day',
      frequency: 'daily',
    ),
  ];

  /// Get preset by ID
  static PresetHabit? getById(String id) {
    try {
      return presets.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}

/// Habit frequency options
enum HabitFrequency {
  daily('daily', 'Daily'),
  weekly('weekly', 'Weekly'),
  custom('custom', 'Custom Days');

  final String value;
  final String label;

  const HabitFrequency(this.value, this.label);

  static HabitFrequency fromValue(String value) {
    return HabitFrequency.values.firstWhere(
      (f) => f.value == value,
      orElse: () => HabitFrequency.daily,
    );
  }
}

/// Habit state for UI
class HabitState {
  final List<HabitData> habits;
  final bool isLoading;
  final String? error;
  final Map<String, List<HabitCompletion>> weeklyCompletions;

  const HabitState({
    this.habits = const [],
    this.isLoading = false,
    this.error,
    this.weeklyCompletions = const {},
  });

  HabitState copyWith({
    List<HabitData>? habits,
    bool? isLoading,
    String? error,
    Map<String, List<HabitCompletion>>? weeklyCompletions,
  }) {
    return HabitState(
      habits: habits ?? this.habits,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      weeklyCompletions: weeklyCompletions ?? this.weeklyCompletions,
    );
  }
}

/// Habit data for display
class HabitData {
  final String id;
  final String userId;
  final String name;
  final String emoji;
  final int targetCount;
  final String unit;
  final String frequency;
  final int currentStreak;
  final int longestStreak;
  final bool isPreset;
  final String? reminderTime;
  final int todayCount;
  final bool isCompletedToday;

  const HabitData({
    required this.id,
    required this.userId,
    required this.name,
    required this.emoji,
    required this.targetCount,
    required this.unit,
    required this.frequency,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.isPreset = false,
    this.reminderTime,
    this.todayCount = 0,
    this.isCompletedToday = false,
  });

  HabitData copyWith({
    String? id,
    String? userId,
    String? name,
    String? emoji,
    int? targetCount,
    String? unit,
    String? frequency,
    int? currentStreak,
    int? longestStreak,
    bool? isPreset,
    String? reminderTime,
    int? todayCount,
    bool? isCompletedToday,
  }) {
    return HabitData(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      targetCount: targetCount ?? this.targetCount,
      unit: unit ?? this.unit,
      frequency: frequency ?? this.frequency,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      isPreset: isPreset ?? this.isPreset,
      reminderTime: reminderTime ?? this.reminderTime,
      todayCount: todayCount ?? this.todayCount,
      isCompletedToday: isCompletedToday ?? this.isCompletedToday,
    );
  }

  /// Get progress as percentage (0.0 - 1.0)
  double get progress =>
      targetCount > 0 ? (todayCount / targetCount).clamp(0.0, 1.0) : 0.0;

  /// Check if streak is active (completed yesterday or today)
  bool get hasActiveStreak => currentStreak > 0;
}

/// Habit completion record
class HabitCompletion {
  final String id;
  final String habitId;
  final DateTime date;
  final int count;

  const HabitCompletion({
    required this.id,
    required this.habitId,
    required this.date,
    required this.count,
  });
}

/// Habit completion for a specific day
class DayCompletion {
  final DateTime date;
  final int completedHabits;
  final int totalHabits;

  const DayCompletion({
    required this.date,
    required this.completedHabits,
    required this.totalHabits,
  });

  double get completionRate =>
      totalHabits > 0 ? completedHabits / totalHabits : 0.0;

  bool get isFullyCompleted =>
      completedHabits >= totalHabits && totalHabits > 0;
}

/// XP rewards for habits
class HabitXpRewards {
  static const int habitCompletion = 2;
  static const int streak7Days = 10;
  static const int streak30Days = 50;
}
