import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../health/data/health_repository.dart';
import '../../../shared/theme/app_colors.dart';

class PeriodLogScreen extends ConsumerStatefulWidget {
  const PeriodLogScreen({super.key});

  @override
  ConsumerState<PeriodLogScreen> createState() => _PeriodLogScreenState();
}

class _PeriodLogScreenState extends ConsumerState<PeriodLogScreen> {
  DateTime _startDate = DateTime.now();
  String? _flowIntensity;
  final List<String> _selectedSymptoms = [];
  final _notesController = TextEditingController();
  bool _isLoading = false;

  final _flowOptions = [
    {'label': 'Light', 'icon': Icons.opacity, 'color': Colors.pink[100]},
    {'label': 'Medium', 'icon': Icons.opacity, 'color': Colors.pink[300]},
    {'label': 'Heavy', 'icon': Icons.opacity, 'color': Colors.pink[700]},
  ];

  final _symptomOptions = [
    'Cramps', 'Bloating', 'Mood Swings', 'Headache', 'Fatigue', 
    'Spotting', 'Back Pain', 'Acne', 'Cravings'
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(healthRepositoryProvider);
      await repo.savePeriodLog(
        startDate: _startDate,
        flowIntensity: _flowIntensity,
        symptoms: _selectedSymptoms.isNotEmpty ? _selectedSymptoms : null,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Period log saved! +10 XP')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Period Tracker · मासिक धर्म ट्रैकर', 
          style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pink[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDatePicker(),
            const SizedBox(height: 32),
            _buildFlowSection(),
            const SizedBox(height: 32),
            _buildSymptomsSection(),
            const SizedBox(height: 32),
            _buildNotesSection(),
            const SizedBox(height: 40),
            _buildSaveButton(),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                '🔒 Data is encrypted end-to-end',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('When did it start?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: _startDate,
              firstDate: DateTime.now().subtract(const Duration(days: 90)),
              lastDate: DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(primary: Colors.pink[700]!),
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null) setState(() => _startDate = picked);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.pink[50]!),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.pink),
                const SizedBox(width: 12),
                Text(
                  DateFormat('MMMM d, yyyy').format(_startDate),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                const Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFlowSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Flow Intensity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _flowOptions.map((opt) {
            final isSelected = _flowIntensity == opt['label'];
            return GestureDetector(
              onTap: () => setState(() => _flowIntensity = opt['label'] as String),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.28,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: isSelected ? (opt['color'] as Color).withOpacity(0.2) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? (opt['color'] as Color) : Colors.pink[50]!,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(opt['icon'] as IconData, 
                      color: isSelected ? (opt['color'] as Color) : Colors.grey[400],
                      size: 32),
                    const SizedBox(height: 8),
                    Text(opt['label'] as String, 
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? opt['color'] as Color : Colors.grey[600],
                      )),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSymptomsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Symptoms', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _symptomOptions.map((sym) {
            final isSelected = _selectedSymptoms.contains(sym);
            return FilterChip(
              label: Text(sym),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedSymptoms.add(sym);
                  } else {
                    _selectedSymptoms.remove(sym);
                  }
                });
              },
              backgroundColor: Colors.white,
              selectedColor: Colors.pink[100],
              checkmarkColor: Colors.pink[700],
              labelStyle: TextStyle(
                color: isSelected ? Colors.pink[700] : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: isSelected ? Colors.pink[700]! : Colors.pink[50]!),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Notes (Encrypted) 🔒', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        TextField(
          controller: _notesController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Any other observations...',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.pink[50]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.pink[50]!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _save,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink[700],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
        ),
        child: _isLoading 
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text('CONFIRM LOG · लॉग करें', 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
      ),
    );
  }
}
