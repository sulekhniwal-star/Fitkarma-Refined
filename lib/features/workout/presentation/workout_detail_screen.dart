import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../data/workout_providers.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/bilingual_text.dart';

class WorkoutDetailScreen extends ConsumerStatefulWidget {
  final String id;
  const WorkoutDetailScreen({super.key, required this.id});

  @override
  ConsumerState<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends ConsumerState<WorkoutDetailScreen> {
  YoutubePlayerController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _initYoutube(String youtubeId) {
    if (_controller != null) return;
    _controller = YoutubePlayerController(
      initialVideoId: youtubeId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final workoutAsync = ref.watch(workoutDetailProvider(widget.id));

    return workoutAsync.when(
      data: (workout) {
        if (workout == null) {
          return const Scaffold(body: Center(child: Text("Workout not found")));
        }

        if (workout.youtubeId != null) {
          _initYoutube(workout.youtubeId!);
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(workout.title),
          ),
          body: Column(
            children: [
              // Video or Thumbnail
              if (_controller != null)
                YoutubePlayer(
                  controller: _controller!,
                  showVideoProgressIndicator: true,
                )
              else if (workout.thumbnailUrl != null)
                Image.network(
                  workout.thumbnailUrl!,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              else
                Container(
                  height: 220,
                  color: Colors.grey[200],
                  child: const Icon(Icons.fitness_center, size: 80, color: Colors.grey),
                ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _buildBadge(workout.difficulty, _getDifficultyColor(workout.difficulty)),
                          const SizedBox(width: 12),
                          _buildBadge("${workout.durationMin} MIN", Colors.blueGrey),
                          if (workout.isPremium) ...[
                            const SizedBox(width: 12),
                            _buildBadge("PREMIUM", Colors.amber),
                          ],
                        ],
                      ),
                      const SizedBox(height: 20),
                      BilingualText(
                        english: workout.title,
                        hindi: "व्यायाम विवरण", // Placeholder or dynamic if exists
                        englishStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "This is a ${workout.category} workout designed to build ${workout.category.toLowerCase()} and endurance. Follow the video instructions for proper form.",
                        style: TextStyle(color: Colors.grey[700], height: 1.5),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          // Start workout logic
                          context.push('/workout/log');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          minimumSize: const Size.fromHeight(56),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text(
                          "START WORKOUT · व्यायाम शुरू करें",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text("Error: $err"))),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  Color _getDifficultyColor(String level) {
    switch (level.toLowerCase()) {
      case 'beginner': return Colors.green;
      case 'intermediate': return Colors.orange;
      case 'advanced': return Colors.red;
      default: return Colors.blue;
    }
  }
}
