import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WhatsAppRepository {
  /// The official WhatsApp Bot number for FitKarma. 
  /// In a production app, this would be fetched from Remote Config.
  static const String botPhoneNumber = '91XXXXXXXXXX'; 

  /// Launches WhatsApp with a pre-filled message to the bot.
  Future<bool> launchBotChat({String? customMessage}) async {
    final message = customMessage ?? 'Hello FitKarma AI, I need personalized health advice.';
    final encodedMessage = Uri.encodeComponent(message);
    
    // Use https://wa.me/ for universal compatibility across OSs
    final whatsappUrl = Uri.parse('https://wa.me/$botPhoneNumber?text=$encodedMessage');
    
    if (await canLaunchUrl(whatsappUrl)) {
      return await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    }
    return false;
  }

  /// Sends a trigger to the Appwrite 'core-engine' function to initiate 
  /// a WhatsApp-based health assessment or verification.
  Future<void> triggerWhatsAppOnboarding(String userId, String phoneNumber) async {
    // This scaffold prepares for the Appwrite function integration
    // that the user mentioned is already partially done.
    
    // Example:
    /*
    final functions = AppwriteClient.functions;
    await functions.createExecution(
      functionId: 'core-engine',
      body: jsonEncode({
        'action': 'whatsapp-initiation',
        'userId': userId,
        'phone': phoneNumber,
      }),
    );
    */
  }
}

final whatsappRepositoryProvider = Provider<WhatsAppRepository>((ref) {
  return WhatsAppRepository();
});
