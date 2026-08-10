import { supabase } from './supabase';
import type { Question, Theme, MemoCard, Referentiel, Badge, Level } from '../types/domain';

const GQS_CODE = 'gqs';

// ---------- Cache mémoire (durée de session) ----------
// Le contenu ne change que via reseed Supabase + redeploy, jamais pendant une
// session utilisateur : on peut donc le mettre en cache sans risque de le
// servir périmé. Ça évite un refetch + spinner à chaque navigation
// Home <-> Thème <-> Quiz, ce qui compte pour un outil consulté en urgence.
const cache = new Map<string, Promise<unknown>>();

function cached<T>(key: string, fetcher: () => Promise<T>): Promise<T> {
  if (!cache.has(key)) {
    const promise = fetcher().catch((e) => {
      cache.delete(key);
      throw e;
    });
    cache.set(key, promise as Promise<unknown>);
  }
  return cache.get(key) as Promise<T>;
}

function getAllThemes(): Promise<Theme[]> {
  return cached('themes:all', async () => {
    const { data, error } = await supabase
      .from('themes')
      .select('*')
      .order('sort_order', { ascending: true });
    if (error) throw error;
    return (data ?? []) as Theme[];
  });
}

function getMemoCardsForLevel(level: Level): Promise<MemoCard[]> {
  return cached(`memo_cards:${level}`, async () => {
    const { data, error } = await supabase
      .from('memo_cards')
      .select('*')
      .contains('levels', [level])
      .order('sort_order', { ascending: true });
    if (error) throw error;
    return (data ?? []) as MemoCard[];
  });
}

function getQuestionsForLevel(level: Level): Promise<Question[]> {
  return cached(`questions:${level}`, async () => {
    const { data, error } = await supabase
      .from('questions')
      .select('*')
      .contains('levels', [level]);
    if (error) throw error;
    return (data ?? []) as Question[];
  });
}

export async function fetchGqsReferentiel(): Promise<Referentiel> {
  return cached('referentiel:gqs', async () => {
    const { data, error } = await supabase
      .from('referentiels')
      .select('*')
      .eq('code', GQS_CODE)
      .single();
    if (error) throw error;
    return data as Referentiel;
  });
}

// Retourne uniquement les thèmes qui ont au moins une fiche ou une question
// pour le niveau demandé. Évite d'afficher un thème vide dans la Home.
export async function fetchThemesForLevel(level: Level): Promise<Theme[]> {
  const [themes, cards, questions] = await Promise.all([
    getAllThemes(),
    getMemoCardsForLevel(level),
    getQuestionsForLevel(level),
  ]);
  const activeThemeIds = new Set<string>([
    ...cards.map((c) => c.theme_id),
    ...questions.map((q) => q.theme_id),
  ]);
  return themes.filter((t) => activeThemeIds.has(t.id));
}

export async function fetchTheme(themeId: string): Promise<Theme> {
  const themes = await getAllThemes();
  const theme = themes.find((t) => t.id === themeId);
  if (!theme) throw new Error('Thème introuvable');
  return theme;
}

export async function fetchMemoCards(themeId: string, level: Level): Promise<MemoCard[]> {
  const cards = await getMemoCardsForLevel(level);
  return cards.filter((c) => c.theme_id === themeId);
}

// Insert-only : aucune policy SELECT publique sur error_reports, donc pas de
// lecture possible depuis le client. Louis consulte via le Table Editor
// Supabase (session admin, contourne RLS).
export async function reportQuestionError(
  questionId: string,
  questionNumber: number | null,
): Promise<void> {
  const { error } = await supabase
    .from('error_reports')
    .insert({ question_id: questionId, question_number: questionNumber });
  if (error) throw error;
}

export async function fetchBadges(): Promise<Badge[]> {
  return cached('badges:all', async () => {
    const { data, error } = await supabase
      .from('badges')
      .select('*')
      .order('criteria_value', { ascending: true });
    if (error) throw error;
    return (data ?? []) as Badge[];
  });
}

function shuffle<T>(arr: T[]): T[] {
  const out = arr.slice();
  for (let i = out.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [out[i], out[j]] = [out[j], out[i]];
  }
  return out;
}

export async function fetchQuizQuestions(params: {
  mode: 'theme' | 'mixed' | 'review';
  themeId?: string;
  questionIds?: string[];
  level: Level;
  count: number;
}): Promise<Question[]> {
  const { mode, themeId, questionIds, level, count } = params;
  if (mode === 'theme' && !themeId) throw new Error('themeId requis en mode theme');

  const all = await getQuestionsForLevel(level);
  let pool: Question[];
  if (mode === 'review') {
    const idSet = new Set(questionIds ?? []);
    pool = all.filter((q) => idSet.has(q.id));
  } else if (mode === 'theme') {
    pool = all.filter((q) => q.theme_id === themeId);
  } else {
    pool = all;
  }
  return shuffle(pool).slice(0, count);
}

// Toutes les questions d'un thème pour un niveau donné (pas de tirage) —
// sert à afficher la progression ("X/Y maîtrisées") sur l'écran thème.
export async function fetchQuestionsForTheme(themeId: string, level: Level): Promise<Question[]> {
  const all = await getQuestionsForLevel(level);
  return all.filter((q) => q.theme_id === themeId);
}

// Sous-ensemble d'un pool de questions par id, filtré par niveau — sert au
// mode "review" pour compter combien de questions ratées restent
// disponibles au niveau actuel avant de lancer le quiz.
export async function fetchQuestionsByIds(ids: string[], level: Level): Promise<Question[]> {
  if (ids.length === 0) return [];
  const all = await getQuestionsForLevel(level);
  const idSet = new Set(ids);
  return all.filter((q) => idSet.has(q.id));
}

// Recherche full-text simple côté client pour la Home.
// Le dataset (~60 questions, ~40 fiches) est petit et déjà en cache mémoire
// après le premier chargement du niveau : la recherche ne fait plus aucun
// aller-retour réseau après ça.
export type SearchHit =
  | { kind: 'memo_card'; card: MemoCard; theme: Theme }
  | { kind: 'question'; question: Question; theme: Theme };

export async function searchAll(query: string, level: Level): Promise<SearchHit[]> {
  const needle = query.trim().toLowerCase();
  if (needle.length < 2) return [];

  const [themes, cards, questions] = await Promise.all([
    getAllThemes(),
    getMemoCardsForLevel(level),
    getQuestionsForLevel(level),
  ]);
  const themesById = new Map<string, Theme>();
  for (const t of themes) themesById.set(t.id, t);

  const hits: SearchHit[] = [];

  for (const c of cards) {
    const haystack = [c.title, ...(Array.isArray(c.action_steps) ? c.action_steps : [])]
      .join(' \n ')
      .toLowerCase();
    if (haystack.includes(needle)) {
      const theme = themesById.get(c.theme_id);
      if (theme) hits.push({ kind: 'memo_card', card: c, theme });
    }
  }

  for (const q of questions) {
    const haystack = [q.question_text, q.explanation, ...(q.choices ?? [])]
      .join(' \n ')
      .toLowerCase();
    if (haystack.includes(needle)) {
      const theme = themesById.get(q.theme_id);
      if (theme) hits.push({ kind: 'question', question: q, theme });
    }
  }

  return hits;
}
