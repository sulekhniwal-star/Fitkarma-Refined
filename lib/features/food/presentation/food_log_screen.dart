import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/bilingual_text.dart';
import '../../../core/storage/app_database.dart';
import '../../auth/data/auth_repository.dart';
import '../data/food_repository.dart';

class FoodLogScreen extends ConsumerWidget {
  const FoodLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const BilingualText(
          english: "Daily Food Log",
          hindi: "भोजन का विवरण",
          englishStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: userState.when(
        data: (user) {
          if (user == null) return const Center(child: Text("Please login."));
          final logsStream = ref.watch(foodRepositoryProvider).watchTodayLogs(user.$id);
          
          return StreamBuilder<List<FoodLog>>(
            stream: logsStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
              final logs = snapshot.data ?? [];
              
              if (logs.isEmpty) return _buildEmptyState(context);
              
              final breakfast = logs.where((l) => l.mealType == 'Breakfast').toList();
              final lunch = logs.where((l) => l.mealType == 'Lunch').toList();
              final dinner = logs.where((l) => l.mealType == 'Dinner').toList();
              final snacks = logs.where((l) => l.mealType == 'Snacks').toList();

              final totalCalories = logs.fold<double>(0, (sum, l) => sum + l.calories);

              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _buildSummaryCard(totalCalories, logs),
                  const SizedBox(height: 24),
                  _buildMealSection(context, "Breakfast", "नाश्ता", breakfast),
                  _buildMealSection(context, "Lunch", "दोपहर का भोजन", lunch),
                  _buildMealSection(context, "Dinner", "रात का खाना", dinner),
                  _buildMealSection(context, "Snacks", "अल्पाहार", snacks),
                ],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text("Error: $e")),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/food/search'),
        icon: const Icon(Icons.add),
        label: const Text("Log Food"),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  Widget _buildSummaryCard(double calories, List<FoodLog> logs) {
    final protein = logs.fold<double>(0, (sum, l) => sum + l.proteinG);
    final carbs = logs.fold<double>(0, (sum, l) => sum + l.carbsG);
    final fat = logs.fold<double>(0, (sum, l) => sum + l.fatG);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: Column(
        children: [
          const Text("Daily Progress", style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("${calories.toInt()} / 2000 kcal", style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _summaryItem("P", protein.toInt(), "g"),
              _summaryItem("C", carbs.toInt(), "g"),
              _summaryItem("F", fat.toInt(), "g"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(String label, int value, String unit) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
        Text("$value$unit", style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildMealSection(BuildContext context, String title, String hindi, List<FoodLog> meals) {
    final mealCals = meals.fold<double>(0, (sum, m) => sum + m.calories);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BilingualText(
              english: title,
              hindi: hindi,
              englishStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (mealCals > 0)
              Text("${mealCals.toInt()} kcal", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            if (mealCals == 0)
              IconButton(onPressed: () => context.push('/food/search', extra: title), icon: const Icon(Icons.add_circle_outline, color: AppColors.primary)),
          ],
        ),
        if (meals.isEmpty)
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text("No meals logged yet.", style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
        ...meals.map((m) => Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            title: Text(m.foodName),
            subtitle: Text("${m.quantityG.toInt()}g"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${m.calories.toInt()} kcal", style: const TextStyle(fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.close, size: 16, color: Colors.red),
                  onPressed: () => _confirmDelete(context, m),
                ),
              ],
            ),
          ),
        )),
        const SizedBox(height: 16),
      ],
    );
  }

  void _confirmDelete(BuildContext context, FoodLog log) {
    // Basic delete
    ProviderScope.containerOf(context).read(foodRepositoryProvider).deleteLog(log.id);
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.restaurant_menu, size: 80, color: Colors.grey),
          const SizedBox(height: 24),
          const BilingualText(
            english: "What's on the menu today?",
            hindi: "आज खाने में क्या है?",
            englishStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.push('/food/search'),
            child: const Text("Log your first meal"),
          ),
        ],
      ),
    );
  }
}
