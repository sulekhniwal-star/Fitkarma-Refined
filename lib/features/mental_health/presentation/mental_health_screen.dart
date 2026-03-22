// lib/features/mental_health/presentation/mental_health_screen.dart
// Mental Health Screen - Mood logging, heatmap calendar, voice notes

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fitkarma/features/mental_health/data/mood_providers.dart';
import 'package:fitkarma/features/mental_health/data/burnout_service.dart';
import 'package:fitkarma/features/mental_health/data/cbt_program_service.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';
import 'package:fitkarma/core/storage/drift_service.dart';

class MentalHealthScreen extends ConsumerStatefulWidget {
  const MentalHealthScreen({super.key});

  @override
  ConsumerState<MentalHealthScreen> createState() => _MentalHealthScreenState();
}

class _MentalHealthScreenState extends ConsumerState<MentalHealthScreen> {
  int _selectedMood = 3;
  double _energyLevel = 5;
  double _stressLevel = 5;
  final List<String> _selectedTags = [];
  bool _isLogging = false;
  String? _userId;

  // Burnout and CBT state
  BurnoutAnalysis? _burnoutAnalysis;
  bool _isAnalyzingBurnout = false;
  CbtProgramService? _cbtService;
  List<CbtProgramDay>? _cbtProgram;
  int _currentCbtDay = 1;
  bool _showBurnoutAlert = false;
  bool _showProfessionalHelpPrompt = false;

  // Helpline visibility
  bool _showHelplines = false;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final authService = AuthAwService();
    final userId = await authService.getStoredUserId();
    if (mounted) {
      setState(() {
        _userId = userId;
      });
      // Initialize services after userId is loaded
      if (userId != null) {
        _initializeServices(userId);
      }
    }
  }

  Future<void> _initializeServices(String userId) async {
    // Initialize CBT service
    _cbtService = CbtProgramService();
    _cbtProgram = _cbtService!.getProgram();

    // Analyze burnout
    await _analyzeBurnout(userId);

    // Check for persistent low mood
    await _checkPersistentLowMood(userId);
  }

  Future<void> _analyzeBurnout(String userId) async {
    setState(() => _isAnalyzingBurnout = true);
    try {
      final driftService = ref.read(driftServiceProvider);
      final burnoutService = BurnoutService(driftService.db);
      final analysis = await burnoutService.analyzeBurnout(userId);

      if (mounted) {
        setState(() {
          _burnoutAnalysis = analysis;
          _showBurnoutAlert = analysis.isBurnoutDetected;
          _isAnalyzingBurnout = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isAnalyzingBurnout = false);
      }
    }
  }

  Future<void> _checkPersistentLowMood(String userId) async {
    try {
      final driftService = ref.read(driftServiceProvider);
      final burnoutService = BurnoutService(driftService.db);
      final result = await burnoutService.checkPersistentLowMood(userId);

      if (mounted) {
        setState(() {
          _showProfessionalHelpPrompt = result.hasPersistentLowMood;
        });
      }
    } catch (e) {
      // Silently handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mental Health'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mood Logging Section
            _buildMoodLoggingCard(),
            const SizedBox(height: 24),

            // Voice Note Section
            _buildVoiceNoteCard(),
            const SizedBox(height: 24),

            // Mood Heatmap Calendar
            _buildMoodHeatmapCard(),
            const SizedBox(height: 24),

            // Recent Mood Logs
            _buildRecentMoodsCard(),
            const SizedBox(height: 24),

            // Burnout Detection Alert
            if (_showBurnoutAlert) _buildBurnoutAlertCard(),

            // 14-Day Persistent Low Mood Prompt
            if (_showProfessionalHelpPrompt) _buildProfessionalHelpCard(),
            const SizedBox(height: 24),

            // 7-Day CBT Program
            _buildCbtProgramCard(),
            const SizedBox(height: 24),

            // Indian Helpline Resources
            _buildHelplineResourcesCard(),
          ],
        ),
      ),
    );
  }

  /// Build Burnout Detection Alert Card
  Widget _buildBurnoutAlertCard() {
    if (_burnoutAnalysis == null) return const SizedBox.shrink();

    return Card(
      elevation: 4,
      color: Colors.orange.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orange.shade700,
                  size: 28,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Burnout Detected',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'We noticed patterns suggesting burnout: ${_burnoutAnalysis!.contributingFactors.take(3).join(", ")}',
              style: TextStyle(color: Colors.orange.shade900),
            ),
            const SizedBox(height: 12),
            Text(
              'Score: ${_burnoutAnalysis!.burnoutScore}/100 | Days of low mood: ${_burnoutAnalysis!.consecutiveLowMoodDays}',
              style: TextStyle(color: Colors.orange.shade700, fontSize: 12),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _currentCbtDay = 1;
                });
              },
              icon: const Icon(Icons.self_improvement),
              label: const Text('Start Recovery Program'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build Professional Help Prompt Card (14-day persistent low mood)
  Widget _buildProfessionalHelpCard() {
    return Card(
      elevation: 4,
      color: Colors.red.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.support_agent, color: Colors.red.shade700, size: 28),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'We Want to Help',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'You\'ve been experiencing low mood for a while now. Consider speaking with a mental health professional for additional support.',
              style: TextStyle(color: Colors.red.shade900),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _showHelplines = !_showHelplines;
                    });
                  },
                  icon: const Icon(Icons.phone),
                  label: const Text('View Helplines'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _showProfessionalHelpPrompt = false;
                    });
                  },
                  icon: const Icon(Icons.close),
                  label: const Text('Not Now'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red.shade700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build CBT Program Card
  Widget _buildCbtProgramCard() {
    final program = _cbtProgram;
    if (program == null || program.isEmpty) {
      return Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Icon(Icons.self_improvement, size: 48, color: Colors.teal),
              const SizedBox(height: 8),
              const Text(
                '7-Day Stress Recovery Program',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _isAnalyzingBurnout
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        if (_userId != null) {
                          await _analyzeBurnout(_userId!);
                        }
                      },
                      child: const Text('Check My Wellness'),
                    ),
            ],
          ),
        ),
      );
    }

    final currentDayProgram = program[_currentCbtDay - 1];

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.self_improvement,
                  color: Colors.teal,
                  size: 28,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '7-Day Stress Recovery Program',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Day $_currentCbtDay of 7: ${currentDayProgram.title}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Progress indicator
            LinearProgressIndicator(
              value: _currentCbtDay / 7,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.teal),
            ),
            const SizedBox(height: 16),

            // Day theme
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentDayProgram.theme,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currentDayProgram.description,
                    style: TextStyle(color: Colors.teal.shade700, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Data-driven prompt
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.psychology,
                        color: Colors.blue.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Reflection',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ],
                  ),
                  if (currentDayProgram.prompt.contextFromData != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      currentDayProgram.prompt.contextFromData!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    currentDayProgram.prompt.question,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: currentDayProgram.prompt.suggestedResponses
                        .map(
                          (response) => ActionChip(
                            label: Text(
                              response,
                              style: const TextStyle(fontSize: 11),
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Noted: $response'),
                                  backgroundColor: Colors.teal,
                                ),
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Day navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentCbtDay > 1)
                  OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        _currentCbtDay--;
                      });
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Previous'),
                  )
                else
                  const SizedBox.shrink(),
                ElevatedButton.icon(
                  onPressed: () {
                    // Save progress
                    if (_userId != null && _cbtService != null) {
                      _cbtService!.saveProgress(
                        userId: _userId!,
                        dayNumber: _currentCbtDay,
                        completed: true,
                      );
                    }

                    if (_currentCbtDay < 7) {
                      setState(() {
                        _currentCbtDay++;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Day $_currentCbtDay unlocked!'),
                          backgroundColor: Colors.teal,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            '🎉 Congratulations! You completed the 7-day program!',
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    _currentCbtDay == 7 ? Icons.check : Icons.arrow_forward,
                  ),
                  label: Text(_currentCbtDay == 7 ? 'Complete' : 'Next Day'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build Indian Helpline Resources Card
  Widget _buildHelplineResourcesCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.phone_in_talk, color: Colors.green, size: 28),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Indian Mental Health Helplines',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _showHelplines ? Icons.expand_less : Icons.expand_more,
                  ),
                  onPressed: () {
                    setState(() {
                      _showHelplines = !_showHelplines;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Free, confidential support available 24/7',
              style: TextStyle(color: Colors.grey),
            ),
            if (_showHelplines) ...[
              const SizedBox(height: 16),
              const Divider(),
              ...IndianHelplineResources.allResources.map(
                (resource) => _buildHelplineItem(resource),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHelplineItem(IndianHelplineResources resource) {
    MaterialColor typeColor;
    final resourceType = resource.type;
    if (resourceType == 'crisis') {
      typeColor = Colors.red;
    } else if (resourceType == 'counselling') {
      typeColor = Colors.blue;
    } else {
      typeColor = Colors.green;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  resource.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: typeColor.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: typeColor.shade200),
                ),
                child: Text(
                  resource.type.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: typeColor.shade700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            resource.description,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.phone, size: 16, color: Colors.green.shade700),
              const SizedBox(width: 4),
              Text(
                resource.phoneNumber,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Text(
                resource.hours,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.language, size: 14, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  resource.language,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildMoodLoggingCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.mood, color: Colors.purple),
                const SizedBox(width: 8),
                Text(
                  'How are you feeling?',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '+3 XP',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 5-Emoji Selector
            const Text(
              'Select your mood:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(5, (index) {
                final mood = index + 1;
                final isSelected = _selectedMood == mood;
                return GestureDetector(
                  onTap: () => setState(() => _selectedMood = mood),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.purple.shade200
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? Colors.purple
                            : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          moodEmojis[mood] ?? '😐',
                          style: TextStyle(fontSize: isSelected ? 36 : 28),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          moodLabels[mood] ?? '',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected ? Colors.purple : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            // Energy Level Slider
            _buildSlider(
              label: 'Energy Level',
              value: _energyLevel,
              icon: Icons.bolt,
              color: Colors.orange,
              onChanged: (value) => setState(() => _energyLevel = value),
            ),
            const SizedBox(height: 16),

            // Stress Level Slider
            _buildSlider(
              label: 'Stress Level',
              value: _stressLevel,
              icon: Icons.psychology,
              color: Colors.red,
              onChanged: (value) => setState(() => _stressLevel = value),
            ),
            const SizedBox(height: 24),

            // Tag Chips
            const Text('Tags:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: moodTags.map((tag) {
                final isSelected = _selectedTags.contains(tag);
                return FilterChip(
                  label: Text(tag),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedTags.add(tag);
                      } else {
                        _selectedTags.remove(tag);
                      }
                    });
                  },
                  selectedColor: Colors.purple.shade200,
                  checkmarkColor: Colors.purple,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Log Mood Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLogging ? null : _logMood,
                icon: _isLogging
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.check),
                label: Text(_isLogging ? 'Logging...' : 'Log Mood'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required IconData icon,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                value.round().toString(),
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: 1,
          max: 10,
          divisions: 9,
          activeColor: color,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildVoiceNoteCard() {
    final voiceNoteNotifier = ref.watch(voiceNoteProvider);
    final voiceState = voiceNoteNotifier.voiceNoteState;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.mic, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Voice Note',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Record a voice note (stored locally only)',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Record/Stop Button
                if (voiceState.recordingState == RecordingState.idle)
                  ElevatedButton.icon(
                    onPressed: () => voiceNoteNotifier.startRecording(),
                    icon: const Icon(Icons.mic),
                    label: const Text('Record'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  )
                else
                  ElevatedButton.icon(
                    onPressed: () => voiceNoteNotifier.stopRecording(),
                    icon: const Icon(Icons.stop),
                    label: const Text('Stop'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                    ),
                  ),
                const SizedBox(width: 16),
                // Play Button (if recorded)
                if (voiceState.recordedPath != null &&
                    voiceState.recordingState == RecordingState.idle)
                  ElevatedButton.icon(
                    onPressed: () {
                      if (voiceState.isPlaying) {
                        voiceNoteNotifier.stopPlayback();
                      } else {
                        voiceNoteNotifier.playRecording();
                      }
                    },
                    icon: Icon(
                      voiceState.isPlaying ? Icons.stop : Icons.play_arrow,
                    ),
                    label: Text(voiceState.isPlaying ? 'Stop' : 'Play'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                const SizedBox(width: 16),
                // Clear Button
                if (voiceState.recordedPath != null &&
                    voiceState.recordingState == RecordingState.idle)
                  IconButton(
                    onPressed: () => voiceNoteNotifier.clearRecording(),
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: 'Clear recording',
                  ),
              ],
            ),
            if (voiceState.recordingState == RecordingState.recording)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.fiber_manual_record,
                      color: Colors.red,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Recording... ${_formatDuration(voiceState.recordingDuration)}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            if (voiceState.error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  voiceState.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Widget _buildMoodHeatmapCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_month, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  'Mood Calendar',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Your mood over the last 30 days',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            SizedBox(height: 180, child: _buildMoodHeatmap()),
            const SizedBox(height: 16),
            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem('😢', 1),
                _buildLegendItem('😔', 2),
                _buildLegendItem('😐', 3),
                _buildLegendItem('🙂', 4),
                _buildLegendItem('😄', 5),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodHeatmap() {
    // Generate sample data for the heatmap
    final now = DateTime.now();
    final spots = <FlSpot>[];

    for (int i = 29; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      // Generate random mood for demo (in real app, fetch from database)
      final mood = (date.day % 5) + 1;
      spots.add(FlSpot((29 - i).toDouble(), mood.toDouble()));
    }

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value >= 1 && value <= 5) {
                  return Text(
                    moodEmojis[value.toInt()] ?? '',
                    style: const TextStyle(fontSize: 16),
                  );
                }
                return const Text('');
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 7,
              getTitlesWidget: (value, meta) {
                final date = now.subtract(Duration(days: 29 - value.toInt()));
                return Text(
                  '${date.day}/${date.month}',
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        minY: 0.5,
        maxY: 5.5,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.purple,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                final mood = spot.y.toInt();
                return FlDotCirclePainter(
                  radius: 6,
                  color: _getMoodColor(mood),
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.purple.withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    );
  }

  Color _getMoodColor(int mood) {
    switch (mood) {
      case 1:
        return Colors.red.shade300;
      case 2:
        return Colors.orange.shade300;
      case 3:
        return Colors.grey.shade400;
      case 4:
        return Colors.lightGreen.shade400;
      case 5:
        return Colors.green.shade400;
      default:
        return Colors.grey;
    }
  }

  Widget _buildLegendItem(String emoji, int mood) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 4),
          Text(
            '$mood',
            style: TextStyle(
              fontSize: 12,
              color: _getMoodColor(mood),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentMoodsCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.history, color: Colors.teal),
                const SizedBox(width: 8),
                Text(
                  'Recent Moods',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Your mood history',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            // Sample recent mood entries
            _buildRecentMoodItem(
              emoji: '😄',
              label: 'Great',
              time: '2 hours ago',
              tags: ['Happy', 'Energetic'],
            ),
            const Divider(),
            _buildRecentMoodItem(
              emoji: '🙂',
              label: 'Good',
              time: 'Yesterday',
              tags: ['Calm', 'Grateful'],
            ),
            const Divider(),
            _buildRecentMoodItem(
              emoji: '😐',
              label: 'Neutral',
              time: '2 days ago',
              tags: ['Tired'],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentMoodItem({
    required String emoji,
    required String label,
    required String time,
    required List<String> tags,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 32)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  children: tags
                      .map(
                        (tag) => Chip(
                          label: Text(
                            tag,
                            style: const TextStyle(fontSize: 10),
                          ),
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Future<void> _logMood() async {
    if (_userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to log your mood')),
      );
      return;
    }

    setState(() => _isLogging = true);

    try {
      final moodNotifier = ref.read(moodNotifierProvider);
      final voiceNoteNotifier = ref.read(voiceNoteProvider);

      // Get voice note path if recorded
      String? voiceNotePath;
      if (voiceNoteNotifier.voiceNoteState.recordedPath != null) {
        voiceNotePath = voiceNoteNotifier.voiceNoteState.recordedPath;
      }

      final success = await moodNotifier.logMood(
        userId: _userId!,
        moodScore: _selectedMood,
        energyLevel: _energyLevel.round(),
        stressLevel: _stressLevel.round(),
        tags: _selectedTags.isNotEmpty ? _selectedTags : null,
        voiceNotePath: voiceNotePath,
      );

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Mood logged! +3 XP earned! 🎉'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );

        // Reset form
        setState(() {
          _selectedMood = 3;
          _energyLevel = 5;
          _stressLevel = 5;
          _selectedTags.clear();
        });

        // Clear voice note
        voiceNoteNotifier.clearRecording();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to log mood: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLogging = false);
      }
    }
  }
}
