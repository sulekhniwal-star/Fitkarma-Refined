import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/user_experience_stage.dart';

// Mocked for now — in production, this will read firstLaunch date from local storage
final uxStageProvider = Provider<UXStage>((ref) {
  return UXStage.firstWeek;
});
