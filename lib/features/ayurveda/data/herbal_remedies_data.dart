// lib/features/ayurveda/data/herbal_remedies_data.dart
// Herbal remedies library with evidence notes

import 'package:fitkarma/features/ayurveda/data/ayurveda_models.dart';

/// Herbal remedies library
class HerbalRemediesData {
  static const List<HerbalRemedy> remedies = [
    // Ashwagandha
    HerbalRemedy(
      id: 'ashwagandha',
      name: 'Ashwagandha',
      sanskritName: 'अश्वगन्धा',
      botanicalName: 'Withania somnifera',
      primaryDosha: [DoshaType.vata],
      secondaryDosha: [DoshaType.kapha],
      description:
          'Known as "Indian Ginseng", ashwagandha is a powerful adaptogen that helps the body manage stress and anxiety. It promotes strength, vitality, and longevity.',
      uses: '''
• Reduces stress and anxiety (adaptogen)
• Improves sleep quality
• Boosts energy and stamina
• Supports thyroid function
• Enhances muscle strength and recovery
• May improve cognitive function
• Supports immune system
• Helps with joint pain and inflammation
      ''',
      dosage: '''
• Powder: 1-2 grams daily with warm milk or water
• Capsule: 300-600mg extract daily
• Best taken in morning or evening
• Use for 2-3 months, then take a break
      ''',
      evidence: '''
Clinical studies show ashwagandha significantly reduces cortisol (stress hormone) levels by 22-30%. A 2021 meta-analysis found it effective for anxiety reduction. Research supports its adaptogenic properties for stress management.
      ''',
      caution: '''
• May cause drowsiness - avoid driving after taking
• Avoid during pregnancy and breastfeeding
• Can interact with thyroid medication
• High doses may cause digestive issues
• Consult doctor if on blood pressure or diabetes medication
      ''',
      emoji: '🌿',
    ),

    // Triphala
    HerbalRemedy(
      id: 'triphala',
      name: 'Triphala',
      sanskritName: 'त्रिफला',
      botanicalName:
          'Emblica officinalis + Terminalia chebula + Terminalia bellirica',
      primaryDosha: [DoshaType.vata, DoshaType.pitta, DoshaType.kapha],
      secondaryDosha: [],
      description:
          'A foundational Ayurvedic formula combining three fruits (Amalaki, Bibhitaki, Haritaki). Triphala is a gentle detoxifier and rejuvenator that supports digestion, detoxification, and overall health.',
      uses: '''
• Gentle daily detoxifier
• Supports healthy digestion and bowel movements
• Antioxidant properties - fights free radicals
• Supports liver function
• May help with weight management
• Eye health (contains Vitamin A)
• Skin health
• Immune support
      ''',
      dosage: '''
• Powder: 1-2 teaspoons with warm water before bed
• Capsule: 500-1000mg daily
• Best taken 30 minutes before dinner or before bed
• Start with small dose and adjust
      ''',
      evidence: '''
Studies show Triphala has significant antioxidant activity. Research demonstrates its mild laxative effect and ability to support healthy bowel movements. Its anti-inflammatory properties are well-documented in multiple studies.
      ''',
      caution: '''
• May cause loose stools initially (detox effect)
• Avoid if pregnant or breastfeeding
• Can interact with blood pressure medications
• Don't take with other laxatives
• Those with chronic constipation should consult doctor
      ''',
      emoji: '🍃',
    ),

    // Brahmi
    HerbalRemedy(
      id: 'brahmi',
      name: 'Brahmi (Bacopa)',
      sanskritName: 'ब्राह्मी',
      botanicalName: 'Bacopa monnieri',
      primaryDosha: [DoshaType.vata, DoshaType.kapha],
      secondaryDosha: [DoshaType.pitta],
      description:
          'Known as "Brain Herb", Brahmi is a premier nootropic that enhances cognitive function, memory, and concentration. It is named after Brahma, the creator god of Hindu mythology.',
      uses: '''
• Enhances memory and recall
• Improves concentration and focus
• Reduces anxiety and stress
• Supports learning ability
• Neuroprotective properties
• May help with ADHD symptoms
• Supports mood balance
• Promotes restful sleep
      ''',
      dosage: '''
• Powder: 1-2 grams daily
• Capsule: 300-500mg extract daily
• Best taken in morning with breakfast
• Allow 4-6 weeks to see cognitive benefits
• Can be taken long-term with breaks
      ''',
      evidence: '''
Multiple clinical trials show Brahmi improves memory and cognitive function. A 2016 meta-analysis confirmed its positive effects on cognitive performance. Studies show it may help with age-related cognitive decline.
      ''',
      caution: '''
• May cause nausea or stomach upset initially
• Avoid if pregnant or breastfeeding
• Can interact with seizure medications
• May cause sedation when combined with other herbs
• Start with lower dose to test tolerance
      ''',
      emoji: '🧠',
    ),

    // Turmeric
    HerbalRemedy(
      id: 'turmeric',
      name: 'Turmeric (Haridra)',
      sanskritName: 'हरिद्रा',
      botanicalName: 'Curcuma longa',
      primaryDosha: [DoshaType.pitta],
      secondaryDosha: [DoshaType.vata, DoshaType.kapha],
      description:
          'The golden spice of Ayurveda, turmeric contains curcumin which has powerful anti-inflammatory and antioxidant properties. It has been used for thousands of years for healing.',
      uses: '''
• Powerful anti-inflammatory
• Joint health and flexibility
• Supports skin health
• Liver detoxification
• Digestive support
• Heart health
• Mood regulation
• Wound healing (external use)
• Brain health
      ''',
      dosage: '''
• Cooking: 1/2 to 1 teaspoon daily
• Golden Milk: 1/2 tsp with warm milk
• Capsule: 500-1000mg standardized extract
• Best absorbed with black pepper (piperine) and fats
• Can be taken long-term
      ''',
      evidence: '''
Over 10,000 studies on curcumin. FDA approved its use. Proven anti-inflammatory effects comparable to NSAIDs but without side effects. Strong evidence for joint health and antioxidant benefits.
      ''',
      caution: '''
• High doses may cause stomach upset
• Can interact with blood thinners
• May lower blood sugar - diabetics monitor closely
• Avoid if having gallbladder issues
• Can stain skin and clothing
      ''',
      emoji: '🌟',
    ),

    // Additional herbs
    HerbalRemedy(
      id: 'ginger',
      name: 'Ginger (Adrak)',
      sanskritName: 'अद्रक',
      botanicalName: 'Zingiber officinale',
      primaryDosha: [DoshaType.vata, DoshaType.kapha],
      secondaryDosha: [DoshaType.pitta],
      description:
          'A warming spice that kindles digestive fire (Agni). Fresh ginger is more potent and commonly used in Ayurvedic cooking and medicine.',
      uses: '''
• Digestive aid - reduces nausea
• Anti-inflammatory
• Boost immunity
• Warm the body
• Reduce bloating
• Support circulation
• Clear respiratory congestion
• Reduce muscle soreness
      ''',
      dosage: '''
• Fresh: 1-2 grams of grated ginger
• Powder: 1/2 to 1 teaspoon
• Tea: Slice fresh ginger, boil 5 minutes
• Can be used in cooking daily
      ''',
      evidence: '''
FDA approved ginger for nausea. Studies show it effectively reduces motion sickness and morning sickness. Anti-inflammatory properties well-documented.
      ''',
      caution: '''
• May cause heartburn in some
• Can interact with blood thinners
• High doses may lower blood sugar
• Avoid in pregnancy (excess amounts)
      ''',
      emoji: '🫚',
    ),

    HerbalRemedy(
      id: 'amla',
      name: 'Amla (Indian Gooseberry)',
      sanskritName: 'आमला',
      botanicalName: 'Emblica officinalis',
      primaryDosha: [DoshaType.vata, DoshaType.pitta, DoshaType.kapha],
      secondaryDosha: [],
      description:
          'One of the most potent rejuvenating herbs in Ayurveda, Amla is rich in Vitamin C and antioxidants. It forms part of Triphala.',
      uses: '''
• Immune booster
• Antioxidant powerhouse
• Hair and skin health
• Digestive health
• Liver support
• Heart health
• Eye health
• Blood sugar support
      ''',
      dosage: '''
• Fresh: 1-2 raw amla daily
• Powder: 1-2 teaspoons
• Juice: 1-2 tablespoons
• Chyawanprash: 1-2 teaspoons
      ''',
      evidence: '''
Contains 20-30 times more Vitamin C than orange. Studies show strong antioxidant and anti-aging properties. Supports immune function and collagen production.
      ''',
      caution: '''
• May cause loose stools in excess
• Can lower blood sugar
• Very sour - may affect teeth enamel
      ''',
      emoji: '🫐',
    ),
  ];

  /// Get remedy by ID
  static HerbalRemedy? getById(String id) {
    try {
      return remedies.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Get remedies by dosha
  static List<HerbalRemedy> getForDosha(DoshaType doshaType) {
    return remedies.where((r) => r.primaryDosha.contains(doshaType)).toList();
  }
}
