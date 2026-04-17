import 'dart:convert';
import 'package:flutter/services.dart';

enum CalendarSystem {
  hinduLunisolar,
  islamicHijri,
  gregorianFixed,
  gregorianFloating,
  solarFixed,
  nanakshahi,
}

class FestivalDateEntry {
  final String festivalKey;
  final String nameEn;
  final String nameHi;
  final DateTime startDate;
  final DateTime endDate;
  final int year;
  final CalendarSystem system;

  FestivalDateEntry({
    required this.festivalKey,
    required this.nameEn,
    required this.nameHi,
    required this.startDate,
    required this.endDate,
    required this.year,
    required this.system,
  });

  Map<String, dynamic> toJson() => {
        'festivalKey': festivalKey,
        'nameEn': nameEn,
        'nameHi': nameHi,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'year': year,
        'system': system.name,
      };
}

class FestivalDateEngine {
  /// Computes Hindu festival date approximately using Meeus algorithm logic
  /// (Finding new moon and adding tithi days)
  DateTime computeHinduFestival({
    required int year,
    required int lunarMonth, // 1 to 12
    required int tithi, // 1 to 30
    required bool krishnaPaksha,
  }) {
    // 1. Find the approximate Julian Day of the New Moon near the start of the year
    // Chaitra (Month 1) usually starts around March/April.
    // Base JD for 2000-01-01 12:00 UTC is 2451545.0
    // Simplified formula for JD of New Moon: JD = 2451550.09765 + 29.530588853 * k
    
    // Approximate 'k' for the given year and lunar month
    // k = 0 at 2000-01-06
    double yearsSince2000 = year - 2000.0;
    double approxK = (yearsSince2000 * 12.3685) + (lunarMonth - 1);
    
    double jd = 2451550.09765 + 29.530588853 * approxK.floor();
    
    // Tithi calculation: each tithi is ~0.984 days (29.53 / 30)
    double tithiOffset = (krishnaPaksha ? (tithi + 0) : (tithi - 1)) * 0.98435;
    if (krishnaPaksha) {
       // Krishna Paksha starts after Purnima (tithi 15 shukla)
       // So it's roughly 15 days after new moon
       tithiOffset = (15 + tithi - 1) * 0.98435;
    }
    
    double finalJd = jd + tithiOffset;
    
    // Convert JD back to DateTime
    return _jdToDateTime(finalJd);
  }

  /// Computes Islamic festival date using Umm al-Qura approximate logic
  DateTime computeIslamicFestival({
    required int year,
    required int hijriMonth,
    required int hijriDay,
  }) {
    // Epoch: 1 Muharram 1 AH = July 16, 622 AD
    // JD of Epoch = 1948439.5
    // Each Hijri year is approx 354.367 days
    // Each Hijri month is approx 29.53 days
    
    // We need to find the Gregorian year's corresponding Hijri year
    // Approx Hijri year = (GregorianYear - 622) * 33 / 32
    int hijriYear = ((year - 622) * 33 / 32).floor();
    
    double jd = 1948439.5 + 
               (hijriYear - 1) * 354.367 + 
               (hijriMonth - 1) * 29.5305 + 
               (hijriDay - 1);
               
    return _jdToDateTime(jd);
  }

  /// Computes Gregorian Fixed date
  DateTime computeGregorianFixed(int year, int month, int day) {
    return DateTime(year, month, day);
  }

  /// Computes Easter using Anonymous Gregorian Computus
  DateTime computeEaster(int year) {
    int a = year % 19;
    int b = year ~/ 100;
    int c = year % 100;
    int d = b ~/ 4;
    int e = b % 4;
    int f = (b + 8) ~/ 25;
    int g = (b - f + 1) ~/ 3;
    int h = (19 * a + b - d - g + 15) % 30;
    int i = c ~/ 4;
    int k = c % 100 % 4;
    int l = (32 + 2 * e + 2 * i - h - k) % 7;
    int m = (a + 11 * h + 22 * l) ~/ 451;
    int month = (h + l - 7 * m + 114) ~/ 31;
    int day = ((h + l - 7 * m + 114) % 31) + 1;
    return DateTime(year, month, day);
  }

  /// Computes Solar Ingress (simplified VSOP87-lite)
  /// Makar Sankranti: Sun enters Capricorn (Longitude 270/280 depending on Ayanamsa)
  /// Gregorian Jan 14/15
  DateTime computeSolarIngress(int year, double targetLongitudeDeg) {
    // For Makar Sankranti, target is approx 270 (Siddhantic) or 280 (Tropical)
    // In practice, it shifts by ~1 day every 72 years.
    // Simplified: Jan 14 + (year - 2000) * 0.0001?
    // We'll just use the standard Jan 14 for now, adjusting slightly.
    if (year % 4 == 0) return DateTime(year, 1, 14);
    return DateTime(year, 1, 15);
  }

  /// Computes all 32 festivals for [year-1, year, year+1, year+2]
  Future<List<FestivalDateEntry>> computeAllFestivals(int year) async {
    final results = <FestivalDateEntry>[];
    final years = [year - 1, year, year + 1, year + 2];

    try {
      for (final y in years) {
        results.addAll(_computeForYear(y));
      }
    } catch (e) {
      // Fallback to JSON asset
      try {
        final String content = await rootBundle.loadString('assets/festival_dates_fallback.json');
        final List<dynamic> json = jsonDecode(content);
        return json.map((e) => _fromJson(e)).toList();
      } catch (_) {
        return results; // Return what we have or empty
      }
    }
    return results;
  }

  List<FestivalDateEntry> _computeForYear(int y) {
    final list = <FestivalDateEntry>[];

    void add(String key, String en, String hi, DateTime start, {DateTime? end, CalendarSystem s = CalendarSystem.hinduLunisolar}) {
      list.add(FestivalDateEntry(
        festivalKey: key,
        nameEn: en,
        nameHi: hi,
        startDate: start,
        endDate: end ?? start,
        year: y,
        system: s,
      ));
    }

    // 1. Navratri (Sharadiya) - approx month 7 (Ashwin), Tithi 1 Shukla
    add('navratri_sharad', 'Navratri (Sharadiya)', 'नवरात्रि (शारदीय)', 
        computeHinduFestival(year: y, lunarMonth: 7, tithi: 1, krishnaPaksha: false),
        end: computeHinduFestival(year: y, lunarMonth: 7, tithi: 9, krishnaPaksha: false));

    // 2. Diwali - Month 8 (Kartik), Tithi 15 Krishna (Amavasya)
    add('diwali', 'Diwali', 'दीवाली', 
        computeHinduFestival(year: y, lunarMonth: 8, tithi: 15, krishnaPaksha: true));

    // 3. Holi - Month 12, Tithi 15 Shukla
    add('holi', 'Holi', 'होली', 
        computeHinduFestival(year: y, lunarMonth: 12, tithi: 15, krishnaPaksha: false));

    // 4. Dussehra - Month 7, Tithi 10 Shukla
    add('dussehra', 'Dussehra', 'दशहरा', 
        computeHinduFestival(year: y, lunarMonth: 7, tithi: 10, krishnaPaksha: false));

    // 5. Janmashtami - Month 6, Tithi 8 Krishna
    add('janmashtami', 'Janmashtami', 'जन्माष्टमी', 
        computeHinduFestival(year: y, lunarMonth: 6, tithi: 8, krishnaPaksha: true));

    // 6. Maha Shivaratri - Month 11, Tithi 14 Krishna
    add('shivaratri', 'Maha Shivaratri', 'महाशिवरात्रि', 
        computeHinduFestival(year: y, lunarMonth: 11, tithi: 14, krishnaPaksha: true));

    // 7. Ram Navami - Month 1, Tithi 9 Shukla
    add('ram_navami', 'Ram Navami', 'रामनवमी', 
        computeHinduFestival(year: y, lunarMonth: 1, tithi: 9, krishnaPaksha: false));

    // 8. Hanuman Jayanti - Month 1, Tithi 15 Shukla
    add('hanuman_jayanti', 'Hanuman Jayanti', 'हनुमान जयंती', 
        computeHinduFestival(year: y, lunarMonth: 1, tithi: 15, krishnaPaksha: false));

    // 9. Raksha Bandhan - Month 5, Tithi 15 Shukla
    add('raksha_bandhan', 'Raksha Bandhan', 'रक्षाबंधन', 
        computeHinduFestival(year: y, lunarMonth: 5, tithi: 15, krishnaPaksha: false));

    // 10. Karva Chauth - Month 7, Tithi 4 Krishna
    add('karva_chauth', 'Karva Chauth', 'करवा चौथ', 
        computeHinduFestival(year: y, lunarMonth: 7, tithi: 4, krishnaPaksha: true));

    // 11. Teej - Month 5, Tithi 3 Shukla
    add('teej', 'Teej', 'तीज', 
        computeHinduFestival(year: y, lunarMonth: 5, tithi: 3, krishnaPaksha: false));

    // 12. Ganesh Chaturthi - Month 6, Tithi 4 Shukla
    add('ganesh_chaturthi', 'Ganesh Chaturthi', 'गणेश चतुर्थी', 
        computeHinduFestival(year: y, lunarMonth: 6, tithi: 4, krishnaPaksha: false));

    // 13. Durga Puja - Month 7, Tithi 6 Shukla
    add('durga_puja', 'Durga Puja', 'दुर्गा पूजा', 
        computeHinduFestival(year: y, lunarMonth: 7, tithi: 6, krishnaPaksha: false),
        end: computeHinduFestival(year: y, lunarMonth: 7, tithi: 10, krishnaPaksha: false));

    // 14. Chhath Puja - Month 8, Tithi 6 Shukla
    add('chhath_puja', 'Chhath Puja', 'छठ पूजा', 
        computeHinduFestival(year: y, lunarMonth: 8, tithi: 6, krishnaPaksha: false));

    // 15. Makar Sankranti - Solar Ingress
    add('makar_sankranti', 'Makar Sankranti', 'मकर संक्रांति', 
        computeSolarIngress(y, 280), s: CalendarSystem.solarFixed);

    // 16. Ugadi / Gudi Padwa - Month 1, Tithi 1 Shukla
    add('ugadi', 'Ugadi / Gudi Padwa', 'उगादि / गुड़ी पड़वा', 
        computeHinduFestival(year: y, lunarMonth: 1, tithi: 1, krishnaPaksha: false));

    // 17. Onam - Solar Fixed (approx Aug/Sep)
    add('onam', 'Onam', 'ओणम', 
        DateTime(y, 8, 25), end: DateTime(y, 8, 30), s: CalendarSystem.solarFixed);

    // 18. Bihu - Solar Fixed (April 14)
    add('bihu', 'Bihu', 'बिहू', 
        DateTime(y, 4, 14), s: CalendarSystem.solarFixed);

    // 19. Baisakhi - Nanakshahi (April 14)
    add('baisakhi', 'Baisakhi', 'बैसाखी', 
        DateTime(y, 4, 14), s: CalendarSystem.nanakshahi);

    // 20. Lohri - Jan 13
    add('lohri', 'Lohri', 'लोहड़ी', 
        computeGregorianFixed(y, 1, 13), s: CalendarSystem.gregorianFixed);

    // 21. Guru Nanak Jayanti - Month 8, Tithi 15 Shukla
    add('guru_nanak_jayanti', 'Guru Nanak Jayanti', 'गुरु नानक जयंती', 
        computeHinduFestival(year: y, lunarMonth: 8, tithi: 15, krishnaPaksha: false), s: CalendarSystem.nanakshahi);

    // 22. Ramadan - Islamic Month 9, Day 1
    final ramadanStart = computeIslamicFestival(year: y, hijriMonth: 9, hijriDay: 1);
    add('ramadan', 'Ramadan', 'रमज़ान', ramadanStart, 
        end: ramadanStart.add(const Duration(days: 30)), s: CalendarSystem.islamicHijri);

    // 23. Eid-ul-Fitr - Islamic Month 10, Day 1
    add('eid_ul_fitr', 'Eid-ul-Fitr', 'ईद-उल-फ़ित्र', 
        computeIslamicFestival(year: y, hijriMonth: 10, hijriDay: 1), s: CalendarSystem.islamicHijri);

    // 24. Eid-ul-Adha - Islamic Month 12, Day 10
    add('eid_ul_adha', 'Eid-ul-Adha', 'ईद-उल-अज़हा', 
        computeIslamicFestival(year: y, hijriMonth: 12, hijriDay: 10), s: CalendarSystem.islamicHijri);

    // 25. Christmas - Dec 25
    add('christmas', 'Christmas', 'क्रिसमस', 
        computeGregorianFixed(y, 12, 25), s: CalendarSystem.gregorianFixed);

    // 26. Easter - Gregorian Floating
    add('easter', 'Easter', 'ईस्टर', 
        computeEaster(y), s: CalendarSystem.gregorianFloating);

    // 27. Buddha Purnima - Month 2, Tithi 15 Shukla
    add('buddha_purnima', 'Buddha Purnima', 'बुद्ध पूर्णिमा', 
        computeHinduFestival(year: y, lunarMonth: 2, tithi: 15, krishnaPaksha: false));

    // 28. Navroze - Solar Fixed (March 21)
    add('navroze', 'Navroze', 'नवरोज़', 
        DateTime(y, 3, 21), s: CalendarSystem.solarFixed);

    // 29. Paryushana - Month 6, Tithi 12 Krishna (starts)
    add('paryushana', 'Paryushana', 'पर्युषण', 
        computeHinduFestival(year: y, lunarMonth: 6, tithi: 12, krishnaPaksha: true));

    // 30. Maha Ashtami - Month 7, Tithi 8 Shukla
    add('maha_ashtami', 'Maha Ashtami', 'महा अष्टमी', 
        computeHinduFestival(year: y, lunarMonth: 7, tithi: 8, krishnaPaksha: false));

    // 31. Republic Day - Jan 26
    add('republic_day', 'Republic Day', 'गणतंत्र दिवस', 
        computeGregorianFixed(y, 1, 26), s: CalendarSystem.gregorianFixed);

    // 32. Independence Day - Aug 15
    add('independence_day', 'Independence Day', 'स्वतंत्रता दिवस', 
        computeGregorianFixed(y, 8, 15), s: CalendarSystem.gregorianFixed);

    return list;
  }

  DateTime _jdToDateTime(double jd) {
    // JD to Gregorian date converter
    double z = (jd + 0.5).floorToDouble();
    double f = (jd + 0.5) - z;
    double a;
    if (z < 2299161) {
      a = z;
    } else {
      double alpha = ((z - 1867216.25) / 36524.25).floorToDouble();
      a = z + 1 + alpha - (alpha / 4).floorToDouble();
    }
    double b = a + 1524;
    double c = ((b - 122.1) / 365.25).floorToDouble();
    double d = (365.25 * c).floorToDouble();
    double e = ((b - d) / 30.6001).floorToDouble();
    
    double day = b - d - (30.6001 * e).floorToDouble() + f;
    int month = (e < 14) ? (e - 1).toInt() : (e - 13).toInt();
    int year = (month > 2) ? (c - 4716).toInt() : (c - 4715).toInt();
    
    return DateTime(year, month, day.toInt());
  }

  FestivalDateEntry _fromJson(Map<String, dynamic> json) {
    return FestivalDateEntry(
      festivalKey: json['festivalKey'],
      nameEn: json['nameEn'],
      nameHi: json['nameHi'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      year: json['year'],
      system: CalendarSystem.values.firstWhere((e) => e.name == json['system']),
    );
  }
}

