// lib/features/meditation/presentation/breathing_exercise_screen.dart
// Breathing exercise screen with timer

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/features/meditation/data/meditation_providers.dart';
import 'package:fitkarma/features/meditation/data/pranayama_models.dart';
import 'package:fitkarma/features/meditation/data/pranayama_service.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class BreathingExerciseScreen extends ConsumerStatefulWidget {
  final String? exerciseId;

  const BreathingExerciseScreen({super.key, this.exerciseId});

  @override
  ConsumerState<BreathingExerciseScreen> createState() =>
      _BreathingExerciseScreenState();
}

class _BreathingExerciseScreenState
    extends ConsumerState<BreathingExerciseScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateAnimation(BreathingPhase phase) {
    final exercise = ref.read(breathingSessionProvider).exercise;
    if (exercise == null) return;

    Duration phaseDuration;
    switch (phase) {
      case BreathingPhase.inhale:
        phaseDuration = Duration(seconds: exercise.inhaleSeconds);
        _animationController.duration = phaseDuration;
        _animationController.forward(from: 0);
        break;
      case BreathingPhase.exhale:
        phaseDuration = Duration(seconds: exercise.exhaleSeconds);
        _animationController.duration = phaseDuration;
        _animationController.reverse(from: 1);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(breathingSessionProvider);
    final pranyamas = ref.watch(pranyamasProvider);

    // Get exercise from ID or use first one
    final exercise =
        session.exercise ??
        (widget.exerciseId != null
            ? pranyamas.firstWhere(
                (p) => p.id == widget.exerciseId,
                orElse: () => pranyamas.first,
              )
            : pranyamas.first);

    // Update animation based on phase
    if (session.isActive && !session.isPaused) {
      _updateAnimation(session.phase);
    }

    return Scaffold(
      backgroundColor: _getBackgroundColor(session.phase),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(exercise.name),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: session.isActive || session.phase == BreathingPhase.completed
            ? _buildActiveSession(context, session)
            : _buildSetupScreen(context, exercise),
      ),
    );
  }

  Color _getBackgroundColor(BreathingPhase phase) {
    switch (phase) {
      case BreathingPhase.inhale:
        return Colors.blue.shade50;
      case BreathingPhase.exhale:
        return Colors.green.shade50;
      case BreathingPhase.holdAfterInhale:
      case BreathingPhase.holdAfterExhale:
        return Colors.orange.shade50;
      case BreathingPhase.completed:
        return AppColors.success.withValues(alpha: 0.1);
      default:
        return Colors.white;
    }
  }

  Widget _buildSetupScreen(BuildContext context, Pranayama exercise) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Exercise icon
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                exercise.iconEmoji,
                style: const TextStyle(fontSize: 48),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Name
          Text(
            exercise.name,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            exercise.sanskritName,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.primary,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            exercise.description,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),

          // Timing info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimingItem('Inhale', '${exercise.inhaleSeconds}s'),
                _buildTimingItem('Hold', '${exercise.holdAfterInhaleSeconds}s'),
                _buildTimingItem('Exhale', '${exercise.exhaleSeconds}s'),
                _buildTimingItem('Hold', '${exercise.holdAfterExhaleSeconds}s'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Cycles selector
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Cycles: ',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                '${exercise.recommendedCycles}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Start button
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                ref
                    .read(breathingSessionProvider.notifier)
                    .startExercise(exercise);
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Exercise'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Benefits
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Benefits',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 8),
          ...exercise.benefits.map(
            (b) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 16,
                    color: AppColors.success,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(b, style: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimingItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          label,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildActiveSession(
    BuildContext context,
    BreathingSessionState session,
  ) {
    final phase = session.phase;
    final exercise = session.exercise!;

    // Completed state
    if (phase == BreathingPhase.completed) {
      return _buildCompletedScreen(context, session);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Cycle counter
        Text(
          'Cycle ${session.currentCycle} of ${session.totalCycles}',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 40),

        // Animated circle
        AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: session.isPaused
                  ? _scaleAnimation.value
                  : (_scaleAnimation.value),
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getPhaseColor(phase).withValues(alpha: 0.3),
                  border: Border.all(color: _getPhaseColor(phase), width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: _getPhaseColor(phase).withValues(alpha: 0.3),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        PranayamaService.getCountdownText(
                          phase,
                          session.secondsRemaining,
                        ),
                        style: TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                          color: _getPhaseColor(phase),
                        ),
                      ),
                      Text(
                        PranayamaService.getPhaseText(
                          phase,
                          session.secondsRemaining,
                        ),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: _getPhaseColor(phase),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 40),

        // Instruction
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            PranayamaService.getPhaseInstruction(phase),
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
          ),
        ),
        const SizedBox(height: 60),

        // Controls
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Stop button
            IconButton.filled(
              onPressed: () {
                ref.read(breathingSessionProvider.notifier).stop();
              },
              icon: const Icon(Icons.stop),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.error.withValues(alpha: 0.2),
                foregroundColor: AppColors.error,
              ),
            ),
            const SizedBox(width: 24),

            // Pause/Resume button
            IconButton.filled(
              onPressed: () {
                if (session.isPaused) {
                  ref.read(breathingSessionProvider.notifier).resume();
                } else {
                  ref.read(breathingSessionProvider.notifier).pause();
                }
              },
              icon: Icon(session.isPaused ? Icons.play_arrow : Icons.pause),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(width: 24),

            // Skip button
            IconButton.filled(
              onPressed: () {
                ref.read(breathingSessionProvider.notifier).skip();
              },
              icon: const Icon(Icons.skip_next),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.secondary.withValues(alpha: 0.2),
                foregroundColor: AppColors.secondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCompletedScreen(
    BuildContext context,
    BreathingSessionState session,
  ) {
    final exercise = session.exercise!;
    final xpEarned = ref.read(breathingSessionProvider.notifier).calculateXp();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🎉', style: TextStyle(fontSize: 80)),
          const SizedBox(height: 16),
          Text(
            'Great Job!',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'You completed ${session.totalCycles} cycles of ${exercise.name}',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),

          // XP reward
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.accentLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: AppColors.accentDark),
                const SizedBox(width: 8),
                Text(
                  '+$xpEarned XP earned!',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.accentDark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  ref.read(breathingSessionProvider.notifier).stop();
                },
                child: const Text('Done'),
              ),
              const SizedBox(width: 16),
              FilledButton(
                onPressed: () {
                  ref.read(breathingSessionProvider.notifier).stop();
                  ref
                      .read(breathingSessionProvider.notifier)
                      .startExercise(exercise);
                },
                child: const Text('Repeat'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getPhaseColor(BreathingPhase phase) {
    switch (phase) {
      case BreathingPhase.inhale:
        return Colors.blue;
      case BreathingPhase.exhale:
        return Colors.green;
      case BreathingPhase.holdAfterInhale:
      case BreathingPhase.holdAfterExhale:
        return Colors.orange;
      case BreathingPhase.completed:
        return AppColors.success;
      default:
        return AppColors.primary;
    }
  }
}
