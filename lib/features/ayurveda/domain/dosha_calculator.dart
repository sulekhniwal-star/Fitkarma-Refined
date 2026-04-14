enum Dosha { vata, pitta, kapha }

class DoshaScore {
  final int vata;
  final int pitta;
  final int kapha;

  DoshaScore({required this.vata, required this.pitta, required this.kapha});

  Map<Dosha, double> get percentages {
    final total = vata + pitta + kapha;
    if (total == 0) return {Dosha.vata: 0, Dosha.pitta: 0, Dosha.kapha: 0};
    return {
      Dosha.vata: (vata / total) * 100,
      Dosha.pitta: (pitta / total) * 100,
      Dosha.kapha: (kapha / total) * 100,
    };
  }

  Dosha get dominant {
    final p = percentages;
    if (p[Dosha.vata]! >= p[Dosha.pitta]! && p[Dosha.vata]! >= p[Dosha.kapha]!) return Dosha.vata;
    if (p[Dosha.pitta]! >= p[Dosha.vata]! && p[Dosha.pitta]! >= p[Dosha.kapha]!) return Dosha.pitta;
    return Dosha.kapha;
  }
}

class DoshaCalculator {
  /// Calculates dosha scores from 12 answers.
  /// Each answer index is a question, value 0-2 (mapping to V, P, K).
  static DoshaScore calculate(List<int> answers) {
    int v = 0, p = 0, k = 0;
    
    // Simplified mapping for demo purposes
    for (int i = 0; i < answers.length; i++) {
        final val = answers[i];
        if (i % 3 == 0) {
          v += val;
        } else if (i % 3 == 1) p += val;
        else k += val;
    }
    
    return DoshaScore(vata: v, pitta: p, kapha: k);
  }
}
