// lib/features/ayurveda/data/ritucharya_data.dart
// Seasonal recommendations (Ritucharya) for Indian seasons

import 'package:fitkarma/features/ayurveda/data/ayurveda_models.dart';

/// Ritucharya - Seasonal recommendations based on Ayurvedic principles
class RitucharyaData {
  static const List<SeasonalRecommendation> seasonalRecommendations = [
    // Spring (Vasanta) - March-April
    SeasonalRecommendation(
      season: IndianSeason.spring,
      diet: [
        'Light, easy-to-digest foods',
        'Barley, rice, wheat',
        'Green leafy vegetables',
        'Honey (instead of sugar)',
        'Avoid sour and pungent foods',
      ],
      lifestyle: [
        'Wake early, exercise moderately',
        'Use nasal oil (Nasya)',
        'Practice breathing exercises',
        'Avoid daytime sleeping',
        'Spring cleaning - declutter home',
      ],
      exercises: [
        'Gentle yoga',
        'Walking in nature',
        'Light stretching',
        'Dynamic movements',
      ],
      avoid: [
        'Heavy, oily foods',
        'Excessive exercise',
        'Cold drinks and foods',
        'Overeating',
      ],
      specialNote:
          'Spring is Kapha season. Focus on detoxification (Kitchari diet) and stimulating metabolism.',
    ),

    // Summer (Grishma) - May-June
    SeasonalRecommendation(
      season: IndianSeason.summer,
      diet: [
        'Cool, refreshing foods',
        'Coconut water, buttermilk',
        'Sweet, juicy fruits',
        'Rice, wheat, oats',
        'Ghee in moderation',
        'Avoid spicy and sour tastes',
      ],
      lifestyle: [
        'Stay cool, avoid excessive heat',
        'Midday rest during peak heat',
        'Oil massage with cooling oils',
        'Light clothing',
        'Evening walks when cool',
      ],
      exercises: [
        'Swimming',
        'Early morning yoga',
        'Gentle stretches',
        'Avoid intense exercise in heat',
      ],
      avoid: [
        'Hot, spicy foods',
        'Excessive sun exposure',
        'Heavy exercises',
        'Alcohol and caffeine',
        'Excess salt and sour foods',
      ],
      specialNote:
          'Summer is Pitta season. Focus on cooling the body and pacifying Pitta dosha.',
    ),

    // Monsoon (Varsha) - July-August
    SeasonalRecommendation(
      season: IndianSeason.monsoon,
      diet: [
        'Warm, light, easily digestible',
        'Cooked vegetables',
        'Ginger and garlic preparations',
        'Avoid raw foods',
        'Boiled water',
        'Light buttermilk',
      ],
      lifestyle: [
        'Keep body warm and dry',
        'Ayurvedic detoxification (Panchakarma)',
        'Steam therapy',
        'Avoid getting wet in rain',
        'Use essential oils for immunity',
      ],
      exercises: [
        'Indoor yoga',
        'Light stretches',
        'Walking indoors',
        'Breathing exercises',
      ],
      avoid: [
        'Raw vegetables',
        'Leafy greens in excess',
        'Cold water',
        'Heavy fried foods',
        'Daytime sleeping',
      ],
      specialNote:
          'Monsoon weakens digestion (Agni). Focus on boosting immunity and maintaining digestive strength.',
    ),

    // Autumn (Sharad) - September-October
    SeasonalRecommendation(
      season: IndianSeason.autumn,
      diet: [
        'Sweet, sour, salty tastes',
        'Rice, wheat, pulses',
        'Ghee and oils',
        'Fresh seasonal vegetables',
        'Warm water',
        'Pomegranate, grapes',
      ],
      lifestyle: [
        'Maintain regular routine',
        'Oil massage daily',
        'Nasya oil for sinuses',
        'Get adequate sleep',
        'Practice gratitude',
      ],
      exercises: [
        'Moderate yoga',
        'Walking',
        'Swimming (if available)',
        'Balance exercises',
      ],
      avoid: [
        'Excessive pungent foods',
        'Dry foods',
        'Overexertion',
        'Late nights',
        'Cold drinks',
      ],
      specialNote:
          'Autumn is Vata season. Focus on grounding, nourishing, and building immunity for winter.',
    ),

    // Winter (Hemanta) - November-December
    SeasonalRecommendation(
      season: IndianSeason.winter,
      diet: [
        'Warm, nourishing foods',
        'Soups, stews, khichdi',
        'Ghee, sesame oil',
        'Nuts and dried fruits',
        'Spices: ginger, cinnamon, cardamom',
        'Warm milk with herbs',
      ],
      lifestyle: [
        'Oil massage (Abhyanga) daily',
        'Keep warm, especially feet',
        'Use warming herbs',
        'Evening meditation',
        'Early bedtime',
      ],
      exercises: [
        'Yoga (sun salutations)',
        'Indoor exercises',
        'Moderate intensity',
        'Consistent routine',
      ],
      avoid: [
        'Cold foods and drinks',
        'Light, dry foods',
        'Excessive raw foods',
        'Overexposure to cold',
        'Skipping meals',
      ],
      specialNote:
          'Winter is Kapha season. Focus on maintaining warmth, stimulating digestion, and avoiding heaviness.',
    ),

    // Late Winter (Shishira) - January-February
    SeasonalRecommendation(
      season: IndianSeason.lateWinter,
      diet: [
        'Warming, heavy foods',
        'Root vegetables',
        'Legumes and pulses',
        'Ghee, warm milk',
        'Spiced foods',
        'Avoid cold foods entirely',
      ],
      lifestyle: [
        'Continue Abhyanga (oil massage)',
        'Keep warm, cover head and feet',
        'Sun exposure when possible',
        'Use aromatherapy',
        'Strengthen immunity',
      ],
      exercises: [
        'Yoga with sun salutations',
        'Active but not excessive',
        'Indoor workouts',
        'Stretching',
      ],
      avoid: [
        'Cold beverages',
        'Raw foods',
        'Light salads',
        'Excessive exercise',
        'Getting cold',
      ],
      specialNote:
          'Late winter intensifies Kapha. Focus on lightening practices and preparing for spring.',
    ),
  ];

  /// Get recommendation for a specific season
  static SeasonalRecommendation? getRecommendationForSeason(
    IndianSeason season,
  ) {
    try {
      return seasonalRecommendations.firstWhere((r) => r.season == season);
    } catch (_) {
      return null;
    }
  }

  /// Get recommendation for current season
  static SeasonalRecommendation getCurrentSeasonRecommendation() {
    final currentSeason = IndianSeason.getCurrentSeason();
    return getRecommendationForSeason(currentSeason) ??
        seasonalRecommendations.first;
  }

  /// Get adjusted recommendations based on dosha type
  static List<String> getDietAdjustments(
    DoshaType doshaType,
    IndianSeason season,
  ) {
    final rec = getRecommendationForSeason(season);
    if (rec == null) return [];

    switch (doshaType) {
      case DoshaType.vata:
        return [
          ...rec.diet,
          'Extra ghee and oils',
          'More warm cooked foods',
          'Avoid raw foods completely',
          'Sweet taste in moderation',
        ];
      case DoshaType.pitta:
        return [
          'Avoid hot, spicy foods',
          'Use cooling herbs (mint, fennel)',
          'Sweet, bitter, astringent tastes',
          'Avoid sour and salty',
          'Room temperature foods',
          ...rec.diet.where((d) => !d.contains('spicy') && !d.contains('sour')),
        ];
      case DoshaType.kapha:
        return [
          'Light, dry foods',
          'More pungent, bitter, astringent',
          'Less sweet, oily, heavy',
          'Use ginger to stimulate digestion',
          'Honey (never cooked)',
          ...rec.diet.where((d) => !d.contains('heavy') && !d.contains('oily')),
        ];
    }
  }

  /// Get lifestyle adjustments based on dosha
  static List<String> getLifestyleAdjustments(
    DoshaType doshaType,
    IndianSeason season,
  ) {
    switch (doshaType) {
      case DoshaType.vata:
        return [
          'Maintain consistent routine',
          'Oil massage twice daily',
          'Stay warm always',
          'Meditate to reduce anxiety',
          'Ground yourself in nature',
          'Get 8 hours sleep',
        ];
      case DoshaType.pitta:
        return [
          'Avoid overheating',
          'Take time to relax',
          'Don\'t skip meals',
          'Avoid conflict and frustration',
          'Cooling breathing exercises',
          'Early bedtime before 10 PM',
        ];
      case DoshaType.kapha:
        return [
          'Exercise every morning',
          'Avoid daytime naps',
          'Stay active and engaged',
          'Use stimulating herbs',
          'Light, warm foods only',
          'Get up early (before 6 AM)',
        ];
    }
  }
}
