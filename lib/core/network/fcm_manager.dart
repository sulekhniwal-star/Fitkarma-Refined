import 'package:firebase_messaging/firebase_messaging.dart';
import '../network/appwrite_client.dart';
import 'package:appwrite/appwrite.dart';

class FCMManager {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> init(String userId) async {
    // 1. Request permission (iOS/Android 13+)
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // 2. Get FCM Token
      String? token = await _messaging.getToken();
      if (token != null) {
        await _saveTokenToAppwrite(userId, token);
      }
    }

    // 3. Listen for token refreshes
    _messaging.onTokenRefresh.listen((newToken) {
      _saveTokenToAppwrite(userId, newToken);
    });
  }

  static Future<void> _saveTokenToAppwrite(String userId, String token) async {
    final databases = Databases(AppwriteClient.client);
    try {
      await databases.updateDocument(
        databaseId: 'main',
        collectionId: 'users',
        documentId: userId,
        data: {
          'fcm_token': token,
        },
      );
    } catch (e) {
      // Silently fail if user doc is not ready or restricted
    }
  }
}

