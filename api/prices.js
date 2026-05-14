export default async function handler(req, res) {
  if (req.method !== 'GET') return res.status(405).end();
  res.setHeader('Access-Control-Allow-Origin', '*');

  try {
    const r = await fetch(
      `https://api.metals.dev/v1/latest?api_key=${process.env.METALS_API_KEY}&currency=USD&unit=toz`
    );
    const d = await r.json();
    const m = d.metals || {};
    res.json({
      ptOz: m.platinum || 0,
      pdOz: m.palladium || 0,
      rhOz: m.rhodium || 0,
    });
  } catch (e) {
    res.status(500).json({ error: 'Price fetch failed' });
  }
}
