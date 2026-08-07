// Vérifie que le seed GQS est bien en base : compte les lignes de chaque table.
// Usage : node scripts/check-seed.mjs
import { readFileSync } from 'node:fs';
import { createClient } from '@supabase/supabase-js';

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
const url = env.VITE_SUPABASE_URL;
const anon = env.VITE_SUPABASE_ANON_KEY;

if (!url || !anon) {
  console.error('Manque VITE_SUPABASE_URL / VITE_SUPABASE_ANON_KEY dans .env.local');
  process.exit(1);
}

const supabase = createClient(url, anon, { auth: { persistSession: false } });

const expected = {
  themes: 2,
  memo_cards: 14,
  questions: 19,
  quizzes: 3,
  badges: 4,
};

let allOk = true;
console.log('Table            | Attendu | Réel  | OK');
console.log('---------------- | ------- | ----- | --');
for (const [table, want] of Object.entries(expected)) {
  const { count, error } = await supabase.from(table).select('*', { count: 'exact', head: true });
  if (error) {
    console.log(`${table.padEnd(16)} | ${String(want).padStart(7)} | ERROR | ✗   ${error.message}`);
    allOk = false;
    continue;
  }
  const ok = count === want;
  if (!ok) allOk = false;
  console.log(
    `${table.padEnd(16)} | ${String(want).padStart(7)} | ${String(count ?? '?').padStart(5)} | ${ok ? '✓' : '✗'}`,
  );
}

if (!allOk) {
  console.error('\n✗ Écart détecté. Vérifie que schema.sql PUIS seed-gqs.sql ont été exécutés dans le bon ordre.');
  process.exit(1);
}
console.log('\n✓ Seed conforme.');
