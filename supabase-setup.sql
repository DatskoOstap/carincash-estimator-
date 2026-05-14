-- Run this entire file in your Supabase SQL editor (supabase.com → your project → SQL Editor)

-- 1. Create the cars table
CREATE TABLE IF NOT EXISTS cars (
  id          BIGSERIAL PRIMARY KEY,
  name        TEXT NOT NULL,
  sub         TEXT DEFAULT '',
  cats        INTEGER DEFAULT 1,
  pt_g        FLOAT DEFAULT 0,
  pd_g        FLOAT DEFAULT 0,
  rh_g        FLOAT DEFAULT 0,
  tags        TEXT[] DEFAULT '{}',
  tier        TEXT DEFAULT 'average',
  notes       TEXT DEFAULT '',
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Enable Row Level Security
ALTER TABLE cars ENABLE ROW LEVEL SECURITY;

-- 3. Allow any logged-in user to read/write all cars (shared list)
CREATE POLICY "Authenticated users can manage cars"
  ON cars FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- 4. Seed default cars (all 44 vehicles)
INSERT INTO cars (name, sub, cats, pt_g, pd_g, rh_g, tags, tier, notes) VALUES
('Ferrari F430',               'V8 · 2 cats',                       2, 8.0, 6.0, 3.0,  ARRAY['top'],    'top',     'Highest scrap cat ever'),
('Lamborghini Aventador',      'V12 6.5L · 2 cats',                 2, 7.0, 6.0, 2.5,  ARRAY['top'],    'top',     'Rare but worth a lot'),
('Toyota Land Cruiser',        'V8 · large SUV',                    2, 6.0, 5.0, 2.0,  ARRAY[]::TEXT[], 'top',     'Very popular in Canada'),
('Ram 2500 / 3500',            'Heavy duty V8',                     1, 6.0, 5.0, 2.0,  ARRAY['truck'],  'top',     'High theft target'),
('Ford F-250 / F-350 Super Duty','Torpedo-style cat',               2, 6.0, 4.0, 2.0,  ARRAY['truck'],  'top',     'Torpedo cats = $820 each'),
('Toyota Prius',               'All years · hybrid',                1, 5.0, 6.0, 2.0,  ARRAY['hybrid'], 'top',     'Most stolen in Canada'),
('Toyota Tundra',              'V8 pickup · sits high',             3, 5.0, 4.0, 1.5,  ARRAY[]::TEXT[], 'top',     '4-cat models very valuable'),
('Porsche Cayenne / Panamera', 'V6/V8 · Euro6',                    2, 4.0, 4.0, 2.0,  ARRAY['euro'],   'strong',  'Euro6 = premium loading'),
('BMW X5 / X7',                '3.0L or V8 luxury SUV',             2, 4.0, 4.0, 1.5,  ARRAY['euro'],   'strong',  ''),
('Mercedes-Benz GLE / E-Class','V6 or inline-6',                   2, 4.0, 3.5, 1.5,  ARRAY['euro'],   'strong',  ''),
('Toyota RAV4 Hybrid',         '2019+ · hybrid system',             1, 4.0, 5.0, 2.0,  ARRAY['hybrid'], 'strong',  'Hybrid = much more than gas RAV4'),
('Ford F-150 V8 5.0L',         '#1 selling in Canada',              2, 5.0, 4.0, 1.5,  ARRAY['truck'],  'strong',  'V6 EcoBoost = less'),
('Chevrolet Silverado 1500 V8 5.3L','Two cats on V8',              2, 4.0, 3.5, 1.5,  ARRAY[]::TEXT[], 'strong',  'High theft — 2 cats visible'),
('GMC Sierra 1500 / 2500',     'Same platform as Silverado',        2, 4.0, 3.5, 1.5,  ARRAY[]::TEXT[], 'strong',  ''),
('Chevrolet Tahoe / GMC Yukon','Full-size V8 SUV',                 2, 4.0, 3.5, 1.5,  ARRAY[]::TEXT[], 'strong',  ''),
('Toyota 4Runner',             'V6 · truck platform',               2, 4.0, 3.0, 1.5,  ARRAY[]::TEXT[], 'strong',  ''),
('Jeep Grand Cherokee V8 5.7L','Hemi engine',                      2, 4.0, 3.0, 1.5,  ARRAY[]::TEXT[], 'strong',  'V6 = much less'),
('Ford Mustang GT V8',         '5.0L Coyote',                       2, 4.0, 3.0, 1.5,  ARRAY['perf'],   'strong',  'V6 Mustang = $100–180'),
('Dodge Charger / Challenger V8','5.7L or 6.4L Hemi',             2, 4.0, 3.0, 1.5,  ARRAY['perf'],   'strong',  ''),
('Ford Expedition',            'V8 full-size SUV',                  2, 4.0, 3.0, 1.5,  ARRAY[]::TEXT[], 'strong',  ''),
('Ford Escape Hybrid',         '2.5L hybrid',                       1, 3.0, 4.0, 1.5,  ARRAY['hybrid'], 'strong',  ''),
('Honda CR-V',                 '2.0L / 1.5T · most popular SUV',   1, 3.0, 3.0, 1.0,  ARRAY[]::TEXT[], 'average', ''),
('Toyota RAV4 (gas)',          '2.5L · #1 SUV in Canada',           1, 3.0, 3.0, 1.0,  ARRAY[]::TEXT[], 'average', 'Hybrid version = 2× more'),
('Toyota Camry V6',            '3.5L',                              1, 3.0, 3.0, 1.0,  ARRAY[]::TEXT[], 'average', '4-cyl = lower'),
('Honda Accord V6',            '3.5L',                              1, 3.0, 3.0, 1.0,  ARRAY[]::TEXT[], 'average', ''),
('Dodge Grand Caravan / Chrysler','3.6L V6 · very common',         1, 3.0, 3.0, 1.0,  ARRAY[]::TEXT[], 'average', ''),
('Honda Odyssey',              'V6 minivan',                        1, 3.0, 3.5, 1.0,  ARRAY[]::TEXT[], 'average', ''),
('Ford Explorer V6 3.5L',      'Mid-size SUV',                      2, 3.0, 3.0, 1.0,  ARRAY[]::TEXT[], 'average', 'Varies a lot by year'),
('Jeep Wrangler V6',           '3.6L Pentastar',                    1, 3.0, 2.5, 1.0,  ARRAY[]::TEXT[], 'average', ''),
('Mazda CX-5 / Mazda 3',       'Skyactiv 2.0 / 2.5L',              1, 3.0, 3.0, 1.0,  ARRAY[]::TEXT[], 'average', ''),
('Hyundai Santa Fe / Tucson',  '2.0L / 2.5L GDI',                  1, 2.5, 3.0, 1.0,  ARRAY[]::TEXT[], 'average', ''),
('Kia Sorento / Sportage',     'Same platform as Hyundai',          1, 2.5, 3.0, 1.0,  ARRAY[]::TEXT[], 'average', ''),
('Nissan Rogue / Murano',      '2.5L / 3.5L',                      1, 2.5, 2.5, 1.0,  ARRAY[]::TEXT[], 'average', ''),
('Subaru Outback / Forester',  'Boxer 2.5L',                        1, 2.5, 2.5, 1.0,  ARRAY[]::TEXT[], 'average', 'Boxer = slightly less efficient'),
('Chevrolet Equinox / GMC Terrain','1.5T / 2.0T compact SUV',      1, 2.5, 2.5, 0.8,  ARRAY[]::TEXT[], 'average', ''),
('Nissan Altima / Sentra',     '2.0L / 2.5L sedan',                1, 2.5, 2.5, 0.8,  ARRAY[]::TEXT[], 'average', ''),
('Ford F-150 EcoBoost V6',     '2.7L / 3.5L EcoBoost',             2, 3.0, 3.0, 1.0,  ARRAY[]::TEXT[], 'average', 'Less than V8 version'),
('Honda Civic / Honda Fit',    '1.5T / 1.5L small',                1, 2.0, 2.0, 0.5,  ARRAY[]::TEXT[], 'low',     'Most common car in Canada'),
('Toyota Corolla',             '2.0L',                              1, 2.0, 2.0, 0.5,  ARRAY[]::TEXT[], 'low',     ''),
('Hyundai Elantra / Kia Forte','2.0L entry sedan',                 1, 2.0, 2.0, 0.4,  ARRAY[]::TEXT[], 'low',     ''),
('VW Jetta / Golf TDI',        'Diesel · no Rh',                   1, 3.0, 1.0, 0.0,  ARRAY['diesel'], 'diesel',  'Zero rhodium in diesel'),
('BMW 3 Series diesel',        '320d / 330d',                       1, 3.5, 1.0, 0.0,  ARRAY['diesel'], 'diesel',  'Despite BMW name — no Rh'),
('Any EV (Tesla / Bolt / Leaf)','No combustion engine',            0, 0.0, 0.0, 0.0,  ARRAY[]::TEXT[], 'low',     'Nothing to sell'),
('Aftermarket / universal cat','Any car · replacement part',        1, 0.3, 0.2, 0.05, ARRAY[]::TEXT[], 'low',     '~10% of OEM content');
