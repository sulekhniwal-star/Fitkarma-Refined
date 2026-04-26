enum Dosha { vata, pitta, kapha }

class DoshaScore {
  final int vata;
  final int pitta;
  final int kapha;

  DoshaScore({required this.vata, required this.pitta, required this.kapha});

  Map<Dosha, double> get percentages {
    final total = vata + pitta + kapha;
    if (total == 0) return {Dosha.vata: 33.3, Dosha.pitta: 33.3, Dosha.kapha: 33.4};
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
  /// Calculates dosha scores from a list of selected option points.
  /// Each selected option is a Map<String, int> like {'vata': 3, 'pitta': 0, 'kapha': 0}.
  static DoshaScore calculate(List<Map<String, int>> selections) {
    int v = 0, p = 0, k = 0;
    
    for (final selection in selections) {
      v += selection['vata'] ?? 0;
      p += selection['pitta'] ?? 0;
      k += selection['kapha'] ?? 0;
    }
    
    return DoshaScore(vata: v, pitta: p, kapha: k);
  }
}
