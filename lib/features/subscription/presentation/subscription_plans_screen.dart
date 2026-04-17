import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';

class SubscriptionPlansScreen extends ConsumerWidget {
  const SubscriptionPlansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.background : AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHero(isDark),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildPlanCard(
                    title: 'Monthly',
                    price: '₹99',
                    desc: 'Perfect for starters',
                    isDark: isDark,
                  ),
                  const SizedBox(height: 16),
                  _buildPlanCard(
                    title: 'Quarterly',
                    price: '₹249',
                    desc: 'Most Popular',
                    isPopular: true,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 16),
                  _buildPlanCard(
                    title: 'Yearly',
                    price: '₹899',
                    desc: 'Best Value',
                    isBestValue: true,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 16),
                  _buildPlanCard(
                    title: 'Family',
                    price: '₹1,499',
                    desc: 'Up to 5 members',
                    isDark: isDark,
                  ),
                  const SizedBox(height: 32),
                  _buildComparisonTable(isDark),
                  const SizedBox(height: 32),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Restore Purchase',
                      style: AppTextStyles.labelLarge(isDark).copyWith(
                        color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      '7-day free trial, cancel anytime',
                      style: AppTextStyles.caption(isDark),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
      decoration: BoxDecoration(
        gradient: AppColors.amberGradient,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.workspace_premium,
              color: Colors.white,
              size: 48,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Unlock Full FitKarma',
            style: AppTextStyles.displayLarge(isDark).copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            '⚡ Premium health insights & features',
            style: AppTextStyles.bodyLarge(isDark).copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required String desc,
    bool isPopular = false,
    bool isBestValue = false,
    required bool isDark,
  }) {
    final hasBadge = isPopular || isBestValue;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: hasBadge
              ? (isPopular
                  ? (isDark ? AppColorsDark.secondary : AppColors.secondary)
                  : AppColors.accent)
              : (isDark ? AppColorsDark.divider : AppColors.divider),
          width: hasBadge ? 2 : 1,
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStats.h2(isDark),
              ),
              if (isPopular)
                _buildBadge('MOST POPULAR', isDark ? AppColorsDark.secondary : AppColors.secondary)
              else if (isBestValue)
                _buildBadge('BEST VALUE', AppColors.accent),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                price,
                style: AppTextStyles.statLarge(isDark).copyWith(
                  color: isDark ? AppColorsDark.primary : AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '/month',
                style: AppTextStyles.bodyMedium(isDark),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            style: AppTextStyles.bodyMedium(isDark),
          ),
          const SizedBox(height: 16),
          _buildFeatureList(isDark),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? AppColorsDark.primary : AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'START $title PLAN',
                style: AppTextStyles.buttonLarge(isDark).copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => _launchUPILink(price.replaceAll('₹', '').replaceAll(',', '')),
              style: OutlinedButton.styleFrom(
                foregroundColor: isDark ? AppColorsDark.primary : AppColors.primary,
                side: BorderSide(
                  color: isDark ? AppColorsDark.primary : AppColors.primary,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.payment, size: 18),
                  const SizedBox(width: 8),
                  Text('Pay via UPI'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildFeatureList(bool isDark) {
    final features = _getFeaturesForPlan();

    return Column(
      children: features.map((feature) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                size: 16,
                color: isDark ? AppColorsDark.success : AppColors.success,
              ),
              const SizedBox(width: 8),
              Text(
                feature,
                style: AppTextStyles.bodyMedium(isDark),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  List<String> _getFeaturesForPlan() {
    return [
      'Personalized diet plans',
      'Advanced health insights',
      'Priority support',
      'Unlimited history',
    ];
  }

  void _launchUPILink(String amount) async {
    final url = 'upi://pay?pa=fitkarma@razorpay&pn=FitKarma&am=$amount&cu=INR';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  Widget _buildComparisonTable(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColorsDark.divider : AppColors.divider,
        ),
      ),
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
                'FEATURE COMPARISON',
                style: AppTextStyles.sectionHeader(isDark),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildComparisonRow('Personalized Diet Plans', true, true, isDark),
          _buildComparisonRow('Advanced Health Insights', true, true, isDark),
          _buildComparisonRow('WhatsApp Support', true, true, isDark),
          _buildComparisonRow('Family Shared Plans', true, false, isDark),
          _buildComparisonRow('Lab Report Import', true, false, isDark),
          _buildComparisonRow('Wearable Sync', true, false, isDark),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(String feature, bool isPro, bool isIncluded, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              feature,
              style: AppTextStyles.bodyMedium(isDark),
            ),
          ),
          if (isPro)
            Icon(
              isIncluded ? Icons.check_circle : Icons.cancel,
              size: 18,
              color: isIncluded
                  ? (isDark ? AppColorsDark.success : AppColors.success)
                  : AppColors.textMuted,
            )
          else
            Icon(
              Icons.remove,
              size: 18,
              color: isDark ? AppColorsDark.textMuted : AppColors.textMuted,
            ),
        ],
      ),
    );
  }
}

// Additional text styles for subscription
class AppTextStats {
  static TextStyle h2(bool isDark) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      );
}
