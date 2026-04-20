import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/ayurveda/data/ayurveda_data.dart';

class AyurvedaLogic {
  static String getVedicSeason() {
    final month = DateTime.now().month;
    // Strict Indian Vedic Season (Ritu) mapping
    if (month == 3 || month == 4) return 'Vasanta (Spring)';
    if (month == 5 || month == 6) return 'Grishma (Summer)';
    if (month == 7 || month == 8) return 'Varsha (Monsoon)';
    if (month == 9 || month == 10) return 'Sharad (Autumn)';
    if (month == 11 || month == 12) return 'Hemanta (Late Autumn)';
    return 'Shishira (Winter)'; // Jan-Feb
  }

  static Map<String, dynamic> getCurrentSeasonData() {
    final seasonName = getVedicSeason();
    return AyurvedaData.ritucharya.firstWhere(
      (s) => s['season'] == seasonName,
      orElse: () => AyurvedaData.ritucharya.first,
    );
  }
}

final currentVedicSeasonProvider = Provider<String>((ref) {
  return AyurvedaLogic.getVedicSeason();
});

final currentSeasonDataProvider = Provider<Map<String, dynamic>>((ref) {
  return AyurvedaLogic.getCurrentSeasonData();
});
