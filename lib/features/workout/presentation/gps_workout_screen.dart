// lib/features/workout/presentation/gps_workout_screen.dart
// GPS Outdoor workout tracking with flutter_map

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fitkarma/features/workout/data/pr_detection_service.dart';
import 'package:fitkarma/features/workout/presentation/pr_celebration_widget.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';

class GpsWorkoutScreen extends ConsumerStatefulWidget {
  const GpsWorkoutScreen({super.key});

  @override
  ConsumerState<GpsWorkoutScreen> createState() => _GpsWorkoutScreenState();
}

class _GpsWorkoutScreenState extends ConsumerState<GpsWorkoutScreen> {
  final MapController _mapController = MapController();
  StreamSubscription<Position>? _positionStream;

  List<LatLng> _routePoints = [];
  bool _isTracking = false;
  bool _hasPermission = false;
  Position? _currentPosition;
  DateTime? _startTime;
  Timer? _timer;
  int _elapsedSeconds = 0;
  double _totalDistanceMeters = 0;
  double _currentSpeed = 0;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _checkPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showPermissionDialog('Location services are disabled');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showPermissionDialog('Location permission denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showPermissionDialog('Location permissions are permanently denied');
      return;
    }

    setState(() {
      _hasPermission = true;
    });

    // Get initial position
    try {
      final position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
      });
      _mapController.move(LatLng(position.latitude, position.longitude), 15);
    } catch (e) {
      debugPrint('Error getting initial position: $e');
    }
  }

  void _showPermissionDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission Required'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _startTracking() {
    if (!_hasPermission) {
      _checkPermissions();
      return;
    }

    setState(() {
      _isTracking = true;
      _startTime = DateTime.now();
      _routePoints = [];
      _totalDistanceMeters = 0;
      _elapsedSeconds = 0;
    });

    // Start location updates
    _positionStream =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 5, // Update every 5 meters
          ),
        ).listen((Position position) {
          setState(() {
            _currentPosition = position;
            _currentSpeed = position.speed; // m/s

            if (_routePoints.isNotEmpty) {
              final lastPoint = _routePoints.last;
              final newPoint = LatLng(position.latitude, position.longitude);
              final distance = Geolocator.distanceBetween(
                lastPoint.latitude,
                lastPoint.longitude,
                newPoint.latitude,
                newPoint.longitude,
              );
              _totalDistanceMeters += distance;
            }

            _routePoints.add(LatLng(position.latitude, position.longitude));
          });
        });

    // Start timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  void _stopTracking() {
    _positionStream?.cancel();
    _timer?.cancel();
    setState(() {
      _isTracking = false;
    });
  }

  String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPS Workout'),
        actions: [
          if (_isTracking)
            IconButton(
              icon: const Icon(Icons.stop),
              onPressed: () {
                _stopTracking();
                _showCompletionDialog();
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Map
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentPosition != null
                    ? LatLng(
                        _currentPosition!.latitude,
                        _currentPosition!.longitude,
                      )
                    : const LatLng(28.6139, 77.2090), // Default to Delhi
                initialZoom: 15,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.fitkarma.fitkarma',
                ),
                // Route polyline
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      color: Colors.blue,
                      strokeWidth: 4,
                    ),
                  ],
                ),
                // Current position marker
                if (_currentPosition != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(
                          _currentPosition!.latitude,
                          _currentPosition!.longitude,
                        ),
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.location_on,
                          color: _isTracking ? Colors.red : Colors.blue,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),

          // Stats panel
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Column(
              children: [
                // Timer
                Text(
                  _formatTime(_elapsedSeconds),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _StatItem(
                      icon: Icons.straighten,
                      label: 'Distance',
                      value: _totalDistanceMeters > 1000
                          ? '${(_totalDistanceMeters / 1000).toStringAsFixed(2)} km'
                          : '${_totalDistanceMeters.toStringAsFixed(0)} m',
                    ),
                    _StatItem(
                      icon: Icons.speed,
                      label: 'Speed',
                      value: '${(_currentSpeed * 3.6).toStringAsFixed(1)} km/h',
                    ),
                    _StatItem(
                      icon: Icons.timer,
                      label: 'Pace',
                      value: _totalDistanceMeters > 0
                          ? '${((_elapsedSeconds / 60) / (_totalDistanceMeters / 1000)).toStringAsFixed(1)} min/km'
                          : '-- min/km',
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Start/Stop button
                if (!_isTracking)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _startTracking,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Start Workout'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  )
                else
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _stopTracking,
                      icon: const Icon(Icons.stop),
                      label: const Text('Stop Workout'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCompletionDialog() async {
    // Calculate average speed in m/s
    final averageSpeed = _elapsedSeconds > 0
        ? _totalDistanceMeters / _elapsedSeconds
        : 0.0;

    // Check for PRs
    List<DetectedPR> prs = [];
    try {
      final authService = AuthAwService();
      final userId = await authService.getStoredUserId();
      if (userId != null) {
        final prService = PRDetectionService();
        prs = await prService.checkForPRs(
          userId: userId,
          workoutType: 'Running',
          durationMinutes: _elapsedSeconds ~/ 60,
          totalDistanceMeters: _totalDistanceMeters,
          averageSpeed: averageSpeed,
        );

        // Record PRs and award XP
        for (final pr in prs) {
          await prService.recordPRAndAwardXP(userId: userId, pr: pr);
        }
      }
    } catch (e) {
      debugPrint('Error checking for PRs: $e');
    }

    if (!mounted) return;

    // Show completion dialog first
    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Workout Complete! 🎉'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Duration: ${_formatTime(_elapsedSeconds)}'),
            Text(
              'Distance: ${_totalDistanceMeters > 1000 ? '${(_totalDistanceMeters / 1000).toStringAsFixed(2)} km' : '${_totalDistanceMeters.toStringAsFixed(0)} m'}',
            ),
            if (prs.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.emoji_events, color: Colors.amber),
                    const SizedBox(width: 8),
                    Text(
                      '${prs.length} New PR${prs.length > 1 ? 's' : ''}!',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            const Text('Great job on your outdoor workout!'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            child: const Text('Save & Exit'),
          ),
        ],
      ),
    );

    // Show PR celebration after dialog
    if (prs.isNotEmpty && mounted) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (prs.length == 1) {
        showPRCelebration(context, prs.first);
      } else {
        showMultiplePRCelebration(context, prs);
      }
    }
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
      ],
    );
  }
}
