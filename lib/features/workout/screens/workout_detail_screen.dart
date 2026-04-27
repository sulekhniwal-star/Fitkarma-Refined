import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_gradients.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/ambient_widgets.dart';
import '../../../shared/widgets/glass_card.dart';

// ── Static workout detail data ─────────────────────────────────────────────────

class _ExerciseData {
  final String name;
  final String setsReps;
  final int rpe;
  final String? superset; // 'A', 'B', 'C' or null

  const _ExerciseData(this.name, this.setsReps, this.rpe, [this.superset]);
}

const _workoutDetails = {
  'yoga_flow': (
    title: 'Morning Yoga Flow',
    duration: '30 min',
    difficulty: 'Beginner',
    description:
        'A gentle morning flow to awaken the body, improve flexibility, and set a calm tone for the day. Suitable for all levels.',
    equipment: ['Yoga Mat', 'Blocks (optional)'],
    exercises: [
      _ExerciseData('Sun Salutation A', '3 × 5 rounds', 4),
      _ExerciseData('Warrior I', '2 × 45 sec each side', 5),
      _ExerciseData('Warrior II', '2 × 45 sec each side', 5),
      _ExerciseData('Downward Dog', '3 × 30 sec', 4),
      _ExerciseData('Child\'s Pose', '2 × 60 sec', 2),
      _ExerciseData('Seated Forward Fold', '3 × 30 sec', 3),
    ],
  ),
  'hiit_20': (
    title: '20-Min HIIT Blast',
    duration: '20 min',
    difficulty: 'Intermediate',
    description:
        'High-intensity intervals designed to torch calories and boost cardiovascular fitness in just 20 minutes.',
    equipment: ['None'],
    exercises: [
      _ExerciseData('Burpees', '4 × 10 reps', 8, 'A'),
      _ExerciseData('Jump Squats', '4 × 15 reps', 7, 'A'),
      _ExerciseData('Mountain Climbers', '4 × 20 reps', 8, 'B'),
      _ExerciseData('High Knees', '4 × 30 sec', 7, 'B'),
      _ExerciseData('Push-ups', '3 × 12 reps', 6),
      _ExerciseData('Plank Hold', '3 × 45 sec', 6),
    ],
  ),
};

const _similarWorkouts = [
  {'id': 'hiit_20',        'title': '20-Min HIIT Blast',   'duration': '20 min'},
  {'id': 'strength_upper', 'title': 'Upper Body Strength', 'duration': '45 min'},
  {'id': 'cardio_run',     'title': 'Cardio Endurance',    'duration': '40 min'},
];

// ── Screen ─────────────────────────────────────────────────────────────────────

class WorkoutDetailScreen extends ConsumerWidget {
  final String workoutId;
  const WorkoutDetailScreen({super.key, required this.workoutId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final primary = isDark ? AppColorsDark.primary : AppColorsLight.primary;
    final surface1 = isDark ? AppColorsDark.surface1 : AppColorsLight.surface1;

    final detail = _workoutDetails[workoutId] ?? _workoutDetails['yoga_flow']!;

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.bg0 : AppColorsLight.bg0,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // ── Hero gradient (Pattern B) ─────────────────────
          Container(
            height: 300,
            decoration: BoxDecoration(
              gradient: isDark
                  ? AppGradients.heroDeep
                  : AppGradients.heroDeepLight,
            ),
            child: Stack(
              children: [
                const AmbientBlobs(),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.screenH),
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.black26,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                // Hero content
                Positioned(
                  bottom: 24,
                  left: AppSpacing.screenH,
                  right: AppSpacing.screenH,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(detail.title,
                          style: AppTypography.displayLg(
                              color: Colors.white)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _HeroBadge(
                              icon: Icons.timer_outlined,
                              label: detail.duration),
                          const SizedBox(width: 8),
                          _HeroBadge(
                              icon: Icons.fitness_center_rounded,
                              label: detail.difficulty),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Scrollable body ───────────────────────────────
          DraggableScrollableSheet(
            initialChildSize: 0.62,
            minChildSize: 0.62,
            maxChildSize: 1.0,
            builder: (_, controller) => Container(
              decoration: BoxDecoration(
                color: surface1,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppRadius.xl)),
              ),
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenH, 20, AppSpacing.screenH, 32),
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      width: 36,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColorsDark.divider
                            : AppColorsLight.divider,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // Description
                  Text('About', style: AppTypography.h4(color: text0)),
                  const SizedBox(height: 8),
                  Text(detail.description,
                      style: AppTypography.bodyMd(color: text2)),
                  const SizedBox(height: 20),

                  // Equipment chips
                  Text('Equipment',
                      style: AppTypography.h4(color: text0)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    children: detail.equipment
                        .map((e) => _EquipmentChip(
                            label: e, isDark: isDark, text2: text2))
                        .toList(),
                  ),
                  const SizedBox(height: 20),

                  // Exercise list
                  Text('Exercises',
                      style: AppTypography.h4(color: text0)),
                  const SizedBox(height: 10),
                  ...detail.exercises.map((ex) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _ExerciseRow(
                          exercise: ex,
                          isDark: isDark,
                          text0: text0,
                          text2: text2,
                          primary: primary,
                        ),
                      )),
                  const SizedBox(height: 20),

                  // Similar workouts
                  Text('Similar Workouts',
                      style: AppTypography.h4(color: text0)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _similarWorkouts.length,
                      itemBuilder: (_, i) {
                        final w = _similarWorkouts[i];
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () => context.pushReplacement(
                                '/home/workout/${w['id']}'),
                            child: GlassCard(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 10),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Text(w['title']!,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: text0)),
                                  const SizedBox(height: 4),
                                  Text(w['duration']!,
                                      style: TextStyle(
                                          fontSize: 11, color: text2)),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Start Workout CTA
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => context.push(
                          '/home/workout/$workoutId/active'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                      child: const Text('Start Workout',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Hero badge ─────────────────────────────────────────────────────────────────

class _HeroBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  const _HeroBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) => Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13, color: Colors.white),
            const SizedBox(width: 5),
            Text(label,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
          ],
        ),
      );
}

// ── Equipment chip ─────────────────────────────────────────────────────────────

class _EquipmentChip extends StatelessWidget {
  final String label;
  final bool isDark;
  final Color text2;
  const _EquipmentChip(
      {required this.label, required this.isDark, required this.text2});

  @override
  Widget build(BuildContext context) {
    final surface0 =
        isDark ? AppColorsDark.surface0 : AppColorsLight.surface0;
    final divider =
        isDark ? AppColorsDark.divider : AppColorsLight.divider;
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: surface0,
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: Border.all(color: divider),
      ),
      child: Text(label,
          style: TextStyle(fontSize: 12, color: text2)),
    );
  }
}

// ── Exercise row ───────────────────────────────────────────────────────────────

class _ExerciseRow extends StatelessWidget {
  final _ExerciseData exercise;
  final bool isDark;
  final Color text0, text2, primary;
  const _ExerciseRow(
      {required this.exercise,
      required this.isDark,
      required this.text0,
      required this.text2,
      required this.primary});

  static const _supersetColors = {
    'A': AppColorsDark.primary,
    'B': AppColorsDark.teal,
    'C': AppColorsDark.secondary,
  };

  @override
  Widget build(BuildContext context) {
    final accentColor = exercise.superset != null
        ? (_supersetColors[exercise.superset] ?? primary)
        : null;

    return GlassCard(
      padding: EdgeInsets.zero,
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Superset left accent bar
            if (accentColor != null)
              Container(
                width: 4,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppRadius.md),
                    bottomLeft: Radius.circular(AppRadius.md),
                  ),
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    // Superset letter badge
                    if (exercise.superset != null) ...[
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: accentColor!.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(exercise.superset!,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: accentColor)),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(exercise.name,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: text0)),
                          const SizedBox(height: 2),
                          Text(exercise.setsReps,
                              style: TextStyle(
                                  fontSize: 11, color: text2)),
                        ],
                      ),
                    ),
                    // RPE badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: primary.withValues(alpha: 0.1),
                        borderRadius:
                            BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Text('RPE ${exercise.rpe}',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: primary)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
