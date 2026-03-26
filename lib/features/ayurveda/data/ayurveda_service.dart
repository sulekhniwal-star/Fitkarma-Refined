// lib/features/ayurveda/data/ayurveda_service.dart
// Service for managing Ayurveda data - in-memory storage

import 'package:fitkarma/features/ayurveda/data/ayurveda_models.dart';
import 'package:fitkarma/features/ayurveda/data/dinacharya_data.dart';

/// Service for managing Ayurveda profile and daily rituals
/// Uses in-memory storage for instant access
class AyurvedaService {
  // In-memory cache for profiles
  final Map<String, AyurvedaProfile> _profiles = {};

  // In-memory cache for daily rituals completion
  final Map<String, Set<String>> _completedRituals = {};

  /// Get user's Ayurveda profile
  AyurvedaProfile? getProfile(String odUserId) {
    return _profiles[odUserId];
  }

  /// Save Ayurveda profile
  void saveProfile(AyurvedaProfile profile) {
    _profiles[profile.odUserId] = profile;
  }

  /// Create new profile
  AyurvedaProfile createProfile(String odUserId) {
    final now = DateTime.now();
    final profile = AyurvedaProfile(
      odUserId: odUserId,
      completedDailyRituals: [],
      createdAt: now,
      updatedAt: now,
    );
    _profiles[odUserId] = profile;
    return profile;
  }

  /// Get or create profile
  AyurvedaProfile getOrCreateProfile(String odUserId) {
    var profile = _profiles[odUserId];
    profile ??= createProfile(odUserId);
    return profile;
  }

  /// Update dosha result
  AyurvedaProfile updateDoshaResult(String odUserId, DoshaResult result) {
    final profile = getOrCreateProfile(odUserId);
    final updated = profile.copyWith(
      doshaResult: result,
      lastQuizDate: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _profiles[odUserId] = updated;
    return updated;
  }

  /// Get completed ritual IDs for today
  Set<String> _getCompletedRitualsKey(String odUserId) {
    final today = DateTime.now();
    final key = '${odUserId}_${today.year}_${today.month}_${today.day}';
    return _completedRituals[key] ?? {};
  }

  /// Mark ritual as complete
  void markRitualComplete(String odUserId, String ritualId) {
    final today = DateTime.now();
    final key = '${odUserId}_${today.year}_${today.month}_${today.day}';
    _completedRituals[key] ??= {};
    _completedRituals[key]!.add(ritualId);
  }

  /// Mark ritual as incomplete
  void markRitualIncomplete(String odUserId, String ritualId) {
    final today = DateTime.now();
    final key = '${odUserId}_${today.year}_${today.month}_${today.day}';
    _completedRituals[key]?.remove(ritualId);
  }

  /// Get daily rituals with completion status
  List<DinacharyaTask> getDailyRituals(
    String odUserId, {
    DoshaType? doshaType,
    IndianSeason? season,
  }) {
    final completed = _getCompletedRitualsKey(odUserId);
    final tasks = DinacharyaData.getRecommendedTasks(doshaType, season);

    return tasks.map((task) {
      final isComplete = completed.contains(task.id);
      return DinacharyaTask(
        id: task.id,
        name: task.name,
        description: task.description,
        time: task.time,
        recommendedFor: task.recommendedFor,
        avoidFor: task.avoidFor,
        benefit: task.benefit,
        isCompleted: isComplete,
        completedAt: isComplete ? DateTime.now() : null,
      );
    }).toList();
  }

  /// Get recommended tasks based on user's dosha
  List<DinacharyaTask> getRecommendedRituals(String odUserId) {
    final profile = getOrCreateProfile(odUserId);
    final doshaResult = profile.doshaResult;

    if (doshaResult == null) {
      return getDailyRituals(odUserId);
    }

    // Determine primary dosha for recommendations
    final doshaType = _getPrimaryDoshaType(doshaResult);
    final season = IndianSeason.getCurrentSeason();

    return getDailyRituals(odUserId, doshaType: doshaType, season: season);
  }

  DoshaType _getPrimaryDoshaType(DoshaResult result) {
    if (result.vataPercent >= result.pittaPercent &&
        result.vataPercent >= result.kaphaPercent) {
      return DoshaType.vata;
    } else if (result.pittaPercent >= result.vataPercent &&
        result.pittaPercent >= result.kaphaPercent) {
      return DoshaType.pitta;
    }
    return DoshaType.kapha;
  }

  /// Check if user has completed quiz
  bool hasCompletedQuiz(String odUserId) {
    final profile = _profiles[odUserId];
    return profile?.doshaResult != null;
  }

  /// Get current season
  IndianSeason getCurrentSeason() {
    return IndianSeason.getCurrentSeason();
  }

  /// Get completion count for today
  int getTodayCompletionCount(String odUserId) {
    final completed = _getCompletedRitualsKey(odUserId);
    return completed.length;
  }

  /// Get total tasks count
  int getTotalTasksCount(String odUserId) {
    final profile = getOrCreateProfile(odUserId);
    final doshaResult = profile.doshaResult;

    if (doshaResult == null) {
      return DinacharyaData.allTasks.length;
    }

    final doshaType = _getPrimaryDoshaType(doshaResult);
    return DinacharyaData.getRecommendedTasks(
      doshaType,
      getCurrentSeason(),
    ).length;
  }
}
