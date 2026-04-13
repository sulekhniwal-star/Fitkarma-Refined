export default async ({ req, res, log, error }) => { log('Executing whatsapp handler'); return res.json({ message: 'Hello from whatsapp handler' }); };
