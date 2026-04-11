import 'package:drift/drift.dart' show OrderingTerm, OrderingMode, Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/health_repository.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';
import '../../auth/data/auth_repository.dart';

// ── BP Classification ─────────────────────────────────────────────────────────
enum BpClass { normal, elevated, stage1, stage2, crisis }

extension BpClassExtension on BpClass {
  String get label {
    switch (this) {
      case BpClass.normal:   return 'Normal';
      case BpClass.elevated: return 'Elevated';
      case BpClass.stage1:   return 'Stage 1 HTN';
      case BpClass.stage2:   return 'Stage 2 HTN';
      case BpClass.crisis:   return '⚠️ HYPERTENSIVE CRISIS';
    }
  }

  Color get color {
    switch (this) {
      case BpClass.normal:   return const Color(0xFF2ECC71);
      case BpClass.elevated: return const Color(0xFFF39C12);
      case BpClass.stage1:   return const Color(0xFFE67E22);
      case BpClass.stage2:   return const Color(0xFFE74C3C);
      case BpClass.crisis:   return const Color(0xFFAD1457);
    }
  }
}

BpClass classifyBp(int systolic, int diastolic) {
  if (systolic >= 180 || diastolic >= 120) return BpClass.crisis;
  if (systolic >= 140 || diastolic >= 90)  return BpClass.stage2;
  if (systolic >= 130 || diastolic >= 80)  return BpClass.stage1;
  if (systolic >= 120 && diastolic < 80)   return BpClass.elevated;
  return BpClass.normal;
}

// ── Provider for recent BP logs ───────────────────────────────────────────────
final bpLogsProvider = StreamProvider.family<List<BloodPressureLog>, String>((ref, userId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.bloodPressureLogs)
    ..where((t) => t.userId.equals(userId))
    ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)])
    ..limit(30))
      .watch();
});

// ── Screen ────────────────────────────────────────────────────────────────────
class BpLogScreen extends ConsumerStatefulWidget {
  const BpLogScreen({super.key});

  @override
  ConsumerState<BpLogScreen> createState() => _BpLogScreenState();
}

class _BpLogScreenState extends ConsumerState<BpLogScreen> {
  final _systolicCtrl   = TextEditingController();
  final _diastolicCtrl  = TextEditingController();
  final _pulseCtrl      = TextEditingController();
  BpClass? _preview;
  bool _saving = false;

  @override
  void dispose() {
    _systolicCtrl.dispose();
    _diastolicCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  void _updatePreview() {
    final s = int.tryParse(_systolicCtrl.text);
    final d = int.tryParse(_diastolicCtrl.text);
    if (s != null && d != null) {
      setState(() => _preview = classifyBp(s, d));
    }
  }

  Future<void> _save() async {
    final s = int.tryParse(_systolicCtrl.text);
    final d = int.tryParse(_diastolicCtrl.text);
    if (s == null || d == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter valid systolic and diastolic values')),
      );
      return;
    }

    setState(() => _saving = true);
    final classification = classifyBp(s, d);
    await ref.read(healthRepositoryProvider).saveBloodPressureLog(
      systolic: s,
      diastolic: d,
      pulse: int.tryParse(_pulseCtrl.text),
      classification: classification.name,
    );

    // Crisis alert
    if (classification == BpClass.crisis && mounted) {
      _showCrisisAlert(s, d);
    }

    setState(() => _saving = false);
    _systolicCtrl.clear();
    _diastolicCtrl.clear();
    _pulseCtrl.clear();
    setState(() => _preview = null);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('BP logged: $s/$d — ${classification.label}'),
          backgroundColor: classification.color,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showCrisisAlert(int s, int d) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2E),
        title: const Text('⚠️ Hypertensive Crisis', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        content: Text(
          'Your reading ($s/$d mmHg) is critically high.\n\n'
          'Please seek immediate medical care. Call your doctor or go to the nearest emergency room.\n\n'
          'आपका रक्तचाप बहुत अधिक है। तुरंत डॉक्टर से मिलें।',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('I Understand', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).asData?.value;
    final logsAsync = ref.watch(bpLogsProvider(user?.$id ?? ''));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Blood Pressure', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('रक्तचाप', style: TextStyle(fontSize: 11, color: Colors.white60)),
          ],
        ),
        backgroundColor: const Color(0xFFE74C3C),
        foregroundColor: Colors.white,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('🔒 AES-256', style: TextStyle(color: Colors.white, fontSize: 11)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Log Form ───────────────────────────────────────────────
          _BpInputCard(
            systolicCtrl: _systolicCtrl,
            diastolicCtrl: _diastolicCtrl,
            pulseCtrl: _pulseCtrl,
            preview: _preview,
            onChanged: _updatePreview,
            onSave: _save,
            saving: _saving,
          ),

          const SizedBox(height: 24),

          // ── AHA Reference Bands ───────────────────────────────────
          _AhaBandsCard(),

          const SizedBox(height: 24),

          // ── History List ──────────────────────────────────────────
          const Text(
            'Recent Readings · हालिया रीडिंग',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          logsAsync.when(
            data: (logs) => logs.isEmpty
                ? const _EmptyBpState()
                : Column(
                    children: logs.take(10).map((l) => _BpHistoryTile(log: l)).toList(),
                  ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('Error: $e'),
          ),
        ],
      ),
    );
  }
}

// ── Input Card ────────────────────────────────────────────────────────────────
class _BpInputCard extends StatelessWidget {
  const _BpInputCard({
    required this.systolicCtrl,
    required this.diastolicCtrl,
    required this.pulseCtrl,
    required this.preview,
    required this.onChanged,
    required this.onSave,
    required this.saving,
  });

  final TextEditingController systolicCtrl;
  final TextEditingController diastolicCtrl;
  final TextEditingController pulseCtrl;
  final BpClass? preview;
  final VoidCallback onChanged;
  final VoidCallback onSave;
  final bool saving;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1E1E2E)
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Log Reading · रीडिंग दर्ज करें',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _NumField(ctrl: systolicCtrl, label: 'Systolic', unit: 'mmHg',
                    onChanged: (_) => onChanged()),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('/', style: TextStyle(fontSize: 32, color: Colors.grey)),
              ),
              Expanded(
                child: _NumField(ctrl: diastolicCtrl, label: 'Diastolic', unit: 'mmHg',
                    onChanged: (_) => onChanged()),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _NumField(ctrl: pulseCtrl, label: 'Pulse (optional)', unit: 'bpm', onChanged: (_) {}),

          if (preview != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: preview!.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: preview!.color.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 10, height: 10,
                    decoration: BoxDecoration(color: preview!.color, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 10),
                  Text(preview!.label,
                      style: TextStyle(color: preview!.color, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],

          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: saving ? null : onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE74C3C),
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: saving
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('LOG READING · रीडिंग सेव करें',
                      style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class _NumField extends StatelessWidget {
  const _NumField({
    required this.ctrl,
    required this.label,
    required this.unit,
    required this.onChanged,
  });

  final TextEditingController ctrl;
  final String label;
  final String unit;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctrl,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: label,
        suffixText: unit,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}

// ── AHA Reference ─────────────────────────────────────────────────────────────
class _AhaBandsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const bands = [
      (BpClass.normal,   '< 120', '< 80'),
      (BpClass.elevated, '120-129', '< 80'),
      (BpClass.stage1,   '130-139', '80-89'),
      (BpClass.stage2,   '140-179', '90-119'),
      (BpClass.crisis,   '≥ 180',   '≥ 120'),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1E1E2E)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('AHA Classification', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 12),
          ...bands.map((b) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 8, height: 8,
                      decoration: BoxDecoration(color: b.$1.color, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text(b.$1.label, style: const TextStyle(fontSize: 13))),
                    Text('${b.$2} / ${b.$3}',
                        style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ── History Tile ──────────────────────────────────────────────────────────────
class _BpHistoryTile extends StatelessWidget {
  const _BpHistoryTile({required this.log});
  final BloodPressureLog log;

  @override
  Widget build(BuildContext context) {
    final classification = BpClass.values.firstWhere(
      (c) => c.name == log.classification,
      orElse: () => BpClass.normal,
    );
    final time = '${log.loggedAt.hour.toString().padLeft(2, '0')}:${log.loggedAt.minute.toString().padLeft(2, '0')}';
    final date = '${log.loggedAt.day}/${log.loggedAt.month}';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1E1E2E)
            : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: classification.color, width: 4)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${log.systolic}/${log.diastolic}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Text('mmHg${log.pulse != null ? " · ${log.pulse} bpm" : ""}',
                    style: TextStyle(color: Colors.grey[500], fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: classification.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  classification.label,
                  style: TextStyle(
                    color: classification.color,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text('$date  $time', style: TextStyle(color: Colors.grey[400], fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyBpState extends StatelessWidget {
  const _EmptyBpState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Text('🩺', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 12),
            const Text('No readings yet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('Log your first blood pressure reading above',
                style: TextStyle(color: Colors.grey[500], fontSize: 13),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}