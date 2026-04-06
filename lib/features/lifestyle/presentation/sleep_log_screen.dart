import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/storage/app_database.dart';

class SleepLogScreen extends ConsumerStatefulWidget {
  const SleepLogScreen({super.key});

  @override
  ConsumerState<SleepLogScreen> createState() => _SleepLogScreenState();
}

class _SleepLogScreenState extends ConsumerState<SleepLogScreen> {
  DateTime _date = DateTime.now();
  String _bedtime = '22:00';
  String _wakeTime = '06:00';
  int _quality = 3;
  bool _isLoading = false;

  double calculateDuration() {
    try {
      final bedParts = _bedtime.split(':');
      final wakeParts = _wakeTime.split(':');
      
      var bedHour = int.parse(bedParts[0]);
      var wakeHour = int.parse(wakeParts[0]);
      
      if (bedHour > 12) bedHour -= 24;
      if (wakeHour < bedHour) wakeHour += 24;
      
      var bedMin = int.parse(bedParts[1]);
      var wakeMin = int.parse(wakeParts[1]);
      
      final duration = (wakeHour * 60 + wakeMin) - (bedHour * 60 + bedMin);
      return duration / 60.0;
    } catch (e) {
      return 0;
    }
  }

  String getQualityLabel(int quality) {
    switch (quality) {
      case 1: return 'Very Poor';
      case 2: return 'Poor';
      case 3: return 'Fair';
      case 4: return 'Good';
      case 5: return 'Excellent';
      default: return 'Fair';
    }
  }

  Future<void> _saveSleepLog() async {
    setState(() => _isLoading = true);

    try {
      final db = DriftService.db;
      final id = const Uuid().v4();
      final hours = calculateDuration();
      final durationMin = (hours * 60).toInt();

      await db.into(db.sleepLogs).insert(
        SleepLogsCompanion.insert(
          id: id,
          userId: 'current_user',
          date: _date,
          bedtime: _bedtime,
          wakeTime: _wakeTime,
          durationMin: durationMin,
          qualityScore: _quality,
          source: 'manual',
        ),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sleep logged: ${hours.toStringAsFixed(1)} hours! +5 XP')),
        );
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
    final duration = calculateDuration();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep Tracker'),
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
                      'Log Sleep',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: const Text('Date'),
                      subtitle: Text('${_date.day}/${_date.month}/${_date.year}'),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _date,
                          firstDate: DateTime.now().subtract(const Duration(days: 7)),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          setState(() => _date = date);
                        }
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.bedtime),
                      title: const Text('Bedtime'),
                      subtitle: Text(_bedtime),
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 22, minute: 0),
                        );
                        if (time != null) {
                          setState(() => _bedtime = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}');
                        }
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.wb_sunny),
                      title: const Text('Wake Time'),
                      subtitle: Text(_wakeTime),
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 6, minute: 0),
                        );
                        if (time != null) {
                          setState(() => _wakeTime = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}');
                        }
                      },
                    ),
                    const Divider(),
                    Text('Sleep Quality', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(5, (index) {
                        final rating = index + 1;
                        return GestureDetector(
                          onTap: () => setState(() => _quality = rating),
                          child: Column(
                            children: [
                              Icon(
                                Icons.emoji_emotions,
                                color: _quality >= rating
                                    ? Colors.amber
                                    : Colors.grey,
                                size: 32,
                              ),
                              Text(
                                getQualityLabel(rating),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _quality >= rating
                                      ? Colors.amber
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.access_time),
                          const SizedBox(width: 8),
                          Text(
                            '${duration.toStringAsFixed(1)} hours',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _isLoading ? null : _saveSleepLog,
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
          ],
        ),
      ),
    );
  }
}

class DriftService {
  static AppDatabase get db => throw UnimplementedError();
}