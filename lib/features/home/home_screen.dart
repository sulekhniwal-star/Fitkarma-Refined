import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/home/data/dashboard_providers.dart';
import 'package:fitkarma/features/karma/karma_screen.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/widgets/activity_rings.dart';
import 'package:fitkarma/shared/widgets/insight_card.dart';
import 'package:fitkarma/shared/widgets/quick_log_fab.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool _synced = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _triggerBackgroundSync());
  }

  Future<void> _triggerBackgroundSync() async {
    if (_synced) return;
    _synced = true;
    Future.delayed(const Duration(seconds: 1), () {
      ref.invalidate(dashboardDataProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardAsync = ref.watch(dashboardDataProvider);

    return Scaffold(
      body: dashboardAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
        data: (data) => _DashboardContent(data: data),
      ),
      floatingActionButton: const QuickLogFab(),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final DashboardData data;

  const _DashboardContent({required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(() => Navigator.push(context, MaterialPageRoute(builder: (_) => const KarmaHubScreen()))),
        SliverToBoxAdapter(child: _buildActivityRings()),
        SliverToBoxAdapter(child: _buildInsightCard()),
        SliverToBoxAdapter(child: _buildMealsSection()),
        SliverToBoxAdapter(child: _buildQuickStats()),
        const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
      ],
    );
  }

  Widget _buildAppBar(VoidCallback onKarmaTap) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
        title: Text(
          'Namaste, ${data.userName.split(' ').first} 🙏',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: onKarmaTap,
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, color: Color(0xFFFFD700), size: 18),
                const SizedBox(width: 4),
                Text(
                  '${data.totalKarma} XP',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityRings() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            height: 140,
            child: ActivityRings(
              stepsProgress: data.stepsProgress,
              caloriesProgress: data.caloriesProgress,
              sleepProgress: data.sleepProgress,
              moodProgress: 0.7,
              size: 140,
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              children: [
                _RingLabel(
                  icon: Icons.directions_walk,
                  label: 'Steps',
                  value: '${data.todaySteps}',
                  goal: '${data.stepsGoal.toInt()}',
                  color: const Color(0xFFFF9500),
                ),
                const SizedBox(height: 12),
                _RingLabel(
                  icon: Icons.local_fire_department,
                  label: 'Calories',
                  value: '${data.todayCalories.toInt()}',
                  goal: '${data.caloriesGoal.toInt()}',
                  color: const Color(0xFF2ECC71),
                ),
                const SizedBox(height: 12),
                _RingLabel(
                  icon: Icons.bedtime,
                  label: 'Sleep',
                  value: '${(data.todaySleepMin / 60).toStringAsFixed(1)}h',
                  goal: '${(data.sleepGoal / 60).toInt()}h',
                  color: const Color(0xFF1ABC9C),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard() {
    return const InsightCard(
      title: 'Health Tip',
      body: 'Great job logging your meals! Keep maintaining this consistency for better results.',
    );
  }

  Widget _buildMealsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Meals",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _MealCard(
            title: 'Breakfast',
            icon: Icons.free_breakfast,
            items: data.breakfast,
            color: const Color(0xFFFF9500),
            isHighlighted: data.breakfast.isNotEmpty,
          ),
          const SizedBox(height: 8),
          _MealCard(
            title: 'Lunch',
            icon: Icons.lunch_dining,
            items: data.lunch,
            color: const Color(0xFF2ECC71),
            isHighlighted: data.lunch.isNotEmpty,
          ),
          const SizedBox(height: 8),
          _MealCard(
            title: 'Dinner',
            icon: Icons.dinner_dining,
            items: data.dinner,
            color: const Color(0xFF9B59B6),
            isHighlighted: data.dinner.isNotEmpty,
          ),
          const SizedBox(height: 8),
          _MealCard(
            title: 'Snacks',
            icon: Icons.cookie,
            items: data.snacks,
            color: const Color(0xFF3498DB),
            isHighlighted: data.snacks.isNotEmpty,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              title: 'Workout',
              value: '${data.totalWorkoutMinutes}',
              unit: 'min',
              icon: Icons.fitness_center,
              color: const Color(0xFFE74C3C),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatCard(
              title: 'Sleep',
              value: (data.todaySleepMin / 60).toStringAsFixed(1),
              unit: 'hrs',
              icon: Icons.bedtime,
              color: const Color(0xFF9B59B6),
            ),
          ),
        ],
      ),
    );
  }
}

class _RingLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String goal;
  final Color color;

  const _RingLabel({
    required this.icon,
    required this.label,
    required this.value,
    required this.goal,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(
              '$value / $goal',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}

class _MealCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List items;
  final Color color;
  final bool isHighlighted;

  const _MealCard({
    required this.title,
    required this.icon,
    required this.items,
    required this.color,
    required this.isHighlighted,
  });

  @override
  Widget build(BuildContext context) {
    double calories = 0;
    for (final item in items) {
      calories += (item as dynamic).calories as double;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isHighlighted ? color.withValues(alpha: 0.1) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighlighted ? color : Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  isHighlighted
                      ? '${items.length} items logged'
                      : 'Tap to log',
                  style: TextStyle(
                    fontSize: 12,
                    color: isHighlighted ? color : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${calories.toInt()} kcal',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isHighlighted ? color : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            unit,
            style: TextStyle(fontSize: 12, color: color),
          ),
        ],
      ),
    );
  }
}

typedef HomeScreen = DashboardScreen;