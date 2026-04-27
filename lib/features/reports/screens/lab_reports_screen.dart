import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/status_widgets.dart';
import '../../reports/providers/report_provider.dart';

// ── Screen ─────────────────────────────────────────────────────────────────────

class LabReportsScreen extends ConsumerWidget {
  const LabReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final bg1 = isDark ? AppColorsDark.bg1 : AppColorsLight.bg1;
    final divider = isDark ? AppColorsDark.divider : AppColorsLight.divider;

    // Calm Zone — no blobs, no glow
    // TODO: wire to user profile provider — false until ABHA linked
    // ignore: dead_code
    final bool abhaLinked = false;

    final reportsAsync = ref.watch(labReportsProvider);

    return Scaffold(
      backgroundColor: bg1,
      appBar: AppBar(
        backgroundColor: bg1,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back_ios_new_rounded,
              size: 20, color: text2),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lab Reports',
                style: AppTypography.h1(color: text0)),
            Text('लैब रिपोर्ट',
                style: AppTypography.hindi(color: text2)),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenH, 16, AppSpacing.screenH, 32),
        children: [
          // ── Scan CTA card ─────────────────────────────────────
          _ScanCTACard(isDark: isDark, text0: text0, text2: text2),
          const SizedBox(height: 20),

          // ── Imported reports list ─────────────────────────────
          Text('Imported Reports',
              style: AppTypography.h4(color: text0)),
          const SizedBox(height: 10),
          reportsAsync.when(
            data: (reports) => reports.isEmpty
                ? _EmptyReports(text2: text2)
                : Column(
                    children: reports
                        .map((r) => Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8),
                              child: _ReportRow(
                                report: r,
                                isDark: isDark,
                                text0: text0,
                                text2: text2,
                                divider: divider,
                                onShare: () async {
                                  await ref.read(
                                      shareLinkProvider(r.id).future);
                                },
                                onDelete: () {},
                              ),
                            ))
                        .toList(),
                  ),
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(
                  child: CircularProgressIndicator(strokeWidth: 2)),
            ),
            error: (_, __) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text('Could not load reports',
                  style: AppTypography.bodySm(color: text2)),
            ),
          ),
          const SizedBox(height: 20),

          // ── Import from ABHA (if linked) ──────────────────────
          // ignore: dead_code
          if (abhaLinked) ...[
            _ABHAImportCard(isDark: isDark, text0: text0, text2: text2),
            const SizedBox(height: 20),
          ],

          // ── Privacy footnote ──────────────────────────────────
          _PrivacyCard(isDark: isDark, text2: text2, divider: divider),
        ],
      ),
    );
  }
}

// ── Scan CTA card ──────────────────────────────────────────────────────────────

class _ScanCTACard extends StatelessWidget {
  final bool isDark;
  final Color text0, text2;
  const _ScanCTACard(
      {required this.isDark, required this.text0, required this.text2});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/home/food/lab-scan'),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark
              ? AppColorsDark.surface0
              : AppColorsLight.surface0,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
              color: AppColorsDark.teal.withValues(alpha: 0.35)),
        ),
        child: Row(
          children: [
            // Animated scan icon placeholder (Lottie would go here)
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColorsDark.teal.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.document_scanner_rounded,
                  size: 28, color: AppColorsDark.teal),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Scan New Report',
                      style: AppTypography.h3(color: text0)),
                  const SizedBox(height: 4),
                  Text(
                    'Take a photo or upload a PDF to extract health values automatically.',
                    style: AppTypography.bodySm(color: text2),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 16, color: AppColorsDark.teal),
          ],
        ),
      ),
    );
  }
}

// ── Empty state ────────────────────────────────────────────────────────────────

class _EmptyReports extends StatelessWidget {
  final Color text2;
  const _EmptyReports({required this.text2});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            Icon(Icons.folder_open_rounded,
                size: 48, color: text2.withValues(alpha: 0.4)),
            const SizedBox(height: 12),
            Text('No lab reports imported yet.',
                style: AppTypography.bodyMd(color: text2)),
            const SizedBox(height: 4),
            Text('Tap "Scan New Report" to get started.',
                style: AppTypography.bodySm(color: text2)),
          ],
        ),
      );
}

// ── Report row with swipe actions ─────────────────────────────────────────────

class _ReportRow extends StatelessWidget {
  final dynamic report;
  final bool isDark;
  final Color text0, text2, divider;
  final VoidCallback onShare, onDelete;
  const _ReportRow({
    required this.report,
    required this.isDark,
    required this.text0,
    required this.text2,
    required this.divider,
    required this.onShare,
    required this.onDelete,
  });

  String _fmtDate(DateTime? dt) {
    if (dt == null) return '—';
    return '${dt.day}/${dt.month}/${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(report.id as String),
      // Swipe right → share (teal)
      background: _SwipeBg(
        color: AppColorsDark.teal,
        icon: Icons.share_rounded,
        alignment: Alignment.centerLeft,
      ),
      // Swipe left → delete (error)
      secondaryBackground: _SwipeBg(
        color: AppColorsDark.error,
        icon: Icons.delete_outline_rounded,
        alignment: Alignment.centerRight,
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onShare();
          return false; // don't remove on share
        }
        // Delete: confirm
        return await showDialog<bool>(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Delete report?'),
                content: const Text(
                    'This will remove the report from your device.'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Delete',
                          style:
                              TextStyle(color: AppColorsDark.error))),
                ],
              ),
            ) ??
            false;
      },
      onDismissed: (_) => onDelete(),
      child: GlassCard(
        borderRadius: AppRadius.md,
        padding: const EdgeInsets.all(AppSpacing.cardH),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColorsDark.secondary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: const Icon(Icons.description_rounded,
                  size: 20, color: AppColorsDark.secondary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report.fileName as String,
                    style: AppTypography.labelMd(color: text0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _fmtDate(report.reportDate as DateTime?),
                    style: AppTypography.caption(color: text2),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Metrics count pill
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColorsDark.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
              child: Text('View',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColorsDark.secondary)),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwipeBg extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Alignment alignment;
  const _SwipeBg(
      {required this.color,
      required this.icon,
      required this.alignment});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border:
              Border.all(color: color.withValues(alpha: 0.3)),
        ),
        alignment: alignment,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Icon(icon, color: color, size: 22),
      );
}

// ── Import from ABHA card ──────────────────────────────────────────────────────

class _ABHAImportCard extends StatelessWidget {
  final bool isDark;
  final Color text0, text2;
  const _ABHAImportCard(
      {required this.isDark, required this.text0, required this.text2});

  @override
  Widget build(BuildContext context) => GlassCard(
        borderRadius: AppRadius.md,
        padding: const EdgeInsets.all(AppSpacing.cardH),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColorsDark.success.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.account_balance_rounded,
                  size: 20, color: AppColorsDark.success),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Import from ABHA',
                      style: AppTypography.labelMd(color: text0)),
                  Text('Fetch linked health records',
                      style: AppTypography.bodySm(color: text2)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_rounded,
                color: AppColorsDark.success, size: 18),
          ],
        ),
      );
}

// ── Privacy footnote card ──────────────────────────────────────────────────────

class _PrivacyCard extends StatelessWidget {
  final bool isDark;
  final Color text2, divider;
  const _PrivacyCard(
      {required this.isDark,
      required this.text2,
      required this.divider});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppSpacing.cardH),
        decoration: BoxDecoration(
          color: isDark
              ? AppColorsDark.surface0
              : AppColorsLight.surface0,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const EncryptionBadge(),
            const SizedBox(height: 10),
            Text(
              'Your lab reports are stored encrypted on your device and never shared without your explicit consent. Files uploaded to cloud storage use AES-256 server-side encryption.',
              style: AppTypography.bodySm(color: text2),
            ),
          ],
        ),
      );
}
