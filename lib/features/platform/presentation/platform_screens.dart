import 'package:flutter/material.dart';

class EmergencyCardScreen extends StatelessWidget {
  const EmergencyCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Health Card'),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Column(
                children: [
                  const Icon(Icons.emergency, color: Colors.red, size: 48),
                  const SizedBox(height: 8),
                  const Text('EMERGENCY HEALTH CARD', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 16),
                  _InfoRow(label: 'Name', value: 'User Name'),
                  _InfoRow(label: 'Blood Group', value: 'B+'),
                  _InfoRow(label: 'Date of Birth', value: '15/03/1990'),
                  _InfoRow(label: 'Allergies', value: 'Penicillin'),
                  _InfoRow(label: 'Conditions', value: 'None'),
                  _InfoRow(label: 'Medications', value: 'None'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.phone, color: Colors.green),
                        const SizedBox(width: 8),
                        const Text('Emergency Contact', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(),
                    _InfoRow(label: 'Name', value: 'John Doe'),
                    _InfoRow(label: 'Relation', value: 'Spouse'),
                    _InfoRow(label: 'Phone', value: '+91 98765 43210'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.local_hospital),
                        const SizedBox(width: 8),
                        const Text('Primary Doctor', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(),
                    _InfoRow(label: 'Name', value: 'Dr. Sharma'),
                    _InfoRow(label: 'Hospital', value: 'City Hospital'),
                    _InfoRow(label: 'Phone', value: '+91 12345 67890'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class HealthReportsScreen extends StatelessWidget {
  const HealthReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Reports'),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
              title: const Text('Monthly Health Report'),
              subtitle: const Text('March 2026'),
              trailing: const Icon(Icons.download),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
              title: const Text('Lab Report'),
              subtitle: const Text('Blood Test - 15 Feb 2026'),
              trailing: const Icon(Icons.download),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 24),
          Text('Share with Doctor', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Generate a time-limited link to share your health summary with your doctor.'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.link),
                          label: const Text('Generate Link'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Link expires in 7 days · No login required for doctor', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PersonalRecordsScreen extends StatelessWidget {
  const PersonalRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Records')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Workout PRs', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _PRRow(exercise: 'Bench Press', weight: '75 kg', reps: '5', date: '2 days ago'),
                  _PRRow(exercise: 'Squat', weight: '100 kg', reps: '3', date: '1 week ago'),
                  _PRRow(exercise: 'Deadlift', weight: '120 kg', reps: '2', date: '2 weeks ago'),
                  _PRRow(exercise: 'Pull-ups', weight: '-', reps: '15', date: '5 days ago'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Cardio Records', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _PRRow(exercise: '5K Run', weight: '28:30', reps: 'min', date: '1 week ago'),
                  _PRRow(exercise: '10K Run', weight: '1:02:15', reps: 'min', date: '3 weeks ago'),
                  _PRRow(exercise: 'Longest Run', weight: '15 km', reps: '-', date: '1 month ago'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PRRow extends StatelessWidget {
  final String exercise;
  final String weight;
  final String reps;
  final String date;

  const _PRRow({required this.exercise, required this.weight, required this.reps, required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.emoji_events, color: Colors.amber),
          const SizedBox(width: 12),
          Expanded(child: Text(exercise, style: const TextStyle(fontWeight: FontWeight.w500))),
          Text(weight),
          const SizedBox(width: 8),
          Text(reps, style: const TextStyle(color: Colors.grey)),
          const SizedBox(width: 8),
          Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}