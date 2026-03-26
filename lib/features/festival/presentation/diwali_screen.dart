// lib/features/festival/presentation/diwali_screen.dart
// Diwali sweet calorie tracker + healthy alternatives

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/festival/data/festival_data.dart';
import 'package:fitkarma/features/festival/data/festival_providers.dart';

class DiwaliScreen extends ConsumerWidget {
  const DiwaliScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sweetTracker = ref.watch(diwaliSweetTrackerProvider);
    final totalCalories = sweetTracker.totalCalories;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diwali'),
        backgroundColor: const Color(0xFFFF9800),
        foregroundColor: Colors.white,
        actions: [
          if (sweetTracker.entries.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                ref.read(diwaliSweetTrackerProvider.notifier).clearAll();
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Calories Card
            Card(
              color: const Color(0xFFFF9800),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Sweets Calories',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        Text(
                          '${totalCalories.toInt()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'calories consumed',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.lightbulb,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Add Sweet Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showAddSweetDialog(context, ref),
                icon: const Icon(Icons.add),
                label: const Text('Add Sweet'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9800),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Logged Sweets
            const Text(
              'Logged Sweets',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            if (sweetTracker.entries.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.cake_outlined, size: 48, color: Colors.grey),
                        SizedBox(height: 8),
                        Text(
                          'No sweets logged yet',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              ...sweetTracker.entries.asMap().entries.map((entry) {
                final index = entry.key;
                final sweet = entry.value;
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF9800).withAlpha(30),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.cake, color: Color(0xFFFF9800)),
                    ),
                    title: Text(sweet.sweetName),
                    subtitle: Text('${sweet.quantityG.toInt()}g'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${sweet.calories.toInt()} cal',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 18),
                          onPressed: () {
                            ref
                                .read(diwaliSweetTrackerProvider.notifier)
                                .removeSweet(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),

            const SizedBox(height: 24),

            // Traditional Sweets
            const Text(
              'Traditional Sweets',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildSweetsList(isHealthy: false),

            const SizedBox(height: 24),

            // Healthy Alternatives
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withAlpha(20),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.withAlpha(50)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.eco, color: Colors.green),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Healthy Alternatives - Lower calorie options!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _buildSweetsList(isHealthy: true),

            const SizedBox(height: 24),

            // Guidelines
            const Text(
              'Diwali Health Tips',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildGuidelines(),
          ],
        ),
      ),
    );
  }

  Widget _buildSweetsList({required bool isHealthy}) {
    final sweets = FestivalDatabase()
        .getFestivalsForYear(DateTime.now().year)
        .where((f) => f.type == FestivalType.diwali)
        .expand(
          (f) => isHealthy
              ? (f.healthyAlternatives ?? [])
              : (f.recommendedFoods ?? []),
        )
        .toList();

    if (sweets.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No sweets available'),
        ),
      );
    }

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sweets.length,
        itemBuilder: (context, index) {
          final sweet = sweets[index];
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 12),
            child: Card(
              color: isHealthy ? Colors.green.withAlpha(20) : null,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (isHealthy)
                          const Icon(Icons.eco, color: Colors.green, size: 16),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            sweet.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      sweet.nameHindi,
                      style: TextStyle(color: Colors.grey[600], fontSize: 11),
                    ),
                    const Spacer(),
                    Text(
                      '${sweet.caloriesPer100g.toInt()} cal/100g',
                      style: TextStyle(
                        color: isHealthy
                            ? Colors.green[700]
                            : Colors.orange[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (sweet.alternativeFor != null)
                      Text(
                        '替代 ${sweet.alternativeFor}',
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGuidelines() {
    final guidelines =
        FestivalDatabase()
            .getFestivalsForYear(DateTime.now().year)
            .where((f) => f.type == FestivalType.diwali)
            .firstOrNull
            ?.fastingGuidelines ??
        [];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: guidelines
              .map(
                (guideline) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Color(0xFFFF9800),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(guideline)),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _showAddSweetDialog(BuildContext context, WidgetRef ref) {
    final sweets = FestivalDatabase()
        .getFestivalsForYear(DateTime.now().year)
        .where((f) => f.type == FestivalType.diwali)
        .expand((f) => (f.recommendedFoods ?? []).cast<FestivalFood>())
        .toList();

    if (sweets.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No sweets available')));
      return;
    }

    FestivalFood? selectedSweet;
    double quantity = 50;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add Sweet',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<FestivalFood>(
                    decoration: const InputDecoration(
                      labelText: 'Select Sweet',
                      border: OutlineInputBorder(),
                    ),
                    items: sweets.map((sweet) {
                      return DropdownMenuItem(
                        value: sweet,
                        child: Text(sweet.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => selectedSweet = value);
                    },
                  ),
                  const SizedBox(height: 16),
                  Text('Quantity: ${quantity.toInt()}g'),
                  Slider(
                    value: quantity,
                    min: 10,
                    max: 200,
                    divisions: 19,
                    label: '${quantity.toInt()}g',
                    activeColor: const Color(0xFFFF9800),
                    onChanged: (value) {
                      setState(() => quantity = value);
                    },
                  ),
                  if (selectedSweet != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Calories: ${(selectedSweet!.caloriesPer100g * quantity / 100).toInt()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF9800),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: selectedSweet != null
                          ? () {
                              ref
                                  .read(diwaliSweetTrackerProvider.notifier)
                                  .addSweet(selectedSweet!, quantity);
                              Navigator.pop(context);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9800),
                      ),
                      child: const Text('Add'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
