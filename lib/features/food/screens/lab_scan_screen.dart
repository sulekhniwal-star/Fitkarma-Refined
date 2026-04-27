import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/shimmer_loader.dart';
import '../../../shared/widgets/status_widgets.dart';

// ── Calm Zone — zero glow, zero blur, no ambient blobs ────────────────────────

enum _ScanState { idle, processing, done }

// Mock extracted values
const _mockValues = [
  {'label': 'Glucose (Fasting)', 'value': '98 mg/dL', 'classification': 'Normal'},
  {'label': 'HbA1c', 'value': '5.4%', 'classification': 'Normal'},
  {'label': 'Total Cholesterol', 'value': '218 mg/dL', 'classification': 'Borderline'},
  {'label': 'LDL', 'value': '142 mg/dL', 'classification': 'Borderline'},
  {'label': 'HDL', 'value': '38 mg/dL', 'classification': 'Low'},
  {'label': 'Triglycerides', 'value': '185 mg/dL', 'classification': 'Borderline'},
  {'label': 'Haemoglobin', 'value': '11.2 g/dL', 'classification': 'Low'},
  {'label': 'Vitamin D', 'value': '18 ng/mL', 'classification': 'Low'},
  {'label': 'Vitamin B12', 'value': '310 pg/mL', 'classification': 'Normal'},
  {'label': 'TSH', 'value': '2.8 mIU/L', 'classification': 'Normal'},
];

class LabScanScreen extends ConsumerStatefulWidget {
  const LabScanScreen({super.key});

  @override
  ConsumerState<LabScanScreen> createState() => _LabScanScreenState();
}

class _LabScanScreenState extends ConsumerState<LabScanScreen> {
  _ScanState _state = _ScanState.idle;

  void _startScan() async {
    setState(() => _state = _ScanState.processing);
    // Simulate OCR processing delay
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _state = _ScanState.done);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final primary = isDark ? AppColorsDark.primary : AppColorsLight.primary;
    // Calm Zone: use surface0 solid, no glow, no blur
    final bg1 = isDark ? AppColorsDark.bg1 : AppColorsLight.bg1;

    return Scaffold(
      backgroundColor: bg1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: text2),
          onPressed: () => context.pop(),
        ),
        title: Text('Lab / Rx Scan', style: AppTypography.h1(color: text0)),
        actions: const [EncryptionBadge()],
      ),
      body: SafeArea(
        child: switch (_state) {
          _ScanState.idle => _IdleBody(
              isDark: isDark,
              text0: text0,
              text2: text2,
              primary: primary,
              onScan: _startScan,
            ),
          _ScanState.processing => _ProcessingBody(isDark: isDark, text2: text2),
          _ScanState.done => _ResultsBody(
              isDark: isDark,
              text0: text0,
              text2: text2,
              primary: primary,
              onImport: () => context.pop(),
              onDiscard: () => setState(() => _state = _ScanState.idle),
            ),
        },
      ),
    );
  }
}

// ── Idle: two half-cards ───────────────────────────────────────────────────────

class _IdleBody extends StatelessWidget {
  final bool isDark;
  final Color text0, text2, primary;
  final VoidCallback onScan;

  const _IdleBody({
    required this.isDark,
    required this.text0,
    required this.text2,
    required this.primary,
    required this.onScan,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.screenH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Import your lab report to track health values automatically.',
            style: AppTypography.bodyMd(color: text2),
          ),
          const SizedBox(height: 24),

          // Two half-cards
          Row(
            children: [
              Expanded(
                child: _ScanOptionCard(
                  icon: Icons.camera_alt_rounded,
                  label: 'Take Photo',
                  sublabel: 'JPG / PNG',
                  color: primary,
                  isDark: isDark,
                  onTap: onScan,
                ),
              ),
              const SizedBox(width: AppSpacing.bentoGap),
              Expanded(
                child: _ScanOptionCard(
                  icon: Icons.picture_as_pdf_rounded,
                  label: 'Upload PDF',
                  sublabel: 'PDF up to 20 MB',
                  color: AppColorsDark.teal,
                  isDark: isDark,
                  onTap: onScan,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Privacy note
          _PrivacyNote(isDark: isDark, text2: text2),
        ],
      ),
    );
  }
}

class _ScanOptionCard extends StatelessWidget {
  final IconData icon;
  final String label, sublabel;
  final Color color;
  final bool isDark;
  final VoidCallback onTap;

  const _ScanOptionCard({
    required this.icon,
    required this.label,
    required this.sublabel,
    required this.color,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Calm Zone: solid surface, no blur
    final surface0 = isDark ? AppColorsDark.surface0 : AppColorsLight.surface0;
    final divider = isDark ? AppColorsDark.divider : AppColorsLight.divider;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: surface0,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: divider),
        ),
        child: Column(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(label,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: text0)),
            const SizedBox(height: 4),
            Text(sublabel,
                style: TextStyle(fontSize: 11, color: text2)),
          ],
        ),
      ),
    );
  }
}

// ── Processing: ShimmerLoader ──────────────────────────────────────────────────

class _ProcessingBody extends StatelessWidget {
  final bool isDark;
  final Color text2;

  const _ProcessingBody({required this.isDark, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.screenH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Extracting health values...',
              style: AppTypography.h3(
                  color: isDark
                      ? AppColorsDark.textPrimary
                      : AppColorsLight.textPrimary)),
          const SizedBox(height: 6),
          Text('This usually takes a few seconds',
              style: AppTypography.bodySm(color: text2)),
          const SizedBox(height: 24),
          // Shimmer rows simulating extracted values
          ...List.generate(
            6,
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  ShimmerLoader(width: 160, height: 16, borderRadius: 6),
                  const Spacer(),
                  ShimmerLoader(width: 80, height: 16, borderRadius: 6),
                  const SizedBox(width: 12),
                  ShimmerLoader(width: 64, height: 24, borderRadius: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Results: LabValueRow list ──────────────────────────────────────────────────

class _ResultsBody extends StatefulWidget {
  final bool isDark;
  final Color text0, text2, primary;
  final VoidCallback onImport, onDiscard;

  const _ResultsBody({
    required this.isDark,
    required this.text0,
    required this.text2,
    required this.primary,
    required this.onImport,
    required this.onDiscard,
  });

  @override
  State<_ResultsBody> createState() => _ResultsBodyState();
}

class _ResultsBodyState extends State<_ResultsBody> {
  // Track confirmed values (user can uncheck)
  final Set<int> _confirmed = {
    for (var i = 0; i < _mockValues.length; i++) i
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenH, 8, AppSpacing.screenH, 0),
            children: [
              Text(
                '${_mockValues.length} values extracted',
                style: AppTypography.h4(color: widget.text0),
              ),
              const SizedBox(height: 4),
              Text(
                'Review and confirm before importing',
                style: AppTypography.bodySm(color: widget.text2),
              ),
              const SizedBox(height: 16),
              ..._mockValues.asMap().entries.map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: LabValueRow(
                      label: e.value['label']!,
                      value: e.value['value']!,
                      classification: e.value['classification']!,
                      confirmed: _confirmed.contains(e.key),
                      onToggle: () => setState(() =>
                          _confirmed.contains(e.key)
                              ? _confirmed.remove(e.key)
                              : _confirmed.add(e.key)),
                      isDark: widget.isDark,
                      text0: widget.text0,
                      text2: widget.text2,
                    ),
                  )),
              const SizedBox(height: 16),
              _PrivacyNote(isDark: widget.isDark, text2: widget.text2),
              const SizedBox(height: 80),
            ],
          ),
        ),

        // ── Action buttons ──────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenH, 8, AppSpacing.screenH, 20),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _confirmed.isEmpty ? null : widget.onImport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.primary,
                    disabledBackgroundColor:
                        widget.primary.withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                  child: Text(
                    'Import ${_confirmed.length} value${_confirmed.length != 1 ? 's' : ''} to Health Data',
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: widget.onDiscard,
                style: TextButton.styleFrom(
                  foregroundColor: AppColorsDark.error,
                ),
                child: const Text('Discard',
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── LabValueRow ────────────────────────────────────────────────────────────────

class LabValueRow extends StatelessWidget {
  final String label, value, classification;
  final bool confirmed;
  final VoidCallback onToggle;
  final bool isDark;
  final Color text0, text2;

  const LabValueRow({
    super.key,
    required this.label,
    required this.value,
    required this.classification,
    required this.confirmed,
    required this.onToggle,
    required this.isDark,
    required this.text0,
    required this.text2,
  });

  Color get _classColor => switch (classification) {
        'Normal' => AppColorsDark.success,
        'Borderline' => AppColorsDark.accent,
        _ => AppColorsDark.error, // High / Low
      };

  // Calm Zone card — no blur, no glow
  BoxDecoration _calmCard() => BoxDecoration(
        color: isDark ? AppColorsDark.surface0 : AppColorsLight.surface0,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
            color: isDark ? AppColorsDark.divider : AppColorsLight.divider),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: _calmCard(),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: text0)),
                const SizedBox(height: 2),
                Text(value,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: _classColor)),
              ],
            ),
          ),
          // Classification pill
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _classColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Text(
              classification,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: _classColor),
            ),
          ),
          const SizedBox(width: 10),
          // Confirm checkbox
          GestureDetector(
            onTap: onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: confirmed
                    ? AppColorsDark.success.withValues(alpha: 0.15)
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: confirmed
                      ? AppColorsDark.success
                      : (isDark
                          ? AppColorsDark.divider
                          : AppColorsLight.divider),
                  width: 2,
                ),
              ),
              child: confirmed
                  ? const Icon(Icons.check,
                      size: 14, color: AppColorsDark.success)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Privacy note ───────────────────────────────────────────────────────────────

class _PrivacyNote extends StatelessWidget {
  final bool isDark;
  final Color text2;

  const _PrivacyNote({required this.isDark, required this.text2});

  @override
  Widget build(BuildContext context) {
    final surface0 =
        isDark ? AppColorsDark.surface0 : AppColorsLight.surface0;
    final divider =
        isDark ? AppColorsDark.divider : AppColorsLight.divider;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: surface0,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EncryptionBadge(),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Your lab data is encrypted with AES-256 and stored only on your device. It is never shared without your explicit consent.',
              style: TextStyle(fontSize: 11, color: text2, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
