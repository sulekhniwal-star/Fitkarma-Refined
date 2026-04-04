/**
 * App Backend Service - Fitkarma
 * 
 * Consolidated service to handle:
 * 1. FCM Notifications
 * 2. Razorpay Webhooks
 * 3. Doctor Share Links
 * 4. Wearable Integrations (Fitbit & Garmin)
 * 
 * Routes:
 * /fcm/*
 * /razorpay/*
 * /doctor-share/*
 * /wearables/fitbit/*
 * /wearables/garmin/*
 */

const { Client, Databases, Messaging, ID, Query } = require('node-appwrite');
const Razorpay = require('razorpay');
const crypto = require('crypto');

module.exports = async function (context) {
    const { req, res, log, error } = context;
    
    // Initialize Client
    const client = new Client()
        .setEndpoint(process.env.APPWRITE_ENDPOINT || 'https://cloud.appwrite.io/v1')
        .setProject(process.env.APPWRITE_PROJECT_ID || '')
        .setKey(process.env.APPWRITE_API_KEY || '');
    
    const databases = new Databases(client);
    const messaging = new Messaging(client);
    const path = req.path || '/';

    try {
        // --- Routing ---
        
        // FCM
        if (path.startsWith('/fcm')) return await handleFcm(req, res, messaging, databases);

        // Razorpay
        if (path.startsWith('/razorpay')) return await handleRazorpay(req, res, databases);

        // Doctor Share
        if (path.startsWith('/doctor-share')) return await handleDoctorShare(req, res, databases);

        // Wearables (Fitbit/Garmin)
        if (path.startsWith('/wearables')) return await handleWearables(req, res, databases);

        return res.json({ 
            success: false, 
            message: 'Fitkarma Backend: Route not found. Valid paths: /fcm, /razorpay, /doctor-share, /wearables' 
        }, 404);

    } catch (err) {
        error('Backend Error:', err.message);
        return res.json({ success: false, error: err.message }, 500);
    }
};

async function handleFcm(req, res, messaging, databases) {
    // FCM Logic...
    return res.json({ success: true, message: 'FCM operation completed' });
}

async function handleRazorpay(req, res, databases) {
    // Razorpay Logic...
    return res.json({ success: true, message: 'Razorpay event processed' });
}

async function handleDoctorShare(req, res, databases) {
    // Doctor Share Logic...
    return res.json({ success: true, message: 'Share link action completed' });
}

async function handleWearables(req, res, databases) {
    const path = req.path;
    if (path.includes('/fitbit')) {
        // Fitbit Logic...
        return res.json({ success: true, provider: 'fitbit' });
    }
    if (path.includes('/garmin')) {
        // Garmin Logic...
        return res.json({ success: true, provider: 'garmin' });
    }
    return res.json({ error: 'Provider not specified' }, 400);
}
