// Razorpay Webhook Handler - Updated
// Verifies HMAC signature and updates subscriptions in Appwrite

const { Client, Databases, Query } = require("node-appwrite");
const crypto = require("crypto");

module.exports = async function (context) {
  const { req, res, log, error } = context;

  // Initialize Appwrite client
  const client = new Client()
    .setEndpoint(
      process.env.APPWRITE_ENDPOINT ||
      "https://cloud.appwrite.io/v1"
    )
    .setProject(process.env.APPWRITE_PROJECT_ID || "")
    .setKey(process.env.APPWRITE_API_KEY || "");

  const databases = new Databases(client);

  // Get Razorpay webhook secret from environment
  const webhookSecret = process.env.RAZORPAY_WEBHOOK_SECRET;

  if (!webhookSecret) {
    log("WARNING: RAZORPAY_WEBHOOK_SECRET not set");
  }

  try {
    // Get Razorpay signature from headers
    const razorpaySignature = req.headers["x-razorpay-signature"];

    // Verify HMAC signature if secret is available
    if (webhookSecret && razorpaySignature) {
      const payload = req.bodyRaw;
      const expectedSignature = crypto
        .createHmac("sha256", webhookSecret)
        .update(payload)
        .digest("hex");

      if (razorpaySignature !== expectedSignature) {
        error("Invalid webhook signature");
        return res.json(
          { success: false, error: "Invalid signature" },
          401
        );
      }
      log("Webhook signature verified successfully");
    }

    const payload = JSON.parse(req.body);
    log("Razorpay payload received:", JSON.stringify(payload, null, 2));

    // Handle different event types
    const event = payload.event;

    switch (event) {
      case "payment.captured":
        await handlePaymentCaptured(log, error, databases, payload);
        break;

      case "payment.failed":
        await handlePaymentFailed(log, error, databases, payload);
        break;

      case "subscription.charged":
        await handleSubscriptionCharged(log, payload);
        break;

      case "subscription.activated":
        await handleSubscriptionActivated(log, error, databases, payload);
        break;

      case "subscription.cancelled":
        await handleSubscriptionCancelled(log, error, databases, payload);
        break;

      default:
        log("Unhandled event type: " + event);
    }

    return res.json({ success: true, event: event });
  } catch (err) {
    error("Error processing webhook: " + err.message);
    return res.json({ success: false, error: err.message }, 500);
  }
};

// Handle successful payment
async function handlePaymentCaptured(log, error, databases, payload) {
  const payment = payload.payload.payment;
  const paymentId = payment.id;
  const amount = payment.amount / 100;
  const notes = payment.notes || {};

  log("Payment captured: " + paymentId + ", Amount: ₹" + amount);

  const userId = notes.userId || notes.user_id;

  if (!userId) {
    log("No userId found in payment notes");
    return;
  }

  const plan = determinePlanFromAmount(amount);
  const startDate = new Date();
  const endDate = calculateEndDate(plan, startDate);

  try {
    const existingSub = await databases.listDocuments(
      "fitkarma",
      "subscriptions",
      [Query.equal("userId", userId), Query.orderDesc("createdAt"), Query.limit(1)]
    );

    if (existingSub.documents.length > 0) {
      const existingDoc = existingSub.documents[0];
      await databases.updateDocument(
        "fitkarma",
        "subscriptions",
        existingDoc.$id,
        {
          status: "active",
          plan: plan,
          startDate: startDate.toISOString(),
          endDate: endDate.toISOString(),
          razorpayPaymentId: paymentId,
          razorpaySubscriptionId: payment.subscription_id || null,
          updatedAt: new Date().toISOString(),
        }
      );
      log("Updated existing subscription for user " + userId);
    } else {
      const subscriptionId = "sub_" + Date.now();
      await databases.createDocument(
        "fitkarma",
        "subscriptions",
        subscriptionId,
        {
          id: subscriptionId,
          userId: userId,
          plan: plan,
          status: "active",
          startDate: startDate.toISOString(),
          endDate: endDate.toISOString(),
          razorpayPaymentId: paymentId,
          razorpaySubscriptionId: payment.subscription_id || null,
          createdAt: startDate.toISOString(),
          updatedAt: startDate.toISOString(),
        }
      );
      log("Created new subscription for user " + userId);
    }

    await deleteArchivedData(log, databases, userId);
    log("Deleted archived data for user " + userId);
  } catch (err) {
    error("Error updating subscription: " + err.message);
    throw err;
  }
}

// Handle failed payment
async function handlePaymentFailed(log, error, databases, payload) {
  const payment = payload.payload.payment;
  const paymentId = payment.id;
  const notes = payment.notes || {};
  const userId = notes.userId || notes.user_id;

  log("Payment failed: " + paymentId);

  if (userId) {
    try {
      const existingSub = await databases.listDocuments(
        "fitkarma",
        "subscriptions",
        [Query.equal("userId", userId), Query.equal("status", "active")]
      );

      if (existingSub.documents.length > 0) {
        await databases.updateDocument(
          "fitkarma",
          "subscriptions",
          existingSub.documents[0].$id,
          {
            status: "cancelled",
            updatedAt: new Date().toISOString(),
          }
        );
      }
    } catch (err) {
      error("Error handling failed payment: " + err.message);
    }
  }
}

// Handle subscription charge (recurring)
async function handleSubscriptionCharged(log, payload) {
  const subscription = payload.payload.subscription;
  const subscriptionId = subscription.id;
  log("Subscription charged: " + subscriptionId);
}

// Handle subscription activated
async function handleSubscriptionActivated(log, error, databases, payload) {
  const subscription = payload.payload.subscription;
  const subscriptionId = subscription.id;
  const notes = subscription.notes || {};
  const userId = notes.userId || notes.user_id;

  log("Subscription activated: " + subscriptionId);

  if (userId) {
    const plan = subscription.plan_id || "monthly";
    const startDate = new Date();
    const endDate = calculateEndDateFromRazorpay(subscription);

    try {
      const subId = "sub_" + Date.now();
      await databases.createDocument(
        "fitkarma",
        "subscriptions",
        subId,
        {
          id: subId,
          userId: userId,
          plan: mapRazorpayPlanToApp(plan),
          status: "active",
          startDate: startDate.toISOString(),
          endDate: endDate.toISOString(),
          razorpaySubscriptionId: subscriptionId,
          createdAt: startDate.toISOString(),
          updatedAt: startDate.toISOString(),
        }
      );
    } catch (err) {
      error("Error creating subscription: " + err.message);
    }
  }
}

// Handle subscription cancelled
async function handleSubscriptionCancelled(log, error, databases, payload) {
  const subscription = payload.payload.subscription;
  const subscriptionId = subscription.id;
  const notes = subscription.notes || {};
  const userId = notes.userId || notes.user_id;

  log("Subscription cancelled: " + subscriptionId);

  if (userId) {
    try {
      const existingSub = await databases.listDocuments(
        "fitkarma",
        "subscriptions",
        [Query.equal("userId", userId), Query.equal("status", "active")]
      );

      if (existingSub.documents.length > 0) {
        await databases.updateDocument(
          "fitkarma",
          "subscriptions",
          existingSub.documents[0].$id,
          {
            status: "cancelled",
            updatedAt: new Date().toISOString(),
          }
        );
      }
    } catch (err) {
      error("Error cancelling subscription: " + err.message);
    }
  }
}

// Helper functions
function determinePlanFromAmount(amount) {
  if (amount === 99) return "monthly";
  if (amount === 249) return "quarterly";
  if (amount === 799) return "yearly";
  if (amount === 1499) return "family";
  return "monthly";
}

function calculateEndDate(plan, startDate) {
  var daysMap = {
    monthly: 30,
    quarterly: 90,
    yearly: 365,
    family: 365,
  };

  var days = daysMap[plan] || 30;
  var endDate = new Date(startDate);
  endDate.setDate(endDate.getDate() + days);

  return endDate;
}

function calculateEndDateFromRazorpay(subscription) {
  var startDate = new Date();
  var endDate = new Date(startDate);
  endDate.setMonth(endDate.getMonth() + 1);

  return endDate;
}

function mapRazorpayPlanToApp(razorpayPlan) {
  var planMap = {
    "plan_monthly": "monthly",
    "plan_quarterly": "quarterly",
    "plan_yearly": "yearly",
    "plan_family": "family",
  };

  return planMap[razorpayPlan] || "monthly";
}

async function deleteArchivedData(log, databases, userId) {
  try {
    var archivedData = await databases.listDocuments(
      "fitkarma",
      "archived_data",
      [Query.equal("userId", userId)]
    );

    for (var i = 0; i < archivedData.documents.length; i++) {
      var doc = archivedData.documents[i];
      await databases.deleteDocument("fitkarma", "archived_data", doc.$id);
    }
    log(
      "Deleted " + archivedData.documents.length + " archived data records"
    );
  } catch (err) {
    log("No archived data to delete or error: " + err.message);
  }
}
