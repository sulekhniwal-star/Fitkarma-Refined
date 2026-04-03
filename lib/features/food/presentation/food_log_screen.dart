import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/food/data/food_repository.dart';
import 'package:fitkarma/features/food/domain/food_log_model.dart';

class MealTypeNotifier extends Notifier<String> {
  @override
  String build() => 'breakfast';

  void setMealType(String type) => state = type;
}

final mealTypeProvider = NotifierProvider<MealTypeNotifier, String>(() => MealTypeNotifier());

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) => state = query;
}

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(() => SearchQueryNotifier());

final foodSearchResultsProvider = FutureProvider<List<FoodItemModel>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.length < 2) return [];
  
  final repo = ref.read(foodRepositoryProvider);
  final items = await repo.searchFoods(query);
  return items.map((i) => FoodItemModel.fromDrift(i)).toList();
});

class FoodLogScreen extends ConsumerWidget {
  const FoodLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealType = ref.watch(mealTypeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Log ${_mealTypeLabel(mealType)}'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.content_copy),
            onPressed: () => _copyYesterdayMeals(context, ref),
            tooltip: 'Copy yesterday\'s meals',
          ),
        ],
      ),
      body: Column(
        children: [
          _SearchBar(),
          _QuickActionChips(),
          Expanded(
            child: _FoodList(),
          ),
        ],
      ),
    );
  }

  String _mealTypeLabel(String type) {
    switch (type) {
      case 'breakfast':
        return 'Breakfast 🌅';
      case 'lunch':
        return 'Lunch ☀️';
      case 'dinner':
        return 'Dinner 🌙';
      case 'snack':
        return 'Snack 🍪';
      default:
        return 'Meal';
    }
  }

  Future<void> _copyYesterdayMeals(BuildContext context, WidgetRef ref) async {
    try {
      final repo = ref.read(foodRepositoryProvider);
      // TODO: Implement copy yesterday logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Yesterday\'s meals copied!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class _SearchBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: (v) => ref.read(searchQueryProvider.notifier).state = v,
        decoration: InputDecoration(
          hintText: 'Search Indian foods...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: query.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => ref.read(searchQueryProvider.notifier).state = '',
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
      ),
    );
  }
}

class _QuickActionChips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _ActionChip(
            icon: Icons.camera_alt,
            label: 'Scan Label',
            onTap: () => _showScanSheet(context),
          ),
          const SizedBox(width: 8),
          _ActionChip(
            icon: Icons.photo_camera,
            label: 'Upload Photo',
            onTap: () => _showUploadSheet(context),
          ),
          const SizedBox(width: 8),
          _ActionChip(
            icon: Icons.edit,
            label: 'Manual Entry',
            onTap: () => _showManualEntrySheet(context),
          ),
        ],
      ),
    );
  }

  void _showScanSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const _PlaceholderSheet('Scan Label'),
    );
  }

  void _showUploadSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const _PlaceholderSheet('Upload Photo'),
    );
  }

  void _showManualEntrySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const _ManualEntrySheet(),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onPressed: onTap,
    );
  }
}

class _FoodList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);

    if (query.length < 2) {
      return const _EmptyState();
    }

    final resultsAsync = ref.watch(foodSearchResultsProvider);

    return resultsAsync.when(
      data: (items) {
        if (items.isEmpty) {
          return const Center(child: Text('No foods found'));
        }
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return _FoodItemTile(
              item: item,
              onTap: () => _showPortionSheet(context, item),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }

  void _showPortionSheet(BuildContext context, FoodItemModel item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _PortionSheet(item: item),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'Search for foods',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Text(
            'Type at least 2 characters',
            style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _FoodItemTile extends StatelessWidget {
  final FoodItemModel item;
  final VoidCallback onTap;

  const _FoodItemTile({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text(item.formattedNutrition),
      trailing: Text(
        item.regionEmoji,
        style: const TextStyle(fontSize: 20),
      ),
      onTap: onTap,
    );
  }
}

class _PortionSheet extends StatefulWidget {
  final FoodItemModel item;

  const _PortionSheet({required this.item});

  @override
  State<_PortionSheet> createState() => _PortionSheetState();
}

class _PortionSheetState extends State<_PortionSheet> {
  double _portionMultiplier = 1.0;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final portionG = (100 * _portionMultiplier).toInt();

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          if (item.nameLocal != null) Text(item.nameLocal!),
          const SizedBox(height: 16),
          Text('Portion: ${portionG}g'),
          Slider(
            value: _portionMultiplier,
            min: 0.25,
            max: 3.0,
            divisions: 11,
            label: '${portionG}g',
            onChanged: (v) => setState(() => _portionMultiplier = v),
          ),
          const SizedBox(height: 16),
          _buildMacroRow('Calories', '${(item.caloriesPer100g * _portionMultiplier).toInt()} kcal'),
          _buildMacroRow('Protein', '${(item.proteinPer100g * _portionMultiplier).toInt()}g'),
          _buildMacroRow('Carbs', '${(item.carbsPer100g * _portionMultiplier).toInt()}g'),
          _buildMacroRow('Fat', '${(item.fatPer100g * _portionMultiplier).toInt()}g'),
          const SizedBox(height: 8),
          _buildMicroRow('Vitamin D', '${(item.vitaminDMcg * _portionMultiplier).toStringAsFixed(1)} mcg'),
          _buildMicroRow('Vitamin B12', '${(item.vitaminB12Mcg * _portionMultiplier).toStringAsFixed(1)} mcg'),
          _buildMicroRow('Iron', '${(item.ironMg * _portionMultiplier).toStringAsFixed(1)} mg'),
          _buildMicroRow('Calcium', '${(item.calciumMg * _portionMultiplier).toStringAsFixed(1)} mg'),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => _logFood(context),
              child: const Text('Log Meal'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildMicroRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          Text(value, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        ],
      ),
    );
  }

  Future<void> _logFood(BuildContext context) async {
    try {
      // TODO: Log to repository
      // Award XP
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Meal logged! +10 XP'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }
}

class _ManualEntrySheet extends StatefulWidget {
  const _ManualEntrySheet();

  @override
  State<_ManualEntrySheet> createState() => _ManualEntrySheetState();
}

class _ManualEntrySheetState extends State<_ManualEntrySheet> {
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manual Entry',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Food Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _caloriesController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Calories',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _proteinController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Protein (g)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _carbsController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Carbs (g)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _fatController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Fat (g)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => _logManualEntry(context),
                child: const Text('Log Meal'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logManualEntry(BuildContext context) async {
    // TODO: Implement manual entry logging
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Meal logged! +10 XP')),
    );
  }
}

class _PlaceholderSheet extends StatelessWidget {
  final String title;

  const _PlaceholderSheet(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          const Text('Coming soon!'),
        ],
      ),
    );
  }
}