// lib/features/workout/presentation/custom_workout_builder_screen.dart
// Screen for creating custom workouts

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/workout/data/workout_providers.dart';

class CustomWorkoutBuilderScreen extends ConsumerStatefulWidget {
  const CustomWorkoutBuilderScreen({super.key});

  @override
  ConsumerState<CustomWorkoutBuilderScreen> createState() =>
      _CustomWorkoutBuilderScreenState();
}

class _CustomWorkoutBuilderScreenState
    extends ConsumerState<CustomWorkoutBuilderScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = 'Strength';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final builderState = ref.watch(customWorkoutBuilderProvider);
    final categories = [
      'Yoga',
      'HIIT',
      'Strength',
      'Dance',
      'Bollywood',
      'Pranayama',
      'Custom',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Custom Workout'),
        actions: [
          TextButton(
            onPressed: builderState.exercises.isNotEmpty
                ? () {
                    // Save workout
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Workout saved!')),
                    );
                    Navigator.pop(context);
                  }
                : null,
            child: const Text('Save'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Workout Title',
                hintText: 'e.g., Morning Strength Routine',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                ref.read(customWorkoutBuilderProvider.notifier).setTitle(value);
              },
            ),
            const SizedBox(height: 16),

            // Description
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                hintText: 'Describe your workout...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: (value) {
                ref
                    .read(customWorkoutBuilderProvider.notifier)
                    .setDescription(value);
              },
            ),
            const SizedBox(height: 16),

            // Category
            const Text(
              'Category',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: categories.map((cat) {
                final isSelected = _selectedCategory == cat;
                return ChoiceChip(
                  label: Text(cat),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = cat;
                    });
                    ref
                        .read(customWorkoutBuilderProvider.notifier)
                        .setCategory(cat);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Exercises section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Exercises',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _showAddExerciseDialog(context);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Exercise'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Exercise list
            if (builderState.exercises.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.fitness_center,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'No exercises added yet',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tap "Add Exercise" to build your workout',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              ReorderableListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: builderState.exercises.length,
                itemBuilder: (context, index) {
                  final exercise = builderState.exercises[index];
                  return Card(
                    key: ValueKey(exercise.id),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(exercise.name),
                      subtitle: Text(
                        '${exercise.sets} sets × ${exercise.reps ?? exercise.durationSec ?? 0} ${exercise.reps != null ? 'reps' : 'sec'}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.timer),
                            tooltip: 'Rest: ${exercise.restTimeSec}s',
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              ref
                                  .read(customWorkoutBuilderProvider.notifier)
                                  .removeExercise(exercise.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                onReorder: (oldIndex, newIndex) {
                  ref
                      .read(customWorkoutBuilderProvider.notifier)
                      .reorderExercises(oldIndex, newIndex);
                },
              ),

            const SizedBox(height: 24),

            // Summary card
            if (builderState.exercises.isNotEmpty)
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'Workout Summary',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _SummaryItem(
                            label: 'Exercises',
                            value: '${builderState.exercises.length}',
                          ),
                          _SummaryItem(
                            label: 'Total Sets',
                            value: '${builderState.totalSets}',
                          ),
                          _SummaryItem(
                            label: 'Est. Rest',
                            value: '${builderState.estimatedTotalRestTime}s',
                          ),
                        ],
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

  void _showAddExerciseDialog(BuildContext context) {
    final nameController = TextEditingController();
    final setsController = TextEditingController(text: '3');
    final repsController = TextEditingController(text: '12');
    final durationController = TextEditingController();
    final restController = TextEditingController(text: '60');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Exercise'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Exercise Name',
                  hintText: 'e.g., Push-ups',
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: setsController,
                      decoration: const InputDecoration(labelText: 'Sets'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: repsController,
                      decoration: const InputDecoration(labelText: 'Reps'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: durationController,
                decoration: const InputDecoration(
                  labelText: 'Duration (seconds)',
                  hintText: 'For timed exercises',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: restController,
                decoration: const InputDecoration(
                  labelText: 'Rest between sets (seconds)',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isEmpty) return;

              final newExercise = CustomExercise(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: nameController.text,
                sets: int.tryParse(setsController.text) ?? 3,
                reps: repsController.text.isNotEmpty
                    ? int.tryParse(repsController.text)
                    : null,
                durationSec: durationController.text.isNotEmpty
                    ? int.tryParse(durationController.text)
                    : null,
                restTimeSec: int.tryParse(restController.text) ?? 60,
                orderIndex: ref
                    .read(customWorkoutBuilderProvider)
                    .exercises
                    .length,
              );

              ref
                  .read(customWorkoutBuilderProvider.notifier)
                  .addExercise(newExercise);

              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
        ),
      ],
    );
  }
}
