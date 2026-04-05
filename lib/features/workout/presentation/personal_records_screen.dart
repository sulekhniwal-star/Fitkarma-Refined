import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/bilingual_text.dart';
import '../../../core/storage/app_database.dart';
import '../../auth/data/auth_repository.dart';
import '../data/workout_controller.dart';

class PersonalRecordsScreen extends ConsumerWidget {
  const PersonalRecordsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider).value;
    if (user == null) {
      return const Scaffold(body: Center(child: Text("Please log in")));
    }

    final prStream = ref.watch(workoutControllerProvider.notifier).watchUserPRs(user.$id);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const BilingualText(
          english: "Personal Records",
          hindi: "व्यक्तिगत रिकॉर्ड",
          englishStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: StreamBuilder<List<PersonalRecord>>(
        stream: prStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildEmptyState();
          }

          final prs = snapshot.data!;
          // Group by exercise name to show only the best one in the main list, 
          // or show all history? Let's show best one with an option to see history.
          final Map<String, PersonalRecord> bestPRs = {};
          for (final pr in prs) {
            final current = bestPRs[pr.exerciseName];
            if (current == null || pr.value > current.value) {
              bestPRs[pr.exerciseName] = pr;
            }
          }

          final sortedExercises = bestPRs.keys.toList()..sort();

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: sortedExercises.length,
            itemBuilder: (context, index) {
              final exerciseName = sortedExercises[index];
              final pr = bestPRs[exerciseName]!;
              return _PRCard(pr: pr);
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.emoji_events_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 20),
          const BilingualText(
            english: "No records yet",
            hindi: "अभी तक कोई रिकॉर्ड नहीं",
            englishStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          const Text(
            "Complete a workout to set your first PR! 🏋️‍♂️",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _PRCard extends StatelessWidget {
  final PersonalRecord pr;
  const _PRCard({required this.pr});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 6,
                color: AppColors.primary,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              pr.exerciseName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          const Icon(Icons.stars, color: Colors.orangeAccent, size: 24),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildMetric(
                            context, 
                            label: "WEIGHT · वजन", 
                            value: "${pr.value} ${pr.unit}",
                            icon: Icons.fitness_center,
                          ),
                          const SizedBox(width: 24),
                          _buildMetric(
                            context, 
                            label: "REPS · अंतराल", 
                            value: "${pr.reps ?? 0}",
                            icon: Icons.repeat,
                          ),
                        ],
                      ),
                      const Divider(height: 32),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat('MMM dd, yyyy').format(pr.achievedAt),
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
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
      ),
    );
  }

  Widget _buildMetric(BuildContext context, {required String label, required String value, required IconData icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey[400]),
            const SizedBox(width: 6),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ],
        ),
      ],
    );
  }
}
