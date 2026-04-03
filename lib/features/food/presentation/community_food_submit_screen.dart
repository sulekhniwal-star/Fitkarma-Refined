import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityFoodSubmitScreen extends ConsumerStatefulWidget {
  const CommunityFoodSubmitScreen({super.key});

  @override
  ConsumerState<CommunityFoodSubmitScreen> createState() => _CommunityFoodSubmitScreenState();
}

class _CommunityFoodSubmitScreenState extends ConsumerState<CommunityFoodSubmitScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nameLocalController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatController = TextEditingController();
  String? _selectedRegion;
  bool _isSubmitting = false;

  final _regions = [
    ('north', 'North India (Punjab, Haryana, Delhi)'),
    ('south', 'South India (Tamil Nadu, Karnataka, Kerala)'),
    ('west', 'West India (Maharashtra, Gujarat, Goa)'),
    ('east', 'East India (West Bengal, Odisha, Bihar)'),
    ('northeast', 'Northeast India (Assam, Meghalaya)'),
    ('central', 'Central India (MP, Chhattisgarh)'),
    ('all', 'All India'),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _nameLocalController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Local Food'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Submit a food from your region',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Help build a comprehensive Indian food database',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  controller: _nameController,
                  label: 'Food Name (English)',
                  hint: 'e.g., Litti Chokha',
                  validator: (v) => v?.isEmpty == true ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _nameLocalController,
                  label: 'Food Name (Local Script)',
                  hint: 'e.g., लिट्टी छोखरा',
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _selectedRegion,
                  decoration: const InputDecoration(
                    labelText: 'Region',
                    border: OutlineInputBorder(),
                  ),
                  items: _regions.map((r) {
                    return DropdownMenuItem(value: r.$1, child: Text(r.$2));
                  }).toList(),
                  onChanged: (v) => setState(() => _selectedRegion = v),
                  validator: (v) => v == null ? 'Required' : null,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Nutrition per 100g',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _caloriesController,
                        label: 'Calories',
                        hint: 'kcal',
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: (v) => v?.isEmpty == true ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField(
                        controller: _proteinController,
                        label: 'Protein (g)',
                        hint: 'g',
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                        validator: (v) => v?.isEmpty == true ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _carbsController,
                        label: 'Carbs (g)',
                        hint: 'g',
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                        validator: (v) => v?.isEmpty == true ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField(
                        controller: _fatController,
                        label: 'Fat (g)',
                        hint: 'g',
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                        validator: (v) => v?.isEmpty == true ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _isSubmitting ? null : _submitFood,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Submit for Review'),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Submissions are reviewed before adding to the database',
                          style: TextStyle(color: Colors.blue.shade700, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
    );
  }

  Future<void> _submitFood() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Food submitted for review! Thank you.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}