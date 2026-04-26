import 'package:flutter/physics.dart';

class AppSprings {
  AppSprings._();

  /// Chips, toggles, small state changes
  static const light = SpringDescription(mass: 1.0, stiffness: 400, damping: 28.28);

  /// Cards, tab transitions, page routes  
  static const standard = SpringDescription(mass: 1.0, stiffness: 250, damping: 22.36);

  /// Hero entrances, metric reveals, level-up
  static const dramatic = SpringDescription(mass: 1.0, stiffness: 180, damping: 18.97);
}
