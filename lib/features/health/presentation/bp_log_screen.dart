import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' hide Column;

import '../../../core/storage/app_database.dart';
import '../../../core/security/encryption_service.dart';
import '../../../core/security/key_manager.dart';
import '../../../shared/widgets/async_value_widget.dart';

class BpLogScreen extends ConsumerStatefulWidget {
  const BpLogScreen({super.key});

  @override
  ConsumerState<BpLogScreen> createState() => _BpLogScreenState();
}

class _BpLogScreenState extends ConsumerState<BpLogScreen> {
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  final _pulseController = TextEditingController();
  bool _isLoading = false;

  String classify(int systolic, int diastolic) {
    if (systolic >= 180 || diastolic >= 120) return 'crisis';
    if (systolic >= 140 || diastolic >= 90) return 'stage2';
    if (systolic >= 130 || diastolic >= 80) return 'stage1';
    if (systolic >= 120 || diastolic >= 80) return 'elevated';
    return 'normal';
  }

  Color getClassificationColor(String classification) {
    switch (classification) {
      case 'crisis':
        return Colors.red;
      case 'stage2':
        return Colors.orange;
      case 'stage1':
        return Colors.amber;
      case 'elevated':
        return Colors.yellow.shade700;
      default:
        return Colors.green;
    }
  }

  Future<void> _saveBpLog() async {
    final systolic = int.tryParse(_systolicController.text);
    final diastolic = int.tryParse(_diastolicController.text);
    final pulse = int.tryParse(_pulseController.text);

    if (systolic == null || diastolic == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid values')),
      );
      return;
    }

    if (systolic >= 180 || diastolic >= 120) {
      _showEmergencyAlert();
    }

    setState(() => _isLoading = true);

    try {
      final db = DriftService.db;
      final id = const Uuid().v4();
      final classification = classify(systolic, diastolic);

      await db.into(db.bloodPressureLogs).insert(
        BloodPressureLogsCompanion.insert(
          id: id,
          userId: 'current_user', // TODO: get from auth
          systolic: systolic,
          diastolic: diastolic,
          pulse: Value(pulse),
          classification: classification,
          loggedAt: DateTime.now(),
        ),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('BP logged successfully! +5 XP')),
        );
        _systolicController.clear();
        _diastolicController.clear();
        _pulseController.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showEmergencyAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('⚠️ Emergency Alert'),
        content: const Text(
          'Your blood pressure is critically high (≥180/120). '
          'Please seek immediate medical attention.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Open emergency contacts
            },
            child: const Text('Call Emergency'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Pressure'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Log Blood Pressure',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _systolicController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Systolic',
                              hintText: '120',
                              suffixText: 'mmHg',
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _diastolicController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Diastolic',
                              hintText: '80',
                              suffixText: 'mmHg',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _pulseController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Pulse (optional)',
                        hintText: '72',
                        suffixText: 'bpm',
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _isLoading ? null : _saveBpLog,
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Recent Readings',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _buildRecentLogs(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentLogs() {
    return FutureBuilder<List<BloodPressureLog>>(
      future: () async {
        final db = DriftService.db;
        return (db.select(db.bloodPressureLogs)
              ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)])
              ..limit(10))
            .get();
      }(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final logs = snapshot.data ?? [];
        if (logs.isEmpty) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.monitor_heart,
                        size: 48,
                        color: Theme.of(context).colorScheme.primary),
                    const SizedBox(height: 8),
                    const Text('No BP logs yet'),
                  ],
                ),
              ),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: logs.length,
          itemBuilder: (context, index) {
            final log = logs[index];
            final color = getClassificationColor(log.classification);
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.1),
                  child: Icon(Icons.monitor_heart, color: color),
                ),
                title: Text('${log.systolic}/${log.diastolic} mmHg'),
                subtitle: Text(
                  '${log.loggedAt.day}/${log.loggedAt.month}/${log.loggedAt.year}',
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    log.classification.toUpperCase(),
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _systolicController.dispose();
    _diastolicController.dispose();
    _pulseController.dispose();
    super.dispose();
  }
}

class DriftService {
  static AppDatabase get db => throw UnimplementedError();
}