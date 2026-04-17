import 'package:flutter/physics.dart';

class MotionPresets {
  // Spring presets
  static final lightSpring = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 400.0,
    ratio: 0.85,
  );

  static final standardSpring = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 250.0,
    ratio: 0.80,
  );

  static final dramaticSpring = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 180.0,
    ratio: 0.75,
  );

  // Animation durations
  static const durationLight = Duration(milliseconds: 200);
  static const durationStandard = Duration(milliseconds: 300);
  static const durationDramatic = Duration(milliseconds: 500);
}

