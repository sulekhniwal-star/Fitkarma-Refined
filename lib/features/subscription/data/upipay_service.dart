// lib/features/subscription/data/upipay_service.dart
// UPI Deep-link payment service

import 'package:url_launcher/url_launcher.dart';

/// UPI payment service for creating deep-links
class UpiPaymentService {
  /// Create a UPI payment deep-link URL
  ///
  /// Parameters:
  /// - [vpa]: The UPI Virtual Payment Address (e.g., merchant@upi)
  /// - [name]: The payee name
  /// - [amount]: The amount to pay (in INR)
  /// - [transactionNote]: Note for the transaction
  /// - [transactionId]: Unique transaction ID
  ///
  /// Returns a UPI deep-link URL that can be opened in any UPI app
  static String createUpiLink({
    required String vpa,
    required String name,
    required double amount,
    required String transactionNote,
    required String transactionId,
  }) {
    // Encode parameters for URL
    final encodedVpa = Uri.encodeComponent(vpa);
    final encodedName = Uri.encodeComponent(name);
    final encodedNote = Uri.encodeComponent(transactionNote);

    // Create the UPI deep-link
    // Format: upi://pay?pa=<vpa>&pn=<name>&am=<amount>&tn=<note>&tid=<transactionId>
    final upiLink = Uri(
      scheme: 'upi',
      host: 'pay',
      queryParameters: {
        'pa': encodedVpa,
        'pn': encodedName,
        'am': amount.toStringAsFixed(2),
        'tn': encodedNote,
        'tid': transactionId,
        'cu': 'INR',
      },
    ).toString();

    return upiLink;
  }

  /// Create a UPI payment deep-link for subscription purchase
  static String createSubscriptionUpiLink({
    required String vpa,
    required String planName,
    required double amount,
    required String userId,
  }) {
    final transactionId = 'sub_${DateTime.now().millisecondsSinceEpoch}';

    return createUpiLink(
      vpa: vpa,
      name: 'Fitkarma Premium',
      amount: amount,
      transactionNote: '$planName Subscription - $userId',
      transactionId: transactionId,
    );
  }

  /// Create a UPI payment deep-link for workout pack purchase
  static String createWorkoutPackUpiLink({
    required String vpa,
    required String packName,
    required double amount,
    required String userId,
  }) {
    final transactionId = 'wpp_${DateTime.now().millisecondsSinceEpoch}';

    return createUpiLink(
      vpa: vpa,
      name: 'Fitkarma Workout Pack',
      amount: amount,
      transactionNote: '$packName - $userId',
      transactionId: transactionId,
    );
  }

  /// Check if UPI is available on the device
  static Future<bool> isUpiAvailable() async {
    // Try to check if any UPI app can handle the URL
    final testUri = Uri.parse('upi://pay');
    return await canLaunchUrl(testUri);
  }

  /// Launch UPI payment
  static Future<bool> launchUpiPayment(String upiLink) async {
    final uri = Uri.parse(upiLink);

    try {
      // First try to check if the URL can be launched
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }

      // If direct launch fails, try with custom tab
      return await launchUrl(uri, mode: LaunchMode.inAppWebView);
    } catch (e) {
      return false;
    }
  }

  /// Get list of common UPI apps' package names (for Android)
  static const List<String> upiAppPackages = [
    'com.google.android.apps.nbu.paisa.user', // Google Pay
    'com.phonepe.app', // PhonePe
    'com.amazon.mShop.android.shopping', // Amazon Pay
    'com.flipkart.android', // Flipkart
    'com.mobikwik.newapp', // Mobikwik
    'com.freecharge.android', // FreeCharge
    'com.ajbuild.apps.indianual', // Paytm (old)
    'net.one97.paytm', // Paytm
  ];

  /// Get merchant UPA (UPI Payment Address) - this would be configured in settings
  /// For Fitkarma, this should be configured in AppConfig or fetched from remote config
  static const String defaultMerchantVpa =
      'fitkarma@oksbi'; // Example: Replace with actual merchant VPA
}

/// UPI app info for showing app selection
class UpiAppInfo {
  final String name;
  final String packageName;
  final String? iconPath;

  const UpiAppInfo({
    required this.name,
    required this.packageName,
    this.iconPath,
  });

  static const List<UpiAppInfo> commonApps = [
    UpiAppInfo(
      name: 'Google Pay',
      packageName: 'com.google.android.apps.nbu.paisa.user',
    ),
    UpiAppInfo(name: 'PhonePe', packageName: 'com.phonepe.app'),
    UpiAppInfo(name: 'Paytm', packageName: 'net.one97.paytm'),
    UpiAppInfo(
      name: 'Amazon Pay',
      packageName: 'com.amazon.mShop.android.shopping',
    ),
    UpiAppInfo(name: 'Mobikwik', packageName: 'com.mobikwik.newapp'),
  ];
}
