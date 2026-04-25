import 'package:flutter/material.dart';

class AppGradients {
  AppGradients._();

  static const heroDeep = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0A0818), Color(0xFF1E1850)],
  );

  static const heroDeepLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2C2A6B), Color(0xFF3F3D8F)],
  );

  static const heroSleep = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF04020F), Color(0xFF0D0B2E), Color(0xFF1C1A48)],
  );

  static const heroFestival = LinearGradient(
    begin: Alignment(-.5, -1),
    end: Alignment(.5, 1),
    colors: [Color(0xFF1A0A00), Color(0xFF3D1500)],
  );

  static const heroWedding = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A1000), Color(0xFF3A2800)],
  );

  static const heroPrimary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A0800), Color(0xFF3D1100)],
  );
}
