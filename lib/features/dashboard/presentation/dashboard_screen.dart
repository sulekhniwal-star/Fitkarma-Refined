import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/activity_rings.dart';
import '../../../shared/widgets/insight_card.dart';
import '../../../shared/widgets/karma_level_card.dart';
import '../../../shared/widgets/quick_log_fab.dart';
import '../../../shared/widgets/dosha_chart.dart';
import '../../../shared/widgets/bilingual_text.dart';
import '../../../shared/widgets/shimmer_loader.dart';
import '../../../shared/widgets/wedding_countdown_card.dart';
import '../../../shared/widgets/festival_countdown_banner.dart';
import '../../../shared/widgets/async_value_widget.dart';
import '../../../shared/widgets/error_retry_widget.dart';
import 'dashboard_controller.dart';
import '../../../shared/widgets/water_intake_dialog.dart';
import '../../health/data/health_repository.dart';
import '../../../core/storage/app_database.dart';
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
            child: AsyncValueWidget<DashboardData>(
              value: dashboardState,
              loadingBuilder: const Padding(
                padding: EdgeInsets.all(20),
                child: ShimmerLoader(width: double.infinity, height: 600),
              ),
              errorBuilder: (e, s) => ErrorRetryWidget(
                message: 'Could not load dashboard: $e',
                onRetry: () => ref.refresh(dashboardControllerProvider),
              ),
              builder: (data) => _buildContent(context, data),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
      floatingActionButton: QuickLogFAB(
        onFood: () => context.push('/food/search'),
        onWorkout: () => context.push('/workout/log'),
        onBp: () => context.push('/health/bp'),
        onGlucose: () => context.push('/health/glucose'),
        onWater: () => showDialog(
          context: context,
          builder: (context) => WaterIntakeDialog(
            onSave: (glasses) async {
              await ref.read(healthRepositoryProvider).saveWaterIntake(glasses);
              ref.refresh(dashboardControllerProvider);
            },
          ),
        ),
        onMood: () => context.push('/lifestyle/mood'),
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
                  style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
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
          const SizedBox(height: 24),
          _buildHealthMonitoring(context, data),
          if (data.activeFestivals.isNotEmpty || data.activeWeddingPlan != null) ...[
            const SizedBox(height: 24),
            _buildContextualAdvice(context, data),
          ],
          const SizedBox(height: 24),
          if (data.micronutrientGapMessage != null)
            InsightCard(
              title: "Nutrition Insight",
              message: data.micronutrientGapMessage!,
            ),
          ...data.insights.map((insight) => Padding(
                padding: const EdgeInsets.only(top: 12),
                child: InsightCard(
                  title: insight.titleEn,
                  message: insight.bodyEn,
                  icon: insight.icon,
                  color: insight.color,
                  onTap: insight.actionRoute != null ? () => context.push(insight.actionRoute!) : null,
                ),
              )),
          const SizedBox(height: 12),
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
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.settings_outlined, size: 20, color: Colors.grey),
              onPressed: () => context.push('/food/goals'),
            ),
          ),
          Row(
            children: [
          ActivityRingsWidget(
            size: 140,
            strokeWidth: 10,
            spacing: 3,
            rings: [
              ActivityRingData(
                progress: data.todayCalories / (data.nutritionGoal?.calorieTarget ?? 2000),
                color: _getColorForProgress(data.todayCalories / (data.nutritionGoal?.calorieTarget ?? 2000)),
              ),
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
                _buildMetricRow(Icons.local_fire_department, "Calories", "${data.todayCalories.toInt()} / ${data.nutritionGoal?.calorieTarget ?? 2000} kcal"),
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
    ]),
  );
}

  Widget _buildContextualAdvice(BuildContext context, DashboardData data) {
    if (data.activeWeddingPlan != null) {
      final plan = data.activeWeddingPlan!;
      return WeddingCountdownCard(
        daysUntil: plan.daysToWedding,
        role: plan.role,
        phase: plan.phase.name,
        nextEvent: plan.eventName,
        onTap: () => context.push('/wedding-planner'),
      );
    }

    if (data.activeFestivals.isNotEmpty) {
      final festival = data.activeFestivals.first;
      return FestivalCountdownBanner(
        nameEn: festival.nameEn,
        nameHi: festival.nameHi,
        startDate: festival.startDate,
        onTap: () => context.push('/festival-calendar'),
      );
    }

    return const SizedBox.shrink();
  }

  Color _getColorForProgress(double progress) {
    if (progress < 0.9) return Colors.green;
    if (progress <= 1.1) return Colors.green;
    if (progress <= 1.25) return Colors.orange;
    return Colors.red;
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

  Widget _buildHealthMonitoring(BuildContext context, DashboardData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BilingualText(
              english: "Health Monitoring",
              hindi: "स्वास्थ्य निगरानी",
              englishStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {}, // TODO: Navigate to full health hub
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildHealthCard(
                context,
                "Blood Pressure",
                data.lastBp != null ? "${data.lastBp!.systolic}/${data.lastBp!.diastolic}" : "--/--",
                "mmHg",
                data.lastBp?.classification ?? "No data",
                _getBpColor(data.lastBp?.classification),
                Icons.favorite,
                () => context.push('/health/bp'),
              ),
              _buildHealthCard(
                context,
                "Glucose",
                data.lastGlucose != null ? "${data.lastGlucose!.valueMgDl}" : "--",
                "mg/dL",
                data.lastGlucose?.testType ?? "No data",
                Colors.orange,
                Icons.bloodtype,
                () => context.push('/health/glucose'),
              ),
              _buildHealthCard(
                context,
                "SpO2",
                data.lastSpo2 != null ? "${data.lastSpo2!.valuePercent}%" : "--%",
                "Saturation",
                data.lastSpo2 != null && data.lastSpo2!.valuePercent < 95 ? "Low" : "Normal",
                data.lastSpo2 != null && data.lastSpo2!.valuePercent < 95 ? Colors.red : Colors.blue,
                Icons.air,
                () => context.push('/health/spo2'),
              ),
              if (data.nextAppointment != null)
                _buildAppointmentCard(context, data.nextAppointment!),
              _buildHealthCard(
                context,
                "Lab Reports",
                "Scan",
                "Latest",
                "AI Extractor",
                Colors.indigo,
                Icons.document_scanner,
                () => context.push('/health/lab-scan'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHealthCard(BuildContext context, String title, String value, String unit, String status, Color color, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(width: 4),
                Text(unit, style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                status,
                style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(BuildContext context, DoctorAppointment appt) {
    return GestureDetector(
      onTap: () => context.push('/health/appointments'),
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue[800]!.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue[800]!.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.calendar_month, color: Colors.blue, size: 20),
            const SizedBox(height: 8),
            const Text("Upcoming Visit", style: TextStyle(fontSize: 11, color: Colors.grey)),
            Text(appt.doctorName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
            Text(appt.specialty ?? "General", style: const TextStyle(fontSize: 10, color: Colors.blue)),
            const SizedBox(height: 8),
            Text(
              "${appt.appointmentDate.day}/${appt.appointmentDate.month} · ${appt.appointmentDate.hour}:${appt.appointmentDate.minute.toString().padLeft(2, '0')}",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBpColor(String? classification) {
    switch (classification) {
      case 'Normal': return Colors.green;
      case 'Elevated': return Colors.orange;
      case 'Hypertension Stage 1': return Colors.deepOrange;
      case 'Hypertension Stage 2': return Colors.red;
      case 'Hypertensive Crisis': return Colors.redAccent;
      default: return Colors.grey;
    }
  }
}
