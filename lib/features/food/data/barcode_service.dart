import 'dart:convert';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../core/storage/app_database.dart';
import 'food_drift_service.dart';

class BarcodeService {
  final FoodDriftService _drift;
  final _uuid = const Uuid();

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
          final id = _uuid.v4();

          final companion = FoodItemsCompanion.insert(
            id: id,
            localRowId: 0, // Will be ignored on insert as it is autoIncrement in DB? 
            // Wait, localRowId is NOT autoIncrement in the table definition I saw?
            // Actually, in app_database.dart I added it as integer().autoIncrement()()
            userId: 'system', // Global product cache
            name: product['product_name'] ?? 'Unknown Product',
            barcode: Value(barcode),
            caloriesPer100g: (nutrients['energy-kcal_100g'] ?? 0.0).toDouble(),
            proteinPer100g: (nutrients['proteins_100g'] ?? 0.0).toDouble(),
            carbsPer100g: (nutrients['carbohydrates_100g'] ?? 0.0).toDouble(),
            fatPer100g: (nutrients['fat_100g'] ?? 0.0).toDouble(),
            fiberPer100g: Value((nutrients['fiber_100g'] ?? 0.0).toDouble()),
            isIndian: const Value(false),
            source: 'openfoodfacts',
            idempotencyKey: _uuid.v4(),
            syncStatus: const Value('synced'), // Global data
          );

          await _drift.bulkInsertFoodItems([companion]);
          
          return FoodItem(
            id: id,
            localRowId: 0, 
            userId: 'system',
            name: product['product_name'] ?? 'Unknown Product',
            barcode: barcode,
            caloriesPer100g: (nutrients['energy-kcal_100g'] ?? 0.0).toDouble(),
            proteinPer100g: (nutrients['proteins_100g'] ?? 0.0).toDouble(),
            carbsPer100g: (nutrients['carbohydrates_100g'] ?? 0.0).toDouble(),
            fatPer100g: (nutrients['fat_100g'] ?? 0.0).toDouble(),
            isIndian: false,
            source: 'openfoodfacts',
            idempotencyKey: id,
            syncStatus: 'synced',
            createdAt: DateTime.now(),
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
