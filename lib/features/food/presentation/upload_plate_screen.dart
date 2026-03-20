// lib/features/food/presentation/upload_plate_screen.dart
// Photo AI screen for uploading plate photos and identifying food

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fitkarma/features/food/data/image_labeling_service.dart';
import 'package:fitkarma/features/food/data/food_providers.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

/// Provider for image labeling service
final imageLabelingServiceProvider = Provider<ImageLabelingService>((ref) {
  return ImageLabelingService();
});

/// Upload plate photo screen for food identification
class UploadPlateScreen extends ConsumerStatefulWidget {
  const UploadPlateScreen({super.key});

  @override
  ConsumerState<UploadPlateScreen> createState() => _UploadPlateScreenState();
}

class _UploadPlateScreenState extends ConsumerState<UploadPlateScreen> {
  File? _selectedImage;
  bool _isProcessing = false;
  List<IdentifiedFood>? _identifiedFoods;
  IdentifiedFood? _selectedFood;
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
          _identifiedFoods = null;
          _selectedFood = null;
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
      final service = ref.read(imageLabelingServiceProvider);
      final foods = await service.processImage(_selectedImage!);

      setState(() {
        _identifiedFoods = foods;
        _selectedFood = foods.isNotEmpty ? foods.first : null;
        _isProcessing = false;

        // Pre-fill the text field
        if (_selectedFood != null) {
          _productNameController.text = _selectedFood!.label;
        }
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
        title: const Text('Upload Plate'),
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

    if (_identifiedFoods != null) {
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
          Text('Analyzing your plate...', style: AppTextStyles.bodyLarge),
          const SizedBox(height: 8),
          Text(
            'Identifying food items',
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
            Icons.restaurant,
            size: 100,
            color: AppColors.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 24),
          Text('Upload Plate Photo', style: AppTextStyles.h3),
          const SizedBox(height: 8),
          Text(
            'Take a photo of your food plate and let AI identify what you\'re eating',
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
          const SizedBox(height: 32),
          // Tips
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
                  children: [
                    Icon(Icons.lightbulb, color: AppColors.primary, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Tips for best results',
                      style: AppTextStyles.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '• Good lighting helps AI identify food better\n'
                  '• Capture the entire plate in the frame\n'
                  '• Avoid blurry images',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
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
              style: AppTextStyles.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _selectedImage = null;
                  _identifiedFoods = null;
                  _selectedFood = null;
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
    final foods = _identifiedFoods!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image preview
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.surface,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(_selectedImage!, fit: BoxFit.cover),
                  // Confidence overlay
                  if (_selectedFood != null)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.black54,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedFood!.label,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${(_selectedFood!.confidence * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Retake button
          Center(
            child: TextButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.camera_alt),
              label: const Text('Take New Photo'),
            ),
          ),

          const SizedBox(height: 16),

          // Detected items
          if (foods.length > 1) ...[
            Text('Detected Items (${foods.length})', style: AppTextStyles.h4),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: foods.map((food) {
                final isSelected = food == _selectedFood;
                return ChoiceChip(
                  label: Text(food.label),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedFood = food;
                      _productNameController.text = food.label;
                    });
                  },
                  selectedColor: AppColors.primary.withValues(alpha: 0.2),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],

          // Selected food info
          if (_selectedFood != null) ...[
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
                    children: [
                      const Icon(
                        Icons.restaurant_menu,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _selectedFood!.label,
                          style: AppTextStyles.h4,
                        ),
                      ),
                    ],
                  ),
                  if (_selectedFood!.suggestedIndianFood != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Hindi: ',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          _selectedFood!.suggestedIndianFood!,
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoItem(
                        'Calories',
                        '${_selectedFood!.estimatedCalories?.toStringAsFixed(0) ?? '--'}',
                        'kcal',
                      ),
                      _buildInfoItem(
                        'Confidence',
                        '${(_selectedFood!.confidence * 100).toStringAsFixed(0)}',
                        '%',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Product name input (editable)
          TextField(
            controller: _productNameController,
            decoration: const InputDecoration(
              labelText: 'Food Name',
              hintText: 'e.g., Dal Chawal, Roti Sabzi',
              prefixIcon: Icon(Icons.edit),
            ),
          ),

          const SizedBox(height: 24),

          // Log button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedFood != null ? _logFood : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Log Food (+20 XP)',
                style: AppTextStyles.buttonLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, String unit) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: value, style: AppTextStyles.h4),
              TextSpan(text: ' $unit', style: AppTextStyles.bodySmall),
            ],
          ),
        ),
      ],
    );
  }

  void _logFood() {
    if (_selectedFood == null) return;

    final productName = _productNameController.text.isNotEmpty
        ? _productNameController.text
        : _selectedFood!.label;

    // Show quantity dialog
    showDialog(
      context: context,
      builder: (context) => _QuantityDialog(
        productName: productName,
        caloriesPer100g: _selectedFood!.estimatedCalories ?? 150,
        onConfirm: (quantity) async {
          await ref
              .read(foodLogProvider.notifier)
              .logFood(
                foodName: productName,
                quantityG: quantity,
                calories:
                    (_selectedFood!.estimatedCalories ?? 150) * quantity / 100,
                proteinG: 10 * quantity / 100, // Estimated
                carbsG: 20 * quantity / 100, // Estimated
                fatG: 5 * quantity / 100, // Estimated
              );

          if (mounted) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Logged $productName (+20 XP)'),
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
  final double caloriesPer100g;
  final Function(double) onConfirm;

  const _QuantityDialog({
    required this.productName,
    required this.caloriesPer100g,
    required this.onConfirm,
  });

  @override
  State<_QuantityDialog> createState() => _QuantityDialogState();
}

class _QuantityDialogState extends State<_QuantityDialog> {
  double _quantity = 150;
  final _controller = TextEditingController(text: '150');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final estimatedCalories = widget.caloriesPer100g * _quantity / 100;

    return AlertDialog(
      title: const Text('Enter Quantity'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.productName, style: AppTextStyles.bodyMedium),
          const SizedBox(height: 8),
          Text(
            'Est. ${estimatedCalories.toStringAsFixed(0)} kcal',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary),
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
          Wrap(
            spacing: 8,
            children: [100, 150, 200, 250, 300].map((g) {
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
