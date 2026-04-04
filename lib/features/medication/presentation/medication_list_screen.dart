import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class MedicationListScreen extends ConsumerWidget {
  final String userId;

  const MedicationListScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medications'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/medication/add', extra: userId),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: db.medicationsDao.watchActiveMedications(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final meds = snapshot.data ?? [];
          if (meds.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.medication_outlined, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'No medications added',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => context.push('/medication/add', extra: userId),
                    child: const Text('Add Medication'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: meds.length,
            itemBuilder: (context, index) {
              final med = meds[index];
              return _MedicationCard(
                medication: med,
                userId: userId,
                onTap: () => context.push('/medication/edit/${med.id}', extra: userId),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/medication/add', extra: userId),
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
    );
  }
}

class _MedicationCard extends StatelessWidget {
  final Medication medication;
  final String userId;
  final VoidCallback onTap;

  const _MedicationCard({
    required this.medication,
    required this.userId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.medication, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          medication.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (medication.dosage != null)
                          Text(
                            medication.dosage!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (medication.reminderEnabled == true)
                    const Icon(Icons.notifications_active, color: Colors.orange, size: 20),
                ],
              ),
              if (medication.frequency != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 16, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(
                      medication.frequency!,
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ],
              if (medication.pillsRemaining != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.inventory_2, size: 16, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(
                      '${medication.pillsRemaining} pills remaining',
                      style: TextStyle(
                        fontSize: 13,
                        color: medication.pillsRemaining! <= 10
                            ? Colors.red
                            : Colors.grey.shade600,
                      ),
                    ),
                    if (medication.estimatedRefillDate != null) ...[
                      const SizedBox(width: 12),
                      Icon(Icons.event, size: 16, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text(
                        'Refill: ${_formatDate(medication.estimatedRefillDate!)}',
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}