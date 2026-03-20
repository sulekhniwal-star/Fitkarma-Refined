// lib/features/workout/presentation/workout_complete_screen.dart
// Screen shown during and after workout completion

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:fitkarma/features/workout/data/workout_aw_service.dart';
import 'package:fitkarma/features/workout/data/workout_providers.dart';

class WorkoutCompleteScreen extends ConsumerStatefulWidget {
  final Workout workout;

  const WorkoutCompleteScreen({super.key, required this.workout});

  @override
  ConsumerState<WorkoutCompleteScreen> createState() =>
      _WorkoutCompleteScreenState();
}

class _WorkoutCompleteScreenState extends ConsumerState<WorkoutCompleteScreen> {
  late YoutubePlayerController _controller;
  Timer? _timer;
  int _elapsedSeconds = 0;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.workout.youtubeId,
      flags: const YoutubePlayerFlags(
        hideControls: false,
        controlsVisibleAtStart: true,
        autoPlay: true,
        mute: false,
      ),
    );

    // Start timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _elapsedSeconds++;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _completeWorkout() {
    _timer?.cancel();
    setState(() {
      _isCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rpeValue = ref.watch(rpeValueProvider);

    if (_isCompleted) {
      return _buildCompletionScreen(context, rpeValue);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout.title),
        actions: [
          TextButton.icon(
            onPressed: _completeWorkout,
            icon: const Icon(Icons.check),
            label: const Text('Finish'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Timer
          Container(
            padding: const EdgeInsets.all(24),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.timer, size: 32),
                const SizedBox(width: 12),
                Text(
                  _formatTime(_elapsedSeconds),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // YouTube Player
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                  ),
                ),
              ),
            ),
          ),

          // Workout Info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _InfoItem(
                      icon: Icons.local_fire_department,
                      label: 'Calories',
                      value: '${widget.workout.caloriesPerSession ?? 0}',
                    ),
                    _InfoItem(
                      icon: Icons.timer,
                      label: 'Target',
                      value: '${widget.workout.durationMinutes} min',
                    ),
                    _InfoItem(
                      icon: Icons.category,
                      label: 'Category',
                      value: widget.workout.category,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _completeWorkout,
        icon: const Icon(Icons.check_circle),
        label: const Text('Complete'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildCompletionScreen(BuildContext context, int rpeValue) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Complete! 🎉'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Success icon
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 24),

            // Congratulations text
            Text(
              'Great Job!',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'You completed ${widget.workout.title}',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Stats cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatCard(
                  icon: Icons.timer,
                  label: 'Duration',
                  value: _formatTime(_elapsedSeconds),
                ),
                _StatCard(
                  icon: Icons.local_fire_department,
                  label: 'Calories',
                  value: '${widget.workout.caloriesPerSession ?? 0}',
                ),
              ],
            ),
            const SizedBox(height: 24),

            // RPE Slider
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rate of Perceived Exertion (RPE)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'How hard was this workout? (1 = Easy, 10 = Maximum effort)',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text(
                          '1',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Slider(
                            value: rpeValue.toDouble(),
                            min: 1,
                            max: 10,
                            divisions: 9,
                            label: rpeValue.toString(),
                            onChanged: (value) {
                              ref.read(rpeValueProvider.notifier).state = value
                                  .round();
                            },
                          ),
                        ),
                        const Text(
                          '10',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        'RPE: $rpeValue',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _getRpeColor(rpeValue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // XP earned
            Card(
              color: Colors.amber.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 32),
                    const SizedBox(width: 12),
                    Text(
                      '+20 XP Earned!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Here we would save the workout log
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Save & Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRpeColor(int rpe) {
    if (rpe <= 3) return Colors.green;
    if (rpe <= 6) return Colors.orange;
    return Colors.red;
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(label, style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }
}
