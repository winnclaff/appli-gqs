// Valide le contenu actuellement en base avant/après une exécution SQL.
// Usage : node scripts/validate-content.mjs
//
// Attrape les erreurs de saisie classiques lors d'un sync Notion -> SQL :
// mauvais nombre de choix, index de bonne réponse hors bornes, champs vides,
// levels/referentiel_codes vides ou avec une valeur inconnue.
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

const VALID_LEVELS = new Set(['grand_public', 'psc', 'pse', 'afgsu']);
const VALID_REFERENTIELS = new Set(['gqs', 'psc', 'pse', 'afgsu', 'sse_2024', 'damage_control']);

const errors = [];
const warnings = [];

function err(scope, id, message) {
  errors.push(`✗ [${scope} ${id}] ${message}`);
}
function warn(scope, id, message) {
  warnings.push(`! [${scope} ${id}] ${message}`);
}

// ---------- Questions ----------
const { data: questions, error: qError } = await supabase.from('questions').select('*');
if (qError) {
  console.error('Erreur lecture questions:', qError.message);
  process.exit(1);
}

const seenNumbers = new Map();
for (const q of questions) {
  const label = q.question_number != null ? `N°${q.question_number}` : q.id.slice(0, 8);

  if (!Array.isArray(q.choices) || q.choices.length !== 4) {
    err('question', label, `doit avoir exactement 4 choix, en a ${q.choices?.length ?? 0}`);
  } else if (q.choices.some((c) => !c || !String(c).trim())) {
    err('question', label, 'contient un choix vide');
  }

  if (
    typeof q.correct_choice_index !== 'number' ||
    q.correct_choice_index < 0 ||
    q.correct_choice_index > 3
  ) {
    err('question', label, `correct_choice_index invalide (${q.correct_choice_index})`);
  }

  if (!q.question_text || !q.question_text.trim()) {
    err('question', label, 'question_text vide');
  }
  if (!q.explanation || !q.explanation.trim()) {
    err('question', label, 'explanation (justification) vide');
  }
  if (!q.source_name || !q.source_name.trim()) {
    err('question', label, 'source_name vide');
  }
  if (!q.theme_id) {
    err('question', label, 'theme_id manquant');
  }

  if (!Array.isArray(q.levels) || q.levels.length === 0) {
    err('question', label, 'levels vide');
  } else {
    for (const l of q.levels) {
      if (!VALID_LEVELS.has(l)) err('question', label, `level inconnu "${l}"`);
    }
  }
  if (!Array.isArray(q.referentiel_codes) || q.referentiel_codes.length === 0) {
    warn('question', label, 'referentiel_codes vide');
  } else {
    for (const r of q.referentiel_codes) {
      if (!VALID_REFERENTIELS.has(r)) warn('question', label, `referentiel_code inconnu "${r}"`);
    }
  }

  if (q.question_number != null) {
    if (seenNumbers.has(q.question_number)) {
      err('question', label, `N° en double avec ${seenNumbers.get(q.question_number)}`);
    }
    seenNumbers.set(q.question_number, q.id);
  }
}

// ---------- Memo cards ----------
const { data: cards, error: cError } = await supabase.from('memo_cards').select('*');
if (cError) {
  console.error('Erreur lecture memo_cards:', cError.message);
  process.exit(1);
}

for (const c of cards) {
  const label = c.title || c.id.slice(0, 8);

  if (!Array.isArray(c.action_steps) || c.action_steps.length === 0) {
    err('memo_card', label, 'action_steps vide ou absent');
  } else if (c.action_steps.some((s) => !s || !String(s).trim())) {
    err('memo_card', label, 'contient une étape vide');
  }

  if (!c.source_name || !c.source_name.trim()) {
    err('memo_card', label, 'source_name vide');
  }
  if (!c.theme_id) {
    err('memo_card', label, 'theme_id manquant');
  }

  if (!Array.isArray(c.levels) || c.levels.length === 0) {
    err('memo_card', label, 'levels vide');
  } else {
    for (const l of c.levels) {
      if (!VALID_LEVELS.has(l)) err('memo_card', label, `level inconnu "${l}"`);
    }
  }
}

// ---------- Thèmes orphelins (aucun contenu, tous niveaux confondus) ----------
const { data: themes } = await supabase.from('themes').select('id,title');
const activeThemeIds = new Set([
  ...questions.map((q) => q.theme_id),
  ...cards.map((c) => c.theme_id),
]);
for (const t of themes ?? []) {
  if (!activeThemeIds.has(t.id)) {
    warn('theme', t.title, 'aucune fiche ni question, tous niveaux confondus');
  }
}

// ---------- Rapport ----------
console.log(`Vérifié : ${questions.length} questions, ${cards.length} fiches, ${themes?.length ?? 0} thèmes.\n`);

if (warnings.length) {
  console.log('Avertissements :');
  for (const w of warnings) console.log(' ', w);
  console.log();
}

if (errors.length) {
  console.log('Erreurs :');
  for (const e of errors) console.log(' ', e);
  console.log(`\n✗ ${errors.length} erreur(s) trouvée(s).`);
  process.exit(1);
}

console.log('✓ Contenu valide, aucune erreur détectée.');
