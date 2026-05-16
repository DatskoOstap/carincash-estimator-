export default async function handler(req, res) {
  if (req.method !== 'GET') return res.status(405).end();
  res.setHeader('Access-Control-Allow-Origin', '*');

  try {
    const r = await fetch(
      `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${process.env.GEMINI_API_KEY}`,
      {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          contents: [{ parts: [{ text: 'What are the current spot prices today for platinum, palladium, and rhodium in USD per troy ounce? Return ONLY a raw JSON object, no markdown: {"ptOz": 1234, "pdOz": 1234, "rhOz": 1234}' }] }],
          tools: [{ googleSearch: {} }],
        }),
      }
    );
    const d = await r.json();
    const text = d.candidates?.[0]?.content?.parts?.find(p => p.text)?.text || '';
    const match = text.match(/\{[^}]*"ptOz"[^}]*\}/);
    if (!match) throw new Error('No price data in response');
    res.json(JSON.parse(match[0]));
  } catch (e) {
    res.status(500).json({ error: 'Price fetch failed' });
  }
}
