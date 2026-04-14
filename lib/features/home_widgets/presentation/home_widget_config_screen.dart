import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';

class HomeWidgetConfigScreen extends ConsumerWidget {
  const HomeWidgetConfigScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen Widgets')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildWidgetPreview(
            context: context,
            title: 'Activity Rings (2x2)',
            description: 'Today\'s steps, calories, and water progress.',
            previewColor: Colors.orange.shade50,
            icon: Icons.donut_large,
          ),
          const SizedBox(height: 24),
          _buildWidgetPreview(
            context: context,
            title: 'Health Insight (4x1)',
            description: 'Weekly health trend and focus area.',
            previewColor: Colors.blue.shade50,
            icon: Icons.insights,
          ),
          const SizedBox(height: 24),
          _buildWidgetPreview(
            context: context,
            title: 'Event Countdown (2x2)',
            description: 'Countdown to your next Festival or Wedding.',
            previewColor: Colors.amber.shade50,
            icon: Icons.event,
          ),
          const SizedBox(height: 40),
          _buildInstructionsCard(),
        ],
      ),
    );
  }

  Widget _buildWidgetPreview({
    required BuildContext context,
    required String title,
    required String description,
    required Color previewColor,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
            color: previewColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 64, color: Colors.black26),
              const SizedBox(height: 12),
              const Text('Widget Preview', style: TextStyle(color: Colors.black45)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(description, style: const TextStyle(color: Colors.grey, fontSize: 13))),
            ElevatedButton(
              onPressed: () => HomeWidget.requestPinWidget(
                name: 'ActivityRingsWidgetProvider', // Simulation
                androidName: 'ActivityRingsWidgetProvider',
              ),
              child: const Text('ADD'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInstructionsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, size: 20, color: Colors.blue),
              SizedBox(width: 12),
              Text('How to setup', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Android: Long-press any empty space on your home screen, select Widgets, search for FitKarma, and drag your favorite to the home screen.',
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
          const SizedBox(height: 8),
          Text(
            'iOS: Long-press your home screen until icons jiggle, tap the + button, search for FitKarma, and choose a widget size.',
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
