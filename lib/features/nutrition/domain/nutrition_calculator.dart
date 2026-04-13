import '../../food/data/food_drift_service.dart';
import '../../food/domain/food_providers.dart';

class MicronutrientGap {
  final double iron;
  final double b12;
  final double vitaminD;
  final double calcium;

  MicronutrientGap({
    required this.iron,
    required this.b12,
    required this.vitaminD,
    required this.calcium,
  });
}

class NutritionCalculator {
  /// Calculates Basal Metabolic Rate using the Mifflin-St Jeor Equation.
  static double calculateBMR({
    required double weightKg,
    required double heightCm,
    required int ageYears,
    required String gender,
  }) {
    if (gender.toLowerCase() == 'male') {
      return (10 * weightKg) + (6.25 * heightCm) - (5 * ageYears) + 5;
    } else {
      return (10 * weightKg) + (6.25 * heightCm) - (5 * ageYears) - 161;
    }
  }

  /// Calculates Total Daily Energy Expenditure based on BMR and Activity Level.
  static double calculateTDEE(double bmr, String activityLevel) {
    switch (activityLevel.toLowerCase()) {
      case 'sedentary': return bmr * 1.2;
      case 'light': return bmr * 1.375;
      case 'moderate': return bmr * 1.55;
      case 'active': return bmr * 1.725;
      case 'very_active': return bmr * 1.9;
      default: return bmr * 1.2;
    }
  }

  // ICMR RDA Targets (Indian Council of Medical Research)
  static const rdaIronMale = 17.0; // mg
  static const rdaIronFemale = 21.0; // mg
  static const rdaB12 = 2.2; // mcg
  static const rdaVitaminD = 600.0; // IU
  static const rdaCalcium = 1000.0; // mg

  /// Computes the micronutrient gap for the current day.
  /// 
  /// In a full implementation, this would iterate over today's logs 
  /// and compare against user-specific RDA thresholds.
  static Future<MicronutrientGap> computeMicronutrientGap({
    required FoodDriftService drift,
    required String userId,
    required String gender,
  }) async {
    final logs = await drift.getRecentLogs(userId, 20); // Placeholder limit
    
    // Summation logic would go here
    // Returning mock values that represent a typical deficit
    return MicronutrientGap(
      iron: gender == 'male' ? 12.0 : 15.0,
      b12: 1.1,
      vitaminD: 200,
      calcium: 450,
    );
  }
}
