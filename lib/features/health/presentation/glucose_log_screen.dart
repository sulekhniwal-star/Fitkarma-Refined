import 'package:drift/drift.dart' show OrderingTerm, OrderingMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';
import '../../auth/data/auth_repository.dart';
import '../../karma/data/karma_service.dart';

// ── Glucose Classification ────────────────────────────────────────────────────
enum GlucoseTestType { fasting, postMeal, random, bedtime }

extension GlucoseTestTypeExt on GlucoseTestType {
  String get label {
    switch (this) {
      case GlucoseTestType.fasting:  return 'Fasting';
      case GlucoseTestType.postMeal: return 'Post-meal (2h)';
      case GlucoseTestType.random:   return 'Random';
      case GlucoseTestType.bedtime:  return 'Bedtime';
    }
  }
  String get labelHi {
    switch (this) {
      case GlucoseTestType.fasting:  return 'खाली पेट';
      case GlucoseTestType.postMeal: return 'खाने के 2 घंटे बाद';
      case GlucoseTestType.random:   return 'कभी भी';
      case GlucoseTestType.bedtime:  return 'सोने से पहले';
    }
  }
}

enum GlucoseClass { normal, prediabetes, diabetes, hypoglycemia }

extension GlucoseClassExt on GlucoseClass {
  String get label {
    switch (this) {
      case GlucoseClass.normal:       return 'Normal';
      case GlucoseClass.prediabetes:  return 'Pre-diabetes';
      case GlucoseClass.diabetes:     return 'High — Consult Doctor';
      case GlucoseClass.hypoglycemia: return '⚠️ Low — Act Now';
    }
  }

  Color get color {
    switch (this) {
      case GlucoseClass.normal:       return const Color(0xFF2ECC71);
      case GlucoseClass.prediabetes:  return const Color(0xFFF39C12);
      case GlucoseClass.diabetes:     return const Color(0xFFE74C3C);
      case GlucoseClass.hypoglycemia: return const Color(0xFFAD1457);
    }
  }
}

GlucoseClass classifyFasting(double mgDl) {
  if (mgDl < 54)  return GlucoseClass.hypoglycemia;
  if (mgDl < 100) return GlucoseClass.normal;
  if (mgDl < 126) return GlucoseClass.prediabetes;
  return GlucoseClass.diabetes;
}

GlucoseClass classifyPostMeal2h(double mgDl) {
  if (mgDl < 54)  return GlucoseClass.hypoglycemia;
  if (mgDl < 140) return GlucoseClass.normal;
  if (mgDl < 200) return GlucoseClass.prediabetes;
  return GlucoseClass.diabetes;
}

GlucoseClass classifyRandom(double mgDl) {
  if (mgDl < 54)  return GlucoseClass.hypoglycemia;
  if (mgDl < 140) return GlucoseClass.normal;
  if (mgDl < 200) return GlucoseClass.prediabetes;
  return GlucoseClass.diabetes;
}

// ── Provider ──────────────────────────────────────────────────────────────────
final glucoseLogsProvider = StreamProvider.family<List<GlucoseLog>, String>((ref, userId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.glucoseLogs)
    ..where((t) => t.userId.equals(userId))
    ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)])
    ..limit(30))
      .watch();
});

// ── Screen ────────────────────────────────────────────────────────────────────
class GlucoseLogScreen extends ConsumerStatefulWidget {
  const GlucoseLogScreen({super.key});

  @override
  ConsumerState<GlucoseLogScreen> createState() => _GlucoseLogScreenState();
}

class _GlucoseLogScreenState extends ConsumerState<GlucoseLogScreen> {
  final _valueCtrl = TextEditingController();
  GlucoseTestType _testType = GlucoseTestType.fasting;
  GlucoseClass? _preview;
  bool _saving = false;

  @override
  void dispose() {
    _valueCtrl.dispose();
    super.dispose();
  }

  void _updatePreview() {
    final v = double.tryParse(_valueCtrl.text);
    if (v == null) { setState(() => _preview = null); return; }
    setState(() {
      switch (_testType) {
        case GlucoseTestType.fasting:  _preview = classifyFasting(v);
        case GlucoseTestType.postMeal: _preview = classifyPostMeal2h(v);
        default:                       _preview = classifyRandom(v);
      }
    });
  }

  Future<void> _save() async {
    final v = double.tryParse(_valueCtrl.text);
    if (v == null) return;

    setState(() => _saving = true);
    final user = ref.read(currentUserProvider).asData?.value;
    final db = ref.read(databaseProvider);

    await db.into(db.glucoseLogs).insert(
      GlucoseLogsCompanion.insert(
        id: const Uuid().v4(),
        userId: user?.$id ?? 'local',
        valueMgDl: v,
        testType: _testType.name,
        loggedAt: DateTime.now(),
      ),
    );

    await ref.read(karmaServiceProvider.notifier).grantXP(KarmaAction.glucoseLog);
    setState(() { _saving = false; _preview = null; });
    _valueCtrl.clear();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Glucose logged: ${v.round()} mg/dL — ${_preview?.label ?? ''}'),
          backgroundColor: _preview?.color ?? AppColors.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).asData?.value;
    final logsAsync = ref.watch(glucoseLogsProvider(user?.$id ?? ''));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Blood Glucose', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('रक्त ग्लूकोज', style: TextStyle(fontSize: 11, color: Colors.white60)),
          ],
        ),
        backgroundColor: const Color(0xFF3498DB),
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
          // ── Test Type Selector ────────────────────────────────────
          _TestTypeSelector(
            selected: _testType,
            onChanged: (t) { setState(() => _testType = t); _updatePreview(); },
          ),
          const SizedBox(height: 16),

          // ── Input Card ────────────────────────────────────────────
          _GlucoseInputCard(
            ctrl: _valueCtrl,
            preview: _preview,
            onChanged: (_) => _updatePreview(),
            onSave: _save,
            saving: _saving,
          ),

          const SizedBox(height: 24),

          // ── Reference Ranges ──────────────────────────────────────
          _GlucoseReferenceCard(testType: _testType),

          const SizedBox(height: 24),

          // ── History ───────────────────────────────────────────────
          const Text('Recent Readings · हालिया रीडिंग',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          logsAsync.when(
            data: (logs) => logs.isEmpty
                ? const _EmptyGlucoseState()
                : Column(children: logs.take(10).map((l) => _GlucoseTile(log: l)).toList()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('Error: $e'),
          ),
        ],
      ),
    );
  }
}

// ── Widgets ───────────────────────────────────────────────────────────────────
class _TestTypeSelector extends StatelessWidget {
  const _TestTypeSelector({required this.selected, required this.onChanged});
  final GlucoseTestType selected;
  final ValueChanged<GlucoseTestType> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: GlucoseTestType.values.length,
        itemBuilder: (context, i) {
          final t = GlucoseTestType.values[i];
          final isSel = t == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(t.label),
              selected: isSel,
              onSelected: (_) => onChanged(t),
              selectedColor: const Color(0xFF3498DB).withOpacity(0.15),
              labelStyle: TextStyle(
                color: isSel ? const Color(0xFF3498DB) : Colors.grey[600],
                fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
              ),
              showCheckmark: false,
            ),
          );
        },
      ),
    );
  }
}

class _GlucoseInputCard extends StatelessWidget {
  const _GlucoseInputCard({
    required this.ctrl,
    required this.preview,
    required this.onChanged,
    required this.onSave,
    required this.saving,
  });

  final TextEditingController ctrl;
  final GlucoseClass? preview;
  final ValueChanged<String> onChanged;
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
        children: [
          TextField(
            controller: ctrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: onChanged,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              labelText: 'Glucose Level',
              suffixText: 'mg/dL',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            ),
          ),

          if (preview != null) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: preview!.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(preview!.label,
                  style: TextStyle(color: preview!.color, fontWeight: FontWeight.bold)),
            ),
          ],

          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: saving ? null : onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3498DB),
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: saving
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('LOG GLUCOSE · ग्लूकोज सेव करें',
                      style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlucoseReferenceCard extends StatelessWidget {
  const _GlucoseReferenceCard({required this.testType});
  final GlucoseTestType testType;

  @override
  Widget build(BuildContext context) {
    final ranges = testType == GlucoseTestType.postMeal
        ? [
            (GlucoseClass.normal,       'Normal', '< 140'),
            (GlucoseClass.prediabetes,  'Pre-diabetes', '140-199'),
            (GlucoseClass.diabetes,     'Diabetes', '≥ 200'),
            (GlucoseClass.hypoglycemia, 'Low', '< 54'),
          ]
        : [
            (GlucoseClass.normal,       'Normal', '70-99'),
            (GlucoseClass.prediabetes,  'Pre-diabetes', '100-125'),
            (GlucoseClass.diabetes,     'Diabetes', '≥ 126'),
            (GlucoseClass.hypoglycemia, 'Low', '< 70'),
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
          const Text('Reference Ranges (mg/dL)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 12),
          ...ranges.map((r) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 8, height: 8,
                      decoration: BoxDecoration(color: r.$1.color, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text(r.$2, style: const TextStyle(fontSize: 13))),
                    Text(r.$3, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _GlucoseTile extends StatelessWidget {
  const _GlucoseTile({required this.log});
  final GlucoseLog log;

  @override
  Widget build(BuildContext context) {
    final classification = log.testType == 'postMeal'
        ? classifyPostMeal2h(log.valueMgDl)
        : classifyFasting(log.valueMgDl);
    final time = '${log.loggedAt.hour.toString().padLeft(2, '0')}:${log.loggedAt.minute.toString().padLeft(2, '0')}';

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
                Text('${log.valueMgDl.round()} mg/dL',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                Text(GlucoseTestType.values.firstWhere((t) => t.name == log.testType, orElse: () => GlucoseTestType.random).label,
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
                  style: TextStyle(color: classification.color, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 4),
              Text('${log.loggedAt.day}/${log.loggedAt.month}  $time',
                  style: TextStyle(color: Colors.grey[400], fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyGlucoseState extends StatelessWidget {
  const _EmptyGlucoseState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Text('🩸', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 12),
            const Text('No readings yet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('Log your first glucose reading above',
                style: TextStyle(color: Colors.grey[500], fontSize: 13)),
          ],
        ),
      ),
    );
  }
}