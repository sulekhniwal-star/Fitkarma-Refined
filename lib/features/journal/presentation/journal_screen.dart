import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' show Value;
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class JournalEntryScreen extends ConsumerStatefulWidget {
  final String odUserId;
  final int? entryId;

  const JournalEntryScreen({super.key, required this.odUserId, this.entryId});

  @override
  ConsumerState<JournalEntryScreen> createState() => _JournalEntryScreenState();
}

class _JournalEntryScreenState extends ConsumerState<JournalEntryScreen> {
  final _contentController = TextEditingController();
  String _currentPrompt = '';
  String _selectedMood = '';
  bool _syncEnabled = false;
  bool _isLoading = false;

  static const _moods = ['😊 Happy', '😌 Calm', '😔 Sad', '😰 Anxious', '😤 Frustrated', '🤔 Thoughtful', '😴 Tired', '😃 Excited'];

  @override
  void initState() {
    super.initState();
    _loadPrompt();
  }

  Future<void> _loadPrompt() async {
    final db = ref.read(appDatabaseProvider);
    setState(() {
      _currentPrompt = db.journalEntriesDao.getWeeklyPrompt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.entryId == null ? 'New Entry' : 'Edit Entry'),
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
        actions: [
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
            )
          else
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _saveEntry,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_currentPrompt.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _currentPrompt,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
            const Text('How are you feeling?', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _moods.map((mood) {
                final isSelected = _selectedMood == mood;
                return FilterChip(
                  label: Text(mood),
                  selected: isSelected,
                  onSelected: (v) => setState(() => _selectedMood = v ? mood : ''),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _contentController,
              maxLines: 12,
              decoration: const InputDecoration(
                hintText: 'Start writing your thoughts...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Sync to cloud'),
              subtitle: const Text('Enable to backup to FitKarma cloud (opt-in)'),
              value: _syncEnabled,
              onChanged: (v) => setState(() => _syncEnabled = v),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _saveEntry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(widget.entryId == null ? 'Save Entry' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveEntry() async {
    if (_contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write something')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final db = ref.read(appDatabaseProvider);
      
      await db.journalEntriesDao.insertEntryEncrypted(
        userId: widget.odUserId,
        content: _contentController.text,
        plainText: _contentController.text,
        promptUsed: _currentPrompt.isEmpty ? null : _currentMood,
        moodTag: _selectedMood.isEmpty ? null : _selectedMood,
        syncEnabled: _syncEnabled,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Journal entry saved!'), backgroundColor: Colors.green),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }
}

class JournalHistoryScreen extends ConsumerWidget {
  final String odUserId;

  const JournalHistoryScreen({super.key, required this.odUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/journal/new', extra: odUserId),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: db.journalEntriesDao.watchEntriesForUser(odUserId),
        builder: (context, snapshot) {
          final entries = snapshot.data ?? [];
          if (entries.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  const Text('No journal entries yet'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => context.push('/journal/new', extra: odUserId),
                    child: const Text('Write First Entry'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () => context.push('/journal/edit/${entry.id}', extra: odUserId),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              _formatDate(entry.createdAt),
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const Spacer(),
                            if (entry.moodTag != null)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(entry.moodTag!),
                              ),
                          ],
                        ),
                        if (entry.promptUsed != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            entry.promptUsed!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                        const SizedBox(height: 8),
                        Text(
                          entry.plainText ?? entry.content,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(DateTime d) {
    final now = DateTime.now();
    if (d.year == now.year && d.month == now.month && d.day == now.day) {
      return 'Today ${d.hour}:${d.minute.toString().padLeft(2, '0')}';
    }
    return '${d.day}/${d.month}/${d.year}';
  }
}