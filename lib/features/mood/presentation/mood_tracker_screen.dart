import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fitkarma/core/theme/app_colors.dart';
import 'package:fitkarma/core/theme/app_text_styles.dart';
import '../data/mood_drift_service.dart';
import '../../../core/di/providers.dart';

final moodDriftServiceProvider = Provider<MoodDriftService>((ref) {
  final db = ref.watch(driftDbProvider);
  return MoodDriftService(db);
});

class MoodTrackerScreen extends ConsumerStatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  ConsumerState<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends ConsumerState<MoodTrackerScreen> {
  int _selectedMood = 3; // 1-5
  double _energy = 5.0;
  double _stress = 2.0;
  final List<String> _selectedTags = [];

  final List<String> _availableTags = [
    'Anxious', 'Calm', 'Focused', 'Tired', 'Motivated', 'Irritable', 'Inspired', 'Stressed'
  ];

  Future<void> _saveMood() async {
    await ref.read(moodDriftServiceProvider).insertMoodLog(
      userId: 'current_user',
      score: _selectedMood,
      energy: _energy.toInt(),
      stress: _stress.toInt(),
      tags: _selectedTags,
    );
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mood recorded successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.background : AppColors.background,
      appBar: AppBar(title: const Text('Mood Tracker')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('How are you feeling?', style: AppTextStyles.h2(isDark)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(5, (index) {
                final score = index + 1;
                final isSelected = _selectedMood == score;
                return GestureDetector(
                  onTap: () => setState(() => _selectedMood = score),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
                      shape: BoxShape.circle,
                      border: isSelected ? Border.all(color: AppColors.primary, width: 2) : null,
                    ),
                    child: Text(_getMoodEmoji(score), style: const TextStyle(fontSize: 40)),
                  ),
                );
              }),
            ),
            const SizedBox(height: 48),
            
            _buildSliderSection('Energy Level', _energy, (val) => setState(() => _energy = val), isDark, Icons.bolt),
            const SizedBox(height: 32),
            _buildSliderSection('Stress Level', _stress, (val) => setState(() => _stress = val), isDark, Icons.psychology),
            
            const SizedBox(height: 48),
            Text('Mood Tags', style: AppTextStyles.labelLarge(isDark)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableTags.map((tag) {
                final isSelected = _selectedTags.contains(tag);
                return FilterChip(
                  label: Text(tag),
                  selected: isSelected,
                  onSelected: (val) {
                    setState(() {
                      if (val) {
                        _selectedTags.add(tag);
                      } else {
                        _selectedTags.remove(tag);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 64),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _saveMood,
                icon: const Icon(Icons.check),
                label: const Text('Log Daily Mood'),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.mic, size: 16),
                label: const Text('Record Private Voice Note'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderSection(String title, double value, ValueChanged<double> onChanged, bool isDark, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [Icon(icon, size: 16, color: isDark ? Colors.white54 : Colors.black54), const SizedBox(width: 8), Text(title)]),
            Text(value.toInt().toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        Slider(
          value: value,
          min: 1,
          max: 10,
          divisions: 9,
          activeColor: AppColors.primary,
          onChanged: onChanged,
        ),
      ],
    );
  }

  String _getMoodEmoji(int score) {
    switch (score) {
      case 1: return '😫';
      case 2: return '🙁';
      case 3: return '😐';
      case 4: return '🙂';
      case 5: return '🤩';
      default: return '😐';
    }
  }
}

