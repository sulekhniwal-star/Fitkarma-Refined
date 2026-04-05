import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          _SectionHeader(title: 'Account'),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Privacy'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.fingerprint),
            title: const Text('Biometric Lock'),
            trailing: Switch(value: false, onChanged: (v) {}),
          ),
          const Divider(),
          _SectionHeader(title: 'Data & Sync'),
          ListTile(
            leading: const Icon(Icons.sync),
            title: const Text('Sync Status'),
            subtitle: const Text('Last synced 5 min ago'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.cloud_off),
            title: const Text('Offline Mode'),
            subtitle: const Text('Enabled'),
            trailing: Switch(value: false, onChanged: (v) {}),
          ),
          ListTile(
            leading: const Icon(Icons.storage),
            title: const Text('Data Usage'),
            subtitle: const Text('12.5 MB used'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          _SectionHeader(title: 'Appearance'),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            trailing: Switch(value: false, onChanged: (v) {}),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: const Text('English'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          _SectionHeader(title: 'Health Integrations'),
          ListTile(
            leading: const Icon(Icons.watch),
            title: const Text('Wearables'),
            subtitle: const Text('Connect fitness tracker'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.link),
            title: const Text('ABHA Link'),
            subtitle: const Text('Not linked'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.health_and_safety),
            title: const Text('Health Connect'),
            subtitle: const Text('Connected'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          _SectionHeader(title: 'Support'),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help Center'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Feedback'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          _SectionHeader(title: 'About'),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Version'),
            subtitle: const Text('1.0.0'),
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Terms of Service'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Sign Out'),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

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
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
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
          Text(lastSync, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 16),
            Text('User Name', style: Theme.of(context).textTheme.headlineSmall),
            Text('user@email.com', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _ProfileRow(label: 'Member Since', value: 'Jan 2026'),
                    _ProfileRow(label: 'Current Streak', value: '12 days'),
                    _ProfileRow(label: 'Total XP', value: '2,450'),
                    _ProfileRow(label: 'Level', value: 'Level 5'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}