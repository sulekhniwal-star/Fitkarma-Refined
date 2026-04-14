import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:local_auth/local_auth.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../shared/widgets/encryption_badge.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final LocalAuthentication _auth = LocalAuthentication();
  bool _biometricEnabled = false;
  double _fontSize = 1.0;
  bool _dyslexiaFont = false;

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.surfaceVariant : AppColors.surfaceVariant,
      appBar: AppBar(
        backgroundColor: isDark ? AppColorsDark.surfaceVariant : AppColors.surfaceVariant,
        elevation: 0,
        title: const Text('Settings'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: EncryptionBadge(),
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Account', 'खाता'),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Edit Profile'),
            onTap: () => context.push('/profile/edit'),
          ),
          ListTile(
            leading: const Icon(Icons.star_outline, color: Colors.orange),
            title: const Text('Subscription'),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(4)),
              child: const Text('PRO', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 10)),
            ),
            onTap: () => context.push('/subscription'),
          ),
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Change Password'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.health_and_safety_outlined),
            title: const Text('ABHA Account'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/abha'),
          ),


          const Divider(),
          _buildSectionHeader('Preferences', 'पसंद'),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            trailing: const Text('English'),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: const Text('Theme'),
            trailing: DropdownButton<ThemeMode>(
              value: themeMode,
              onChanged: (mode) {
                if (mode != null) ref.read(themeProvider.notifier).setThemeMode(mode);
              },
              items: const [
                DropdownMenuItem(value: ThemeMode.system, child: Text('Auto')),
                DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.format_size, color: Colors.grey),
                const SizedBox(width: 16),
                const Text('Font Size'),
                Expanded(
                  child: Slider(
                    value: _fontSize,
                    min: 0.8,
                    max: 1.4,
                    onChanged: (val) => setState(() => _fontSize = val),
                  ),
                ),
              ],
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.spellcheck),
            title: const Text('Dyslexia Friendly Font'),
            subtitle: const Text('Reduces reading difficulty'),
            value: _dyslexiaFont,
            onChanged: (val) => setState(() => _dyslexiaFont = val),
          ),

          const Divider(),
          _buildSectionHeader('Privacy & Security', 'गोपनीयता और सुरक्षा'),
          SwitchListTile(
            secondary: const Icon(Icons.fingerprint),
            title: const Text('Biometric Lock'),
            value: _biometricEnabled,
            onChanged: (val) async {
              final canCheck = await _auth.canCheckBiometrics;
              if (canCheck) {
                setState(() => _biometricEnabled = val);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.download_outlined),
            title: const Text('Export My Data'),
            subtitle: const Text('Portable JSON of all health logs'),
            onTap: () => Share.share('{"user": "id", "logs": []}', subject: 'FitKarma Data Export'),
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text('Account Deletion', style: TextStyle(color: Colors.red)),
            onTap: _showDeleteDialog,
          ),


          const Divider(),
          _buildSectionHeader('Data & Sync', 'डेटा और सिंक'),
          SwitchListTile(
            secondary: const Icon(Icons.data_usage),
            title: const Text('Low Data Mode'),
            value: false,
            onChanged: (val) {},
          ),
          const ListTile(
            leading: Icon(Icons.sync),
            title: Text('Sync Interval'),
            trailing: Text('15 min'),
          ),
          ListTile(
            leading: const Icon(Icons.watch),
            title: const Text('Wearable Connections'),
            onTap: () => context.push('/wearables'),
          ),
          ListTile(
            leading: const Icon(Icons.pending_outlined, color: Colors.amber),
            title: const Text('Pending Sync Items'),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: Colors.amber.shade100, borderRadius: BorderRadius.circular(10)),
              child: const Text('2', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 10)),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.error_outline, color: Colors.red),
            title: const Text('View Failed Sync Items'),
            onTap: () {},
          ),

          const Divider(),
          _buildSectionHeader('Customisation', 'अनुकूलन'),
          ListTile(
            leading: const Icon(Icons.widgets_outlined),
            title: const Text('Home Widgets'),
            subtitle: const Text('Configure Android/iOS widgets'),
            onTap: () => context.push('/home-widgets'),
          ),

          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: OutlinedButton(
              onPressed: () => context.go('/login'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('LOGOUT'),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, [String? hindi]) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 3,
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          if (hindi != null)
             Padding(
               padding: const EdgeInsets.only(left: 11),
               child: Text(
                 hindi,
                 style: TextStyle(fontSize: 10, color: isDark ? AppColorsDark.textMuted : AppColors.textMuted),
               ),
             ),
        ],
      ),
    );
  }


  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account?'),
        content: const Text('All your encrypted health data, logs, and progress will be permanently erased. This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL')),
          TextButton(
            onPressed: () => context.go('/login'),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('DELETE PERMANENTLY'),
          ),
        ],
      ),
    );
  }
}
