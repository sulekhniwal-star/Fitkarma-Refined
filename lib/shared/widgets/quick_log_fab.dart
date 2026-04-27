import 'package:flutter/material.dart';

class QuickLogFAB extends StatefulWidget {
  const QuickLogFAB({super.key});

  @override
  State<QuickLogFAB> createState() => _QuickLogFABState();
}

class _QuickLogFABState extends State<QuickLogFAB> with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _controller;

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
      children: [
        if (_isOpen) ...[
          _buildSubFAB(Icons.restaurant, 'Food', Colors.orange),
          const SizedBox(height: 12),
          _buildSubFAB(Icons.water_drop, 'Water', Colors.blue),
          const SizedBox(height: 12),
          _buildSubFAB(Icons.mood, 'Mood', Colors.purple),
          const SizedBox(height: 12),
          _buildSubFAB(Icons.fitness_center, 'Workout', Colors.green),
          const SizedBox(height: 12),
          _buildSubFAB(Icons.monitor_heart, 'BP', Colors.red),
          const SizedBox(height: 12),
          _buildSubFAB(Icons.bloodtype, 'Glucose', Colors.redAccent),
          const SizedBox(height: 16),
        ],
        FloatingActionButton(
          onPressed: _toggle,
          backgroundColor: const Color(0xFFF97316),
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _controller,
          ),
        ),
      ],
    );
  }

  Widget _buildSubFAB(IconData icon, String label, Color color) {
    return Row(
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
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        const SizedBox(width: 12),
        FloatingActionButton.small(
          onPressed: () {},
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
      ],
    );
  }
}
