// lib/features/workout/presentation/workout_detail_screen.dart
// Detailed view of a workout with YouTube player

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:fitkarma/features/workout/data/workout_aw_service.dart';
import 'package:fitkarma/features/workout/data/workout_providers.dart';
import 'package:fitkarma/features/workout/presentation/workout_complete_screen.dart';

class WorkoutDetailScreen extends ConsumerStatefulWidget {
  final String workoutId;

  const WorkoutDetailScreen({super.key, required this.workoutId});

  @override
  ConsumerState<WorkoutDetailScreen> createState() =>
      _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends ConsumerState<WorkoutDetailScreen> {
  YoutubePlayerController? _youtubeController;
  bool _isPlayerReady = false;

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  void _initializePlayer(String youtubeId) {
    _youtubeController = YoutubePlayerController(
      initialVideoId: youtubeId,
      flags: const YoutubePlayerFlags(
        hideControls: false,
        controlsVisibleAtStart: true,
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final workoutAsync = ref.watch(workoutByIdProvider(widget.workoutId));

    return Scaffold(
      body: workoutAsync.when(
        data: (workout) {
          if (workout == null) {
            return const Center(child: Text('Workout not found'));
          }

          // Initialize player if not already initialized
          _youtubeController ??= YoutubePlayerController(
            initialVideoId: workout.youtubeId,
            flags: const YoutubePlayerFlags(
              hideControls: false,
              controlsVisibleAtStart: true,
              autoPlay: false,
            ),
          );

          return CustomScrollView(
            slivers: [
              // App Bar with Thumbnail
              SliverAppBar(
                expandedHeight: 220,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: workout.thumbnailUrl != null
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: workout.thumbnailUrl!,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.play_circle_fill,
                                  size: 64,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _youtubeController!.play();
                                },
                              ),
                            ),
                          ],
                        )
                      : Container(
                          color: Colors.grey.shade300,
                          child: const Icon(
                            Icons.fitness_center,
                            size: 64,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        workout.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Meta info row
                      Row(
                        children: [
                          _InfoChip(
                            icon: Icons.timer,
                            label: '${workout.durationMinutes} min',
                          ),
                          const SizedBox(width: 8),
                          _DifficultyChip(difficulty: workout.difficulty),
                          const SizedBox(width: 8),
                          _InfoChip(
                            icon: Icons.local_fire_department,
                            label: '${workout.caloriesPerSession ?? 0} cal',
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Category
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          workout.category,
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Description
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        workout.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // YouTube Player
                      const Text(
                        'Preview',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: YoutubePlayer(
                            controller: _youtubeController!,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 100), // Space for FAB
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: workoutAsync.whenOrNull(
        data: (workout) => workout != null
            ? FloatingActionButton.extended(
                onPressed: () {
                  // Start workout
                  ref
                      .read(workoutSessionProvider.notifier)
                      .state = WorkoutSessionState(
                    currentWorkout: workout,
                    startTime: DateTime.now(),
                    isActive: true,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WorkoutCompleteScreen(workout: workout),
                    ),
                  );
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Workout'),
                backgroundColor: Theme.of(context).colorScheme.primary,
              )
            : null,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade700),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _DifficultyChip extends StatelessWidget {
  final String difficulty;

  const _DifficultyChip({required this.difficulty});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        color = Colors.green;
        break;
      case 'intermediate':
        color = Colors.orange;
        break;
      case 'advanced':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        difficulty.substring(0, 1).toUpperCase() + difficulty.substring(1),
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
