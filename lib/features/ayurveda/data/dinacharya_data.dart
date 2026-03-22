// lib/features/ayurveda/data/dinacharya_data.dart
// Daily rituals (Dinacharya) based on dosha type

import 'package:fitkarma/features/ayurveda/data/ayurveda_models.dart';

/// Dinacharya tasks library
class DinacharyaData {
  static const List<DinacharyaTask> allTasks = [
    // Morning rituals
    DinacharyaTask(
      id: 'wake_early',
      name: 'Wake with the sun',
      description: 'Wake up early, ideally before 6 AM during Brahma Muhurta',
      time: '5:30 - 6:00 AM',
      recommendedFor: [DoshaType.vata, DoshaType.pitta, DoshaType.kapha],
      benefit:
          'Aligns with natural circadian rhythms and promotes mental clarity',
    ),
    DinacharyaTask(
      id: 'oil_massage',
      name: 'Abhyanga (Oil Massage)',
      description: 'Self-massage with warm sesame oil for 5-10 minutes',
      time: 'Before shower',
      recommendedFor: [DoshaType.vata, DoshaType.kapha],
      avoidFor: [DoshaType.pitta],
      benefit: 'Nourishes skin, calms nervous system, improves circulation',
    ),
    DinacharyaTask(
      id: 'tongue_scraping',
      name: 'Tongue Scraping',
      description:
          'Use copper tongue scraper to remove ama (toxins) from tongue',
      time: 'After brushing',
      recommendedFor: [DoshaType.vata, DoshaType.pitta, DoshaType.kapha],
      benefit: 'Removes bacteria, improves taste, signals digestive health',
    ),
    DinacharyaTask(
      id: 'oil_pulling',
      name: 'Oil Pulling',
      description: 'Swish 1 tbsp sesame or coconut oil for 5-10 minutes',
      time: 'Before breakfast',
      recommendedFor: [DoshaType.vata, DoshaType.kapha],
      avoidFor: [DoshaType.pitta],
      benefit: 'Detoxifies mouth, strengthens gums, improves oral health',
    ),
    DinacharyaTask(
      id: 'nasal_oil',
      name: 'Nasya (Nasal Oil)',
      description: 'Apply 2-3 drops of nasal oil to each nostril',
      time: 'Morning',
      recommendedFor: [DoshaType.vata],
      benefit:
          'Clears sinuses, improves mental clarity, lubricates nasal passages',
    ),

    // Exercise
    DinacharyaTask(
      id: 'yoga_morning',
      name: 'Morning Yoga',
      description:
          'Practice 20-30 minutes of yoga, stretching, or gentle movement',
      time: '6:00 - 7:00 AM',
      recommendedFor: [DoshaType.vata, DoshaType.pitta, DoshaType.kapha],
      benefit: 'Increases flexibility, reduces stiffness, improves circulation',
    ),
    DinacharyaTask(
      id: 'walking',
      name: 'Morning Walk',
      description: 'Walk outdoors for 20-30 minutes, preferably in nature',
      time: '6:30 - 7:00 AM',
      recommendedFor: [DoshaType.vata, DoshaType.kapha],
      avoidFor: [DoshaType.pitta],
      benefit: 'Boosts energy, improves digestion, connects with nature',
    ),
    DinacharyaTask(
      id: 'sunrise_meditation',
      name: 'Sunrise Meditation',
      description: 'Meditate during sunrise for 10-15 minutes',
      time: '6:00 - 6:30 AM',
      recommendedFor: [DoshaType.vata, DoshaType.pitta, DoshaType.kapha],
      benefit: 'Calms mind, sets intention for day, balances doshas',
    ),

    // Meals
    DinacharyaTask(
      id: 'breakfast_main',
      name: 'Eat a substantial breakfast',
      description: 'Have a warm, cooked breakfast within 2 hours of waking',
      time: '7:30 - 8:30 AM',
      recommendedFor: [DoshaType.vata, DoshaType.kapha],
      benefit:
          'Stabilizes blood sugar, provides energy, prevents overeating later',
    ),
    DinacharyaTask(
      id: 'lunch_main',
      name: 'Eat your largest meal at lunch',
      description:
          'Have the largest meal between 12-1 PM when digestion is strongest',
      time: '12:00 - 1:00 PM',
      recommendedFor: [DoshaType.vata, DoshaType.pitta, DoshaType.kapha],
      benefit: 'Optimizes digestive fire (Agni), provides sustained energy',
    ),
    DinacharyaTask(
      id: 'dinner_light',
      name: 'Eat a light dinner',
      description: 'Have a light, easily digestible meal before 7 PM',
      time: '6:30 - 7:00 PM',
      recommendedFor: [DoshaType.vata, DoshaType.pitta, DoshaType.kapha],
      benefit: 'Allows proper digestion before sleep, prevents accumulation',
    ),

    // Evening
    DinacharyaTask(
      id: 'evening_walk',
      name: 'Evening walk',
      description: 'Take a gentle 15-20 minute walk after dinner',
      time: '7:30 PM',
      recommendedFor: [DoshaType.kapha],
      benefit: 'Aids digestion, prevents Kapha accumulation, promotes sleep',
    ),
    DinacharyaTask(
      id: 'meditation_evening',
      name: 'Evening Meditation',
      description: 'Meditate or practice deep breathing before bed',
      time: '9:00 - 9:30 PM',
      recommendedFor: [DoshaType.vata, DoshaType.pitta],
      benefit: 'Calms the mind, prepares for restful sleep, reduces stress',
    ),
    DinacharyaTask(
      id: 'screen_free',
      name: 'Screen-free time',
      description: 'Avoid screens 1 hour before bed',
      time: '9:00 PM onwards',
      recommendedFor: [DoshaType.vata, DoshaType.pitta],
      benefit:
          'Improves sleep quality, reduces eye strain, calms nervous system',
    ),

    // Sleep
    DinacharyaTask(
      id: 'sleep_early',
      name: 'Sleep by 10 PM',
      description:
          'Be in bed by 10 PM to align with Kapha time (promotes rest)',
      time: '10:00 PM',
      recommendedFor: [DoshaType.vata, DoshaType.kapha],
      benefit:
          'Supports natural repair cycles, improves immunity, balances hormones',
    ),
    DinacharyaTask(
      id: 'foot_massage',
      name: 'Foot Massage',
      description: 'Massage feet with warm oil before bed',
      time: 'Before sleep',
      recommendedFor: [DoshaType.vata],
      benefit: 'Grounds energy, promotes deep sleep, relieves tension',
    ),

    // Hydration
    DinacharyaTask(
      id: 'warm_water_morning',
      name: 'Warm water on waking',
      description: 'Drink 1-2 glasses of warm water with lemon upon waking',
      time: 'Upon waking',
      recommendedFor: [DoshaType.vata, DoshaType.kapha],
      benefit: 'Stimulates digestion, flushes toxins, hydrates after sleep',
    ),
    DinacharyaTask(
      id: 'herbal_tea',
      name: 'Herbal tea between meals',
      description: 'Drink ginger, cinnamon, or fennel tea between meals',
      time: 'Between meals',
      recommendedFor: [DoshaType.vata, DoshaType.kapha],
      benefit:
          'Supports digestion, reduces bloating, hydrates without caffeine',
    ),
  ];

  /// Get tasks filtered by dosha type and season
  static List<DinacharyaTask> getRecommendedTasks(
    DoshaType? doshaType,
    IndianSeason? season,
  ) {
    return allTasks.where((task) {
      // If dosha specified, check if it's recommended
      if (doshaType != null) {
        if (task.avoidFor.contains(doshaType)) {
          return false;
        }
        return true; // Show all tasks that aren't explicitly avoided
      }
      return true;
    }).toList();
  }

  /// Get tasks specifically recommended for a dosha
  static List<DinacharyaTask> getTasksForDosha(DoshaType doshaType) {
    return allTasks.where((task) {
      return task.recommendedFor.contains(doshaType);
    }).toList();
  }
}
