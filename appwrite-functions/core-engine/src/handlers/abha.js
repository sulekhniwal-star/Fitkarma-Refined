export default async ({ req, res, log, error }) => { log('Executing abha handler'); return res.json({ message: 'Hello from abha handler' }); };
