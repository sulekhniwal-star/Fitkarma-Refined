import '../domain/dosha_calculator.dart';

class AyurvedaData {
  static const Map<Dosha, List<String>> dinacharya = {
    Dosha.vata: [
      'Wake up before sunrise (Brahma Muhurta)',
      'Drink warm water with ginger',
      'Standard Abhyanga (warm sesame oil massage)',
      'Subtle, grounding pranayama (Nadi Shodhana)',
      'Warm, oily, cooked foods only',
    ],
    Dosha.pitta: [
      'Wake up at sunrise',
      'Drink room temperature water',
      'Daily Abhyanga (cooling coconut/sunflower oil)',
      'Sheetali pranayama (cooling breath)',
      'Cooling, sweet, and bitter foods',
    ],
    Dosha.kapha: [
      'Wake up before 6 AM',
      'Drink warm water with honey and lemon',
      'Dry massage (Udvartana) with herbal powder',
      'Stimulating Kapalabhati pranayama',
      'Light, warm, pungent, and astringent foods',
    ],
  };

  static const List<Map<String, dynamic>> ritucharya = [
    {
      'season': 'Vasanta (Spring)',
      'months': 'March - April',
      'focus': 'Kapha pacifying',
      'activities': 'Dry massage, intense exercise, steam bath',
      'foods': 'Honey, dry grains (barley), pungent herbs',
    },
    {
      'season': 'Grishma (Summer)',
      'months': 'May - June',
      'focus': 'Pitta pacifying',
      'activities': 'Swimming, cool moonlight walks, limit exertion',
      'foods': 'Cucumber, watermelon, coconut water, sweet fruits',
    },
    {
      'season': 'Varsha (Monsoon)',
      'months': 'July - August',
      'focus': 'Vata pacifying',
      'activities': 'Stay dry, sesame oil massage, rest',
      'foods': 'Ginger tea, rice, lentils, ghee',
    },
    {
      'season': 'Sharad (Autumn)',
      'months': 'September - October',
      'focus': 'Pitta clearing',
      'activities': 'Gentle yoga, cooling herbs',
      'foods': 'Ghee, coconut, bitter greens, cabbage',
    },
    {
      'season': 'Hemanta (Late Autumn)',
      'months': 'November - December',
      'focus': 'Agni boosting',
      'activities': 'Abhyanga, sun bathing, warming cardio',
      'foods': 'Nuts, seeds, whole grains, warm spices',
    },
    {
      'season': 'Shishira (Winter)',
      'months': 'January - February',
      'focus': 'Vata nourishing',
      'activities': 'Intense Abhyanga, staying very warm',
      'foods': 'Root vegetables, thick stews, spicy teas',
    },
  ];

  static const List<Map<String, String>> remedies = [
    {
      'name': 'Ashwagandha',
      'benefits': 'Reduces stress, boosts immunity and strength.',
      'type': 'Adaptogen',
      'usage': '1/2 tsp with warm milk/water before bed.',
    },
    {
      'name': 'Triphala',
      'benefits': 'Digestion, detox, and gentle bowel cleanse.',
      'type': 'Digestive',
      'usage': '1 tsp in warm water after dinner.',
    },
    {
      'name': 'Brahmi',
      'benefits': 'Improves memory, focus and reduces anxiety.',
      'type': 'Brain Tonic',
      'usage': '1/4 tsp with ghee or honey.',
    },
    {
      'name': 'Turmeric (Haldi)',
      'benefits': 'Anti-inflammatory and natural antiseptic.',
      'type': 'Superfood',
      'usage': 'Golden milk or in daily cooking.',
    },
  ];
}
