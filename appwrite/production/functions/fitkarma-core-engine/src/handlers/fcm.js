export default async ({ req, res, log, error }) => { log('Executing fcm handler'); return res.json({ message: 'Hello from fcm handler' }); };
