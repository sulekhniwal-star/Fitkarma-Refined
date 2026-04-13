export default async ({ req, res, log, error }) => { log('Executing festival handler'); return res.json({ message: 'Hello from festival handler' }); };
