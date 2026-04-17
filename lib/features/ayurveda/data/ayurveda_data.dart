import '../domain/dosha_calculator.dart';

class AyurvedaData {
  static const Map<Dosha, List<Map<String, dynamic>>> dinacharya = {
    Dosha.vata: [
      {'label': 'Wake up before sunrise (Brahma Muhurta)', 'karma': 20, 'key': 'wakeup_vata'},
      {'label': 'Drink warm water with ginger', 'karma': 5, 'key': 'water_vata'},
      {'label': 'Standard Abhyanga (warm sesame oil)', 'karma': 15, 'key': 'oil_vata'},
      {'label': 'Grounding Nadi Shodhana pranayama', 'karma': 10, 'key': 'breath_vata'},
      {'label': 'Eat warm, oily, cooked foods', 'karma': 10, 'key': 'food_vata'},
    ],
    Dosha.pitta: [
      {'label': 'Wake up at sunrise', 'karma': 15, 'key': 'wakeup_pitta'},
      {'label': 'Drink room temperature water', 'karma': 5, 'key': 'water_pitta'},
      {'label': 'Cooling Abhyanga (coconut oil)', 'karma': 15, 'key': 'oil_pitta'},
      {'label': 'Sheetali cooling pranayama', 'karma': 10, 'key': 'breath_pitta'},
      {'label': 'Eat cooling, sweet/bitter foods', 'karma': 10, 'key': 'food_pitta'},
    ],
    Dosha.kapha: [
      {'label': 'Wake up before 6 AM', 'karma': 20, 'key': 'wakeup_kapha'},
      {'label': 'Warm water with honey and lemon', 'karma': 5, 'key': 'water_kapha'},
      {'label': 'Dry Udvartana herbal massage', 'karma': 15, 'key': 'oil_kapha'},
      {'label': 'Stimulating Kapalabhati pranayama', 'karma': 10, 'key': 'breath_kapha'},
      {'label': 'Eat light, warm, pungent foods', 'karma': 10, 'key': 'food_kapha'},
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
