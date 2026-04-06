import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../core/storage/app_database.dart';
import 'package:drift/drift.dart';

enum CalendarSystem { hindu, hijri, sikh, gregorian }
enum DietaryType { fasting, feast, sattvic, normal }

class FestivalDate {
  final String key;
  final String festivalKey;
  final String nameEn;
  final String nameHi;
  final String? nameLocal;
  final int year;
  final DateTime startDate;
  final DateTime endDate;
  final CalendarSystem system;
  final DietaryType dietType;
  final bool isFasting;
  final String? fastingType;
  final String? allowedFoods;
  final String? forbiddenFoods;
  final String? insight;

  FestivalDate({
    required this.key,
    required this.festivalKey,
    required this.nameEn,
    required this.nameHi,
    this.nameLocal,
    required this.year,
    required this.startDate,
    required this.endDate,
    required this.system,
    required this.dietType,
    this.isFasting = false,
    this.fastingType,
    this.allowedFoods,
    this.forbiddenFoods,
    this.insight,
  });

  factory FestivalDate.fromJson(Map<String, dynamic> json) {
    return FestivalDate(
      key: json['key'] ?? '',
      festivalKey: json['festivalKey'] ?? '',
      nameEn: json['nameEn'] ?? '',
      nameHi: json['nameHi'] ?? '',
      nameLocal: json['nameLocal'],
      year: json['year'] ?? 2024,
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      system: CalendarSystem.values.firstWhere((e) => e.name == json['calendarSystem'], orElse: () => CalendarSystem.gregorian),
      dietType: DietaryType.values.firstWhere((e) => e.name == json['dietPlanType'], orElse: () => DietaryType.normal),
      isFasting: json['isFastingDay'] ?? false,
      fastingType: json['fastingType'],
      allowedFoods: json['allowedFoods'],
      forbiddenFoods: json['forbiddenFoods'],
      insight: json['insightMessage'],
    );
  }

  FestivalCalendarCompanion toCompanion() {
    return FestivalCalendarCompanion.insert(
      id: key,
      festivalKey: festivalKey,
      nameEn: nameEn,
      nameHi: nameHi,
      nameLocal: Value(nameLocal),
      year: year,
      startDate: startDate,
      endDate: endDate,
      calendarSystem: system.name,
      dietPlanType: dietType.name,
      isFastingDay: Value(isFasting),
      fastingType: Value(fastingType),
      allowedFoods: Value(allowedFoods),
      forbiddenFoods: Value(forbiddenFoods),
      insightMessage: Value(insight),
      computedAt: DateTime.now(),
    );
  }
}

class FestivalDateEngine {
  /// Entry point to ensure the local database has up-to-date festival dates.
  static Future<void> syncLocal(AppDatabase db) async {
    try {
      // 1. Initialise local festivals if empty or if new year started
      final upcoming = await db.festivalCalendarDao.getUpcomingFestivals(DateTime.now().subtract(const Duration(days: 30)), 1);
      
      if (upcoming.isEmpty) {
        final jsonStr = await rootBundle.loadString('assets/festival_dates_2024_2030.json');
        final List<dynamic> data = json.decode(jsonStr);
        final companions = data.map((j) => FestivalDate.fromJson(j).toCompanion()).toList();
        await db.festivalCalendarDao.upsertFestivals(companions);
      }
      
      // 2. Compute dynamic solar and fixed Gregorian festivals
      final currentYear = DateTime.now().year;
      final yearRange = [currentYear - 1, currentYear, currentYear + 1];
      
      final List<FestivalDate> computed = [];
      for (final y in yearRange) {
        computed.addAll(_getFixedFestivals(y));
        computed.addAll(_computeLunisolarFestivals(y));
      }
      
      final companions = computed.map((f) => f.toCompanion()).toList();
      await db.festivalCalendarDao.upsertFestivals(companions);
    } catch (e) {
      // Silently fail or log for background sync
    }
  }

  static List<FestivalDate> _getFixedFestivals(int year) {
    return [
      FestivalDate(
        key: 'ind_day_$year',
        festivalKey: 'independence_day',
        nameEn: 'Independence Day',
        nameHi: 'स्वतंत्रता दिवस',
        year: year,
        startDate: DateTime(year, 8, 15),
        endDate: DateTime(year, 8, 15, 23, 59),
        system: CalendarSystem.gregorian,
        dietType: DietaryType.normal,
        insight: 'Enjoy the national holiday with conscious eating.',
      ),
      FestivalDate(
        key: 'rep_day_$year',
        festivalKey: 'republic_day',
        nameEn: 'Republic Day',
        nameHi: 'गणतंत्र दिवस',
        year: year,
        startDate: DateTime(year, 1, 26),
        endDate: DateTime(year, 1, 26, 23, 59),
        system: CalendarSystem.gregorian,
        dietType: DietaryType.normal,
      ),
      FestivalDate(
        key: 'gandhi_jayanthi_$year',
        festivalKey: 'gandhi_jayanthi',
        nameEn: 'Gandhi Jayanti',
        nameHi: 'गांधी जयंती',
        year: year,
        startDate: DateTime(year, 10, 2),
        endDate: DateTime(year, 10, 2, 23, 59),
        system: CalendarSystem.gregorian,
        dietType: DietaryType.sattvic,
        insight: 'Clean eating and reflection. Try a sattvic meal today.',
      ),
      FestivalDate(
        key: 'lohri_$year',
        festivalKey: 'lohri',
        nameEn: 'Lohri',
        nameHi: 'लोहड़ी',
        year: year,
        startDate: DateTime(year, 1, 13),
        endDate: DateTime(year, 1, 13, 23, 59),
        system: CalendarSystem.gregorian,
        dietType: DietaryType.feast,
      ),
      FestivalDate(
        key: 'makar_sankranti_$year',
        festivalKey: 'makar_sankranti',
        nameEn: 'Makar Sankranti',
        nameHi: 'मकर संक्रांति',
        year: year,
        startDate: DateTime(year, 1, 14),
        endDate: DateTime(year, 1, 14, 23, 59),
        system: CalendarSystem.gregorian,
        dietType: DietaryType.feast,
      ),
      FestivalDate(
        key: 'christmas_$year',
        festivalKey: 'christmas',
        nameEn: 'Christmas',
        nameHi: 'क्रिसमस',
        year: year,
        startDate: DateTime(year, 12, 25),
        endDate: DateTime(year, 12, 25, 23, 59),
        system: CalendarSystem.gregorian,
        dietType: DietaryType.feast,
      ),
    ];
  }

  static List<FestivalDate> _computeLunisolarFestivals(int year) {
    // In a real app, this would use complex astronomy (Meeus/Swiss Ephemeris).
    // For this implementation, we combine algorithmic structure with 
    // lookup tables for accuracy where complex physics is needed.
    return [
      // Example: Navratri often falls around late March or early October
      // This is a placeholder for the algorithmic results from the engine.
    ];
  }
}
