import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:fitkarma/features/workout/data/workout_aw_service.dart';
import 'package:fitkarma/features/workout/data/workout_service.dart';
import 'package:fitkarma/features/workout/data/map_cache_service.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class WorkoutHomeScreen extends ConsumerWidget {
  const WorkoutHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WorkoutCalendarScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CustomWorkoutBuilderScreen()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search workouts...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemCount: WorkoutCategory.all.length,
              itemBuilder: (context, index) {
                final category = WorkoutCategory.all[index];
                return _buildCategoryCard(context, category);
              },
            ),
          ),
          _buildQuickActions(context),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, WorkoutCategory category) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => WorkoutListScreen(category: category.name),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.primary.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                category.icon,
                style: const TextStyle(fontSize: 36),
              ),
              const SizedBox(height: 8),
              Text(
                category.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                category.description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GPSWorkoutScreen()),
              ),
              icon: const Icon(Icons.directions_run),
              label: const Text('Outdoor GPS'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WorkoutHistoryScreen()),
              ),
              icon: const Icon(Icons.history),
              label: const Text('History'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WorkoutListScreen extends ConsumerWidget {
  final String category;

  const WorkoutListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final awService = ref.watch(workoutAwServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: FutureBuilder<List<WorkoutData>>(
        future: awService.getWorkoutsByCategory(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final workouts = snapshot.data ?? [];
          if (workouts.isEmpty) {
            return const Center(child: Text('No workouts found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return _buildWorkoutCard(context, workout);
            },
          );
        },
      ),
    );
  }

  Widget _buildWorkoutCard(BuildContext context, WorkoutData workout) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.fitness_center, color: AppColors.primary),
        ),
        title: Text(
          workout.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${workout.duration} min • ${workout.difficulty}'),
            Text(
              workout.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WorkoutDetailScreen(workout: workout),
          ),
        ),
      ),
    );
  }
}

class WorkoutDetailScreen extends StatefulWidget {
  final WorkoutData workout;

  const WorkoutDetailScreen({super.key, required this.workout});

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  bool _isPlayerReady = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.black,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.play_circle_outline,
                      color: Colors.white,
                      size: 80,
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        color: Colors.black54,
                        child: Text(
                          '${widget.workout.duration} min',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.workout.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildInfoChip(Icons.timer, '${widget.workout.duration} min'),
                      const SizedBox(width: 8),
                      _buildInfoChip(Icons.speed, widget.workout.difficulty),
                      const SizedBox(width: 8),
                      _buildInfoChip(Icons.local_fire_department, 
                        '${(widget.workout.caloriesPerMin * widget.workout.duration).round()} cal'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.workout.description,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isPlayerReady ? () => _startWorkout(context) : null,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Start Workout'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  void _startWorkout(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ActiveWorkoutScreen(workout: widget.workout),
      ),
    );
  }
}

class ActiveWorkoutScreen extends StatefulWidget {
  final WorkoutData workout;

  const ActiveWorkoutScreen({super.key, required this.workout});

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  int _elapsedSeconds = 0;
  Timer? _timer;
  int _rpe = 5;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _elapsedSeconds++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Workout'),
        actions: [
          TextButton(
            onPressed: _finishWorkout,
            child: const Text('Finish', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: Colors.black,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.fitness_center,
                    color: Colors.white54,
                    size: 80,
                  ),
                  if (_isCompleted)
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 60,
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildTimerDisplay(),
                const SizedBox(height: 16),
                if (_isCompleted) _buildRPESlider(),
                if (_isCompleted)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveWorkout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Save Workout (+20 XP)'),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerDisplay() {
    final minutes = _elapsedSeconds ~/ 60;
    final seconds = _elapsedSeconds % 60;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text('Duration', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          Text(
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRPESlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rate of Perceived Exertion (RPE)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('Easy'),
            Expanded(
              child: Slider(
                value: _rpe.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                label: _rpe.toString(),
                onChanged: (value) => setState(() => _rpe = value.round()),
              ),
            ),
            const Text('Hard'),
          ],
        ),
        Text(
          'RPE: $_rpe/10',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  void _finishWorkout() {
    _timer?.cancel();
    setState(() => _isCompleted = true);
  }

  void _saveWorkout() {
    final calories = (widget.workout.caloriesPerMin * _elapsedSeconds / 60).round();
    final duration = _elapsedSeconds ~/ 60;
    
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Workout saved! +$duration min, $calories cal, RPE: $_rpe'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class GPSWorkoutScreen extends ConsumerStatefulWidget {
  const GPSWorkoutScreen({super.key});

  @override
  ConsumerState<GPSWorkoutScreen> createState() => _GPSWorkoutScreenState();
}

class _GPSWorkoutScreenState extends ConsumerState<GPSWorkoutScreen> {
  bool _isTracking = false;
  List<LatLng> _routePoints = [];
  LatLng? _currentPosition;
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPS Workout'),
        actions: [
          if (_routePoints.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.stop),
              onPressed: _stopTracking,
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentPosition ?? const LatLng(28.6139, 77.2090),
                initialZoom: 15,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.fitkarma.app',
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      color: const Color(0xFF4A148C),
                      strokeWidth: 4,
                    ),
                  ],
                ),
                if (_currentPosition != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _currentPosition!,
                        width: 40,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF4A148C),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.directions_run, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          _buildStatsPanel(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isTracking ? _stopTracking : _startTracking,
        icon: Icon(_isTracking ? Icons.stop : Icons.play_arrow),
        label: Text(_isTracking ? 'Stop' : 'Start'),
        backgroundColor: _isTracking ? Colors.red : Colors.green,
      ),
    );
  }

  Widget _buildStatsPanel() {
    double distanceKm = 0;
    if (_routePoints.length >= 2) {
      for (int i = 1; i < _routePoints.length; i++) {
        distanceKm += const Distance().as(
          LengthUnit.Kilometer,
          _routePoints[i - 1],
          _routePoints[i],
        );
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStat('Distance', '${distanceKm.toStringAsFixed(2)} km', Icons.straighten),
            _buildStat('Time', _formatTime(_elapsedSeconds), Icons.timer),
            _buildStat('Pace', distanceKm > 0 ? '${(_elapsedSeconds / 60 / distanceKm).toStringAsFixed(1)} min/km' : '--', Icons.speed),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
      ],
    );
  }

  int _elapsedSeconds = 0;
  Timer? _trackingTimer;

  void _startTracking() async {
    final service = ref.read(workoutServiceProvider);
    final hasPermission = await service.checkLocationPermission();
    
    if (!hasPermission) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission required')),
        );
      }
      return;
    }

    final position = await service.getCurrentPosition();
    if (position != null) {
      setState(() {
        _isTracking = true;
        _currentPosition = LatLng(position.latitude, position.longitude);
        _routePoints = [_currentPosition!];
      });
    }

    service.startGpsTracking(
      onPointAdded: (point) => setState(() {
        _currentPosition = point;
        _routePoints.add(point);
      }),
      onError: () {},
    );

    _trackingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _elapsedSeconds++);
    });
  }

  void _stopTracking() {
    final service = ref.read(workoutServiceProvider);
    service.stopGpsTracking();
    _trackingTimer?.cancel();
    setState(() => _isTracking = false);
  }

  String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}

class CustomWorkoutBuilderScreen extends ConsumerWidget {
  const CustomWorkoutBuilderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutState = ref.watch(customWorkoutProvider);
    final notifier = ref.read(customWorkoutProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Workout'),
        actions: [
          TextButton(
            onPressed: workoutState.exercises.isNotEmpty
                ? () => _saveWorkout(context, ref)
                : null,
            child: const Text('Save'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Workout Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: notifier.setWorkoutName,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: workoutState.category,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Strength', 'HIIT', 'Yoga', 'Cardio']
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) => notifier.setCategory(v ?? 'Strength'),
                ),
              ],
            ),
          ),
          Expanded(
            child: workoutState.exercises.isEmpty
                ? const Center(child: Text('Add exercises below'))
                : ListView.builder(
                    itemCount: workoutState.exercises.length,
                    itemBuilder: (context, index) {
                      final ex = workoutState.exercises[index];
                      return ListTile(
                        title: Text(ex.name),
                        subtitle: Text('${ex.sets} sets × ${ex.reps} reps'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => notifier.removeExercise(index),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showAddExerciseDialog(context, ref),
                icon: const Icon(Icons.add),
                label: const Text('Add Exercise'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddExerciseDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final setsController = TextEditingController(text: '3');
    final repsController = TextEditingController(text: '10');
    final restController = TextEditingController(text: '60');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Exercise'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Exercise Name'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: setsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Sets'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: repsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Reps'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: restController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Rest (seconds)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final exercise = CustomExercise(
                name: nameController.text,
                sets: int.tryParse(setsController.text) ?? 3,
                reps: int.tryParse(repsController.text) ?? 10,
                restSeconds: int.tryParse(restController.text) ?? 60,
              );
              ref.read(customWorkoutProvider.notifier).addExercise(exercise);
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _saveWorkout(BuildContext context, WidgetRef ref) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Custom workout saved!')),
    );
    Navigator.pop(context);
  }
}

class WorkoutCalendarScreen extends StatelessWidget {
  const WorkoutCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout Calendar')),
      body: const Center(child: Text('Calendar coming soon')),
    );
  }
}

class WorkoutHistoryScreen extends StatelessWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout History')),
      body: const Center(child: Text('History coming soon')),
    );
  }
}