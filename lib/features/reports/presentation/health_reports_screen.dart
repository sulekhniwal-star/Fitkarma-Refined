import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/network/appwrite_client.dart';
import 'dart:convert';

class HealthReportsScreen extends ConsumerStatefulWidget {
  const HealthReportsScreen({super.key});

  @override
  ConsumerState<HealthReportsScreen> createState() => _HealthReportsScreenState();
}

class _HealthReportsScreenState extends ConsumerState<HealthReportsScreen> {
  String? _shareUrl;
  DateTime? _expiresAt;
  bool _isGenerating = false;

  Future<void> _shareReport(String type) async {
    setState(() => _isGenerating = true);
    try {
      final functions = AppwriteClient.functions;
      final response = await functions.createExecution(
        functionId: 'core-engine',
        body: jsonEncode({
          'action': 'shareable-health-report',
          'report_type': type,
        }),
      );

      if (response.status == 'completed') {
        final data = jsonDecode(response.responseBody);
        setState(() {
          _shareUrl = data['share_url'];
          _expiresAt = DateTime.parse(data['expires_at']);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _isGenerating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health Reports')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildReportCard('Weekly Summary', 'April 7 - April 13', 'Steps: 45k • Avg Sleep: 7.2h'),
            const SizedBox(height: 16),
            _buildReportCard('Monthly Insight', 'March 2026', 'BP: Normal • Mood: Steady'),
            const SizedBox(height: 24),
            if (_shareUrl != null) 
              _HealthShareCard(
                url: _shareUrl!, 
                expiresAt: _expiresAt!,
                onDelete: () => setState(() => _shareUrl = null),
              ),
            if (_isGenerating)
              const Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(String title, String subtitle, String stats) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Icon(Icons.description, color: Colors.blue),
              ],
            ),
            Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 12),
            Text(stats, style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.picture_as_pdf, size: 18),
                    label: const Text('VIEW PDF'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade200, foregroundColor: Colors.black87),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _shareReport(title),
                    icon: const Icon(Icons.share, size: 18),
                    label: const Text('SHARE'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HealthShareCard extends StatelessWidget {
  final String url;
  final DateTime expiresAt;
  final VoidCallback onDelete;

  const _HealthShareCard({required this.url, required this.expiresAt, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final daysLeft = expiresAt.difference(DateTime.now()).inDays;

    return Card(
      color: Colors.green.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Colors.green.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(Icons.link, color: Colors.green),
                SizedBox(width: 12),
                Text('Active Share Link', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 12),
            Text(url, style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline), overflow: TextOverflow.ellipsis),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Expires in $daysLeft days', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.copy, size: 20),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Share.share('My Health Report: $url'),
                icon: const Icon(Icons.share),
                label: const Text('SHARE REPORT'),
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF25D366)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
