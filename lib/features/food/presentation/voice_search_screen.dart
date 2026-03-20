// lib/features/food/presentation/voice_search_screen.dart
// Voice search screen for logging food by voice

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/food/data/voice_search_service.dart';
import 'package:fitkarma/features/food/data/food_providers.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

/// Provider for voice search service
final voiceSearchServiceProvider = Provider<VoiceSearchService>((ref) {
  return VoiceSearchService();
});

/// Voice search screen for logging food by voice
class VoiceSearchScreen extends ConsumerStatefulWidget {
  const VoiceSearchScreen({super.key});

  @override
  ConsumerState<VoiceSearchScreen> createState() => _VoiceSearchScreenState();
}

class _VoiceSearchScreenState extends ConsumerState<VoiceSearchScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  final VoiceSearchService _voiceService = VoiceSearchService();
  bool _isInitialized = false;
  bool _isListening = false;
  String _recognizedText = '';
  List<String> _suggestions = [];
  String? _selectedFood;

  // Estimated nutrition data for common Indian foods
  final Map<String, Map<String, double>> _foodNutrition = {
    'dal': {'calories': 116, 'protein': 9, 'carbs': 20, 'fat': 0.5},
    'chawal': {'calories': 130, 'protein': 2.7, 'carbs': 28, 'fat': 0.3},
    'roti': {'calories': 79, 'protein': 2.7, 'carbs': 17, 'fat': 1},
    'sabzi': {'calories': 35, 'protein': 2, 'carbs': 7, 'fat': 0.3},
    'biryani': {'calories': 190, 'protein': 6, 'carbs': 25, 'fat': 8},
    'pulao': {'calories': 163, 'protein': 4, 'carbs': 22, 'fat': 6},
    'dosa': {'calories': 168, 'protein': 3, 'carbs': 18, 'fat': 9},
    'idli': {'calories': 39, 'protein': 2, 'carbs': 8, 'fat': 0.4},
    'sambar': {'calories': 57, 'protein': 3, 'carbs': 10, 'fat': 1},
    'paneer': {'calories': 265, 'protein': 14, 'carbs': 3, 'fat': 22},
    'chicken': {'calories': 239, 'protein': 27, 'carbs': 0, 'fat': 14},
    'mutton': {'calories': 250, 'protein': 25, 'carbs': 0, 'fat': 15},
    'fish': {'calories': 136, 'protein': 20, 'carbs': 0, 'fat': 5},
    'egg': {'calories': 155, 'protein': 13, 'carbs': 1, 'fat': 11},
    'paratha': {'calories': 130, 'protein': 3, 'carbs': 15, 'fat': 7},
    'naan': {'calories': 120, 'protein': 3, 'carbs': 18, 'fat': 4},
    'butter chicken': {'calories': 290, 'protein': 20, 'carbs': 8, 'fat': 20},
    'dal makhani': {'calories': 180, 'protein': 10, 'carbs': 20, 'fat': 8},
    'rajma': {'calories': 115, 'protein': 8, 'carbs': 20, 'fat': 0.5},
    'chole': {'calories': 150, 'protein': 8, 'carbs': 22, 'fat': 6},
    'aloo': {'calories': 77, 'protein': 2, 'carbs': 17, 'fat': 0.1},
    'gobi': {'calories': 25, 'protein': 2, 'carbs': 5, 'fat': 0.3},
    'poha': {'calories': 100, 'protein': 2, 'carbs': 20, 'fat': 2},
    'chai': {'calories': 40, 'protein': 1, 'carbs': 7, 'fat': 1},
    'lassi': {'calories': 120, 'protein': 4, 'carbs': 15, 'fat': 5},
    'curd': {'calories': 61, 'protein': 3, 'carbs': 4, 'fat': 3},
    'salad': {'calories': 20, 'protein': 1, 'carbs': 4, 'fat': 0.2},
    'thali': {'calories': 500, 'protein': 15, 'carbs': 60, 'fat': 20},
    'rice': {'calories': 130, 'protein': 2.7, 'carbs': 28, 'fat': 0.3},
    'khichdi': {'calories': 150, 'protein': 5, 'carbs': 25, 'fat': 4},
  };

  @override
  void initState() {
    super.initState();
    _initSpeech();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _voiceService.dispose();
    super.dispose();
  }

  Future<void> _initSpeech() async {
    final success = await _voiceService.initialize();
    setState(() {
      _isInitialized = success;
    });
  }

  Future<void> _startListening() async {
    if (!_isInitialized) {
      await _initSpeech();
    }

    if (!_isInitialized) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Voice recognition not available'),
            backgroundColor: AppColors.error,
          ),
        );
      }
      return;
    }

    setState(() {
      _isListening = true;
      _recognizedText = '';
      _suggestions = [];
      _selectedFood = null;
    });

    _animationController.repeat(reverse: true);

    await _voiceService.startListening(
      onResult: (result) {
        setState(() {
          _recognizedText = result.recognizedText;
          _suggestions = result.possibleMatches;

          if (result.recognizedText.isNotEmpty) {
            // Try to find exact food match
            final foodMatch = _findFoodMatch(result.recognizedText);
            if (foodMatch != null) {
              _selectedFood = foodMatch;
            }
          }
        });
      },
    );
  }

  Future<void> _stopListening() async {
    await _voiceService.stopListening();
    setState(() {
      _isListening = false;
    });
    _animationController.stop();
    _animationController.reset();
  }

  String? _findFoodMatch(String text) {
    final textLower = text.toLowerCase();
    final foodTerms = _foodNutrition.keys.toList();

    for (final food in foodTerms) {
      if (textLower.contains(food)) {
        return food;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Voice Log'),
        backgroundColor: AppColors.surface,
        actions: [
          if (_recognizedText.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  _recognizedText = '';
                  _suggestions = [];
                  _selectedFood = null;
                });
              },
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 40),

          // Animated mic button
          Center(
            child: AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _isListening ? _pulseAnimation.value : 1.0,
                  child: child,
                );
              },
              child: GestureDetector(
                onTap: _isListening ? _stopListening : _startListening,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isListening ? AppColors.error : AppColors.primary,
                    boxShadow: [
                      BoxShadow(
                        color:
                            (_isListening ? AppColors.error : AppColors.primary)
                                .withValues(alpha: 0.4),
                        blurRadius: 20,
                        spreadRadius: _isListening ? 10 : 0,
                      ),
                    ],
                  ),
                  child: Icon(
                    _isListening ? Icons.stop : Icons.mic,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Status text
          Text(
            _isListening ? 'Listening...' : 'Tap to speak',
            style: AppTextStyles.h4.copyWith(
              color: _isListening ? AppColors.error : AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Say something like "dal chawal" or "roti sabzi"',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 32),

          // Recognized text display
          if (_recognizedText.isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'You said:',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('"$_recognizedText"', style: AppTextStyles.h4),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],

          // Suggestions
          if (_suggestions.isNotEmpty) ...[
            Text('Suggestions', style: AppTextStyles.h4),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _suggestions.map((suggestion) {
                final isSelected = _selectedFood == suggestion.toLowerCase();
                return ChoiceChip(
                  label: Text(suggestion),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedFood = suggestion.toLowerCase();
                      _recognizedText = suggestion;
                    });
                  },
                  selectedColor: AppColors.primary.withValues(alpha: 0.2),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],

          // Selected food info
          if (_selectedFood != null &&
              _foodNutrition.containsKey(_selectedFood)) ...[
            _buildFoodInfoCard(_selectedFood!),
            const SizedBox(height: 24),
          ],

          // Confirm button
          if (_selectedFood != null &&
              _foodNutrition.containsKey(_selectedFood))
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _logFood,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Log ${_selectedFood!.substring(0, 1).toUpperCase()}${_selectedFood!.substring(1)} (+10 XP)',
                  style: AppTextStyles.buttonLarge,
                ),
              ),
            ),

          // Manual override button
          if (_recognizedText.isNotEmpty && _selectedFood == null)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Try to log with recognized text as custom food
                  setState(() {
                    _selectedFood = _recognizedText.toLowerCase();
                  });
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Log as "${_recognizedText}"',
                  style: AppTextStyles.buttonLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFoodInfoCard(String food) {
    final nutrition = _foodNutrition[food]!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.restaurant_menu, color: AppColors.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  food.substring(0, 1).toUpperCase() + food.substring(1),
                  style: AppTextStyles.h4,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNutrientInfo(
                'Calories',
                '${nutrition['calories']!.toStringAsFixed(0)}',
                'kcal',
              ),
              _buildNutrientInfo(
                'Protein',
                '${nutrition['protein']!.toStringAsFixed(1)}',
                'g',
              ),
              _buildNutrientInfo(
                'Carbs',
                '${nutrition['carbs']!.toStringAsFixed(1)}',
                'g',
              ),
              _buildNutrientInfo(
                'Fat',
                '${nutrition['fat']!.toStringAsFixed(1)}',
                'g',
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '* Values per 100g serving',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientInfo(String label, String value, String unit) {
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
              TextSpan(
                text: value,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: ' $unit', style: AppTextStyles.bodySmall),
            ],
          ),
        ),
      ],
    );
  }

  void _logFood() {
    if (_selectedFood == null) return;

    final nutrition =
        _foodNutrition[_selectedFood] ??
        {'calories': 150.0, 'protein': 5.0, 'carbs': 20.0, 'fat': 5.0};

    // Show quantity dialog
    showDialog(
      context: context,
      builder: (context) => _QuantityDialog(
        foodName: _selectedFood!,
        caloriesPer100g: nutrition['calories']!,
        proteinPer100g: nutrition['protein']!,
        carbsPer100g: nutrition['carbs']!,
        fatPer100g: nutrition['fat']!,
        onConfirm: (quantity) async {
          await ref
              .read(foodLogProvider.notifier)
              .logFood(
                foodName:
                    _selectedFood!.substring(0, 1).toUpperCase() +
                    _selectedFood!.substring(1),
                quantityG: quantity,
                calories: nutrition['calories']! * quantity / 100,
                proteinG: nutrition['protein']! * quantity / 100,
                carbsG: nutrition['carbs']! * quantity / 100,
                fatG: nutrition['fat']! * quantity / 100,
              );

          if (mounted) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Logged ${_selectedFood!.substring(0, 1).toUpperCase()}${_selectedFood!.substring(1)} (+10 XP)',
                ),
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

/// Quantity dialog
class _QuantityDialog extends StatefulWidget {
  final String foodName;
  final double caloriesPer100g;
  final double proteinPer100g;
  final double carbsPer100g;
  final double fatPer100g;
  final Function(double) onConfirm;

  const _QuantityDialog({
    required this.foodName,
    required this.caloriesPer100g,
    required this.proteinPer100g,
    required this.carbsPer100g,
    required this.fatPer100g,
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
          Text(
            widget.foodName.substring(0, 1).toUpperCase() +
                widget.foodName.substring(1),
            style: AppTextStyles.bodyMedium,
          ),
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
