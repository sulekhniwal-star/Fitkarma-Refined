import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/storage/app_database.dart';

part 'food_api_service.g.dart';

class FoodApiService {
  final Dio dio;

  FoodApiService(this.dio);

  Future<FoodItem?> fetchByBarcode(String barcode) async {
    try {
      final response = await dio.get('https://world.openfoodfacts.org/api/v0/product/$barcode.json');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == 1) {
          final product = data['product'];
          final nutriments = product['nutriments'] ?? {};
          
          return FoodItem(
            id: 'barcode_$barcode',
            name: product['product_name'] ?? 'Unknown Product',
            nameLocal: product['product_name_hi'], // Hindi if available
            region: null,
            barcode: barcode,
            caloriesPer100g: (nutriments['energy-kcal_100g'] as num?)?.toDouble() ?? 0.0,
            proteinPer100g: (nutriments['proteins_100g'] as num?)?.toDouble() ?? 0.0,
            carbsPer100g: (nutriments['carbohydrates_100g'] as num?)?.toDouble() ?? 0.0,
            fatPer100g: (nutriments['fat_100g'] as num?)?.toDouble() ?? 0.0,
            fiberPer100g: (nutriments['fiber_100g'] as num?)?.toDouble(),
            calciumPer100g: (nutriments['calcium_100g'] as num?)?.toDouble() != null ? (nutriments['calcium_100g'] as num?)!.toDouble() * 1000 : null, // OFF usually in g
            ironPer100g: (nutriments['iron_100g'] as num?)?.toDouble() != null ? (nutriments['iron_100g'] as num?)!.toDouble() * 1000 : null,
            isIndian: true, // we can check brands but for now assume generic or whatever came from Indian markets
            servingSizes: null,
            source: 'OpenFoodFacts',
          );
        }
      }
    } catch (_) {
      // Log error in production
    }
    return null;
  }
}

@riverpod
FoodApiService foodApiService(Ref ref) {
  // Replace with a central dio provider if available
  return FoodApiService(Dio());
}
