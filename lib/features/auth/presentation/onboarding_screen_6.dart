import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/di/providers.dart';
import 'package:fitkarma/core/storage/drift_service.dart';
import '../data/onboarding_providers.dart';
import '../data/user_profile_service.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';

class OnboardingScreen6 extends ConsumerStatefulWidget {
  const OnboardingScreen6({super.key});

  @override
  ConsumerState<OnboardingScreen6> createState() => _OnboardingScreen6State();
}

class _OnboardingScreen6State extends ConsumerState<OnboardingScreen6> {
  bool _abhaLinked = false;
  String? _abhaNumber;
  final _abhaController = TextEditingController();
  bool _isLoading = false;
  List<String> _connectedWearables = [];

  final List<_Wearable> _wearables = [
    _Wearable(id: 'fitbit', name: 'Fitbit', icon: Icons.watch),
    _Wearable(id: 'garmin', name: 'Garmin', icon: Icons.sports_score),
    _Wearable(id: 'apple_health', name: 'Apple Health', icon: Icons.favorite),
    _Wearable(id: 'google_fit', name: 'Google Fit', icon: Icons.directions_run),
    _Wearable(
      id: 'samsung_health',
      name: 'Samsung Health',
      icon: Icons.phone_android,
    ),
    _Wearable(
      id: 'huawei_health',
      name: 'Huawei Health',
      icon: Icons.phone_iphone,
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(onboardingStateProvider).state;
      _abhaLinked = state.abhaLinked;
      _abhaNumber = state.abhaNumber;
      _connectedWearables = List.from(state.connectedWearables);
      if (_abhaNumber != null) _abhaController.text = _abhaNumber!;
    });
  }

  @override
  void dispose() {
    _abhaController.dispose();
    super.dispose();
  }

  void _linkAbha() {
    if (_abhaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your ABHA number')),
      );
      return;
    }

    // In a real app, validate the ABHA number with the Ayushman Bharat API
    setState(() {
      _abhaLinked = true;
      _abhaNumber = _abhaController.text;
    });
  }

  void _unlinkAbha() {
    setState(() {
      _abhaLinked = false;
      _abhaNumber = null;
      _abhaController.clear();
    });
  }

  void _toggleWearable(String id) {
    setState(() {
      if (_connectedWearables.contains(id)) {
        _connectedWearables.remove(id);
      } else {
        _connectedWearables.add(id);
      }
    });
  }

  Future<void> _completeOnboarding() async {
    setState(() => _isLoading = true);

    try {
      final notifier = ref.read(onboardingStateProvider);
      final currentState = notifier.state;
      notifier.updateState(
        currentState.copyWith(
          abhaLinked: _abhaLinked,
          abhaNumber: _abhaNumber,
          connectedWearables: _connectedWearables,
        ),
      );

      // Get user ID from session
      final session = await ref.read(appwriteSessionProvider.future);
      final userId = session.userId ?? 'anonymous_user';

      // Get drift service which has the database
      final driftService = ref.read(driftServiceProvider);

      // Create user profile service
      final profileService = UserProfileService(driftService.db);

      // Get Appwrite databases for sync
      final databases = ref.read(appwriteDatabasesProvider);

      // Save to Drift, enqueue Appwrite sync, and award XP
      await profileService.completeOnboarding(
        notifier.state,
        userId,
        databases,
      );

      if (mounted) {
        // Show success message with XP
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 8),
                Text(_abhaLinked ? '+150 XP earned!' : '+50 XP earned!'),
              ],
            ),
            backgroundColor: AppColors.success,
          ),
        );

        // Navigate to home
        context.go('/home/dashboard');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving profile: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _skip() {
    _completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ABHA & Wearables'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/onboarding/5'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicator
              LinearProgressIndicator(
                value: 6 / 6,
                backgroundColor: AppColors.divider,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Step 6 of 6',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text('Connect Your Health', style: AppTextStyles.h1),
              const SizedBox(height: 8),
              Text(
                'Link ABHA and connect wearables for a complete health picture (optional)',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),

              // ABHA Card
              _buildAbhaSection(),
              const SizedBox(height: 32),

              // Wearables Section
              Text('Connect Wearables', style: AppTextStyles.h3),
              const SizedBox(height: 8),
              Text(
                'Sync data from your fitness devices',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),

              // Wearables Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.5,
                ),
                itemCount: _wearables.length,
                itemBuilder: (context, index) {
                  final wearable = _wearables[index];
                  final isConnected = _connectedWearables.contains(wearable.id);
                  return InkWell(
                    onTap: () => _toggleWearable(wearable.id),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isConnected
                            ? AppColors.success.withOpacity(0.1)
                            : Colors.white,
                        border: Border.all(
                          color: isConnected
                              ? AppColors.success
                              : AppColors.divider,
                          width: isConnected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            wearable.icon,
                            color: isConnected
                                ? AppColors.success
                                : AppColors.textSecondary,
                            size: 28,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            wearable.name,
                            style: AppTextStyles.labelMedium.copyWith(
                              color: isConnected
                                  ? AppColors.success
                                  : AppColors.textPrimary,
                            ),
                          ),
                          if (isConnected)
                            Text(
                              'Connected',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.success,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // XP Reward Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.accent),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: AppColors.accent, size: 32),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Complete Profile',
                            style: AppTextStyles.labelLarge.copyWith(
                              color: AppColors.accentDark,
                            ),
                          ),
                          Text(
                            _abhaLinked
                                ? '+150 XP (ABHA linked + Profile complete)'
                                : '+50 XP (Profile complete)',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.accentDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isLoading ? null : _skip,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Skip'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _completeOnboarding,
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Complete'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAbhaSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _abhaLinked
              ? [AppColors.success, AppColors.teal]
              : [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.health_and_safety,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ABHA Link',
                      style: AppTextStyles.h4.copyWith(color: Colors.white),
                    ),
                    Text(
                      'Ayushman Bharat Health Account',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              if (_abhaLinked)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.success,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Linked',
                        style: TextStyle(
                          color: AppColors.success,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (_abhaLinked)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ABHA Number: ${_abhaNumber?.substring(0, 4)}****${_abhaNumber?.substring(_abhaNumber!.length - 4)}',
                  style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: _unlinkAbha,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                  ),
                  child: const Text('Unlink ABHA'),
                ),
              ],
            )
          else
            Column(
              children: [
                Text(
                  'Link your ABHA to earn +100 XP bonus and access government health schemes.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _abhaController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter ABHA number',
                          hintStyle: TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _linkAbha,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                      ),
                      child: const Text('Link'),
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _Wearable {
  final String id;
  final String name;
  final IconData icon;

  const _Wearable({required this.id, required this.name, required this.icon});
}
