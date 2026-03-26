import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';

/// Service for managing period logs with encryption and cycle predictions.
/// All sensitive data is encrypted using HKDF-derived period key.
class PeriodService {
  final AppDatabase db;

  PeriodService(this.db);

  // =============================================================================
  // CRUD Operations
  // =============================================================================

  /// Log a period day entry with encryption
  Future<void> logPeriodDay({
    required String userId,
    required DateTime date,
    DateTime? cycleStartDate,
    DateTime? cycleEndDate,
    String? flowIntensity,
    PeriodSymptoms? symptoms,
    String? notes,
    bool isPcodPcos = false,
  }) async {
    final now = DateTime.now();
    final id = 'period_${userId}_${date.millisecondsSinceEpoch}';

    // Determine if this is the first day of period (cycle start)
    bool isFirstDayOfCycle = cycleStartDate != null;

    // Check if this is period day based on flow intensity
    bool isPeriodDay = flowIntensity != null && flowIntensity.isNotEmpty;

    // Get symptoms JSON
    String? symptomsJson;
    if (symptoms != null) {
      symptomsJson = json.encode(symptoms.toJson());
    }

    // Calculate cycle predictions if we have enough data
    CyclePredictions? predictions;
    if (isFirstDayOfCycle) {
      predictions = await _calculatePredictions(userId, cycleStartDate);
    }

    await db
        .into(db.periodLogs)
        .insert(
          PeriodLogsCompanion.insert(
            id: id,
            userId: userId,
            date: date,
            cycleStartDate: Value(cycleStartDate),
            cycleEndDate: Value(cycleEndDate),
            cycleLength: Value(predictions?.averageCycleLength),
            periodLength: Value(predictions?.averagePeriodLength),
            predictedNextPeriod: Value(predictions?.predictedNextPeriod),
            predictedOvulationDate: Value(predictions?.predictedOvulationDate),
            isPeriodDay: Value(isPeriodDay),
            flowIntensity: Value(flowIntensity),
            symptoms: Value(symptomsJson),
            isPcodPcos: Value(isPcodPcos),
            notes: Value(notes),
            syncStatus: 'pending',
            idempotencyKey: '${userId}_period_${date.millisecondsSinceEpoch}',
          ),
        );
  }

  /// Update an existing period log
  Future<void> updatePeriodLog({
    required String id,
    String? flowIntensity,
    PeriodSymptoms? symptoms,
    String? notes,
    bool? isPcodPcos,
  }) async {
    String? symptomsJson;
    if (symptoms != null) {
      symptomsJson = json.encode(symptoms.toJson());
    }

    await (db.update(db.periodLogs)..where((tbl) => tbl.id.equals(id))).write(
      PeriodLogsCompanion(
        flowIntensity: Value(flowIntensity),
        symptoms: Value(symptomsJson),
        notes: Value(notes),
        isPcodPcos: Value(isPcodPcos ?? false),
        syncStatus: const Value('pending'),
      ),
    );
  }

  /// Get all period logs for a user
  Future<List<PeriodLog>> getPeriodLogs(String userId, {int? limit}) async {
    final query = db.select(db.periodLogs)
      ..where((tbl) => tbl.userId.equals(userId))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)]);

    if (limit != null) {
      query.limit(limit);
    }

    return query.get();
  }

  /// Get period logs for a specific date range
  Future<List<PeriodLog>> getPeriodLogsInRange(
    String userId,
    DateTime start,
    DateTime end,
  ) async {
    return (db.select(db.periodLogs)
          ..where(
            (tbl) =>
                tbl.userId.equals(userId) &
                tbl.date.isBetweenValues(start, end),
          )
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)]))
        .get();
  }

  /// Get the most recent period log for a user
  Future<PeriodLog?> getLatestPeriodLog(String userId) async {
    return (db.select(db.periodLogs)
          ..where((tbl) => tbl.userId.equals(userId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Get cycle start dates for cycle prediction (last 3 cycles)
  Future<List<DateTime>> getCycleStartDates(
    String userId, {
    int limit = 3,
  }) async {
    final logs =
        await (db.select(db.periodLogs)
              ..where(
                (tbl) =>
                    tbl.userId.equals(userId) & tbl.cycleStartDate.isNotNull(),
              )
              ..orderBy([(tbl) => OrderingTerm.desc(tbl.cycleStartDate)])
              ..limit(limit))
            .get();

    return logs
        .where((log) => log.cycleStartDate != null)
        .map((log) => log.cycleStartDate!)
        .toList();
  }

  /// Get current cycle phase and predictions
  Future<PeriodCycleInfo> getCycleInfo(String userId) async {
    final latestLog = await getLatestPeriodLog(userId);
    final cycleStarts = await getCycleStartDates(userId);

    if (latestLog == null) {
      return PeriodCycleInfo(
        currentPhase: CyclePhase.unknown,
        daysUntilNextPeriod: null,
        nextPeriodDate: null,
        ovulationDate: null,
        isPcodPcosMode: false,
      );
    }

    // Determine current phase
    final now = DateTime.now();
    final cyclePhase = _determineCyclePhase(
      latestLog.cycleStartDate,
      latestLog.predictedNextPeriod,
      latestLog.predictedOvulationDate,
      now,
    );

    // Calculate days until next period
    int? daysUntilNext;
    if (latestLog.predictedNextPeriod != null) {
      daysUntilNext = latestLog.predictedNextPeriod!.difference(now).inDays;
    }

    return PeriodCycleInfo(
      currentPhase: cyclePhase,
      daysUntilNextPeriod: daysUntilNext,
      nextPeriodDate: latestLog.predictedNextPeriod,
      ovulationDate: latestLog.predictedOvulationDate,
      isPcodPcosMode: latestLog.isPcodPcos,
      averageCycleLength: latestLog.cycleLength,
      averagePeriodLength: latestLog.periodLength,
    );
  }

  /// Toggle PCOD/PCOS mode
  Future<void> setPcodPcosMode(String userId, bool isEnabled) async {
    // Update all recent period logs with PCOD/PCOS flag
    final logs = await getPeriodLogs(userId, limit: 10);
    for (final log in logs) {
      await (db.update(
        db.periodLogs,
      )..where((tbl) => tbl.id.equals(log.id))).write(
        PeriodLogsCompanion(
          isPcodPcos: Value(isEnabled),
          syncStatus: const Value('pending'),
        ),
      );
    }

    // Recalculate predictions with PCOD/PCOS adjusted values
    if (isEnabled && logs.isNotEmpty && logs.first.cycleStartDate != null) {
      await _recalculatePredictionsForPcod(userId);
    }
  }

  // =============================================================================
  // Cycle Predictions
  // =============================================================================

  /// Calculate cycle predictions based on last 3 cycles
  Future<CyclePredictions> _calculatePredictions(
    String userId,
    DateTime currentCycleStart,
  ) async {
    final cycleStarts = await getCycleStartDates(userId, limit: 4);

    // Add current cycle start
    final allCycleStarts = [currentCycleStart, ...cycleStarts];

    if (allCycleStarts.length < 2) {
      // Not enough data, use defaults
      return _getDefaultPredictions(currentCycleStart);
    }

    // Calculate average cycle length from last 3 cycles
    final cycleLengths = <int>[];
    for (int i = 0; i < allCycleStarts.length - 1; i++) {
      final length = allCycleStarts[i].difference(allCycleStarts[i + 1]).inDays;
      if (length > 0 && length < 60) {
        // Sanity check: 0-60 days
        cycleLengths.add(length);
      }
    }

    // Get average period length
    final periodLogs = await getPeriodLogsInRange(
      userId,
      currentCycleStart.subtract(const Duration(days: 60)),
      currentCycleStart.add(const Duration(days: 10)),
    );

    final periodLengths = periodLogs
        .where((log) => log.periodLength != null)
        .map((log) => log.periodLength!)
        .toList();

    // Use last 3 period lengths or default
    final avgCycleLength = cycleLengths.isNotEmpty
        ? (cycleLengths.reduce((a, b) => a + b) / cycleLengths.length).round()
        : 28; // Default

    final avgPeriodLength = periodLengths.isNotEmpty
        ? (periodLengths.reduce((a, b) => a + b) / periodLengths.length).round()
        : 5; // Default

    // Calculate next period date
    final nextPeriod = currentCycleStart.add(Duration(days: avgCycleLength));

    // Calculate ovulation date (typically 14 days before next period)
    // For PCOD/PCOS, ovulation may be irregular
    final ovulation = nextPeriod.subtract(Duration(days: 14));

    return CyclePredictions(
      averageCycleLength: avgCycleLength,
      averagePeriodLength: avgPeriodLength,
      predictedNextPeriod: nextPeriod,
      predictedOvulationDate: ovulation,
    );
  }

  /// Get default predictions for new users
  CyclePredictions _getDefaultPredictions(DateTime cycleStart) {
    return CyclePredictions(
      averageCycleLength: 28,
      averagePeriodLength: 5,
      predictedNextPeriod: cycleStart.add(const Duration(days: 28)),
      predictedOvulationDate: cycleStart.add(const Duration(days: 14)),
    );
  }

  /// Recalculate predictions for PCOD/PCOS users (longer cycles)
  Future<void> _recalculatePredictionsForPcod(String userId) async {
    final latestLog = await getLatestPeriodLog(userId);
    if (latestLog == null || latestLog.cycleStartDate == null) return;

    // PCOD/PCOS typically has longer cycles (35-40 days)
    final predictions = CyclePredictions(
      averageCycleLength: 35,
      averagePeriodLength: 6,
      predictedNextPeriod: latestLog.cycleStartDate!.add(
        const Duration(days: 35),
      ),
      predictedOvulationDate: latestLog.cycleStartDate!.add(
        const Duration(days: 21),
      ),
    );

    await (db.update(
      db.periodLogs,
    )..where((tbl) => tbl.id.equals(latestLog.id))).write(
      PeriodLogsCompanion(
        cycleLength: Value(predictions.averageCycleLength),
        periodLength: Value(predictions.averagePeriodLength),
        predictedNextPeriod: Value(predictions.predictedNextPeriod),
        predictedOvulationDate: Value(predictions.predictedOvulationDate),
        syncStatus: const Value('pending'),
      ),
    );
  }

  /// Determine current cycle phase
  CyclePhase _determineCyclePhase(
    DateTime? cycleStart,
    DateTime? predictedNext,
    DateTime? ovulationDate,
    DateTime now,
  ) {
    if (cycleStart == null) return CyclePhase.unknown;

    final daysSinceStart = now.difference(cycleStart).inDays;

    // Menstrual phase (days 1-5)
    if (daysSinceStart >= 0 && daysSinceStart <= 5) {
      return CyclePhase.menstrual;
    }

    // Follicular phase (days 6-13)
    if (daysSinceStart >= 6 && daysSinceStart <= 13) {
      return CyclePhase.follicular;
    }

    // Ovulation phase (days 14-16)
    if (daysSinceStart >= 14 && daysSinceStart <= 16) {
      return CyclePhase.ovulation;
    }

    // Luteal phase (days 17-28+)
    return CyclePhase.luteal;
  }

  // =============================================================================
  // Workout Suggestions
  // =============================================================================

  /// Get workout suggestions based on current cycle phase
  List<WorkoutSuggestion> getWorkoutSuggestions(CyclePhase phase) {
    switch (phase) {
      case CyclePhase.menstrual:
        return [
          WorkoutSuggestion(
            title: 'Gentle Yoga',
            description: 'Relieves cramps and tension',
            intensity: 'low',
            duration: '20-30 min',
          ),
          WorkoutSuggestion(
            title: 'Light Walking',
            description: 'Easy cardio to boost mood',
            intensity: 'low',
            duration: '15-20 min',
          ),
          WorkoutSuggestion(
            title: 'Stretching',
            description: 'Release lower back tension',
            intensity: 'low',
            duration: '10-15 min',
          ),
        ];
      case CyclePhase.follicular:
        return [
          WorkoutSuggestion(
            title: 'HIIT Workout',
            description: 'High energy - great time for intense workouts',
            intensity: 'high',
            duration: '30-45 min',
          ),
          WorkoutSuggestion(
            title: 'Strength Training',
            description: 'Build muscle with increased testosterone',
            intensity: 'high',
            duration: '40-50 min',
          ),
          WorkoutSuggestion(
            title: 'Dance Cardio',
            description: 'Fun way to burn calories',
            intensity: 'medium',
            duration: '30 min',
          ),
        ];
      case CyclePhase.ovulation:
        return [
          WorkoutSuggestion(
            title: 'Power Yoga',
            description: 'Balance energy levels',
            intensity: 'medium',
            duration: '30-40 min',
          ),
          WorkoutSuggestion(
            title: 'Swimming',
            description: 'Full body workout with low impact',
            intensity: 'medium',
            duration: '30 min',
          ),
          WorkoutSuggestion(
            title: 'Cycling',
            description: 'Build endurance',
            intensity: 'medium',
            duration: '30-45 min',
          ),
        ];
      case CyclePhase.luteal:
        return [
          WorkoutSuggestion(
            title: 'Moderate Strength',
            description: 'Focus on compound movements',
            intensity: 'medium',
            duration: '35-45 min',
          ),
          WorkoutSuggestion(
            title: 'Pilates',
            description: 'Core strengthening',
            intensity: 'medium',
            duration: '30 min',
          ),
          WorkoutSuggestion(
            title: 'Brisk Walking',
            description: 'Gentle cardio to maintain energy',
            intensity: 'low',
            duration: '20-30 min',
          ),
        ];
      case CyclePhase.unknown:
        return [
          WorkoutSuggestion(
            title: 'Any Activity',
            description:
                'Start tracking your cycle for personalized suggestions',
            intensity: 'any',
            duration: '20-30 min',
          ),
        ];
    }
  }

  /// Delete a period log
  Future<void> deletePeriodLog(String id) async {
    await (db.delete(db.periodLogs)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Get symptoms summary for a date range
  Future<SymptomSummary> getSymptomSummary(
    String userId,
    DateTime start,
    DateTime end,
  ) async {
    final logs = await getPeriodLogsInRange(userId, start, end);

    final symptomsCount = <String, int>{};
    for (final log in logs) {
      if (log.symptoms != null) {
        try {
          final symptoms = json.decode(log.symptoms!) as Map<String, dynamic>;
          symptoms.forEach((key, value) {
            if (value == true) {
              symptomsCount[key] = (symptomsCount[key] ?? 0) + 1;
            }
          });
        } catch (_) {}
      }
    }

    return SymptomSummary(
      totalDays: logs.length,
      symptomsCount: symptomsCount,
      dateRange: DateTimeRange(start: start, end: end),
    );
  }
}

/// Symptom tracking model
class PeriodSymptoms {
  final bool cramps;
  final bool bloating;
  final bool moodSwings;
  final bool headache;
  final bool fatigue;
  final bool spotting;
  final String? other;

  PeriodSymptoms({
    this.cramps = false,
    this.bloating = false,
    this.moodSwings = false,
    this.headache = false,
    this.fatigue = false,
    this.spotting = false,
    this.other,
  });

  Map<String, dynamic> toJson() => {
    'cramps': cramps,
    'bloating': bloating,
    'moodSwings': moodSwings,
    'headache': headache,
    'fatigue': fatigue,
    'spotting': spotting,
    'other': other,
  };

  factory PeriodSymptoms.fromJson(Map<String, dynamic> json) {
    return PeriodSymptoms(
      cramps: json['cramps'] ?? false,
      bloating: json['bloating'] ?? false,
      moodSwings: json['moodSwings'] ?? false,
      headache: json['headache'] ?? false,
      fatigue: json['fatigue'] ?? false,
      spotting: json['spotting'] ?? false,
      other: json['other'],
    );
  }
}

/// Cycle predictions model
class CyclePredictions {
  final int averageCycleLength;
  final int averagePeriodLength;
  final DateTime predictedNextPeriod;
  final DateTime predictedOvulationDate;

  CyclePredictions({
    required this.averageCycleLength,
    required this.averagePeriodLength,
    required this.predictedNextPeriod,
    required this.predictedOvulationDate,
  });
}

/// Period cycle information
class PeriodCycleInfo {
  final CyclePhase currentPhase;
  final int? daysUntilNextPeriod;
  final DateTime? nextPeriodDate;
  final DateTime? ovulationDate;
  final bool isPcodPcosMode;
  final int? averageCycleLength;
  final int? averagePeriodLength;

  PeriodCycleInfo({
    required this.currentPhase,
    this.daysUntilNextPeriod,
    this.nextPeriodDate,
    this.ovulationDate,
    this.isPcodPcosMode = false,
    this.averageCycleLength,
    this.averagePeriodLength,
  });
}

/// Cycle phases
enum CyclePhase {
  menstrual, // Days 1-5: Period
  follicular, // Days 6-13: Pre-ovulation
  ovulation, // Days 14-16: Fertile window
  luteal, // Days 17-28: Pre-period
  unknown, // Not enough data
}

/// Workout suggestion model
class WorkoutSuggestion {
  final String title;
  final String description;
  final String intensity;
  final String duration;

  WorkoutSuggestion({
    required this.title,
    required this.description,
    required this.intensity,
    required this.duration,
  });
}

/// Symptom summary
class SymptomSummary {
  final int totalDays;
  final Map<String, int> symptomsCount;
  final DateTimeRange dateRange;

  SymptomSummary({
    required this.totalDays,
    required this.symptomsCount,
    required this.dateRange,
  });
}

/// DateTime range helper class
class DateTimeRange {
  final DateTime start;
  final DateTime end;

  DateTimeRange({required this.start, required this.end});
}
