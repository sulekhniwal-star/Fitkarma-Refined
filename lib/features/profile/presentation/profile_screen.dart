import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../shared/widgets/abha_link_badge.dart';
import '../../auth/domain/auth_providers.dart';
// For level card if needed

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String? _imagePath;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _imagePath = image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateProvider).value;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHero(user),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   _buildKarmaLevelCard(),
                   const SizedBox(height: 24),
                   _buildDoshaMiniCard(),
                   const SizedBox(height: 24),
                   _buildPersonalInfo(user),
                   const SizedBox(height: 32),
                   const ABHALinkBadge(isLinked: true, isLarge: false),
                   const SizedBox(height: 32),
                   _buildAchievementsSection(),
                   const SizedBox(height: 32),
                   _buildReferralCard(context),
                   const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(dynamic user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
      decoration: BoxDecoration(
        color: Colors.indigo.shade900,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white24,
              backgroundImage: _imagePath != null ? FileImage(File(_imagePath!)) : null,
              child: _imagePath == null ? const Icon(Icons.camera_alt, color: Colors.white) : null,
            ),
          ),
          const SizedBox(height: 16),
          Text(user?.name ?? 'Arjun Mehta', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          Text(user?.email ?? 'arjun@example.com', style: TextStyle(color: Colors.white.withOpacity(0.7))),
        ],
      ),
    );
  }

  Widget _buildKarmaLevelCard() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.workspace_premium, color: Colors.amber, size: 32),
        title: const Text('Level 14: Warrior', style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text('Next level: 450 XP required'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push('/karma'),
      ),
    );
  }

  Widget _buildDoshaMiniCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.spa, color: Colors.teal),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text('Pitta Dominant', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Metabolism is strong today.', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            SizedBox(height: 40, width: 40, child: Icon(Icons.donut_large, color: Colors.teal.shade200)),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfo(dynamic user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Personal Info', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 16),
        _buildInfoRow(Icons.phone, 'Phone', '+91 98765 43210'),
        _buildInfoRow(Icons.cake, 'Date of Birth', '12 Jan 1992'),
        _buildInfoRow(Icons.height, 'Height', '178 cm'),
        _buildInfoRow(Icons.monitor_weight, 'Weight', '74 kg'),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
           Icon(icon, size: 20, color: Colors.grey),
           const SizedBox(width: 16),
           Expanded(child: Text(label, style: const TextStyle(color: Colors.grey))),
           Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
           const SizedBox(width: 8),
           const Icon(Icons.edit, size: 14, color: Colors.blue),
        ],
      ),
    );
  }

  Widget _buildAchievementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Achievements', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 16, crossAxisSpacing: 16),
          itemCount: 8,
          itemBuilder: (context, index) => _buildAchievementIcon(index),
        ),
      ],
    );
  }

  Widget _buildAchievementIcon(int index) {
    final earned = index < 3;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: earned ? Colors.amber.shade100 : Colors.grey.shade100, shape: BoxShape.circle),
          child: Icon(Icons.emoji_events, color: earned ? Colors.amber : Colors.grey.shade400, size: 24),
        ),
      ],
    );
  }

  Widget _buildReferralCard(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      child: ListTile(
        title: const Text('Invite Friends', style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text('Earn 500 XP for every successful join.'),
        trailing: const Icon(Icons.share, color: Colors.blue),
        onTap: () => context.push('/referral'),
      ),
    );
  }
}
