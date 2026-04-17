import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../auth/domain/auth_providers.dart';

class ReferralScreen extends ConsumerWidget {
  const ReferralScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;
    final referralCode = user?.id.substring(0, 8).toUpperCase() ?? 'FIT-JOIN';

    return Scaffold(
      appBar: AppBar(title: const Text('Rewards & Referrals')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildRewardHero(),
            const SizedBox(height: 32),
            _buildReferralCard(context, referralCode),
            const SizedBox(height: 32),
            _buildLeaderboard(),
            const SizedBox(height: 32),
            _buildMilestones(),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardHero() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
            Text('Invite & Earn XP', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    _RewardInfo(label: 'Referrer', xp: '+500 XP'),
                    _RewardInfo(label: 'New User', xp: '+100 XP'),
                ],
            ),
        ],
      ),
    );
  }

  Widget _buildReferralCard(BuildContext context, String code) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('Your Unique Code', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: code));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Code copied!')));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.orange.shade200)),
                child: Text(code, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2)),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => Share.share('Join me on FitKarma! Use my code $code to get 100 XP instantly.'),
                icon: const Icon(Icons.share),
                label: const Text('SHARE VIA WHATSAPP'),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF25D366), foregroundColor: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
                onPressed: () {},
                child: const Text('COPY LINK', style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('National Top Referrers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ...List.generate(3, (index) => ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(['Aditya R.', 'Sneha P.', 'Rahul M.'][index]),
            trailing: Text('${[120, 95, 84][index]} Refers', style: const TextStyle(fontWeight: FontWeight.bold)),
        )),
      ],
    );
  }

  Widget _buildMilestones() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(16)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text('Milestone Rewards', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text('🏆 Invite 10 friends → Unlock "Community Leader" Badge'),
            Text('⚡ Invite 25 friends → 1 Month Premium Free'),
        ],
      ),
    );
  }
}

class _RewardInfo extends StatelessWidget {
  final String label;
  final String xp;
  const _RewardInfo({required this.label, required this.xp});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
            Text(label, style: const TextStyle(color: Colors.white70)),
            Text(xp, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
    );
  }
}

