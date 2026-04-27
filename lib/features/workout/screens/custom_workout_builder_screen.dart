import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/ambient_widgets.dart';
import '../../../shared/widgets/glass_card.dart';

// ── Exercise model ─────────────────────────────────────────────────────────────

class _Exercise {
  String name;
  String sets;
  String reps;
  String rest;
  String rpe;
  String? superset; // 'A', 'B', 'C' or null

  _Exercise({
    this.name = '',
    this.sets = '3',
    this.reps = '10',
    this.rest = '60',
    this.rpe = '7',
    this.superset,
  });
}

// ── Screen ─────────────────────────────────────────────────────────────────────

class CustomWorkoutBuilderScreen extends ConsumerStatefulWidget {
  const CustomWorkoutBuilderScreen({super.key});

  @override
  ConsumerState<CustomWorkoutBuilderScreen> createState() =>
      _CustomWorkoutBuilderScreenState();
}

class _CustomWorkoutBuilderScreenState
    extends ConsumerState<CustomWorkoutBuilderScreen> {
  final _planNameCtrl = TextEditingController(text: 'My Custom Plan');
  final List<_Exercise> _exercises = [
    _Exercise(name: 'Squat', sets: '4', reps: '12', rest: '90', rpe: '7'),
    _Exercise(name: 'Bench Press', sets: '4', reps: '10', rest: '90', rpe: '8', superset: 'A'),
    _Exercise(name: 'Dumbbell Row', sets: '4', reps: '10', rest: '60', rpe: '7', superset: 'A'),
  ];

  void _addExercise() {
    setState(() => _exercises.add(_Exercise()));
  }

  void _removeExercise(int index) {
    setState(() => _exercises.removeAt(index));
  }

  void _savePlan() {
    // TODO: persist via WorkoutNotifier
    context.pop();
  }

  @override
  void dispose() {
    _planNameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final primary = isDark ? AppColorsDark.primary : AppColorsLight.primary;
    final bg1 = isDark ? AppColorsDark.bg1 : AppColorsLight.bg1;
    final surface0 = isDark ? AppColorsDark.surface0 : AppColorsLight.surface0;
    final divider = isDark ? AppColorsDark.divider : AppColorsLight.divider;

    return Scaffold(
      backgroundColor: bg1,
      body: Stack(
        children: [
          const AmbientBlobs(),
          SafeArea(
            child: Column(
              children: [
                // ── App bar ─────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenH, 12, AppSpacing.screenH, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            size: 20, color: text2),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _planNameCtrl,
                          style: AppTypography.h1(color: text0),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // ── Reorderable exercise list ────────────────
                Expanded(
                  child: ReorderableListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenH),
                    itemCount: _exercises.length,
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) newIndex--;
                        final item = _exercises.removeAt(oldIndex);
                        _exercises.insert(newIndex, item);
                      });
                    },
                    itemBuilder: (_, i) => _ExerciseRow(
                      key: ValueKey(i),
                      exercise: _exercises[i],
                      index: i,
                      isDark: isDark,
                      text0: text0,
                      text2: text2,
                      primary: primary,
                      surface0: surface0,
                      divider: divider,
                      onDelete: () => _removeExercise(i),
                      onChanged: () => setState(() {}),
                    ),
                  ),
                ),

                // ── Bottom buttons ───────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenH, 8, AppSpacing.screenH, 20),
                  child: Column(
                    children: [
                      // + Add Exercise
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton.icon(
                          onPressed: _addExercise,
                          icon: Icon(Icons.add_rounded, color: primary),
                          label: Text('Add Exercise',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primary)),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: primary),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppRadius.md),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Save Plan
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _savePlan,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppRadius.md),
                            ),
                          ),
                          child: const Text('Save Plan',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Exercise row ───────────────────────────────────────────────────────────────

class _ExerciseRow extends StatefulWidget {
  final _Exercise exercise;
  final int index;
  final bool isDark;
  final Color text0, text2, primary, surface0, divider;
  final VoidCallback onDelete, onChanged;

  const _ExerciseRow({
    super.key,
    required this.exercise,
    required this.index,
    required this.isDark,
    required this.text0,
    required this.text2,
    required this.primary,
    required this.surface0,
    required this.divider,
    required this.onDelete,
    required this.onChanged,
  });

  @override
  State<_ExerciseRow> createState() => _ExerciseRowState();
}

class _ExerciseRowState extends State<_ExerciseRow> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _setsCtrl;
  late final TextEditingController _repsCtrl;
  late final TextEditingController _restCtrl;
  late final TextEditingController _rpeCtrl;

  static const _supersets = [null, 'A', 'B', 'C'];
  static const _supersetColors = {
    'A': AppColorsDark.primary,
    'B': AppColorsDark.teal,
    'C': AppColorsDark.secondary,
  };

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.exercise.name);
    _setsCtrl = TextEditingController(text: widget.exercise.sets);
    _repsCtrl = TextEditingController(text: widget.exercise.reps);
    _restCtrl = TextEditingController(text: widget.exercise.rest);
    _rpeCtrl  = TextEditingController(text: widget.exercise.rpe);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _setsCtrl.dispose();
    _repsCtrl.dispose();
    _restCtrl.dispose();
    _rpeCtrl.dispose();
    super.dispose();
  }

  void _cycleSuperset() {
    final current = widget.exercise.superset;
    final idx = _supersets.indexOf(current);
    widget.exercise.superset =
        _supersets[(idx + 1) % _supersets.length];
    widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final ss = widget.exercise.superset;
    final ssColor = ss != null ? _supersetColors[ss] : null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassCard(
        padding: EdgeInsets.zero,
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Superset accent bar
              if (ssColor != null)
                Container(
                  width: 4,
                  decoration: BoxDecoration(
                    color: ssColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppRadius.md),
                      bottomLeft: Radius.circular(AppRadius.md),
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name field
                      TextField(
                        controller: _nameCtrl,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: widget.text0),
                        decoration: InputDecoration(
                          hintText: 'Exercise name',
                          hintStyle:
                              TextStyle(fontSize: 13, color: widget.text2),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: (v) => widget.exercise.name = v,
                      ),
                      const SizedBox(height: 8),

                      // Inline inputs row
                      Row(
                        children: [
                          _InlineInput(
                            ctrl: _setsCtrl,
                            label: 'Sets',
                            width: 44,
                            text0: widget.text0,
                            text2: widget.text2,
                            surface0: widget.surface0,
                            divider: widget.divider,
                            onChanged: (v) => widget.exercise.sets = v,
                          ),
                          const SizedBox(width: 6),
                          _InlineInput(
                            ctrl: _repsCtrl,
                            label: 'Reps',
                            width: 44,
                            text0: widget.text0,
                            text2: widget.text2,
                            surface0: widget.surface0,
                            divider: widget.divider,
                            onChanged: (v) => widget.exercise.reps = v,
                          ),
                          const SizedBox(width: 6),
                          _InlineInput(
                            ctrl: _restCtrl,
                            label: 'Rest(s)',
                            width: 52,
                            text0: widget.text0,
                            text2: widget.text2,
                            surface0: widget.surface0,
                            divider: widget.divider,
                            onChanged: (v) => widget.exercise.rest = v,
                          ),
                          const SizedBox(width: 6),
                          _InlineInput(
                            ctrl: _rpeCtrl,
                            label: 'RPE',
                            width: 40,
                            text0: widget.text0,
                            text2: widget.text2,
                            surface0: widget.surface0,
                            divider: widget.divider,
                            onChanged: (v) => widget.exercise.rpe = v,
                          ),
                          const Spacer(),

                          // Superset pill
                          GestureDetector(
                            onTap: _cycleSuperset,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: ssColor != null
                                    ? ssColor.withValues(alpha: 0.15)
                                    : widget.surface0,
                                borderRadius:
                                    BorderRadius.circular(AppRadius.sm),
                                border: Border.all(
                                  color: ssColor != null
                                      ? ssColor.withValues(alpha: 0.4)
                                      : widget.divider,
                                ),
                              ),
                              child: Text(
                                ss ?? '—',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: ssColor ?? widget.text2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Delete + drag handle column
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete_outline_rounded,
                        size: 18, color: AppColorsDark.error),
                    onPressed: widget.onDelete,
                    padding: EdgeInsets.zero,
                    constraints:
                        const BoxConstraints(minWidth: 36, minHeight: 36),
                  ),
                  ReorderableDragStartListener(
                    index: widget.index,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4, bottom: 8),
                      child: Icon(Icons.drag_handle_rounded,
                          size: 20, color: widget.text2),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Inline input ───────────────────────────────────────────────────────────────

class _InlineInput extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;
  final double width;
  final Color text0, text2, surface0, divider;
  final ValueChanged<String> onChanged;

  const _InlineInput({
    required this.ctrl,
    required this.label,
    required this.width,
    required this.text0,
    required this.text2,
    required this.surface0,
    required this.divider,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(fontSize: 9, color: text2)),
            const SizedBox(height: 2),
            Container(
              height: 28,
              decoration: BoxDecoration(
                color: surface0,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: divider),
              ),
              child: TextField(
                controller: ctrl,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: text0),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4),
                ),
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      );
}
