// lib/features/food/presentation/scan_label_screen.dart
// OCR scan label screen using Google ML Kit

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fitkarma/features/food/data/ocr_nutrition_service.dart';
import 'package:fitkarma/features/food/data/food_providers.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

/// Provider for OCR service
final ocrNutritionServiceProvider = Provider<OcrNutritionService>((ref) {
  return OcrNutritionService();
});

/// Scan label screen for OCR nutrition reading
class ScanLabelScreen extends ConsumerStatefulWidget {
  const ScanLabelScreen({super.key});

  @override
  ConsumerState<ScanLabelScreen> createState() => _ScanLabelScreenState();
}

class _ScanLabelScreenState extends ConsumerState<ScanLabelScreen> {
  File? _selectedImage;
  bool _isProcessing = false;
  ExtractedNutritionData? _nutritionData;
  String? _error;
  final _productNameController = TextEditingController();

  @override
  void dispose() {
    _productNameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: source, imageQuality: 85);

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _nutritionData = null;
          _error = null;
        });
        await _processImage();
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to pick image: $e';
      });
    }
  }

  Future<void> _processImage() async {
    if (_selectedImage == null) return;

    setState(() {
      _isProcessing = true;
      _error = null;
    });

    try {
      final service = ref.read(ocrNutritionServiceProvider);
      final data = await service.processImage(_selectedImage!);

      setState(() {
        _nutritionData = data;
        _isProcessing = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to process image: $e';
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Scan Label'),
        backgroundColor: AppColors.surface,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isProcessing) {
      return _buildLoadingView();
    }

    if (_selectedImage == null) {
      return _buildImagePicker();
    }

    if (_error != null) {
      return _buildErrorView();
    }

    if (_nutritionData != null) {
      return _buildResultView();
    }

    return _buildImagePicker();
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: AppColors.primary),
          const SizedBox(height: 20),
          Text('Reading nutrition label...', style: AppTextStyles.bodyLarge),
          const SizedBox(height: 8),
          Text(
            'This may take a few seconds',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePicker() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.document_scanner,
            size: 100,
            color: AppColors.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 24),
          Text('Scan Nutrition Label', style: AppTextStyles.h3),
          const SizedBox(height: 8),
          Text(
            'Take a photo of the nutrition label to extract information automatically',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: _ActionButton(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () => _pickImage(ImageSource.camera),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _ActionButton(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () => _pickImage(ImageSource.gallery),
                ),
              ),
            ],
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
              style: AppTextStyles.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _selectedImage = null;
                  _nutritionData = null;
                  _error = null;
                });
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultView() {
    final data = _nutritionData!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image preview
          if (_selectedImage != null)
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.surface,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(_selectedImage!, fit: BoxFit.cover),
              ),
            ),

          const SizedBox(height: 16),

          // Retake button
          Center(
            child: TextButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.camera_alt),
              label: const Text('Retake Photo'),
            ),
          ),

          const SizedBox(height: 16),

          // Product name input
          TextField(
            controller: _productNameController,
            decoration: const InputDecoration(
              labelText: 'Product Name',
              hintText: 'e.g., Almonds, Granola Bar',
              prefixIcon: Icon(Icons.fastfood),
            ),
          ),

          const SizedBox(height: 24),

          // Nutrition facts card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nutrition Facts', style: AppTextStyles.h4),
                    if (data.servingSize != null)
                      Text(
                        'Per ${data.servingSize}g',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
                const Divider(height: 24),

                // Calories - prominent
                if (data.calories != null) ...[
                  _buildNutrientRow(
                    'Calories',
                    data.calories,
                    'kcal',
                    isHighlighted: true,
                  ),
                  const SizedBox(height: 12),
                ],

                // Macronutrients
                _buildNutrientRow('Protein', data.protein, 'g'),
                _buildNutrientRow('Carbohydrates', data.carbs, 'g'),
                _buildNutrientRow('Fat', data.fat, 'g'),

                // Additional fats
                if (data.saturatedFat != null) ...[
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: _buildNutrientRow(
                      '  Saturated Fat',
                      data.saturatedFat,
                      'g',
                    ),
                  ),
                ],
                if (data.transFat != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: _buildNutrientRow('  Trans Fat', data.transFat, 'g'),
                  ),

                const Divider(height: 24),

                // Fiber and Sugar
                _buildNutrientRow('Fiber', data.fiber, 'g'),
                _buildNutrientRow('Sugar', data.sugar, 'g'),

                const Divider(height: 24),

                // Minerals
                _buildNutrientRow('Sodium', data.sodium, 'mg'),
                _buildNutrientRow('Cholesterol', data.cholesterol, 'mg'),

                const Divider(height: 24),

                // Vitamins
                if (data.vitaminD != null ||
                    data.vitaminA != null ||
                    data.vitaminC != null) ...[
                  Text(
                    'Vitamins',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildNutrientRow('Vitamin D', data.vitaminD, 'mcg'),
                  _buildNutrientRow('Vitamin A', data.vitaminA, 'mcg'),
                  _buildNutrientRow('Vitamin C', data.vitaminC, 'mg'),
                  const Divider(height: 24),
                ],

                // Minerals
                if (data.calcium != null ||
                    data.iron != null ||
                    data.potassium != null) ...[
                  Text(
                    'Minerals',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildNutrientRow('Calcium', data.calcium, 'mg'),
                  _buildNutrientRow('Iron', data.iron, 'mg'),
                  _buildNutrientRow('Potassium', data.potassium, 'mg'),
                ],
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Raw text toggle
          ExpansionTile(
            title: const Text('View Raw Text'),
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  data.rawText,
                  style: AppTextStyles.bodySmall,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Log button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: data.hasData ? _logFood : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Log Food (+15 XP)',
                style: AppTextStyles.buttonLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientRow(
    String label,
    double? value,
    String unit, {
    bool isHighlighted = false,
  }) {
    if (value == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTextStyles.bodyMedium),
            Text(
              '--',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isHighlighted
                ? AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)
                : AppTextStyles.bodyMedium,
          ),
          Text(
            '${value.toStringAsFixed(1)} $unit',
            style: isHighlighted
                ? AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)
                : AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }

  void _logFood() {
    if (_nutritionData == null) return;

    final productName = _productNameController.text.isNotEmpty
        ? _productNameController.text
        : 'Scanned Product';

    // Show quantity dialog
    showDialog(
      context: context,
      builder: (context) => _QuantityDialog(
        productName: productName,
        nutritionData: _nutritionData!,
        onConfirm: (quantity) async {
          await ref
              .read(foodLogProvider.notifier)
              .logFood(
                foodName: productName,
                quantityG: quantity,
                calories: (_nutritionData!.calories ?? 0) * quantity / 100,
                proteinG: (_nutritionData!.protein ?? 0) * quantity / 100,
                carbsG: (_nutritionData!.carbs ?? 0) * quantity / 100,
                fatG: (_nutritionData!.fat ?? 0) * quantity / 100,
                fiberG: _nutritionData!.fiber != null
                    ? _nutritionData!.fiber! * quantity / 100
                    : null,
              );

          if (mounted) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Logged $productName (+15 XP)'),
                backgroundColor: AppColors.primary,
              ),
            );
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}

/// Action button widget
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(label, style: AppTextStyles.bodyMedium),
          ],
        ),
      ),
    );
  }
}

/// Quantity dialog
class _QuantityDialog extends StatefulWidget {
  final String productName;
  final ExtractedNutritionData nutritionData;
  final Function(double) onConfirm;

  const _QuantityDialog({
    required this.productName,
    required this.nutritionData,
    required this.onConfirm,
  });

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
          Text(widget.productName, style: AppTextStyles.bodyMedium),
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
          Wrap(
            spacing: 8,
            children: [25, 50, 100, 150, 200].map((g) {
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
