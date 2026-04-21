import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/storage/drift_service.dart';
import '../../../core/storage/app_database.dart';

class EmergencyService {
  final AppDatabase db;

  EmergencyService(this.db);

  /// Triggers a call to the primary emergency services (e.g., 102 in India).
  Future<void> callPublicEmergency() async {
    final Uri url = Uri.parse('tel:102');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  /// Triggers a call to a specific phone number.
  Future<void> callNumber(String phoneNumber) async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  /// Fetches the user's emergency card which contains custom contacts.
  Future<EmergencyCard?> getEmergencyCard(String userId) async {
    return await (db.select(db.emergencyCards)
          ..where((t) => t.userId.equals(userId))
          ..limit(1))
        .getSingleOrNull();
  }

  /// High-level logic to call the user's primary emergency contact.
  Future<void> callEmergencyContact(String userId) async {
    final card = await getEmergencyCard(userId);
    if (card != null && card.emergencyContactPhone.isNotEmpty) {
      await callNumber(card.emergencyContactPhone);
    } else {
      // Fallback to public emergency if no contact is defined
      await callPublicEmergency();
    }
  }
}

final emergencyServiceProvider = Provider<EmergencyService>((ref) {
  return EmergencyService(DriftService.db);
});
