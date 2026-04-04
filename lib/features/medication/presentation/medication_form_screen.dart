import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' show Value;
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/features/medication/data/medication_reminder_service.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class MedicationFormScreen extends ConsumerStatefulWidget {
  final String userId;
  final int? medicationId;

  const MedicationFormScreen({
    super.key,
    required this.userId,
    this.medicationId,
  });

  @override
  ConsumerState<MedicationFormScreen> createState() => _MedicationFormScreenState();
}

class _MedicationFormScreenState extends ConsumerState<MedicationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _pillsController = TextEditingController();
  
  String _frequency = 'Once daily';
  String _category = 'General';
  TimeOfDay _reminderTime = const TimeOfDay(hour: 8, minute: 0);
  bool _reminderEnabled = false;
  bool _isLoading = false;
  bool _isEdit = false;
  Medication? _existingMedication;

  static const _frequencies = [
    'Once daily',
    'Twice daily',
    'Three times daily',
    'Four times daily',
    'Every other day',
    'Weekly',
    'As needed',
  ];

  static const _categories = [
    'General',
    'Blood Pressure',
    'Diabetes',
    'Pain',
    'Infection',
    'Allergy',
    'Mental Health',
    'Heart',
    'Thyroid',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _isEdit = widget.medicationId != null;
    if (_isEdit) _loadMedication();
  }

  Future<void> _loadMedication() async {
    final db = ref.read(appDatabaseProvider);
    final meds = await db.medicationsDao.getAllMedications(widget.userId);
    final med = meds.firstWhere((m) => m.id == widget.medicationId);
    
    setState(() {
      _existingMedication = med;
      _nameController.text = med.name;
      _dosageController.text = med.dosage ?? '';
      _pillsController.text = med.pillsRemaining?.toString() ?? '';
      _frequency = med.frequency ?? 'Once daily';
      _category = med.category ?? 'General';
      _reminderEnabled = med.reminderEnabled;
      if (med.reminderTime != null) {
        final parts = med.reminderTime!.split(':');
        if (parts.length == 2) {
          _reminderTime = TimeOfDay(
            hour: int.tryParse(parts[0]) ?? 8,
            minute: int.tryParse(parts[1]) ?? 0,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Medication' : 'Add Medication'),
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Medication Name *',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v?.isEmpty == true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dosageController,
                decoration: const InputDecoration(
                  labelText: 'Dosage',
                  hintText: 'e.g., 500mg, 10ml, 2 tablets',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _frequency,
                decoration: const InputDecoration(
                  labelText: 'Frequency',
                  border: OutlineInputBorder(),
                ),
                items: _frequencies.map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(),
                onChanged: (v) => setState(() => _frequency = v!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _category,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) => setState(() => _category = v!),
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pillsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Pills Remaining',
                  hintText: 'Number of pills currently available',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              SwitchListTile(
                title: const Text('Enable Reminder'),
                subtitle: const Text('Get notified when to take this medication'),
                value: _reminderEnabled,
                onChanged: (v) => setState(() => _reminderEnabled = v),
                contentPadding: EdgeInsets.zero,
              ),
              if (_reminderEnabled) ...[
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Reminder Time'),
                  trailing: Text(
                    _reminderTime.format(context),
                    style: const TextStyle(fontSize: 16, color: AppColors.primary),
                  ),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: _reminderTime,
                    );
                    if (time != null) {
                      setState(() => _reminderTime = time);
                    }
                  },
                ),
              ],
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _saveMedication,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : Text(_isEdit ? 'Update' : 'Add Medication'),
              ),
              if (_isEdit) ...[
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: _isLoading ? null : _deactivateMedication,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Deactivate Medication'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveMedication() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    try {
      final db = ref.read(appDatabaseProvider);
      final pills = int.tryParse(_pillsController.text);
      final reminderTimeStr = '${_reminderTime.hour.toString().padLeft(2, '0')}:${_reminderTime.minute.toString().padLeft(2, '0')}';
      
      if (_isEdit && _existingMedication != null) {
        await db.medicationsDao.updateMedication(
          MedicationsCompanion(
            id: Value(_existingMedication!.id),
            userId: Value(widget.userId),
            name: Value(_nameController.text),
            dosage: Value(_dosageController.text.isEmpty ? null : _dosageController.text),
            frequency: Value(_frequency),
            category: Value(_category),
            pillsRemaining: Value(pills),
            reminderTime: Value(_reminderEnabled ? reminderTimeStr : null),
            reminderEnabled: Value(_reminderEnabled),
            isActive: const Value(true),
          ),
        );
      } else {
        await db.medicationsDao.insertMedication(
          MedicationsCompanion.insert(
            userId: widget.userId,
            name: _nameController.text,
            dosage: Value(_dosageController.text.isEmpty ? null : _dosageController.text),
            frequency: Value(_frequency),
            category: Value(_category),
            pillsRemaining: Value(pills),
            reminderTime: Value(_reminderEnabled ? reminderTimeStr : null),
            reminderEnabled: Value(_reminderEnabled),
            isActive: true,
            createdAt: DateTime.now(),
          ),
        );
      }
      
      if (_reminderEnabled) {
        await MedicationReminderService.scheduleMedicationReminder(
          id: _existingMedication?.id ?? DateTime.now().millisecondsSinceEpoch,
          medicationName: _nameController.text,
          dosage: _dosageController.text.isEmpty ? 'your medication' : _dosageController.text,
          reminderTime: reminderTimeStr,
        );
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_isEdit ? 'Medication updated!' : 'Medication added!')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _deactivateMedication() async {
    setState(() => _isLoading = true);
    
    try {
      final db = ref.read(appDatabaseProvider);
      await db.medicationsDao.updateMedication(
        MedicationsCompanion(
          id: Value(_existingMedication!.id),
          userId: Value(widget.userId),
          name: Value(_existingMedication!.name),
          dosage: Value(_existingMedication!.dosage),
          frequency: Value(_existingMedication!.frequency),
          category: Value(_existingMedication!.category),
          pillsRemaining: Value(_existingMedication!.pillsRemaining),
          reminderTime: const Value(null),
          reminderEnabled: const Value(false),
          isActive: const Value(false),
          createdAt: Value(_existingMedication!.createdAt),
        ),
      );
      
      await MedicationReminderService.cancelReminder(_existingMedication!.id);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Medication deactivated')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _pillsController.dispose();
    super.dispose();
  }
}