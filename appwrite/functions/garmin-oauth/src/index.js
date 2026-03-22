/**
 * Garmin OAuth1 Function for Fitkarma
 * 
 * This function handles:
 * 1. OAuth1.0a authorization flow with Garmin Connect
 * 2. Token exchange and session management
 * 3. Data fetching (steps, sleep, HR, activities)
 * 4. Storing tokens securely in Appwrite database
 * 
 * The consumer_secret is kept server-side in Appwrite Function environment variables
 * 
 * Note: Garmin uses OAuth1.0a (HMAC-SHA1 signature)
 */

const fetch = require('node-fetch');
const crypto = require('crypto');
const { Client, Databases, Query } = require('appwrite');

// Appwrite configuration
const APPWRITE_ENDPOINT = process.env.APPWRITE_ENDPOINT || 'https://cloud.appwrite.io/v1';
const APPWRITE_PROJECT = process.env.APPWRITE_PROJECT_ID;
const APPWRITE_DATABASE_ID = 'fitkarma';
const APPWRITE_TOKENS_COLLECTION = 'wearable_tokens';

// Garmin configuration - kept secret in Appwrite Function
const GARMIN_CLIENT_ID = process.env.GARMIN_CLIENT_ID;
const GARMIN_CLIENT_SECRET = process.env.GARMIN_CLIENT_SECRET;
const GARMIN_REDIRECT_URI = process.env.GARMIN_REDIRECT_URI || 'fitkarma://oauth/garmin';
const GARMIN_REQUEST_TOKEN_URL = 'https://connectapi.garmin.com/oauth-service/oauth/request_token';
const GARMIN_ACCESS_TOKEN_URL = 'https://connectapi.garmin.com/oauth-service/oauth/access_token';
const GARMIN_AUTHORIZE_URL = 'https://connect.garmin.com/oauthConfirm';
const GARMIN_API_BASE = 'https://apis.garmin.com/wellness-api/rest';

// OAuth1 constants
const OAUTH_VERSION = '1.0';
const OAUTH_SIGNATURE_METHOD = 'HMAC-SHA1';

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
            case 'sync':
                await handleSync(req, res, databases);
                break;
            case 'revoke':
                await handleRevoke(req, res, databases);
                break;
            default:
                res.json({ error: 'Invalid action' }, 400);
        }
    } catch (error) {
        console.error('Garmin OAuth Error:', error);
        res.json({ error: error.message }, 500);
    }
};

/**
 * Generate OAuth1 authorization URL
 */
async function handleAuthorize(req, res) {
    const userId = req.query.userId;

    if (!userId) {
        return res.json({ error: 'userId is required' }, 400);
    }

    // Generate OAuth callback URL with state
    const oauthCallback = `${process.env.APPWRITE_FUNCTION_API_ENDPOINT}/fitkarma-garmin-oauth?action=callback&userId=${userId}`;

    // Generate OAuth request token
    const requestToken = await getRequestToken(oauthCallback);

    if (!requestToken) {
        return res.json({ error: 'Failed to get request token' }, 500);
    }

    // Build authorization URL
    const authorizeUrl = `${GARMIN_AUTHORIZE_URL}?oauth_token=${requestToken.oauth_token}&oauth_callback=${encodeURIComponent(oauthCallback)}`;

    // Store request token temporarily (in real implementation, use session or cache)
    // For simplicity, we'll include it in the response - in production use secure storage

    res.json({
        authorizationUrl: authorizeUrl,
        oauthToken: requestToken.oauth_token,
        oauthSecret: requestToken.oauth_token_secret,
    });
}

/**
 * Handle OAuth1 callback and exchange request token for access token
 */
async function handleCallback(req, res, databases) {
    const { oauth_token, oauth_verifier, userId, denied } = req.query;

    if (denied) {
        return res.json({ error: 'Authorization denied by user' }, 400);
    }

    if (!oauth_token || !oauth_verifier || !userId) {
        return res.json({ error: 'Missing OAuth parameters' }, 400);
    }

    try {
        // Exchange request token for access token
        const accessToken = await getAccessToken(oauth_token, oauth_verifier);

        if (!accessToken) {
            return res.json({ error: 'Failed to get access token' }, 500);
        }

        // Store tokens in Appwrite database
        const tokenData = {
            userId: userId,
            provider: 'garmin',
            accessToken: accessToken.oauth_token,
            refreshToken: accessToken.oauth_token_secret, // Garmin uses token secret as refresh
            expiresAt: null, // Garmin tokens don't expire
            scope: 'ACTIVITY,SLEEP,HEART_RATE',
            createdAt: new Date().toISOString(),
        };

        // Check if token already exists for this user
        const existingTokens = await databases.listDocuments(
            APPWRITE_DATABASE_ID,
            APPWRITE_TOKENS_COLLECTION,
            [Query.equal('userId', userId), Query.equal('provider', 'garmin')]
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
                require('appwrite').ID.unique(),
                tokenData
            );
        }

        res.json({
            success: true,
            userId: userId,
            message: 'Garmin connected successfully',
        });
    } catch (error) {
        console.error('Callback error:', error);
        res.json({ error: error.message }, 500);
    }
}

/**
 * Sync Garmin data to Fitkarma
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
            [Query.equal('userId', userId), Query.equal('provider', 'garmin')]
        );

        if (tokens.documents.length === 0) {
            return res.json({ error: 'Garmin not connected' }, 404);
        }

        const storedToken = tokens.documents[0];
        const accessToken = storedToken.accessToken;
        const tokenSecret = storedToken.refreshToken;

        // Fetch data from Garmin API
        const data = await fetchGarminData(accessToken, tokenSecret, startDate, endDate);

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
 * Revoke Garmin connection
 */
async function handleRevoke(req, res, databases) {
    const userId = req.query.userId;

    if (!userId) {
        return res.json({ error: 'userId is required' }, 400);
    }

    try {
        // Delete stored tokens
        const tokens = await databases.listDocuments(
            APPWRITE_DATABASE_ID,
            APPWRITE_TOKENS_COLLECTION,
            [Query.equal('userId', userId), Query.equal('provider', 'garmin')]
        );

        if (tokens.documents.length > 0) {
            await databases.deleteDocument(
                APPWRITE_DATABASE_ID,
                APPWRITE_TOKENS_COLLECTION,
                tokens.documents[0].$id
            );
        }

        res.json({
            success: true,
            message: 'Garmin disconnected',
        });
    } catch (error) {
        console.error('Revoke error:', error);
        res.json({ error: error.message }, 500);
    }
}

/**
 * Get OAuth1 request token
 */
async function getRequestToken(oauthCallback) {
    const timestamp = Math.floor(Date.now() / 1000).toString();
    const nonce = generateNonce();

    const params = {
        oauth_consumer_key: GARMIN_CLIENT_ID,
        oauth_signature_method: OAUTH_SIGNATURE_METHOD,
        oauth_timestamp: timestamp,
        oauth_nonce: nonce,
        oauth_version: OAUTH_VERSION,
        oauth_callback: oauthCallback,
    };

    const signature = generateSignature('POST', GARMIN_REQUEST_TOKEN_URL, params, GARMIN_CLIENT_SECRET, null);
    params.oauth_signature = signature;

    const response = await fetch(GARMIN_REQUEST_TOKEN_URL, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams(params).toString(),
    });

    if (!response.ok) {
        console.error('Request token error:', await response.text());
        return null;
    }

    const body = await response.text();
    return parseOAuthResponse(body);
}

/**
 * Get OAuth1 access token
 */
async function getAccessToken(oauthToken, oauthVerifier) {
    const timestamp = Math.floor(Date.now() / 1000).toString();
    const nonce = generateNonce();

    const params = {
        oauth_consumer_key: GARMIN_CLIENT_ID,
        oauth_signature_method: OAUTH_SIGNATURE_METHOD,
        oauth_timestamp: timestamp,
        oauth_nonce: nonce,
        oauth_version: OAUTH_VERSION,
        oauth_token: oauthToken,
        oauth_verifier: oauthVerifier,
    };

    const signature = generateSignature('POST', GARMIN_ACCESS_TOKEN_URL, params, GARMIN_CLIENT_SECRET, null);
    params.oauth_signature = signature;

    const response = await fetch(GARMIN_ACCESS_TOKEN_URL, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams(params).toString(),
    });

    if (!response.ok) {
        console.error('Access token error:', await response.text());
        return null;
    }

    const body = await response.text();
    return parseOAuthResponse(body);
}

/**
 * Fetch data from Garmin API
 */
async function fetchGarminData(accessToken, tokenSecret, startDate, endDate) {
    const headers = {
        'Content-Type': 'application/json',
    };

    const results = {};

    // OAuth1 signed request helper
    const signedRequest = async (url) => {
        const timestamp = Math.floor(Date.now() / 1000).toString();
        const nonce = generateNonce();

        const params = {
            oauth_consumer_key: GARMIN_CLIENT_ID,
            oauth_signature_method: OAUTH_SIGNATURE_METHOD,
            oauth_timestamp: timestamp,
            oauth_nonce: nonce,
            oauth_version: OAUTH_VERSION,
            oauth_token: accessToken,
        };

        const signature = generateSignature('GET', url, params, GARMIN_CLIENT_SECRET, tokenSecret);
        params.oauth_signature = signature;

        const authHeader = 'OAuth ' + Object.entries(params)
            .map(([k, v]) => `${k}="${v}"`)
            .join(', ');

        return fetch(url, {
            method: 'GET',
            headers: {
                ...headers,
                'Authorization': authHeader,
            },
        });
    };

    // Fetch daily summaries (steps, calories, distance)
    try {
        const dailyResponse = await signedRequest(
            `${GARMIN_API_BASE}/dailies?startDate=${startDate}&endDate:endDate=${endDate}`
        );
        if (dailyResponse.ok) {
            results.daily = await dailyResponse.json();
        }
    } catch (e) {
        console.error('Garmin daily fetch error:', e);
    }

    // Fetch sleep summaries
    try {
        const sleepResponse = await signedRequest(
            `${GARMIN_API_BASE}/sleeps?startDate=${startDate}&endDate=${endDate}`
        );
        if (sleepResponse.ok) {
            results.sleep = await sleepResponse.json();
        }
    } catch (e) {
        console.error('Garmin sleep fetch error:', e);
    }

    // Fetch heart rate data
    try {
        const hrResponse = await signedRequest(
            `${GARMIN_API_BASE}/activities?startDate=${startDate}&endDate=${endDate}`
        );
        if (hrResponse.ok) {
            results.activities = await hrResponse.json();
        }
    } catch (e) {
        console.error('Garmin activities fetch error:', e);
    }

    return results;
}

/**
 * Generate OAuth1 signature
 */
function generateSignature(method, url, params, consumerSecret, tokenSecret) {
    // Sort and encode parameters
    const sortedParams = Object.keys(params).sort().map(key =>
        `${encodeURIComponent(key)}=${encodeURIComponent(params[key])}`
    ).join('&');

    // Create signature base string
    const baseString = [
        method.toUpperCase(),
        encodeURIComponent(url),
        encodeURIComponent(sortedParams)
    ].join('&');

    // Create signing key
    const signingKey = encodeURIComponent(consumerSecret) + '&' +
        (tokenSecret ? encodeURIComponent(tokenSecret) : '');

    // Generate HMAC-SHA1 signature
    const hmac = crypto.createHmac('sha1', signingKey);
    hmac.update(baseString);

    return hmac.digest('base64');
}

/**
 * Generate random nonce
 */
function generateNonce() {
    return crypto.randomBytes(16).toString('hex');
}

/**
 * Parse OAuth response
 */
function parseOAuthResponse(body) {
    const params = {};
    body.split('&').forEach(part => {
        const [key, value] = part.split('=');
        params[key] = decodeURIComponent(value);
    });
    return params;
}

/**
 * Get default start date (7 days ago)
 */
function getDefaultStartDate() {
    const date = new Date();
    date.setDate(date.getDate() - 7);
    return date.toISOString().split('T')[0];
}
