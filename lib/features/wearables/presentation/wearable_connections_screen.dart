import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/network/appwrite_client.dart';
import '../../../shared/theme/app_colors.dart';

class WearableConnectionsScreen extends ConsumerStatefulWidget {
  const WearableConnectionsScreen({super.key});

  @override
  ConsumerState<WearableConnectionsScreen> createState() => _WearableConnectionsScreenState();
}

class _WearableConnectionsScreenState extends ConsumerState<WearableConnectionsScreen> {
  final _storage = const FlutterSecureStorage();
  bool _isHealthConnectLinked = false;
  bool _isFitbitLinked = false;
  bool _isGarminLinked = false;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    final fitbitToken = await _storage.read(key: 'fitbit_token');
    final garminToken = await _storage.read(key: 'garmin_token');
    setState(() {
      _isFitbitLinked = fitbitToken != null;
      _isGarminLinked = garminToken != null;
    });
  }

  Future<void> _linkFitbit() async {
    // Show loading
    try {
      final functions = AppwriteClient.functions;
      final response = await functions.createExecution(
        functionId: 'core-engine',
        body: '{"action": "fitbit-token-exchange"}',
      );
      // Simulating successful OAuth flow callback
      await _storage.write(key: 'fitbit_token', value: 'mock_token');
      _checkStatus();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wearable Connections'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildConnectionCard(
            name: 'Health Connect',
            icon: Icons.health_and_safety,
            description: 'Android centralized health data',
            isLinked: _isHealthConnectLinked,
            color: Colors.blue,
            onToggle: () => setState(() => _isHealthConnectLinked = !_isHealthConnectLinked),
          ),
          _buildConnectionCard(
            name: 'Fitbit',
            icon: Icons.watch,
            description: 'Steps, Sleep & Heart Rate',
            isLinked: _isFitbitLinked,
            color: Colors.teal,
            onToggle: _isFitbitLinked ? () async {
              await _storage.delete(key: 'fitbit_token');
              _checkStatus();
             } : _linkFitbit,
          ),
          _buildConnectionCard(
            name: 'Garmin',
            icon: Icons.directions_run,
            description: 'High-performance sports data',
            isLinked: _isGarminLinked,
            color: Colors.black87,
            onToggle: () {},
          ),
          _buildConnectionCard(
            name: 'Apple HealthKit',
            icon: Icons.favorite,
            description: 'iOS centralized health data',
            isLinked: false,
            color: Colors.pink,
            onToggle: null, // Disabled on Android
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionCard({
    required String name,
    required IconData icon,
    required String description,
    required bool isLinked,
    required Color color,
    required VoidCallback? onToggle,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  if (isLinked)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Last synced: Today',
                        style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            if (onToggle != null)
              OutlinedButton(
                onPressed: onToggle,
                style: OutlinedButton.styleFrom(
                  foregroundColor: isLinked ? Colors.red : Colors.blue,
                  side: BorderSide(color: isLinked ? Colors.red : Colors.blue),
                ),
                child: Text(isLinked ? 'DISCONNECT' : 'CONNECT'),
              ),
          ],
        ),
      ),
    );
  }
}
