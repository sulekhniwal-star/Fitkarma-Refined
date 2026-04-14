import { Client, Databases, Query } from 'node-appwrite';

export default async ({ req, res, log, error }) => {
  // 1. Verify webhook challenge (GET request from Meta)
  if (req.method === 'GET') {
    const verifyToken = process.env.WHATSAPP_VERIFY_TOKEN;
    const mode = req.query['hub.mode'];
    const token = req.query['hub.verify_token'];
    const challenge = req.query['hub.challenge'];

    if (mode === 'subscribe' && token === verifyToken) {
      log('WhatsApp webhook verified successfully');
      return res.text(challenge);
    }
    return res.text('Verification failed', 403);
  }

  // 2. Process POST request (Incoming Message)
  if (req.method === 'POST') {
    const payload = req.body;
    
    // Check if it's a WhatsApp message payload
    if (!payload.entry || !payload.entry[0].changes || !payload.entry[0].changes[0].value.messages) {
      return res.json({ success: false, message: 'Invalid WhatsApp payload' });
    }

    const message = payload.entry[0].changes[0].value.messages[0];
    const from = message.from; // Phone number
    const text = message.text?.body || '';

    log(`Received WhatsApp message from ${from}: ${text}`);

    const client = new Client()
      .setEndpoint(process.env.APPWRITE_FUNCTION_ENDPOINT)
      .setProject(process.env.APPWRITE_FUNCTION_PROJECT_ID)
      .setKey(process.env.APPWRITE_API_KEY);

    const databases = new Databases(client);
    const databaseId = process.env.APPWRITE_DATABASE_ID || 'main';
    const usersCollectionId = 'users';

    try {
      // 3. Look up user by phone number
      const users = await databases.listDocuments(databaseId, usersCollectionId, [
        Query.equal('phone', from)
      ]);

      if (users.total === 0) {
        log(`User not found for phone: ${from}`);
        return res.json({ success: false, message: 'User not found' });
      }

      const user = users.documents[0];
      const userId = user.$id;

      // 4. Parse intent and update database
      const cleanText = text.toLowerCase().trim();
      
      if (cleanText.includes('food') || cleanText.includes('ate')) {
        log(`Logging food for user ${userId}: ${text}`);
        await databases.createDocument(databaseId, 'food_logs', 'unique()', {
          userId: userId,
          content: text,
          source: 'whatsapp',
          loggedAt: new Date().toISOString()
        });
      } else if (cleanText.includes('mood') || cleanText.includes('feeling')) {
        log(`Logging mood for user ${userId}: ${text}`);
        await databases.createDocument(databaseId, 'mood_logs', 'unique()', {
          userId: userId,
          content: text,
          source: 'whatsapp',
          loggedAt: new Date().toISOString()
        });
      } else if (cleanText.includes('stats') || cleanText.includes('status')) {
         log(`Returning stats for user ${userId}`);
         // Here we would typically trigger an outbound message via WhatsApp Cloud API
         // For now, we just success out.
      } else {
        log(`Unrecognized intent: ${text}`);
      }

      return res.json({ success: true });
    } catch (e) {
      error(`Error processing WhatsApp message: ${e.message}`);
      return res.json({ success: false, error: e.message }, 500);
    }
  }

  return res.json({ message: 'Method not allowed' }, 405);
};
