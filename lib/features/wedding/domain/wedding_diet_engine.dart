import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';
import '../../food/domain/tdee_calculator.dart';
import '../../auth/data/auth_repository.dart';

part 'wedding_diet_engine.g.dart';

enum WeddingPhaseType { preWedding, weddingWeek, postWedding, none }

class WeddingDietPlan {
  final WeddingPhaseType phase;
  final int daysToWedding;
  final String adviceEn;
  final String adviceHi;
  final int calorieOffset; // changes to the base goal
  final String? eventName;

  WeddingDietPlan({
    required this.phase,
    required this.daysToWedding,
    required this.adviceEn,
    required this.adviceHi,
    this.calorieOffset = 0,
    this.eventName,
  });
}

@riverpod
class WeddingDietProvider extends _$WeddingDietProvider {
  @override
  Future<WeddingDietPlan?> build() async {
    final db = ref.watch(databaseProvider);
    final userAsync = ref.watch(currentUserProvider);
    final user = userAsync.value;
    if (user == null) return null;

    final weddingPlan = await db.weddingEventsDao.getActiveWeddingPlan(user.$id);
    if (weddingPlan == null) return null;

    final now = DateTime.now();
    final weddingStart = weddingPlan.startDate;
    final weddingEnd = weddingPlan.endDate;

    if (now.isBefore(weddingStart)) {
      final daysToWedding = weddingStart.difference(now).inDays;
      // Pre-wedding phase
      return WeddingDietPlan(
        phase: WeddingPhaseType.preWedding,
        daysToWedding: daysToWedding,
        adviceEn: _getPreWeddingAdvice(weddingPlan, daysToWedding, 'en'),
        adviceHi: _getPreWeddingAdvice(weddingPlan, daysToWedding, 'hi'),
        calorieOffset: weddingPlan.primaryGoal == 'look_best' ? -200 : -100,
      );
    } else if (now.isAfter(weddingEnd)) {
      // Post-wedding phase
      return WeddingDietPlan(
        phase: WeddingPhaseType.postWedding,
        daysToWedding: 0,
        adviceEn: 'Congratulations! Focus on recovery and hydration this week.',
        adviceHi: 'बधाई हो! इस सप्ताह रिकवरी और हाइड्रेशन पर ध्यान दें।',
        calorieOffset: 0,
      );
    } else {
      // Wedding week phase
      return WeddingDietPlan(
        phase: WeddingPhaseType.weddingWeek,
        daysToWedding: 0,
        adviceEn: 'Prioritize snacks between events. Stay hydrated during ceremonies!',
        adviceHi: 'आयोजनों के बीच स्नैक्स को प्राथमिकता दें। रस्मों के दौरान हाइड्रेटेड रहें!',
        calorieOffset: 250, // Feast buffer
      );
    }
  }

  String _getPreWeddingAdvice(WeddingEventEntry plan, int days, String lang) {
    final role = plan.role;
    final goal = plan.primaryGoal;

    if (days > 30) {
      if (role == 'bride' || role == 'groom') {
        return lang == 'en' 
            ? 'Long-term glow: Focus on sleep and antioxidants.' 
            : 'दीर्घकालिक चमक: नींद और एंटीऑक्सीडेंट पर ध्यान दें।';
      }
      return lang == 'en' ? 'Build a base for the busy weeks ahead.' : 'आने वाले व्यस्त हफ्तों के लिए आधार बनाएं।';
    } else if (days > 7) {
      if (goal == 'look_best') {
        return lang == 'en' ? 'Limit high-sodium foods to prevent bloating.' : 'सूजन (bloating) को रोकने के लिए उच्च सोडियम वाले खाद्य पदार्थों को सीमित करें।';
      }
      return lang == 'en' ? 'Keep stress low, stay consistent.' : 'तनाव कम रखें, निरंतर बने रहें।';
    } else {
      return lang == 'en' ? 'Final countdown! Prioritize easy-to-digest meals.' : 'अंतिम गिनती! पचने में आसान भोजन को प्राथमिकता दें।';
    }
  }
}
