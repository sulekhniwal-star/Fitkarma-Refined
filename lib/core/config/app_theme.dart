import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Dark mode tokens
  static const bg0 = Color(0xFF080810);
  static const bg1 = Color(0xFF0F0F1A);
  static const bg2 = Color(0xFF161625);
  static const surface0 = Color(0xFF1C1C2E);
  static const surface1 = Color(0xFF22223A);
  static const surface2 = Color(0xFF2A2A45);
  static const glass = Color(0x0FFFFFFF); // rgba(255,255,255,0.06)
  static const glassBorder = Color(0x1AFFFFFF); // rgba(255,255,255,0.10)
  
  static const primary = Color(0xFFFF6B35);
  static const primaryGlow = Color(0x40FF6B35); // rgba(255,107,53,0.25)
  static const primaryMuted = Color(0x30FF6B35); // #FF6B3530
  
  static const accent = Color(0xFFFFB547);
  static const secondary = Color(0xFF7B6FF0);
  static const teal = Color(0xFF00D4B4);
  static const success = Color(0xFF4ADE80);
  static const warning = Color(0xFFFBBF24);
  static const error = Color(0xFFF87171);
  static const rose = Color(0xFFFB7185);
  static const purple = Color(0xFFC084FC);
  
  static const textPrimary = Color(0xFFF1F0FF);
  static const textSecondary = Color(0xFF9B99CC);
  static const textMuted = Color(0xFF6B68A0);
  static const divider = Color(0x14FFFFFF); // rgba(255,255,255,0.08)

  // Light mode tokens
  static const lBg0 = Color(0xFFF7F0E8);
  static const lBg1 = Color(0xFFFDF6EC);
  static const lSurface0 = Color(0xFFFFFFFF);
  static const lSurface1 = Color(0xFFFFFAF5);
  static const lGlass = Color(0xB2FFFAF5); // rgba(255,250,245,0.70)
  static const lGlassBorder = Color(0x26F4511E); // rgba(244,81,30,0.15)
  
  static const lPrimary = Color(0xFFF4511E);
  static const lPrimaryMuted = Color(0xFFFEE8E2);
  static const lAccent = Color(0xFFF59E0B);
  static const lSecondary = Color(0xFF5B50D4);
  static const lTeal = Color(0xFF0D9488);
  static const lSuccess = Color(0xFF22C55E);
  
  static const lTextPrimary = Color(0xFF1A1830);
  static const lTextSecondary = Color(0xFF6B6A96);
  static const lTextMuted = Color(0xFFB0AEC8);
  static const lDivider = Color(0x121A1830); // rgba(26,24,48,0.07)

  // Gradients
  static const heroDeep = LinearGradient(
    begin: Alignment(0.707, -0.707),
    end: Alignment(-0.707, 0.707),
    colors: [Color(0xFF0A0818), Color(0xFF1E1850)],
  );
  
  static const heroFestival = LinearGradient(
    begin: Alignment(-0.5, -0.866),
    end: Alignment(0.5, 0.866),
    colors: [Color(0xFF1A0A00), Color(0xFF3D1500)],
  );
  
  static const heroWedding = LinearGradient(
    begin: Alignment(0.707, -0.707),
    end: Alignment(-0.707, 0.707),
    colors: [Color(0xFF1A1000), Color(0xFF3A2800)],
  );
  
  static const heroPrimary = LinearGradient(
    begin: Alignment(0.707, -0.707),
    end: Alignment(-0.707, 0.707),
    colors: [Color(0xFF1A0800), Color(0xFF3D1100)],
  );

  // Radius
  static const radiusSm = 10.0;
  static const radiusMd = 16.0;
  static const radiusLg = 20.0;
  static const radiusXl = 28.0;
  static const radiusFull = 9999.0;

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bg1,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface0,
        error: error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimary,
      ),
      dividerColor: divider,
      textTheme: _textTheme(textPrimary),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lBg1,
      primaryColor: lPrimary,
      colorScheme: const ColorScheme.light(
        primary: lPrimary,
        secondary: lSecondary,
        surface: lSurface0,
        error: error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: lTextPrimary,
      ),
      dividerColor: lDivider,
      textTheme: _textTheme(lTextPrimary),
    );
  }

  static TextTheme _textTheme(Color textColor) {
    return TextTheme(
      displayLarge: GoogleFonts.plusJakartaSans(
        fontSize: 72,
        fontWeight: FontWeight.w800,
        color: textColor,
      ),
      displayMedium: GoogleFonts.plusJakartaSans(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      displaySmall: GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineLarge: GoogleFonts.plusJakartaSans(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
      headlineMedium: GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineSmall: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      titleLarge: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelLarge: GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      labelMedium: GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      bodyLarge: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      bodyMedium: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      bodySmall: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
    );
  }

  // Named TextStyles as requested in §2.2
  static TextStyle heroDisplay(BuildContext context) => Theme.of(context).textTheme.displayLarge!;
  static TextStyle displayLg(BuildContext context) => Theme.of(context).textTheme.headlineLarge!;
  static TextStyle displayMd(BuildContext context) => Theme.of(context).textTheme.displayMedium!;
  
  static TextStyle metricXL(BuildContext context) => GoogleFonts.plusJakartaSans(
    fontSize: 56,
    fontWeight: FontWeight.w700,
    color: Theme.of(context).textTheme.displayLarge?.color,
  );
  
  static TextStyle metricLg(BuildContext context) => GoogleFonts.plusJakartaSans(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: Theme.of(context).textTheme.displayLarge?.color,
  );

  static TextStyle h1(BuildContext context) => Theme.of(context).textTheme.displaySmall!;
  static TextStyle h2(BuildContext context) => Theme.of(context).textTheme.headlineMedium!;
  static TextStyle h3(BuildContext context) => Theme.of(context).textTheme.headlineSmall!;
  static TextStyle h4(BuildContext context) => Theme.of(context).textTheme.titleLarge!;
  
  static TextStyle labelLg(BuildContext context) => Theme.of(context).textTheme.labelLarge!;
  static TextStyle labelMd(BuildContext context) => Theme.of(context).textTheme.labelMedium!;
  
  static TextStyle bodyLg(BuildContext context) => Theme.of(context).textTheme.bodyLarge!;
  static TextStyle bodyMd(BuildContext context) => Theme.of(context).textTheme.bodyMedium!;
  static TextStyle bodySm(BuildContext context) => Theme.of(context).textTheme.bodySmall!;
  
  static TextStyle monoXL(BuildContext context) => GoogleFonts.jetBrainsMono(
    fontSize: 48,
    fontWeight: FontWeight.w700,
  );
  
  static TextStyle monoLg(BuildContext context) => GoogleFonts.jetBrainsMono(
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );
  
  static TextStyle caption(BuildContext context) => Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 11);
  
  static TextStyle hindi(BuildContext context) => GoogleFonts.notoSansDevanagari(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}
