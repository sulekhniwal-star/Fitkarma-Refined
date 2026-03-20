// lib/features/karma/presentation/karma_store_screen.dart
// Karma Store Screen - Rewards redeemable with XP

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/karma/data/karma_models.dart';
import 'package:fitkarma/features/karma/data/karma_providers.dart';

class KarmaStoreScreen extends ConsumerWidget {
  const KarmaStoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final karmaNotifier = ref.watch(karmaNotifierProvider);
    final state = karmaNotifier.state;
    final rewards = KarmaReward.rewards;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Karma Store'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.bolt, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    '${state.profile?.totalXp ?? 0} XP',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: rewards.length,
              itemBuilder: (context, index) {
                final reward = rewards[index];
                final canAfford =
                    (state.profile?.totalXp ?? 0) >= reward.xpCost;

                return _RewardCard(
                  reward: reward,
                  canAfford: canAfford,
                  onRedeem: () async {
                    if (!canAfford) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Not enough XP to redeem this reward'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Show confirmation dialog
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Redeem ${reward.name}?'),
                        content: Text(
                          'This will cost ${reward.xpCost} XP. Are you sure?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Redeem'),
                          ),
                        ],
                      ),
                    );

                    if (confirmed == true) {
                      final success = await karmaNotifier.redeemReward(reward);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              success
                                  ? '🎉 ${reward.name} redeemed successfully!'
                                  : 'Failed to redeem reward',
                            ),
                            backgroundColor: success
                                ? Colors.green
                                : Colors.red,
                          ),
                        );
                      }
                    }
                  },
                );
              },
            ),
    );
  }
}

class _RewardCard extends StatelessWidget {
  final KarmaReward reward;
  final bool canAfford;
  final VoidCallback onRedeem;

  const _RewardCard({
    required this.reward,
    required this.canAfford,
    required this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: canAfford ? 4 : 1,
      color: canAfford ? null : Colors.grey[200],
      child: InkWell(
        onTap: onRedeem,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(reward.icon, style: const TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              Text(
                reward.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: canAfford ? null : Colors.grey,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                reward.description,
                style: TextStyle(
                  fontSize: 12,
                  color: canAfford ? Colors.grey[600] : Colors.grey,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: canAfford ? Colors.amber[100] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.bolt,
                      size: 16,
                      color: canAfford ? Colors.amber[800] : Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${reward.xpCost} XP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: canAfford ? Colors.amber[800] : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
