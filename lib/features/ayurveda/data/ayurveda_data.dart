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

  static const List<Map<String, dynamic>> remedies = [
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

  static const List<Map<String, dynamic>> prakritiQuestions = [
    {
      'category': 'Physical',
      'questionEn': 'What is your body frame?',
      'questionHi': 'आपका शारीरिक ढांचा कैसा है?',
      'options': [
        {'textEn': 'Thin, bony, difficult to gain weight', 'textHi': 'दुबला-पतला, हड्डियां दिखती हैं, वजन बढ़ना मुश्किल है', 'points': {'vata': 3, 'pitta': 0, 'kapha': 0}},
        {'textEn': 'Medium, athletic, consistent weight', 'textHi': 'मध्यम, एथलेटिक, स्थिर वजन', 'points': {'vata': 0, 'pitta': 3, 'kapha': 0}},
        {'textEn': 'Broad, large-boned, gains weight easily', 'textHi': 'चौड़ा, भारी हड्डियां, वजन आसानी से बढ़ता है', 'points': {'vata': 0, 'pitta': 0, 'kapha': 3}},
      ]
    },
    {
      'category': 'Physical',
      'questionEn': 'Describe your skin texture.',
      'questionHi': 'अपनी त्वचा की बनावट का वर्णन करें।',
      'options': [
        {'textEn': 'Dry, rough, prone to cracking', 'textHi': 'रूखी, खुरदरी, फटने वाली', 'points': {'vata': 3, 'pitta': 0, 'kapha': 0}},
        {'textEn': 'Oily, warm, prone to acne/redness', 'textHi': 'तैलीय, गर्म, मुहांसे/लालिमा वाली', 'points': {'vata': 0, 'pitta': 3, 'kapha': 0}},
        {'textEn': 'Thick, smooth, cool, oily', 'textHi': 'मोटी, चिकनी, ठंडी, तैलीय', 'points': {'vata': 0, 'pitta': 0, 'kapha': 3}},
      ]
    },
    {
      'category': 'Physiological',
      'questionEn': 'How is your digestion?',
      'questionHi': 'आपका पाचन कैसा है?',
      'options': [
        {'textEn': 'Irregular, prone to gas/bloating', 'textHi': 'अनियमित, गैस/ब्लोटिंग होती है', 'points': {'vata': 3, 'pitta': 0, 'kapha': 0}},
        {'textEn': 'Strong, intense hunger, acidic', 'textHi': 'तेज, तीव्र भूख, एसिडिक', 'points': {'vata': 0, 'pitta': 3, 'kapha': 0}},
        {'textEn': 'Slow, heavy after meals', 'textHi': 'धीमा, भोजन के बाद भारीपन', 'points': {'vata': 0, 'pitta': 0, 'kapha': 3}},
      ]
    },
    {
      'category': 'Physiological',
      'questionEn': 'Describe your sleep pattern.',
      'questionHi': 'अपनी नींद के पैटर्न का वर्णन करें।',
      'options': [
        {'textEn': 'Light, interrupted, often insomniac', 'textHi': 'हल्की, बीच-बीच में टूटने वाली, अक्सर अनिद्रा', 'points': {'vata': 3, 'pitta': 0, 'kapha': 0}},
        {'textEn': 'Moderate but sound, 6-7 hours', 'textHi': 'मध्यम लेकिन गहरी, 6-7 घंटे', 'points': {'vata': 0, 'pitta': 3, 'kapha': 0}},
        {'textEn': 'Deep, long, difficult to wake up', 'textHi': 'गहरी, लंबी, जागना मुश्किल', 'points': {'vata': 0, 'pitta': 0, 'kapha': 3}},
      ]
    },
    {
      'category': 'Mental',
      'questionEn': 'How do you handle stress?',
      'questionHi': 'आप तनाव को कैसे संभालते हैं?',
      'options': [
        {'textEn': 'Anxious, fearful, worried', 'textHi': 'चिंतित, भयभीत, परेशान', 'points': {'vata': 3, 'pitta': 0, 'kapha': 0}},
        {'textEn': 'Irritable, angry, impatient', 'textHi': 'चिड़चिड़ा, क्रोधित, अधीर', 'points': {'vata': 0, 'pitta': 3, 'kapha': 0}},
        {'textEn': 'Calm, steady, withdraws', 'textHi': 'शांत, स्थिर, पीछे हट जाना', 'points': {'vata': 0, 'pitta': 0, 'kapha': 3}},
      ]
    },
  ];
}


