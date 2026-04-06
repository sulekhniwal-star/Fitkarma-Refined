import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';

part 'festival_diet_engine.g.dart';

class FestivalDietConfig {
  final String festivalKey;
  final String fastingType; // nirjala, phalahar, roza, none
  final List<String> allowedFoods;
  final List<String> forbiddenFoods;
  final double calorieMultiplier; // e.g. 0.8 for fasting, 1.2 for feast
  final bool workoutSuppressed;
  final String dietPlanType; // fasting, feast, sattvic, normal
  final String insightMessage;

  FestivalDietConfig({
    required this.festivalKey,
    this.fastingType = 'none',
    required this.dietPlanType,
    this.allowedFoods = const [],
    this.forbiddenFoods = const [],
    this.calorieMultiplier = 1.0,
    this.workoutSuppressed = false,
    required this.insightMessage,
  });

  bool get isFasting => fastingType != 'none';
}

@riverpod
class FestivalDietProvider extends _$FestivalDietProvider {
  @override
  Future<List<FestivalDietConfig>> build() async {
    final db = ref.watch(databaseProvider);
    final activeFestivals = await db.festivalCalendarDao.getActiveFestivals(DateTime.now());
    
    return activeFestivals.map((f) => _mapToConfig(f)).toList();
  }

  FestivalDietConfig _mapToConfig(FestivalCalendarEntry f) {
    List<String> allowed = [];
    List<String> forbidden = [];
    
    try {
      if (f.allowedFoods != null) {
        final decoded = json.decode(f.allowedFoods!);
        if (decoded is List) allowed = decoded.map((e) => e.toString()).toList();
      }
      if (f.forbiddenFoods != null) {
        final decoded = json.decode(f.forbiddenFoods!);
        if (decoded is List) forbidden = decoded.map((e) => e.toString()).toList();
      }
    } catch (_) {
      // Fallback for simple comma-separated strings if JSON fails
      allowed = f.allowedFoods?.split(',').map((e) => e.trim()).toList() ?? [];
      forbidden = f.forbiddenFoods?.split(',').map((e) => e.trim()).toList() ?? [];
    }

    return FestivalDietConfig(
      festivalKey: f.festivalKey,
      fastingType: f.fastingType ?? 'none',
      allowedFoods: allowed,
      forbiddenFoods: forbidden,
      calorieMultiplier: f.dietPlanType == 'fasting' ? 0.75 : (f.dietPlanType == 'feast' ? 1.25 : 1.0),
      workoutSuppressed: f.fastingType == 'nirjala', 
      dietPlanType: f.dietPlanType,
      insightMessage: f.insightMessage ?? '',
    );
  }

  /// Check if a specific food item is allowed under the current festival constraints
  bool isFoodAllowed(String foodId, String foodName) {
    if (!state.hasValue || state.value!.isEmpty) return true;

    for (final config in state.value!) {
      if (config.allowedFoods.isNotEmpty) {
        // If there's an allowed list, the food MUST be in it
        bool found = config.allowedFoods.any((f) => 
          f.toLowerCase() == foodId.toLowerCase() || 
          f.toLowerCase() == foodName.toLowerCase()
        );
        if (!found) return false;
      }
      
      if (config.forbiddenFoods.isNotEmpty) {
        // If there's a forbidden list, the food MUST NOT be in it
        bool forbidden = config.forbiddenFoods.any((f) => 
          f.toLowerCase() == foodId.toLowerCase() || 
          f.toLowerCase() == foodName.toLowerCase()
        );
        if (forbidden) return false;
      }
    }
    return true;
  }
}
