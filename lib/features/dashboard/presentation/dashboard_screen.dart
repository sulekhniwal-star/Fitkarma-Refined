// lib/features/dashboard/presentation/dashboard_screen.dart
// Main Dashboard Screen - reads from Drift on first render

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';
import 'package:fitkarma/shared/widgets/activity_rings.dart';
import 'package:fitkarma/shared/widgets/insight_card.dart';
import 'package:fitkarma/shared/widgets/karma_level_card.dart';
import 'package:fitkarma/features/dashboard/data/dashboard_providers.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _selectedMealTab = 0;
  bool _isLoadingBackgroundSync = false;

  @override
  void initState() {
    super.initState();
    // Trigger background sync after initial render
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _triggerBackgroundSync();
    });
  }

  Future<void> _triggerBackgroundSync() async {
    setState(() => _isLoadingBackgroundSync = true);
    // Background sync would be triggered here
    // For now, we just simulate a small delay
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _isLoadingBackgroundSync = false);
      // Refresh all the data providers
      ref.invalidate(userProfileProvider);
      ref.invalidate(karmaStatsProvider);
      ref.invalidate(activityRingsProvider);
      ref.invalidate(todayMealsProvider);
      ref.invalidate(latestWorkoutProvider);
      ref.invalidate(sleepRecoveryProvider);
      ref.invalidate(dashboardInsightProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.darkBackground
          : AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _triggerBackgroundSync,
          child: CustomScrollView(
            slivers: [
              // Header Section
              SliverToBoxAdapter(child: _buildHeader()),

              // Karma Level Card
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildKarmaCard(),
                ),
              ),

              // Activity Rings Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildActivityRings(),
                ),
              ),

              // Insight Card
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildInsightCard(),
                ),
              ),

              // Today's Meals Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildMealsSection(),
                ),
              ),

              // Workout & Sleep Cards
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildWorkoutSleepSection(),
                ),
              ),

              // Bottom padding
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildQuickLogFAB(),
    );
  }

  // ============================================================
  // HEADER - Avatar, Namaste, Karma XP & Level Badge
  // ============================================================
  Widget _buildHeader() {
    final userProfile = ref.watch(userProfileProvider);
    final karmaStats = ref.watch(karmaStatsProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Avatar
          userProfile.when(
            data: (profile) => CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              backgroundImage: profile?.name != null ? null : null,
              child: profile?.name != null
                  ? Text(
                      profile!.name.isNotEmpty
                          ? profile.name[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    )
                  : const Icon(Icons.person, color: AppColors.primary),
            ),
            loading: () => const CircleAvatar(
              radius: 28,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            error: (_, __) => const CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.error,
              child: Icon(Icons.error, color: Colors.white),
            ),
          ),

          const SizedBox(width: 12),

          // Namaste + Name + Karma Badge
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Namaste 🙏',
                  style: AppTextStyles.h4.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                userProfile.when(
                  data: (profile) => Text(
                    profile?.name ?? 'Guest',
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  loading: () => const SizedBox(
                    height: 20,
                    width: 100,
                    child: LinearProgressIndicator(),
                  ),
                  error: (_, __) => const Text('Error'),
                ),
              ],
            ),
          ),

          // Karma XP & Level Badge
          karmaStats.when(
            data: (stats) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.secondary, AppColors.secondaryDark],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.stars, color: AppColors.accent, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Lv.${stats.level}',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${stats.xpPoints} XP',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            loading: () => const SizedBox(
              height: 32,
              width: 80,
              child: LinearProgressIndicator(),
            ),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // KARMA LEVEL CARD
  // ============================================================
  Widget _buildKarmaCard() {
    final karmaStats = ref.watch(karmaStatsProvider);

    return karmaStats.when(
      data: (stats) => KarmaLevelCard(
        level: stats.level,
        title: stats.title,
        progress: stats.progressToNextLevel,
        karmaPoints: stats.xpPoints,
        pointsToNextLevel: stats.pointsToNextLevel,
      ),
      loading: () => const SizedBox(
        height: 180,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Error loading karma: $e'),
        ),
      ),
    );
  }

  // ============================================================
  // ACTIVITY RINGS WIDGET
  // ============================================================
  Widget _buildActivityRings() {
    final activityData = ref.watch(activityRingsProvider);

    return Card(
      elevation: 0,
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkSurface
          : AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today\'s Activity',
                  style: AppTextStyles.h4.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                if (_isLoadingBackgroundSync)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
            const SizedBox(height: 20),

            // Activity Rings
            activityData.when(
              data: (data) => Row(
                children: [
                  // Rings
                  Expanded(
                    flex: 2,
                    child: ActivityRingsWidget(
                      caloriesProgress: data.caloriesProgress,
                      stepsProgress: data.stepsProgress,
                      waterProgress: data.waterProgress,
                      minutesProgress: data.activeMinutesProgress,
                      size: 140,
                    ),
                  ),

                  // Stats labels
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildActivityStat(
                          '🔥 Calories',
                          '${data.caloriesBurned}',
                          ' / 2000',
                          AppColors.primary,
                        ),
                        const SizedBox(height: 12),
                        _buildActivityStat(
                          '👣 Steps',
                          '${data.steps}',
                          ' / 10,000',
                          AppColors.success,
                        ),
                        const SizedBox(height: 12),
                        _buildActivityStat(
                          '💧 Water',
                          '${data.waterGlasses}',
                          ' / 8 glasses',
                          AppColors.teal,
                        ),
                        const SizedBox(height: 12),
                        _buildActivityStat(
                          '⏱️ Active',
                          '${data.activeMinutes}',
                          ' / 30 min',
                          AppColors.purple,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              loading: () => const SizedBox(
                height: 140,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => Text('Error: $e'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityStat(
    String label,
    String value,
    String suffix,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$label: ',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                TextSpan(
                  text: value,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: suffix,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // INSIGHT CARD
  // ============================================================
  Widget _buildInsightCard() {
    final insightData = ref.watch(dashboardInsightProvider);

    return insightData.when(
      data: (insight) {
        if (insight == null) return const SizedBox.shrink();
        return InsightCard(
          title: insight.title,
          message: insight.message,
          onDismiss: () {
            // Dismiss insight - would store dismissal in local storage
          },
        );
      },
      loading: () => const SizedBox(
        height: 100,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  // ============================================================
  // TODAY'S MEALS SECTION
  // ============================================================
  Widget _buildMealsSection() {
    final mealsData = ref.watch(todayMealsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Today\'s Meals',
              style: AppTextStyles.h4.copyWith(color: AppColors.textPrimary),
            ),
            TextButton(
              onPressed: () => context.go('/home/food'),
              child: Text(
                'View All',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Meal Type Tabs
        mealsData.when(
          data: (meals) => Column(
            children: [
              // Tab Bar
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.darkSurface
                      : AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    _buildMealTab('Breakfast', 0),
                    _buildMealTab('Lunch', 1),
                    _buildMealTab('Dinner', 2),
                    _buildMealTab('Snacks', 3),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Meal Summary Card
              _buildMealSummaryCard(
                meals.isNotEmpty ? meals[_selectedMealTab] : null,
              ),
            ],
          ),
          loading: () => const SizedBox(
            height: 150,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => Text('Error: $e'),
        ),
      ],
    );
  }

  Widget _buildMealTab(String label, int index) {
    final isSelected = _selectedMealTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedMealTab = index),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.labelMedium.copyWith(
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMealSummaryCard(MealSummary? meal) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    if (meal == null || meal.itemCount == 0) {
      return Card(
        elevation: 0,
        color: isDarkMode ? AppColors.darkSurface : AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(
                Icons.restaurant_outlined,
                size: 40,
                color: AppColors.textSecondary.withOpacity(0.5),
              ),
              const SizedBox(height: 8),
              Text(
                'No meals logged yet',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => context.go(
                  '/home/food/log/${['breakfast', 'lunch', 'dinner', 'snack'][_selectedMealTab]}',
                ),
                child: const Text('Log Meal'),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 0,
      color: isDarkMode ? AppColors.darkSurface : AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Items
            Text(
              meal.items.take(3).join(', '),
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 12),

            // Macros
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMacroStat(
                  'Calories',
                  '${meal.totalCalories.round()}',
                  AppColors.primary,
                ),
                _buildMacroStat(
                  'Protein',
                  '${meal.totalProtein.round()}g',
                  AppColors.success,
                ),
                _buildMacroStat(
                  'Carbs',
                  '${meal.totalCarbs.round()}g',
                  AppColors.accent,
                ),
                _buildMacroStat(
                  'Fat',
                  '${meal.totalFat.round()}g',
                  AppColors.warning,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.labelLarge.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  // ============================================================
  // WORKOUT & SLEEP SECTION
  // ============================================================
  Widget _buildWorkoutSleepSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Latest Workout Card
        Expanded(child: _buildWorkoutCard()),

        const SizedBox(width: 12),

        // Sleep Recovery Card
        Expanded(child: _buildSleepCard()),
      ],
    );
  }

  Widget _buildWorkoutCard() {
    final workoutData = ref.watch(latestWorkoutProvider);
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Card(
      elevation: 0,
      color: isDarkMode ? AppColors.darkSurface : AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: workoutData.when(
          data: (workout) {
            if (workout == null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.fitness_center,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Workout',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No workout logged',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => context.go('/home/workout'),
                    child: const Text('Start Workout'),
                  ),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.fitness_center, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(
                      'Last Workout',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  workout.title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildWorkoutStat(
                      Icons.timer_outlined,
                      '${workout.durationMin} min',
                    ),
                    const SizedBox(width: 12),
                    _buildWorkoutStat(
                      Icons.local_fire_department,
                      '${workout.caloriesBurned.round()} cal',
                    ),
                  ],
                ),
              ],
            );
          },
          loading: () => const SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => Text('Error: $e'),
        ),
      ),
    );
  }

  Widget _buildWorkoutStat(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          value,
          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildSleepCard() {
    final sleepData = ref.watch(sleepRecoveryProvider);
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Card(
      elevation: 0,
      color: isDarkMode ? AppColors.darkSurface : AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: sleepData.when(
          data: (sleep) {
            if (sleep == null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.bedtime, color: AppColors.purple),
                      const SizedBox(width: 8),
                      Text(
                        'Sleep',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No sleep data',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Connect a device to track',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.bedtime, color: AppColors.purple),
                    const SizedBox(width: 8),
                    Text(
                      'Recovery',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Recovery Score Circle
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(
                          value: sleep.recoveryScore / 100,
                          strokeWidth: 6,
                          backgroundColor: AppColors.purple.withOpacity(0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            sleep.recoveryScore > 70
                                ? AppColors.success
                                : sleep.recoveryScore > 40
                                ? AppColors.warning
                                : AppColors.error,
                          ),
                        ),
                      ),
                      Text(
                        '${sleep.recoveryScore}%',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  '${(sleep.durationMin / 60).toStringAsFixed(1)}h sleep',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            );
          },
          loading: () => const SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => Text('Error: $e'),
        ),
      ),
    );
  }

  // ============================================================
  // QUICK LOG FAB
  // ============================================================
  Widget _buildQuickLogFAB() {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      activeBackgroundColor: AppColors.error,
      activeForegroundColor: Colors.white,
      buttonSize: const Size(56, 56),
      childrenButtonSize: const Size(56, 56),
      visible: true,
      closeManually: false,
      curve: Curves.easeInOut,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      elevation: 8.0,
      shape: const CircleBorder(),
      children: [
        SpeedDialChild(
          child: const Icon(Icons.restaurant),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          label: 'Food',
          labelStyle: AppTextStyles.labelMedium,
          onTap: () => context.go('/home/food/log/breakfast'),
        ),
        SpeedDialChild(
          child: const Icon(Icons.water_drop),
          backgroundColor: AppColors.teal,
          foregroundColor: Colors.white,
          label: 'Water',
          labelStyle: AppTextStyles.labelMedium,
          onTap: () => _logWater(),
        ),
        SpeedDialChild(
          child: const Icon(Icons.mood),
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          label: 'Mood',
          labelStyle: AppTextStyles.labelMedium,
          onTap: () => context.go('/home/mood'),
        ),
        SpeedDialChild(
          child: const Icon(Icons.fitness_center),
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
          label: 'Workout',
          labelStyle: AppTextStyles.labelMedium,
          onTap: () => context.go('/home/workout'),
        ),
        SpeedDialChild(
          child: const Icon(Icons.favorite),
          backgroundColor: AppColors.error,
          foregroundColor: Colors.white,
          label: 'BP',
          labelStyle: AppTextStyles.labelMedium,
          onTap: () => context.go('/home/health/bp'),
        ),
        SpeedDialChild(
          child: const Icon(Icons.bloodtype),
          backgroundColor: AppColors.warning,
          foregroundColor: Colors.white,
          label: 'Glucose',
          labelStyle: AppTextStyles.labelMedium,
          onTap: () => context.go('/home/health/glucose'),
        ),
        SpeedDialChild(
          child: const Icon(Icons.description),
          backgroundColor: AppColors.purple,
          foregroundColor: Colors.white,
          label: 'Lab Report',
          labelStyle: AppTextStyles.labelMedium,
          onTap: () => context.go('/lab-reports/scan'),
        ),
      ],
    );
  }

  void _logWater() {
    // Quick water log - would add 1 glass to today's water log
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Added 1 glass of water 💧'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
