// lib/core/utils/ayur_utils.dart
import 'dart:convert';

class AyurUtils {
  /// Calculates the percentage of each dosha based on the raw scores.
  static Map<String, double> calculateDoshaPercentages(Map<String, int> scores) {
    final vata = scores['vata'] ?? 0;
    final pitta = scores['pitta'] ?? 0;
    final kapha = scores['kapha'] ?? 0;
    
    final total = vata + pitta + kapha;
    if (total == 0) return {'Vata': 0, 'Pitta': 0, 'Kapha': 0};
    
    return {
      'Vata': (vata / total) * 100,
      'Pitta': (pitta / total) * 100,
      'Kapha': (kapha / total) * 100,
    };
  }

  /// Extracts the dominant dosha(s).
  static String getDominantDosha(Map<String, double> percentages) {
    final sorted = percentages.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final dominant = sorted.first;
    
    // Check for dual-dosha (if the difference is less than 5%)
    if (sorted.length > 1 && (dominant.value - sorted[1].value) < 5) {
      return '${dominant.key}-${sorted[1].key}';
    }
    
    return dominant.key;
  }
  
  /// Encodes scores as JSON for storage.
  static String encodeScores(Map<String, int> scores) => json.encode(scores);
  
  /// Decodes scores from JSON.
  static Map<String, int> decodeScores(String jsonStr) {
    try {
      final decoded = json.decode(jsonStr) as Map<String, dynamic>;
      return decoded.map((key, value) => MapEntry(key, value as int));
    } catch (_) {
      return {};
    }
  }
}
