// lib/features/family/presentation/family_home_screen.dart
// Family home screen - main entry point for family features

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/family_models.dart';
import '../data/family_providers.dart';

/// Family home screen
class FamilyHomeScreen extends ConsumerWidget {
  final String userId;
  final String userName;
  final String? userEmail;

  const FamilyHomeScreen({
    super.key,
    required this.userId,
    required this.userName,
    this.userEmail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyDataAsync = ref.watch(familyDataProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Family'),
        actions: [
          IconButton(
            icon: const Icon(Icons.leaderboard),
            onPressed: () => context.push('/family/leaderboard'),
            tooltip: 'Leaderboard',
          ),
          IconButton(
            icon: const Icon(Icons.emoji_events),
            onPressed: () => context.push('/family/challenges'),
            tooltip: 'Challenges',
          ),
        ],
      ),
      body: familyDataAsync.when(
        data: (familyData) {
          if (familyData.error != null) {
            return _buildErrorState(context, familyData.error!);
          }

          if (!familyData.hasFamily) {
            return _buildNoFamilyState(context);
          }

          return _buildFamilyContent(context, ref, familyData);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorState(context, error.toString()),
      ),
    );
  }

  Widget _buildNoFamilyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.family_restroom, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Start Your Family Journey',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Create a family group to track progress together, compete in challenges, and stay motivated!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _showCreateFamilyDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Create Family'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => _showJoinFamilyDialog(context),
              icon: const Icon(Icons.group_add),
              label: const Text('Join Existing Family'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFamilyContent(
    BuildContext context,
    WidgetRef ref,
    FamilyData familyData,
  ) {
    final family = familyData.family!;
    final isAdmin = family.adminId == userId;

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(familyDataProvider(userId));
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Family header card
          _buildFamilyHeaderCard(context, family),
          const SizedBox(height: 16),

          // Quick stats row
          _buildQuickStatsRow(context, familyData),
          const SizedBox(height: 24),

          // Admin section - Invite members
          if (isAdmin && family.canInviteMore) ...[
            _buildInviteSection(context, ref, family),
            const SizedBox(height: 24),
          ],

          // Members section
          _buildMembersSection(context, ref, familyData),
          const SizedBox(height: 24),

          // Active challenges preview
          if (familyData.challenges.isNotEmpty) ...[
            _buildChallengesPreview(context, familyData.challenges),
          ],
        ],
      ),
    );
  }

  Widget _buildFamilyHeaderCard(BuildContext context, Family family) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    family.name.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        family.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${family.membersCount} / ${family.maxMembers} members',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                if (family.isFamilyPlan)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'FAMILY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStatsRow(BuildContext context, FamilyData familyData) {
    final activeChallenges = familyData.challenges
        .where((c) => c.status == FamilyChallengeStatus.active)
        .length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.group,
            label: 'Members',
            value: '${familyData.members.length}',
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.emoji_events,
            label: 'Active',
            value: '$activeChallenges',
            color: Colors.orange,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.calendar_today,
            label: 'Days',
            value: '${_getDaysSinceCreation(familyData.family!.createdAt)}',
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInviteSection(
    BuildContext context,
    WidgetRef ref,
    Family family,
  ) {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person_add, color: Colors.blue),
                const SizedBox(width: 8),
                const Text(
                  'Invite Members',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Invite up to ${family.maxMembers - family.membersCount} more members to your family group.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showInviteDialog(context, ref, family),
                icon: const Icon(Icons.mail),
                label: const Text('Send Invitation'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMembersSection(
    BuildContext context,
    WidgetRef ref,
    FamilyData familyData,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Family Members',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...familyData.members.map(
          (member) => _buildMemberCard(context, member),
        ),
      ],
    );
  }

  Widget _buildMemberCard(BuildContext context, FamilyMember member) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: member.isAdmin ? Colors.purple : Colors.grey,
          child: Text(
            member.userName.substring(0, 1).toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Row(
          children: [
            Text(member.userName),
            if (member.isAdmin) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Admin',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: member.weeklySteps != null
            ? Text(
                '${_formatNumber(member.weeklySteps!)} steps this week',
                style: TextStyle(color: Colors.grey[600]),
              )
            : null,
        trailing: member.currentStreak != null && member.currentStreak! > 0
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.local_fire_department, color: Colors.orange),
                  Text(
                    '${member.currentStreak}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              )
            : null,
      ),
    );
  }

  Widget _buildChallengesPreview(
    BuildContext context,
    List<FamilyChallenge> challenges,
  ) {
    final activeChallenges = challenges
        .where((c) => c.status == FamilyChallengeStatus.active)
        .take(2)
        .toList();

    if (activeChallenges.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Active Challenges',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => context.push('/family/challenges'),
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...activeChallenges.map(
          (challenge) => _buildChallengeCard(context, challenge),
        ),
      ],
    );
  }

  Widget _buildChallengeCard(BuildContext context, FamilyChallenge challenge) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getChallengeColor(challenge.type),
          child: Icon(_getChallengeIcon(challenge.type), color: Colors.white),
        ),
        title: Text(challenge.title),
        subtitle: LinearProgressIndicator(
          value: challenge.progressPercent,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation(
            _getChallengeColor(challenge.type),
          ),
        ),
        trailing: Text(
          '${(challenge.progressPercent * 100).toInt()}%',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _getChallengeColor(challenge.type),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text('Error: $error'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Refresh
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _showCreateFamilyDialog(BuildContext context) {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Family'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Family Name',
                hintText: 'e.g., The Johnsons',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Free plan: Up to 2 members\nFamily plan: Up to 5 members',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _createFamily(context, nameController.text);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _createFamily(BuildContext context, String familyName) async {
    if (familyName.isEmpty) return;

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final service = ref.read(familyAwServiceProvider);
      await service.createFamily(
        adminId: userId,
        adminName: userName,
        familyName: familyName,
        plan: SubscriptionPlan.free,
      );

      Navigator.pop(context); // Close loading
      ref.invalidate(familyDataProvider(userId));

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Family "$familyName" created!')));
    } catch (e) {
      Navigator.pop(context); // Close loading
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void _showJoinFamilyDialog(BuildContext context) {
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Join Family'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter your email to check for pending invitations:'),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Your Email',
                hintText: 'email@example.com',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _checkInvitations(context, emailController.text);
            },
            child: const Text('Check'),
          ),
        ],
      ),
    );
  }

  void _checkInvitations(BuildContext context, String email) async {
    if (email.isEmpty) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final service = ref.read(familyAwServiceProvider);
      final invitations = await service.getPendingInvitations(email);

      Navigator.pop(context);

      if (invitations.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No pending invitations found')),
        );
      } else {
        _showInvitationsList(context, invitations);
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void _showInvitationsList(
    BuildContext context,
    List<FamilyInvitation> invitations,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pending Invitations'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: invitations.length,
            itemBuilder: (context, index) {
              final inv = invitations[index];
              return ListTile(
                title: Text(inv.familyName),
                subtitle: Text('From: ${inv.inviterName}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () {
                        Navigator.pop(context);
                        _acceptInvitation(context, inv);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _acceptInvitation(
    BuildContext context,
    FamilyInvitation invitation,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final service = ref.read(familyAwServiceProvider);
      await service.acceptInvitation(
        invitationId: invitation.id,
        familyId: invitation.familyId,
        userId: userId,
        userName: userName,
        userEmail: userEmail,
      );

      Navigator.pop(context);
      ref.invalidate(familyDataProvider(userId));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Joined ${invitation.familyName}!')),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void _showInviteDialog(BuildContext context, WidgetRef ref, Family family) {
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invite Family Member'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Send an invitation to join your family group:',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                hintText: 'family@example.com',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _sendInvitation(context, ref, family, emailController.text);
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  void _sendInvitation(
    BuildContext context,
    WidgetRef ref,
    Family family,
    String email,
  ) async {
    if (email.isEmpty) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final service = ref.read(familyAwServiceProvider);
      await service.sendInvitation(
        familyId: family.id,
        familyName: family.name,
        inviterId: userId,
        inviterName: userName,
        inviteeEmail: email,
      );

      Navigator.pop(context);
      ref.invalidate(familyDataProvider(userId));

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invitation sent!')));
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  int _getDaysSinceCreation(DateTime createdAt) {
    return DateTime.now().difference(createdAt).inDays;
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }

  Color _getChallengeColor(FamilyChallengeType type) {
    switch (type) {
      case FamilyChallengeType.steps7Day:
        return Colors.green;
      case FamilyChallengeType.waterChallenge:
        return Colors.blue;
      case FamilyChallengeType.screenFreeMorning:
        return Colors.purple;
      case FamilyChallengeType.combined:
        return Colors.orange;
    }
  }

  IconData _getChallengeIcon(FamilyChallengeType type) {
    switch (type) {
      case FamilyChallengeType.steps7Day:
        return Icons.directions_walk;
      case FamilyChallengeType.waterChallenge:
        return Icons.water_drop;
      case FamilyChallengeType.screenFreeMorning:
        return Icons.phone_android;
      case FamilyChallengeType.combined:
        return Icons.emoji_events;
    }
  }
}
