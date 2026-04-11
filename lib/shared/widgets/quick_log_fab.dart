import 'package:flutter/material.dart';

class QuickLogFAB extends StatefulWidget {
  final VoidCallback onFood;
  final VoidCallback onWorkout;
  final VoidCallback onBp;
  final VoidCallback onGlucose;
  final VoidCallback onWater;
  final VoidCallback onMood;

  const QuickLogFAB({
    super.key,
    required this.onFood,
    required this.onWorkout,
    required this.onBp,
    required this.onGlucose,
    required this.onWater,
    required this.onMood,
  });

  @override
  State<QuickLogFAB> createState() => _QuickLogFABState();
}

class _QuickLogFABState extends State<QuickLogFAB> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
       vsync: this,
       duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_isOpen) ...[
          _buildActionButton(Icons.restaurant, 'Food', widget.onFood, 1),
          _buildActionButton(Icons.fitness_center, 'Workout', widget.onWorkout, 2),
          _buildActionButton(Icons.favorite, 'BP', widget.onBp, 3),
          _buildActionButton(Icons.bloodtype, 'Glucose', widget.onGlucose, 4),
          _buildActionButton(Icons.local_drink, 'Water', widget.onWater, 5),
          _buildActionButton(Icons.sentiment_satisfied, 'Mood', widget.onMood, 6),
          const SizedBox(height: 16),
        ],
        FloatingActionButton(
          onPressed: _toggle,
          backgroundColor: Colors.orange[700],
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _controller,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onPressed, int index) {
    return FadeTransition(
      opacity: _controller,
      child: ScaleTransition(
        scale: _controller,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
               Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 8),
              FloatingActionButton.small(
                onPressed: () {
                  _toggle();
                  onPressed();
                },
                backgroundColor: Colors.white,
                child: Icon(icon, color: Colors.orange[700], size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
