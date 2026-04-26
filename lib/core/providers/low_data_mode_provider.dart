import 'package:flutter_riverpod/flutter_riverpod.dart';

// Using Riverpod 2.0+ Notifier pattern
class LowDataModeNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() => state = !state;

  void setLowDataMode(bool enabled) => state = enabled;
}

final lowDataModeProvider = NotifierProvider<LowDataModeNotifier, bool>(() {
  return LowDataModeNotifier();
});
