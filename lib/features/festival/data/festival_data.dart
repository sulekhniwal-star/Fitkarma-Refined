// lib/features/festival/data/festival_data.dart
// Hardcoded Indian Festival Database - Zero API dependency

import 'package:flutter/material.dart';

/// Festival types
enum FestivalType { navratri, ramadan, diwali, karwaChauth, holi }

/// Extension for FestivalType display names
extension FestivalTypeExtension on FestivalType {
  String get displayName {
    switch (this) {
      case FestivalType.navratri:
        return 'Navratri';
      case FestivalType.ramadan:
        return 'Ramadan';
      case FestivalType.diwali:
        return 'Diwali';
      case FestivalType.karwaChauth:
        return 'Karwa Chauth';
      case FestivalType.holi:
        return 'Holi';
    }
  }

  String get hindiName {
    switch (this) {
      case FestivalType.navratri:
        return 'नवरात्रि';
      case FestivalType.ramadan:
        return 'रमज़ान';
      case FestivalType.diwali:
        return 'दिवाली';
      case FestivalType.karwaChauth:
        return 'करवा चौथ';
      case FestivalType.holi:
        return 'होली';
    }
  }

  String get description {
    switch (this) {
      case FestivalType.navratri:
        return '9-day Hindu festival celebrating the goddess Durga';
      case FestivalType.ramadan:
        return 'Islamic holy month of fasting from dawn to sunset';
      case FestivalType.diwali:
        return 'Festival of lights celebrating the return of Lord Rama';
      case FestivalType.karwaChauth:
        return 'Hindu fasting day for married women';
      case FestivalType.holi:
        return 'Festival of colors celebrating spring';
    }
  }

  IconData get icon {
    switch (this) {
      case FestivalType.navratri:
        return Icons.temple_hindu;
      case FestivalType.ramadan:
        return Icons.nights_stay;
      case FestivalType.diwali:
        return Icons.lightbulb;
      case FestivalType.karwaChauth:
        return Icons.water_drop;
      case FestivalType.holi:
        return Icons.palette;
    }
  }

  Color get color {
    switch (this) {
      case FestivalType.navratri:
        return const Color(0xFFE91E63); // Pink
      case FestivalType.ramadan:
        return const Color(0xFF4CAF50); // Green
      case FestivalType.diwali:
        return const Color(0xFFFF9800); // Orange
      case FestivalType.karwaChauth:
        return const Color(0xFF9C27B0); // Purple
      case FestivalType.holi:
        return const Color(0xFFE91E63); // Pink/Magenta
    }
  }
}

/// Festival data model
class Festival {
  final FestivalType type;
  final DateTime startDate;
  final DateTime endDate;
  final int notificationDaysBefore;
  final List<String> fastingGuidelines;
  final List<DaySpecificGuide>? dayGuides; // For Navratri
  final List<FestivalFood>? recommendedFoods;
  final List<FestivalFood>? healthyAlternatives; // For Diwali

  const Festival({
    required this.type,
    required this.startDate,
    required this.endDate,
    this.notificationDaysBefore = 3,
    this.fastingGuidelines = const [],
    this.dayGuides,
    this.recommendedFoods,
    this.healthyAlternatives,
  });

  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(startDate.subtract(const Duration(days: 1))) &&
        now.isBefore(endDate.add(const Duration(days: 1)));
  }

  bool get isUpcoming {
    final now = DateTime.now();
    return now.isBefore(startDate);
  }

  int get daysUntilStart {
    final now = DateTime.now();
    return startDate.difference(now).inDays;
  }

  int get daysRemaining {
    final now = DateTime.now();
    return endDate.difference(now).inDays;
  }
}

/// Day-specific guide for Navratri
class DaySpecificGuide {
  final int day;
  final String name;
  final String mantra;
  final String color;
  final List<String> allowedFoods;
  final List<String> prohibitedFoods;
  final String fastingDifficulty; // Easy, Medium, Hard

  const DaySpecificGuide({
    required this.day,
    required this.name,
    required this.mantra,
    required this.color,
    required this.allowedFoods,
    required this.prohibitedFoods,
    required this.fastingDifficulty,
  });
}

/// Festival food item
class FestivalFood {
  final String name;
  final String nameHindi;
  final double caloriesPer100g;
  final double proteinG;
  final double carbsG;
  final double fatG;
  final bool isHealthy;
  final String? alternativeFor;
  final String healthTip;

  const FestivalFood({
    required this.name,
    required this.nameHindi,
    required this.caloriesPer100g,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    this.isHealthy = false,
    this.alternativeFor,
    this.healthTip = '',
  });
}

/// Garba activity for calorie tracking
class GarbaActivity {
  final String name;
  final String description;
  final int caloriesPerHour;
  final String difficulty;

  const GarbaActivity({
    required this.name,
    required this.description,
    required this.caloriesPerHour,
    required this.difficulty,
  });
}

/// Sehri/Iftar meal item
class SehriIftarMeal {
  final String name;
  final String nameHindi;
  final double calories;
  final String bestTime; // 'sehri' or 'iftar'
  final List<String> nutrients;
  final String tip;

  const SehriIftarMeal({
    required this.name,
    required this.nameHindi,
    required this.calories,
    required this.bestTime,
    required this.nutrients,
    required this.tip,
  });
}

/// Hardcoded Festival Database
class FestivalDatabase {
  // Singleton
  static final FestivalDatabase _instance = FestivalDatabase._internal();
  factory FestivalDatabase() => _instance;
  FestivalDatabase._internal();

  /// Get all festivals for a given year
  List<Festival> getFestivalsForYear(int year) {
    return [
      ..._getNavratriDates(year),
      ..._getRamadanDates(year),
      ..._getDiwaliDates(year),
      ..._getKarwaChauthDates(year),
      ..._getHoliDates(year),
    ];
  }

  /// Get upcoming festivals (sorted by start date)
  List<Festival> getUpcomingFestivals({int limit = 5}) {
    final now = DateTime.now();
    final allFestivals = [
      ...getFestivalsForYear(now.year),
      ...getFestivalsForYear(now.year + 1),
    ];

    final upcoming =
        allFestivals
            .where(
              (f) => f.startDate.isAfter(now.subtract(const Duration(days: 7))),
            )
            .toList()
          ..sort((a, b) => a.startDate.compareTo(b.startDate));

    return upcoming.take(limit).toList();
  }

  /// Get active festival (if any)
  Festival? getActiveFestival() {
    final now = DateTime.now();
    final allFestivals = [
      ...getFestivalsForYear(now.year),
      ...getFestivalsForYear(now.year + 1),
    ];

    try {
      return allFestivals.firstWhere((f) => f.isActive);
    } catch (_) {
      return null;
    }
  }

  /// Navratri dates for various years
  List<Festival> _getNavratriDates(int year) {
    // Navratri typically occurs in March/April (Chaitra) and September/October (Sharad)
    final List<Map<String, dynamic>> dates = [
      {
        'year': 2025,
        'start': '2025-03-22',
        'end': '2025-03-30',
        'name': 'Chaitra Navratri',
      },
      {
        'year': 2025,
        'start': '2025-09-22',
        'end': '2025-09-30',
        'name': 'Sharad Navratri',
      },
      {
        'year': 2026,
        'start': '2026-03-11',
        'end': '2026-03-19',
        'name': 'Chaitra Navratri',
      },
      {
        'year': 2026,
        'start': '2026-09-12',
        'end': '2026-09-20',
        'name': 'Sharad Navratri',
      },
      {
        'year': 2027,
        'start': '2027-03-01',
        'end': '2027-03-09',
        'name': 'Chaitra Navratri',
      },
      {
        'year': 2027,
        'start': '2027-09-21',
        'end': '2027-09-29',
        'name': 'Sharad Navratri',
      },
    ];

    return dates
        .where((d) => d['year'] == year)
        .map(
          (d) => Festival(
            type: FestivalType.navratri,
            startDate: DateTime.parse(d['start'] as String),
            endDate: DateTime.parse(d['end'] as String),
            fastingGuidelines: _navratriGuidelines,
            dayGuides: _navratriDayGuides,
          ),
        )
        .toList();
  }

  /// Ramadan dates for various years (approximate based on Islamic calendar)
  List<Festival> _getRamadanDates(int year) {
    // Ramadan shifts approximately 11 days earlier each year
    final List<Map<String, dynamic>> dates = [
      {'year': 2025, 'start': '2025-02-28', 'end': '2025-03-30'},
      {'year': 2026, 'start': '2026-02-17', 'end': '2026-03-18'},
      {'year': 2027, 'start': '2027-02-06', 'end': '2027-03-08'},
      {'year': 2028, 'start': '2028-01-27', 'end': '2028-02-25'},
    ];

    return dates
        .where((d) => d['year'] == year)
        .map(
          (d) => Festival(
            type: FestivalType.ramadan,
            startDate: DateTime.parse(d['start'] as String),
            endDate: DateTime.parse(d['end'] as String),
            fastingGuidelines: _ramadanGuidelines,
            recommendedFoods: _sehriIftarFoods,
          ),
        )
        .toList();
  }

  /// Diwali dates for various years
  List<Festival> _getDiwaliDates(int year) {
    // Diwali typically falls in October or November
    final List<Map<String, dynamic>> dates = [
      {'year': 2025, 'date': '2025-10-20'},
      {'year': 2026, 'date': '2026-10-09'},
      {'year': 2027, 'date': '2027-10-29'},
      {'year': 2028, 'date': '2028-10-17'},
    ];

    return dates.where((d) => d['year'] == year).map((d) {
      final date = DateTime.parse(d['date'] as String);
      return Festival(
        type: FestivalType.diwali,
        startDate: date,
        endDate: date,
        fastingGuidelines: _diwaliGuidelines,
        recommendedFoods: _diwaliSweets,
        healthyAlternatives: _diwaliHealthyAlternatives,
      );
    }).toList();
  }

  /// Karwa Chauth dates for various years
  List<Festival> _getKarwaChauthDates(int year) {
    // Karwa Chauth typically falls in October or November
    final List<Map<String, dynamic>> dates = [
      {'year': 2025, 'date': '2025-10-17'},
      {'year': 2026, 'date': '2026-10-06'},
      {'year': 2027, 'date': '2027-10-25'},
      {'year': 2028, 'date': '2028-10-13'},
    ];

    return dates.where((d) => d['year'] == year).map((d) {
      final date = DateTime.parse(d['date'] as String);
      return Festival(
        type: FestivalType.karwaChauth,
        startDate: date,
        endDate: date,
        fastingGuidelines: _karwaChauthGuidelines,
      );
    }).toList();
  }

  /// Holi dates for various years
  List<Festival> _getHoliDates(int year) {
    // Holi typically falls in March
    final List<Map<String, dynamic>> dates = [
      {'year': 2025, 'date': '2025-03-14'},
      {'year': 2026, 'date': '2026-03-03'},
      {'year': 2027, 'date': '2027-03-21'},
      {'year': 2028, 'date': '2028-03-09'},
    ];

    return dates.where((d) => d['year'] == year).map((d) {
      final date = DateTime.parse(d['date'] as String);
      return Festival(
        type: FestivalType.holi,
        startDate: date,
        endDate: date,
        fastingGuidelines: _holiGuidelines,
      );
    }).toList();
  }

  // ============== Static Data ==============

  static const List<String> _navratriGuidelines = [
    'Eat only vegetarian food during Navratri',
    'Avoid onions, garlic, and legumes',
    'Drink plenty of water and stay hydrated',
    'Have small, frequent meals',
    'Include fruits, nuts, and dairy products',
    'Avoid fried foods and excessive oil',
    'Practice fasting during the 9 days',
    'Wake up early and pray to Goddess Durga',
    'Avoid non-vegetarian food and alcohol',
  ];

  static const List<DaySpecificGuide> _navratriDayGuides = [
    DaySpecificGuide(
      day: 1,
      name: 'Pratima',
      mantra: 'Om Jagadambe Namah',
      color: 'Red',
      allowedFoods: ['Kuttu flour', 'Singhare ka flour', 'Fruits', 'Dairy'],
      prohibitedFoods: ['Onions', 'Garlic', 'Non-veg', 'Legumes'],
      fastingDifficulty: 'Easy',
    ),
    DaySpecificGuide(
      day: 2,
      name: 'Brahmacharini',
      mantra: 'Om Brahmacharinyai Namah',
      color: 'Blue',
      allowedFoods: ['Milk', 'Fruits', 'Dry fruits', 'Kuttu puri'],
      prohibitedFoods: ['Onions', 'Garlic', 'Rice', 'Wheat'],
      fastingDifficulty: 'Easy',
    ),
    DaySpecificGuide(
      day: 3,
      name: 'Chandraghanta',
      mantra: 'Om Chandraghantayai Namah',
      color: 'Yellow',
      allowedFoods: ['Lassi', 'Banana', 'Kheer', 'Sabudana'],
      prohibitedFoods: ['Onions', 'Garlic', 'Non-veg', 'Fried foods'],
      fastingDifficulty: 'Medium',
    ),
    DaySpecificGuide(
      day: 4,
      name: 'Kushmanda',
      mantra: 'Om Kushmandayai Namah',
      color: 'Green',
      allowedFoods: ['Malai', 'Pure ghee', 'Rice', 'Dal'],
      prohibitedFoods: ['Onions', 'Garlic', 'Tamarind'],
      fastingDifficulty: 'Medium',
    ),
    DaySpecificGuide(
      day: 5,
      name: 'Skandamata',
      mantra: 'Om Skandamatayai Namah',
      color: 'Grey',
      allowedFoods: ['Doodh', 'Dahi', 'Fruits', 'Kuttu flour'],
      prohibitedFoods: ['Onions', 'Garlic', 'Non-veg'],
      fastingDifficulty: 'Easy',
    ),
    DaySpecificGuide(
      day: 6,
      name: 'Katyayani',
      mantra: 'Om Katyayanyai Namah',
      color: 'Orange',
      allowedFoods: ['Halwa', 'Panjiri', 'Fruits', 'Nuts'],
      prohibitedFoods: ['Onions', 'Garlic', 'Fried foods'],
      fastingDifficulty: 'Hard',
    ),
    DaySpecificGuide(
      day: 7,
      name: 'Kalaratri',
      mantra: 'Om Kalaratryai Namah',
      color: 'White',
      allowedFoods: ['Fruits', 'Milk', 'Jaggery', 'Nuts'],
      prohibitedFoods: ['Onions', 'Garlic', 'Non-veg', 'Legumes'],
      fastingDifficulty: 'Hard',
    ),
    DaySpecificGuide(
      day: 8,
      name: 'Mahagauri',
      mantra: 'Om Mahagauryai Namah',
      color: 'Pink',
      allowedFoods: ['Kheer', 'Panjiri', 'Fruits', 'Dairy'],
      prohibitedFoods: ['Onions', 'Garlic', 'Non-veg'],
      fastingDifficulty: 'Medium',
    ),
    DaySpecificGuide(
      day: 9,
      name: 'Siddhidatri',
      mantra: 'Om Siddhidatryai Namah',
      color: 'Purple',
      allowedFoods: ['Prasad', 'Fruits', 'Milk', 'Nuts'],
      prohibitedFoods: ['Onions', 'Garlic', 'Non-veg'],
      fastingDifficulty: 'Easy',
    ),
  ];

  static const List<String> _ramadanGuidelines = [
    'Wake up for Sehri (pre-dawn meal) and eat Suhoor',
    'Break fast at Iftar with dates and water',
    'Start with light foods at Iftar',
    'Avoid overeating after Iftar',
    'Drink plenty of water between Iftar and sleep',
    'Include protein-rich foods in Sehri',
    'Avoid caffeine and sugary drinks',
    'Get adequate rest during the day',
    'Listen to your body and adjust activity levels',
  ];

  static const List<String> _diwaliGuidelines = [
    'Enjoy sweets in moderation',
    'Opt for homemade sweets over store-bought',
    'Include nuts and dry fruits for health benefits',
    'Stay hydrated with water and electrolytes',
    'Practice mindful eating',
    'Include fiber-rich foods to balance calorie intake',
    'Balance sweets with savory snacks',
    'Include fresh fruits in your diet',
    'Maintain regular exercise routine',
  ];

  static const List<String> _karwaChauthGuidelines = [
    'Complete fasting from sunrise to moonrise',
    'Wake up early for Sargi meal',
    'Break fast after sighting the moon',
    'Drink water and fluids throughout the day',
    'Avoid strenuous activities',
    'Eat light foods after breaking fast',
    'Include energy-boosting foods in Sargi',
    'Rest and conserve energy during the day',
  ];

  static const List<String> _holiGuidelines = [
    'Play with natural colors instead of synthetic ones',
    'Stay hydrated before and after playing Holi',
    'Eat a light meal before playing',
    'Apply oil to skin before playing for protection',
    'Avoid consuming alcohol and excessive sweets',
    'Use protective eyewear',
    'Wash colors off with lukewarm water',
    'Apply moisturizer after bathing',
    'Rest if you feel exhausted',
  ];

  // ============== Food Data ==============

  static const List<FestivalFood> _diwaliSweets = [
    FestivalFood(
      name: 'Ladoo (Besan)',
      nameHindi: 'बेसन के लड्डू',
      caloriesPer100g: 450,
      proteinG: 8,
      carbsG: 50,
      fatG: 25,
      healthTip: 'High in calories - enjoy in moderation',
    ),
    FestivalFood(
      name: 'Barfi',
      nameHindi: 'बर्फी',
      caloriesPer100g: 500,
      proteinG: 6,
      carbsG: 55,
      fatG: 28,
      healthTip: 'Rich in sugar - share with family',
    ),
    FestivalFood(
      name: 'Gulab Jamun',
      nameHindi: 'गुलाब जामुन',
      caloriesPer100g: 350,
      proteinG: 4,
      carbsG: 45,
      fatG: 15,
      healthTip: 'Best consumed fresh',
    ),
    FestivalFood(
      name: 'Jalebi',
      nameHindi: 'जलेबी',
      caloriesPer100g: 450,
      proteinG: 3,
      carbsG: 60,
      fatG: 20,
      healthTip: 'Very high in sugar - limited consumption',
    ),
    FestivalFood(
      name: 'Motichoor Ladoo',
      nameHindi: 'मोतीचूर लड्डू',
      caloriesPer100g: 420,
      proteinG: 7,
      carbsG: 48,
      fatG: 22,
      healthTip: 'Contains ghee - consume in moderation',
    ),
    FestivalFood(
      name: 'Kaju Katli',
      nameHindi: 'काजू कतली',
      caloriesPer100g: 550,
      proteinG: 10,
      carbsG: 45,
      fatG: 35,
      healthTip: 'High in healthy fats from cashews',
    ),
  ];

  static const List<FestivalFood> _diwaliHealthyAlternatives = [
    FestivalFood(
      name: 'Dry Fruit Ladoo',
      nameHindi: 'मेवा लड्डू',
      caloriesPer100g: 320,
      proteinG: 12,
      carbsG: 30,
      fatG: 18,
      isHealthy: true,
      alternativeFor: 'Besan Ladoo',
      healthTip: 'Rich in minerals and healthy fats',
    ),
    FestivalFood(
      name: 'Baked Barfi',
      nameHindi: 'बेक्ड बर्फी',
      caloriesPer100g: 280,
      proteinG: 8,
      carbsG: 35,
      fatG: 12,
      isHealthy: true,
      alternativeFor: 'Barfi',
      healthTip: 'Baked instead of fried - lower fat',
    ),
    FestivalFood(
      name: 'Mithai with Jaggery',
      nameHindi: 'गुड़ की मिठाई',
      caloriesPer100g: 300,
      proteinG: 5,
      carbsG: 40,
      fatG: 12,
      isHealthy: true,
      alternativeFor: 'Sugar sweets',
      healthTip: 'Jaggery is more nutritious than refined sugar',
    ),
    FestivalFood(
      name: 'Roasted Makhana',
      nameHindi: 'भुना मखाना',
      caloriesPer100g: 150,
      proteinG: 10,
      carbsG: 15,
      fatG: 5,
      isHealthy: true,
      alternativeFor: 'Fried snacks',
      healthTip: 'Low calorie, high protein snack',
    ),
    FestivalFood(
      name: 'Fruit Chaat',
      nameHindi: 'फ्रूट चाट',
      caloriesPer100g: 80,
      proteinG: 2,
      carbsG: 18,
      fatG: 0,
      isHealthy: true,
      alternativeFor: 'Sweets',
      healthTip: 'Rich in vitamins and fiber',
    ),
  ];

  static const List<FestivalFood> _sehriIftarFoods = [
    FestivalFood(
      name: 'Dates',
      nameHindi: 'खजूर',
      caloriesPer100g: 277,
      proteinG: 1.8,
      carbsG: 75,
      fatG: 0.2,
      isHealthy: true,
      healthTip: 'Best for Iftar - natural energy boost',
    ),
    FestivalFood(
      name: 'Oatmeal',
      nameHindi: 'ओटमील',
      caloriesPer100g: 389,
      proteinG: 16.9,
      carbsG: 66,
      fatG: 6.9,
      isHealthy: true,
      healthTip: 'Perfect for Sehri - sustained energy',
    ),
    FestivalFood(
      name: 'Chicken/Protein',
      nameHindi: 'चिकन/प्रोटीन',
      caloriesPer100g: 165,
      proteinG: 31,
      carbsG: 0,
      fatG: 3.6,
      isHealthy: true,
      healthTip: 'Keep you full during fasting hours',
    ),
    FestivalFood(
      name: 'Yogurt',
      nameHindi: 'दही',
      caloriesPer100g: 61,
      proteinG: 3.5,
      carbsG: 4.7,
      fatG: 3.3,
      isHealthy: true,
      healthTip: 'Good for gut health during Ramadan',
    ),
    FestivalFood(
      name: 'Eggs',
      nameHindi: 'अंडे',
      caloriesPer100g: 155,
      proteinG: 13,
      carbsG: 1.1,
      fatG: 11,
      isHealthy: true,
      healthTip: 'Complete protein for Sehri',
    ),
  ];

  // ============== Garba Activities ==============

  static const List<GarbaActivity> garbaActivities = [
    GarbaActivity(
      name: 'Garba (Standard)',
      description: 'Traditional Garba dance around the lamp',
      caloriesPerHour: 350,
      difficulty: 'Medium',
    ),
    GarbaActivity(
      name: 'Dandiya Raas',
      description: 'Dancing with wooden sticks',
      caloriesPerHour: 400,
      difficulty: 'High',
    ),
    GarbaActivity(
      name: 'Raas Garba',
      description: 'Fast-paced Garba variation',
      caloriesPerHour: 450,
      difficulty: 'High',
    ),
    GarbaActivity(
      name: 'Easy Garba',
      description: 'Simple steps for beginners',
      caloriesPerHour: 250,
      difficulty: 'Easy',
    ),
  ];
}
