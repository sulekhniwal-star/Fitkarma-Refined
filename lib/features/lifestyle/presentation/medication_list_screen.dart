import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../data/lifestyle_providers.dart';
import '../data/lifestyle_repository.dart';
import '../../auth/data/auth_repository.dart';
import '../../../shared/theme/app_colors.dart';

class MedicationListScreen extends ConsumerWidget {
  const MedicationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider).asData?.value;
    final medsAsync = user != null 
        ? ref.watch(medicationProvider(user.$id)) 
        : const AsyncValue.loading();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Medications · दवाइयाँ', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal[700],
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMedication(context),
        backgroundColor: Colors.teal[700],
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: medsAsync.when(
        data: (meds) => meds.isEmpty
            ? _buildEmptyState(context)
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: meds.length,
                itemBuilder: (context, index) => _buildMedCard(context, meds[index]),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.medication_liquid, size: 80, color: Colors.teal[100]),
          const SizedBox(height: 16),
          const Text('No active medications', style: TextStyle(fontSize: 18, color: Colors.grey)),
          const SizedBox(height: 8),
          const Text('Track your prescriptions with reminders', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildMedCard(BuildContext context, dynamic med) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.teal[50],
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.medication, color: Colors.teal[700]),
        ),
        title: Text(med.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(med.dosage ?? 'No dosage specified', style: TextStyle(color: Colors.grey[700])),
            const SizedBox(height: 2),
            Row(
              children: [
                const Icon(Icons.event_repeat, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(med.frequency ?? 'As needed', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Show details or edit
        },
      ),
    );
  }

  void _showAddMedication(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => const AddMedicationBottomSheet(),
    );
  }
}

class AddMedicationBottomSheet extends ConsumerStatefulWidget {
  const AddMedicationBottomSheet({super.key});

  @override
  ConsumerState<AddMedicationBottomSheet> createState() => _AddMedicationBottomSheetState();
}

class _AddMedicationBottomSheetState extends ConsumerState<AddMedicationBottomSheet> {
  final _nameCtrl = TextEditingController();
  final _dosageCtrl = TextEditingController();
  DateTime _startDate = DateTime.now();
  String _frequency = 'Daily';
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24, right: 24, top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('New Medication · नई दवा', 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(
              labelText: 'Medication Name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.title),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _dosageCtrl,
            decoration: const InputDecoration(
              labelText: 'Dosage (e.g. 500mg, 1 tab)',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.scale),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _frequency,
            items: ['Daily', 'Twice a day', 'Three times a day', 'Weekly', 'As needed']
                .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                .toList(),
            onChanged: (v) => setState(() => _frequency = v!),
            decoration: const InputDecoration(
              labelText: 'Frequency',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.repeat),
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Start Date'),
            subtitle: Text(DateFormat('MMM d, yyyy').format(_startDate)),
            leading: const Icon(Icons.calendar_today),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _startDate,
                firstDate: DateTime.now().subtract(const Duration(days: 30)),
                lastDate: DateTime.now().add(const Duration(days: 30)),
              );
              if (picked != null) setState(() => _startDate = picked);
            },
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _isSaving ? null : _save,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal[700],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: _isSaving 
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('ADD MEDICATION', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    if (_nameCtrl.text.isEmpty) return;
    setState(() => _isSaving = true);
    try {
      final repo = ref.read(lifestyleRepositoryProvider.notifier);
      await repo.saveMedication(
        name: _nameCtrl.text,
        dosage: _dosageCtrl.text.isNotEmpty ? _dosageCtrl.text : null,
        frequency: _frequency,
        startDate: _startDate,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Medication added!')),
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
      setState(() => _isSaving = false);
    }
  }
}
