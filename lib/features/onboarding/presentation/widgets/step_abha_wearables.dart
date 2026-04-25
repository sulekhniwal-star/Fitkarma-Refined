import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/theme/app_theme.dart';
import 'package:fitkarma/shared/widgets/glass_card.dart';
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
    
    if (_otpDigits.every((d) => d.isNotEmpty)) {
      _verifyOtp();
    }
  }

  Future<void> _verifyOtp() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      ref.read(onboardingProvider.notifier).setAbhaLinked(true);
      ref.read(onboardingProvider.notifier).setAbhaId(_abhaController.text);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.verified, color: Colors.white),
              const SizedBox(width: 12),
              Text('ABHA linked successfully! +100 XP', style: AppTheme.labelMd(context).copyWith(color: Colors.white)),
            ],
          ),
          backgroundColor: AppTheme.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);
    
    final wearables = [
      ('fitbit', 'Fitbit', 'Steps, Sleep, Heart Rate', 'फिटबिट'),
      ('garmin', 'Garmin', 'Steps, Sleep, HR, GPS', 'गार्मिन'),
      ('health_connect', 'Health Connect', 'Android health data', 'हेल्थ कनेक्ट'),
      ('healthkit', 'HealthKit', 'Apple health data', 'एप्पल हेल्थकिट'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Connect Health ID', style: AppTheme.h1(context)),
          Text(
            'स्वास्थ्य पहचान पत्र जोड़ें',
            style: AppTheme.hindi(context).copyWith(fontSize: 16, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 32),
          
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.warning.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.health_and_safety, color: AppTheme.warning, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ABHA Health ID', style: AppTheme.h2(context)),
                          Text('Ayushman Bharat Health Account', style: AppTheme.caption(context).copyWith(color: AppTheme.textSecondary)),
                        ],
                      ),
                    ),
                    if (state.abhaLinked)
                      const Icon(Icons.check_circle, color: AppTheme.success, size: 28),
                  ],
                ),
                const SizedBox(height: 24),
                
                if (!state.abhaLinked) ...[
                  Text('14-digit ABHA ID', style: AppTheme.labelMd(context).copyWith(color: AppTheme.textSecondary)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _abhaController,
                    onChanged: _onAbhaInputChanged,
                    keyboardType: TextInputType.number,
                    maxLength: 19,
                    style: AppTheme.monoLg(context).copyWith(letterSpacing: 4),
                    decoration: InputDecoration(
                      hintText: 'XX-XXXX-XXXX-XXXX',
                      hintStyle: AppTheme.monoLg(context).copyWith(color: AppTheme.textMuted, letterSpacing: 4),
                      filled: true,
                      fillColor: AppTheme.surface2.withValues(alpha: 0.5),
                      counterText: '',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    ),
                  ),
                  
                  if (_showOtpField) ...[
                    const SizedBox(height: 24),
                    Text('Verification OTP', style: AppTheme.labelMd(context).copyWith(color: AppTheme.textSecondary)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return SizedBox(
                          width: 48,
                          height: 56,
                          child: TextField(
                            onChanged: (value) => _onOtpDigitChanged(index, value),
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            style: AppTheme.h2(context).copyWith(fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: AppTheme.surface2,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: AppTheme.primary, width: 2),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ] else ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.success.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.success.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Text('Linked Successfully', style: AppTheme.labelLg(context).copyWith(color: AppTheme.success)),
                        Text(state.abhaId ?? '', style: AppTheme.monoLg(context)),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          if (!state.abhaLinked)
            Center(
              child: TextButton(
                onPressed: () => ref.read(onboardingProvider.notifier).setAbhaLinked(false),
                child: Text('Skip for now', style: AppTheme.labelMd(context).copyWith(color: AppTheme.textMuted)),
              ),
            ),
            
          const SizedBox(height: 40),
          
          Text('Connect Wearable', style: AppTheme.h2(context)),
          Text(
            'फिटनेस डिवाइस जोड़ें',
            style: AppTheme.hindi(context).copyWith(fontSize: 14, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 16),
          
          ...wearables.map((wearableData) {
            final id = wearableData.$1;
            final isConnected = state.wearableConnected && state.connectedWearableType == id;
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => ref.read(onboardingProvider.notifier).setWearableConnected(!isConnected, id),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isConnected ? AppTheme.primaryMuted : AppTheme.glass,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    border: Border.all(
                      color: isConnected ? AppTheme.primary : AppTheme.glassBorder,
                      width: isConnected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getWearableIcon(id),
                        color: isConnected ? AppTheme.primary : AppTheme.textSecondary,
                        size: 28,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(wearableData.$2, style: AppTheme.labelLg(context)),
                            Text(wearableData.$3, style: AppTheme.caption(context).copyWith(color: AppTheme.textSecondary)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isConnected ? AppTheme.primary : AppTheme.surface2,
                          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                        ),
                        child: Text(
                          isConnected ? 'CONNECTED' : 'CONNECT',
                          style: AppTheme.caption(context).copyWith(
                            color: isConnected ? Colors.white : AppTheme.textSecondary,
                            fontWeight: FontWeight.bold,
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
          GlassCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.privacy_tip_outlined, color: AppTheme.textMuted, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Your data is encrypted and stays private. We focus on your security.',
                    style: AppTheme.bodySm(context).copyWith(color: AppTheme.textMuted),
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
      case 'fitbit': return Icons.watch;
      case 'garmin': return Icons.directions_run;
      case 'health_connect': return Icons.android;
      case 'healthkit': return Icons.apple;
      default: return Icons.watch;
    }
  }
}
