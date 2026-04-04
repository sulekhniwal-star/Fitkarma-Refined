import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/family/data/family_models.dart';
import 'package:fitkarma/features/family/data/family_repository.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

class FamilyScreen extends ConsumerWidget {
  const FamilyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(familyRepositoryProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: AppBar(
          backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          title: const Text('Family Hub 🏠'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Members'),
              Tab(text: 'Challenges'),
            ],
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_active_outlined),
              onPressed: () => _showNotificationSheet(context, ref),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            _FamilyMembersTab(state: state),
            _FamilyChallengesTab(state: state),
          ],
        ),
      ),
    );
  }

  void _showNotificationSheet(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Send Family Alert 🚨', style: AppTextStyles.titleMedium),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'e.g., Time for morning yoga!',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(familyRepositoryProvider.notifier).sendGroupMessage(
                        'Family Alert',
                        controller.text,
                      );
                  Navigator.pop(context);
                },
                child: const Text('Broadcast to All'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _FamilyMembersTab extends ConsumerWidget {
  final FamilyState state;
  const _FamilyMembersTab({required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<FamilyGroup?>(
      future: state.familyGroup,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final group = snapshot.data;
        if (group == null) return _EmptyFamilyState();

        // Sort members for leaderboard (using random mock for now if data is missing)
        final members = group.members.toList();

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _FamilyStatsHero(members: members),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Family Members', style: AppTextStyles.titleMedium),
                if (group.members.length < 6)
                  TextButton.icon(
                    onPressed: () => _showInviteSheet(context, ref),
                    icon: const Icon(Icons.add_circle_outline),
                    label: const Text('Invite'),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            ...members.map((member) => _MemberCard(
                  member: member,
                  isAdmin: group.isAdminMe('me'), // Assume 'me' is current user for UI
                )),
          ],
        );
      },
    );
  }

  void _showInviteSheet(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Invite Family Member ✉️', style: AppTextStyles.titleMedium),
            const Text('Only for Family Plan users (Max 5 members)',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_outlined),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(familyRepositoryProvider.notifier).inviteMember(
                        emailController.text.trim(),
                      );
                  Navigator.pop(context);
                },
                child: const Text('Send Invitation'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _FamilyStatsHero extends StatelessWidget {
  final List<FamilyMember> members;
  const _FamilyStatsHero({required this.members});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFF2ECC71)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Weekly Step Leaderboard 🏆',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _PodiumPlace(name: 'Mom', steps: 42000, rank: 2),
              _PodiumPlace(name: 'You', steps: 48500, rank: 1, isMe: true),
              _PodiumPlace(name: 'Arjun', steps: 31000, rank: 3),
            ],
          ),
        ],
      ),
    );
  }
}

class _PodiumPlace extends StatelessWidget {
  final String name;
  final int steps;
  final int rank;
  final bool isMe;

  const _PodiumPlace({
    required this.name,
    required this.steps,
    required this.rank,
    this.isMe = false,
  });

  @override
  Widget build(BuildContext context) {
    double scale = rank == 1 ? 1.2 : (rank == 2 ? 1.0 : 0.85);

    return Column(
      children: [
        Transform.scale(
          scale: scale,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: rank == 1 ? Colors.orange : Colors.grey.shade400,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                name[0].toUpperCase(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isMe ? AppColors.primary : Colors.grey,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isMe ? 'You' : name,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        Text(
          '${(steps / 1000).toStringAsFixed(1)}k',
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}

class _MemberCard extends ConsumerWidget {
  final FamilyMember member;
  final bool isAdmin;

  const _MemberCard({required this.member, required this.isAdmin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMe = member.isMe;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isMe ? AppColors.primary : Colors.grey.shade200,
          child: Text(
            member.name[0],
            style: TextStyle(color: isMe ? Colors.white : Colors.black87),
          ),
        ),
        title: Text(
          member.isMe ? '${member.name} (Me)' : member.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(member.role == FamilyRole.admin ? 'Family Admin' : 'Member'),
        trailing: isAdmin && !isMe
            ? ElevatedButton(
                onPressed: () => _showMemberSummary(context, ref, member.userId, member.name),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  visualDensity: VisualDensity.compact,
                ),
                child: const Text('View Summary'),
              )
            : member.role == FamilyRole.admin
                ? const Icon(Icons.verified, color: Colors.blue, size: 20)
                : null,
      ),
    );
  }

  void _showMemberSummary(BuildContext context, WidgetRef ref, String userId, String name) async {
    final summary = await ref.read(familyRepositoryProvider.notifier).getMemberSummary(userId);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$name\'s Weekly Summary 📊'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SummaryRow(label: 'Weekly Steps', value: '${summary.weeklySteps}'),
            _SummaryRow(label: 'Step Streak', value: '${summary.currentStepStreak} days'),
            _SummaryRow(label: 'Water Intake', value: '${summary.waterIntakeLiters.toStringAsFixed(1)}L'),
            _SummaryRow(
              label: 'Workouts',
              value: '${summary.workoutsCompleted}',
              color: Colors.green,
            ),
            _SummaryRow(
              label: 'Karma Earned',
              value: '+${summary.karmaXp} XP',
              color: Colors.orange,
            ),
            const SizedBox(height: 12),
            const Text(
              '⚠️ Raw logs and journal entries are private and cannot be viewed.',
              style: TextStyle(fontSize: 10, color: Colors.grey, fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Done')),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const _SummaryRow({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}

class _FamilyChallengesTab extends StatelessWidget {
  final FamilyState state;
  const _FamilyChallengesTab({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.challenges.isEmpty) {
      return const Center(child: Text('No active family challenges. 🧘'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.challenges.length,
      itemBuilder: (context, index) {
        final challenge = state.challenges[index];
        return _ChallengeCard(challenge: challenge);
      },
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  final FamilyChallenge challenge;
  const _ChallengeCard({required this.challenge});

  @override
  Widget build(BuildContext context) {
    final isActive = challenge.isActive;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary.withValues(alpha: 0.1) : Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  challenge.type == FamilyChallengeType.steps
                      ? Icons.directions_walk
                      : Icons.local_drink,
                  color: isActive ? AppColors.primary : Colors.grey,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(challenge.title, style: AppTextStyles.titleMedium),
                      Text(
                        isActive ? 'Active Challenge' : 'Starts Soon',
                        style: TextStyle(
                          fontSize: 10,
                          color: isActive ? AppColors.primary : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${challenge.endDate.difference(DateTime.now()).inDays}d left',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(challenge.description, style: AppTextStyles.bodyMedium),
                const SizedBox(height: 16),
                const Text('Family Progress', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _ChallengeProgressBar(
                  label: 'You',
                  progress: 0.75,
                  color: AppColors.primary,
                ),
                _ChallengeProgressBar(
                  label: 'Mom',
                  progress: 0.55,
                  color: Colors.green,
                ),
                _ChallengeProgressBar(
                  label: 'Arjun',
                  progress: 0.9,
                  color: Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChallengeProgressBar extends StatelessWidget {
  final String label;
  final double progress;
  final Color color;

  const _ChallengeProgressBar({
    required this.label,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 12)),
              Text('${(progress * 100).toInt()}%', style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: color.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    );
  }
}

class _EmptyFamilyState extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.family_restroom, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          const Text('No Family Group Found', style: AppTextStyles.titleLarge),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
            child: Text(
              'Join your family on FitKarma to compete in challenges and track progress together.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _showCreateSheet(context, ref),
            child: const Text('Start a Family Group'),
          ),
        ],
      ),
    );
  }

  void _showCreateSheet(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: 'My Family');
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Family Group Name', style: AppTextStyles.titleMedium),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // In repository, createFamilyGroup is handled during invitation
                  // or we could add a direct create method.
                  ref.read(familyRepositoryProvider.notifier).inviteMember('dummy@example.com');
                  Navigator.pop(context);
                },
                child: const Text('Create & Invite Members'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
