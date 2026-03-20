// lib/features/food/data/openfoodfacts_service.dart
// Service for fetching food data from OpenFoodFacts API

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';

/// Model for OpenFoodFacts API response
class OpenFoodFactsProduct {
  final String? barcode;
  final String? productName;
  final String? productNameHindi;
  final String? brand;
  final double? calories;
  final double? protein;
  final double? carbs;
  final double? fat;
  final double? fiber;
  final double? servingSize;
  final String? imageUrl;
  final String? ingredients;

  OpenFoodFactsProduct({
    this.barcode,
    this.productName,
    this.productNameHindi,
    this.brand,
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.fiber,
    this.servingSize,
    this.imageUrl,
    this.ingredients,
  });

  factory OpenFoodFactsProduct.fromJson(Map<String, dynamic> json) {
    final product = json['product'] as Map<String, dynamic>?;
    if (product == null) return OpenFoodFactsProduct();

    // Extract nutrition data
    final nutriments = product['nutriments'] as Map<String, dynamic>?;

    return OpenFoodFactsProduct(
      barcode: product['code'] as String?,
      productName: product['product_name'] as String?,
      productNameHindi: product['product_name_hi'] as String?,
      brand: product['brands'] as String?,
      calories: _parseDouble(nutriments?['energy-kcal_100g']),
      protein: _parseDouble(nutriments?['proteins_100g']),
      carbs: _parseDouble(nutriments?['carbohydrates_100g']),
      fat: _parseDouble(nutriments?['fat_100g']),
      fiber: _parseDouble(nutriments?['fiber_100g']),
      servingSize: _parseDouble(product['serving_size']),
      imageUrl: product['image_url'] as String?,
      ingredients: product['ingredients_text'] as String?,
    );
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  /// Convert to FoodItemsCompanion for Drift database
  FoodItemsCompanion toFoodItemsCompanion(String id) {
    return FoodItemsCompanion(
      id: Value(id),
      name: Value(productName ?? 'Unknown'),
      nameLocal: Value(productNameHindi ?? productName ?? 'Unknown'),
      region: Value('International'),
      barcode: Value(barcode),
      caloriesPer100g: Value(calories ?? 0),
      proteinPer100g: Value(protein ?? 0),
      carbsPer100g: Value(carbs ?? 0),
      fatPer100g: Value(fat ?? 0),
      fiberPer100g: Value(fiber),
      vitaminDPer100g: const Value(null),
      vitaminB12Per100g: const Value(null),
      ironPer100g: const Value(null),
      calciumPer100g: const Value(null),
      isIndian: const Value(false),
      servingSizes: Value(
        jsonEncode([
          {'size': '100g', 'grams': 100},
          if (servingSize != null) {'size': servingSize, 'grams': 100},
        ]),
      ),
      source: Value('openfoodfacts'),
    );
  }
}

/// Service for OpenFoodFacts API
class OpenFoodFactsService {
  static const String _baseUrl =
      'https://world.openfoodfacts.org/api/v2/product';

  final http.Client _client;

  OpenFoodFactsService({http.Client? client})
    : _client = client ?? http.Client();

  /// Fetch product by barcode
  Future<OpenFoodFactsProduct?> getProductByBarcode(String barcode) async {
    try {
      final uri = Uri.parse('$_baseUrl/$barcode.json');
      final response = await _client.get(
        uri,
        headers: {
          'User-Agent': 'Fitkarma/1.0 (Flutter App)',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final status = data['status'] as int?;

        if (status == 1) {
          return OpenFoodFactsProduct.fromJson(data);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Search products by name
  Future<List<OpenFoodFactsProduct>> searchProducts(
    String query, {
    int page = 1,
  }) async {
    try {
      final uri = Uri.parse('https://world.openfoodfacts.org/cgi/search.pl')
          .replace(
            queryParameters: {
              'search_terms': query,
              'search_simple': '1',
              'action': 'process',
              'json': '1',
              'page': page.toString(),
              'page_size': '20',
            },
          );

      final response = await _client.get(
        uri,
        headers: {
          'User-Agent': 'Fitkarma/1.0 (Flutter App)',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final products = data['products'] as List<dynamic>?;

        if (products != null) {
          return products
              .map((p) => OpenFoodFactsProduct.fromJson({'product': p}))
              .where((p) => p.productName != null)
              .toList();
        }
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  void dispose() {
    _client.close();
  }
}
