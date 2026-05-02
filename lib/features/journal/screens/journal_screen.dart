import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/status_widgets.dart';
import '../../journal/providers/journal_provider.dart';

// ── Constants ──────────────────────────────────────────────────────────────────

const _emojis = ['😡', '😟', '😐', '😊', '🤩'];
const _tags = ['Grateful', 'Anxious', 'Hopeful', 'Tired', 'Calm', 'Inspired'];

// ── Screen ─────────────────────────────────────────────────────────────────────

class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({super.key});

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  final _quillCtrl = quill.QuillController.basic();
  final _editorFocus = FocusNode();
  int? _selectedMood;
  final Set<String> _selectedTags = {};
  bool _saving = false;

  @override
  void dispose() {
    _quillCtrl.dispose();
    _editorFocus.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final delta = _quillCtrl.document.toDelta();
    final body = jsonEncode(delta.toJson());
    if (body == '[{"insert":"\\n"}]') return; // empty
    setState(() => _saving = true);
    await ref.read(journalProvider.notifier).createEntry(
          body: body,
          moodScore: _selectedMood != null ? _selectedMood! + 1 : null,
          moodEmoji: _selectedMood != null ? _emojis[_selectedMood!] : null,
          tags: _selectedTags.toList(),
        );
    _quillCtrl.clear();
    setState(() {
      _saving = false;
      _selectedMood = null;
      _selectedTags.clear();
    });
  }

  String _firstLine(String body) {
    try {
      final ops = jsonDecode(body) as List;
      for (final op in ops) {
        final insert = op['insert'];
        if (insert is String && insert.trim().isNotEmpty) {
          final line = insert.split('\n').first.trim();
          if (line.isNotEmpty) {
            return line.length > 60 ? '${line.substring(0, 60)}…' : line;
          }
        }
      }
    } catch (_) {}
    return 'No content';
  }

  String _fmtDate(DateTime dt) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${dt.day} ${months[dt.month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final bg1 = isDark ? AppColorsDark.bg1 : AppColorsLight.bg1;
    final surface0 = isDark ? AppColorsDark.surface0 : AppColorsLight.surface0;
    final divider = isDark ? AppColorsDark.divider : AppColorsLight.divider;
    final primary = isDark ? AppColorsDark.primary : AppColorsLight.primary;

    final prompt = ref.watch(journalPromptProvider).asData?.value
        ?? 'How are you feeling today? What\'s one thing you\'re grateful for?';
    final entriesAsync = ref.watch(journalProvider);
    final entries = entriesAsync.asData?.value ?? [];
    final showSentiment = entries.length >= 30;

    return Scaffold(
      backgroundColor: bg1,
      // Calm Zone — no AmbientBlobs
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
            Text('Journal', style: AppTypography.h1(color: text0)),
            Text('डायरी', style: AppTypography.hindi(color: text2)),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: AppSpacing.screenH),
            child: EncryptionBadge(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenH, 16, AppSpacing.screenH, 32),
        children: [
          // ── Today's prompt ────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(AppSpacing.cardH),
            decoration: BoxDecoration(
              color: AppColorsDark.accent.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                  color: AppColorsDark.accent.withValues(alpha: 0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('💡', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(prompt,
                      style: AppTypography.bodyMd(color: text0)
                          .copyWith(fontStyle: FontStyle.italic)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Quill editor ──────────────────────────────────────
          GlassCard(
            borderRadius: AppRadius.md,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                // Toolbar
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: divider)),
                  ),
                  child: quill.QuillSimpleToolbar(
                    controller: _quillCtrl,
                    config: quill.QuillSimpleToolbarConfig(
                      showFontFamily: false,
                      showFontSize: false,
                      showSubscript: false,
                      showSuperscript: false,
                      showInlineCode: false,
                      showCodeBlock: false,
                      showIndent: false,
                      showLink: false,
                      showSearchButton: false,
                      showClipboardCut: false,
                      showClipboardCopy: false,
                      showClipboardPaste: false,
                      toolbarIconAlignment: WrapAlignment.start,
                      buttonOptions: quill.QuillSimpleToolbarButtonOptions(
                        base: quill.QuillToolbarBaseButtonOptions(
                          iconTheme: quill.QuillIconTheme(
                            iconButtonSelectedData:
                                quill.IconButtonData(color: primary),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Editor
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 200),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: quill.QuillEditor.basic(
                      controller: _quillCtrl,
                      focusNode: _editorFocus,
                      config: quill.QuillEditorConfig(
                        placeholder: 'Write your thoughts…',
                        padding: EdgeInsets.zero,
                        customStyles: quill.DefaultStyles(
                          paragraph: quill.DefaultTextBlockStyle(
                            AppTypography.bodyMd(color: text0),
                            const quill.HorizontalSpacing(0, 0),
                            const quill.VerticalSpacing(0, 0),
                            const quill.VerticalSpacing(0, 0),
                            null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // ── Mood emoji row ────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (i) {
              final sel = _selectedMood == i;
              return GestureDetector(
                onTap: () =>
                    setState(() => _selectedMood = sel ? null : i),
                child: AnimatedScale(
                  scale: sel ? 1.2 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.elasticOut,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: sel
                          ? Border.all(color: primary, width: 2)
                          : null,
                      color: sel
                          ? primary.withValues(alpha: 0.1)
                          : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(_emojis[i],
                            style: const TextStyle(fontSize: 26))),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),

          // ── Tag chips ─────────────────────────────────────────
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _tags.map((tag) {
              final active = _selectedTags.contains(tag);
              return GestureDetector(
                onTap: () => setState(() {
                  if (active) {
                    _selectedTags.remove(tag);
                  } else {
                    _selectedTags.add(tag);
                  }
                }),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: active
                        ? primary.withValues(alpha: 0.15)
                        : surface0,
                    borderRadius:
                        BorderRadius.circular(AppRadius.full),
                    border: Border.all(
                        color: active
                            ? primary.withValues(alpha: 0.5)
                            : divider),
                  ),
                  child: Text(tag,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: active ? primary : text2)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // ── Save button ───────────────────────────────────────
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _saving ? null : _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md)),
              ),
              child: _saving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : const Text('Save Entry',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
            ),
          ),
          const SizedBox(height: 24),

          // ── Sentiment summary (30+ entries) ───────────────────
          if (showSentiment) ...[
            _SentimentCard(
                entries: entries,
                isDark: isDark,
                text0: text0,
                text2: text2),
            const SizedBox(height: 20),
          ],

          // ── Past entries ──────────────────────────────────────
          if (entries.isNotEmpty) ...[
            Text('Past Entries',
                style: AppTypography.h4(color: text0)),
            const SizedBox(height: 10),
            ...entries.take(20).map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: GestureDetector(
                    onTap: () {
                      // Slide transition to entry detail (placeholder)
                    },
                    child: GlassCard(
                      borderRadius: AppRadius.md,
                      padding: const EdgeInsets.all(AppSpacing.cardH),
                      child: Row(
                        children: [
                          if (e.moodEmoji != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(e.moodEmoji!,
                                  style:
                                      const TextStyle(fontSize: 22)),
                            ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(_firstLine(e.body),
                                    style: AppTypography.labelMd(
                                        color: text0),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 2),
                                Text(_fmtDate(e.createdAt),
                                    style: AppTypography.caption(
                                        color: text2)),
                              ],
                            ),
                          ),
                          Icon(Icons.chevron_right_rounded,
                              color: text2, size: 18),
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ],
      ),
    );
  }
}

// ── Sentiment summary card ─────────────────────────────────────────────────────

class _SentimentCard extends StatelessWidget {
  final List<dynamic> entries;
  final bool isDark;
  final Color text0, text2;
  const _SentimentCard(
      {required this.entries,
      required this.isDark,
      required this.text0,
      required this.text2});

  @override
  Widget build(BuildContext context) {
    final scored = entries
        .where((e) => e.moodScore != null)
        .map((e) => (e.moodScore as int).toDouble())
        .toList();
    final avg = scored.isEmpty
        ? 0.0
        : scored.reduce((a, b) => a + b) / scored.length;
    final trend = scored.length >= 2
        ? scored.last - scored[scored.length - 2]
        : 0.0;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardH),
      decoration: BoxDecoration(
        color: AppColorsDark.secondary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
            color: AppColorsDark.secondary.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.psychology_rounded,
                  size: 16, color: AppColorsDark.secondary),
              const SizedBox(width: 8),
              Text('Sentiment Summary',
                  style: AppTypography.labelMd(
                      color: AppColorsDark.secondary)),
              const Spacer(),
              TrendChip(value: trend, isHigherBetter: true),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Avg mood: ${avg.toStringAsFixed(1)}/5 across ${entries.length} entries',
            style: AppTypography.bodyMd(color: text0),
          ),
          const SizedBox(height: 4),
          Text('Processed on-device only · never uploaded',
              style: AppTypography.caption(color: text2)),
        ],
      ),
    );
  }
}
// ── Entry Detail Screen (Placeholder) ─────────────────────────────────────────

class _EntryDetailScreen extends StatelessWidget {
  final dynamic entry;
  const _EntryDetailScreen({required this.entry});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final bg1 = isDark ? AppColorsDark.bg1 : AppColorsLight.bg1;

    return Scaffold(
      backgroundColor: bg1,
      appBar: AppBar(
        backgroundColor: bg1,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded,
              size: 20, color: text2),
        ),
        title: Text('Entry Detail', style: AppTypography.h3(color: text0)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.screenH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mood: ${entry.moodEmoji ?? 'None'}',
              style: AppTypography.bodyLg(color: text0),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  entry.body, // In real app, render Quill
                  style: AppTypography.bodyMd(color: text0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
