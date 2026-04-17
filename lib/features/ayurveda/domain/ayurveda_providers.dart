import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/di/providers.dart';
import '../domain/dosha_calculator.dart';
import '../domain/prakriti_quiz.dart';
import '../../../core/storage/app_database.dart';
import 'package:drift/drift.dart';

part 'ayurveda_providers.g.dart';

@riverpod
class AyurvedaNotifier extends _$AyurvedaNotifier {
  @override
  Future<DoshaScore?> build() async {
    final user = await ref.watch(userDaoProvider).getUser('current_user_id'); // Mocked user ID
    if (user == null || user.dominantDosha == null) return null;

    return DoshaScore(
      vata: user.doshaVata ?? 0,
      pitta: user.doshaPitta ?? 0,
      kapha: user.doshaKapha ?? 0,
    );
  }

  Future<void> saveQuizResult(DoshaScore score) async {
    final userDao = ref.read(userDaoProvider);
    final db = ref.read(driftDbProvider);

    await (db.update(db.users)..where((t) => t.id.equals('current_user_id'))).write(
      UsersCompanion(
        doshaVata: Value(score.vata),
        doshaPitta: Value(score.pitta),
        doshaKapha: Value(score.kapha),
        dominantDosha: Value(score.dominant.name),
      ),
    );
    
    // Refresh state
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
}
