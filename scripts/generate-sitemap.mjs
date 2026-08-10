// Génère public/sitemap.xml à partir des thèmes réels en base.
// À relancer manuellement après un changement notable de contenu (nouveaux
// thèmes). Pas automatisé au build : le contenu change rarement.
// Usage : node scripts/generate-sitemap.mjs
import { readFileSync, writeFileSync } from 'node:fs';
import { createClient } from '@supabase/supabase-js';

const SITE_URL = 'https://gentle-sherbet-52e2cd.netlify.app';

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

const { data: themes, error } = await supabase.from('themes').select('id').order('sort_order');
if (error) {
  console.error('Erreur lecture themes:', error.message);
  process.exit(1);
}

const staticUrls = ['/', '/reviser', '/quiz', '/badges'];
const themeUrls = themes.map((t) => `/themes/${t.id}`);
const urls = [...staticUrls, ...themeUrls];

const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls.map((u) => `  <url><loc>${SITE_URL}${u}</loc></url>`).join('\n')}
</urlset>
`;

writeFileSync(new URL('../public/sitemap.xml', import.meta.url), xml);
console.log(`✓ sitemap.xml généré avec ${urls.length} URLs (${staticUrls.length} statiques + ${themeUrls.length} thèmes).`);
