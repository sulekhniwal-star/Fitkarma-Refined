// lib/features/meal_planner/presentation/meal_planner_screen.dart
// 7-day meal planner grid UI

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:fitkarma/features/meal_planner/data/meal_planner_providers.dart';
import 'package:fitkarma/features/meal_planner/data/indian_meal_templates.dart';
import 'package:fitkarma/features/food/data/food_providers.dart';

class MealPlannerScreen extends ConsumerStatefulWidget {
  const MealPlannerScreen({super.key});

  @override
  ConsumerState<MealPlannerScreen> createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends ConsumerState<MealPlannerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _mealTypes = ['breakfast', 'lunch', 'dinner', 'snack'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final plannerState = ref.watch(mealPlannerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planner'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => _showGroceryList(context),
            tooltip: 'Grocery List',
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) => _handleMenuAction(context, value),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'regenerate',
                child: ListTile(
                  leading: Icon(Icons.refresh),
                  title: Text('Regenerate Plan'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'cuisine',
                child: ListTile(
                  leading: Icon(Icons.restaurant),
                  title: Text('Change Cuisine'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Breakfast', icon: Icon(Icons.wb_sunny_outlined)),
            Tab(text: 'Lunch', icon: Icon(Icons.wb_sunny)),
            Tab(text: 'Dinner', icon: Icon(Icons.nightlight_outlined)),
            Tab(text: 'Snacks', icon: Icon(Icons.cookie_outlined)),
          ],
        ),
      ),
      body: plannerState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildWeekSelector(context, plannerState),
                _buildDailySummary(context, plannerState),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: _mealTypes.map((mealType) {
                      return _buildMealList(context, plannerState, mealType);
                    }).toList(),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddMealDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Meal'),
      ),
    );
  }

  Widget _buildWeekSelector(BuildContext context, MealPlannerState state) {
    final weekStart = state.currentPlan?.weekStartDate ?? DateTime.now();
    final weekEnd = weekStart.add(const Duration(days: 6));
    final dateFormat = DateFormat('MMM d');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              // Navigate to previous week
            },
          ),
          Text(
            '${dateFormat.format(weekStart)} - ${dateFormat.format(weekEnd)}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              // Navigate to next week
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDailySummary(BuildContext context, MealPlannerState state) {
    final dateFormat = DateFormat('EEE\nd');
    final weekStart = state.currentPlan?.weekStartDate ?? DateTime.now();
    final selectedDate = state.selectedDate;

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          final date = weekStart.add(Duration(days: index));
          final isSelected =
              date.day == selectedDate.day &&
              date.month == selectedDate.month &&
              date.year == selectedDate.year;

          return GestureDetector(
            onTap: () {
              ref.read(mealPlannerProvider.notifier).setSelectedDate(date);
            },
            child: Container(
              width: 50,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  dateFormat.format(date),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMealList(
    BuildContext context,
    MealPlannerState state,
    String mealType,
  ) {
    final meals = state.entries
        .where(
          (e) => e.mealType == mealType && e.date.day == state.selectedDate.day,
        )
        .toList();

    if (meals.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No ${mealType} planned',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => _showMealSuggestions(context, mealType),
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Get Suggestions'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];
        return _buildMealCard(context, meal, state);
      },
    );
  }

  Widget _buildMealCard(
    BuildContext context,
    dynamic meal,
    MealPlannerState state,
  ) {
    final theme = Theme.of(context);
    final status = meal.status; // 'planned', 'logged', 'skipped'

    Color statusColor;
    IconData statusIcon;
    switch (status) {
      case 'logged':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'skipped':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = Colors.orange;
        statusIcon = Icons.schedule;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _handleMealTap(context, meal),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '${meal.calories.toInt()}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(meal.foodName, style: theme.textTheme.titleMedium),
                    if (meal.foodNameLocal != null)
                      Text(
                        meal.foodNameLocal!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildNutrientChip(
                          context,
                          'P',
                          '${meal.proteinG.toInt()}g',
                        ),
                        const SizedBox(width: 8),
                        _buildNutrientChip(
                          context,
                          'C',
                          '${meal.carbsG.toInt()}g',
                        ),
                        const SizedBox(width: 8),
                        _buildNutrientChip(
                          context,
                          'F',
                          '${meal.fatG.toInt()}g',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Icon(statusIcon, color: statusColor, size: 20),
                  const SizedBox(height: 4),
                  Text(
                    '${meal.quantityG.toInt()}g',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutrientChip(BuildContext context, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _handleMealTap(BuildContext context, dynamic meal) {
    if (meal.status == 'planned') {
      showModalBottomSheet(
        context: context,
        builder: (context) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.check_circle),
                title: const Text('Log Meal'),
                subtitle: const Text('Tap to log this meal'),
                onTap: () {
                  Navigator.pop(context);
                  ref.read(mealPlannerProvider.notifier).logPlannedMeal(meal);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Meal logged! +15 XP'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.skip_next),
                title: const Text('Skip'),
                subtitle: const Text('Mark as skipped'),
                onTap: () {
                  Navigator.pop(context);
                  ref.read(mealPlannerProvider.notifier).skipMeal(meal.id);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                subtitle: const Text('Modify portion or meal'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to edit screen
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ref
                      .read(mealPlannerProvider.notifier)
                      .deleteMealEntry(meal.id);
                },
              ),
            ],
          ),
        ),
      );
    }
  }

  void _showAddMealDialog(BuildContext context) {
    final mealType = _mealTypes[_tabController.index];
    _showMealSuggestions(context, mealType);
  }

  void _showMealSuggestions(BuildContext context, String mealType) {
    final state = ref.read(mealPlannerProvider);
    final region = state.cuisineRegion;

    // Get suggestions based on region and meal type
    final suggestions = IndianMealTemplates.getTemplatesForMealType(
      mealType,
      region,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    'Add $mealType',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final meal = suggestions[index];
                  return ListTile(
                    title: Text(meal.name),
                    subtitle: Text(meal.nameLocal),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${meal.caloriesPer100g.toInt()} cal'),
                        Text(
                          'per 100g',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _showPortionDialog(context, meal);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPortionDialog(BuildContext context, MealTemplate meal) {
    double portion = 150; // Default portion in grams

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final nutrients = meal.getScaledNutrients(portion);

          return AlertDialog(
            title: Text(meal.name),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${portion.toInt()}g',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Slider(
                  value: portion,
                  min: 50,
                  max: 500,
                  divisions: 18,
                  label: '${portion.toInt()}g',
                  onChanged: (value) {
                    setState(() => portion = value);
                  },
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNutritionInfo(
                      'Calories',
                      '${nutrients['calories']!.toInt()}',
                    ),
                    _buildNutritionInfo(
                      'Protein',
                      '${nutrients['proteinG']!.toInt()}g',
                    ),
                    _buildNutritionInfo(
                      'Carbs',
                      '${nutrients['carbsG']!.toInt()}g',
                    ),
                    _buildNutritionInfo(
                      'Fat',
                      '${nutrients['fatG']!.toInt()}g',
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  ref
                      .read(mealPlannerProvider.notifier)
                      .addMealEntry(
                        mealType: meal.mealType,
                        foodName: meal.name,
                        foodNameLocal: meal.nameLocal,
                        quantityG: portion,
                        calories: nutrients['calories']!,
                        proteinG: nutrients['proteinG']!,
                        carbsG: nutrients['carbsG']!,
                        fatG: nutrients['fatG']!,
                        fiberG: nutrients['fiberG'],
                        vitaminDMcg: nutrients['vitaminDMcg'],
                        vitaminB12Mcg: nutrients['vitaminB12Mcg'],
                        ironMg: nutrients['ironMg'],
                        calciumMg: nutrients['calciumMg'],
                        region: meal.region,
                      );
                },
                child: const Text('Add to Plan'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNutritionInfo(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ],
    );
  }

  void _showGroceryList(BuildContext context) {
    final state = ref.read(mealPlannerProvider);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.shopping_cart),
                  const SizedBox(width: 8),
                  Text(
                    'Grocery List',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  FilledButton.icon(
                    onPressed: () {
                      // Generate grocery list
                      if (state.currentPlan != null) {
                        ref.invalidate(
                          generateGroceryListProvider(state.currentPlan!.id),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Grocery list generated!'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Generate'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_basket_outlined,
                      size: 64,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Generate grocery list from your meal plan',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'regenerate':
        _showRegenerateConfirmation(context);
        break;
      case 'cuisine':
        _showCuisineSelector(context);
        break;
    }
  }

  void _showRegenerateConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Regenerate Plan'),
        content: const Text(
          'This will create a new meal plan based on your TDEE and dosha. Your current plan will be replaced.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement regenerate
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Plan regenerated!')),
              );
            },
            child: const Text('Regenerate'),
          ),
        ],
      ),
    );
  }

  void _showCuisineSelector(BuildContext context) {
    final cuisines = [
      {'id': 'north_indian', 'name': 'North Indian', 'icon': '🛕'},
      {'id': 'south_indian', 'name': 'South Indian', 'icon': '🪷'},
      {'id': 'bengali', 'name': 'Bengali', 'icon': '🪷'},
      {'id': 'gujarati', 'name': 'Gujarati', 'icon': '🪔'},
      {'id': 'mixed', 'name': 'Mixed', 'icon': '🍛'},
    ];

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Select Cuisine',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ...cuisines.map(
              (cuisine) => ListTile(
                leading: Text(
                  cuisine['icon']!,
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(cuisine['name']!),
                onTap: () {
                  Navigator.pop(context);
                  ref
                      .read(mealPlannerProvider.notifier)
                      .changeCuisineRegion(cuisine['id']!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
