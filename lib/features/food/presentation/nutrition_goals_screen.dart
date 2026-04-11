import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/bilingual_text.dart';
import '../data/nutrition_repository.dart';
import '../../auth/data/auth_repository.dart';

class NutritionGoalsScreen extends ConsumerStatefulWidget {
  const NutritionGoalsScreen({super.key});

  @override
  ConsumerState<NutritionGoalsScreen> createState() => _NutritionGoalsScreenState();
}

class _NutritionGoalsScreenState extends ConsumerState<NutritionGoalsScreen> {
  int? calorieTarget;
  int? proteinG;
  int? carbsG;
  int? fatG;
  double adjustmentFactor = 1.0;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentGoals();
  }

  Future<void> _loadCurrentGoals() async {
    final user = await ref.read(currentUserProvider.future);
    if (user == null) return;

    final repo = ref.read(nutritionRepositoryProvider);
    final goals = await repo.getGoals(user.$id);

    if (goals != null && mounted) {
      setState(() {
        calorieTarget = goals.calorieTarget;
        proteinG = goals.proteinTarget;
        carbsG = goals.carbsTarget;
        fatG = goals.fatTarget;
      });
    }
  }

  void _adjustGoals(double factor) {
    if (calorieTarget == null) return;
    setState(() {
      adjustmentFactor = factor;
    });
  }

  Future<void> _saveGoals() async {
    final user = await ref.read(currentUserProvider.future);
    if (user == null || calorieTarget == null) return;

    setState(() => isSaving = true);
    try {
      final repo = ref.read(nutritionRepositoryProvider);
      final finalCalories = (calorieTarget! * adjustmentFactor).round();
      final finalProtein = (proteinG! * adjustmentFactor).round();
      final finalCarbs = (carbsG! * adjustmentFactor).round();
      final finalFat = (fatG! * adjustmentFactor).round();

      await repo.updateGoals(
        userId: user.$id,
        calorieTarget: finalCalories,
        proteinTarget: finalProtein,
        carbsTarget: finalCarbs,
        fatTarget: finalFat,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Goals updated successfully! · लक्ष्य अपडेट किए गए!")),
        );
        Navigator.pop(context);
      }
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (calorieTarget == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final adjustedCals = (calorieTarget! * adjustmentFactor).round();
    final adjustedProtein = (proteinG! * adjustmentFactor).round();
    final adjustedCarbs = (carbsG! * adjustmentFactor).round();
    final adjustedFat = (fatG! * adjustmentFactor).round();

    return Scaffold(
      appBar: AppBar(
        title: const BilingualText(
          english: "Nutrition Goals",
          hindi: "पोषण लक्ष्य",
          englishStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGoalCard(adjustedCals, adjustedProtein, adjustedCarbs, adjustedFat, isDark),
            const SizedBox(height: 32),
            Text(
              "Adjust Goal (+/- 10%)",
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Fine-tune your daily targets based on your appetite and energy levels.",
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.remove_circle_outline, color: Colors.grey),
                Expanded(
                  child: Slider(
                    value: adjustmentFactor,
                    min: 0.9,
                    max: 1.1,
                    divisions: 20,
                    activeColor: AppColors.primary,
                    label: "${((adjustmentFactor - 1) * 100).toStringAsFixed(0)}%",
                    onChanged: _adjustGoals,
                  ),
                ),
                const Icon(Icons.add_circle_outline, color: Colors.grey),
              ],
            ),
            Center(
              child: Text(
                "${((adjustmentFactor - 1) * 100).toStringAsFixed(1)}% Adjustment",
                style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 40),
            _buildInfoTile(
              "Standard Split",
              "Carbs: 55% | Protein: 20% | Fat: 25%",
              Icons.pie_chart_outline,
            ),
            const SizedBox(height: 16),
            _buildInfoTile(
              "TDEE Based",
              "Calculated using Mifflin-St Jeor formula for your body metrics.",
              Icons.calculate_outlined,
            ),
            const SizedBox(height: 60),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: isSaving ? null : _saveGoals,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Save Changes · सहेजें", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalCard(int cal, int pro, int carb, int fat, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "DAILY BUDGET",
            style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          const SizedBox(height: 8),
          Text(
            "$cal kcal",
            style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMacroItem("Protein", "${pro}g", Colors.orangeAccent),
              _buildMacroItem("Carbs", "${carb}g", Colors.cyanAccent),
              _buildMacroItem("Fat", "${fat}g", Colors.pinkAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroItem(String label, String value, Color color) {
    return Column(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12)),
      ],
    );
  }

  Widget _buildInfoTile(String title, String subtitle, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
