import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/metric_widgets.dart';

// ── Static exercise data (reused from detail) ──────────────────────────────────

const _exercises = [
  ('Sun Salutation A', '5 rounds', 3),
  ('Warrior I',        '45 sec',   5),
  ('Warrior II',       '45 sec',   5),
  ('Downward Dog',     '30 sec',   4),
  ('Child\'s Pose',    '60 sec',   2),
];

class ActiveWorkoutScreen extends ConsumerStatefulWidget {
  final String workoutId;
  const ActiveWorkoutScreen({super.key, required this.workoutId});

  @override
  ConsumerState<ActiveWorkoutScreen> createState() =>
      _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends ConsumerState<ActiveWorkoutScreen> {
  int _exerciseIndex = 0;
  int _currentSet = 1;
  final int _totalSets = 3;
  int _rpe = 5;
  bool _isPaused = false;

  // Rest timer
  bool _resting = false;
  final int _restSeconds = 60;
  int _restRemaining = 60;
  Timer? _restTimer;

  @override
  void dispose() {
    _restTimer?.cancel();
    super.dispose();
  }

  void _startRest() {
    setState(() {
      _resting = true;
      _restRemaining = _restSeconds;
    });
    _restTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_restRemaining <= 1) {
        t.cancel();
        HapticFeedback.heavyImpact();
        setState(() => _resting = false);
      } else {
        setState(() => _restRemaining--);
        if (_restRemaining <= 3) HapticFeedback.lightImpact();
      }
    });
  }

  void _skipRest() {
    _restTimer?.cancel();
    setState(() => _resting = false);
  }

  void _nextSet() {
    HapticFeedback.mediumImpact();
    if (_currentSet < _totalSets) {
      setState(() => _currentSet++);
      _startRest();
    } else {
      _nextExercise();
    }
  }

  void _nextExercise() {
    if (_exerciseIndex < _exercises.length - 1) {
      setState(() {
        _exerciseIndex++;
        _currentSet = 1;
        _resting = false;
      });
      _restTimer?.cancel();
    } else {
      _finishWorkout();
    }
  }

  void _finishWorkout() {
    HapticFeedback.heavyImpact();
    context.pop();
  }

  void _togglePause() {
    HapticFeedback.selectionClick();
    setState(() => _isPaused = !_isPaused);
    if (_isPaused) {
      _restTimer?.cancel();
    } else if (_resting) {
      _startRest();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final primary = isDark ? AppColorsDark.primary : AppColorsLight.primary;
    final bg0 = isDark ? AppColorsDark.bg0 : AppColorsLight.bg0;
    final surface1 = isDark ? AppColorsDark.surface1 : AppColorsLight.surface1;
    final divider = isDark ? AppColorsDark.divider : AppColorsLight.divider;

    final (exName, exTarget, _) = _exercises[_exerciseIndex];
    final progress = _exerciseIndex / _exercises.length;

    return Scaffold(
      backgroundColor: bg0,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ───────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenH, 12, AppSpacing.screenH, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(Icons.close_rounded, color: text2),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 4,
                        backgroundColor: divider,
                        valueColor: AlwaysStoppedAnimation(primary),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${_exerciseIndex + 1}/${_exercises.length}',
                    style: AppTypography.bodySm(color: text2),
                  ),
                ],
              ),
            ),

            // ── Main content ──────────────────────────────────
            Expanded(
              child: _resting
                  ? _RestView(
                      remaining: _restRemaining,
                      total: _restSeconds,
                      onSkip: _skipRest,
                      primary: primary,
                      text0: text0,
                      text2: text2,
                    )
                  : _ExerciseView(
                      name: exName,
                      target: exTarget,
                      currentSet: _currentSet,
                      totalSets: _totalSets,
                      rpe: _rpe,
                      onRpeChanged: (v) {
                        HapticFeedback.selectionClick();
                        setState(() => _rpe = v.round());
                      },
                      isDark: isDark,
                      text0: text0,
                      text2: text2,
                      primary: primary,
                    ),
            ),

            // ── Glass dock ────────────────────────────────────
            Container(
              margin: const EdgeInsets.fromLTRB(
                  AppSpacing.screenH, 0, AppSpacing.screenH, 20),
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: surface1,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: divider),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _DockButton(
                    icon: _isPaused
                        ? Icons.play_arrow_rounded
                        : Icons.pause_rounded,
                    label: _isPaused ? 'Resume' : 'Pause',
                    color: text2,
                    onTap: _togglePause,
                  ),
                  Container(width: 1, height: 36, color: divider),
                  _DockButton(
                    icon: Icons.skip_next_rounded,
                    label: _currentSet < _totalSets
                        ? 'Next Set'
                        : 'Next Exercise',
                    color: primary,
                    onTap: _nextSet,
                  ),
                  Container(width: 1, height: 36, color: divider),
                  _DockButton(
                    icon: Icons.flag_rounded,
                    label: 'Finish',
                    color: AppColorsDark.success,
                    onTap: _finishWorkout,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Exercise view ──────────────────────────────────────────────────────────────

class _ExerciseView extends StatelessWidget {
  final String name, target;
  final int currentSet, totalSets, rpe;
  final ValueChanged<double> onRpeChanged;
  final bool isDark;
  final Color text0, text2, primary;

  const _ExerciseView({
    required this.name,
    required this.target,
    required this.currentSet,
    required this.totalSets,
    required this.rpe,
    required this.onRpeChanged,
    required this.isDark,
    required this.text0,
    required this.text2,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Exercise name — h1 centered
          Text(name,
              style: AppTypography.h1(color: text0),
              textAlign: TextAlign.center),
          const SizedBox(height: 8),

          // Rep target — bodyLg
          Text(target,
              style: AppTypography.bodyLg(color: text2),
              textAlign: TextAlign.center),
          const SizedBox(height: 40),

          // Set counter — monoXL with primary glow
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: primary.withValues(alpha: 0.3),
                    blurRadius: 32,
                    spreadRadius: 4),
              ],
            ),
            child: Text(
              '$currentSet',
              style: TextStyle(
                fontFamily: 'JetBrainsMono',
                fontSize: 96,
                fontWeight: FontWeight.w700,
                color: primary,
                letterSpacing: -2,
              ),
            ),
          ),
          Text('of $totalSets sets',
              style: AppTypography.labelMd(color: text2)),
          const SizedBox(height: 40),

          // HR Zone badge (placeholder)
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColorsDark.error.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(
                  color: AppColorsDark.error.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.favorite_rounded,
                    size: 14, color: AppColorsDark.error),
                const SizedBox(width: 6),
                Text('Zone 3 · 142 bpm',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColorsDark.error)),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // RPE selector — gradient slider
          Text('Rate of Perceived Exertion (RPE): $rpe',
              style: AppTypography.bodySm(color: text2)),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 6,
              thumbShape:
                  const RoundSliderThumbShape(enabledThumbRadius: 10),
              overlayShape:
                  const RoundSliderOverlayShape(overlayRadius: 18),
              activeTrackColor: primary,
              inactiveTrackColor: primary.withValues(alpha: 0.15),
              thumbColor: primary,
              overlayColor: primary.withValues(alpha: 0.15),
            ),
            child: Slider(
              value: rpe.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: onRpeChanged,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Easy', style: AppTypography.caption(color: text2)),
              Text('Max', style: AppTypography.caption(color: text2)),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Rest view ──────────────────────────────────────────────────────────────────

class _RestView extends StatelessWidget {
  final int remaining, total;
  final VoidCallback onSkip;
  final Color primary, text0, text2;

  const _RestView({
    required this.remaining,
    required this.total,
    required this.onSkip,
    required this.primary,
    required this.text0,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    final progress = remaining / total;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Rest', style: AppTypography.h2(color: text2)),
        const SizedBox(height: 24),
        SizedBox(
          width: 180,
          height: 180,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PulseRing(
                color: primary,
                child: SizedBox(
                  width: 160,
                  height: 160,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 6,
                    backgroundColor: primary.withValues(alpha: 0.12),
                    valueColor: AlwaysStoppedAnimation(primary),
                  ),
                ),
              ),
              Text(
                '$remaining',
                style: TextStyle(
                  fontFamily: 'JetBrainsMono',
                  fontSize: 56,
                  fontWeight: FontWeight.w700,
                  color: primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text('seconds remaining',
            style: AppTypography.bodySm(color: text2)),
        const SizedBox(height: 32),
        TextButton(
          onPressed: onSkip,
          style: TextButton.styleFrom(foregroundColor: text2),
          child: const Text('Skip Rest',
              style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

// ── Dock button ────────────────────────────────────────────────────────────────

class _DockButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _DockButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color)),
          ],
        ),
      );
}
