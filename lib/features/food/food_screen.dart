import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/food/data/nutrition_service.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final tdeeCalculatorProvider = StateNotifierProvider<TdeeCalculatorNotifier, TdeeCalculatorState>((ref) {
  return TdeeCalculatorNotifier();
});

class TdeeCalculatorState {
  final double weight;
  final double height;
  final int age;
  final String gender;
  final double activityLevel;
  final double? tdee;
  final MacroTargets? macros;

  TdeeCalculatorState({
    this.weight = 70,
    this.height = 170,
    this.age = 30,
    this.gender = 'male',
    this.activityLevel = 1.375,
    this.tdee,
    this.macros,
  });

  TdeeCalculatorState copyWith({
    double? weight,
    double? height,
    int? age,
    String? gender,
    double? activityLevel,
    double? tdee,
    MacroTargets? macros,
  }) {
    return TdeeCalculatorState(
      weight: weight ?? this.weight,
      height: height ?? this.height,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      activityLevel: activityLevel ?? this.activityLevel,
      tdee: tdee ?? this.tdee,
      macros: macros ?? this.macros,
    );
  }
}

class TdeeCalculatorNotifier extends StateNotifier<TdeeCalculatorState> {
  TdeeCalculatorNotifier() : super(TdeeCalculatorState());

  void setWeight(double v) => state = state.copyWith(weight: v);
  void setHeight(double v) => state = state.copyWith(height: v);
  void setAge(int v) => state = state.copyWith(age: v);
  void setGender(String v) => state = state.copyWith(gender: v);
  void setActivityLevel(double v) => state = state.copyWith(activityLevel: v);

  void calculate(NutritionService service) {
    final tdee = service.calculateTdee(
      weightKg: state.weight,
      heightCm: state.height,
      ageYears: state.age,
      gender: state.gender,
      activityMultiplier: state.activityLevel,
    );
    final macros = service.calculateMacros(tdee);
    state = state.copyWith(tdee: tdee, macros: macros);
  }
}

class FoodScreen extends ConsumerWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nutrition'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Dashboard'),
              Tab(text: 'Calculator'),
              Tab(text: 'Micros'),
              Tab(text: 'Grocery'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NutritionDashboardTab(),
            TdeeCalculatorTab(),
            MicronutrientTab(),
            GroceryListTab(),
          ],
        ),
      ),
    );
  }
}

class NutritionDashboardTab extends ConsumerWidget {
  const NutritionDashboardTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(nutritionServiceProvider);
    final now = DateTime.now();

    return FutureBuilder(
      future: service.getDailyTotals('current_user', now),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final totals = snapshot.data!;
        final goals = ref.watch(nutritionServiceProvider).getNutritionGoals('current_user');

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateHeader(now),
              const SizedBox(height: 16),
              _buildMacroRings(totals),
              const SizedBox(height: 16),
              _buildMicronutrientRow(totals),
              const SizedBox(height: 16),
              _buildMicronutrientGapCard(ref, totals),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDateHeader(DateTime date) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return Text(
      '${days[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}',
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildMacroRings(Map<String, double> totals) {
    final calories = totals['calories'] ?? 0;
    final protein = totals['protein'] ?? 0;
    final carbs = totals['carbs'] ?? 0;
    final fat = totals['fat'] ?? 0;

    const goalCal = 2000.0;
    const goalProtein = 100.0;
    const goalCarbs = 275.0;
    const goalFat = 55.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildMacroRing(calories, goalCal, 'Calories', Colors.orange),
        _buildMacroRing(protein, goalProtein, 'Protein', Colors.red),
        _buildMacroRing(carbs, goalCarbs, 'Carbs', Colors.blue),
        _buildMacroRing(fat, goalFat, 'Fat', Colors.yellow.shade700),
      ],
    );
  }

  Widget _buildMacroRing(double current, double goal, String label, Color color) {
    final percent = (current / goal * 100).clamp(0, 100);
    Color statusColor;
    if (percent >= 90 && percent <= 110) {
      statusColor = Colors.green;
    } else if (percent >= 70) {
      statusColor = Colors.orange;
    } else {
      statusColor = Colors.red;
    }

    return Column(
      children: [
        SizedBox(
          width: 70,
          height: 70,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: percent / 100,
                strokeWidth: 6,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation(statusColor),
              ),
              Text(
                '${percent.round()}%',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
        Text('${current.round()}/${goal.round()}', style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
      ],
    );
  }

  Widget _buildMicronutrientRow(Map<String, double> totals) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Micronutrients', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMicroItem('Iron', totals['iron'] ?? 0, 18, 'mg'),
              _buildMicroItem('Vit D', totals['vitaminD'] ?? 0, 15, 'mcg'),
              _buildMicroItem('B12', totals['vitaminB12'] ?? 0, 2.4, 'mcg'),
              _buildMicroItem('Calcium', totals['calcium'] ?? 0, 1000, 'mg'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMicroItem(String name, double current, double target, String unit) {
    final percent = (current / target * 100).clamp(0, 100);
    final statusColor = percent >= 70 ? Colors.green : Colors.red;

    return Column(
      children: [
        Text(name, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 4),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${percent.round()}%',
              style: TextStyle(fontSize: 10, color: statusColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Text('${current.round()}/$target', style: TextStyle(fontSize: 9, color: Colors.grey.shade600)),
      ],
    );
  }

  Widget _buildMicronutrientGapCard(WidgetRef ref, Map<String, double> totals) {
    final service = ref.read(nutritionServiceProvider);
    final gap = service.findBiggestGap(totals, null);

    if (gap == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 12),
            Expanded(child: Text('All micronutrients on track!', style: TextStyle(color: Colors.green))),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber, color: Colors.orange.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(gap.summaryText, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(gap.suggestionText, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TdeeCalculatorTab extends ConsumerWidget {
  const TdeeCalculatorTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tdeeCalculatorProvider);
    final notifier = ref.read(tdeeCalculatorProvider.notifier);
    final service = ref.read(nutritionServiceProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('TDEE Calculator', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Mifflin-St Jeor Formula', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildSlider('Weight', state.weight, 40, 150, 'kg', notifier.setWeight),
          _buildSlider('Height', state.height, 140, 210, 'cm', notifier.setHeight),
          _buildSlider('Age', state.age.toDouble(), 18, 80, 'years', (v) => notifier.setAge(v.round())),
          const SizedBox(height: 16),
          _buildGenderSelector(state.gender, notifier.setGender),
          const SizedBox(height: 16),
          _buildActivitySelector(state.activityLevel, notifier.setActivityLevel),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => notifier.calculate(service),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
              child: const Text('Calculate'),
            ),
          ),
          if (state.tdee != null) ...[
            const SizedBox(height: 24),
            _buildResultsCard(state),
          ],
        ],
      ),
    );
  }

  Widget _buildSlider(String label, double value, double min, double max, String unit, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.round()} $unit'),
        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildGenderSelector(String gender, Function(String) onChanged) {
    return Row(
      children: [
        const Text('Gender: '),
        const SizedBox(width: 16),
        ChoiceChip(
          label: const Text('Male'),
          selected: gender == 'male',
          onSelected: (_) => onChanged('male'),
        ),
        const SizedBox(width: 8),
        ChoiceChip(
          label: const Text('Female'),
          selected: gender == 'female',
          onSelected: (_) => onChanged('female'),
        ),
      ],
    );
  }

  Widget _buildActivitySelector(double level, Function(double) onChanged) {
    final activities = [
      (1.2, 'Sedentary'),
      (1.375, 'Light'),
      (1.55, 'Moderate'),
      (1.725, 'Active'),
      (1.9, 'Very Active'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Activity Level'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: activities.map((a) => ChoiceChip(
            label: Text(a.$2),
            selected: level == a.$1,
            onSelected: (_) => onChanged(a.$1),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildResultsCard(TdeeCalculatorState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF4A148C), Color(0xFF7B1FA2)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text('Your TDEE', style: TextStyle(color: Colors.white70)),
          Text('${state.tdee!.round()} kcal/day', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Text('Daily Macros', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMacroResult('Carbs', state.macros!.carbsGrams.round(), 55),
              _buildMacroResult('Protein', state.macros!.proteinGrams.round(), 20),
              _buildMacroResult('Fat', state.macros!.fatGrams.round(), 25),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroResult(String label, int grams, int percent) {
    return Column(
      children: [
        Text('$grams g', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        Text('$label $percent%', style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}

class MicronutrientTab extends StatelessWidget {
  const MicronutrientTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Weekly micronutrient report coming soon'));
  }
}

class GroceryListTab extends StatelessWidget {
  const GroceryListTab({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      GroceryItem(name: 'Whole grains/Roti', quantity: '7 days', reason: 'Carbs'),
      GroceryItem(name: 'Pulses/Dal', quantity: '1 kg', reason: 'Protein + Iron'),
      GroceryItem(name: 'Eggs', quantity: '14', reason: 'Protein + B12'),
      GroceryItem(name: 'Milk', quantity: '3 liters', reason: 'Calcium'),
      GroceryItem(name: 'Paneer', quantity: '500g', reason: 'Protein + Calcium'),
      GroceryItem(name: 'Leafy greens', quantity: '1 bunch', reason: 'Iron'),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: const Icon(Icons.shopping_basket),
            title: Text(item.name),
            subtitle: Text(item.reason),
            trailing: Text(item.quantity, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}