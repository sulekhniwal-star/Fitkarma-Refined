import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class PrescriptionScreen extends ConsumerStatefulWidget {
  final String userId;
  final int appointmentId;

  const PrescriptionScreen({
    super.key,
    required this.userId,
    required this.appointmentId,
  });

  @override
  ConsumerState<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends ConsumerState<PrescriptionScreen> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescription Photo'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: _isProcessing
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.camera_alt, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text('Photograph your prescription'),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _takePhoto,
                      icon: const Icon(Icons.camera),
                      label: const Text('Take Photo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _takePhoto() async {
    setState(() => _isProcessing = true);
    
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Photo captured! (Image picker requires setup)'),
        ),
      );
      context.pop();
    }
  }
}