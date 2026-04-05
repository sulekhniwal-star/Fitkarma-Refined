import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/bilingual_text.dart';
import '../../../core/storage/app_database.dart';
import '../../auth/data/auth_repository.dart';
import '../data/food_repository.dart';

class FoodDetailScreen extends ConsumerStatefulWidget {
  final FoodItem item;
  final String? mealType;

  const FoodDetailScreen({super.key, required this.item, this.mealType});

  @override
  ConsumerState<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends ConsumerState<FoodDetailScreen> {
  double _quantity = 100.0;
  String _selectedUnit = 'grams';
  List<dynamic> _servingSizes = [];

  @override
  void initState() {
    super.initState();
    if (widget.item.servingSizes != null) {
      try {
        _servingSizes = json.decode(widget.item.servingSizes!);
        if (_servingSizes.isNotEmpty) {
          _selectedUnit = _servingSizes.first['name'];
          _quantity = (_servingSizes.first['grams'] as num).toDouble();
        }
      } catch (_) {}
    }
  }

  void _onUnitChanged(String? unit) {
    if (unit == null) return;
    setState(() {
      _selectedUnit = unit;
      if (unit == 'grams') {
        _quantity = 100.0;
      } else {
        final size = _servingSizes.firstWhere((s) => s['name'] == unit);
        _quantity = (size['grams'] as num).toDouble();
      }
    });
  }

  // Adjusted logic: quantity is 'multiplier', grams is the final amount.
  double _getGrams(double multiplier, String unit) {
    if (unit == 'grams') return multiplier;
    final size = _servingSizes.firstWhere((s) => s['name'] == unit, orElse: () => {'grams': 100});
    return multiplier * (size['grams'] as num).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final grams = _getGrams(_quantity, _selectedUnit);
    final scale = grams / 100.0;
    final calories = widget.item.caloriesPer100g * scale;
    final protein = widget.item.proteinPer100g * scale;
    final carbs = widget.item.carbsPer100g * scale;
    final fat = widget.item.fatPer100g * scale;

    return Scaffold(
      appBar: AppBar(title: Text(widget.item.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(calories),
            const SizedBox(height: 24),
            _buildPortionSelector(),
            const SizedBox(height: 24),
            const Text("Macros", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildMacrosTable(protein, carbs, fat),
            const SizedBox(height: 24),
            const Text("Micronutrients", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildMicros(scale),
            const SizedBox(height: 40),
            _buildLogButton(grams),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(double calories) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)]),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.item.nameLocal ?? widget.item.region ?? '', style: const TextStyle(color: Colors.white70)),
              Text(widget.item.name, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
          Text("${calories.toInt()} kcal", style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildPortionSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Portion", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                onChanged: (v) => setState(() => _quantity = double.tryParse(v) ?? 0.0),
                controller: TextEditingController(text: _quantity.toStringAsFixed(0))..selection = TextSelection.collapsed(offset: _quantity.toStringAsFixed(0).length),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<String>(
                initialValue: _selectedUnit,
                items: [
                  const DropdownMenuItem(value: 'grams', child: Text('grams')),
                  ..._servingSizes.map((s) => DropdownMenuItem(value: s['name'] as String, child: Text(s['name']))),
                ],
                onChanged: _onUnitChanged,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMacrosTable(double protein, double carbs, double fat) {
    return Row(
      children: [
        _macroCard("Protein", protein, "g", Colors.purple),
        _macroCard("Carbs", carbs, "g", Colors.orange),
        _macroCard("Fat", fat, "g", Colors.red),
      ],
    );
  }

  Widget _macroCard(String label, double value, String unit, Color color) {
    return Expanded(
      child: Card(
        color: color.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text("${value.toStringAsFixed(1)} $unit", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMicros(double scale) {
    final iron = (widget.item.ironPer100g ?? 0) * scale;
    final calcium = (widget.item.calciumPer100g ?? 0) * scale;
    final vitD = (widget.item.vitaminDPer100g ?? 0) * scale;
    final vitB12 = (widget.item.vitaminB12Per100g ?? 0) * scale;

    return Column(
      children: [
        _microRow("Iron", iron, "mg"),
        _microRow("Calcium", calcium, "mg"),
        _microRow("Vitamin D", vitD, "mcg"),
        _microRow("Vitamin B12", vitB12, "mcg"),
      ],
    );
  }

  Widget _microRow(String label, double value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text("${value.toStringAsFixed(2)} $unit", style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildLogButton(double grams) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: () async {
          final user = await ref.read(currentUserProvider.future);
          if (user == null) return;
          
          await ref.read(foodRepositoryProvider).logFood(
            userId: user.$id,
            item: widget.item,
            quantityG: grams,
            mealType: widget.mealType ?? 'Snack',
            logMethod: 'manual',
          );
          
          if (mounted) context.pop();
        },
        child: const Text("Log This Meal", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
