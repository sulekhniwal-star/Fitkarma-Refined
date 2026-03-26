// lib/features/food/presentation/barcode_scanner_screen.dart
// Barcode scanner screen using mobile_scanner

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:fitkarma/features/food/data/openfoodfacts_service.dart';
import 'package:fitkarma/features/food/data/food_providers.dart';
import 'package:fitkarma/features/food/presentation/manual_entry_sheet.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

/// Provider for OpenFoodFacts service
final openFoodFactsServiceProvider = Provider<OpenFoodFactsService>((ref) {
  return OpenFoodFactsService();
});

/// Barcode scanner screen
class BarcodeScannerScreen extends ConsumerStatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  ConsumerState<BarcodeScannerScreen> createState() =>
      _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends ConsumerState<BarcodeScannerScreen> {
  bool _isScanning = true;
  bool _isLoading = false;
  String? _scannedBarcode;
  OpenFoodFactsProduct? _product;
  String? _error;
  MobileScannerController? _scannerController;
  bool _torchEnabled = false;

  @override
  void initState() {
    super.initState();
    _scannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  @override
  void dispose() {
    _scannerController?.dispose();
    super.dispose();
  }

  Future<void> _startScanning() async {
    setState(() {
      _isScanning = true;
      _scannedBarcode = null;
      _product = null;
      _error = null;
    });
  }

  Future<void> _scanBarcode() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
  }

  void _handleBarcode(BarcodeCapture capture) {
    if (_isLoading) {
      final List<Barcode> barcodes = capture.barcodes;
      if (barcodes.isNotEmpty) {
        final barcode = barcodes.first.rawValue;
        if (barcode != null && barcode.isNotEmpty) {
          setState(() {
            _scannedBarcode = barcode;
            _isScanning = false;
            _isLoading = false;
          });
          _fetchProductData(barcode);
        }
      }
    }
  }

  Future<void> _fetchProductData(String barcode) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final service = ref.read(openFoodFactsServiceProvider);
      final product = await service.getProductByBarcode(barcode);

      if (product != null) {
        setState(() {
          _product = product;
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Product not found in database';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to fetch product: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Scan Barcode'),
        actions: [
          if (_scannedBarcode != null)
            IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              onPressed: _startScanning,
              tooltip: 'Scan again',
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isScanning) {
      return _buildScannerView();
    }

    if (_isLoading) {
      return _buildLoadingView();
    }

    if (_product != null) {
      return _buildProductView();
    }

    if (_error != null) {
      return _buildErrorView();
    }

    return _buildScannerView();
  }

  Widget _buildScannerView() {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              // MobileScanner widget for barcode scanning
              MobileScanner(
                controller: _scannerController!,
                onDetect: _handleBarcode,
              ),
              // Scanner overlay
              Center(
                child: Container(
                  width: 280,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              // Instructions overlay
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Point camera at barcode',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Bottom info
        Container(
          padding: const EdgeInsets.all(16),
          color: AppColors.surface,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoChip(
                  _torchEnabled ? Icons.flash_on : Icons.flash_off,
                  'Flash',
                  onTap: () {
                    _scannerController?.toggleTorch();
                    setState(() {
                      _torchEnabled = !_torchEnabled;
                    });
                  },
                ),
                _buildInfoChip(
                  Icons.cameraswitch,
                  'Switch',
                  onTap: () {
                    _scannerController?.switchCamera();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white70),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: AppColors.primary),
          const SizedBox(height: 20),
          Text(
            'Searching product...',
            style: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildProductView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          if (_product!.imageUrl != null)
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    _product!.imageUrl!,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.fastfood,
                      size: 80,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            )
          else
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.surface,
                ),
                child: const Icon(
                  Icons.fastfood,
                  size: 80,
                  color: AppColors.textSecondary,
                ),
              ),
            ),

          const SizedBox(height: 24),

          // Product name
          Text(
            _product!.productName ?? 'Unknown Product',
            style: AppTextStyles.h3,
          ),

          if (_product!.brand != null) ...[
            const SizedBox(height: 4),
            Text(
              _product!.brand!,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],

          const SizedBox(height: 24),

          // Nutrition info card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nutrition Facts (per 100g)', style: AppTextStyles.h4),
                const Divider(height: 24),
                _buildNutrientRow(
                  'Calories',
                  '${_product!.calories ?? 0}',
                  'kcal',
                ),
                _buildNutrientRow('Protein', '${_product!.protein ?? 0}', 'g'),
                _buildNutrientRow('Carbs', '${_product!.carbs ?? 0}', 'g'),
                _buildNutrientRow('Fat', '${_product!.fat ?? 0}', 'g'),
                if (_product!.fiber != null)
                  _buildNutrientRow('Fiber', '${_product!.fiber}', 'g'),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _startScanning,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Scan Another'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _logFood(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Log Food'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientRow(String label, String value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyMedium),
          Text(
            '$value $unit',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: AppColors.error),
            const SizedBox(height: 20),
            Text(
              _error!,
              style: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _startScanning,
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => _showManualEntry(),
              child: const Text('Enter manually instead'),
            ),
          ],
        ),
      ),
    );
  }

  void _logFood() {
    if (_product == null) return;

    // Show quantity selection dialog
    showDialog(
      context: context,
      builder: (context) => _QuantityDialog(
        product: _product!,
        onConfirm: (quantity) async {
          // Log the food
          await ref
              .read(foodLogProvider.notifier)
              .logFood(
                foodName: _product!.productName ?? 'Unknown',
                quantityG: quantity,
                calories: (_product!.calories ?? 0) * quantity / 100,
                proteinG: (_product!.protein ?? 0) * quantity / 100,
                carbsG: (_product!.carbs ?? 0) * quantity / 100,
                fatG: (_product!.fat ?? 0) * quantity / 100,
                fiberG: _product!.fiber != null
                    ? _product!.fiber! * quantity / 100
                    : null,
              );

          if (mounted) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Logged ${_product!.productName}'),
                backgroundColor: AppColors.primary,
              ),
            );
          }
        },
      ),
    );
  }

  void _showManualEntry() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ManualEntrySheet()),
    );
  }
}

/// Quantity selection dialog
class _QuantityDialog extends StatefulWidget {
  final OpenFoodFactsProduct product;
  final Function(double) onConfirm;

  const _QuantityDialog({required this.product, required this.onConfirm});

  @override
  State<_QuantityDialog> createState() => _QuantityDialogState();
}

class _QuantityDialogState extends State<_QuantityDialog> {
  double _quantity = 100;
  final _controller = TextEditingController(text: '100');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Quantity'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.product.productName ?? 'Unknown',
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Quantity (grams)',
              suffixText: 'g',
            ),
            onChanged: (value) {
              final parsed = double.tryParse(value);
              if (parsed != null && parsed > 0) {
                setState(() => _quantity = parsed);
              }
            },
          ),
          const SizedBox(height: 16),
          // Quick select buttons
          Wrap(
            spacing: 8,
            children: [50, 100, 150, 200, 250].map((g) {
              return ActionChip(
                label: Text('${g}g'),
                onPressed: () {
                  setState(() {
                    _quantity = g.toDouble();
                    _controller.text = g.toString();
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            widget.onConfirm(_quantity);
          },
          child: const Text('Log'),
        ),
      ],
    );
  }
}
