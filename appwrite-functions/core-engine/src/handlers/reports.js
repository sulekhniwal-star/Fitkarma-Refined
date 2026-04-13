export default async ({ req, res, log, error }) => { log('Executing reports handler'); return res.json({ message: 'Hello from reports handler' }); };
