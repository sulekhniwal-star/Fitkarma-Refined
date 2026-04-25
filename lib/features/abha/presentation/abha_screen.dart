import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/abha_repository.dart';
import '../../auth/domain/auth_providers.dart';
import '../../../shared/widgets/abha_link_badge.dart';
import '../../../shared/widgets/encryption_badge.dart';
import '../domain/abha_health_record.dart';
import 'package:fitkarma/core/theme/app_colors.dart';

class ABHAScreen extends ConsumerStatefulWidget {
  const ABHAScreen({super.key});

  @override
  ConsumerState<ABHAScreen> createState() => _ABHAScreenState();
}

class _ABHAScreenState extends ConsumerState<ABHAScreen> {
  final _idController = TextEditingController();
  final _otpController = TextEditingController();
  bool _otpSent = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _idController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _verifyOTP() async {
    setState(() => _isLoading = true);
    try {
      final userId = ref.read(authStateProvider).value?.id;
      if (userId == null) throw Exception('User not logged in');

      await ref.read(abhaRepositoryProvider).linkABHA(
        userId: userId,
        abhaId: _idController.text,
        otp: _otpController.text,
      );

      // Refresh status
      ref.invalidate(abhaStatusProvider);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ABHA linked successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusAsync = ref.watch(abhaStatusProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ABHA (Digital Health ID)'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: EncryptionBadge(),
          ),
        ],
      ),
      body: statusAsync.when(
        data: (link) => _buildBody(link),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildBody(AbhaLinkData? link) {
    final isLinked = link != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          ABHALinkBadge(isLinked: isLinked, isLarge: true),
          const SizedBox(height: 32),
          if (!isLinked) _buildUnlinkedForm() else _buildLinkedInfo(link),
          const SizedBox(height: 40),
          _buildConsentNote(),
        ],
      ),
    );
  }

  Widget _buildUnlinkedForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Link your ABHA Number',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Experience seamless access to your health records across India.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 32),
        TextField(
          controller: _idController,
          decoration: const InputDecoration(
            labelText: '14-digit ABHA Number',
            hintText: 'XX-XXXX-XXXX-XXXX',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          maxLength: 14,
        ),
        const SizedBox(height: 16),
        if (_otpSent) ...[
          TextField(
            controller: _otpController,
            decoration: const InputDecoration(
              labelText: 'OTP',
              hintText: 'Enter 6-digit OTP',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
        ],
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _isLoading ? null : (_otpSent ? _verifyOTP : () => setState(() => _otpSent = true)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: _isLoading 
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(_otpSent ? 'VERIFY OTP' : 'SEND OTP'),
          ),
        ),
      ],
    );
  }

  Widget _buildLinkedInfo(AbhaLinkData link) {
    final maskedId = '${link.id.substring(0, 2)}-XXXX-XXXX-${link.id.substring(link.id.length - 4)}';
    
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text('ABHA ID'),
                  subtitle: Text(maskedId, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  trailing: const Icon(Icons.verified, color: Colors.green),
                ),
                if (link.address != null)
                  ListTile(
                    title: const Text('ABHA Address'),
                    subtitle: Text(link.address!),
                  ),
                ListTile(
                  title: const Text('Last Synchronized'),
                  subtitle: Text(link.lastSync != null ? link.lastSync.toString() : 'Once linked'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Linked Records', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton.icon(
              onPressed: () => ref.refresh(abhaRecordsProvider),
              icon: const Icon(Icons.sync, size: 18),
              label: const Text('Refresh'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Consumer(builder: (context, ref, _) {
          final recordsAsync = ref.watch(abhaRecordsProvider);
          return recordsAsync.when(
            data: (records) {
              if (records.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Text('No verified records found in ABHA.', style: TextStyle(color: Colors.grey)),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: records.length,
                itemBuilder: (context, i) => _buildLinkedRecordItem(records[i]),
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => Center(child: Text('Failed to load records: $e')),
          );
        }),
      ],
    );
  }

  Widget _buildLinkedRecordItem(AbhaHealthRecord record) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _getRecordColor(record.type).withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(_getRecordIcon(record.type), color: _getRecordColor(record.type)),
        ),
        title: Text(
          _getRecordTitle(record.type),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(record.source),
            Text(
              '${record.date.day} ${_getMonth(record.date.month)} ${record.date.year}',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
        trailing: record.isImported
            ? const Icon(Icons.check_circle, color: Colors.green)
            : ElevatedButton(
                onPressed: () => _importRecord(record),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(80, 36),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('IMPORT', style: TextStyle(fontSize: 11)),
              ),
      ),
    );
  }

  IconData _getRecordIcon(AbhaRecordType type) {
    switch (type) {
      case AbhaRecordType.bloodPressure: return Icons.favorite_rounded;
      case AbhaRecordType.glucose: return Icons.bloodtype_rounded;
      case AbhaRecordType.labReport: return Icons.biotech_rounded;
      case AbhaRecordType.prescription: return Icons.description_rounded;
      default: return Icons.health_and_safety_rounded;
    }
  }

  Color _getRecordColor(AbhaRecordType type) {
    switch (type) {
      case AbhaRecordType.bloodPressure: return Colors.red;
      case AbhaRecordType.glucose: return Colors.orange;
      case AbhaRecordType.labReport: return Colors.blue;
      case AbhaRecordType.prescription: return Colors.teal;
      default: return Colors.grey;
    }
  }

  String _getRecordTitle(AbhaRecordType type) {
    switch (type) {
      case AbhaRecordType.bloodPressure: return 'Blood Pressure';
      case AbhaRecordType.glucose: return 'Blood Glucose';
      case AbhaRecordType.labReport: return 'Lab Report';
      case AbhaRecordType.prescription: return 'Prescription';
      default: return 'Health Record';
    }
  }

  String _getMonth(int m) => ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][m-1];

  Future<void> _importRecord(AbhaHealthRecord record) async {
    setState(() => _isLoading = true);
    try {
      final userId = ref.read(authStateProvider).value?.id;
      if (userId == null) return;

      await ref.read(abhaRepositoryProvider).importHealthRecord(userId, record);
      
      // Force refresh records to show the "check" icon
      ref.invalidate(abhaRecordsProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.verified, color: Colors.white),
                const SizedBox(width: 12),
                Text('Imported ${record.type.name} to Health Log!'),
              ],
            ),
             backgroundColor: AppColorsDark.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Import failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildConsentNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        'Consent: By linking your ABHA, you allow FitKarma to process your digital health records. You can revoke this consent anytime in settings.',
        style: TextStyle(fontSize: 11, color: Colors.grey),
      ),
    );
  }
}

