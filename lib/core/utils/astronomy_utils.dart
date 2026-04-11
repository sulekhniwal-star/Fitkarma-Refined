import 'dart:math';

/// Utility class for astronomical computations like sunrise, sunset, 
/// moonrise, and lunar phases for Indian festivals and Ramadan.
class AstronomyUtils {
  AstronomyUtils._();

  /// Calculates sunrise and sunset for a given location and date.
  /// Returns a Map with 'sunrise' and 'sunset' as DateTime objects.
  /// Based on the simplified Meeus algorithm (zenith 90.833).
  static Map<String, DateTime> calculateSunTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
  }) {
    final sunrise = _computeSunTime(latitude, longitude, date, true);
    final sunset = _computeSunTime(latitude, longitude, date, false);

    return {
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }

  /// Calculates moonrise time for a given location and date.
  /// Crucial for Karva Chauth.
  /// Note: This is an approximation. High precision requires complex ephemeris.
  static DateTime calculateMoonrise({
    required double latitude,
    required double longitude,
    required DateTime date,
  }) {
    // Moonrise is roughly 50 minutes later each day.
    // However, for Karva Chauth, we need it relative to sunset.
    // Simplified: roughly offsets from the New Moon or Full Moon cycle.
    // For Karva Chauth (Krishna Paksha Chaturthi), it's usually 1.5 - 2 hours after sunset.
    
    // In a real implementation, we'd use the lunar age and RA/Dec.
    // For now, providing a robust approximation based on empirical offsets.
    final sunTimes = calculateSunTimes(latitude: latitude, longitude: longitude, date: date);
    final sunset = sunTimes['sunset']!;
    
    // Karva Chauth moonrise is roughly 20:00 - 21:00 in India usually.
    return sunset.add(const Duration(hours: 1, minutes: 45)); 
  }

  static DateTime _computeSunTime(double lat, double lng, DateTime date, bool isSunrise) {
    const deg2rad = pi / 180;
    const rad2deg = 180 / pi;

    // 1. Day of the year
    final n = date.difference(DateTime(date.year, 1, 1)).inDays + 1;

    // 2. Approximate time
    final lngHour = lng / 15;
    final t = isSunrise ? n + ((6 - lngHour) / 24) : n + ((18 - lngHour) / 24);

    // 3. Mean anomaly
    final m = (0.9856 * t) - 3.289;

    // 4. True longitude
    var l = m + (1.916 * sin(m * deg2rad)) + (0.020 * sin(2 * m * deg2rad)) + 282.634;
    l = _normalize(l, 360);

    // 5. Right ascension
    var ra = rad2deg * atan(0.91764 * tan(l * deg2rad));
    ra = _normalize(ra, 360);

    // RA must be in same quadrant as L
    final lQuadrant = (l / 90).floor() * 90;
    final raQuadrant = (ra / 90).floor() * 90;
    ra = ra + (lQuadrant - raQuadrant);
    ra = ra / 15;

    // 6. Declination
    final sinDec = 0.39782 * sin(l * deg2rad);
    final cosDec = cos(asin(sinDec));

    // 7. Local hour angle
    const zenith = 90.8333;
    final cosH = (cos(zenith * deg2rad) - (sinDec * sin(lat * deg2rad))) / (cosDec * cos(lat * deg2rad));

    if (cosH > 1) return DateTime(date.year, date.month, date.day, 0, 0); // Always dark
    if (cosH < -1) return DateTime(date.year, date.month, date.day, 23, 59); // Always light

    // 8. Calculate H and convert to hours
    final acousRange = max(-1.0, min(1.0, cosH));
    var h = isSunrise ? 360 - rad2deg * acos(acousRange) : rad2deg * acos(acousRange);
    h = h / 15;

    // 9. Local mean time
    final localT = h + ra - (0.06571 * t) - 6.622;

    // 10. UTC time
    var utcT = localT - lngHour;
    utcT = _normalize(utcT, 24);

    // 11. Convert to local time
    final localOffset = date.timeZoneOffset.inHours + (date.timeZoneOffset.inMinutes % 60 / 60);
    final localTFinal = _normalize(utcT + localOffset, 24);
    
    final hour = localTFinal.floor();
    final minute = ((localTFinal - hour) * 60).floor();
    
    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  static double _normalize(double value, double max) {
    var v = value % max;
    if (v < 0) v += max;
    return v;
  }
}
