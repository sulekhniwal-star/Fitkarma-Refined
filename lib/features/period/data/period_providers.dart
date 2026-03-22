import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/core/storage/drift_service.dart';
import 'package:fitkarma/features/period/data/period_service.dart';

/// Provider for PeriodService
/// Uses the driftServiceProvider which has access to the AppDatabase
final periodServiceProvider = Provider<PeriodService>((ref) {
  final driftService = ref.watch(driftServiceProvider);
  return PeriodService(driftService.db);
});

/// Provider for current user's cycle info
final periodCycleInfoProvider = FutureProvider.family<PeriodCycleInfo, String>((
  ref,
  userId,
) async {
  final periodService = ref.watch(periodServiceProvider);
  return periodService.getCycleInfo(userId);
});

/// Provider for period logs
final periodLogsProvider = FutureProvider.family<List<PeriodLog>, String>((
  ref,
  userId,
) async {
  final periodService = ref.watch(periodServiceProvider);
  return periodService.getPeriodLogs(userId);
});

/// Provider for workout suggestions based on cycle phase
final workoutSuggestionsProvider =
    Provider.family<List<WorkoutSuggestion>, CyclePhase>((ref, phase) {
      final periodService = ref.watch(periodServiceProvider);
      return periodService.getWorkoutSuggestions(phase);
    });

/// Provider for symptom summary
final symptomSummaryProvider =
    FutureProvider.family<SymptomSummary, PeriodSummaryRequest>((
      ref,
      request,
    ) async {
      final periodService = ref.watch(periodServiceProvider);
      return periodService.getSymptomSummary(
        request.userId,
        request.startDate,
        request.endDate,
      );
    });

/// Request model for symptom summary
class PeriodSummaryRequest {
  final String userId;
  final DateTime startDate;
  final DateTime endDate;

  PeriodSummaryRequest({
    required this.userId,
    required this.startDate,
    required this.endDate,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeriodSummaryRequest &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          startDate == other.startDate &&
          endDate == other.endDate;

  @override
  int get hashCode => userId.hashCode ^ startDate.hashCode ^ endDate.hashCode;
}
