import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../festival_calendar/domain/festival_diet_engine.dart';
import '../../wedding/domain/wedding_diet_engine.dart';

part 'diet_conflict_resolver.g.dart';

@riverpod
Future<ConflictInsight?> dietConflictInsight(Ref ref) async {
  final festivals = await ref.watch(festivalDietProviderProvider.future);
  final wedding = await ref.watch(weddingDietProviderProvider.future);

  if (festivals.isEmpty || wedding == null) return null;

  // We only care about fasting conflicts or extreme feast conflicts
  final activeFast = festivals.cast<FestivalDietConfig?>().firstWhere(
    (f) => f != null && f.isFasting, 
    orElse: () => null
  );
  
  if (activeFast != null && wedding.phase == WeddingPhaseType.weddingWeek) {
    return ConflictInsight(
      titleEn: "Tradition Conflict",
      titleHi: "परंपरा संघर्ष",
      messageEn: "Wedding events overlap with ${activeFast.nameEn} fast. Recommendation: Follow 'Phalahar' and stay hydrated to maintain energy for ceremonies.",
      messageHi: "शादी के कार्यक्रम ${activeFast.nameHi} उपवास के साथ ओवरलैप हो रहे हैं। सुझाव: 'फलाहार' का पालन करें और रस्मों के लिए ऊर्जा बनाए रखने के लिए हाइड्रेटेड रहें।",
      severity: 'medium',
    );
  }

  if (activeFast != null && wedding.phase == WeddingPhaseType.preWedding && wedding.daysToWedding < 7) {
    return ConflictInsight(
      titleEn: "Energy Management",
      titleHi: "ऊर्जा प्रबंधन",
      messageEn: "Pre-wedding stress + ${activeFast.nameEn} fast detected. Avoid 'Nirjala' (no water) to prevent final-week fatigue.",
      messageHi: "शादी से पहले का तनाव + ${activeFast.nameHi} उपवास। अंतिम सप्ताह की थकान से बचने के लिए 'निर्जला' उपवास से बचें।",
      severity: 'high',
    );
  }

  return null;
}

class ConflictInsight {
  final String titleEn;
  final String titleHi;
  final String messageEn;
  final String messageHi;
  final String severity; // low, medium, high

  ConflictInsight({
    required this.titleEn,
    required this.titleHi,
    required this.messageEn,
    required this.messageHi,
    required this.severity,
  });
}
