import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/wedding_logic.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/bilingual_text.dart';

class WeddingFitnessPlanScreen extends ConsumerWidget {
  final WeddingRole role;
  final WeddingPrimaryGoal goal;

  const WeddingFitnessPlanScreen({
    super.key,
    required this.role,
    required this.goal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wedding Fitness Plan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _HeroSection(role: role, goal: goal),
            const SizedBox(height: 24),
            const BilingualText(
              english: 'Weekly Plan',
              hindi: 'साप्ताहिक योजना',
              englishStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildPlanCard(
              day: 'MON/WED/FRI', 
              title: 'Tone & Sweat (HIIT)', 
              icon: Icons.flash_on, 
              color: Colors.orange,
            ),
            _buildPlanCard(
              day: 'TUE/THU', 
              title: 'Glow Yoga & Prep', 
              icon: Icons.self_improvement, 
              color: AppColors.teal,
            ),
            _buildPlanCard(
              day: 'SAT', 
              title: 'Sangeet Dance Practice', 
              icon: Icons.music_note, 
              color: Colors.purple,
            ),
            _buildPlanCard(
              day: 'SUN', 
              title: 'Active Recovery', 
              icon: Icons.spa, 
              color: Colors.green,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Navigate to the main workout list with filtered results
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: AppColors.secondary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('EXPLORE RECOMMENDED WORKOUTS'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({required String day, required String title, required IconData icon, required Color color}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(day, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)),
        subtitle: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final WeddingRole role;
  final WeddingPrimaryGoal goal;
  const _HeroSection({required this.role, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD4AF37), Color(0xFFFFD700)], // Gold gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(Icons.fitness_center, color: Colors.white, size: 48),
          const SizedBox(height: 16),
          Text(
            'Transformation for the ${role.name.toUpperCase()}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            'Goal: ${goal.name.replaceAll(RegExp(r'(?=[A-Z])'), ' ')}',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
