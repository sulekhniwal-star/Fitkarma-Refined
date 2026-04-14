import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionPlansScreen extends ConsumerWidget {
  const SubscriptionPlansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHero(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                 children: [
                    _buildPlanCard(title: 'Monthly', price: '₹99', desc: 'Perfect for starters'),
                    const SizedBox(height: 16),
                    _buildPlanCard(title: 'Quarterly', price: '₹249', desc: 'Most Popular', isPopular: true),
                    const SizedBox(height: 16),
                    _buildPlanCard(title: 'Yearly', price: '₹899', desc: 'Best Value', isBestValue: true),
                    const SizedBox(height: 16),
                    _buildPlanCard(title: 'Family', price: '₹1,499', desc: 'Up to 5 members'),
                    const SizedBox(height: 32),
                    _buildComparisonTable(),
                    const SizedBox(height: 32),
                    TextButton(onPressed: () {}, child: const Text('Restore Purchase', style: TextStyle(color: Colors.grey))),
                    const SizedBox(height: 40),
                 ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFFFFC107), Color(0xFFFF9800)]),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: const Column(
        children: [
          Icon(Icons.workspace_premium, color: Colors.white, size: 64),
          SizedBox(height: 16),
          Text('Upgrade to PRO', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
          Text('Unlock precision health insights', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildPlanCard({required String title, required String price, required String desc, bool isPopular = false, bool isBestValue = false}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: (isPopular || isBestValue) ? Colors.orange : Colors.grey.shade200, width: 2),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              if (isPopular) _buildBadge('MOST POPULAR', Colors.blue),
              if (isBestValue) _buildBadge('BEST VALUE', Colors.green),
            ],
          ),
          const SizedBox(height: 8),
          Text(price, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange)),
          Text(desc, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
              child: Text('START $title PLAN'),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
               onPressed: () => _launchUPILink(price.replaceAll('₹', '').replaceAll(',', '')),
               child: const Text('Pay via UPI'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  void _launchUPILink(String amount) async {
    final url = 'upi://pay?pa=fitkarma@razorpay&pn=FitKarma&am=$amount&cu=INR';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  Widget _buildComparisonTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Feature Comparison', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildComparisonRow('Personalised Diet Plans', true),
        _buildComparisonRow('Advanced Health Insights', true),
        _buildComparisonRow('WhatsApp Bot Support', true),
        _buildComparisonRow('Family Shared Plans', false),
      ],
    );
  }

  Widget _buildComparisonRow(String feature, bool isPro) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(feature),
          Icon(isPro ? Icons.check_circle : Icons.cancel, color: isPro ? Colors.green : Colors.grey),
        ],
      ),
    );
  }
}
