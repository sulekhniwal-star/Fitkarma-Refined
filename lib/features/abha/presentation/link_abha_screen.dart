import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/features/abha/data/abha_oauth_service.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final abhaLinkProvider = FutureProvider.family<AbhaLink?, String>((ref, userId) async {
  final db = ref.read(appDatabaseProvider);
  return db.abhaLinksDao.getLinkForUser(userId);
});

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class LinkAbhaScreen extends ConsumerStatefulWidget {
  final String userId;

  const LinkAbhaScreen({super.key, required this.userId});

  @override
  ConsumerState<LinkAbhaScreen> createState() => _LinkAbhaScreenState();
}

class _LinkAbhaScreenState extends ConsumerState<LinkAbhaScreen> {
  bool _isLoading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Link ABHA'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    final abhaAsync = ref.watch(abhaLinkProvider(widget.userId));

    return abhaAsync.when(
      data: (abhaLink) {
        if (abhaLink != null && abhaLink.isVerified) {
          return _buildLinkedProfile(abhaLink);
        }
        return _buildLinkPrompt();
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => _buildLinkPrompt(),
    );
  }

  Widget _buildLinkPrompt() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.favorite_border, size: 64, color: AppColors.primary),
          ),
          const SizedBox(height: 24),
          const Text(
            'Link Your ABHA',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Connect your Ayushman Bharat Health Account to access verified prescriptions and healthcare records.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 16),
          _buildFeatureRow(Icons.verified_user, 'Verified by NHA'),
          _buildFeatureRow(Icons.security, 'Secure OAuth2 connection'),
          _buildFeatureRow(Icons.medical_services, 'Access prescriptions'),
          const SizedBox(height: 32),
          if (_error != null) ...[
            Text(_error!, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
            const SizedBox(height: 16),
          ],
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _startAbhaLink,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Link ABHA ID', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 12),
          Text(text, style: TextStyle(color: Colors.grey.shade700)),
        ],
      ),
    );
  }

  Widget _buildLinkedProfile(AbhaLink abhaLink) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Text('ABHA Linked', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.lightSurface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                      child: Text(
                        '${abhaLink.firstName?[0] ?? ''}${abhaLink.lastName?[0] ?? ''}'.toUpperCase(),
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${abhaLink.firstName ?? ''} ${abhaLink.lastName ?? ''}'.trim(),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'ABHA-${abhaLink.abhaNumber}',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 32),
                _buildProfileRow('Date of Birth', abhaLink.dateOfBirth?.toString().split(' ')[0] ?? 'N/A'),
                _buildProfileRow('Gender', abhaLink.gender?.toUpperCase() ?? 'N/A'),
                _buildProfileRow('State', abhaLink.stateCode ?? 'N/A'),
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => context.push('/abha/prescriptions/${widget.userId}'),
                  icon: const Icon(Icons.description),
                  label: const Text('Prescriptions'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _syncAbhaRecords,
                  icon: const Icon(Icons.sync),
                  label: const Text('Sync'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: _confirmUnlink,
            icon: const Icon(Icons.link_off, color: Colors.red),
            label: const Text('Unlink ABHA', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Future<void> _startAbhaLink() async {
    setState(() => _isLoading = true);
    
    try {
      final oauthService = AbhaOAuthService.instance;
      final authUrl = await oauthService.buildAuthUrl();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Auth URL: ${authUrl.url}')),
        );
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  Future<void> _syncAbhaRecords() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Syncing ABHA records...')),
    );
  }

  Future<void> _confirmUnlink() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unlink ABHA?'),
        content: const Text('This will remove your ABHA link and all cached data from this device. You can link again anytime.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Unlink', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    
    if (confirm == true && mounted) {
      await AbhaOAuthService.instance.unlinkAbha(widget.userId);
      ref.invalidate(abhaLinkProvider(widget.userId));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ABHA unlinked')),
        );
      }
    }
  }
}