import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/medications/data/medications_service.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

class MedicationsScreen extends ConsumerStatefulWidget {
  const MedicationsScreen({super.key});

  @override
  ConsumerState<MedicationsScreen> createState() => _MedicationsScreenState();
}

class _MedicationsScreenState extends ConsumerState<MedicationsScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: Get userId from auth
    const String userId = 'demo_user';

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Medications'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddMedicationDialog(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Active Medications Section
          _buildSectionHeader('Active Medications'),
          _buildMedicationsList(userId, activeOnly: true),

          const SizedBox(height: 24),

          // All Medications Section
          _buildSectionHeader('All Medications'),
          _buildMedicationsList(userId, activeOnly: false),

          const SizedBox(height: 24),

          // Refill Alerts Section
          _buildRefillAlertsSection(userId),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddMedicationDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Medication'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: AppTextStyles.h4.copyWith(color: AppColors.primary),
      ),
    );
  }

  Widget _buildMedicationsList(String userId, {required bool activeOnly}) {
    // TODO: Implement with actual service provider
    // For now, show placeholder
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.medication, size: 48, color: AppColors.textMuted),
            const SizedBox(height: 8),
            Text(
              activeOnly ? 'No active medications' : 'No medications added',
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Tap + to add your first medication',
              style: AppTextStyles.caption,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRefillAlertsSection(String userId) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.notifications_active,
                  color: AppColors.warning,
                ),
                const SizedBox(width: 8),
                Text('Refill Alerts', style: AppTextStyles.h4),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Get notified 3 days before your medications need refilling',
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  void _showAddMedicationDialog(BuildContext context) {
    String name = '';
    String dose = '';
    String frequency = 'once_daily';
    String category = 'prescription';
    String? reminderTime;
    int? refillDays;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add Medication', style: AppTextStyles.h4),
                const SizedBox(height: 16),

                // Medication Name
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Medication Name *',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => name = value,
                ),
                const SizedBox(height: 12),

                // Dosage
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Dosage *',
                    hintText: 'e.g., 500mg, 2 tablets',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => dose = value,
                ),
                const SizedBox(height: 12),

                // Frequency
                DropdownButtonFormField<String>(
                  value: frequency,
                  decoration: const InputDecoration(
                    labelText: 'Frequency',
                    border: OutlineInputBorder(),
                  ),
                  items: MedicationFrequency.values
                      .map(
                        (f) => DropdownMenuItem(
                          value: f.dbValue,
                          child: Text(f.displayName),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setModalState(() => frequency = value);
                  },
                ),
                const SizedBox(height: 12),

                // Category
                DropdownButtonFormField<String>(
                  value: category,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  items: MedicationCategory.values
                      .map(
                        (c) => DropdownMenuItem(
                          value: c.dbValue,
                          child: Text(c.displayName),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setModalState(() => category = value);
                  },
                ),
                const SizedBox(height: 12),

                // Reminder Time
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.access_time),
                  title: const Text('Reminder Time'),
                  subtitle: Text(reminderTime ?? 'Not set'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        setModalState(
                          () => reminderTime = time.format(context),
                        );
                      }
                    },
                  ),
                ),

                // Refill Duration
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Refill Duration (days)',
                    hintText: 'e.g., 30',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => refillDays = int.tryParse(value),
                ),

                const SizedBox(height: 16),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (name.isEmpty || dose.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill in required fields'),
                          ),
                        );
                        return;
                      }
                      // TODO: Save medication via service
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Medication added!')),
                      );
                    },
                    child: const Text('Save Medication'),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
