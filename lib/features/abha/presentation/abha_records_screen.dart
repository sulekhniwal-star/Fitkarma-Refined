import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../data/abha_providers.dart';
import '../data/models/abha_health_records.dart';

/// Screen for viewing ABHA health records (prescriptions and discharge summaries)
class ABHARecordsScreen extends ConsumerStatefulWidget {
  const ABHARecordsScreen({super.key});

  @override
  ConsumerState<ABHARecordsScreen> createState() => _ABHARecordsScreenState();
}

class _ABHARecordsScreenState extends ConsumerState<ABHARecordsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadRecords();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadRecords() async {
    await ref.read(abhaHealthRecordsProvider).fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    final recordsState = ref.watch(abhaHealthRecordsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Records'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _loadRecords,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: [
            Tab(
              text:
                  'Prescriptions (${recordsState.state.prescriptions.length})',
            ),
            Tab(
              text:
                  'Discharge (${recordsState.state.dischargeSummaries.length})',
            ),
          ],
        ),
      ),
      body: recordsState.state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildPrescriptionsList(recordsState.state),
                _buildDischargeList(recordsState.state),
              ],
            ),
    );
  }

  Widget _buildPrescriptionsList(ABHAHealthRecordsState state) {
    if (state.isLoadingPrescriptions) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.prescriptions.isEmpty) {
      return _buildEmptyState(
        icon: Icons.description_outlined,
        title: 'No Prescriptions',
        subtitle:
            'Your prescriptions from ABHA-linked facilities will appear here',
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(abhaHealthRecordsProvider).fetchPrescriptions();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.prescriptions.length,
        itemBuilder: (context, index) {
          return _buildRecordCard(state.prescriptions[index]);
        },
      ),
    );
  }

  Widget _buildDischargeList(ABHAHealthRecordsState state) {
    if (state.isLoadingDischargeSummaries) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.dischargeSummaries.isEmpty) {
      return _buildEmptyState(
        icon: Icons.local_hospital_outlined,
        title: 'No Discharge Summaries',
        subtitle:
            'Your discharge summaries from ABHA-linked facilities will appear here',
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(abhaHealthRecordsProvider).fetchDischargeSummaries();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.dischargeSummaries.length,
        itemBuilder: (context, index) {
          return _buildRecordCard(state.dischargeSummaries[index]);
        },
      ),
    );
  }

  Widget _buildRecordCard(ABHAHealthRecord record) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _getRecordTypeColor(
                      record.recordType,
                    ).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getRecordTypeIcon(record.recordType),
                    color: _getRecordTypeColor(record.recordType),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.displayTitle,
                        style: AppTextStyles.labelLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        record.facilityName ?? 'Unknown Facility',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (record.recordDate != null)
                  Text(
                    _formatDate(record.recordDate!),
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
              ],
            ),
          ),

          // Diagnosis
          if (record.diagnosis != null && record.diagnosis!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Diagnosis',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(record.diagnosis!, style: AppTextStyles.bodyMedium),
                  ],
                ),
              ),
            ),

          // Medications
          if (record.medications.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Medications',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: record.medications.map((med) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.teal.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.teal.withOpacity(0.2),
                          ),
                        ),
                        child: Text(
                          med,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.teal,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

          // Doctor Name
          if (record.doctorName != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: [
                  const Icon(
                    Icons.person_outline_rounded,
                    size: 16,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Dr. ${record.doctorName}',
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

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 40, color: AppColors.textMuted),
            ),
            const SizedBox(height: 24),
            Text(title, style: AppTextStyles.h4),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getRecordTypeIcon(String recordType) {
    switch (recordType) {
      case 'prescription':
        return Icons.description_outlined;
      case 'discharge_summary':
        return Icons.local_hospital_outlined;
      case 'lab_report':
        return Icons.science_outlined;
      default:
        return Icons.article_outlined;
    }
  }

  Color _getRecordTypeColor(String recordType) {
    switch (recordType) {
      case 'prescription':
        return AppColors.primary;
      case 'discharge_summary':
        return AppColors.teal;
      case 'lab_report':
        return AppColors.purple;
      default:
        return AppColors.textSecondary;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
