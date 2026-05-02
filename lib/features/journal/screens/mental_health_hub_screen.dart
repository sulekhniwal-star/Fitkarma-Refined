import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/ambient_widgets.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/status_widgets.dart';
import '../../insights/providers/insight_provider.dart';

// ── Static data ────────────────────────────────────────────────────────────────

const _stressPrograms = [
  (title: '7-Day Calm Reset',    days: 7,  level: 'Beginner',     emoji: '🧘'),
  (title: 'Anxiety Relief Plan', days: 7,  level: 'Intermediate', emoji: '💆'),
  (title: 'Sleep & Stress',      days: 7,  level: 'Beginner',     emoji: '😴'),
  (title: 'Mindful Mornings',    days: 7,  level: 'All levels',   emoji: '🌅'),
];

const _helplines = [
  (name: 'iCall',                number: '9152987821',  org: 'TISS'),
  (name: 'Vandrevala Foundation', number: '18602662345', org: '24×7 Free'),
  (name: 'NIMHANS',              number: '08046110007', org: 'Govt. of India'),
];

// Breathing techniques: (name, inhale, hold1, exhale, hold2) in seconds
const _breathTechniques = [
  (name: '4-7-8',       inhale: 4, hold1: 7, exhale: 8, hold2: 0),
  (name: 'Box Breathing', inhale: 4, hold1: 4, exhale: 4, hold2: 4),
];

// ── Screen ─────────────────────────────────────────────────────────────────────

class MentalHealthHubScreen extends ConsumerStatefulWidget {
  const MentalHealthHubScreen({super.key});

  @override
  ConsumerState<MentalHealthHubScreen> createState() =>
      _MentalHealthHubScreenState();
}

class _MentalHealthHubScreenState
    extends ConsumerState<MentalHealthHubScreen>
    with TickerProviderStateMixin {
  int _breathIndex = 0;
  bool _breathActive = false;
  late AnimationController _breathCtrl;
  late Animation<double> _breathAnim;
  String _breathPhase = 'Tap to begin';

  // Burnout score — placeholder (would come from a provider)
  final int _burnoutScore = 55;

  @override
  void initState() {
    super.initState();
    _breathCtrl = AnimationController(vsync: this);
    _breathAnim = Tween<double>(begin: 0.5, end: 1.0)
        .animate(CurvedAnimation(parent: _breathCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _breathCtrl.dispose();
    super.dispose();
  }

  void _startBreathing() {
    if (_breathActive) {
      _breathCtrl.stop();
      setState(() { _breathActive = false; _breathPhase = 'Tap to begin'; });
      return;
    }
    setState(() => _breathActive = true);
    _runBreathCycle();
  }

  Future<void> _runBreathCycle() async {
    final t = _breathTechniques[_breathIndex];
    while (_breathActive && mounted) {
      // Inhale
      setState(() => _breathPhase = 'Inhale');
      _breathCtrl.duration = Duration(seconds: t.inhale);
      await _breathCtrl.forward(from: 0.5);
      if (!_breathActive) break;
      // Hold 1
      if (t.hold1 > 0) {
        setState(() => _breathPhase = 'Hold');
        await Future.delayed(Duration(seconds: t.hold1));
        if (!_breathActive) break;
      }
      // Exhale
      setState(() => _breathPhase = 'Exhale');
      _breathCtrl.duration = Duration(seconds: t.exhale);
      await _breathCtrl.reverse(from: 1.0);
      if (!_breathActive) break;
      // Hold 2
      if (t.hold2 > 0) {
        setState(() => _breathPhase = 'Hold');
        await Future.delayed(Duration(seconds: t.hold2));
        if (!_breathActive) break;
      }
    }
  }

  Future<void> _call(String number) async {
    final uri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final bg1 = isDark ? AppColorsDark.bg1 : AppColorsLight.bg1;
    final divider = isDark ? AppColorsDark.divider : AppColorsLight.divider;

    final insightAsync = ref.watch(dashboardInsightProvider);

    return Scaffold(
      backgroundColor: bg1,
      body: Stack(
        children: [
          const AmbientBlobs(),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  pinned: true,
                  leading: GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(Icons.arrow_back_ios_new_rounded,
                        size: 20, color: text2),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mental Health',
                          style: AppTypography.h1(color: text0)),
                      Text('मानसिक स्वास्थ्य',
                          style: AppTypography.hindi(color: text2)),
                    ],
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenH),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([

                      // ── CBT Insight card ──────────────────────
                      insightAsync.when(
                        data: (insight) => InsightCard(
                          message: insight,
                          onThumbsUp: () {},
                          onThumbsDown: () {},
                        ),
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 20),

                      // ── Stress programs ───────────────────────
                      Text('Stress Programs',
                          style: AppTypography.h4(color: text0)),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 130,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _stressPrograms.length,
                          itemBuilder: (_, i) {
                            final p = _stressPrograms[i];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GlassCard(
                                borderRadius: AppRadius.md,
                                padding: const EdgeInsets.all(14),
                                child: SizedBox(
                                  width: 150,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(p.emoji,
                                          style: const TextStyle(
                                              fontSize: 28)),
                                      const Spacer(),
                                      Text(p.title,
                                          style: AppTypography.labelMd(
                                              color: text0),
                                          maxLines: 2,
                                          overflow:
                                              TextOverflow.ellipsis),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          _Pill(
                                              label: '${p.days} days',
                                              color: AppColorsDark
                                                  .secondary),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: Text(p.level,
                                                style: AppTypography
                                                    .caption(
                                                        color: text2),
                                                overflow: TextOverflow
                                                    .ellipsis),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── Breathing exercise card ───────────────
                      Text('Breathing Exercise',
                          style: AppTypography.h4(color: text0)),
                      const SizedBox(height: 10),
                      GlassCard(
                        borderRadius: AppRadius.md,
                        padding: const EdgeInsets.all(AppSpacing.cardH),
                        child: Column(
                          children: [
                            // Technique selector
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: List.generate(
                                  _breathTechniques.length, (i) {
                                final active = i == _breathIndex;
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(right: 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_breathActive) return;
                                      setState(() => _breathIndex = i);
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                          milliseconds: 150),
                                      padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 14,
                                              vertical: 6),
                                      decoration: BoxDecoration(
                                        color: active
                                            ? AppColorsDark.teal
                                                .withValues(alpha: 0.2)
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(
                                                AppRadius.full),
                                        border: Border.all(
                                            color: active
                                                ? AppColorsDark.teal
                                                : divider),
                                      ),
                                      child: Text(
                                          _breathTechniques[i].name,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  FontWeight.w600,
                                              color: active
                                                  ? AppColorsDark.teal
                                                  : text2)),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 20),
                            // Animated breath circle
                            GestureDetector(
                              onTap: _startBreathing,
                              child: AnimatedBuilder(
                                animation: _breathAnim,
                                builder: (_, __) => _BreathCircle(
                                  scale: _breathAnim.value,
                                  phase: _breathPhase,
                                  active: _breathActive,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _breathActive
                                  ? 'Tap to stop'
                                  : 'Tap circle to begin',
                              style: AppTypography.caption(color: text2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── Burnout gauge (score > 40) ────────────
                      if (_burnoutScore > 40) ...[
                        Text('Burnout Risk',
                            style: AppTypography.h4(color: text0)),
                        const SizedBox(height: 10),
                        GlassCard(
                          borderRadius: AppRadius.md,
                          padding: const EdgeInsets.all(AppSpacing.cardH),
                          child: _BurnoutGauge(
                              score: _burnoutScore,
                              text0: text0,
                              text2: text2),
                        ),
                        const SizedBox(height: 20),
                      ],

                      // ── Indian helplines ──────────────────────
                      Text('Crisis Support',
                          style: AppTypography.h4(color: text0)),
                      const SizedBox(height: 4),
                      Text('मदद के लिए',
                          style: AppTypography.hindi(color: text2)),
                      const SizedBox(height: 10),
                      GlassCard(
                        borderRadius: AppRadius.md,
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: _helplines.asMap().entries.map((e) {
                            final i = e.key;
                            final h = e.value;
                            return Column(
                              children: [
                                if (i > 0)
                                  Divider(color: divider, height: 1),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppSpacing.cardH,
                                      vertical: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(h.name,
                                                style: AppTypography
                                                    .labelMd(
                                                        color: text0)),
                                            Text(h.org,
                                                style: AppTypography
                                                    .caption(
                                                        color: text2)),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => _call(h.number),
                                        child: Container(
                                          padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 7),
                                          decoration: BoxDecoration(
                                            color: AppColorsDark.success
                                                .withValues(alpha: 0.12),
                                            borderRadius:
                                                BorderRadius.circular(
                                                    AppRadius.full),
                                            border: Border.all(
                                                color: AppColorsDark
                                                    .success
                                                    .withValues(
                                                        alpha: 0.3)),
                                          ),
                                          child: Row(
                                            mainAxisSize:
                                                MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                  Icons.phone_rounded,
                                                  size: 13,
                                                  color: AppColorsDark
                                                      .success),
                                              const SizedBox(width: 5),
                                              Text('Call',
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColorsDark
                                                          .success)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.fabClearance),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Breath circle ──────────────────────────────────────────────────────────────

class _BreathCircle extends StatelessWidget {
  final double scale;
  final String phase;
  final bool active;
  const _BreathCircle(
      {required this.scale, required this.phase, required this.active});

  @override
  Widget build(BuildContext context) {
    final size = 120.0 + (scale * 60);
    return SizedBox(
      width: 200,
      height: 200,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColorsDark.teal.withValues(alpha: 0.15),
            border: Border.all(
                color: AppColorsDark.teal.withValues(alpha: 0.5),
                width: 2),
            boxShadow: active
                ? [
                    BoxShadow(
                        color: AppColorsDark.teal.withValues(alpha: 0.3),
                        blurRadius: 24,
                        spreadRadius: 4)
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              phase,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColorsDark.teal),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Burnout gauge ──────────────────────────────────────────────────────────────

class _BurnoutGauge extends StatelessWidget {
  final int score;
  final Color text0, text2;
  const _BurnoutGauge(
      {required this.score, required this.text0, required this.text2});

  Color get _color {
    if (score < 40) return AppColorsDark.success;
    if (score < 70) return AppColorsDark.warning;
    return AppColorsDark.error;
  }

  String get _label {
    if (score < 40) return 'Low Risk';
    if (score < 70) return 'Moderate Risk';
    return 'High Risk';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 110,
          child: CustomPaint(
            painter: _GaugePainter(score: score, color: _color),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('$score',
                      style: AppTypography.monoLg(color: _color)),
                  Text(_label,
                      style: AppTypography.caption(color: text2)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Based on your sleep, mood, and activity patterns.',
          style: AppTypography.bodySm(color: text2),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _GaugePainter extends CustomPainter {
  final int score;
  final Color color;
  const _GaugePainter({required this.score, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height - 10;
    final r = size.width / 2 - 10;
    final rect = Rect.fromCircle(center: Offset(cx, cy), radius: r);

    // Track
    canvas.drawArc(
      rect,
      math.pi,
      math.pi,
      false,
      Paint()
        ..color = AppColorsDark.divider.withValues(alpha: 0.4)
        ..strokeWidth = 12
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    // Fill
    final sweep = (score / 100).clamp(0.0, 1.0) * math.pi;
    canvas.drawArc(
      rect,
      math.pi,
      sweep,
      false,
      Paint()
        ..color = color
        ..strokeWidth = 12
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    // Needle
    final angle = math.pi + sweep;
    final nx = cx + (r - 6) * math.cos(angle);
    final ny = cy + (r - 6) * math.sin(angle);
    canvas.drawCircle(
      Offset(nx, ny),
      6,
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(_GaugePainter old) =>
      old.score != score || old.color != color;
}

// ── Pill ───────────────────────────────────────────────────────────────────────

class _Pill extends StatelessWidget {
  final String label;
  final Color color;
  const _Pill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) => Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: color)),
      );
}
