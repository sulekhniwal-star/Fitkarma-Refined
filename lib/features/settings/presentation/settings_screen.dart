import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../auth/data/auth_repository.dart';
import '../../health/data/health_providers.dart';

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
          Consumer(
            builder: (context, ref, child) {
              final user = ref.watch(currentUserProvider).asData?.value;
              final abhaLink = ref.watch(abhaLinkProvider(user?.$id ?? ''));
              return abhaLink.when(
                data: (link) => ListTile(
                  leading: Icon(Icons.link, color: link != null ? Colors.green : null),
                  title: const Text('ABHA Link'),
                  subtitle: Text(link != null ? 'Linked: ${link.abhaAddress} ✅' : 'Not linked'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/health/abha-link'),
                ),
                loading: () => const ListTile(title: Text('ABHA Link'), subtitle: Text('Checking...')),
                error: (_, _) => const ListTile(title: Text('ABHA Link'), subtitle: Text('Error')),
              );
            },
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