import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';
import 'package:fitkarma/features/journal/data/journal_providers.dart';
import 'package:fitkarma/features/journal/data/journal_service.dart';

/// Main journal screen showing list of entries and entry creation
class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({super.key});

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  String? _userId;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final userId = await AuthAwService().getStoredUserId();
    if (mounted) {
      setState(() {
        _userId = userId;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final weeklyPrompt = ref.watch(weeklyPromptProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Show sync settings
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _userId == null
          ? const Center(child: Text('Please log in to use journal'))
          : _buildContent(weeklyPrompt),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createNewEntry(context, weeklyPrompt),
        icon: const Icon(Icons.add),
        label: const Text('New Entry'),
      ),
    );
  }

  Widget _buildContent(Map<String, String> weeklyPrompt) {
    final entriesAsync = ref.watch(journalEntriesProvider(_userId!));

    return CustomScrollView(
      slivers: [
        // Weekly prompt card
        SliverToBoxAdapter(child: _WeeklyPromptCard(prompt: weeklyPrompt)),
        // Journal entries list
        entriesAsync.when(
          data: (entries) => entries.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.book_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No journal entries yet',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        const Text('Tap + to create your first entry'),
                      ],
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final entry = entries[index];
                    return _JournalEntryCard(
                      entry: entry,
                      onTap: () => _viewEntry(context, entry),
                      onDelete: () => _deleteEntry(entry.id),
                    );
                  }, childCount: entries.length),
                ),
          loading: () => const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) =>
              SliverFillRemaining(child: Center(child: Text('Error: $e'))),
        ),
      ],
    );
  }

  void _createNewEntry(BuildContext context, Map<String, String> prompt) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => JournalEntryScreen(
          userId: _userId!,
          promptId: prompt['id'],
          promptText: prompt['text'],
        ),
      ),
    );
  }

  void _viewEntry(BuildContext context, JournalEntry entry) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => JournalEntryScreen(userId: _userId!, entry: entry),
      ),
    );
  }

  Future<void> _deleteEntry(String id) async {
    final service = ref.read(journalServiceProvider);
    await service.deleteEntry(id);
    ref.invalidate(journalEntriesProvider(_userId!));
  }
}

/// Weekly prompt card widget
class _WeeklyPromptCard extends StatelessWidget {
  final Map<String, String> prompt;

  const _WeeklyPromptCard({required this.prompt});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.amber[700]),
                const SizedBox(width: 8),
                Text(
                  'This Week\'s Prompt',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              prompt['text'] ?? 'How are you feeling today?',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              prompt['title'] ?? 'Reflection',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

/// Journal entry card widget
class _JournalEntryCard extends StatelessWidget {
  final JournalEntry entry;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _JournalEntryCard({
    required this.entry,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _MoodIndicator(moodTag: entry.moodTag),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      entry.title ?? 'Untitled Entry',
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _confirmDelete(context),
                    iconSize: 20,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _getPreview(entry.content),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
                  const SizedBox(width: 4),
                  Text(
                    '${dateFormat.format(entry.createdAt)} at ${timeFormat.format(entry.createdAt)}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
                  ),
                  if (entry.sentimentScore != null) ...[
                    const Spacer(),
                    _SentimentBadge(score: entry.sentimentScore!),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getPreview(String? content) {
    if (content == null) return '';
    try {
      // Try to extract plain text from Quill Delta JSON
      final List<dynamic> delta = json.decode(content);
      final buffer = StringBuffer();
      for (final op in delta) {
        if (op is Map && op.containsKey('insert')) {
          final insert = op['insert'];
          if (insert is String) {
            buffer.write(insert);
          }
        }
      }
      return buffer.toString().trim();
    } catch (e) {
      // If not valid JSON, return as-is
      return content;
    }
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Entry'),
        content: const Text(
          'Are you sure you want to delete this journal entry?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              onDelete();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

/// Mood indicator widget
class _MoodIndicator extends StatelessWidget {
  final String? moodTag;

  const _MoodIndicator({this.moodTag});

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;

    switch (moodTag) {
      case 'positive':
        color = Colors.green;
        icon = Icons.sentiment_satisfied;
        break;
      case 'negative':
        color = Colors.red;
        icon = Icons.sentiment_dissatisfied;
        break;
      default:
        color = Colors.grey;
        icon = Icons.sentiment_neutral;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}

/// Sentiment badge widget
class _SentimentBadge extends StatelessWidget {
  final double score;

  const _SentimentBadge({required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getColor().withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '${(score * 100).toInt()}%',
        style: TextStyle(
          fontSize: 12,
          color: _getColor(),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getColor() {
    if (score > 0.3) return Colors.green;
    if (score < -0.3) return Colors.red;
    return Colors.grey;
  }
}

/// Journal entry screen for creating/editing entries with flutter_quill
class JournalEntryScreen extends ConsumerStatefulWidget {
  final String userId;
  final JournalEntry? entry;
  final String? promptId;
  final String? promptText;

  const JournalEntryScreen({
    super.key,
    required this.userId,
    this.entry,
    this.promptId,
    this.promptText,
  });

  @override
  ConsumerState<JournalEntryScreen> createState() => _JournalEntryScreenState();
}

class _JournalEntryScreenState extends ConsumerState<JournalEntryScreen> {
  late QuillController _controller;
  late TextEditingController _titleController;
  bool _isLoading = false;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.entry?.title ?? '');
    _initQuillController();

    _controller.addListener(() {
      if (!_hasChanges) {
        setState(() => _hasChanges = true);
      }
    });
    _titleController.addListener(() {
      if (!_hasChanges) {
        setState(() => _hasChanges = true);
      }
    });
  }

  void _initQuillController() {
    if (widget.entry?.content != null) {
      try {
        final List<dynamic> delta = json.decode(widget.entry!.content!);
        _controller = QuillController(
          document: Document.fromJson(delta),
          selection: const TextSelection.collapsed(offset: 0),
        );
        return;
      } catch (e) {
        // Fall back to plain text if JSON parsing fails
      }
    }
    // Start with empty document
    _controller = QuillController.basic();
  }

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_hasChanges,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _hasChanges) {
          _showDiscardDialog();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.entry == null ? 'New Entry' : 'Edit Entry'),
          actions: [
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            else
              TextButton(onPressed: _saveEntry, child: const Text('Save')),
          ],
        ),
        body: Column(
          children: [
            // Prompt text if available
            if (widget.promptText != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.amber[50],
                child: Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: Colors.amber[700]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.promptText!,
                        style: TextStyle(color: Colors.amber[900]),
                      ),
                    ),
                  ],
                ),
              ),
            // Title field
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Entry title (optional)',
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            // Quill toolbar
            QuillSimpleToolbar(
              controller: _controller,
              config: const QuillSimpleToolbarConfig(
                showBoldButton: true,
                showItalicButton: true,
                showUnderLineButton: true,
                showStrikeThrough: false,
                showInlineCode: false,
                showColorButton: false,
                showBackgroundColorButton: false,
                showClearFormat: true,
                showAlignmentButtons: false,
                showLeftAlignment: false,
                showCenterAlignment: false,
                showRightAlignment: false,
                showJustifyAlignment: false,
                showHeaderStyle: true,
                showListNumbers: true,
                showListBullets: true,
                showListCheck: false,
                showCodeBlock: false,
                showQuote: true,
                showIndent: false,
                showLink: false,
                showUndo: true,
                showRedo: true,
                showDirection: false,
                showSearchButton: false,
                showSubscript: false,
                showSuperscript: false,
              ),
            ),
            const Divider(height: 1),
            // Quill editor
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: QuillEditor.basic(
                  controller: _controller,
                  config: const QuillEditorConfig(
                    placeholder: 'Write your thoughts...',
                    padding: EdgeInsets.zero,
                    autoFocus: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveEntry() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      // Get the Quill Delta JSON
      final contentJson = json.encode(_controller.document.toDelta().toJson());
      final title = _titleController.text.trim();

      final service = ref.read(journalServiceProvider);

      if (widget.entry == null) {
        // Create new entry
        await service.createEntry(
          userId: widget.userId,
          contentJson: contentJson,
          title: title.isEmpty ? null : title,
          promptId: widget.promptId,
        );
      } else {
        // Update existing entry
        await service.updateEntry(
          id: widget.entry!.id,
          contentJson: contentJson,
          title: title.isEmpty ? null : title,
        );
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving entry: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showDiscardDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Discard Changes?'),
        content: const Text(
          'You have unsaved changes. Are you sure you want to discard them?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Keep Editing'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('Discard'),
          ),
        ],
      ),
    );
  }
}
