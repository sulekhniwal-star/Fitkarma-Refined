import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/activity_rings.dart';
import '../../../shared/widgets/insight_card.dart';
import '../../../shared/widgets/karma_level_card.dart';
import '../../../shared/widgets/quick_log_fab.dart';
import '../../../shared/widgets/dosha_chart.dart';
import '../../../shared/widgets/bilingual_text.dart';
import '../../../shared/widgets/shimmer_loader.dart';
import 'dashboard_controller.dart';
import '../../../core/utils/ayur_utils.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardControllerProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, dashboardState),
          SliverToBoxAdapter(
            child: dashboardState.when(
              data: (data) => _buildContent(context, data),
              loading: () => const Padding(
                padding: EdgeInsets.all(20),
                child: ShimmerLoader(width: double.infinity, height: 600),
              ),
              error: (e, s) => Center(child: Text('Error: $e')),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
      floatingActionButton: QuickLogFAB(
        onFood: () {},
        onWorkout: () {},
        onWeight: () {},
        onWater: () {},
        onMood: () {},
        onSleep: () {},
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, AsyncValue<DashboardData> state) {
    final theme = Theme.of(context);
    final profile = state.asData?.value.profile;

    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Text(
                  (profile?.name ?? 'U')[0].toUpperCase(),
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BilingualText(
                      english: "Namaste, ${profile?.name ?? 'User'} 🙏",
                      hindi: "नमस्ते, ${profile?.name ?? 'उपयोगकर्ता'}",
                      englishStyle: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      hindiStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.textTheme.bodySmall?.color),
                    ),
                  ],
                ),
              ),
              const KarmaLevelCard(
                currentXP: 50,
                nextXP: 500,
                levelName: 'Level 1',
                nextLevelName: 'Level 2',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, DashboardData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildHealthSummary(context, data),
          if (data.activeFestivals.isNotEmpty || data.activeWeddingPlan != null) ...[
            const SizedBox(height: 24),
            _buildContextualAdvice(context, data),
          ],
          const SizedBox(height: 24),
          const InsightCard(
            title: "Ayurvedic Tip",
            message: "Your Pitta is slightly elevated. Try cooling foods like cucumber and coconut water today.",
          ),
          const SizedBox(height: 24),
          _buildMealSection(context, data),
          const SizedBox(height: 24),
          _buildRecentActivity(context, data),
        ],
      ),
    );
  }

  Widget _buildHealthSummary(BuildContext context, DashboardData data) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ActivityRingsWidget(
            size: 140,
            strokeWidth: 10,
            spacing: 3,
            rings: [
              ActivityRingData(progress: data.todayCalories / 2000, color: Colors.orange),
              ActivityRingData(progress: data.todaySteps / 8000, color: Colors.green),
              ActivityRingData(progress: data.waterGlasses / 8, color: Colors.teal),
              ActivityRingData(progress: 0.4, color: Colors.purple), // Active Minutes
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMetricRow(Icons.local_fire_department, "Calories", "${data.todayCalories.toInt()} / 2000 kcal"),
                const SizedBox(height: 8),
                _buildMetricRow(Icons.directions_walk, "Steps", "${data.todaySteps} / 8000"),
                const SizedBox(height: 8),
                _buildMetricRow(Icons.water_drop, "Water", "${data.waterGlasses.toInt()} / 8 Glasses"),
                const SizedBox(height: 12),
                if (data.doshaPercentages.isNotEmpty) ...[
                  Row(
                    children: [
                      DoshaDonutChart(
                        size: 40,
                        percentages: data.doshaPercentages,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${AyurUtils.getDominantDosha(data.doshaPercentages)} Dominant",
                        style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContextualAdvice(BuildContext context, DashboardData data) {
    if (data.activeWeddingPlan != null) {
      final plan = data.activeWeddingPlan!;
      return InsightCard(
        title: "Wedding Prep: ${plan.phase.name}",
        message: plan.adviceEn,
        backgroundColor: const Color(0xFFFFF9E6), // Gold tint
        icon: Icons.celebration,
        iconColor: const Color(0xFFD4AF37),
      );
    }

    if (data.activeFestivals.isNotEmpty) {
      final festival = data.activeFestivals.first;
      return InsightCard(
        title: "Festival: ${festival.festivalKey}",
        message: festival.insightMessage,
        backgroundColor: Colors.orange.shade50,
        icon: Icons.timer,
        iconColor: Colors.orange,
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildMetricRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildMealSection(BuildContext context, DashboardData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BilingualText(
          english: "Today's Meals",
          hindi: "आज का भोजन",
          englishStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildMealCard(context, "Breakfast", "450 kcal", Icons.breakfast_dining, true),
              _buildMealCard(context, "Lunch", "--- kcal", Icons.lunch_dining, false),
              _buildMealCard(context, "Dinner", "--- kcal", Icons.dinner_dining, false),
              _buildMealCard(context, "Snacks", "--- kcal", Icons.cookie, false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMealCard(BuildContext context, String title, String kcal, IconData icon, bool logged) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: logged ? AppColors.primary.withOpacity(0.1) : (isDark ? Colors.grey[900] : Colors.grey[100]),
        borderRadius: BorderRadius.circular(20),
        border: logged ? Border.all(color: AppColors.primary.withOpacity(0.3)) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: logged ? AppColors.primary : Colors.grey),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          Text(kcal, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context, DashboardData data) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BilingualText(
          english: "Recent Activity",
          hindi: "हाल की गतिविधि",
          englishStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (data.recentWorkouts.isEmpty)
          const Text("No recent workouts logged.")
        else
          ...data.recentWorkouts.map((w) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.purple.withOpacity(0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.fitness_center, color: Colors.purple, size: 20),
                ),
                title: Text(w.workoutId ?? 'Workout'),
                subtitle: Text("${w.durationMin} mins · ${w.caloriesBurned} kcal"),
                trailing: Text(_formatDate(w.loggedAt), style: theme.textTheme.bodySmall),
              )),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) return "Today";
    return "${date.day}/${date.month}";
  }
}
