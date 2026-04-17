import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/abha_repository.dart';
import '../../auth/domain/auth_providers.dart';
import '../../../shared/widgets/abha_link_badge.dart';
import '../../../shared/widgets/encryption_badge.dart';

class ABHAScreen extends ConsumerStatefulWidget {
  const ABHAScreen({super.key});

  @override
  ConsumerState<ABHAScreen> createState() => _ABHAScreenState();
}

class _ABHAScreenState extends ConsumerState<ABHAScreen> {
  final _idController = TextEditingController();
  final _otpController = TextEditingController();
  bool _otpSent = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _idController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _verifyOTP() async {
    setState(() => _isLoading = true);
    try {
      final userId = ref.read(authStateProvider).value?.id;
      if (userId == null) throw Exception('User not logged in');

      await ref.read(abhaRepositoryProvider).linkABHA(
        userId: userId,
        abhaId: _idController.text,
        otp: _otpController.text,
      );

      // Refresh status
      ref.invalidate(abhaStatusProvider);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ABHA linked successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusAsync = ref.watch(abhaStatusProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ABHA (Digital Health ID)'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: EncryptionBadge(),
          ),
        ],
      ),
      body: statusAsync.when(
        data: (link) => _buildBody(link),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildBody(AbhaLinkData? link) {
    final isLinked = link != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          ABHALinkBadge(isLinked: isLinked, isLarge: true),
          const SizedBox(height: 32),
          if (!isLinked) _buildUnlinkedForm() else _buildLinkedInfo(link),
          const SizedBox(height: 40),
          _buildConsentNote(),
        ],
      ),
    );
  }

  Widget _buildUnlinkedForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Link your ABHA Number',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Experience seamless access to your health records across India.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 32),
        TextField(
          controller: _idController,
          decoration: const InputDecoration(
            labelText: '14-digit ABHA Number',
            hintText: 'XX-XXXX-XXXX-XXXX',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          maxLength: 14,
        ),
        const SizedBox(height: 16),
        if (_otpSent) ...[
          TextField(
            controller: _otpController,
            decoration: const InputDecoration(
              labelText: 'OTP',
              hintText: 'Enter 6-digit OTP',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
        ],
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _isLoading ? null : (_otpSent ? _verifyOTP : () => setState(() => _otpSent = true)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: _isLoading 
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(_otpSent ? 'VERIFY OTP' : 'SEND OTP'),
          ),
        ),
      ],
    );
  }

  Widget _buildLinkedInfo(AbhaLinkData link) {
    final maskedId = '${link.id.substring(0, 2)}-XXXX-XXXX-${link.id.substring(link.id.length - 4)}';
    
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text('ABHA ID'),
                  subtitle: Text(maskedId, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  trailing: const Icon(Icons.verified, color: Colors.green),
                ),
                if (link.address != null)
                  ListTile(
                    title: const Text('ABHA Address'),
                    subtitle: Text(link.address!),
                  ),
                ListTile(
                  title: const Text('Last Synchronized'),
                  subtitle: Text(link.lastSync != null ? link.lastSync.toString() : 'Once linked'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text('Linked Records', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12),
        _buildLinkedRecordItem('Blood Test Report', 'Apollo Clinics'),
        _buildLinkedRecordItem('Prescription', 'Dr. Shruthi Sharma'),
      ],
    );
  }

  Widget _buildLinkedRecordItem(String title, String source) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(source),
        trailing: ElevatedButton(
          onPressed: () {},
          child: const Text('IMPORT'),
        ),
      ),
    );
  }

  Widget _buildConsentNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        'Consent: By linking your ABHA, you allow FitKarma to process your digital health records. You can revoke this consent anytime in settings.',
        style: TextStyle(fontSize: 11, color: Colors.grey),
      ),
    );
  }
}

