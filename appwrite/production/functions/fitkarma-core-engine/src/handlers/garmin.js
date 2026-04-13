export default async ({ req, res, log, error }) => { log('Executing garmin handler'); return res.json({ message: 'Hello from garmin handler' }); };
