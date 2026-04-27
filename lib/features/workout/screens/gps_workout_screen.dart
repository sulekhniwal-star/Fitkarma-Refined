import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_card.dart';

class GPSWorkoutScreen extends ConsumerStatefulWidget {
  const GPSWorkoutScreen({super.key});

  @override
  ConsumerState<GPSWorkoutScreen> createState() => _GPSWorkoutScreenState();
}

class _GPSWorkoutScreenState extends ConsumerState<GPSWorkoutScreen> {
  bool _isRunning = false;
  int _elapsedSeconds = 0;
  double _distanceKm = 0.0;
  int _avgHr = 0;
  Timer? _timer;

  // Mumbai default centre
  final _mapController = MapController();
  final LatLng _centre = const LatLng(19.0760, 72.8777);

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleRun() {
    setState(() => _isRunning = !_isRunning);
    if (_isRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() {
          _elapsedSeconds++;
          _distanceKm += 0.003; // ~10.8 km/h pace simulation
          _avgHr = 140 + (_elapsedSeconds % 10);
        });
      });
    } else {
      _timer?.cancel();
    }
  }

  String get _durationLabel {
    final m = _elapsedSeconds ~/ 60;
    final s = _elapsedSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  String get _paceLabel {
    if (_distanceKm < 0.01) return '--:--';
    final secPerKm = _elapsedSeconds / _distanceKm;
    final m = secPerKm ~/ 60;
    final s = (secPerKm % 60).round();
    return "${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')} /km";
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final primary = isDark ? AppColorsDark.primary : AppColorsLight.primary;

    return Scaffold(
      body: Stack(
        children: [
          // ── Full-bleed flutter_map ────────────────────────
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _centre,
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.fitkarma.app',
                // Dark-style tiles via CartoDB dark matter
                // urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
              ),
            ],
          ),

          // ── Back + offline pill ───────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.screenH),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Offline tile cache indicator
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius:
                          BorderRadius.circular(AppRadius.full),
                      border: Border.all(
                          color: AppColorsDark.teal.withValues(alpha: 0.5)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.offline_bolt_rounded,
                            size: 12, color: AppColorsDark.teal),
                        const SizedBox(width: 5),
                        Text('Tiles cached',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColorsDark.teal)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Stats overlay glass card ──────────────────────
          Positioned(
            left: AppSpacing.screenH,
            right: AppSpacing.screenH,
            bottom: 100,
            child: GlassCard(
              padding: const EdgeInsets.all(AppSpacing.cardH),
              child: Column(
                children: [
                  // Distance — monoXL
                  Text(
                    _distanceKm.toStringAsFixed(2),
                    style: TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      color: primary,
                      letterSpacing: -1,
                    ),
                  ),
                  Text('km',
                      style: AppTypography.labelMd(color: text2)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatCell(
                          label: 'Duration',
                          value: _durationLabel,
                          mono: false,
                          text0: text0,
                          text2: text2),
                      Container(
                          width: 1, height: 36, color: AppColorsDark.divider),
                      _StatCell(
                          label: 'Pace',
                          value: _paceLabel,
                          mono: true,
                          text0: text0,
                          text2: text2),
                      Container(
                          width: 1, height: 36, color: AppColorsDark.divider),
                      _StatCell(
                          label: 'Avg HR',
                          value: _avgHr > 0 ? '$_avgHr bpm' : '-- bpm',
                          mono: true,
                          text0: text0,
                          text2: text2),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ── Start / Stop FAB ──────────────────────────────
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _toggleRun,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: _isRunning ? AppColorsDark.error : primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (_isRunning ? AppColorsDark.error : primary)
                            .withValues(alpha: 0.4),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    _isRunning
                        ? Icons.stop_rounded
                        : Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stat cell ──────────────────────────────────────────────────────────────────

class _StatCell extends StatelessWidget {
  final String label, value;
  final bool mono;
  final Color text0, text2;

  const _StatCell({
    required this.label,
    required this.value,
    required this.mono,
    required this.text0,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontFamily: mono ? 'JetBrainsMono' : null,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: text0,
            ),
          ),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(fontSize: 11, color: text2)),
        ],
      );
}
