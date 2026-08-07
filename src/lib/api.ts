import { supabase } from './supabase';
import type { Question, Theme, MemoCard, Referentiel, Badge, Level } from '../types/domain';

const GQS_CODE = 'gqs';

export async function fetchGqsReferentiel(): Promise<Referentiel> {
  const { data, error } = await supabase
    .from('referentiels')
    .select('*')
    .eq('code', GQS_CODE)
    .single();
  if (error) throw error;
  return data as Referentiel;
}

// Retourne uniquement les thèmes qui ont au moins une fiche ou une question
// pour le niveau demandé. Évite d'afficher un thème vide dans la Home.
export async function fetchThemesForLevel(level: Level): Promise<Theme[]> {
  const [themes, cards, questions] = await Promise.all([
    supabase.from('themes').select('*').order('sort_order', { ascending: true }),
    supabase.from('memo_cards').select('theme_id').contains('levels', [level]),
    supabase.from('questions').select('theme_id').contains('levels', [level]),
  ]);
  if (themes.error) throw themes.error;
  if (cards.error) throw cards.error;
  if (questions.error) throw questions.error;
  const activeThemeIds = new Set<string>([
    ...(cards.data ?? []).map((r) => (r as { theme_id: string }).theme_id),
    ...(questions.data ?? []).map((r) => (r as { theme_id: string }).theme_id),
  ]);
  return (themes.data ?? []).filter((t) => activeThemeIds.has((t as Theme).id)) as Theme[];
}

export async function fetchTheme(themeId: string): Promise<Theme> {
  const { data, error } = await supabase.from('themes').select('*').eq('id', themeId).single();
  if (error) throw error;
  return data as Theme;
}

export async function fetchMemoCards(themeId: string, level: Level): Promise<MemoCard[]> {
  const { data, error } = await supabase
    .from('memo_cards')
    .select('*')
    .eq('theme_id', themeId)
    .contains('levels', [level])
    .order('sort_order', { ascending: true });
  if (error) throw error;
  return (data ?? []) as MemoCard[];
}

export async function fetchBadges(): Promise<Badge[]> {
  const { data, error } = await supabase
    .from('badges')
    .select('*')
    .order('criteria_value', { ascending: true });
  if (error) throw error;
  return (data ?? []) as Badge[];
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
  mode: 'theme' | 'mixed';
  themeId?: string;
  level: Level;
  count: number;
}): Promise<Question[]> {
  const { mode, themeId, level, count } = params;

  let query = supabase.from('questions').select('*').contains('levels', [level]);
  if (mode === 'theme') {
    if (!themeId) throw new Error('themeId requis en mode theme');
    query = query.eq('theme_id', themeId);
  }
  const { data, error } = await query;
  if (error) throw error;

  const rows = (data ?? []) as Question[];
  return shuffle(rows).slice(0, count);
}

// Recherche full-text simple côté client pour la Home.
// Le dataset (~60 questions, ~15 fiches) est petit : on récupère tout pour le niveau
// puis on filtre en JS, plus simple qu'une full-text côté Postgres.
export type SearchHit =
  | { kind: 'memo_card'; card: MemoCard; theme: Theme }
  | { kind: 'question'; question: Question; theme: Theme };

export async function searchAll(query: string, level: Level): Promise<SearchHit[]> {
  const needle = query.trim().toLowerCase();
  if (needle.length < 2) return [];

  const [themesRes, cardsRes, questionsRes] = await Promise.all([
    supabase.from('themes').select('*'),
    supabase.from('memo_cards').select('*').contains('levels', [level]),
    supabase.from('questions').select('*').contains('levels', [level]),
  ]);
  if (themesRes.error) throw themesRes.error;
  if (cardsRes.error) throw cardsRes.error;
  if (questionsRes.error) throw questionsRes.error;

  const themesById = new Map<string, Theme>();
  for (const t of (themesRes.data ?? []) as Theme[]) themesById.set(t.id, t);

  const hits: SearchHit[] = [];

  for (const c of (cardsRes.data ?? []) as MemoCard[]) {
    const haystack = [
      c.title,
      ...(Array.isArray(c.action_steps) ? c.action_steps : []),
    ]
      .join(' \n ')
      .toLowerCase();
    if (haystack.includes(needle)) {
      const theme = themesById.get(c.theme_id);
      if (theme) hits.push({ kind: 'memo_card', card: c, theme });
    }
  }

  for (const q of (questionsRes.data ?? []) as Question[]) {
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
