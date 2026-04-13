export default async ({ req, res, log, error }) => { log('Executing fitbit handler'); return res.json({ message: 'Hello from fitbit handler' }); };
