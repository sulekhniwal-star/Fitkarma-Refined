import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/providers/core_providers.dart';

part 'fasting_provider.g.dart';

enum FastingStage {
  none('Not Fasting', 'Start a fast to track your progress.'),
  bloodSugarRising('Blood Sugar Rising', 'Your body is processing your last meal.'),
  bloodSugarFalling('Blood Sugar Falling', 'Insulin levels are starting to drop.'),
  normalBloodSugar('Normal Blood Sugar', 'Your blood sugar has stabilized.'),
  transitionToFatBurning('Transition to Fat Burning', 'Your body is switching its fuel source.'),
  fatBurning('Fat Burning', 'Stored fat is being used for energy.'),
  ketosis('Ketosis', 'Your body is primarily burning fat for fuel.'),
  autophagy('Autophagy', 'Cellular cleanup and regeneration has started.');

  final String title;
  final String description;
  const FastingStage(this.title, this.description);
}

@riverpod
class FastingTimerNotifier extends _$FastingTimerNotifier {
  Timer? _timer;
  static const String _startTimeKey = 'fast_start_time';

  @override
  FutureOr<DateTime?> build() async {
    return _loadStartTime();
  }

  Future<DateTime?> _loadStartTime() async {
    final storage = ref.read(secureStorageProvider);
    final startTimeStr = await storage.read(key: _startTimeKey);
    if (startTimeStr != null) {
      final startTime = DateTime.parse(startTimeStr);
      _startTimer();
      return startTime;
    }
    return null;
  }

  Future<void> startFast() async {
    final now = DateTime.now();
    final storage = ref.read(secureStorageProvider);
    await storage.write(key: _startTimeKey, value: now.toIso8601String());
    state = AsyncValue.data(now);
    _startTimer();
  }

  Future<void> stopFast() async {
    final storage = ref.read(secureStorageProvider);
    await storage.delete(key: _startTimeKey);
    state = const AsyncValue.data(null);
    _timer?.cancel();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      // Re-trigger duration calculation by notifying listeners of the state
      ref.invalidate(fastingDurationProvider);
    });
  }
}

@riverpod
Duration fastingDuration(Ref ref) {
  final startTimeAsync = ref.watch(fastingTimerProvider);
  final startTime = startTimeAsync.asData?.value;
  if (startTime == null) return Duration.zero;

  return DateTime.now().difference(startTime);
}

@riverpod
FastingStage fastingStage(Ref ref) {
  final duration = ref.watch(fastingDurationProvider);
  if (duration == Duration.zero) return FastingStage.none;

  final hours = duration.inHours;
  if (hours < 2) return FastingStage.bloodSugarRising;
  if (hours < 5) return FastingStage.bloodSugarFalling;
  if (hours < 8) return FastingStage.normalBloodSugar;
  if (hours < 10) return FastingStage.transitionToFatBurning;
  if (hours < 12) return FastingStage.fatBurning;
  if (hours < 14) return FastingStage.ketosis;
  return FastingStage.autophagy;
}
