import 'dart:convert';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:drift/drift.dart';
import '../../../core/storage/app_database.dart';
import 'food_drift_service.dart';

class BarcodeService {
  final FoodDriftService _drift;

  BarcodeService(this._drift);

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
            name: product['product_name'] ?? 'Unknown Product',
            barcode: Value(barcode),
            caloriesPer100g: (nutrients['energy-kcal_100g'] ?? 0.0).toDouble(),
            proteinPer100g: (nutrients['proteins_100g'] ?? 0.0).toDouble(),
            carbsPer100g: (nutrients['carbohydrates_100g'] ?? 0.0).toDouble(),
            fatPer100g: (nutrients['fat_100g'] ?? 0.0).toDouble(),
            fiberPer100g: Value((nutrients['fiber_100g'] ?? 0.0).toDouble()),
            isIndian: Value(false),
            source: 'openfoodfacts',
          );

          await _drift.bulkInsertFoodItems([companion]);
          
          return FoodItem(
            id: 0,
            name: product['product_name'] ?? 'Unknown Product',
            caloriesPer100g: (nutrients['energy-kcal_100g'] ?? 0.0).toDouble(),
            proteinPer100g: (nutrients['proteins_100g'] ?? 0.0).toDouble(),
            carbsPer100g: (nutrients['carbohydrates_100g'] ?? 0.0).toDouble(),
            fatPer100g: (nutrients['fat_100g'] ?? 0.0).toDouble(),
            isIndian: false,
            source: 'openfoodfacts',
          );
        }
      }
    } catch (e) {
      // Log error
    }
    return null;
  }
}
