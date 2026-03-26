// lib/features/ayurveda/data/ayurveda_models.dart
// Models for Ayurveda feature - Dosha, Dinacharya, Ritucharya, Herbal Remedies

/// Dosha types in Ayurveda
enum DoshaType {
  vata,
  pitta,
  kapha;

  String get displayName {
    switch (this) {
      case DoshaType.vata:
        return 'Vata';
      case DoshaType.pitta:
        return 'Pitta';
      case DoshaType.kapha:
        return 'Kapha';
    }
  }

  String get sanskritName {
    switch (this) {
      case DoshaType.vata:
        return 'वात';
      case DoshaType.pitta:
        return 'पित्त';
      case DoshaType.kapha:
        return 'कफ';
    }
  }

  String get description {
    switch (this) {
      case DoshaType.vata:
        return 'Air & Space - Creative, energetic, quick-thinking. Governs movement, circulation, and nerve impulses.';
      case DoshaType.pitta:
        return 'Fire & Water - Intelligent, ambitious, focused. Governs digestion, metabolism, and body temperature.';
      case DoshaType.kapha:
        return 'Earth & Water - Calm, stable, nurturing. Governs structure, immunity, and lubrication.';
    }
  }

  String get qualities {
    switch (this) {
      case DoshaType.vata:
        return 'Dry, Light, Cold, Rough, Subtle';
      case DoshaType.pitta:
        return 'Hot, Sharp, Light, Liquid, Spreading';
      case DoshaType.kapha:
        return 'Heavy, Slow, Cold, Oily, Dense';
    }
  }

  String get emoji {
    switch (this) {
      case DoshaType.vata:
        return '🌬️';
      case DoshaType.pitta:
        return '🔥';
      case DoshaType.kapha:
        return '💧';
    }
  }
}

/// Dominant dosha result
enum DominantDosha {
  vataDominant,
  pittaDominant,
  kaphaDominant,
  vataPitta,
  vataKapha,
  pittaKapha,
  tridoshic;

  String get displayName {
    switch (this) {
      case DominantDosha.vataDominant:
        return 'Vata Dominant';
      case DominantDosha.pittaDominant:
        return 'Pitta Dominant';
      case DominantDosha.kaphaDominant:
        return 'Kapha Dominant';
      case DominantDosha.vataPitta:
        return 'Vata-Pitta';
      case DominantDosha.vataKapha:
        return 'Vata-Kapha';
      case DominantDosha.pittaKapha:
        return 'Pitta-Kapha';
      case DominantDosha.tridoshic:
        return 'Tridoshic (Balanced)';
    }
  }

  String get description {
    switch (this) {
      case DominantDosha.vataDominant:
        return 'You have a strong Vata constitution. Focus on grounding, warming, and calming practices.';
      case DominantDosha.pittaDominant:
        return 'You have a strong Pitta constitution. Focus on cooling, moderating, and soothing practices.';
      case DominantDosha.kaphaDominant:
        return 'You have a strong Kapha constitution. Focus on stimulating, warming, and lightening practices.';
      case DominantDosha.vataPitta:
        return 'You have a Vata-Pitta constitution. Balance between grounding and cooling practices.';
      case DominantDosha.vataKapha:
        return 'You have a Vata-Kapha constitution. Focus on warming and stimulating practices.';
      case DominantDosha.pittaKapha:
        return 'You have a Pitta-Kapha constitution. Balance between cooling and energizing practices.';
      case DominantDosha.tridoshic:
        return 'You have a balanced tridoshic constitution. Maintain balance through moderate practices.';
    }
  }
}

/// Indian seasons (Ritucharya)
enum IndianSeason {
  spring, // Vasanta (March-April)
  summer, // Grishma (May-June)
  monsoon, // Varsha (July-August)
  autumn, // Sharad (September-October)
  winter, // Hemanta (November-December)
  lateWinter; // Shishira (January-February)

  String get displayName {
    switch (this) {
      case IndianSeason.spring:
        return 'Spring';
      case IndianSeason.summer:
        return 'Summer';
      case IndianSeason.monsoon:
        return 'Monsoon';
      case IndianSeason.autumn:
        return 'Autumn';
      case IndianSeason.winter:
        return 'Winter';
      case IndianSeason.lateWinter:
        return 'Late Winter';
    }
  }

  String get sanskritName {
    switch (this) {
      case IndianSeason.spring:
        return 'वसंत';
      case IndianSeason.summer:
        return 'ग्रीष्म';
      case IndianSeason.monsoon:
        return 'वर्षा';
      case IndianSeason.autumn:
        return 'शरद';
      case IndianSeason.winter:
        return 'हेमंत';
      case IndianSeason.lateWinter:
        return 'शिशिर';
    }
  }

  String get months {
    switch (this) {
      case IndianSeason.spring:
        return 'March - April';
      case IndianSeason.summer:
        return 'May - June';
      case IndianSeason.monsoon:
        return 'July - August';
      case IndianSeason.autumn:
        return 'September - October';
      case IndianSeason.winter:
        return 'November - December';
      case IndianSeason.lateWinter:
        return 'January - February';
    }
  }

  /// Get current season based on month
  static IndianSeason getCurrentSeason() {
    final month = DateTime.now().month;
    if (month >= 3 && month <= 4) return IndianSeason.spring;
    if (month >= 5 && month <= 6) return IndianSeason.summer;
    if (month >= 7 && month <= 8) return IndianSeason.monsoon;
    if (month >= 9 && month <= 10) return IndianSeason.autumn;
    if (month >= 11 && month <= 12) return IndianSeason.winter;
    return IndianSeason.lateWinter;
  }
}

/// Dosha quiz question
class DoshaQuestion {
  final int id;
  final String question;
  final List<DoshaAnswer> answers;

  const DoshaQuestion({
    required this.id,
    required this.question,
    required this.answers,
  });
}

/// Answer option for dosha quiz
class DoshaAnswer {
  final String text;
  final int vataScore;
  final int pittaScore;
  final int kaphaScore;

  const DoshaAnswer({
    required this.text,
    required this.vataScore,
    required this.pittaScore,
    required this.kaphaScore,
  });
}

/// Quiz result with dosha percentages
class DoshaResult {
  final int vataPercent;
  final int pittaPercent;
  final int kaphaPercent;
  final DominantDosha dominantDosha;
  final DateTime calculatedAt;

  const DoshaResult({
    required this.vataPercent,
    required this.pittaPercent,
    required this.kaphaPercent,
    required this.dominantDosha,
    required this.calculatedAt,
  });

  factory DoshaResult.fromScores(int vata, int pitta, int kapha) {
    final total = vata + pitta + kapha;
    if (total == 0) {
      return DoshaResult(
        vataPercent: 33,
        pittaPercent: 33,
        kaphaPercent: 34,
        dominantDosha: DominantDosha.tridoshic,
        calculatedAt: DateTime.now(),
      );
    }

    final vataPercent = ((vata / total) * 100).round();
    final pittaPercent = ((pitta / total) * 100).round();
    final kaphaPercent = 100 - vataPercent - pittaPercent;

    final dominant = _calculateDominantDosha(
      vataPercent,
      pittaPercent,
      kaphaPercent,
    );

    return DoshaResult(
      vataPercent: vataPercent,
      pittaPercent: pittaPercent,
      kaphaPercent: kaphaPercent,
      dominantDosha: dominant,
      calculatedAt: DateTime.now(),
    );
  }

  static DominantDosha _calculateDominantDosha(int v, int p, int k) {
    // Threshold for "dominant" classification
    const threshold = 40;
    const closeThreshold = 10;

    final maxVal = [v, p, k];
    final maxIndex = maxVal.indexOf(maxVal.reduce((a, b) => a > b ? a : b));
    final sorted = [v, p, k]..sort((a, b) => b - a);
    final difference = sorted[0] - sorted[1];

    // Single dominant (40%+ and significantly higher)
    if (v >= threshold && difference > closeThreshold && v > p && v > k) {
      return DominantDosha.vataDominant;
    }
    if (p >= threshold && difference > closeThreshold && p > v && p > k) {
      return DominantDosha.pittaDominant;
    }
    if (k >= threshold && difference > closeThreshold && k > v && k > p) {
      return DominantDosha.kaphaDominant;
    }

    // Two doshas close together (within 10 points) - dual dosha
    if (v >= 35 && v - p <= closeThreshold && v > k) {
      return DominantDosha.vataPitta;
    }
    if (v >= 35 && v - k <= closeThreshold && v > p) {
      return DominantDosha.vataKapha;
    }
    if (p >= 35 && p - k <= closeThreshold && p > v) {
      return DominantDosha.pittaKapha;
    }
    if (p >= 35 && p - v <= closeThreshold && p > k) {
      return DominantDosha.vataPitta;
    }
    if (k >= 35 && k - v <= closeThreshold && k > p) {
      return DominantDosha.vataKapha;
    }
    if (k >= 35 && k - p <= closeThreshold && k > v) {
      return DominantDosha.pittaKapha;
    }

    // All three relatively equal
    return DominantDosha.tridoshic;
  }

  Map<String, dynamic> toJson() => {
    'vataPercent': vataPercent,
    'pittaPercent': pittaPercent,
    'kaphaPercent': kaphaPercent,
    'dominantDosha': dominantDosha.name,
    'calculatedAt': calculatedAt.toIso8601String(),
  };

  factory DoshaResult.fromJson(Map<String, dynamic> json) => DoshaResult(
    vataPercent: json['vataPercent'] as int,
    pittaPercent: json['pittaPercent'] as int,
    kaphaPercent: json['kaphaPercent'] as int,
    dominantDosha: DominantDosha.values.firstWhere(
      (d) => d.name == json['dominantDosha'],
      orElse: () => DominantDosha.tridoshic,
    ),
    calculatedAt: DateTime.parse(json['calculatedAt'] as String),
  );
}

/// Dinacharya task (daily ritual)
class DinacharyaTask {
  final String id;
  final String name;
  final String description;
  final String? time; // e.g., "6:00 AM", "Before bed"
  final List<DoshaType> recommendedFor;
  final List<DoshaType> avoidFor;
  final String? benefit;
  final bool isCompleted;
  final DateTime? completedAt;

  const DinacharyaTask({
    required this.id,
    required this.name,
    required this.description,
    this.time,
    required this.recommendedFor,
    this.avoidFor = const [],
    this.benefit,
    this.isCompleted = false,
    this.completedAt,
  });

  DinacharyaTask copyWith({
    String? id,
    String? name,
    String? description,
    String? time,
    List<DoshaType>? recommendedFor,
    List<DoshaType>? avoidFor,
    String? benefit,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return DinacharyaTask(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      time: time ?? this.time,
      recommendedFor: recommendedFor ?? this.recommendedFor,
      avoidFor: avoidFor ?? this.avoidFor,
      benefit: benefit ?? this.benefit,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}

/// Seasonal recommendation (Ritucharya)
class SeasonalRecommendation {
  final IndianSeason season;
  final List<String> diet;
  final List<String> lifestyle;
  final List<String> exercises;
  final List<String> avoid;
  final String? specialNote;

  const SeasonalRecommendation({
    required this.season,
    required this.diet,
    required this.lifestyle,
    required this.exercises,
    required this.avoid,
    this.specialNote,
  });
}

/// Herbal remedy
class HerbalRemedy {
  final String id;
  final String name;
  final String sanskritName;
  final String botanicalName;
  final List<DoshaType> primaryDosha;
  final List<DoshaType> secondaryDosha;
  final String description;
  final String uses;
  final String dosage;
  final String? evidence;
  final String? caution;
  final String emoji;

  const HerbalRemedy({
    required this.id,
    required this.name,
    required this.sanskritName,
    required this.botanicalName,
    required this.primaryDosha,
    this.secondaryDosha = const [],
    required this.description,
    required this.uses,
    required this.dosage,
    this.evidence,
    this.caution,
    required this.emoji,
  });
}

/// User's Ayurveda profile
class AyurvedaProfile {
  final String odUserId;
  final DoshaResult? doshaResult;
  final List<String> completedDailyRituals; // List of task IDs completed today
  final DateTime? lastQuizDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AyurvedaProfile({
    required this.odUserId,
    this.doshaResult,
    this.completedDailyRituals = const [],
    this.lastQuizDate,
    required this.createdAt,
    required this.updatedAt,
  });

  AyurvedaProfile copyWith({
    String? odUserId,
    DoshaResult? doshaResult,
    List<String>? completedDailyRituals,
    DateTime? lastQuizDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AyurvedaProfile(
      odUserId: odUserId ?? this.odUserId,
      doshaResult: doshaResult ?? this.doshaResult,
      completedDailyRituals:
          completedDailyRituals ?? this.completedDailyRituals,
      lastQuizDate: lastQuizDate ?? this.lastQuizDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'odUserId': odUserId,
    'doshaResult': doshaResult?.toJson(),
    'completedDailyRituals': completedDailyRituals,
    'lastQuizDate': lastQuizDate?.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory AyurvedaProfile.fromJson(Map<String, dynamic> json) =>
      AyurvedaProfile(
        odUserId: json['odUserId'] as String,
        doshaResult: json['doshaResult'] != null
            ? DoshaResult.fromJson(json['doshaResult'] as Map<String, dynamic>)
            : null,
        completedDailyRituals:
            (json['completedDailyRituals'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        lastQuizDate: json['lastQuizDate'] != null
            ? DateTime.parse(json['lastQuizDate'] as String)
            : null,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );
}
