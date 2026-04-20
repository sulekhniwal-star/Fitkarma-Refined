import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/di/providers.dart';
import '../data/food_repository.dart';
import '../data/food_aw_service.dart';

final foodRepositoryProvider = Provider<FoodRepository>((ref) {
  final foodDao = ref.watch(foodDaoProvider);
  final syncDao = ref.watch(syncDaoProvider);
  final aw = FoodAwService();
  return FoodRepository(foodDao, syncDao, aw);
});

/// Provider for searching food items with 300ms debounce (handled in UI).
final foodSearchProvider = FutureProvider.family<List<Map<String, dynamic>>, String>((ref, query) async {
  if (query.isEmpty) return [];
  final repo = ref.watch(foodRepositoryProvider);
  return await repo.search(query);
});

/// Provider for recently logged food items.
final recentLogsProvider = FutureProvider.family<List<dynamic>, String>((ref, userId) async {
  final repo = ref.watch(foodRepositoryProvider);
  // Implementation details would go to repository -> drift_service
  return []; // Placeholder
});

/// Provider for typical Indian portion references (seeded data).
final indianFrequentFoodsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  return [
    {'name': 'Masala Tea', 'portion': '1 cup', 'emoji': '☕', 'calories': 45},
    {'name': 'Vegetable Poha', 'portion': '1 katori', 'emoji': '🥣', 'calories': 180},
    {'name': 'Roti / Chapati', 'portion': '1 piece', 'emoji': '🫓', 'calories': 85},
    {'name': 'Dal Tadka', 'portion': '1 katori', 'emoji': '🥣', 'calories': 150},
    {'name': 'Steamed Rice', 'portion': '1 katori', 'emoji': '🍚', 'calories': 130},
    {'name': 'Mixed Veg', 'portion': '1 katori', 'emoji': '🥗', 'calories': 110},
  ];
});

