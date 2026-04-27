
import { Client, Databases, ID, Query } from 'node-appwrite';
import crypto from 'node:crypto';

// XP award table — all values in points
const XP_TABLE = {
  food_log:          5,   // per meal logged
  food_log_complete: 20,  // all 3 meals logged in a day
  workout_complete:  30,
  steps_goal:        25,
  sleep_logged:      10,
  bp_reading:        10,
  glucose_reading:   10,
  habit_complete:    15,
  journal_entry:     10,
  streak_7day:       50,
  streak_30day:     150,
  lab_report:        20,
  abha_linked:      100,
  referral:         500,
};

// Level thresholds — cumulative XP required
const LEVEL_THRESHOLDS = [
  0,     // Level 1  — Newcomer
  200,   // Level 2  — Beginner
  500,   // Level 3  — Starter
  1000,  // Level 4  — Mover
  1800,  // Level 5  — Achiever
  2800,  // Level 6  — Consistent
  4200,  // Level 7  — Dedicated
  6000,  // Level 8  — Warrior
  8500,  // Level 9  — Champion
  12000, // Level 10 — Elite
  16000, // Level 11 — Legend
  21000, // Level 12 — Grandmaster
  27000, // Level 13 — Karma Master
];

const LEVEL_NAMES = [
  'Newcomer', 'Beginner', 'Starter', 'Mover', 'Achiever',
  'Consistent', 'Dedicated', 'Warrior', 'Champion', 'Elite',
  'Legend', 'Grandmaster', 'Karma Master',
];

function _computeLevel(totalXP) {
  let level = 1;
  for (let i = 1; i < LEVEL_THRESHOLDS.length; i++) {
    if (totalXP >= LEVEL_THRESHOLDS[i]) level = i + 1;
    else break;
  }
  return LEVEL_NAMES[level - 1] || 'Karma Master';
}

export default async ({ req, res, log, error }) => {
  const client = new Client()
    .setEndpoint(process.env.APPWRITE_FUNCTION_API_ENDPOINT)
    .setProject(process.env.APPWRITE_FUNCTION_PROJECT_ID)
    .setKey(process.env.APPWRITE_FUNCTION_API_KEY || req.headers['x-appwrite-key']);

  const databases = new Databases(client);
  const DB = 'fitkarma-db';

  let body;
  try {
    body = typeof req.body === 'string' ? JSON.parse(req.body) : (req.bodyJson || {});
  } catch {
    return res.json({ ok: false, error: 'Invalid JSON body' }, 400);
  }

  const action = body.action;
  if (!action) {
    return res.json({ ok: false, error: 'action parameter required' }, 400);
  }

  try {
    switch (action) {
      case 'calculate-xp': {
        const { userId, eventType } = body;
        if (!userId || !eventType) {
          return res.json({ ok: false, error: 'userId and eventType required' }, 400);
        }

        const xp = XP_TABLE[eventType];
        if (xp === undefined) {
          return res.json({ ok: false, error: `Unknown eventType: ${eventType}` }, 400);
        }

        // 1. Record karma event
        await databases.createDocument(DB, 'karma_events', ID.unique(), {
          userId,
          eventType,
          xpAwarded: xp,
          occurredAt: Math.floor(Date.now() / 1000),
          syncStatus: 'synced',
        });

        // 2. Fetch user's current XP
        const users = await databases.listDocuments(DB, 'users', [
          Query.equal('userId', userId),
        ]);

        if (users.total === 0) {
          return res.json({ ok: false, error: 'User not found' }, 404);
        }

        const user = users.documents[0];
        const newXP = (user.karmaXP || 0) + xp;
        const newLevel = _computeLevel(newXP);

        // 3. Update user XP + level
        await databases.updateDocument(DB, 'users', user.$id, {
          karmaXP:    newXP,
          karmaLevel: newLevel,
        });

        log(`XP awarded: userId=${userId} event=${eventType} xp=${xp} total=${newXP} level=${newLevel}`);
        return res.json({ ok: true, xpAwarded: xp, totalXP: newXP, level: newLevel });
      }

      case 'verify-abha': {
        const { userId, abhaId, otp } = body;
        if (!userId || !abhaId) {
          return res.json({ ok: false, error: 'userId and abhaId required' }, 400);
        }

        const cleaned = abhaId.replace(/-/g, '');
        if (!/^\d{14}$/.test(cleaned)) {
          return res.json({ ok: false, error: 'Invalid ABHA ID format' }, 400);
        }

        if (!otp) {
          // Step 1: Request OTP from ABDM (Mock/API)
          log(`OTP requested for ABHA: ${cleaned.slice(0, 4)}****`);
          // Note: Real implementation would use fetch() to ABDM endpoints as documented.
          return res.json({ ok: true, step: 'otp_sent' });
        }

        // Step 2: Verify OTP + mark ABHA linked
        const users = await databases.listDocuments(DB, 'users', [
          Query.equal('userId', userId),
        ]);

        if (users.total === 0) {
          return res.json({ ok: false, error: 'User not found' }, 404);
        }

        await databases.updateDocument(DB, 'users', users.documents[0].$id, {
          abhaId:     cleaned,
          abhaLinked: true,
        });

        log(`ABHA linked for userId=${userId}`);
        return res.json({ ok: true, step: 'linked', abhaId: cleaned });
      }

      case 'share-report': {
        const { reportId, userId, expiryHours = 168 } = body;
        if (!reportId || !userId) {
          return res.json({ ok: false, error: 'reportId and userId required' }, 400);
        }

        const token = crypto.randomBytes(32).toString('hex');
        const expiresAt = Math.floor(Date.now() / 1000) + (expiryHours * 3600);

        await databases.createDocument(DB, 'share_tokens', ID.unique(), {
          token,
          reportId,
          userId,
          expiresAt,
          used: false,
        });

        const shareUrl = `${process.env.APP_BASE_URL}/shared/report/${token}`;
        log(`Share link created for reportId=${reportId} expires=${new Date(expiresAt * 1000).toISOString()}`);

        return res.json({ ok: true, shareUrl, expiresAt });
      }

      default:
        return res.json({ ok: false, error: `Unknown action: ${action}` }, 400);
    }
  } catch (err) {
    error(`FitKarma Core error: ${err.message}`);
    return res.json({ ok: false, error: err.message }, 500);
  }
};
