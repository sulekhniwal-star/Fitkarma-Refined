// lib/features/food/presentation/manual_entry_sheet.dart
// Manual food entry bottom sheet

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/food/data/food_providers.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

/// Manual entry bottom sheet for logging custom food items
class ManualEntrySheet extends ConsumerStatefulWidget {
  const ManualEntrySheet({super.key});

  @override
  ConsumerState<ManualEntrySheet> createState() => _ManualEntrySheetState();
}

class _ManualEntrySheetState extends ConsumerState<ManualEntrySheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController(text: '100');
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatController = TextEditingController();
  final _fiberController = TextEditingController();
  final _vitaminDController = TextEditingController();
  final _vitaminB12Controller = TextEditingController();
  final _ironController = TextEditingController();
  final _calciumController = TextEditingController();

  bool _showMicronutrients = false;

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    _fiberController.dispose();
    _vitaminDController.dispose();
    _vitaminB12Controller.dispose();
    _ironController.dispose();
    _calciumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final foodState = ref.watch(foodLogProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
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

          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                Text('Manual Entry', style: AppTextStyles.h4),
                TextButton(onPressed: _saveEntry, child: const Text('Save')),
              ],
            ),
          ),

          // Form
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Food name
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Food Name / नाम',
                        hintText: 'e.g., Dal Tadka',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter food name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Quantity
                    TextFormField(
                      controller: _quantityController,
                      decoration: const InputDecoration(
                        labelText: 'Quantity (gms)',
                        suffixText: 'g',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter quantity';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Macro nutrients section
                    Text(
                      'Macronutrients (per 100g)',
                      style: AppTextStyles.sectionHeader,
                    ),
                    const SizedBox(height: 12),

                    // Calories
                    TextFormField(
                      controller: _caloriesController,
                      decoration: const InputDecoration(
                        labelText: 'Calories',
                        suffixText: 'kcal',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter calories';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // Protein, Carbs, Fat row
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _proteinController,
                            decoration: const InputDecoration(
                              labelText: 'Protein',
                              suffixText: 'g',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _carbsController,
                            decoration: const InputDecoration(
                              labelText: 'Carbs',
                              suffixText: 'g',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _fatController,
                            decoration: const InputDecoration(
                              labelText: 'Fat',
                              suffixText: 'g',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Show more micronutrients toggle
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _showMicronutrients = !_showMicronutrients;
                        });
                      },
                      icon: Icon(
                        _showMicronutrients
                            ? Icons.expand_less
                            : Icons.expand_more,
                      ),
                      label: Text(
                        _showMicronutrients
                            ? 'Hide Micronutrients'
                            : 'Show Micronutrients',
                      ),
                    ),

                    // Micronutrients section
                    if (_showMicronutrients) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Micronutrients (optional)',
                        style: AppTextStyles.sectionHeader,
                      ),
                      const SizedBox(height: 12),

                      // Fiber
                      TextFormField(
                        controller: _fiberController,
                        decoration: const InputDecoration(
                          labelText: 'Fiber',
                          suffixText: 'g',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),

                      // Vitamin D, B12 row
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _vitaminDController,
                              decoration: const InputDecoration(
                                labelText: 'Vitamin D',
                                suffixText: 'mcg',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _vitaminB12Controller,
                              decoration: const InputDecoration(
                                labelText: 'Vitamin B12',
                                suffixText: 'mcg',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Iron, Calcium row
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _ironController,
                              decoration: const InputDecoration(
                                labelText: 'Iron',
                                suffixText: 'mg',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _calciumController,
                              decoration: const InputDecoration(
                                labelText: 'Calcium',
                                suffixText: 'mg',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 32),

                    // Save button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveEntry,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Log Food (+10 XP)',
                          style: AppTextStyles.buttonLarge,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveEntry() async {
    if (!_formKey.currentState!.validate()) return;

    final quantity = double.parse(_quantityController.text);
    final scale = quantity / 100; // Scale nutrients based on portion

    // Calculate scaled values
    final calories = double.tryParse(_caloriesController.text) ?? 0;
    final protein = double.tryParse(_proteinController.text) ?? 0;
    final carbs = double.tryParse(_carbsController.text) ?? 0;
    final fat = double.tryParse(_fatController.text) ?? 0;
    final fiber = double.tryParse(_fiberController.text);
    final vitaminD = double.tryParse(_vitaminDController.text);
    final vitaminB12 = double.tryParse(_vitaminB12Controller.text);
    final iron = double.tryParse(_ironController.text);
    final calcium = double.tryParse(_calciumController.text);

    await ref
        .read(foodLogProvider.notifier)
        .logFood(
          foodName: _nameController.text,
          quantityG: quantity,
          calories: calories * scale,
          proteinG: protein * scale,
          carbsG: carbs * scale,
          fatG: fat * scale,
          fiberG: fiber != null ? fiber * scale : null,
          vitaminDMcg: vitaminD != null ? vitaminD * scale : null,
          vitaminB12Mcg: vitaminB12 != null ? vitaminB12 * scale : null,
          ironMg: iron != null ? iron * scale : null,
          calciumMg: calcium != null ? calcium * scale : null,
        );

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('+10 XP earned! 🎉'),
          backgroundColor: AppColors.primary,
        ),
      );
    }
  }
}
