import 'package:flutter/physics.dart';

class MotionPresets {
  // Spring presets
  static const lightSpring = SpringDescription(
    mass: 1.0,
    stiffness: 400.0,
    damping: 0.85, // Note: TODO said ratio: 0.85, roughly translates to damping
  );

  static const standardSpring = SpringDescription(
    mass: 1.0,
    stiffness: 250.0,
    damping: 0.80,
  );

  static const dramaticSpring = SpringDescription(
    mass: 1.0,
    stiffness: 180.0,
    damping: 0.75,
  );

  // Animation durations
  static const durationLight = Duration(milliseconds: 200);
  static const durationStandard = Duration(milliseconds: 300);
  static const durationDramatic = Duration(milliseconds: 500);
}
