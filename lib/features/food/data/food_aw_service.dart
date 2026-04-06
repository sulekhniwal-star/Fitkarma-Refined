import 'package:appwrite/appwrite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/network/appwrite_service.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/storage/app_database.dart';

part 'food_aw_service.g.dart';

class FoodAwService {
  final Databases databases;

  FoodAwService(this.databases);

  Future<List<FoodItem>> searchGlobalFood(String query) async {
    try {
      final response = await databases.listDocuments(
        databaseId: AW.dbId,
        collectionId: AW.foodItems,
        queries: [
          Query.search('name', query),
          Query.limit(20),
        ],
      );

      return response.documents.map((doc) {
        // Map Appwrite document to Drift FoodItem
        return FoodItem(
          id: doc.$id,
          name: doc.data['name'] ?? '',
          nameLocal: doc.data['name_local'],
          region: doc.data['region'],
          barcode: doc.data['barcode'],
          caloriesPer100g: (doc.data['calories_per_100g'] as num?)?.toDouble() ?? 0.0,
          proteinPer100g: (doc.data['protein_per_100g'] as num?)?.toDouble() ?? 0.0,
          carbsPer100g: (doc.data['carbs_per_100g'] as num?)?.toDouble() ?? 0.0,
          fatPer100g: (doc.data['fat_per_100g'] as num?)?.toDouble() ?? 0.0,
          fiberPer100g: (doc.data['fiber_per_100g'] as num?)?.toDouble(),
          vitaminDPer100g: (doc.data['vitamin_d_per_100g'] as num?)?.toDouble(),
          vitaminB12Per100g: (doc.data['vitamin_b12_per_100g'] as num?)?.toDouble(),
          ironPer100g: (doc.data['iron_per_100g'] as num?)?.toDouble(),
          calciumPer100g: (doc.data['calcium_per_100g'] as num?)?.toDouble(),
          isIndian: doc.data['is_indian'] ?? true,
          servingSizes: doc.data['serving_sizes'],
          source: 'FitKarma Global',
        );
      }).toList();
    } catch (e) {
      // In a real app, log this to Sentry
      return [];
    }
  }
}

@riverpod
FoodAwService foodAwService(Ref ref) {
  return FoodAwService(ref.watch(appwriteDatabasesProvider));
}
