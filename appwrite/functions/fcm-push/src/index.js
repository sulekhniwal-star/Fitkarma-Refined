/**
 * Send Family Notification - Appwrite Function
 * 
 * This function sends push notifications to all members of a family group.
 * 
 * Expected payload:
 * {
 *   familyId: string,
 *   title: string,
 *   body: string,
 *   senderId: string,
 *   data?: string (optional additional data)
 * }
 * 
 * Environment variables required:
 * - APPWRITE_ENDPOINT: Appwrite endpoint URL
 * - APPWRITE_PROJECT: Appwrite project ID
 * - APPWRITE_API_KEY: Appwrite API key with messaging permissions
 * - DATABASE_ID: fitkarma
 * - FAMILY_MEMBERS_COLLECTION: family_members
 */

const sdk = require('node-appwrite');

module.exports = async function (req, res) {
    // Initialize Appwrite client
    const client = new sdk.Client()
        .setEndpoint(process.env.APPWRITE_ENDPOINT || 'https://cloud.appwrite.io/v1')
        .setProject(process.env.APPWRITE_PROJECT || '')
        .setKey(process.env.APPWRITE_API_KEY || '');

    const databases = new sdk.Databases(client);
    const messaging = new sdk.Messaging(client);

    const databaseId = process.env.DATABASE_ID || 'fitkarma';
    const familyMembersCollection = process.env.FAMILY_MEMBERS_COLLECTION || 'family_members';

    try {
        // Parse request payload
        let payload;
        try {
            payload = typeof req.payload === 'string' ? JSON.parse(req.payload) : req.payload;
        } catch (e) {
            payload = req.payload;
        }

        const { familyId, title, body, senderId, data } = payload;

        if (!familyId || !title || !body) {
            return res.json({
                success: false,
                error: 'Missing required fields: familyId, title, body'
            }, 400);
        }

        // Get all family members from the database
        const membersResponse = await databases.listDocuments(
            databaseId,
            familyMembersCollection,
            [
                sdk.Query.equal('familyId', familyId),
                sdk.Query.equal('invitationStatus', 'accepted')
            ]
        );

        if (membersResponse.documents.length === 0) {
            return res.json({
                success: true,
                message: 'No family members found'
            });
        }

        // Collect user IDs (excluding sender)
        const userIds = membersResponse.documents
            .filter(member => member.userId !== senderId)
            .map(member => member.userId);

        if (userIds.length === 0) {
            return res.json({
                success: true,
                message: 'No other members to notify'
            });
        }

        // For each user, create and send notification
        // Note: In production, you'd typically create push topics or use batch operations
        const results = [];

        for (const userId of userIds) {
            try {
                // Create a notification for each user
                // This is a simplified version - in production you'd use topics or target specific users
                const notification = await messaging.createPush(
                    sdk.ID.unique(),
                    title,
                    body,
                    data ? JSON.parse(data) : undefined,
                    ['topic:family_' + familyId] // Use topic-based targeting
                );

                results.push({ userId, success: true });
            } catch (notifyError) {
                console.error(`Failed to notify user ${userId}:`, notifyError);
                results.push({ userId, success: false, error: notifyError.message });
            }
        }

        // Return success response
        return res.json({
            success: true,
            message: `Notifications sent to ${results.filter(r => r.success).length} members`,
            results
        });

    } catch (error) {
        console.error('Error sending family notification:', error);
        return res.json({
            success: false,
            error: error.message || 'Failed to send notifications'
        }, 500);
    }
};
