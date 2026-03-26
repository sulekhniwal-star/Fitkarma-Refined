// lib/features/festival/data/festival_providers.dart
// Festival providers for Riverpod state management

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/festival/data/festival_data.dart';
import 'package:fitkarma/features/festival/data/festival_notification_service.dart';

/// Festival database provider (singleton)
final festivalDatabaseProvider = Provider<FestivalDatabase>((ref) {
  return FestivalDatabase();
});

/// Upcoming festivals provider
final upcomingFestivalsProvider = Provider<List<Festival>>((ref) {
  final db = ref.watch(festivalDatabaseProvider);
  return db.getUpcomingFestivals(limit: 10);
});

/// Active festival provider (if any festival is currently active)
final activeFestivalProvider = Provider<Festival?>((ref) {
  final db = ref.watch(festivalDatabaseProvider);
  return db.getActiveFestival();
});

/// All festivals for current year
final currentYearFestivalsProvider = Provider<List<Festival>>((ref) {
  final db = ref.watch(festivalDatabaseProvider);
  return db.getFestivalsForYear(DateTime.now().year);
});

/// Garba activities provider
final garbaActivitiesProvider = Provider<List<GarbaActivity>>((ref) {
  return FestivalDatabase.garbaActivities;
});

/// Garba session state
class GarbaSession {
  final GarbaActivity? activity;
  final DateTime? startTime;
  final int caloriesBurned;

  GarbaSession({this.activity, this.startTime, this.caloriesBurned = 0});

  GarbaSession copyWith({
    GarbaActivity? activity,
    DateTime? startTime,
    int? caloriesBurned,
  }) {
    return GarbaSession(
      activity: activity ?? this.activity,
      startTime: startTime ?? this.startTime,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
    );
  }
}

/// Garba session notifier
class GarbaSessionNotifier extends Notifier<GarbaSession> {
  @override
  GarbaSession build() {
    return GarbaSession();
  }

  void startSession(GarbaActivity activity) {
    state = GarbaSession(activity: activity, startTime: DateTime.now());
  }

  void updateCalories(int calories) {
    state = state.copyWith(caloriesBurned: calories);
  }

  void endSession() {
    state = GarbaSession();
  }
}

/// Garba session provider
final garbaSessionProvider =
    NotifierProvider<GarbaSessionNotifier, GarbaSession>(() {
      return GarbaSessionNotifier();
    });

/// Diwali sweet entry
class DiwaliSweetEntry {
  final String sweetName;
  final String sweetNameHindi;
  final double quantityG;
  final double calories;
  final DateTime loggedAt;

  DiwaliSweetEntry({
    required this.sweetName,
    required this.sweetNameHindi,
    required this.quantityG,
    required this.calories,
    required this.loggedAt,
  });
}

/// Diwali sweet tracker state
class DiwaliSweetTrackerState {
  final List<DiwaliSweetEntry> entries;

  DiwaliSweetTrackerState({this.entries = const []});

  double get totalCalories =>
      entries.fold(0, (sum, entry) => sum + entry.calories);

  DiwaliSweetTrackerState copyWith({List<DiwaliSweetEntry>? entries}) {
    return DiwaliSweetTrackerState(entries: entries ?? this.entries);
  }
}

/// Diwali sweet tracker notifier
class DiwaliSweetTrackerNotifier extends Notifier<DiwaliSweetTrackerState> {
  @override
  DiwaliSweetTrackerState build() {
    return DiwaliSweetTrackerState();
  }

  void addSweet(FestivalFood sweet, double quantityG) {
    final calories = (sweet.caloriesPer100g * quantityG / 100);
    final newEntry = DiwaliSweetEntry(
      sweetName: sweet.name,
      sweetNameHindi: sweet.nameHindi,
      quantityG: quantityG,
      calories: calories,
      loggedAt: DateTime.now(),
    );
    state = state.copyWith(entries: [...state.entries, newEntry]);
  }

  void removeSweet(int index) {
    if (index >= 0 && index < state.entries.length) {
      final newEntries = [...state.entries]..removeAt(index);
      state = state.copyWith(entries: newEntries);
    }
  }

  void clearAll() {
    state = DiwaliSweetTrackerState();
  }
}

/// Diwali sweet tracker provider
final diwaliSweetTrackerProvider =
    NotifierProvider<DiwaliSweetTrackerNotifier, DiwaliSweetTrackerState>(() {
      return DiwaliSweetTrackerNotifier();
    });

/// Sehri/Iftar planner state
class SehriIftarPlan {
  final DateTime? sehriTime;
  final DateTime? iftarTime;
  final List<FestivalFood> sehriFoods;
  final List<FestivalFood> iftarFoods;

  SehriIftarPlan({
    this.sehriTime,
    this.iftarTime,
    this.sehriFoods = const [],
    this.iftarFoods = const [],
  });

  SehriIftarPlan copyWith({
    DateTime? sehriTime,
    DateTime? iftarTime,
    List<FestivalFood>? sehriFoods,
    List<FestivalFood>? iftarFoods,
  }) {
    return SehriIftarPlan(
      sehriTime: sehriTime ?? this.sehriTime,
      iftarTime: iftarTime ?? this.iftarTime,
      sehriFoods: sehriFoods ?? this.sehriFoods,
      iftarFoods: iftarFoods ?? this.iftarFoods,
    );
  }
}

/// Sehri/Iftar planner notifier
class SehriIftarPlannerNotifier extends Notifier<SehriIftarPlan> {
  @override
  SehriIftarPlan build() {
    return SehriIftarPlan();
  }

  void setSehriTime(DateTime time) {
    state = state.copyWith(sehriTime: time);
  }

  void setIftarTime(DateTime time) {
    state = state.copyWith(iftarTime: time);
  }

  void addSehriFood(FestivalFood food) {
    state = state.copyWith(sehriFoods: [...state.sehriFoods, food]);
  }

  void addIftarFood(FestivalFood food) {
    state = state.copyWith(iftarFoods: [...state.iftarFoods, food]);
  }

  void removeSehriFood(int index) {
    if (index >= 0 && index < state.sehriFoods.length) {
      final newFoods = [...state.sehriFoods]..removeAt(index);
      state = state.copyWith(sehriFoods: newFoods);
    }
  }

  void removeIftarFood(int index) {
    if (index >= 0 && index < state.iftarFoods.length) {
      final newFoods = [...state.iftarFoods]..removeAt(index);
      state = state.copyWith(iftarFoods: newFoods);
    }
  }

  void reset() {
    state = SehriIftarPlan();
  }
}

/// Sehri/Iftar planner provider
final sehriIftarPlannerProvider =
    NotifierProvider<SehriIftarPlannerNotifier, SehriIftarPlan>(() {
      return SehriIftarPlannerNotifier();
    });

/// Festival notification service provider
final festivalNotificationServiceProvider =
    Provider<FestivalNotificationService>((ref) {
      return FestivalNotificationService();
    });

/// Festival notifications enabled provider
final festivalNotificationsEnabledProvider =
    NotifierProvider<FestivalNotificationsEnabledNotifier, bool>(() {
      return FestivalNotificationsEnabledNotifier();
    });

class FestivalNotificationsEnabledNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void toggle() {
    state = !state;
  }
}

/// Navratri day guide provider
final navratriDayGuideProvider = Provider.family<DaySpecificGuide?, int>((
  ref,
  day,
) {
  final db = FestivalDatabase();
  final guides = db
      .getFestivalsForYear(DateTime.now().year)
      .where((f) => f.type == FestivalType.navratri)
      .expand((f) => f.dayGuides ?? [])
      .toList();

  try {
    return guides.firstWhere((g) => g.day == day);
  } catch (_) {
    return null;
  }
});
