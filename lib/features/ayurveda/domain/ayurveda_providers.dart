import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart';
import '../../auth/domain/auth_providers.dart';
import '../../../core/di/providers.dart';
import '../domain/dosha_calculator.dart';
import '../domain/prakriti_quiz.dart';
import '../data/ayurveda_data.dart';
import '../../../core/storage/app_database.dart';

part 'ayurveda_providers.g.dart';

@riverpod
class AyurvedaNotifier extends _$AyurvedaNotifier {
  @override
  Future<DoshaScore?> build() async {
    final authState = ref.watch(authStateProvider);
    final userId = authState.value?.id;
    
    if (userId == null) return null;

    final user = await ref.watch(userDaoProvider).getUser(userId);
    if (user == null || user.dominantDosha == null) return null;

    return DoshaScore(
      vata: user.doshaVata ?? 0,
      pitta: user.doshaPitta ?? 0,
      kapha: user.doshaKapha ?? 0,
    );
  }

  Future<void> saveQuizResult(DoshaScore score) async {
    final authState = ref.read(authStateProvider);
    final userId = authState.value?.id;
    if (userId == null) return;

    final db = ref.read(driftDbProvider);

    await (db.update(db.users)..where((t) => t.id.equals(userId))).write(
      UsersCompanion(
        doshaVata: Value(score.vata),
        doshaPitta: Value(score.pitta),
        doshaKapha: Value(score.kapha),
        dominantDosha: Value(score.dominant.name),
      ),
    );
    
    ref.invalidateSelf();
  }

  Future<void> resetAssessment() async {
    final authState = ref.read(authStateProvider);
    final userId = authState.value?.id;
    if (userId == null) return;

    final db = ref.read(driftDbProvider);

    await (db.update(db.users)..where((t) => t.id.equals(userId))).write(
      const UsersCompanion(
        doshaVata: Value(null),
        doshaPitta: Value(null),
        doshaKapha: Value(null),
        dominantDosha: Value(null),
      ),
    );
    
    ref.invalidateSelf();
  }
}

@riverpod
class RitualHistory extends _$RitualHistory {
  @override
  Future<List<String>> build(DateTime date) async {
    final authState = ref.watch(authStateProvider);
    final userId = authState.value?.id;
    if (userId == null) return [];

    final completions = await ref.watch(ayurvedaDaoProvider).getCompletionsForDate(userId, date);
    return completions.map((c) => c.ritualKey).toList();
  }

  Future<void> toggleRitual(Map<String, dynamic> ritual) async {
    final authState = ref.read(authStateProvider);
    final userId = authState.value?.id;
    if (userId == null) return;

    final ritualKey = ritual['key'] as String;
    final karmaValue = ritual['karma'] as int;
    
    final currentStatus = state.value ?? [];
    if (currentStatus.contains(ritualKey)) return; // Already done

    // 1. Record in DB
    await ref.read(ayurvedaDaoProvider).recordCompletion(userId, ritualKey, karmaValue);

    // 2. Award Karma
    await ref.read(userDaoProvider).addKarma(
      userId, 
      karmaValue, 
      'Ayurvedic Ritual', 
      'Completed ${ritual['label']}'
    );

    // 3. Refresh state
    ref.invalidateSelf();
  }
}

@riverpod
class QuizProgress extends _$QuizProgress {
  @override
  Map<int, int> build() => {};

  void selectOption(int questionIndex, int optionIndex) {
    state = {...state, questionIndex: optionIndex};
  }

  DoshaScore calculateResult() {
    int v = 0, p = 0, k = 0;
    
    state.forEach((qIdx, oIdx) {
      final option = PrakritiQuizData.questions[qIdx].options[oIdx];
      v += option.vataValue;
      p += option.pittaValue;
      k += option.kaphaValue;
    });

    return DoshaScore(vata: v, pitta: p, kapha: k);
  }

  bool get isComplete => state.length == PrakritiQuizData.questions.length;
  
  void reset() => state = {};
}

