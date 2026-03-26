/**
 * Health Summary Link - Appwrite Function
 * 
 * Generates time-limited, read-only health summary URLs for doctor sharing.
 * 
 * This function handles:
 * 1. Creating temporary share links (expires in 7 days)
 * 2. Retrieving health summary data (aggregate stats only)
 * 3. Revoking share links
 * 
 * IMPORTANT: Only aggregate statistics are shared - no raw logs, journal entries, or period data.
 */

const { Client, Databases, ID, Query } = require('node-appwrite');

// Configuration
const DATABASE_ID = process.env.APPWRITE_DATABASE_ID || 'fitkarma';
const SHARED_LINKS_COLLECTION = 'shared_health_links';
const LINK_EXPIRY_DAYS = 7;

module.exports = async function (req, res) {
    const client = new Client()
        .setEndpoint(process.env.APPWRITE_ENDPOINT || 'https://cloud.appwrite.io/v1')
        .setProject(process.env.APPWRITE_PROJECT_ID || 'fitkarma')
        .setKey(req.headers['x-appwrite-key'] || '');

    const databases = new Databases(client);

    // Parse request
    const method = req.method;
    const path = req.path || '/';
    const params = req.query || {};

    // Route handling
    try {
        // POST / - Create a new share link
        if (method === 'POST' && (path === '/' || path === '')) {
            await createShareLink(databases, req.body);
            return;
        }

        // GET /:token - View health summary (doctor accesses this)
        if (method === 'GET' && path.startsWith('/')) {
            const token = path.substring(1);
            await getHealthSummary(databases, token);
            return;
        }

        // DELETE /:token - Revoke a share link
        if (method === 'DELETE' && path.startsWith('/')) {
            const token = path.substring(1);
            await revokeShareLink(databases, token);
            return;
        }

        // Default: 404
        res.json({
            success: false,
            error: 'Not found. Use POST / to create link, GET /:token to view, DELETE /:token to revoke.'
        }, 404);
    } catch (error) {
        console.error('Error:', error.message);
        res.json({
            success: false,
            error: error.message
        }, 500);
    }

    /**
     * Create a new share link
     * 
     * Request body:
     * {
     *   userId: string,
     *   userName: string (optional)
     * }
     */
    async function createShareLink(databases, body) {
        const userId = body?.userId;
        if (!userId) {
            res.json({ success: false, error: 'userId is required' }, 400);
            return;
        }

        // Generate unique token
        const token = generateToken();
        const expiresAt = new Date();
        expiresAt.setDate(expiresAt.getDate() + LINK_EXPIRY_DAYS);

        // Get aggregate health data from user's local database
        // This is done by the Flutter app before calling this function
        // The Flutter app sends the pre-aggregated data

        const healthSummary = body?.healthSummary || {};

        // Create document in Appwrite
        const document = await databases.createDocument(
            DATABASE_ID,
            SHARED_LINKS_COLLECTION,
            ID.unique(),
            {
                token: token,
                userId: userId,
                userName: body?.userName || 'Patient',
                healthSummary: JSON.stringify(healthSummary),
                createdAt: new Date().toISOString(),
                expiresAt: expiresAt.toISOString(),
                isRevoked: false
            }
        );

        const shareUrl = `https://fitkarma.health/s/${token}`;

        res.json({
            success: true,
            data: {
                id: document.$id,
                shareUrl: shareUrl,
                token: token,
                expiresAt: expiresAt.toISOString(),
                createdAt: document.createdAt
            }
        });
    }

    /**
     * Get health summary for a share link
     * This is what the doctor sees when they open the link
     */
    async function getHealthSummary(databases, token) {
        if (!token) {
            res.json({ success: false, error: 'Token is required' }, 400);
            return;
        }

        // Find the share link document
        const documents = await databases.listDocuments(
            DATABASE_ID,
            SHARED_LINKS_COLLECTION,
            [Query.equal('token', token)]
        );

        if (documents.documents.length === 0) {
            // Check if it's a new format URL without token in database
            // Return a simple placeholder page that the Flutter web view can render
            renderHtmlPage(res, null, token);
            return;
        }

        const doc = documents.documents[0];

        // Check if revoked
        if (doc.isRevoked) {
            renderErrorPage(res, 'This link has been revoked by the user.');
            return;
        }

        // Check if expired
        const expiresAt = new Date(doc.expiresAt);
        if (new Date() > expiresAt) {
            renderErrorPage(res, 'This link has expired.');
            return;
        }

        // Parse health summary
        let healthSummary = {};
        try {
            healthSummary = JSON.parse(doc.healthSummary || '{}');
        } catch (e) {
            healthSummary = {};
        }

        // Render the health summary page for the doctor
        renderHtmlPage(res, {
            userName: doc.userName,
            createdAt: doc.createdAt,
            expiresAt: doc.expiresAt,
            ...healthSummary
        }, token);
    }

    /**
     * Revoke a share link
     */
    async function revokeShareLink(databases, token) {
        if (!token) {
            res.json({ success: false, error: 'Token is required' }, 400);
            return;
        }

        // Find the share link document
        const documents = await databases.listDocuments(
            DATABASE_ID,
            SHARED_LINKS_COLLECTION,
            [Query.equal('token', token)]
        );

        if (documents.documents.length === 0) {
            res.json({ success: false, error: 'Link not found' }, 404);
            return;
        }

        const doc = documents.documents[0];

        // Update to mark as revoked
        await databases.updateDocument(
            DATABASE_ID,
            SHARED_LINKS_COLLECTION,
            doc.$id,
            { isRevoked: true }
        );

        res.json({
            success: true,
            message: 'Link revoked successfully'
        });
    }

    /**
     * Generate a random token for the share link
     */
    function generateToken() {
        const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        let token = '';
        for (let i = 0; i < 16; i++) {
            token += chars.charAt(Math.floor(Math.random() * chars.length));
        }
        return token;
    }

    /**
     * Render HTML page for doctor view
     * This is a clean, mobile-responsive page showing only aggregate health data
     */
    function renderHtmlPage(res, data, token) {
        const isError = !data;
        const userName = data?.userName || 'Patient';
        const createdAt = data?.createdAt ? new Date(data.createdAt).toLocaleDateString() : 'Unknown';
        const expiresAt = data?.expiresAt ? new Date(data.expiresAt).toLocaleDateString() : 'Unknown';

        // Extract health data
        const bpTrend = data?.bpTrend || { avgSystolic: 0, avgDiastolic: 0, readings: 0 };
        const glucoseSummary = data?.glucoseSummary || { average: 0, min: 0, max: 0, readings: 0 };
        const weightTrend = data?.weightTrend || { current: 0, change: 0 };
        const labValues = data?.labValues || [];

        const html = `
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Health Summary - FitKarma</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
      background: #f5f5f5;
      color: #333;
      line-height: 1.6;
    }
    .container {
      max-width: 600px;
      margin: 0 auto;
      padding: 20px;
    }
    .header {
      background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
      color: white;
      padding: 24px;
      border-radius: 16px;
      text-align: center;
      margin-bottom: 20px;
    }
    .header h1 {
      font-size: 24px;
      margin-bottom: 8px;
    }
    .header p {
      opacity: 0.9;
      font-size: 14px;
    }
    .card {
      background: white;
      border-radius: 12px;
      padding: 20px;
      margin-bottom: 16px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    }
    .card-title {
      font-size: 14px;
      color: #666;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      margin-bottom: 12px;
    }
    .metric {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 12px 0;
      border-bottom: 1px solid #f0f0f0;
    }
    .metric:last-child {
      border-bottom: none;
    }
    .metric-label {
      color: #666;
      font-size: 14px;
    }
    .metric-value {
      font-weight: 600;
      font-size: 16px;
    }
    .metric-value.normal {
      color: #10b981;
    }
    .metric-value.warning {
      color: #f59e0b;
    }
    .metric-value.danger {
      color: #ef4444;
    }
    .reference {
      font-size: 12px;
      color: #999;
      margin-top: 4px;
    }
    .status-badge {
      display: inline-block;
      padding: 4px 12px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: 500;
    }
    .status-active {
      background: #d1fae5;
      color: #065f46;
    }
    .status-expired {
      background: #fee2e2;
      color: #991b1b;
    }
    .footer {
      text-align: center;
      padding: 20px;
      color: #999;
      font-size: 12px;
    }
    .footer a {
      color: #6366f1;
      text-decoration: none;
    }
    .error-container {
      text-align: center;
      padding: 40px 20px;
    }
    .error-icon {
      font-size: 48px;
      margin-bottom: 16px;
    }
    .error-message {
      font-size: 18px;
      color: #666;
      margin-bottom: 8px;
    }
    .error-detail {
      font-size: 14px;
      color: #999;
    }
  </style>
</head>
<body>
  <div class="container">
    ${isError ? `
      <div class="header" style="background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);">
        <h1>⚠️ Link Unavailable</h1>
      </div>
      <div class="card">
        <div class="error-container">
          <div class="error-icon">🔗</div>
          <div class="error-message">${data?.error || 'This health summary link is not available'</div>
            <div class="error-detail">The link may have expired or been revoked by the patient.</div>
        </div >
      </div >
            ` : `
            < div class="header" >
        <h1>🏥 Health Summary</h1>
        <p>Patient: ${userName}</p>
        <p>Generated: ${createdAt} • Expires: ${expiresAt}</p>
      </div >

      < !--Blood Pressure Section-- >
      <div class="card">
        <div class="card-title">💓 Blood Pressure (30-day trend)</div>
        <div class="metric">
          <span class="metric-label">Average Systolic</span>
          <span class="metric-value ${getBpColor(bpTrend.avgSystolic, 'systolic')}">${bpTrend.avgSystolic || '--'} mmHg</span>
        </div>
        <div class="metric">
          <span class="metric-label">Average Diastolic</span>
          <span class="metric-value ${getBpColor(bpTrend.avgDiastolic, 'diastolic')}">${bpTrend.avgDiastolic || '--'} mmHg</span>
        </div>
        <div class="metric">
          <span class="metric-label">Total Readings</span>
          <span class="metric-value">${bpTrend.readings || 0}</span>
        </div>
        <div class="reference">Reference: Normal <120/80 • Elevated 120-129/<80 • High ≥130/80</div>
      </div>

      <!--Glucose Section-- >
      <div class="card">
        <div class="card-title">🩸 Blood Glucose Summary</div>
        <div class="metric">
          <span class="metric-label">Average</span>
          <span class="metric-value ${getGlucoseColor(glucoseSummary.average)}">${glucoseSummary.average || '--'} mg/dL</span>
        </div>
        <div class="metric">
          <span class="metric-label">Minimum</span>
          <span class="metric-value">${glucoseSummary.min || '--'} mg/dL</span>
        </div>
        <div class="metric">
          <span class="metric-label">Maximum</span>
          <span class="metric-value">${glucoseSummary.max || '--'} mg/dL</span>
        </div>
        <div class="metric">
          <span class="metric-label">Total Readings</span>
          <span class="metric-value">${glucoseSummary.readings || 0}</span>
        </div>
        <div class="reference">Reference: Normal 70-100 • Prediabetic 100-125 • Diabetic ≥126 mg/dL (fasting)</div>
      </div>

      <!--Weight Section-- >
      <div class="card">
        <div class="card-title">⚖️ Weight Trend</div>
        <div class="metric">
          <span class="metric-label">Current Weight</span>
          <span class="metric-value">${weightTrend.current || '--'} kg</span>
        </div>
        <div class="metric">
          <span class="metric-label">Change</span>
          <span class="metric-value ${weightTrend.change > 0 ? 'warning' : 'normal'}">
            ${weightTrend.change > 0 ? '+' : ''}${weightTrend.change || 0} kg
          </span>
        </div>
      </div>

      <!--Lab Values Section-- >
            ${
                labValues.length > 0 ? `
        <div class="card">
          <div class="card-title">🔬 Key Lab Values</div>
          ${labValues.map(lab => `
            <div class="metric">
              <span class="metric-label">${lab.name}</span>
              <span class="metric-value ${getLabColor(lab.value, lab.referenceRange)}">${lab.value} ${lab.unit}</span>
            </div>
          `).join('')}
        </div>
      ` : ''
        }

        <div class="footer">
            <p>🔒 This is a read-only summary. Raw data is not shared.</p>
            <p>Powered by <a href="https://fitkarma.health">FitKarma</a></p>
        </div>
        `}
  </div>

  <script>
    function getBpColor(value, type) {
      if (!value) return '';
      if (type === 'systolic') {
        if (value < 120) return 'normal';
        if (value < 130) return 'warning';
        return 'danger';
      } else {
        if (value < 80) return 'normal';
        if (value < 85) return 'warning';
        return 'danger';
      }
    }

    function getGlucoseColor(value) {
      if (!value) return '';
      if (value < 100) return 'normal';
      if (value < 126) return 'warning';
      return 'danger';
    }

    function getLabColor(value, range) {
      // Simple check - could be enhanced
      if (!value || !range) return '';
      return '';
    }
  </script>
</body>
</html>
    `;

        res.send(html, 200, { 'Content-Type': 'text/html' });
    }

    /**
     * Render error page
     */
    function renderErrorPage(res, message) {
        renderHtmlPage(res, { error: message }, 'error');
    }

    /**
     * Helper functions for color coding
     */
    function getBpColor(value, type) {
        if (!value) return '';
        if (type === 'systolic') {
            if (value < 120) return 'normal';
            if (value < 130) return 'warning';
            return 'danger';
        } else {
            if (value < 80) return 'normal';
            if (value < 85) return 'warning';
            return 'danger';
        }
    }

    function getGlucoseColor(value) {
        if (!value) return '';
        if (value < 100) return 'normal';
        if (value < 126) return 'warning';
        return 'danger';
    }

    function getLabColor(value, range) {
        if (!value || !range) return '';
        return '';
    }
};