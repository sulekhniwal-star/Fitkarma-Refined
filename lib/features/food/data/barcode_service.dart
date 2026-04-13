import 'dart:convert';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import '../../../core/storage/app_database.dart';
import 'food_drift_service.dart';
import 'package:drift/drift.dart';

class BarcodeService {
  final FoodDriftService _drift;

  BarcodeService(this._drift);

  /// Scans a barcode using the device camera.
  Future<String?> scanBarcode() async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#FF5722', 'Cancel', true, ScanMode.BARCODE);
      
      if (barcodeScanRes == '-1') return null;
      return barcodeScanRes;
    } catch (e) {
      return null;
    }
  }

  /// Fetches product details from OpenFoodFacts and caches it locally.
  Future<FoodItem?> fetchAndCacheProduct(String barcode) async {
    final url = Uri.parse('https://world.openfoodfacts.org/api/v2/product/$barcode.json');
    
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 1) {
          final product = data['product'];
          final nutrients = product['nutriments'] ?? {};

          final companion = FoodItemsCompanion.insert(
            id: barcode, // Global barcode
            name: product['product_name'] ?? 'Unknown Product',
            brand: Value(product['brands'] ?? 'Unknown Brand'),
            calories: (nutrients['energy-kcal_100g'] ?? 0.0).toDouble(),
            proteinG: (nutrients['proteins_100g'] ?? 0.0).toDouble(),
            carbsG: (nutrients['carbohydrates_100g'] ?? 0.0).toDouble(),
            fatG: (nutrients['fat_100g'] ?? 0.0).toDouble(),
            fiberG: (nutrients['fiber_100g'] ?? 0.0).toDouble(),
            emoji: '🥫',
            updatedAt: DateTime.now(),
          );

          await _drift.bulkInsertFoodItems([companion]);
          
          // Return the actual model
          return FoodItem(
            id: barcode,
            name: product['product_name'],
            brand: product['brands'],
            calories: (nutrients['energy-kcal_100g'] ?? 0.0).toDouble(),
            proteinG: (nutrients['proteins_100g'] ?? 0.0).toDouble(),
            carbsG: (nutrients['carbohydrates_100g'] ?? 0.0).toDouble(),
            fatG: (nutrients['fat_100g'] ?? 0.0).toDouble(),
            fiberG: (nutrients['fiber_100g'] ?? 0.0).toDouble(),
            emoji: '🥫',
            updatedAt: DateTime.now(),
          );
        }
      }
    } catch (e) {
      // Log error
    }
    return null;
  }
}
