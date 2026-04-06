import 'package:flutter/material.dart';
import '../../../shared/theme/app_colors.dart';

class KarmaStoreScreen extends StatelessWidget {
  const KarmaStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Karma Store · कर्म स्टोर'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          // Balance Banner
          SliverToBoxAdapter(
            child: _BalanceBanner(totalXP: 540),
          ),

          // Section: Exclusive Rewards
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
              child: const Text(
                'Exclusive Rewards · विशेष पुरस्कार',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.82,
              ),
              delegate: SliverChildListDelegate(
                _storeItems.map((item) => _StoreItemCard(item: item)).toList(),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

// ── Data ──────────────────────────────────────────────────────────────────────
class _StoreItem {
  const _StoreItem({
    required this.emoji,
    required this.title,
    required this.description,
    required this.cost,
    this.isPremium = false,
  });
  final String emoji;
  final String title;
  final String description;
  final int cost;
  final bool isPremium;
}

const _storeItems = [
  _StoreItem(emoji: '🔥', title: 'Streak Shield', description: 'Protect a broken streak (once/30d)', cost: 50),
  _StoreItem(emoji: '📊', title: 'Nutrition Report', description: '30-day PDF report unlock', cost: 100),
  _StoreItem(emoji: '🎯', title: 'Custom Goal', description: 'Set a personalised XP goal', cost: 150),
  _StoreItem(emoji: '🏆', title: 'Gold Badge', description: 'Show off on your profile', cost: 200),
  _StoreItem(emoji: '🧘', title: 'Guided Session', description: 'Unlock premium meditation', cost: 300, isPremium: true),
  _StoreItem(emoji: '💊', title: 'Supplement Guide', description: 'Personalized micro-supplement plan', cost: 500, isPremium: true),
];

// ── Widgets ───────────────────────────────────────────────────────────────────
class _BalanceBanner extends StatelessWidget {
  const _BalanceBanner({required this.totalXP});
  final int totalXP;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C3DC8), Color(0xFF3D1A7A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Text('⚡', style: TextStyle(fontSize: 36)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'YOUR KARMA BALANCE',
                style: TextStyle(color: Colors.white60, fontSize: 11, letterSpacing: 1),
              ),
              const SizedBox(height: 4),
              Text(
                '$totalXP XP',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              const Text('🏅', style: TextStyle(fontSize: 28)),
              const SizedBox(height: 4),
              Text(
                'Level ${(totalXP / 100).floor() + 1}',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StoreItemCard extends StatelessWidget {
  const _StoreItemCard({required this.item});
  final _StoreItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1E1E2E)
            : Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12)],
        border: item.isPremium
            ? Border.all(color: const Color(0xFFFFD700).withOpacity(0.4), width: 1.5)
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(item.emoji, style: const TextStyle(fontSize: 32)),
                const Spacer(),
                if (item.isPremium)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'PREMIUM',
                      style: TextStyle(
                        color: Color(0xFFFFD700),
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              item.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              item.description,
              style: TextStyle(color: Colors.grey[600], fontSize: 11, height: 1.3),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Spent ${item.cost} XP on ${item.title}'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('⚡ ${item.cost} XP', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
