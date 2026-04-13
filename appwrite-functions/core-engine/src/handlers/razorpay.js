export default async ({ req, res, log, error }) => { log('Executing razorpay handler'); return res.json({ message: 'Hello from razorpay handler' }); };
