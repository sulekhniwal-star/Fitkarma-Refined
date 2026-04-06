import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/bilingual_text.dart';

class WeddingGroceryListScreen extends ConsumerStatefulWidget {
  const WeddingGroceryListScreen({super.key});

  @override
  ConsumerState<WeddingGroceryListScreen> createState() => _WeddingGroceryListScreenState();
}

class _WeddingGroceryListScreenState extends ConsumerState<WeddingGroceryListScreen> {
  final Map<String, bool> _items = {
    'Amla (Antioxidant)': false,
    'Walnuts & Almonds': false,
    'Berries (Low glycemic)': false,
    'Avocado (Healthy fats)': false,
    'Coconut Water': false,
    'Leafy Greens (Iron)': false,
    'Chia Seeds': false,
    'Turmeric (Curcumin)': false,
    'Ginger & Lemon': false,
    'Lentils/Dals': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prep Grocery List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share functionality
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Header(),
          const SizedBox(height: 24),
          const BilingualText(
            english: 'Superfoods for Glow',
            hindi: 'चमक के लिए सुपरफूड',
            englishStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ..._items.keys.map((item) => CheckboxListTile(
            value: _items[item],
            onChanged: (val) => setState(() => _items[item] = val!),
            title: Text(item),
            controlAffinity: ListTileControlAffinity.leading,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            activeColor: AppColors.primary,
          )),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
            label: const Text('ADD TO MEAL PLANNER'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: AppColors.secondary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.accentLight.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Icon(Icons.restaurant_menu, color: Colors.orange, size: 32),
          SizedBox(height: 12),
          Text(
            'The Glow-Up List',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 4),
          Text(
            'Focus on fiber and antioxidants for better digestion and skin.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
