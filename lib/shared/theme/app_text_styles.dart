import 'package:flutter/material.dart';

class AppTextStyles {
  // Base Text Styles
  static const displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.25,
  );

  static const displayMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.25,
  );

  static const h1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.25,
  );

  static const h2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static const h3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static const h4 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static const sectionHeader = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static const sectionHeaderHindi = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );

  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  static const labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static const labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static const caption = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 1.2,
  );

  static const statLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static const statMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static const buttonLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  // Dark Mode / Hero Variants
  static final h1OnDark = h1.copyWith(color: Colors.white);
  static final bodyOnDark = bodyMedium.copyWith(color: Colors.white.withOpacity(0.7));
  static final captionOnDark = caption.copyWith(fontSize: 11, color: Colors.white.withOpacity(0.54));
}
