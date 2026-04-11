import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/health_repository.dart';
import '../../../shared/theme/app_colors.dart';

class AbhaLinkScreen extends ConsumerStatefulWidget {
  const AbhaLinkScreen({super.key});

  @override
  ConsumerState<AbhaLinkScreen> createState() => _AbhaLinkScreenState();
}

class _AbhaLinkScreenState extends ConsumerState<AbhaLinkScreen> {
  final _abhaAddressCtrl = TextEditingController();
  final _otpCtrl = TextEditingController();
  bool _otpSent = false;
  bool _isLinking = false;

  @override
  void dispose() {
    _abhaAddressCtrl.dispose();
    _otpCtrl.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (_abhaAddressCtrl.text.isEmpty) return;
    setState(() => _isLinking = true);
    // Simulate API call to NHA
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _otpSent = true;
      _isLinking = false;
    });
  }

  Future<void> _verifyOtp() async {
    if (_otpCtrl.text.isEmpty) return;
    setState(() => _isLinking = true);
    
    // Simulate verification
    await Future.delayed(const Duration(seconds: 2));

    final repo = ref.read(healthRepositoryProvider);

    await repo.linkAbha(
      abhaAddress: _abhaAddressCtrl.text,
      abhaNumber: '${_abhaAddressCtrl.text.split('@').first}1234',
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ABHA ID linked successfully! 🎉')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Link ABHA ID', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Center(
              child: Icon(Icons.security, size: 64, color: Colors.blue),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ayushman Bharat Health Account',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Link your national health ID to access your medical records and government health benefits.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),
            if (!_otpSent) ...[
              TextField(
                controller: _abhaAddressCtrl,
                decoration: const InputDecoration(
                  labelText: 'ABHA Address / Health ID',
                  hintText: 'e.g. user@abdm',
                  prefixIcon: Icon(Icons.alternate_email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLinking ? null : _sendOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: _isLinking 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('SEND OTP', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ] else ...[
              Text('OTP sent to your registered mobile number ending in ****89', 
                style: TextStyle(color: Colors.blue[800], fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 16),
              TextField(
                controller: _otpCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter OTP',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLinking ? null : _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: _isLinking 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('VERIFY & LINK', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              TextButton(
                onPressed: () => setState(() => _otpSent = false),
                child: const Text('Change Health ID'),
              ),
            ],
            const SizedBox(height: 100),
            Image.network(
              'https://dashboard.abdm.gov.in/abdm/images/abdm_logo.png',
              height: 40,
              errorBuilder: (_, _, _) => const Text('NDHM / ABDM', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
