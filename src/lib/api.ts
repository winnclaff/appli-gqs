import { supabase } from './supabase';
import type { Question, Theme, MemoCard, Referentiel, Badge } from '../types/domain';

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

export async function fetchThemes(referentielId: string): Promise<Theme[]> {
  const { data, error } = await supabase
    .from('themes')
    .select('*')
    .eq('referentiel_id', referentielId)
    .order('sort_order', { ascending: true });
  if (error) throw error;
  return (data ?? []) as Theme[];
}

export async function fetchTheme(themeId: string): Promise<Theme> {
  const { data, error } = await supabase.from('themes').select('*').eq('id', themeId).single();
  if (error) throw error;
  return data as Theme;
}

export async function fetchMemoCards(themeId: string): Promise<MemoCard[]> {
  const { data, error } = await supabase
    .from('memo_cards')
    .select('*')
    .eq('theme_id', themeId)
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

// Tirage à la volée : on récupère tous les candidats, on mélange, on prend N.
// Dataset limité (dizaines de questions), suffisant côté client.
export async function fetchQuizQuestions(params: {
  mode: 'theme' | 'mixed';
  themeId?: string;
  referentielId: string;
  count: number;
}): Promise<Question[]> {
  const { mode, themeId, referentielId, count } = params;

  let query = supabase.from('questions').select('*, themes!inner(referentiel_id)');
  if (mode === 'theme') {
    if (!themeId) throw new Error('themeId requis en mode theme');
    query = query.eq('theme_id', themeId);
  } else {
    query = query.eq('themes.referentiel_id', referentielId);
  }
  const { data, error } = await query;
  if (error) throw error;

  const rows = (data ?? []) as Question[];
  return shuffle(rows).slice(0, count);
}
