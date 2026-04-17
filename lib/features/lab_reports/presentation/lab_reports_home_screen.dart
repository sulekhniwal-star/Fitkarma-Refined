import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../abha/data/abha_repository.dart';
import '../../../shared/widgets/encryption_badge.dart';

class LabReportsHomeScreen extends ConsumerWidget {
  const LabReportsHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final abhaLinkAsync = ref.watch(abhaStatusProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Reports'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: EncryptionBadge(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPrivacyNote(),
            const SizedBox(height: 20),
            _buildScanCTA(context),
            const SizedBox(height: 20),
            _buildAbhaCard(context, abhaLinkAsync),
            const SizedBox(height: 24),
            const Text(
              'Your Reports',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildReportsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyNote() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          Icon(Icons.privacy_tip_outlined, color: Colors.blue, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your reports are stored locally and encrypted. No health data is uploaded without your consent.',
              style: TextStyle(fontSize: 12, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanCTA(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFF9800), Color(0xFFF44336)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.push('/home/food/lab-scan'),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                const Icon(Icons.camera_alt, color: Colors.white, size: 32),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Scan New Report',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Import glucose, BP, and more using OCR',
                        style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAbhaCard(BuildContext context, AsyncValue<AbhaLinkData?> abhaLinkAsync) {
    return abhaLinkAsync.when(
      data: (link) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          onTap: () => context.push('/abha'),
          leading: Icon(
            Icons.health_and_safety,
            color: link != null ? Colors.green : Colors.blue,
            size: 32,
          ),
          title: Text(link != null ? 'Linked with ABHA' : 'Import from ABHA'),
          subtitle: Text(link != null 
            ? 'Last sync: ${link.lastSync != null ? link.lastSync!.toLocal().toString().split(' ')[0] : 'Never'}'
            : 'Connect your Digital Health ID'),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
      loading: () => const LinearProgressIndicator(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }

  Widget _buildReportsList() {
    // In a real app, we'd fetch this from Drift
    final mockReports = [
      {'lab': 'Dr. Lal PathLabs', 'date': '2026-04-10', 'metrics': '4'},
      {'lab': 'Apollo Diagnostics', 'date': '2026-03-15', 'metrics': '2'},
    ];

    if (mockReports.isEmpty) {
      return const Center(child: Text('No reports imported yet.'));
    }

    return Column(
      children: mockReports.map((r) => Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: const Icon(Icons.description_outlined),
          title: Text(r['lab']!),
          subtitle: Text('${r['date']} • ${r['metrics']} metrics imported'),
          trailing: TextButton(
            onPressed: () {},
            child: const Text('VIEW'),
          ),
        ),
      )).toList(),
    );
  }
}

