import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/onboarding_providers.dart';

class StepAbhaWearables extends ConsumerStatefulWidget {
  const StepAbhaWearables({super.key});

  @override
  ConsumerState<StepAbhaWearables> createState() => _StepAbhaWearablesState();
}

class _StepAbhaWearablesState extends ConsumerState<StepAbhaWearables> {
  final TextEditingController _abhaController = TextEditingController();
  bool _showOtpField = false;
  final List<String> _otpDigits = List.filled(6, '');
  
  @override
  void dispose() {
    _abhaController.dispose();
    super.dispose();
  }

  String _formatAbhaId(String input) {
    // Format: XX-XXXX-XXXX-XXXX
    final digits = input.replaceAll(RegExp(r'\D'), '');
    if (digits.length <= 2) return digits;
    if (digits.length <= 6) return '${digits.substring(0, 2)}-${digits.substring(2)}';
    if (digits.length <= 10) return '${digits.substring(0, 2)}-${digits.substring(2, 6)}-${digits.substring(6)}';
    return '${digits.substring(0, 2)}-${digits.substring(2, 6)}-${digits.substring(6, 10)}-${digits.substring(10, 14)}';
  }

  void _onAbhaInputChanged(String value) {
    final formatted = _formatAbhaId(value);
    _abhaController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
    
    // Auto-proceed to OTP when 14 digits entered
    if (formatted.replaceAll('-', '').length == 14 && !_showOtpField) {
      setState(() => _showOtpField = true);
    }
  }

  void _onOtpDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      FocusScope.of(context).nextFocus();
    }
    setState(() {
      _otpDigits[index] = value.isNotEmpty ? value[0] : '';
    });
    
    // Check if all digits entered
    if (_otpDigits.every((d) => d.isNotEmpty)) {
      _verifyOtp();
    }
  }

  Future<void> _verifyOtp() async {
    // Simulate OTP verification
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      ref.read(onboardingProvider.notifier).setAbhaLinked(true);
      ref.read(onboardingProvider.notifier).setAbhaId(_abhaController.text);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('ABHA linked successfully! +100 XP'),
          backgroundColor: const Color(0xFF4ADE80),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final textPrimary = isDark ? const Color(0xFFF1F0FF) : const Color(0xFF1A1830);
    final textSecondary = isDark ? const Color(0xFF9B99CC) : const Color(0xFF6B6A96);
    final primary = isDark ? const Color(0xFFFF6B35) : const Color(0xFFF4511E);
    final surface = isDark ? const Color(0xFF1C1C2E) : Colors.white;
    final divider = isDark ? const Color(0x33FFFFFF) : const Color(0x12000000);
    final warning = isDark ? const Color(0xFFFBBF24) : const Color(0xFFF59E0B);
    final success = isDark ? const Color(0xFF4ADE80) : const Color(0xFF22C55E);

    final wearables = [
      ('fitbit', 'Fitbit', 'Steps, Sleep, Heart Rate'),
      ('garmin', 'Garmin', 'Steps, Sleep, HR, GPS Workouts'),
      ('health_connect', 'Health Connect', 'All Android health data'),
      ('healthkit', 'HealthKit', 'All iOS health data'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Connect Health ID',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'स्वास्थ्य ID',
            style: TextStyle(
              fontSize: 12,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Link your ABHA for seamless health records',
            style: TextStyle(
              fontSize: 14,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          
          // ABHA Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  warning.withValues(alpha: 0.15),
                  warning.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: warning.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: warning.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.health_and_safety, color: warning, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ABHA Health ID',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textPrimary,
                            ),
                          ),
                          Text(
                            'Ayushman Bharat Health Account',
                            style: TextStyle(
                              fontSize: 12,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (state.abhaLinked)
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color(0xFF4ADE80),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check, color: Colors.white, size: 16),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                
                if (!state.abhaLinked) ...[
                  Text(
                    'Enter your 14-digit ABHA ID',
                    style: TextStyle(
                      fontSize: 12,
                      color: textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _abhaController,
                    onChanged: _onAbhaInputChanged,
                    keyboardType: TextInputType.number,
                    maxLength: 19,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                      letterSpacing: 2,
                    ),
                    decoration: InputDecoration(
                      hintText: 'XX-XXXX-XXXX-XXXX',
                      hintStyle: TextStyle(color: textSecondary),
                      filled: true,
                      fillColor: surface,
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: divider),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: divider),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: primary, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                  ),
                  
                  if (_showOtpField) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Enter 6-digit OTP sent to your registered mobile',
                      style: TextStyle(
                        fontSize: 12,
                        color: textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return SizedBox(
                          width: 45,
                          height: 50,
                          child: TextField(
                            onChanged: (value) => _onOtpDigitChanged(index, value),
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: surface,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: divider),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: divider),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: primary, width: 2),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ] else ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: success.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: success, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'ABHA ${state.abhaId ?? ""} linked successfully',
                            style: TextStyle(
                              fontSize: 13,
                              color: success,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.lock_outline, size: 14, color: textSecondary),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Your health data is encrypted and stored securely',
                        style: TextStyle(
                          fontSize: 11,
                          color: textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Skip button
          if (!state.abhaLinked)
            Center(
              child: TextButton(
                onPressed: () {
                  ref.read(onboardingProvider.notifier).setAbhaLinked(false);
                },
                child: Text(
                  'Skip for now',
                  style: TextStyle(
                    fontSize: 14,
                    color: textSecondary,
                  ),
                ),
              ),
            ),
          
          const SizedBox(height: 24),
          
          // XP Badge
          if (state.abhaLinked)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFFFB547),
                    const Color(0xFFFF6B35),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.white, size: 18),
                  SizedBox(width: 6),
                  Text(
                    '+100 XP',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          
          const SizedBox(height: 24),
          
          // Wearables Section
          Text(
            'Connect Wearable',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Sync your fitness device for automatic tracking',
            style: TextStyle(
              fontSize: 14,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          
          ...wearables.map((wearableData) {
            final id = wearableData.$1;
            final name = wearableData.$2;
            final desc = wearableData.$3;
            final isConnected = state.wearableConnected && state.connectedWearableType == id;
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () {
                  ref.read(onboardingProvider.notifier).setWearableConnected(!isConnected, id);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isConnected 
                        ? primary.withValues(alpha: 0.15) 
                        : surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isConnected ? primary : divider,
                      width: isConnected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isConnected 
                              ? primary.withValues(alpha: 0.2) 
                              : divider,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _getWearableIcon(id),
                          color: isConnected ? primary : textSecondary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: textPrimary,
                              ),
                            ),
                            Text(
                              desc,
                              style: TextStyle(
                                fontSize: 12,
                                color: textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isConnected 
                              ? primary 
                              : divider,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isConnected ? 'Connected' : 'Connect',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isConnected ? Colors.white : textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          
          const SizedBox(height: 32),
          
          // Privacy Note
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: divider),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: textSecondary, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Your data stays on your device. We never sell your personal information.',
                    style: TextStyle(
                      fontSize: 12,
                      color: textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getWearableIcon(String id) {
    switch (id) {
      case 'fitbit':
        return Icons.watch;
      case 'garmin':
        return Icons.directions_run;
      case 'health_connect':
        return Icons.android;
      case 'healthkit':
        return Icons.apple;
      default:
        return Icons.watch;
    }
  }
}