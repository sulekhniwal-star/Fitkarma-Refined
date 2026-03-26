// lib/features/food/presentation/recipe_browser_screen.dart
// Recipe Browser screen for viewing saved and community recipes

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/food/data/food_providers.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

/// Recipe Browser Screen - View saved and community recipes
class RecipeBrowserScreen extends ConsumerStatefulWidget {
  const RecipeBrowserScreen({super.key});

  @override
  ConsumerState<RecipeBrowserScreen> createState() =>
      _RecipeBrowserScreenState();
}

class _RecipeBrowserScreenState extends ConsumerState<RecipeBrowserScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Recipes'),
        backgroundColor: AppColors.surface,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'My Recipes'),
            Tab(text: 'Community'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Create Recipe',
            onPressed: () => context.go('/food/recipes/new'),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_MyRecipesTab(), _CommunityRecipesTab()],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/food/recipes/new'),
        icon: const Icon(Icons.add),
        label: const Text('New Recipe'),
      ),
    );
  }
}

/// My Recipes Tab - Shows user's saved recipes
class _MyRecipesTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesAsync = ref.watch(userRecipesProvider);

    return recipesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (recipes) {
        if (recipes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.restaurant_menu,
                  size: 64,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(height: 16),
                const Text('No recipes yet', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                const Text('Create your first recipe!'),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => context.go('/food/recipes/new'),
                  icon: const Icon(Icons.add),
                  label: const Text('Create Recipe'),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final recipe = recipes[index];
            return _RecipeCard(recipe: recipe);
          },
        );
      },
    );
  }
}

/// Community Recipes Tab - Shows public recipes
class _CommunityRecipesTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesAsync = ref.watch(communityRecipesProvider);

    return recipesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (recipes) {
        if (recipes.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.people, size: 64, color: AppColors.textSecondary),
                SizedBox(height: 16),
                Text(
                  'No community recipes yet',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text('Be the first to share!'),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final recipe = recipes[index];
            return _RecipeCard(recipe: recipe, isCommunity: true);
          },
        );
      },
    );
  }
}

/// Recipe Card Widget
class _RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final bool isCommunity;

  const _RecipeCard({required this.recipe, this.isCommunity = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showRecipeDetails(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      recipe.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (isCommunity)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Community',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                ],
              ),
              if (recipe.description != null &&
                  recipe.description!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  recipe.description!,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildNutrientChip(
                    Icons.local_fire_department,
                    '${recipe.caloriesPerServing?.toStringAsFixed(0) ?? '0'} kcal',
                  ),
                  const SizedBox(width: 12),
                  _buildNutrientChip(
                    Icons.restaurant,
                    '${recipe.servings} srv',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildMacroChip('P', recipe.proteinPerServing),
                  const SizedBox(width: 8),
                  _buildMacroChip('C', recipe.carbsPerServing),
                  const SizedBox(width: 8),
                  _buildMacroChip('F', recipe.fatPerServing),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutrientChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildMacroChip(String label, double? value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        '$label: ${value?.toStringAsFixed(1) ?? '0'}g',
        style: const TextStyle(fontSize: 11),
      ),
    );
  }

  void _showRecipeDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  children: [
                    // Title
                    Text(
                      recipe.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (recipe.description != null &&
                        recipe.description!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        recipe.description!,
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
                    const SizedBox(height: 20),

                    // Nutrition Summary
                    const Text(
                      'Nutrition per Serving',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildNutritionRow(
                      'Calories',
                      '${recipe.caloriesPerServing?.toStringAsFixed(0) ?? '0'} kcal',
                    ),
                    _buildNutritionRow(
                      'Protein',
                      '${recipe.proteinPerServing?.toStringAsFixed(1) ?? '0'}g',
                    ),
                    _buildNutritionRow(
                      'Carbs',
                      '${recipe.carbsPerServing?.toStringAsFixed(1) ?? '0'}g',
                    ),
                    _buildNutritionRow(
                      'Fat',
                      '${recipe.fatPerServing?.toStringAsFixed(1) ?? '0'}g',
                    ),
                    if (recipe.fiberPerServing != null)
                      _buildNutritionRow(
                        'Fiber',
                        '${recipe.fiberPerServing?.toStringAsFixed(1) ?? '0'}g',
                      ),
                    const Divider(height: 32),

                    // Micronutrients
                    const Text(
                      'Micronutrients',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (recipe.vitaminDPerServing != null)
                      _buildNutritionRow(
                        'Vitamin D',
                        '${recipe.vitaminDPerServing?.toStringAsFixed(1) ?? '0'} mcg',
                      ),
                    if (recipe.vitaminB12PerServing != null)
                      _buildNutritionRow(
                        'Vitamin B12',
                        '${recipe.vitaminB12PerServing?.toStringAsFixed(1) ?? '0'} mcg',
                      ),
                    if (recipe.ironPerServing != null)
                      _buildNutritionRow(
                        'Iron',
                        '${recipe.ironPerServing?.toStringAsFixed(1) ?? '0'} mg',
                      ),
                    if (recipe.calciumPerServing != null)
                      _buildNutritionRow(
                        'Calcium',
                        '${recipe.calciumPerServing?.toStringAsFixed(1) ?? '0'} mg',
                      ),

                    const SizedBox(height: 24),

                    // Servings info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Servings',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text('${recipe.servings}'),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Log Recipe Button
                    if (!isCommunity)
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          context.go('/food/log');
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Log This Recipe'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
