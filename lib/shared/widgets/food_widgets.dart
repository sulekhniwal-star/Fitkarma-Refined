import 'package:flutter/material.dart';
import 'glass_card.dart';

class MealTypeTabBar extends StatelessWidget {
  final List<String> types;
  final int selectedIndex;
  final Function(int) onSelected;

  const MealTypeTabBar({
    super.key,
    required this.types,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: types.asMap().entries.map((entry) {
          final isSelected = entry.key == selectedIndex;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ChoiceChip(
              label: Text(entry.value),
              selected: isSelected,
              onSelected: (_) => onSelected(entry.key),
              selectedColor: const Color(0xFFF97316),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class FoodItemCard extends StatelessWidget {
  final String name;
  final String hindiName;
  final double calories;
  final String portion;
  final String? imageUrl;
  final VoidCallback onAdd;

  const FoodItemCard({
    super.key,
    required this.name,
    required this.hindiName,
    required this.calories,
    required this.portion,
    this.imageUrl,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Image.network(
                imageUrl!,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  hindiName,
                  style: const TextStyle(fontFamily: 'Devanagari', color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$calories kcal', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFF97316))),
                        Text(portion, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                      ],
                    ),
                    IconButton.filled(
                      onPressed: onAdd,
                      icon: const Icon(Icons.add),
                      style: IconButton.styleFrom(backgroundColor: const Color(0xFFF97316)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
