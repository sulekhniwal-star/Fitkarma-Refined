/**
 * Fitbit OAuth2 Function for Fitkarma
 * 
 * This function handles:
 * 1. OAuth2 authorization flow with Fitbit
 * 2. Token exchange and refresh
 * 3. Data fetching (steps, sleep, HR, SpO2)
 * 4. Storing tokens securely in Appwrite database
 * 
 * The client_secret is kept server-side in Appwrite Function environment variables
 */

const fetch = require('node-fetch');
const { Client, Databases, ID, Query } = require('appwrite');

// Appwrite configuration
const APPWRITE_ENDPOINT = process.env.APPWRITE_ENDPOINT || 'https://cloud.appwrite.io/v1';
const APPWRITE_PROJECT = process.env.APPWRITE_PROJECT_ID;
const APPWRITE_DATABASE_ID = 'fitkarma';
const APPWRITE_TOKENS_COLLECTION = 'wearable_tokens';

// Fitbit configuration - kept secret in Appwrite Function
const FITBIT_CLIENT_ID = process.env.FITBIT_CLIENT_ID;
const FITBIT_CLIENT_SECRET = process.env.FITBIT_CLIENT_SECRET;
const FITBIT_REDIRECT_URI = process.env.FITBIT_REDIRECT_URI || 'fitkarma://oauth/fitbit';
const FITBIT_AUTH_URL = 'https://www.fitbit.com/oauth2/authorize';
const FITBIT_TOKEN_URL = 'https://api.fitbit.com/oauth2/token';
const FITBIT_API_BASE = 'https://api.fitbit.com';

// Scopes required for data access
const FITBIT_SCOPES = 'activity heartrate sleep oxygen饱和度 weight profile';

module.exports = async function (req, res) {
    const client = new Client()
        .setEndpoint(APPWRITE_ENDPOINT)
        .setProject(APPWRITE_PROJECT);

    const databases = new Databases(client);

    // Get action from request
    const action = req.query.action || 'authorize';

    try {
        switch (action) {
            case 'authorize':
                await handleAuthorize(req, res);
                break;
            case 'callback':
                await handleCallback(req, res, databases);
                break;
            case 'refresh':
                await handleRefresh(req, res, databases);
                break;
            case 'sync':
                await handleSync(req, res, databases);
                break;
            default:
                res.json({ error: 'Invalid action' }, 400);
        }
    } catch (error) {
        console.error('Fitbit OAuth Error:', error);
        res.json({ error: error.message }, 500);
    }
};

/**
 * Generate OAuth2 authorization URL
 */
async function handleAuthorize(req, res) {
    const userId = req.query.userId;

    if (!userId) {
        return res.json({ error: 'userId is required' }, 400);
    }

    // Generate state parameter for CSRF protection
    const state = `${userId}_${Date.now()}`;

    // Build authorization URL
    const authParams = new URLSearchParams({
        response_type: 'code',
        client_id: FITBIT_CLIENT_ID,
        redirect_uri: FITBIT_REDIRECT_URI,
        scope: FITBIT_SCOPES,
        state: state,
    });

    const authUrl = `${FITBIT_AUTH_URL}?${authParams.toString()}`;

    res.json({
        authorizationUrl: authUrl,
        state: state,
    });
}

/**
 * Handle OAuth2 callback and exchange code for tokens
 */
async function handleCallback(req, res, databases) {
    const { code, state, error } = req.query;

    if (error) {
        return res.json({ error: error }, 400);
    }

    if (!code || !state) {
        return res.json({ error: 'Missing code or state' }, 400);
    }

    // Extract userId from state
    const userId = state.split('_')[0];

    try {
        // Exchange code for tokens
        const tokenResponse = await fetch(FITBIT_TOKEN_URL, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'Authorization': `Basic ${Buffer.from(`${FITBIT_CLIENT_ID}:${FITBIT_CLIENT_SECRET}`).toString('base64')}`,
            },
            body: new URLSearchParams({
                grant_type: 'authorization_code',
                code: code,
                redirect_uri: FITBIT_REDIRECT_URI,
            }),
        });

        if (!tokenResponse.ok) {
            const errorText = await tokenResponse.text();
            throw new Error(`Token exchange failed: ${errorText}`);
        }

        const tokens = await tokenResponse.json();

        // Store tokens in Appwrite database
        const tokenData = {
            userId: userId,
            provider: 'fitbit',
            accessToken: tokens.access_token,
            refreshToken: tokens.refresh_token,
            expiresAt: new Date(Date.now() + tokens.expires_in * 1000).toISOString(),
            scope: tokens.scope,
            userIdFitbit: tokens.user_id,
            createdAt: new Date().toISOString(),
        };

        // Check if token already exists for this user
        const existingTokens = await databases.listDocuments(
            APPWRITE_DATABASE_ID,
            APPWRITE_TOKENS_COLLECTION,
            [Query.equal('userId', userId), Query.equal('provider', 'fitbit')]
        );

        if (existingTokens.documents.length > 0) {
            // Update existing token
            await databases.updateDocument(
                APPWRITE_DATABASE_ID,
                APPWRITE_TOKENS_COLLECTION,
                existingTokens.documents[0].$id,
                tokenData
            );
        } else {
            // Create new token
            await databases.createDocument(
                APPWRITE_DATABASE_ID,
                APPWRITE_TOKENS_COLLECTION,
                ID.unique(),
                tokenData
            );
        }

        res.json({
            success: true,
            userId: userId,
            message: 'Fitbit connected successfully',
        });
    } catch (error) {
        console.error('Callback error:', error);
        res.json({ error: error.message }, 500);
    }
}

/**
 * Refresh expired access token
 */
async function handleRefresh(req, res, databases) {
    const userId = req.query.userId;

    if (!userId) {
        return res.json({ error: 'userId is required' }, 400);
    }

    try {
        // Get stored refresh token
        const tokens = await databases.listDocuments(
            APPWRITE_DATABASE_ID,
            APPWRITE_TOKENS_COLLECTION,
            [Query.equal('userId', userId), Query.equal('provider', 'fitbit')]
        );

        if (tokens.documents.length === 0) {
            return res.json({ error: 'No Fitbit tokens found' }, 404);
        }

        const storedToken = tokens.documents[0];
        const refreshToken = storedToken.refreshToken;

        // Refresh the token
        const tokenResponse = await fetch(FITBIT_TOKEN_URL, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'Authorization': `Basic ${Buffer.from(`${FITBIT_CLIENT_ID}:${FITBIT_CLIENT_SECRET}`).toString('base64')}`,
            },
            body: new URLSearchParams({
                grant_type: 'refresh_token',
                refresh_token: refreshToken,
            }),
        });

        if (!tokenResponse.ok) {
            throw new Error('Token refresh failed');
        }

        const newTokens = await tokenResponse.json();

        // Update stored tokens
        await databases.updateDocument(
            APPWRITE_DATABASE_ID,
            APPWRITE_TOKENS_COLLECTION,
            storedToken.$id,
            {
                accessToken: newTokens.access_token,
                refreshToken: newTokens.refresh_token,
                expiresAt: new Date(Date.now() + newTokens.expires_in * 1000).toISOString(),
            }
        );

        res.json({ success: true });
    } catch (error) {
        console.error('Refresh error:', error);
        res.json({ error: error.message }, 500);
    }
}

/**
 * Sync Fitbit data to Fitkarma
 */
async function handleSync(req, res, databases) {
    const userId = req.query.userId;
    const startDate = req.query.startDate || getDefaultStartDate();
    const endDate = req.query.endDate || new Date().toISOString().split('T')[0];

    if (!userId) {
        return res.json({ error: 'userId is required' }, 400);
    }

    try {
        // Get stored access token
        const tokens = await databases.listDocuments(
            APPWRITE_DATABASE_ID,
            APPWRITE_TOKENS_COLLECTION,
            [Query.equal('userId', userId), Query.equal('provider', 'fitbit')]
        );

        if (tokens.documents.length === 0) {
            return res.json({ error: 'Fitbit not connected' }, 404);
        }

        const storedToken = tokens.documents[0];
        let accessToken = storedToken.accessToken;

        // Check if token is expired and refresh if needed
        if (new Date(storedToken.expiresAt) < new Date()) {
            await refreshToken(databases, storedToken);
            // Get updated token
            const updatedTokens = await databases.listDocuments(
                APPWRITE_DATABASE_ID,
                APPWRITE_TOKENS_COLLECTION,
                [Query.equal('userId', userId), Query.equal('provider', 'fitbit')]
            );
            accessToken = updatedTokens.documents[0].accessToken;
        }

        // Fetch data from Fitbit API
        const data = await fetchFitbitData(accessToken, startDate, endDate);

        res.json({
            success: true,
            userId: userId,
            data: data,
            syncedAt: new Date().toISOString(),
        });
    } catch (error) {
        console.error('Sync error:', error);
        res.json({ error: error.message }, 500);
    }
}

/**
 * Fetch data from Fitbit API
 */
async function fetchFitbitData(accessToken, startDate, endDate) {
    const headers = {
        'Authorization': `Bearer ${accessToken}`,
    };

    const results = {};

    // Fetch steps
    const stepsResponse = await fetch(
        `${FITBIT_API_BASE}/1.2/user/-/activities/date/${startDate}/${endDate}.json`,
        { headers }
    );
    if (stepsResponse.ok) {
        results.steps = await stepsResponse.json();
    }

    // Fetch sleep
    const sleepResponse = await fetch(
        `${FITBIT_API_BASE}/1.2/user/-/sleep/date/${startDate}/${endDate}.json`,
        { headers }
    );
    if (sleepResponse.ok) {
        results.sleep = await sleepResponse.json();
    }

    // Fetch heart rate
    const hrResponse = await fetch(
        `${FITBIT_API_BASE}/1.2/user/-/activities/heart/date/${startDate}/${endDate}.json`,
        { headers }
    );
    if (hrResponse.ok) {
        results.heartRate = await hrResponse.json();
    }

    // Fetch SpO2 (oxygen saturation)
    const spo2Response = await fetch(
        `${FITBIT_API_BASE}/1.2/user/-/spo2/date/${startDate}/${endDate}.json`,
        { headers }
    );
    if (spo2Response.ok) {
        results.spo2 = await spo2Response.json();
    }

    return results;
}

/**
 * Refresh token helper
 */
async function refreshToken(databases, storedToken) {
    const tokenResponse = await fetch(FITBIT_TOKEN_URL, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': `Basic ${Buffer.from(`${FITBIT_CLIENT_ID}:${FITBIT_CLIENT_SECRET}`).toString('base64')}`,
        },
        body: new URLSearchParams({
            grant_type: 'refresh_token',
            refresh_token: storedToken.refreshToken,
        }),
    });

    if (!tokenResponse.ok) {
        throw new Error('Token refresh failed');
    }

    const newTokens = await tokenResponse.json();

    await databases.updateDocument(
        APPWRITE_DATABASE_ID,
        APPWRITE_TOKENS_COLLECTION,
        storedToken.$id,
        {
            accessToken: newTokens.access_token,
            refreshToken: newTokens.refresh_token,
            expiresAt: new Date(Date.now() + newTokens.expires_in * 1000).toISOString(),
        }
    );
}

/**
 * Get default start date (7 days ago)
 */
function getDefaultStartDate() {
    const date = new Date();
    date.setDate(date.getDate() - 7);
    return date.toISOString().split('T')[0];
}
