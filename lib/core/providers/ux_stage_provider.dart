// lib/core/providers/ux_stage_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/user_experience_stage.dart';

// Mocking first launch date for now. 
// In a real app, this would be fetched from persistent storage or the user profile.
final firstLaunchDateProvider = Provider<DateTime>((ref) {
  // Replace with actual storage fetch
  return DateTime.now().subtract(const Duration(days: 2)); 
});

final uxStageProvider = Provider<UXStage>((ref) {
  final firstLaunch = ref.watch(firstLaunchDateProvider);
  return UXStageService.getUXStage(firstLaunch);
});
