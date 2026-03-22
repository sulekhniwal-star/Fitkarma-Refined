// lib/features/food/presentation/recipe_builder_screen.dart
// Recipe Builder screen for creating and saving recipes

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/food/data/food_providers.dart';
import 'package:fitkarma/features/food/data/recipe_service.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';
import 'package:go_router/go_router.dart';

/// Recipe Builder Screen - Create recipes with ingredients from food DB
class RecipeBuilderScreen extends ConsumerStatefulWidget {
  const RecipeBuilderScreen({super.key});

  @override
  ConsumerState<RecipeBuilderScreen> createState() =>
      _RecipeBuilderScreenState();
}

class _RecipeBuilderScreenState extends ConsumerState<RecipeBuilderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _servingsController = TextEditingController(text: '1');
  final _searchController = TextEditingController();
  final _instructionController = TextEditingController();

  bool _showFoodSearch = false;
  bool _showInstructions = false;
  List<FoodItem> _searchResults = [];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _servingsController.dispose();
    _searchController.dispose();
    _instructionController.dispose();
    super.dispose();
  }

  Future<void> _searchFood(String query) async {
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    try {
      final recipeService = ref.read(recipeServiceProvider);
      final db = await recipeService.db
          .select(recipeService.db.foodItems)
          .get();

      final results = db
          .where(
            (item) =>
                item.name.toLowerCase().contains(query.toLowerCase()) ||
                item.nameLocal.toLowerCase().contains(query.toLowerCase()),
          )
          .take(20)
          .toList();

      setState(() => _searchResults = results);
    } catch (e) {
      // Silent fail
    }
  }

  void _addIngredient(FoodItem food) {
    // Show quantity dialog
    showDialog(
      context: context,
      builder: (context) => _QuantityDialog(
        food: food,
        onAdd: (quantity) {
          ref
              .read(recipeBuilderProvider.notifier)
              .addIngredient(
                RecipeIngredient(
                  foodItemId: food.id,
                  name: food.name,
                  quantityG: quantity,
                ),
              );
          setState(() {
            _showFoodSearch = false;
            _searchController.clear();
            _searchResults = [];
          });
        },
      ),
    );
  }

  Future<void> _saveRecipe() async {
    if (!_formKey.currentState!.validate()) return;

    final builder = ref.read(recipeBuilderProvider.notifier);
    builder.setTitle(_titleController.text);
    builder.setDescription(
      _descriptionController.text.isEmpty ? null : _descriptionController.text,
    );
    builder.setServings(int.tryParse(_servingsController.text) ?? 1);

    final recipeId = await builder.saveRecipe();

    if (recipeId != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipe saved successfully!')),
      );
      context.go('/food/recipes');
    }
  }

  Future<void> _saveAndLogRecipe() async {
    if (!_formKey.currentState!.validate()) return;

    final builder = ref.read(recipeBuilderProvider.notifier);
    builder.setTitle(_titleController.text);
    builder.setDescription(
      _descriptionController.text.isEmpty ? null : _descriptionController.text,
    );
    builder.setServings(int.tryParse(_servingsController.text) ?? 1);

    final recipeId = await builder.saveRecipe();

    if (recipeId != null && mounted) {
      // Log the recipe as a single food entry
      final state = ref.read(recipeBuilderProvider);

      // Navigate to food log with recipe data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recipe saved! Tap to log it.'),
          action: SnackBarAction(
            label: 'Log Now',
            onPressed: () {
              context.go('/food/log');
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final recipeState = ref.watch(recipeBuilderProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Create Recipe'),
        backgroundColor: AppColors.surface,
        actions: [
          TextButton(onPressed: _saveRecipe, child: const Text('Save')),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Recipe Title
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Recipe Name *',
                hintText: 'e.g., Chicken Biryani',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a recipe name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Description
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                hintText: 'Brief description of the recipe',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),

            // Servings
            TextFormField(
              controller: _servingsController,
              decoration: const InputDecoration(
                labelText: 'Number of Servings',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final servings = int.tryParse(value) ?? 1;
                ref.read(recipeBuilderProvider.notifier).setServings(servings);
              },
            ),
            const SizedBox(height: 24),

            // Ingredients Section
            _buildSectionHeader(
              'Ingredients',
              action: IconButton(
                icon: Icon(_showFoodSearch ? Icons.close : Icons.add),
                onPressed: () =>
                    setState(() => _showFoodSearch = !_showFoodSearch),
              ),
            ),

            if (_showFoodSearch) ...[
              const SizedBox(height: 8),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search foods...',
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _searchResults = []);
                    },
                  ),
                ),
                onChanged: _searchFood,
              ),
              if (_searchResults.isNotEmpty) ...[
                const SizedBox(height: 8),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final food = _searchResults[index];
                      return ListTile(
                        title: Text(food.name),
                        subtitle: Text(
                          '${food.caloriesPer100g.toStringAsFixed(0)} cal/100g',
                        ),
                        trailing: const Icon(Icons.add_circle_outline),
                        onTap: () => _addIngredient(food),
                      );
                    },
                  ),
                ),
              ],
            ],

            const SizedBox(height: 8),

            // Ingredients List
            if (recipeState.ingredients.isEmpty)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Center(
                  child: Text(
                    'No ingredients added yet.\nTap + to add ingredients.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              )
            else
              ...recipeState.ingredients.asMap().entries.map((entry) {
                final index = entry.key;
                final ingredient = entry.value;
                return _buildIngredientTile(ingredient, index);
              }),

            const SizedBox(height: 24),

            // Instructions Section
            _buildSectionHeader(
              'Instructions',
              action: IconButton(
                icon: Icon(_showInstructions ? Icons.close : Icons.add),
                onPressed: () =>
                    setState(() => _showInstructions = !_showInstructions),
              ),
            ),

            if (_showInstructions) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _instructionController,
                      decoration: const InputDecoration(
                        hintText: 'Add a step...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (_instructionController.text.isNotEmpty) {
                        ref
                            .read(recipeBuilderProvider.notifier)
                            .addInstruction(_instructionController.text);
                        _instructionController.clear();
                      }
                    },
                  ),
                ],
              ),
            ],

            const SizedBox(height: 8),

            // Instructions List
            ...recipeState.instructions.asMap().entries.map((entry) {
              final index = entry.key;
              final instruction = entry.value;
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 14,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  title: Text(instruction),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: AppColors.error,
                    ),
                    onPressed: () {
                      ref
                          .read(recipeBuilderProvider.notifier)
                          .removeInstruction(index);
                    },
                  ),
                ),
              );
            }),

            const SizedBox(height: 24),

            // Nutrition Summary
            _buildSectionHeader('Nutrition per Serving'),
            const SizedBox(height: 8),
            _buildNutritionCard(recipeState),

            const SizedBox(height: 24),

            // Community Sharing Toggle
            Card(
              child: SwitchListTile(
                title: const Text('Share with Community'),
                subtitle: const Text('Make this recipe visible to other users'),
                value: recipeState.isPublic,
                onChanged: (value) {
                  ref.read(recipeBuilderProvider.notifier).setPublic(value);
                },
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _saveRecipe,
                    child: const Text('Save Recipe'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveAndLogRecipe,
                    child: const Text('Save & Log'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {Widget? action}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        if (action != null) action,
      ],
    );
  }

  Widget _buildIngredientTile(RecipeIngredient ingredient, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(ingredient.name),
        subtitle: Text('${ingredient.quantityG.toStringAsFixed(0)}g'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => _QuantityDialog(
                    food: null,
                    initialQuantity: ingredient.quantityG,
                    foodName: ingredient.name,
                    onAdd: (quantity) {
                      ref
                          .read(recipeBuilderProvider.notifier)
                          .updateIngredientQuantity(index, quantity);
                    },
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.error),
              onPressed: () {
                ref
                    .read(recipeBuilderProvider.notifier)
                    .removeIngredient(index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionCard(RecipeBuilderState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calories - prominent
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Calories',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${state.caloriesPerServing.toStringAsFixed(0)} kcal',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const Divider(),

            // Macros
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMacroItem('Protein', state.proteinPerServing, 'g'),
                _buildMacroItem('Carbs', state.carbsPerServing, 'g'),
                _buildMacroItem('Fat', state.fatPerServing, 'g'),
                _buildMacroItem('Fiber', state.fiberPerServing ?? 0, 'g'),
              ],
            ),

            // Micronutrients
            const Divider(),
            const Text(
              'Micronutrients',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _buildMicroItem('Vitamin D', state.vitaminDPerServing, 'mcg'),
                _buildMicroItem(
                  'Vitamin B12',
                  state.vitaminB12PerServing,
                  'mcg',
                ),
                _buildMicroItem('Iron', state.ironPerServing, 'mg'),
                _buildMicroItem('Calcium', state.calciumPerServing, 'mg'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroItem(String label, double value, String unit) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        Text(
          '${value.toStringAsFixed(1)}$unit',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildMicroItem(String label, double? value, String unit) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$label: ', style: const TextStyle(fontSize: 12)),
        Text(
          '${(value ?? 0).toStringAsFixed(1)}$unit',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

/// Dialog for entering ingredient quantity
class _QuantityDialog extends StatefulWidget {
  final FoodItem? food;
  final String? foodName;
  final double? initialQuantity;
  final Function(double) onAdd;

  const _QuantityDialog({
    this.food,
    this.foodName,
    this.initialQuantity,
    required this.onAdd,
  });

  @override
  State<_QuantityDialog> createState() => _QuantityDialogState();
}

class _QuantityDialogState extends State<_QuantityDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialQuantity?.toStringAsFixed(0) ?? '100',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final foodName = widget.food?.name ?? widget.foodName ?? '';

    return AlertDialog(
      title: Text('Add $foodName'),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Quantity (grams)',
          suffixText: 'g',
        ),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final quantity = double.tryParse(_controller.text) ?? 100;
            widget.onAdd(quantity);
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
