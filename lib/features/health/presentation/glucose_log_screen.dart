import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' hide Column;

import '../../../core/storage/app_database.dart';

class GlucoseLogScreen extends ConsumerStatefulWidget {
  const GlucoseLogScreen({super.key});

  @override
  ConsumerState<GlucoseLogScreen> createState() => _GlucoseLogScreenState();
}

class _GlucoseLogScreenState extends ConsumerState<GlucoseLogScreen> {
  final _valueController = TextEditingController();
  String _testType = 'fasting';
  bool _isLoading = false;

  String classifyFasting(double value) {
    if (value < 70) return 'low';
    if (value <= 100) return 'normal';
    if (value <= 125) return 'prediabetes';
    return 'diabetes';
  }

  String classifyPostMeal(double value) {
    if (value < 70) return 'low';
    if (value <= 140) return 'normal';
    if (value <= 199) return 'prediabetes';
    return 'diabetes';
  }

  Color getClassificationColor(String classification) {
    switch (classification) {
      case 'low':
        return Colors.blue;
      case 'normal':
        return Colors.green;
      case 'prediabetes':
        return Colors.orange;
      case 'diabetes':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  double? estimateHbA1c(List<double> recentValues) {
    if (recentValues.isEmpty) return null;
    final avg = recentValues.reduce((a, b) => a + b) / recentValues.length;
    return (avg + 46.7) / 28.7;
  }

  Future<void> _saveGlucoseLog() async {
    final value = double.tryParse(_valueController.text);

    if (value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid value')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final db = DriftService.db;
      final id = const Uuid().v4();
      final classification = _testType == 'after_meal'
          ? classifyPostMeal(value)
          : classifyFasting(value);

      await db.into(db.glucoseLogs).insert(
        GlucoseLogsCompanion.insert(
          id: id,
          userId: 'current_user',
          valueMgDl: value,
          testType: _testType,
          loggedAt: DateTime.now(),
        ),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Glucose logged! +5 XP')),
        );
        _valueController.clear();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Glucose'),
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
                      'Log Glucose',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(value: 'fasting', label: Text('Fasting')),
                        ButtonSegment(value: 'after_meal', label: Text('Post-Meal')),
                        ButtonSegment(value: 'random', label: Text('Random')),
                        ButtonSegment(value: 'bedtime', label: Text('Bedtime')),
                      ],
                      selected: {_testType},
                      onSelectionChanged: (selected) {
                        setState(() => _testType = selected.first);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _valueController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Glucose Level',
                        hintText: '100',
                        suffixText: 'mg/dL',
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _isLoading ? null : _saveGlucoseLog,
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
    return FutureBuilder<List<GlucoseLog>>(
      future: () async {
        final db = DriftService.db;
        return (db.select(db.glucoseLogs)
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
                    Icon(Icons.water_drop,
                        size: 48,
                        color: Theme.of(context).colorScheme.primary),
                    const SizedBox(height: 8),
                    const Text('No glucose logs yet'),
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
            final classification = log.testType == 'after_meal'
                ? classifyPostMeal(log.valueMgDl)
                : classifyFasting(log.valueMgDl);
            final color = getClassificationColor(classification);

            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.1),
                  child: Icon(Icons.water_drop, color: color),
                ),
                title: Text('${log.valueMgDl.toInt()} mg/dL'),
                subtitle: Text(
                  '${log.testType} · ${log.loggedAt.day}/${log.loggedAt.month}',
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    classification.toUpperCase(),
                    style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
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
    _valueController.dispose();
    super.dispose();
  }
}

class DriftService {
  static AppDatabase get db => throw UnimplementedError();
}