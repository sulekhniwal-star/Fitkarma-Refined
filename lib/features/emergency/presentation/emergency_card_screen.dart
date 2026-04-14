import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import '../../auth/domain/auth_providers.dart';
import '../../../core/storage/drift_service.dart';
import '../../../core/storage/app_database.dart';

class EmergencyCardScreen extends ConsumerWidget {
  const EmergencyCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authStateProvider).value?.id;
    final cardFuture = userId != null 
        ? (DriftService.db.select(DriftService.db.emergencyCards)..where((t) => t.userId.equals(userId))).getSingleOrNull()
        : Future.value(null);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Emergency Health Card', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: () => _showQRDialog(context),
          ),
        ],
      ),
      body: FutureBuilder<EmergencyCard?>(
        future: cardFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final card = snapshot.data;
          if (card == null) return _buildEmptyState();
          return _buildCardContent(context, card);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.contact_emergency_outlined, size: 80, color: Colors.grey),
            SizedBox(height: 20),
            Text('No Emergency Data', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text('Please set up your emergency medical information in Profile Settings.', textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildCardContent(BuildContext context, EmergencyCard card) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIdentityHeader(card),
          const SizedBox(height: 24),
          _buildClinicalSection(card),
          const SizedBox(height: 24),
          _buildMedicineSection(),
          const SizedBox(height: 24),
          _buildContactSection(card),
          const SizedBox(height: 24),
          _buildInsuranceSection(card),
          const SizedBox(height: 48),
          const Center(
            child: Text(
              'IN CASE OF EMERGENCY: PRESS CALL BUTTONS ABOVE',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildIdentityHeader(EmergencyCard card) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(card.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const Text('Legal Name', style: TextStyle(color: Colors.grey)),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              Text(card.bloodGroup, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const Text('BLOOD', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClinicalSection(EmergencyCard card) {
    final allergies = card.allergies != null ? (jsonDecode(card.allergies!) as List).cast<String>() : <String>[];
    final conditions = card.chronicConditions != null ? (jsonDecode(card.chronicConditions!) as List).cast<String>() : <String>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('CLINICAL INFO', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        const Divider(),
        const SizedBox(height: 8),
        _buildPillGrid('Allergies', allergies, Colors.red),
        const SizedBox(height: 16),
        _buildPillGrid('Chronic Conditions', conditions, Colors.amber.shade800),
      ],
    );
  }

  Widget _buildPillGrid(String title, List<String> items, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        if (items.isEmpty) const Text('None reported', style: TextStyle(color: Colors.grey, fontSize: 13)),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((i) => Chip(
            label: Text(i, style: const TextStyle(color: Colors.white, fontSize: 12)),
            backgroundColor: color,
            padding: EdgeInsets.zero,
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildMedicineSection() {
    // In real app, pull from db.medications
    final mockMeds = ['Metformin 500mg', 'Atorvastatin 10mg'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('CURRENT MEDICATIONS', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        const Divider(),
        const SizedBox(height: 8),
        ...mockMeds.map((m) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              const Icon(Icons.medication, size: 16, color: Colors.blue),
              const SizedBox(width: 8),
              Text(m, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildContactSection(EmergencyCard card) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('CONTACTS', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        const Divider(),
        _buildContactRow('Emergency Contact', card.emergencyContactName, card.emergencyContactPhone, Colors.green),
        if (card.doctorName != null) 
          _buildContactRow('Attending Doctor', card.doctorName!, card.doctorPhone!, Colors.blue),
      ],
    );
  }

  Widget _buildContactRow(String label, String name, String phone, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          IconButton(
            onPressed: () => launchUrl(Uri.parse('tel:$phone')),
            icon: Icon(Icons.phone, color: color),
            style: IconButton.styleFrom(backgroundColor: color.withOpacity(0.1)),
          ),
        ],
      ),
    );
  }

  Widget _buildInsuranceSection(EmergencyCard card) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('INSURANCE', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        const Divider(),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Policy Number'),
            Text(card.insurancePolicy ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  void _showQRDialog(BuildContext context) {
    // In real app, serialize card to JSON
    const qrData = '{"name": "Arjun Mehta", "blood": "B+", "allergies": ["Peanuts"], "emergency": "+91 9876543210"}';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Medical Staff Scan'),
        content: SizedBox(
          width: 200,
          height: 200,
          child: QrImageView(
            data: qrData,
            version: QrVersions.auto,
            size: 200.0,
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }
}
