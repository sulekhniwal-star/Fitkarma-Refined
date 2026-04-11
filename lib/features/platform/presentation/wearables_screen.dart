import 'package:flutter/material.dart';

class WearablesScreen extends StatelessWidget {
  const WearablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wearables')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Connect your fitness tracker', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          _DeviceCard(
            name: 'Google Pixel Watch',
            icon: Icons.watch,
            status: 'Connected',
            color: Colors.blue,
          ),
          _DeviceCard(
            name: 'Fitbit',
            icon: Icons.fitness_center,
            status: 'Not connected',
            color: Colors.green,
          ),
          _DeviceCard(
            name: 'Garmin',
            icon: Icons.directions_run,
            status: 'Not connected',
            color: Colors.orange,
          ),
          _DeviceCard(
            name: 'Apple Watch',
            icon: Icons.apple,
            status: 'Not connected',
            color: Colors.grey,
          ),
          const SizedBox(height: 24),
          Text('Synced Data', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _SyncItem(icon: Icons.directions_walk, label: 'Steps', lastSync: '5 min ago'),
                  _SyncItem(icon: Icons.fitness_center, label: 'Workouts', lastSync: '1 hour ago'),
                  _SyncItem(icon: Icons.bedtime, label: 'Sleep', lastSync: '2 hours ago'),
                  _SyncItem(icon: Icons.favorite, label: 'Heart Rate', lastSync: '5 min ago'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final String status;
  final Color color;

  const _DeviceCard({required this.name, required this.icon, required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    final isConnected = status == 'Connected';
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: color),
        ),
        title: Text(name),
        subtitle: Text(status),
        trailing: isConnected
            ? const Icon(Icons.check_circle, color: Colors.green)
            : OutlinedButton(onPressed: () {}, child: const Text('Connect')),
      ),
    );
  }
}

class _SyncItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String lastSync;

  const _SyncItem({required this.icon, required this.label, required this.lastSync});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(label)),
          const Spacer(),
          Text(lastSync, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
