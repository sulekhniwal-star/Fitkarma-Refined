import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' show Value;
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class RecipeFormScreen extends ConsumerStatefulWidget {
  final String userId;
  final int? recipeId;

  const RecipeFormScreen({super.key, required this.userId, this.recipeId});

  @override
  ConsumerState<RecipeFormScreen> createState() => _RecipeFormScreenState();
}

class _RecipeFormScreenState extends ConsumerState<RecipeFormScreen> {
  final _titleController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _servingsController = TextEditingController(text: '1');
  final _prepTimeController = TextEditingController();
  final _cookTimeController = TextEditingController();
  
  final _ingredients = <_IngredientEntry>[];
  String _cuisineType = 'North Indian';
  bool _isPublic = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _ingredients.add(_IngredientEntry());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeId == null ? 'New Recipe' : 'Edit Recipe'),
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
        actions: [
          if (_ingredients.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _isLoading ? null : _saveRecipe,
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Recipe Title *',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _servingsController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Servings',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _cuisineType,
                          decoration: const InputDecoration(
                            labelText: 'Cuisine',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            'North Indian', 'South Indian', 'Bengali', 'Gujarati', 'Other',
                          ].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                          onChanged: (v) => setState(() => _cuisineType = v!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _prepTimeController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Prep (min)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _cookTimeController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Cook (min)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Ingredients', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      TextButton.icon(
                        onPressed: () => setState(() => _ingredients.add(_IngredientEntry())),
                        icon: const Icon(Icons.add),
                        label: const Text('Add'),
                      ),
                    ],
                  ),
                  ..._ingredients.asMap().entries.map((e) => _buildIngredientRow(e.key, e.value)),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _instructionsController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Instructions',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Share with Community'),
                    subtitle: const Text('Make recipe public'),
                    value: _isPublic,
                    onChanged: (v) => setState(() => _isPublic = v),
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _saveRecipe,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Save Recipe'),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildIngredientRow(int index, _IngredientEntry entry) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              controller: entry.nameController,
              decoration: InputDecoration(
                labelText: 'Ingredient ${index + 1}',
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: entry.gramsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Grams',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
            onPressed: _ingredients.length > 1
                ? () => setState(() => _ingredients.removeAt(index))
                : null,
          ),
        ],
      ),
    );
  }

  Future<void> _saveRecipe() async {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title is required')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final db = ref.read(appDatabaseProvider);
      final ingredients = _ingredients
          .where((e) => e.nameController.text.isNotEmpty)
          .map((e) => RecipeIngredient(
                name: e.nameController.text,
                grams: double.tryParse(e.gramsController.text) ?? 100,
              ))
          .toList();

      final servings = int.tryParse(_servingsController.text) ?? 1;
      final prepTime = int.tryParse(_prepTimeController.text);
      final cookTime = int.tryParse(_cookTimeController.text);

      final macros = await db.recipesDao.createRecipeWithMacros(
        userId: widget.userId,
        title: _titleController.text,
        ingredients: ingredients,
        servings: servings,
        instructions: _instructionsController.text.isEmpty ? null : _instructionsController.text,
        isPublic: _isPublic,
        prepTimeMin: prepTime,
        cookTimeMin: cookTime,
        cuisineType: _cuisineType,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Recipe saved! ${macros.perServing.toStringAsFixed(0)} cal/serving'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _instructionsController.dispose();
    _servingsController.dispose();
    _prepTimeController.dispose();
    _cookTimeController.dispose();
    super.dispose();
  }
}

class _IngredientEntry {
  final nameController = TextEditingController();
  final gramsController = TextEditingController(text: '100');
}