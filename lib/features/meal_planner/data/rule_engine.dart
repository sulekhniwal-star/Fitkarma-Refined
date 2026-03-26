// lib/features/meal_planner/data/rule_engine.dart
// Rule Engine for generating meal suggestions based on TDEE, dosha, and nutrition gaps


/// Nutrition targets based on TDEE
class NutritionTargets {
  final double calories;
  final double proteinG;
  final double carbsG;
  final double fatG;
  final double fiberG;
  final double vitaminDMcg;
  final double vitaminB12Mcg;
  final double ironMg;
  final double calciumMg;

  const NutritionTargets({
    required this.calories,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    required this.fiberG,
    required this.vitaminDMcg,
    required this.vitaminB12Mcg,
    required this.ironMg,
    required this.calciumMg,
  });

  /// Calculate targets based on TDEE
  factory NutritionTargets.fromTdee(double tdee) {
    // Standard macro split: 30% protein, 40% carbs, 30% fat
    final proteinCalories = tdee * 0.30;
    final carbsCalories = tdee * 0.40;
    final fatCalories = tdee * 0.30;

    return NutritionTargets(
      calories: tdee,
      proteinG: proteinCalories / 4, // 4 cal per gram protein
      carbsG: carbsCalories / 4, // 4 cal per gram carbs
      fatG: fatCalories / 9, // 9 cal per gram fat
      fiberG: 25, // Daily recommended
      vitaminDMcg: 15, // Daily recommended
      vitaminB12Mcg: 2.4, // Daily recommended
      ironMg: 18, // Daily recommended for women
      calciumMg: 1000, // Daily recommended
    );
  }

  /// Adjust targets based on dosha
  NutritionTargets adjustForDosha(String dosha) {
    switch (dosha.toLowerCase()) {
      case 'vata':
        // Vata needs warm, moist, heavier foods
        return NutritionTargets(
          calories: calories * 1.1,
          proteinG: proteinG * 1.1,
          carbsG: carbsG * 1.15,
          fatG: fatG * 1.2,
          fiberG: fiberG * 0.9,
          vitaminDMcg: vitaminDMcg,
          vitaminB12Mcg: vitaminB12Mcg,
          ironMg: ironMg,
          calciumMg: calciumMg,
        );
      case 'pitta':
        // Pitta needs cooling, less spicy foods
        return NutritionTargets(
          calories: calories * 0.95,
          proteinG: proteinG,
          carbsG: carbsG * 1.05,
          fatG: fatG * 0.85,
          fiberG: fiberG * 1.1,
          vitaminDMcg: vitaminDMcg,
          vitaminB12Mcg: vitaminB12Mcg,
          ironMg: ironMg,
          calciumMg: calciumMg,
        );
      case 'kapha':
        // Kapha needs light, spicy, dry foods
        return NutritionTargets(
          calories: calories * 0.85,
          proteinG: proteinG * 1.15,
          carbsG: carbsG * 0.8,
          fatG: fatG * 0.7,
          fiberG: fiberG * 1.3,
          vitaminDMcg: vitaminDMcg,
          vitaminB12Mcg: vitaminB12Mcg,
          ironMg: ironMg,
          calciumMg: calciumMg,
        );
      default:
        return this;
    }
  }
}

/// Meal type calorie distribution
class MealCalorieDistribution {
  final double breakfast; // 25%
  final double lunch; // 35%
  final double dinner; // 30%
  final double snacks; // 10%

  const MealCalorieDistribution({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snacks,
  });

  factory MealCalorieDistribution.standard() {
    return const MealCalorieDistribution(
      breakfast: 0.25,
      lunch: 0.35,
      dinner: 0.30,
      snacks: 0.10,
    );
  }

  factory MealCalorieDistribution.forDosha(String dosha) {
    switch (dosha.toLowerCase()) {
      case 'vata':
        // Vata benefits from more frequent meals
        return const MealCalorieDistribution(
          breakfast: 0.30,
          lunch: 0.30,
          dinner: 0.25,
          snacks: 0.15,
        );
      case 'pitta':
        // Pitta: moderate meals, avoid late eating
        return const MealCalorieDistribution(
          breakfast: 0.25,
          lunch: 0.40,
          dinner: 0.25,
          snacks: 0.10,
        );
      case 'kapha':
        // Kapha: lighter breakfast, smaller dinner
        return const MealCalorieDistribution(
          breakfast: 0.20,
          lunch: 0.40,
          dinner: 0.35,
          snacks: 0.05,
        );
      default:
        return MealCalorieDistribution.standard();
    }
  }

  double getCalories(NutritionTargets targets, String mealType) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return targets.calories * breakfast;
      case 'lunch':
        return targets.calories * lunch;
      case 'dinner':
        return targets.calories * dinner;
      case 'snack':
        return targets.calories * snacks;
      default:
        return 0;
    }
  }
}

/// Nutrition gap analysis
class NutritionGap {
  final String nutrient;
  final double currentIntake;
  final double targetIntake;
  final double gapPercentage;

  const NutritionGap({
    required this.nutrient,
    required this.currentIntake,
    required this.targetIntake,
    required this.gapPercentage,
  });
}

/// Rule Engine for meal planning
class MealPlanRuleEngine {
  final double tdee;
  final String dosha;
  final Map<String, double> currentIntake;
  final String cuisineRegion;

  late final NutritionTargets targets;
  late final MealCalorieDistribution mealDistribution;

  MealPlanRuleEngine({
    required this.tdee,
    required this.dosha,
    required this.currentIntake,
    required this.cuisineRegion,
  }) {
    targets = NutritionTargets.fromTdee(tdee).adjustForDosha(dosha);
    mealDistribution = MealCalorieDistribution.forDosha(dosha);
  }

  /// Analyze nutrition gaps
  List<NutritionGap> analyzeNutritionGaps() {
    final gaps = <NutritionGap>[];
    final nutrients = ['proteinG', 'fiberG', 'vitaminDMcg', 'vitaminB12Mcg', 'ironMg', 'calciumMg'];

    for (final nutrient in nutrients) {
      final current = currentIntake[nutrient] ?? 0;
      final target = _getTargetValue(nutrient);
      
      if (target > 0) {
        final gapPercentage = ((target - current) / target * 100);
        if (gapPercentage > 10) {
          gaps.add(NutritionGap(
            nutrient: nutrient,
            currentIntake: current,
            targetIntake: target,
            gapPercentage: gapPercentage,
          ));
        }
      }
    }

    // Sort by gap percentage (highest first)
    gaps.sort((a, b) => b.gapPercentage.compareTo(a.gapPercentage));
    return gaps;
  }

  double _getTargetValue(String nutrient) {
    switch (nutrient) {
      case 'proteinG':
        return targets.proteinG;
      case 'fiberG':
        return targets.fiberG;
      case 'vitaminDMcg':
        return targets.vitaminDMcg;
      case 'vitaminB12Mcg':
        return targets.vitaminB12Mcg;
      case 'ironMg':
        return targets.ironMg;
      case 'calciumMg':
        return targets.calciumMg;
      default:
        return 0;
    }
  }

  /// Get calorie target for a meal type
  double getCalorieTarget(String mealType) {
    return mealDistribution.getCalories(targets, mealType);
  }

  /// Generate meal suggestions based on gaps
  List<Map<String, dynamic>> generateSuggestions(String mealType) {
    final gaps = analyzeNutritionGaps();
    final calorieTarget = getCalorieTarget(mealType);
    final suggestions = <Map<String, dynamic>>[];

    // Get base suggestions for the meal type
    final baseSuggestions = _getBaseSuggestionsForMealType(mealType);

    // Prioritize foods that address nutrition gaps
    for (final gap in gaps) {
      final foods = _getFoodsForNutrientGap(gap.nutrient, cuisineRegion);
      for (final food in foods) {
        if (!suggestions.any((s) => s['id'] == food['id'])) {
          final adjustedFood = Map<String, dynamic>.from(food);
          adjustedFood['suggestedPortion'] = _calculatePortionForCalories(
            food['caloriesPer100g'] as double,
            calorieTarget,
          );
          suggestions.add(adjustedFood);
        }
      }
    }

    // Add base suggestions if we don't have enough
    for (final suggestion in baseSuggestions) {
      if (!suggestions.any((s) => s['id'] == suggestion['id'])) {
        final adjustedSuggestion = Map<String, dynamic>.from(suggestion);
        adjustedSuggestion['suggestedPortion'] = _calculatePortionForCalories(
          suggestion['caloriesPer100g'] as double,
          calorieTarget,
        );
        suggestions.add(adjustedSuggestion);
      }
    }

    return suggestions.take(10).toList();
  }

  double _calculatePortionForCalories(double caloriesPer100g, double targetCalories) {
    return (targetCalories / caloriesPer100g) * 100;
  }

  List<Map<String, dynamic>> _getBaseSuggestionsForMealType(String mealType) {
    // These will be replaced by actual Indian meal templates
    return [];
  }

  List<Map<String, dynamic>> _getFoodsForNutrientGap(String nutrient, String region) {
    // These will be replaced by actual Indian meal templates
    return [];
  }

  /// Calculate ideal macros for a meal based on calorie target
  Map<String, double> calculateMealMacros(String mealType) {
    final calories = getCalorieTarget(mealType);
    
    return {
      'calories': calories,
      'proteinG': calories * 0.30 / 4,
      'carbsG': calories * 0.40 / 4,
      'fatG': calories * 0.30 / 9,
    };
  }
}

/// Dosha-specific food recommendations
class DoshaFoodRecommendations {
  /// Foods to favor for each dosha
  static Map<String, List<String>> getFavoredFoods(String dosha) {
    switch (dosha.toLowerCase()) {
      case 'vata':
        return {
          'grains': ['rice', 'wheat', 'oats', 'quinoa'],
          'proteins': ['Paneer', 'dal', 'chicken', 'fish'],
          'vegetables': ['carrot', 'sweet potato', 'asparagus', ' squash'],
          'fruits': ['banana', 'mango', 'orange', 'avocado'],
          'spices': ['ginger', 'cumin', 'cinnamon', 'cardamom'],
        };
      case 'pitta':
        return {
          'grains': ['rice', 'wheat', 'barley', 'oats'],
          'proteins': ['Paneer', 'chicken', 'fish', 'legumes'],
          'vegetables': ['cucumber', 'carrot', 'broccoli', 'leafy greens'],
          'fruits': ['apple', 'pear', 'grapes', 'melon'],
          'spices': ['coriander', 'fennel', 'mint', 'turmeric'],
        };
      case 'kapha':
        return {
          'grains': ['barley', 'millet', 'quinoa', 'buckwheat'],
          'proteins': ['chicken', 'fish', 'legumes', 'turkey'],
          'vegetables': ['spinach', 'cabbage', 'broccoli', 'cauliflower'],
          'fruits': ['apple', 'pear', 'pomegranate', 'cranberries'],
          'spices': ['ginger', 'cayenne', 'black pepper', 'clove'],
        };
      default:
        return {};
    }
  }

  /// Foods to avoid for each dosha
  static Map<String, List<String>> getFoodsToAvoid(String dosha) {
    switch (dosha.toLowerCase()) {
      case 'vata':
        return {
          'foods': ['cold drinks', 'dry foods', 'raw vegetables', 'cauliflower'],
        };
      case 'pitta':
        return {
          'foods': ['spicy foods', 'tomatoes', 'citrus', 'fermented foods'],
        };
      case 'kapha':
        return {
          'foods': ['heavy foods', 'dairy', 'fried foods', 'nuts'],
        };
      default:
        return {};
    }
  }

  /// Get meal timing recommendations
  static Map<String, String> getMealTiming(String dosha) {
    switch (dosha.toLowerCase()) {
      case 'vata':
        return {
          'breakfast': '7-8 AM - Warm, substantial',
          'lunch': '12-1 PM - Main meal',
          'dinner': '6-7 PM - Light, warm',
          'snacks': 'Mid-morning and mid-afternoon',
        };
      case 'pitta':
        return {
          'breakfast': '7-8 AM - Light',
          'lunch': '12-1 PM - Largest meal',
          'dinner': '7-8 PM - Cool, light',
          'snacks': 'Only if needed',
        };
      case 'kapha':
        return {
          'breakfast': '7-8 AM - Light or skip',
          'lunch': '11 AM-12 PM - Main meal',
          'dinner': '5-6 PM - Lightest meal',
          'snacks': 'Avoid unless necessary',
        };
      default:
        return {};
    }
  }
}
