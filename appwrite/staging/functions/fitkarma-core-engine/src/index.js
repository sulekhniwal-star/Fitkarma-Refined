import fitbit from './handlers/fitbit.js';
import garmin from './handlers/garmin.js';
import razorpay from './handlers/razorpay.js';
import whatsapp from './handlers/whatsapp.js';
import fcm from './handlers/fcm.js';
import festival from './handlers/festival.js';
import reports from './handlers/reports.js';
import abha from './handlers/abha.js';

export default async ({ req, res, log, error }) => {
  const action = req.headers['x-action'] || req.body.action;

  log(`Received request for action: ${action}`);

  const handlers = {
    fitbit,
    garmin,
    razorpay,
    whatsapp,
    fcm,
    festival,
    reports,
    abha
  };

  const handler = handlers[action];

  if (handler) {
    return await handler({ req, res, log, error });
  }

  return res.json({
    message: 'Unknown action',
    success: false
  }, 404);
};
