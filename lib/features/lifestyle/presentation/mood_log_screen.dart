import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoodLogScreen extends ConsumerStatefulWidget {
  const MoodLogScreen({super.key});

  @override
  ConsumerState<MoodLogScreen> createState() => _MoodLogScreenState();
}

class _MoodLogScreenState extends ConsumerState<MoodLogScreen> {
  int _mood = 3;
  int _energy = 3;
  int _stress = 3;
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
                              if (s) _tags.add(tag);
                              else _tags.remove(tag);
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
                        onPressed: _saveMoodLog,
                        child: const Text('Save'),
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

  Widget _buildSlider(String label, int value, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text('$value/10'),
          ],
        ),
        Slider(value: value.toDouble(), min: 1, max: 10, divisions: 9, onChanged: onChanged),
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mood logged! +3 XP')),
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}