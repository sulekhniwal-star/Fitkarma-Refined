import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class HerbalRemediesScreen extends ConsumerWidget {
  const HerbalRemediesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Herbal Remedies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async => await db.herbalRemediesDao.seedDefaultRemedies(),
          ),
        ],
      ),
      body: FutureBuilder(
        future: db.herbalRemediesDao.getAllRemedies(),
        builder: (context, snapshot) {
          final remedies = snapshot.data ?? [];
          if (remedies.isEmpty) {
            return const Center(child: Text('No remedies loaded'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: remedies.length,
            itemBuilder: (context, index) {
              final r = remedies[index];
              return _RemedyCard(remedy: r);
            },
          );
        },
      ),
    );
  }
}

class _RemedyCard extends StatelessWidget {
  final HerbalRemedy remedy;

  const _RemedyCard({required this.remedy});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getCategoryColor(remedy.category ?? '').withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.eco, color: _getCategoryColor(remedy.category ?? '')),
        ),
        title: Text(remedy.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(remedy.sanskritName ?? '', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey.shade600)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (remedy.benefitsJson != null) ...[
                  const Text('Benefits:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(remedy.benefitsJson!),
                  const SizedBox(height: 8),
                ],
                if (remedy.dosage != null) ...[
                  const Text('Dosage:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(remedy.dosage!),
                  const SizedBox(height: 8),
                ],
                if (remedy.evidence != null) ...[
                  const Text('Evidence:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(remedy.evidence!, style: TextStyle(color: Colors.grey.shade700)),
                  const SizedBox(height: 8),
                ],
                if (remedy.precautions != null) ...[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.warning, color: Colors.red, size: 20),
                        const SizedBox(width: 8),
                        Expanded(child: Text(remedy.precautions!, style: const TextStyle(color: Colors.red))),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Adaptogen': return Colors.green;
      case 'Anti-inflammatory': return Colors.orange;
      case 'Nootropic': return Colors.blue;
      case 'Digestive': return Colors.purple;
      case 'Reproductive': return Colors.pink;
      default: return Colors.grey;
    }
  }
}