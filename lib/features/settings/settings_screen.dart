import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/security/biometric_service.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _biometricEnabled = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final biometric = BiometricService.instance;
    final enabled = await biometric.isBiometricEnabled();
    if (mounted) {
      setState(() {
        _biometricEnabled = enabled;
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleBiometric(bool value) async {
    if (value) {
      final authenticated = await BiometricService.instance.authenticate(
        reason: 'Authenticate to enable biometric lock',
      );
      if (!authenticated) return;
    }
    
    await BiometricService.instance.setBiometricEnabled(value);
    setState(() => _biometricEnabled = value);
  }

  @override
  Widget build(BuildContext context) {
    const isHindi = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi ? 'सेटिंग्स' : 'Settings'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSectionHeader(
                  isHindi ? 'सुरक्षा' : 'Security',
                ),
                const SizedBox(height: 8),
                _buildBiometricTile(isHindi),
                const SizedBox(height: 24),
                _buildSectionHeader(
                  isHindi ? 'ऐप' : 'App',
                ),
                const SizedBox(height: 8),
                _buildAboutTile(isHindi),
              ],
            ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary),
      ),
    );
  }

  Widget _buildBiometricTile(bool isHindi) {
    final biometric = BiometricService.instance;

    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.fingerprint, color: AppColors.primary),
        ),
        title: Text(isHindi ? 'बायोमेट्रिक लॉक' : 'Biometric Lock'),
        subtitle: Text(
          isHindi
              ? 'ऐप खोलने के लिए फ़िंगरप्रिंट या चेहरा'
              : 'Use fingerprint or face to unlock app',
          style: AppTextStyles.bodySmall,
        ),
        trailing: Builder(
          builder: (context) {
            final isAvailable = biometric.isAvailable;
            return Switch(
              value: _biometricEnabled,
              onChanged: isAvailable ? _toggleBiometric : null,
              activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
              activeThumbColor: AppColors.primary,
            );
          },
        ),
      ),
    );
  }

  Widget _buildAboutTile(bool isHindi) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.info_outline, color: Colors.blue),
        ),
        title: const Text('FitKarma'),
        subtitle: const Text('Version 1.0.0'),
      ),
    );
  }
}