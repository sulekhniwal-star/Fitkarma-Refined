import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/lifestyle_repository.dart';

class MoodLogScreen extends ConsumerStatefulWidget {
  const MoodLogScreen({super.key});

  @override
  ConsumerState<MoodLogScreen> createState() => _MoodLogScreenState();
}

class _MoodLogScreenState extends ConsumerState<MoodLogScreen> {
  int _mood = 3;
  int _energy = 3;
  int _stress = 3;
  int _screenTimeHours = 2;
  final _tags = <String>[];
  final _notesController = TextEditingController();

  final _availableTags = [
    'Happy', 'Sad', 'Anxious', 'Calm', 'Tired', 'Energetic',
    'Motivated', 'Stressed', 'Relaxed', 'Focused', 'Distracted'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('How are you feeling?', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(5, (index) {
                        final mood = index + 1;
                        return GestureDetector(
                          onTap: () => setState(() => _mood = mood),
                          child: Column(
                            children: [
                              Icon(
                                _getMoodIcon(mood),
                                size: 40,
                                color: _mood == mood ? Colors.amber : Colors.grey,
                              ),
                              Text(_getMoodLabel(mood), style: const TextStyle(fontSize: 10)),
                            ],
                          ),
                        );
                      }),
                    ),
                    const Divider(height: 32),
                    _buildSlider('Energy Level', _energy, (v) => setState(() => _energy = v.toInt())),
                    _buildSlider('Stress Level', _stress, (v) => setState(() => _stress = v.toInt())),
                    const SizedBox(height: 16),
                    _buildSlider('Screen Time', _screenTimeHours, (v) => setState(() => _screenTimeHours = v.toInt()), max: 12, unit: 'hrs'),
                    const SizedBox(height: 16),
                    Text('Tags', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: _availableTags.map((tag) {
                        final selected = _tags.contains(tag);
                        return FilterChip(
                          label: Text(tag),
                          selected: selected,
                          onSelected: (s) {
                            setState(() {
                              if (s) {
                                _tags.add(tag);
                              } else {
                                _tags.remove(tag);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _notesController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Notes (optional)',
                        hintText: 'How was your day?',
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _isSaving ? null : _saveMoodLog,
                        child: _isSaving 
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : const Text('Save'),
                      ),
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

  Widget _buildSlider(String label, int value, ValueChanged<double> onChanged, {double max = 10, String unit = '/10'}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
            Text('$value$unit'),
          ],
        ),
        Slider(
          value: value.toDouble(), 
          min: 0, 
          max: max, 
          divisions: max.toInt() == 0 ? 1 : max.toInt(), 
          onChanged: onChanged,
        ),
      ],
    );
  }

  IconData _getMoodIcon(int mood) {
    switch (mood) {
      case 1: return Icons.sentiment_very_dissatisfied;
      case 2: return Icons.sentiment_dissatisfied;
      case 3: return Icons.sentiment_neutral;
      case 4: return Icons.sentiment_satisfied;
      case 5: return Icons.sentiment_very_satisfied;
      default: return Icons.sentiment_neutral;
    }
  }

  String _getMoodLabel(int mood) {
    switch (mood) {
      case 1: return 'Very Bad';
      case 2: return 'Bad';
      case 3: return 'Okay';
      case 4: return 'Good';
      case 5: return 'Great';
      default: return 'Okay';
    }
  }

  Future<void> _saveMoodLog() async {
    setState(() => _isSaving = true);
    try {
      final repo = ref.read(lifestyleRepositoryProvider.notifier);
      await repo.saveMoodLog(
        score: _mood,
        energyLevel: _energy,
        stressLevel: _stress,
        screenTimeMin: _screenTimeHours * 60,
        tags: _tags.isNotEmpty ? _tags : null,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mood logged! +5 XP')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      setState(() => _isSaving = false);
    }
  }

  bool _isSaving = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}