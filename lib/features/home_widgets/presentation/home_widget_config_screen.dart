import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';
import '../../../shared/widgets/home_widget_preview.dart';

class HomeWidgetConfigScreen extends ConsumerWidget {
  const HomeWidgetConfigScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen Widgets')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          HomeWidgetPreview(
            title: 'Activity Rings',
            description: 'Today\'s steps, calories, and water progress.',
            size: '2x2',
            icon: Icons.donut_large,
            onAdd: () => HomeWidget.requestPinWidget(
              name: 'ActivityRingsWidgetProvider',
            ),
          ),
          const SizedBox(height: 24),
          HomeWidgetPreview(
            title: 'Health Insight',
            description: 'Weekly health trend and focus area.',
            size: '4x1',
            icon: Icons.insights,
            onAdd: () {},
          ),
          const SizedBox(height: 24),
          HomeWidgetPreview(
            title: 'Event Countdown',
            description: 'Countdown to your next Festival or Wedding.',
            size: '2x2',
            icon: Icons.event,
            onAdd: () {},
          ),

          const SizedBox(height: 40),
          _buildInstructionsCard(),
        ],
      ),
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
          SizedBox(height: 12),
          Text(
            'Android: Long-press any empty space on your home screen, select Widgets, search for FitKarma, and drag your favorite to the home screen.',
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
          SizedBox(height: 8),
          Text(
            'iOS: Long-press your home screen until icons jiggle, tap the + button, search for FitKarma, and choose a widget size.',
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

