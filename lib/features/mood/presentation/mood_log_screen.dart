import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class MoodLoggingState {
  final int mood;
  final int energy;
  final int stress;
  final List<String> tags;
  final String? voiceNotePath;
  final bool isRecording;
  final bool isLoading;
  final String? error;
  final bool logged;

  MoodLoggingState({
    this.mood = 3,
    this.energy = 3,
    this.stress = 3,
    this.tags = const [],
    this.voiceNotePath,
    this.isRecording = false,
    this.isLoading = false,
    this.error,
    this.logged = false,
  });

  MoodLoggingState copyWith({
    int? mood,
    int? energy,
    int? stress,
    List<String>? tags,
    String? voiceNotePath,
    bool? isRecording,
    bool? isLoading,
    String? error,
    bool? logged,
  }) {
    return MoodLoggingState(
      mood: mood ?? this.mood,
      energy: energy ?? this.energy,
      stress: stress ?? this.stress,
      tags: tags ?? this.tags,
      voiceNotePath: voiceNotePath,
      isRecording: isRecording ?? this.isRecording,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      logged: logged ?? this.logged,
    );
  }
}

class MoodLoggingNotifier extends Notifier<MoodLoggingState> {
  @override
  MoodLoggingState build() => MoodLoggingState();

  void setMood(int v) => state = state.copyWith(mood: v);
  void setEnergy(int v) => state = state.copyWith(energy: v);
  void setStress(int v) => state = state.copyWith(stress: v);
  void toggleTag(String tag) {
    final tags = List<String>.from(state.tags);
    if (tags.contains(tag)) {
      tags.remove(tag);
    } else {
      tags.add(tag);
    }
    state = state.copyWith(tags: tags);
  }

  void setRecording(bool v) => state = state.copyWith(isRecording: v);
  void setVoiceNotePath(String? v) => state = state.copyWith(voiceNotePath: v);

  Future<void> saveVoiceNote(String userId) async {
    final dir = await getApplicationDocumentsDirectory();
    final voiceDir = Directory('${dir.path}/voice_memos');
    if (!await voiceDir.exists()) await voiceDir.create(recursive: true);
    
    final path = '${voiceDir.path}/${DateTime.now().millisecondsSinceEpoch}.m4a';
    state = state.copyWith(voiceNotePath: path);
  }

  Future<void> saveLog(String userId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final db = ref.read(appDatabaseProvider);
      await db.moodLogsDao.insertLogWithKarma(
        userId: userId,
        moodScore: state.mood,
        energy: state.energy,
        stress: state.stress,
        tags: state.tags.isEmpty ? null : state.tags.join(','),
        voiceNotePath: state.voiceNotePath,
      );
      state = state.copyWith(isLoading: false, logged: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() => state = MoodLoggingState();
}

final moodLoggingProvider = NotifierProvider<MoodLoggingNotifier, MoodLoggingState>(MoodLoggingNotifier.new);

class MoodLogScreen extends ConsumerStatefulWidget {
  final String userId;

  const MoodLogScreen({super.key, required this.userId});

  @override
  ConsumerState<MoodLogScreen> createState() => _MoodLogScreenState();
}

class _MoodLogScreenState extends ConsumerState<MoodLogScreen> {
  static const _emojis = ['😢', '😔', '😐', '🙂', '😊'];
  static const _moodLabels = ['Very Low', 'Low', 'Neutral', 'Good', 'Great'];
  static const _availableTags = ['Work', 'Family', 'Health', 'Exercise', 'Social', 'Weather', 'News', 'Finance'];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(moodLoggingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood'),
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildMoodSelector(state),
              const SizedBox(height: 24),
              _buildEnergySlider(state),
              const SizedBox(height: 16),
              _buildStressSlider(state),
              const SizedBox(height: 24),
              _buildTagsSelector(state),
              const SizedBox(height: 24),
              _buildVoiceNote(state),
              const SizedBox(height: 32),
              _buildSaveButton(state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodSelector(MoodLoggingState state) {
    return Column(
      children: [
        const Text('How are you feeling?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(5, (i) {
            final isSelected = state.mood == i + 1;
            return GestureDetector(
              onTap: () => ref.read(moodLoggingProvider.notifier).setMood(i + 1),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary.withValues(alpha: 0.2) : null,
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected ? Border.all(color: AppColors.primary, width: 2) : null,
                    ),
                    child: Text(_emojis[i], style: const TextStyle(fontSize: 32)),
                  ),
                  const SizedBox(height: 4),
                  Text(_moodLabels[i], style: TextStyle(fontSize: 10, color: isSelected ? AppColors.primary : Colors.grey)),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildEnergySlider(MoodLoggingState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Energy: ${state.energy}/5', style: const TextStyle(fontWeight: FontWeight.w600)),
        Slider(
          value: state.energy.toDouble(),
          min: 1, max: 5, divisions: 4,
          onChanged: (v) => ref.read(moodLoggingProvider.notifier).setEnergy(v.toInt()),
        ),
      ],
    );
  }

  Widget _buildStressSlider(MoodLoggingState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Stress: ${state.stress}/5', style: const TextStyle(fontWeight: FontWeight.w600)),
        Slider(
          value: state.stress.toDouble(),
          min: 1, max: 5, divisions: 4,
          onChanged: (v) => ref.read(moodLoggingProvider.notifier).setStress(v.toInt()),
        ),
      ],
    );
  }

  Widget _buildTagsSelector(MoodLoggingState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tags (optional)', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8, runSpacing: 8,
          children: _availableTags.map((tag) {
            final isSelected = state.tags.contains(tag);
            return FilterChip(
              label: Text(tag),
              selected: isSelected,
              onSelected: (_) => ref.read(moodLoggingProvider.notifier).toggleTag(tag),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildVoiceNote(MoodLoggingState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Voice Note (optional)', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.lightSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.mic, color: Colors.red),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  state.voiceNotePath != null
                      ? 'Voice note recorded (stored locally)'
                      : 'Tap to record',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
              if (state.isRecording)
                const SizedBox(
                  width: 20, height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(MoodLoggingState state) {
    return ElevatedButton(
      onPressed: state.isLoading ? null : () async {
        await ref.read(moodLoggingProvider.notifier).saveLog(widget.userId);
        if (mounted && ref.read(moodLoggingProvider).logged) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Mood logged! +3 XP'), backgroundColor: Colors.green),
          );
          context.pop();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: state.isLoading
          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
          : const Text('Save', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}