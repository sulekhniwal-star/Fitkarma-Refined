import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' show Value;
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/bilingual_text.dart';
import '../../../core/storage/app_database.dart';
import '../data/exercise_repository.dart';
import '../data/rest_timer_notifier.dart';
import '../data/workout_controller.dart';
import '../../auth/data/auth_repository.dart';
import 'pr_celebration_overlay.dart';

class WorkoutLogScreen extends ConsumerStatefulWidget {
  const WorkoutLogScreen({super.key});

  @override
  ConsumerState<WorkoutLogScreen> createState() => _WorkoutLogScreenState();
}

class _WorkoutLogScreenState extends ConsumerState<WorkoutLogScreen> {
  final List<ExerciseWithSets> _exercises = [];
  bool _isSaving = false;
  final String _workoutTitle = "Evening Workout";

  void _addExercise() async {
    final repo = ref.read(exerciseRepositoryProvider);
    final all = await repo.searchExercises('');
    
    if (!mounted) return;
    
    final selected = await showModalBottomSheet<Exercise>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _ExerciseSearchSheet(exercises: all),
    );

    if (selected != null) {
      setState(() {
        _exercises.add(ExerciseWithSets(
          exercise: selected,
          sets: [ExerciseSet(
            id: const Uuid().v4(),
            workoutLogId: '',
            exerciseId: selected.id,
            setNumber: 1,
            isWarmup: false,
            isCompleted: false,
            createdAt: DateTime.now(),
          )],
        ));
      });
    }
  }

  void _finishWorkout() async {
    final user = ref.read(currentUserProvider).value;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please log in to save workout")),
      );
      return;
    }

    // Show RPE Summary Bottom Sheet
    double workoutRpe = 5.0; // Default to 5
    
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const BilingualText(
                  english: "Workout Summary",
                  hindi: "कसरत सारांश",
                  englishStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  "Rate your overall effort (RPE): ${workoutRpe.toInt()}",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const Text(
                  "(1: Easy, 10: Maximum Effort)",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Slider(
                  value: workoutRpe,
                  min: 1,
                  max: 10,
                  divisions: 9,
                  activeColor: AppColors.primary,
                  onChanged: (val) {
                    setModalState(() => workoutRpe = val);
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("SAVE WORKOUT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 12),
              ],
            ),
          );
        },
      ),
    );

    if (confirmed != true) return;

    setState(() => _isSaving = true);
    
    try {
      await ref.read(workoutControllerProvider.notifier).saveWorkout(
        exercises: _exercises,
        title: _workoutTitle,
        userId: user.$id,
        rpe: workoutRpe,
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Workout saved successfully! | कसरत सफलतापूर्वक सहेजी गई!")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error saving workout: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BilingualText(
          english: _workoutTitle,
          hindi: "कसरत",
          englishStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _finishWorkout,
            child: const Text("FINISH", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: _exercises.length + 1,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              if (index == _exercises.length) {
                return _buildAddButton();
              }
              return _buildExerciseCard(_exercises[index], index);
            },
          ),
          const Positioned(
            bottom: 0,
            left: 20,
            right: 20,
            child: _RestTimerTray(),
          ),
          const PRCelebrationOverlay(),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return OutlinedButton.icon(
      onPressed: _addExercise,
      icon: const Icon(Icons.add),
      label: const Text("ADD EXERCISE"),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildExerciseCard(ExerciseWithSets item, int exerciseIndex) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(item.exercise.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
                ),
                IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
              ],
            ),
            const SizedBox(height: 12),
            _buildSetHeader(),
            ...item.sets.asMap().entries.map((entry) => _buildSetRow(item, entry.key, exerciseIndex)),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  item.sets.add(ExerciseSet(
                    id: const Uuid().v4(),
                    workoutLogId: '',
                    exerciseId: item.exercise.id,
                    setNumber: item.sets.length + 1,
                    isWarmup: false,
                    isCompleted: false,
                    createdAt: DateTime.now(),
                  ));
                });
              },
              icon: const Icon(Icons.add, size: 18),
              label: const Text("ADD SET"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(width: 30, child: Text("SET", style: TextStyle(fontSize: 12, color: Colors.grey))),
          Expanded(flex: 2, child: Center(child: Text("KG", style: TextStyle(fontSize: 12, color: Colors.grey)))),
          Expanded(flex: 2, child: Center(child: Text("REPS", style: TextStyle(fontSize: 12, color: Colors.grey)))),
          Expanded(flex: 2, child: Center(child: Text("RPE", style: TextStyle(fontSize: 12, color: Colors.grey)))),
          SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildSetRow(ExerciseWithSets item, int setIndex, int exerciseIndex) {
    final set = item.sets[setIndex];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 30, child: Text("${set.setNumber}", style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
            flex: 2,
            child: Container(
              height: 40,
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(border: InputBorder.none, hintText: "0"),
                onChanged: (val) {
                  final weight = double.tryParse(val) ?? 0;
                  setState(() => item.sets[setIndex] = set.copyWith(weight: Value(weight)));
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Container(
              height: 40,
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(border: InputBorder.none, hintText: "0"),
                onChanged: (val) {
                  final reps = int.tryParse(val) ?? 0;
                  setState(() => item.sets[setIndex] = set.copyWith(reps: Value(reps)));
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Container(
              height: 40,
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(border: InputBorder.none, hintText: "0"),
                onChanged: (val) {
                  final rpe = int.tryParse(val) ?? 0;
                  setState(() => item.sets[setIndex] = set.copyWith(rpe: Value(rpe)));
                },
              ),
            ),
          ),
          SizedBox(
            width: 40,
            child: Checkbox(
              value: set.isCompleted,
              onChanged: (val) {
                final isCompleted = val ?? false;
                setState(() => item.sets[setIndex] = set.copyWith(isCompleted: isCompleted));
                if (isCompleted) {
                  ref.read(restTimerProvider.notifier).start(90);
                }
              },
              activeColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

class ExerciseWithSets {
  final Exercise exercise;
  final List<ExerciseSet> sets;
  ExerciseWithSets({required this.exercise, required this.sets});
}

class _ExerciseSearchSheet extends StatelessWidget {
  final List<Exercise> exercises;
  const _ExerciseSearchSheet({required this.exercises});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text("Select Exercise", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              hintText: "Search exercises...",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final ex = exercises[index];
                return ListTile(
                  title: Text(ex.name),
                  subtitle: Text(ex.muscleGroup),
                  onTap: () => Navigator.pop(context, ex),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RestTimerTray extends ConsumerWidget {
  const _RestTimerTray();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(restTimerProvider);
    if (!timer.isActive) return const SizedBox.shrink();

    final minutes = (timer.secondsRemaining / 60).floor();
    final seconds = (timer.secondsRemaining % 60).toString().padLeft(2, '0');
    final progress = timer.secondsRemaining / timer.totalSeconds;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, spreadRadius: 2)],
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 44,
                height: 44,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 4,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
              const Icon(Icons.timer, size: 20, color: AppColors.primary),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("REST TIMER", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                Text("$minutes:$seconds", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.stop_circle, color: Colors.redAccent),
            onPressed: () => ref.read(restTimerProvider.notifier).stop(),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: AppColors.primary),
            onPressed: () => ref.read(restTimerProvider.notifier).start(timer.secondsRemaining + 30),
          ),
        ],
      ),
    );
  }
}
