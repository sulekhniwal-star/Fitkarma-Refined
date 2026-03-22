// lib/features/family/presentation/family_challenges_screen.dart
// Family challenges - 7-day step goal, water challenge, screen-free morning

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/family_models.dart';
import '../data/family_providers.dart';

/// Family challenges screen
class FamilyChallengesScreen extends ConsumerWidget {
  final String userId;
  final String userName;
  final String? userEmail;

  const FamilyChallengesScreen({
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
        title: const Text('Family Challenges'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateChallengeDialog(context, ref),
            tooltip: 'Create Challenge',
          ),
        ],
      ),
      body: familyDataAsync.when(
        data: (familyData) {
          if (!familyData.hasFamily) {
            return _buildNoFamilyState(context);
          }

          return _buildChallengesList(context, ref, familyData);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorState(context, error.toString()),
      ),
    );
  }

  Widget _buildNoFamilyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.emoji_events, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'No Family Yet',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Create or join a family to participate in challenges!',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengesList(
    BuildContext context,
    WidgetRef ref,
    FamilyData familyData,
  ) {
    final challenges = familyData.challenges;

    if (challenges.isEmpty) {
      return _buildEmptyState(context);
    }

    // Group challenges by status
    final activeChallenges = challenges
        .where((c) => c.status == FamilyChallengeStatus.active)
        .toList();
    final upcomingChallenges = challenges
        .where((c) => c.status == FamilyChallengeStatus.upcoming)
        .toList();
    final completedChallenges = challenges
        .where((c) => c.status == FamilyChallengeStatus.completed)
        .toList();

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(familyDataProvider(userId));
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Quick create buttons
          _buildQuickCreateButtons(context),
          const SizedBox(height: 24),

          // Active challenges
          if (activeChallenges.isNotEmpty) ...[
            _buildSectionHeader(context, 'Active Challenges', Colors.green),
            const SizedBox(height: 8),
            ...activeChallenges.map(
              (c) => _buildChallengeCard(context, ref, c, familyData),
            ),
            const SizedBox(height: 16),
          ],

          // Upcoming challenges
          if (upcomingChallenges.isNotEmpty) ...[
            _buildSectionHeader(context, 'Upcoming', Colors.blue),
            const SizedBox(height: 8),
            ...upcomingChallenges.map(
              (c) => _buildChallengeCard(context, ref, c, familyData),
            ),
            const SizedBox(height: 16),
          ],

          // Completed challenges
          if (completedChallenges.isNotEmpty) ...[
            _buildSectionHeader(context, 'Completed', Colors.grey),
            const SizedBox(height: 8),
            ...completedChallenges.map(
              (c) => _buildChallengeCard(context, ref, c, familyData),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.emoji_events_outlined,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'No Challenges Yet',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Create a challenge to compete with your family members!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _showCreateChallengeDialog(context, null),
              icon: const Icon(Icons.add),
              label: const Text('Create Challenge'),
            ),
            const SizedBox(height: 16),
            // Quick create buttons
            _buildQuickCreateButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickCreateButtons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Create',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildQuickButton(
                context,
                icon: Icons.directions_walk,
                label: '7-Day Steps',
                color: Colors.green,
                onTap: () => _quickCreateChallenge(
                  context,
                  FamilyChallengeType.steps7Day,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildQuickButton(
                context,
                icon: Icons.water_drop,
                label: 'Water',
                color: Colors.blue,
                onTap: () => _quickCreateChallenge(
                  context,
                  FamilyChallengeType.waterChallenge,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildQuickButton(
                context,
                icon: Icons.phone_android,
                label: 'Screen-Free',
                color: Colors.purple,
                onTap: () => _quickCreateChallenge(
                  context,
                  FamilyChallengeType.screenFreeMorning,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, Color color) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildChallengeCard(
    BuildContext context,
    WidgetRef ref,
    FamilyChallenge challenge,
    FamilyData familyData,
  ) {
    final isAdmin = familyData.family?.adminId == userId;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showChallengeDetails(context, ref, challenge),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: _getChallengeColor(challenge.type),
                    child: Icon(
                      _getChallengeIcon(challenge.type),
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          challenge.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          _getChallengeDescription(challenge.type),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusChip(challenge.status),
                ],
              ),
              const SizedBox(height: 12),

              // Progress
              if (challenge.isJoinedByMe &&
                  challenge.status == FamilyChallengeStatus.active) ...[
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: challenge.progressPercent,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation(
                          _getChallengeColor(challenge.type),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${(challenge.progressPercent * 100).toInt()}%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _getChallengeColor(challenge.type),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${challenge.myProgress ?? 0} / ${challenge.myTargetValue ?? challenge.targetValue} ${challenge.targetUnit}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],

              // Dates
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 14, color: Colors.grey[400]),
                  const SizedBox(width: 4),
                  Text(
                    '${_formatDate(challenge.startDate)} - ${_formatDate(challenge.endDate)}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const Spacer(),
                  Icon(Icons.group, size: 14, color: Colors.grey[400]),
                  const SizedBox(width: 4),
                  Text(
                    '${challenge.participantsCount} joined',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),

              // Action button
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: challenge.isJoinedByMe
                    ? OutlinedButton(
                        onPressed: () =>
                            _showChallengeDetails(context, ref, challenge),
                        child: const Text('View Details'),
                      )
                    : challenge.status == FamilyChallengeStatus.active
                    ? ElevatedButton(
                        onPressed: () =>
                            _joinChallenge(context, ref, challenge),
                        child: const Text('Join Challenge'),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(FamilyChallengeStatus status) {
    Color color;
    String text;

    switch (status) {
      case FamilyChallengeStatus.active:
        color = Colors.green;
        text = 'Active';
        break;
      case FamilyChallengeStatus.upcoming:
        color = Colors.blue;
        text = 'Upcoming';
        break;
      case FamilyChallengeStatus.completed:
        color = Colors.grey;
        text = 'Completed';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }

  void _showCreateChallengeDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Challenge'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select challenge type:'),
            const SizedBox(height: 16),
            _buildChallengeTypeOption(
              context,
              type: FamilyChallengeType.steps7Day,
              icon: Icons.directions_walk,
              label: '7-Day Step Goal',
              color: Colors.green,
            ),
            _buildChallengeTypeOption(
              context,
              type: FamilyChallengeType.waterChallenge,
              icon: Icons.water_drop,
              label: 'Water Challenge',
              color: Colors.blue,
            ),
            _buildChallengeTypeOption(
              context,
              type: FamilyChallengeType.screenFreeMorning,
              icon: Icons.phone_android,
              label: 'Screen-Free Morning',
              color: Colors.purple,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeTypeOption(
    BuildContext context, {
    required FamilyChallengeType type,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(label),
      onTap: () {
        Navigator.pop(context);
        _quickCreateChallenge(context, type);
      },
    );
  }

  void _quickCreateChallenge(
    BuildContext context,
    FamilyChallengeType type,
  ) async {
    String title;
    String description;
    int targetValue;
    String targetUnit;

    switch (type) {
      case FamilyChallengeType.steps7Day:
        title = '7-Day Step Challenge';
        description = 'Walk 10,000 steps every day for 7 days';
        targetValue = 70000;
        targetUnit = 'total steps';
        break;
      case FamilyChallengeType.waterChallenge:
        title = 'Water Challenge';
        description = 'Drink 8 glasses of water daily for 7 days';
        targetValue = 56;
        targetUnit = 'glasses';
        break;
      case FamilyChallengeType.screenFreeMorning:
        title = 'Screen-Free Morning';
        description = 'No screen time before 10 AM for 7 days';
        targetValue = 7;
        targetUnit = 'days';
        break;
      default:
        return;
    }

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final service = ref.read(familyAwServiceProvider);
      final familyData = ref.read(familyDataProvider(userId));

      String? familyId;
      familyData.whenData((data) {
        familyId = data.family?.id;
      });

      if (familyId == null) {
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('No family found')));
        return;
      }

      final now = DateTime.now();
      final startDate = now;
      final endDate = now.add(const Duration(days: 7));

      await service.createChallenge(
        familyId: familyId!,
        title: title,
        description: description,
        type: type,
        targetValue: targetValue,
        targetUnit: targetUnit,
        startDate: startDate,
        endDate: endDate,
        createdBy: userId,
        createdByName: userName,
      );

      Navigator.pop(context);
      ref.invalidate(familyDataProvider(userId));

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$title created!')));
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void _joinChallenge(
    BuildContext context,
    WidgetRef ref,
    FamilyChallenge challenge,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final service = ref.read(familyAwServiceProvider);

      await service.joinChallenge(
        challengeId: challenge.id,
        familyId: challenge.familyId,
        userId: userId,
        userName: userName,
        targetValue: challenge.targetValue,
      );

      Navigator.pop(context);
      ref.invalidate(familyDataProvider(userId));

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Joined challenge!')));
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void _showChallengeDetails(
    BuildContext context,
    WidgetRef ref,
    FamilyChallenge challenge,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => _buildChallengeDetailsSheet(
          context,
          ref,
          challenge,
          scrollController,
        ),
      ),
    );
  }

  Widget _buildChallengeDetailsSheet(
    BuildContext context,
    WidgetRef ref,
    FamilyChallenge challenge,
    ScrollController scrollController,
  ) {
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(24),
      children: [
        // Handle
        Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Header
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: _getChallengeColor(challenge.type),
              child: Icon(
                _getChallengeIcon(challenge.type),
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    challenge.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'by ${challenge.createdByName}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Description
        Text(challenge.description, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 24),

        // Stats
        Row(
          children: [
            Expanded(
              child: _buildStatBox(
                icon: Icons.flag,
                label: 'Target',
                value: '${challenge.targetValue}',
                unit: challenge.targetUnit,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatBox(
                icon: Icons.people,
                label: 'Participants',
                value: '${challenge.participantsCount}',
                unit: 'joined',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatBox(
                icon: Icons.calendar_today,
                label: 'Start',
                value: _formatDate(challenge.startDate),
                unit: '',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatBox(
                icon: Icons.event,
                label: 'End',
                value: _formatDate(challenge.endDate),
                unit: '',
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Progress (if joined)
        if (challenge.isJoinedByMe) ...[
          const Text(
            'Your Progress',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: challenge.progressPercent,
            minHeight: 12,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(
              _getChallengeColor(challenge.type),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${challenge.myProgress ?? 0} / ${challenge.myTargetValue ?? challenge.targetValue} ${challenge.targetUnit}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ],
    );
  }

  Widget _buildStatBox({
    required IconData icon,
    required String label,
    required String value,
    required String unit,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.grey[600]),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            unit.isNotEmpty ? '$label ($unit)' : label,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
    );
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

  String _getChallengeDescription(FamilyChallengeType type) {
    switch (type) {
      case FamilyChallengeType.steps7Day:
        return 'Walk 10,000 steps daily for 7 days';
      case FamilyChallengeType.waterChallenge:
        return 'Drink 8 glasses of water daily';
      case FamilyChallengeType.screenFreeMorning:
        return 'No screen time before 10 AM';
      case FamilyChallengeType.combined:
        return 'Multiple goals combined';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}';
  }
}
