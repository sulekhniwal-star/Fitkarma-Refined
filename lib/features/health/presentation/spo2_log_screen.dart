import 'package:drift/drift.dart' show OrderingTerm, OrderingMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/health_repository.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';
import '../../auth/data/auth_repository.dart';

final spo2LogsProvider = StreamProvider.family<List<Spo2Log>, String>((ref, userId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.spo2Logs)
    ..where((t) => t.userId.equals(userId))
    ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)])
    ..limit(30))
      .watch();
});

class Spo2LogScreen extends ConsumerStatefulWidget {
  const Spo2LogScreen({super.key});

  @override
  ConsumerState<Spo2LogScreen> createState() => _Spo2LogScreenState();
}

class _Spo2LogScreenState extends ConsumerState<Spo2LogScreen> {
  final _valueCtrl = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _valueCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final val = int.tryParse(_valueCtrl.text);
    if (val == null || val < 0 || val > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid SpO2 percentage (0-100)')),
      );
      return;
    }

    setState(() => _saving = true);
    await ref.read(healthRepositoryProvider).saveSpo2Log(
      valuePercent: val,
    );

    if (val < 95 && mounted) {
      _showLowSpo2Alert(val);
    }

    setState(() => _saving = false);
    _valueCtrl.clear();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('SpO2 logged: $val%'),
          backgroundColor: val < 95 ? Colors.red : Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showLowSpo2Alert(int val) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2E),
        title: const Text('⚠️ Low SpO2 Alert', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        content: Text(
          'Your SpO2 level ($val%) is below the normal threshold (95%).\n\n'
          'Please consult your doctor if you feel shortness of breath or dizziness.\n\n'
          'आपका ऑक्सीजन स्तर कम है। कृपया डॉक्टर से सलाह लें।',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).asData?.value;
    final logsAsync = ref.watch(spo2LogsProvider(user?.$id ?? ''));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('O2 Saturation (SpO2)', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('ऑक्सीजन स्तर', style: TextStyle(fontSize: 11, color: Colors.white60)),
          ],
        ),
        backgroundColor: Colors.teal[700],
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Spo2InputCard(
            valueCtrl: _valueCtrl,
            onSave: _save,
            saving: _saving,
          ),
          const SizedBox(height: 24),
          const Text(
            'Recent Readings · हालिया रीडिंग',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          logsAsync.when(
            data: (logs) => logs.isEmpty
                ? const _EmptyState()
                : Column(
                    children: logs.map((l) => _Spo2HistoryTile(log: l)).toList(),
                  ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('Error: $e'),
          ),
        ],
      ),
    );
  }
}

class _Spo2InputCard extends StatelessWidget {
  const _Spo2InputCard({
    required this.valueCtrl,
    required this.onSave,
    required this.saving,
  });

  final TextEditingController valueCtrl;
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
          const Text('Log SpO2 · ऑक्सीजन दर्ज करें',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 20),
          TextField(
            controller: valueCtrl,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              labelText: 'SpO2 Percentage',
              suffixText: '%',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: saving ? null : onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[700],
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: saving
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('LOG READING · सेव करें',
                      style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class _Spo2HistoryTile extends StatelessWidget {
  const _Spo2HistoryTile({required this.log});
  final Spo2Log log;

  @override
  Widget build(BuildContext context) {
    final isLow = log.valuePercent < 95;
    final time = '${log.loggedAt.hour.toString().padLeft(2, '0')}:${log.loggedAt.minute.toString().padLeft(2, '0')}';
    final date = '${log.loggedAt.day}/${log.loggedAt.month}';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1E1E2E)
            : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: isLow ? Colors.red : Colors.teal, width: 4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${log.valuePercent}%',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Text(isLow ? 'Low · कम' : 'Normal · सामान्य',
                  style: TextStyle(color: isLow ? Colors.red : Colors.teal, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          Text('$date  $time', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Text('No SpO2 logs yet.', style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
