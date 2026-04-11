import 'package:flutter/material.dart';

class WaterIntakeDialog extends StatefulWidget {
  final Function(double) onSave;

  const WaterIntakeDialog({super.key, required this.onSave});

  @override
  State<WaterIntakeDialog> createState() => _WaterIntakeDialogState();
}

class _WaterIntakeDialogState extends State<WaterIntakeDialog> {
  double _glasses = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Water Intake'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.water_drop, size: 64, color: Colors.blue),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _glasses > 0.5 ? () => setState(() => _glasses -= 0.5) : null,
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '$_glasses Glass${_glasses == 1 ? '' : 'es'}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () => setState(() => _glasses += 0.5),
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('1 glass ≈ 250ml', style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL')),
        ElevatedButton(
          onPressed: () {
            widget.onSave(_glasses);
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
          child: const Text('LOG WATER'),
        ),
      ],
    );
  }
}
