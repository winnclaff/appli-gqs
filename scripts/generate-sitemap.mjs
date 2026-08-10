// Génère public/sitemap.xml à partir du contenu réel en base.
// Le niveau fait partie de l'URL (/reviser/:level, /quiz/:level,
// /themes/:level/:themeId) pour que chaque référentiel soit indexable
// séparément. On ne liste que les combinaisons thème×niveau qui ont
// effectivement du contenu (mêmes règles que fetchThemesForLevel côté app),
// pour éviter d'envoyer les crawlers vers des pages vides.
// À relancer manuellement après un changement notable de contenu.
// Usage : node scripts/generate-sitemap.mjs
import { readFileSync, writeFileSync } from 'node:fs';
import { createClient } from '@supabase/supabase-js';

const SITE_URL = 'https://gentle-sherbet-52e2cd.netlify.app';
const LEVELS = ['grand_public', 'psc', 'pse', 'afgsu'];

function loadEnv() {
  const raw = readFileSync(new URL('../.env.local', import.meta.url), 'utf8');
  const env = {};
  for (const line of raw.split(/\r?\n/)) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith('#')) continue;
    const eq = trimmed.indexOf('=');
    if (eq === -1) continue;
    env[trimmed.slice(0, eq).trim()] = trimmed.slice(eq + 1).trim();
  }
  return env;
}

const env = loadEnv();
const supabase = createClient(env.VITE_SUPABASE_URL, env.VITE_SUPABASE_ANON_KEY, {
  auth: { persistSession: false },
});

const [{ data: themes, error: tErr }, { data: cards, error: cErr }, { data: questions, error: qErr }] =
  await Promise.all([
    supabase.from('themes').select('id'),
    supabase.from('memo_cards').select('theme_id, levels'),
    supabase.from('questions').select('theme_id, levels'),
  ]);

for (const [label, err] of [['themes', tErr], ['memo_cards', cErr], ['questions', qErr]]) {
  if (err) {
    console.error(`Erreur lecture ${label}:`, err.message);
    process.exit(1);
  }
}

const urls = ['/', '/badges'];

for (const level of LEVELS) {
  urls.push(`/reviser/${level}`, `/quiz/${level}`);
  const activeThemeIds = new Set([
    ...cards.filter((c) => c.levels.includes(level)).map((c) => c.theme_id),
    ...questions.filter((q) => q.levels.includes(level)).map((q) => q.theme_id),
  ]);
  for (const theme of themes) {
    if (activeThemeIds.has(theme.id)) urls.push(`/themes/${level}/${theme.id}`);
  }
}

const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls.map((u) => `  <url><loc>${SITE_URL}${u}</loc></url>`).join('\n')}
</urlset>
`;

writeFileSync(new URL('../public/sitemap.xml', import.meta.url), xml);
console.log(`✓ sitemap.xml généré avec ${urls.length} URLs.`);
