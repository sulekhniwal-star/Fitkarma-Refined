import admin from 'firebase-admin';
import { Client, Databases } from 'node-appwrite';

let initialized = false;

export default async ({ req, res, log, error }) => {
  // 1. Initialize Firebase Admin if not already done
  if (!initialized) {
    try {
      admin.initializeApp({
        credential: admin.credential.cert(JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT)),
      });
      initialized = true;
    } catch (e) {
      error(`Firebase initialization failed: ${e.message}`);
    }
  }

  const payload = req.body;
  const action = payload.action; // 'send_notification'

  if (action !== 'send_notification' && !payload.userId) {
     // Handle database events (e.g., new insight created)
     // This part would be triggered by Appwrite event if configured
  }

  const { userId, title, body, data } = payload;

  log(`Attempting to send FCM to user: ${userId}`);

  const client = new Client()
    .setEndpoint(process.env.APPWRITE_FUNCTION_ENDPOINT)
    .setProject(process.env.APPWRITE_FUNCTION_PROJECT_ID)
    .setKey(process.env.APPWRITE_API_KEY);

  const databases = new Databases(client);

  try {
    // 2. Fetch user's fcm_token
    const user = await databases.getDocument(
      process.env.APPWRITE_DATABASE_ID || 'main',
      'users',
      userId
    );

    const fcmToken = user.fcm_token;

    if (!fcmToken) {
      log(`No FCM token found for user: ${userId}`);
      return res.json({ success: false, message: 'No FCM token' });
    }

    // 3. Send Notification
    const message = {
      token: fcmToken,
      notification: {
        title: title || 'FitKarma Update',
        body: body || 'You have a new update in FitKarma',
      },
      data: data || {},
    };

    const response = await admin.messaging().send(message);
    log(`FCM sent successfully: ${response}`);

    return res.json({ success: true, messageId: response });
  } catch (e) {
    error(`FCM send failed: ${e.message}`);
    return res.json({ success: false, error: e.message }, 500);
  }
};
