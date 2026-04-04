import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../onboarding/presentation/onboarding_controller.dart';

part 'ayurveda_engine.g.dart';

class Ritual {
  final String id;
  final String nameEn;
  final String nameHi;
  final String time;
  final String description;
  final bool isSeasonal;

  Ritual({
    required this.id,
    required this.nameEn,
    required this.nameHi,
    required this.time,
    required this.description,
    this.isSeasonal = false,
  });
}

enum AyurvedaSeason {
  shishira('Late Winter'),
  vasanta('Spring'),
  grishma('Summer'),
  varsha('Monsoon'),
  sharad('Autumn'),
  hemanta('Early Winter');

  final String name;
  const AyurvedaSeason(this.name);
}

@riverpod
class AyurvedaEngine extends _$AyurvedaEngine {
  @override
  void build() {}

  /// Returns the user's dominant dosha from their onboarding state
  String? getUserDominantDosha() {
    final onboarding = ref.read(onboardingControllerProvider);
    if (onboarding.doshaScores.isEmpty) return null;
    return calculateDominantDosha(onboarding.doshaScores);
  }

  /// Calculates the dominant Dosha based on a score map: {'vata': X, 'pitta': Y, 'kapha': Z}
  String calculateDominantDosha(Map<String, int> scores) {
    if (scores.isEmpty) return 'Vata'; // Default
    final entries = scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries.first.key.capitalize();
  }

  /// Returns the current Ayurveda season based on the month (India-centric)
  AyurvedaSeason getCurrentSeason() {
    final month = DateTime.now().month;
    final day = DateTime.now().day;

    if ((month == 1 && day >= 15) || month == 2 || (month == 3 && day < 15)) {
      return AyurvedaSeason.shishira;
    } else if ((month == 3 && day >= 15) || month == 4 || (month == 5 && day < 15)) {
      return AyurvedaSeason.vasanta;
    } else if ((month == 5 && day >= 15) || month == 6 || (month == 7 && day < 15)) {
      return AyurvedaSeason.grishma;
    } else if ((month == 7 && day >= 15) || month == 8 || (month == 9 && day < 15)) {
      return AyurvedaSeason.varsha;
    } else if ((month == 9 && day >= 15) || month == 10 || (month == 11 && day < 15)) {
      return AyurvedaSeason.sharad;
    } else {
      return AyurvedaSeason.hemanta;
    }
  }

  /// Returns a list of daily rituals (Dinacharya + Ritucharya) based on Dosha and Season
  List<Ritual> getRituals() {
    final dosha = getUserDominantDosha() ?? 'Vata';
    final season = getCurrentSeason();
    
    final rituals = [
      Ritual(
        id: 'wake_up',
        nameEn: "Wake up early (Brahma Muhurta)",
        nameHi: "ब्रह्म मुहूर्त में जागें",
        time: "5:30 AM",
        description: "Waking up before sunrise synchronizes your biological clock.",
      ),
      Ritual(
        id: 'tongue_scrape',
        nameEn: "Scrape Tongue (Jihwa Nirlekhana)",
        nameHi: "जिह्वा निर्लेखन",
        time: "6:00 AM",
        description: "Removes morning toxins (Ama) and stimulates digestion.",
      ),
    ];

    // Dosha-specific rituals
    if (dosha.toLowerCase().contains('vata')) {
      rituals.add(Ritual(
        id: 'abhyanga',
        nameEn: "Warm Oil Massage (Abhyanga)",
        nameHi: "अभ्यंग (मालिश)",
        time: "6:30 AM",
        description: "Use warm sesame oil to ground Vata's cold and airy nature.",
      ));
    } else if (dosha.toLowerCase().contains('pitta')) {
      rituals.add(Ritual(
        id: 'pranayama',
        nameEn: "Cooling Breath (Sheetali)",
        nameHi: "शितली प्राणायाम",
        time: "7:00 AM",
        description: "Breathing technique to reduce internal heat (Pitta).",
      ));
    } else if (dosha.toLowerCase().contains('kapha')) {
      rituals.add(Ritual(
        id: 'vyayama',
        nameEn: "Vigorous Exercise (Vyayama)",
        nameHi: "व्यायाम",
        time: "7:30 AM",
        description: "Intense movement to boost sluggish Kapha metabolism.",
      ));
    }

    // Seasonal rituals (Ritucharya)
    switch (season) {
      case AyurvedaSeason.grishma: // Summer
        rituals.add(Ritual(
          id: 'hydration',
          nameEn: "Hydrate with Coconut Water",
          nameHi: "नारियल पानी से हाइड्रेट करें",
          time: "11:00 AM",
          description: "Crucial for cooling Pitta during the intense Indian summer.",
          isSeasonal: true,
        ));
        break;
      case AyurvedaSeason.varsha: // Monsoon
        rituals.add(Ritual(
          id: 'digestive_tea',
          nameEn: "Ginger & Honey Water",
          nameHi: "अदरक और शहद का पानी",
          time: "8:00 AM",
          description: "Keeps digestive fire (Agni) stable during humid monsoon.",
          isSeasonal: true,
        ));
        break;
      case AyurvedaSeason.hemanta: // Winter
        rituals.add(Ritual(
          id: 'sun_bath',
          nameEn: "Sun Bath (Atapa Sevana)",
          nameHi: "धूप सेंकना",
          time: "9:00 AM",
          description: "Natural Vitamin D and warmth for winter wellness.",
          isSeasonal: true,
        ));
        break;
      default:
        break;
    }

    return rituals;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
