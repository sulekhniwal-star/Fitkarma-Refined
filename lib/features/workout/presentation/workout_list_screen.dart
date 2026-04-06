import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/workout_providers.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/bilingual_text.dart';
import '../../../shared/widgets/workout_card.dart';

class WorkoutListScreen extends ConsumerStatefulWidget {
  const WorkoutListScreen({super.key});

  @override
  ConsumerState<WorkoutListScreen> createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends ConsumerState<WorkoutListScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All', 'Yoga', 'HIIT', 'Strength', 'Cardio', 'Dance', 'Bollywood', 'Pranayama'
  ];

  @override
  void initState() {
    super.initState();
    // Seed workouts for demo if needed
    Future.microtask(() => ref.read(workoutRepositoryProvider).seedWorkouts());
  }

  @override
  Widget build(BuildContext context) {
    final workoutsAsync = ref.watch(workoutListProvider(_selectedCategory == 'All' ? '' : _selectedCategory));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const BilingualText(
          english: "Workouts",
          hindi: "व्यायाम",
          englishStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: AppColors.primary),
            onPressed: () => context.push('/workout/log'),
          ),
          IconButton(
            icon: const Icon(Icons.emoji_events_outlined, color: AppColors.primary),
            onPressed: () => context.push('/workout/prs'),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Featured Workout Header
          SliverToBoxAdapter(
            child: _buildFeaturedWorkout(),
          ),
          
          // Category Filter
          SliverToBoxAdapter(
            child: _buildCategoryList(),
          ),

          // Workout Grid
          workoutsAsync.when(
            data: (workouts) => SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final workout = workouts[index];
                    return WorkoutCard(
                      title: workout.title,
                      duration: '${workout.durationMin} min',
                      difficulty: workout.difficulty,
                      isPremium: workout.isPremium,
                      imageUrl: workout.thumbnailUrl,
                      onTap: () {
                        // For now, navigated to log screen as a placeholder for detail
                        context.push('/workout/${workout.id}');
                      },
                    );
                  },
                  childCount: workouts.length,
                ),
              ),
            ),
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) => SliverFillRemaining(
              child: Center(child: Text('Error: $err')),
            ),
          ),
          
          // Bottom clearance for FAB
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/workout/log'),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("LOG REPS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildFeaturedWorkout() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1518611012118-29615638a44d'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "TODAY'S PICK · आज की पसंद",
              style: TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Full Body Mobility Flow",
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildInfoTag(Icons.timer_outlined, "20 MIN"),
                const SizedBox(width: 12),
                _buildInfoTag(Icons.auto_awesome_outlined, "BEGINNER"),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("START", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTag(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.white70),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedCategory == _categories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(_categories[index]),
              selected: isSelected,
              onSelected: (val) {
                if (val) setState(() => _selectedCategory = _categories[index]);
              },
              selectedColor: AppColors.primary.withOpacity(0.15),
              labelStyle: TextStyle(
                color: isSelected ? AppColors.primary : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? AppColors.primary : Colors.grey[300]!,
                  width: isSelected ? 1.5 : 1,
                ),
              ),
              showCheckmark: false,
            ),
          );
        },
      ),
    );
  }
}
