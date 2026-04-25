// lib/core/config/user_experience_stage.dart

enum UXStage { firstWeek, familiar, expert }

class UXStageService {
  static UXStage getUXStage(DateTime firstLaunch) {
    final days = DateTime.now().difference(firstLaunch).inDays;
    if (days < 7) return UXStage.firstWeek;
    if (days < 30) return UXStage.familiar;
    return UXStage.expert;
  }
}
