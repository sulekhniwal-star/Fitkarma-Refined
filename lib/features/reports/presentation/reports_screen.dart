// lib/features/reports/presentation/reports_screen.dart
// Reports Screen - Generate and manage health PDF reports

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:fitkarma/features/reports/data/report_data.dart';
import 'package:fitkarma/features/reports/data/report_providers.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

// Provider for current user name
final currentUserNameProvider = FutureProvider<String>((ref) async {
  // TODO: Get from actual user profile
  return 'User';
});

class ReportsScreen extends ConsumerStatefulWidget {
  final String? userId;
  final String? userName;

  const ReportsScreen({
    super.key,
    this.userId,
    this.userName,
  });

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _userId = '';
  String _userName = 'User';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    // TODO: Load user info from providers
    // For now, use values from widget or defaults
    if (mounted) {
      setState(() {
        _userId = widget.userId ?? '';
        _userName = widget.userName ?? 'User';
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Reports'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'PDF Reports', icon: Icon(Icons.picture_as_pdf)),
            Tab(text: 'Doctor Link', icon: Icon(Icons.link)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _PdfReportsTab(userId: _userId, userName: _userName),
          _DoctorLinkTab(userId: _userId, userName: _userName),
        ],
      ),
    );
  }
}

/// Tab 1: PDF Reports
class _PdfReportsTab extends ConsumerWidget {
  final String userId;
  final String userName;

  const _PdfReportsTab({
    required this.userId,
    required this.userName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedReports = ref.watch(savedReportsProvider);
    final generationState = ref.watch(reportGenerationProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Generate Report Section
          _buildGenerateSection(context, ref, generationState),
          const SizedBox(height: 24),

          // Saved Reports Section
          Text(
            'Saved Reports',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),

          savedReports.when(
            data: (reports) => reports.isEmpty
                ? _buildEmptyState()
                : _buildReportsList(context, ref, reports),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(
              child: Text('Error loading reports: $e'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenerateSection(
    BuildContext context,
    WidgetRef ref,
    ReportGenerationState state,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.picture_as_pdf,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Generate Health Report',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Doctor-friendly format with reference ranges',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (state.isGenerating)
              const Center(child: CircularProgressIndicator())
            else if (state.error != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(child: Text(state.error!, style: const TextStyle(color: Colors.red))),
                  ],
                ),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _generateReport(context, ref, 'weekly'),
                      icon: const Icon(Icons.calendar_view_week),
                      label: const Text('Weekly'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _generateReport(context, ref, 'monthly'),
                      icon: const Icon(Icons.calendar_month),
                      label: const Text('Monthly'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _generateReport(
    BuildContext context,
    WidgetRef ref,
    String period,
  ) async {
    try {
      // Show loading
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Generating $period report...'),
          duration: const Duration(seconds: 2),
        ),
      );

      // TODO: Call actual PDF generation service via ReportService
      // For now, we'll show a placeholder
      await Future.delayed(const Duration(seconds: 1));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$period report generated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Refresh saved reports
        ref.invalidate(savedReportsProvider);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generating report: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.folder_open,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No saved reports',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Generate a weekly or monthly report to get started',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildReportsList(
    BuildContext context,
    WidgetRef ref,
    List<ReportFileInfo> reports,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        final report = reports[index];
        return _ReportCard(
          report: report,
          onShare: () => _shareReport(context, report),
          onPrint: () => _printReport(context, report),
          onDelete: () => _deleteReport(context, ref, report),
        );
      },
    );
  }

  Future<void> _shareReport(BuildContext context, ReportFileInfo report) async {
    try {
      final file = File(report.filePath);
      if (await file.exists()) {
        await Share.shareXFiles(
          [XFile(report.filePath)],
          text: 'Health Report - ${report.reportName}',
        );
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Report file not found'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sharing: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _printReport(BuildContext context, ReportFileInfo report) async {
    try {
      // Using platform printing
      final file = File(report.filePath);
      if (await file.exists()) {
        // Note: For actual printing, you'd use flutter_print or printing package
        await Share.shareXFiles(
          [XFile(report.filePath)],
          text: 'Print Health Report - ${report.reportName}',
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error printing: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteReport(
    BuildContext context,
    WidgetRef ref,
    ReportFileInfo report,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Report'),
        content: Text('Are you sure you want to delete "${report.reportName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final notifier = ref.read(reportGenerationProvider.notifier);
      final success = await notifier.deleteReport(report.filePath);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success ? 'Report deleted' : 'Failed to delete report'),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
      }
    }
  }
}

/// Report Card Widget
class _ReportCard extends StatelessWidget {
  final ReportFileInfo report;
  final VoidCallback onShare;
  final VoidCallback onPrint;
  final VoidCallback onDelete;

  const _ReportCard({
    required this.report,
    required this.onShare,
    required this.onPrint,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.picture_as_pdf,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report.reportName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Generated: ${_formatDate(report.generatedAt)}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    _formatFileSize(report.fileSize),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'share':
                    onShare();
                    break;
                  case 'print':
                    onPrint();
                    break;
                  case 'delete':
                    onDelete();
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'share',
                  child: Row(
                    children: [
                      Icon(Icons.share, size: 20),
                      SizedBox(width: 8),
                      Text('Share'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'print',
                  child: Row(
                    children: [
                      Icon(Icons.print, size: 20),
                      SizedBox(width: 8),
                      Text('Print'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

/// Tab 2: Doctor Share Link
class _DoctorLinkTab extends ConsumerWidget {
  final String userId;
  final String userName;

  const _DoctorLinkTab({
    required this.userId,
    required this.userName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shareLinkState = ref.watch(shareLinkProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info Card
          _buildInfoCard(context),
          const SizedBox(height: 20),

          // Generate Link Section
          _buildGenerateLinkSection(context, ref, shareLinkState),
          const SizedBox(height: 24),

          // Active Links Section
          Text(
            'Active Links',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),

          if (shareLinkState.activeLinks.isEmpty)
            _buildEmptyLinksState()
          else
            _buildActiveLinksList(context, ref, shareLinkState.activeLinks),

          // Privacy Notice
          const SizedBox(height: 24),
          _buildPrivacyNotice(context),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Card(
      elevation: 2,
      color: AppColors.primary.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(
              Icons.medical_information,
              color: AppColors.primary,
              size: 32,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Share with Your Doctor',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Generate a secure, time-limited link to share your health summary with your healthcare provider.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenerateLinkSection(
    BuildContext context,
    WidgetRef ref,
    ShareLinkState state,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.shareUrl != null) ...[
              // Link Generated
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.green),
                        const SizedBox(width: 8),
                        const Text(
                          'Link Generated!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              state.shareUrl!,
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () => _copyToClipboard(context, state.shareUrl!),
                            tooltip: 'Copy to clipboard',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _shareViaWhatsApp(context, state.shareUrl!),
                            icon: const Icon(Icons.chat),
                            label: const Text('WhatsApp'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _shareLink(context, state.shareUrl!),
                            icon: const Icon(Icons.share),
                            label: const Text('Share'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        ref.read(shareLinkProvider.notifier).clearShareUrl();
                      },
                      child: const Text('Generate New Link'),
                    ),
                  ],
                ),
              ),
            ] else ...[
              // Generate Button
              if (state.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (state.error != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          state.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Column(
                  children: [
                    // Preview of what's shared
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'This link will show:',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 12),
                          _buildSharePreviewItem(
                            Icons.show_chart,
                            '30-day BP trend (avg systolic/diastolic)',
                          ),
                          _buildSharePreviewItem(
                            Icons.bloodtype,
                            'Glucose log summary (avg, min, max)',
                          ),
                          _buildSharePreviewItem(
                            Icons.monitor_weight,
                            'Weight trend',
                          ),
                          _buildSharePreviewItem(
                            Icons.science,
                            'Key lab values',
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '🔒 Raw logs, journal entries, and period data are NOT shared',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _generateLink(context, ref),
                        icon: const Icon(Icons.link),
                        label: const Text('Generate Doctor Link'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSharePreviewItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(text, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        ],
      ),
    );
  }

  Widget _buildEmptyLinksState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.link_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No active share links',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Generate a link above to share with your doctor',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActiveLinksList(
    BuildContext context,
    WidgetRef ref,
    List<ShareLinkInfo> links,
  ) {
    // Filter out revoked links
    final activeLinks = links.where((l) => !l.isRevoked).toList();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activeLinks.length,
      itemBuilder: (context, index) {
        final link = activeLinks[index];
        return _ActiveLinkCard(
          link: link,
          onRevoke: () => _revokeLink(context, ref, link),
        );
      },
    );
  }

  Widget _buildPrivacyNotice(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.privacy_tip, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Privacy Protected',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Only aggregate statistics are shared. Your raw health logs, journal entries, and personal data are never exposed. Links automatically expire after 7 days.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _generateLink(BuildContext context, WidgetRef ref) async {
    final url = await ref.read(shareLinkProvider.notifier).generateShareLink(
          userId: userId,
          userName: userName,
        );

    if (url != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Link generated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _copyToClipboard(BuildContext context, String url) {
    Clipboard.setData(ClipboardData(text: url));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Link copied to clipboard!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _shareViaWhatsApp(BuildContext context, String url) async {
    // Note: For actual WhatsApp sharing, you'd use url_launcher with whatsapp scheme
    // For now, copy to clipboard
    _copyToClipboard(context, url);
  }

  Future<void> _shareLink(BuildContext context, String url) async {
    await Share.share(
      'Here is my health summary from Fitkarma: $url',
      subject: 'My Health Summary',
    );
  }

  Future<void> _revokeLink(
    BuildContext context,
    WidgetRef ref,
    ShareLinkInfo link,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Revoke Link'),
        content: const Text(
          'Are you sure you want to revoke this share link? '
          'Your doctor will no longer be able to access it.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Revoke'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      ref.read(shareLinkProvider.notifier).revokeLink(link.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Link revoked successfully'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }
}

/// Active Link Card Widget
class _ActiveLinkCard extends StatelessWidget {
  final ShareLinkInfo link;
  final VoidCallback onRevoke;

  const _ActiveLinkCard({
    required this.link,
    required this.onRevoke,
  });

  @override
  Widget build(BuildContext context) {
    final daysRemaining = link.expiresAt.difference(DateTime.now()).inDays;
    final isExpired = daysRemaining < 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isExpired
                    ? Colors.grey.withValues(alpha: 0.1)
                    : Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                isExpired ? Icons.link_off : Icons.link,
                color: isExpired ? Colors.grey : Colors.orange,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isExpired ? 'Expired' : 'Active',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isExpired ? Colors.grey : Colors.orange[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isExpired
                        ? 'Expired on ${_formatDate(link.expiresAt)}'
                        : 'Expires in $daysRemaining days (${_formatDate(link.expiresAt)})',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Created: ${_formatDate(link.createdAt)}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (!isExpired)
              TextButton(
                onPressed: onRevoke,
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Revoke'),
              ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}