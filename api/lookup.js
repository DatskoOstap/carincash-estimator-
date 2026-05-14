export default async function handler(req, res) {
  if (req.method !== 'POST') return res.status(405).end();
  res.setHeader('Access-Control-Allow-Origin', '*');

  const { carName } = req.body || {};
  if (!carName) return res.status(400).json({ error: 'carName required' });

  const prompt = `Provide catalytic converter PGM data for: "${carName}". Return ONLY a raw JSON object, no markdown, no explanation:
{"name":"full car name","sub":"engine info","cats":1,"ptG":3.0,"pdG":3.0,"rhG":1.0,"tags":[],"tier":"average","notes":"short note"}
tier must be one of: top, strong, average, low, diesel
tags array can include zero or more of: hybrid, truck, euro, perf, top, diesel
ptG/pdG/rhG are average grams of Pt/Pd/Rh in one catalytic converter unit.
Diesel vehicles have rhG=0. EVs have all zeros and cats=0.`;

  try {
    const r = await fetch(
      `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${process.env.GEMINI_API_KEY}`,
      {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          contents: [{ parts: [{ text: prompt }] }],
          generationConfig: { temperature: 0.1, maxOutputTokens: 500 },
        }),
      }
    );
    const d = await r.json();
    const text = d.candidates?.[0]?.content?.parts?.[0]?.text || '';
    const match = text.match(/\{[\s\S]*?\}/);
    if (!match) throw new Error('No JSON in response');
    res.json(JSON.parse(match[0]));
  } catch (e) {
    res.status(500).json({ error: 'Car lookup failed' });
  }
}
