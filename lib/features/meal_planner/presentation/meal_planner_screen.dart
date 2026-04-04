import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class MealPlannerScreen extends ConsumerWidget {
  final String userId;

  const MealPlannerScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planner'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => _showGroceryList(context, db),
          ),
          IconButton(
            icon: const Icon(Icons.auto_awesome),
            onPressed: () => _generatePlan(context, db),
          ),
        ],
      ),
      body: FutureBuilder(
        future: db.mealPlansDao.getCurrentWeekPlan(userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return _buildEmptyState(db, context);
          }
          return _buildWeekGrid(snapshot.data!);
        },
      ),
    );
  }

  Widget _buildEmptyState(AppDatabase db, BuildContext ctx) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.restaurant_menu, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          const Text('No meal plan for this week', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () => _generatePlan(ctx, db),
            icon: const Icon(Icons.auto_awesome),
            label: const Text('Generate Plan'),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekGrid(MealPlan plan) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 0.8,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: 7 * 4,
      itemBuilder: (context, index) {
        final dayIndex = index ~/ 4;
        final mealType = index % 4;
        final mealTypes = ['Breakfast', 'Lunch', 'Dinner', 'Snacks'];
        
        if (dayIndex == 0) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              mealTypes[mealType],
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          );
        }
        
        return _MealCell(
          day: dayIndex - 1,
          mealType: mealTypes[mealType],
          onTap: () => _logMeal(context, dayIndex - 1, mealTypes[mealType]),
        );
      },
    );
  }

  Widget _MealCell({required int day, required String mealType, required VoidCallback onTap}) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.lightSurface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(days[day], style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(mealType, style: const TextStyle(fontSize: 11)),
            const SizedBox(height: 4),
            const Icon(Icons.add_circle_outline, size: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _logMeal(BuildContext context, int day, String mealType) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logging $mealType for day $day')),
    );
  }

  Future<void> _generatePlan(BuildContext context, AppDatabase db) async {
    await db.mealPlansDao.generatePlan(userId: userId, tdee: 2000, cuisineType: 'North Indian');
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Meal plan generated!')),
      );
    }
  }

  Future<void> _showGroceryList(BuildContext context, AppDatabase db) async {
    final plan = await db.mealPlansDao.getCurrentWeekPlan(userId);
    if (plan == null) return;
    
    final groceries = await db.mealPlansDao.generateGroceryList(plan);
    
    if (context.mounted) {
      showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Grocery List', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: groceries.map((g) => Chip(label: Text(g))).toList(),
              ),
            ],
          ),
        ),
      );
    }
  }
}