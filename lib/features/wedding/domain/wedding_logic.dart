enum WeddingRole { bride, groom, guest, relative }
enum WeddingPrimaryGoal { lookBest, highEnergy, stressManagement, weightMaintenance }

class WeddingPhase {
  final String titleEn;
  final String titleHi;
  final String descriptionEn;
  final String descriptionHi;
  final Duration remainder;

  WeddingPhase({
    required this.titleEn,
    required this.titleHi,
    required this.descriptionEn,
    required this.descriptionHi,
    required this.remainder,
  });
}

class WeddingEvent {
  final String nameEn;
  final String nameHi;
  final DateTime date;
  final bool isHighIntensity; // High activity level (dancing, standing)

  WeddingEvent({
    required this.nameEn,
    required this.nameHi,
    required this.date,
    this.isHighIntensity = false,
  });
}

class WeddingLogic {
  static List<WeddingPhase> getTimeline(DateTime weddingDate, WeddingRole role) {
    final now = DateTime.now();
    final remainingDays = weddingDate.difference(now).inDays;

    List<WeddingPhase> phases = [];

    if (remainingDays > 90) {
      phases.add(WeddingPhase(
        titleEn: 'Long-term Preparation',
        titleHi: 'दीर्घकालिक तैयारी',
        descriptionEn: 'Focus on consistent habits. Build a base for glowing skin and high energy.',
        descriptionHi: 'नियमित आदतों पर ध्यान दें। चमकती त्वचा और उच्च ऊर्जा के लिए आधार बनाएं।',
        remainder: const Duration(days: 90),
      ));
    }

    if (remainingDays > 30) {
      phases.add(WeddingPhase(
        titleEn: '30-Day Countdown',
        titleHi: '30-दिवसीय उलटी गिनती',
        descriptionEn: 'Intensify hydration and sleep. Avoid new products or drastic diet changes.',
        descriptionHi: 'हाइड्रेशन और नींद बढ़ाएं। नए उत्पादों या अचानक आहार परिवर्तन से बचें।',
        remainder: const Duration(days: 30),
      ));
    }

    if (remainingDays <= 14) {
      phases.add(WeddingPhase(
        titleEn: 'Final Sprint',
        titleHi: 'अंतिम चरण',
        descriptionEn: 'Prioritize de-stressing. Light workouts and high nutrient intake.',
        descriptionHi: 'तनाव कम करने को प्राथमिकता दें। हल्का व्यायाम और अच्छा पोषण लें।',
        remainder: const Duration(days: 14),
      ));
    }

    return phases;
  }

  static String getRoleBasedAdvice(WeddingRole role, WeddingPrimaryGoal goal) {
    switch (role) {
      case WeddingRole.bride:
      case WeddingRole.groom:
        if (goal == WeddingPrimaryGoal.lookBest) {
          return 'Focus on antioxidants: Amla, berries, and green tea for a wedding glow.';
        }
        return 'De-stress with 10 mins of Pranayama daily to stay calm during ceremonies.';
      case WeddingRole.guest:
      case WeddingRole.relative:
        return 'Focus on energy: Balance heavy feast meals with light, fiber-rich breakfasts.';
    }
  }
}
