const HISTORY_KEY = 'gqs.quiz_history.v1';
const BADGES_KEY = 'gqs.badges_unlocked.v1';

export type QuizHistoryEntry = {
  quizId?: string;
  themeId: string | null;
  mode: 'theme' | 'mixed';
  score: number;
  total: number;
  maxStreak: number;
  completedAt: string;
};

function readJson<T>(key: string, fallback: T): T {
  try {
    const raw = localStorage.getItem(key);
    if (!raw) return fallback;
    return JSON.parse(raw) as T;
  } catch {
    return fallback;
  }
}

function writeJson(key: string, value: unknown): void {
  try {
    localStorage.setItem(key, JSON.stringify(value));
  } catch {
    // localStorage indisponible (mode privé, quota…) : la progression est optionnelle, on ignore.
  }
}

export function getHistory(): QuizHistoryEntry[] {
  return readJson<QuizHistoryEntry[]>(HISTORY_KEY, []);
}

export function addHistoryEntry(entry: QuizHistoryEntry): QuizHistoryEntry[] {
  const next = [...getHistory(), entry];
  writeJson(HISTORY_KEY, next);
  return next;
}

export function getUnlockedBadges(): string[] {
  return readJson<string[]>(BADGES_KEY, []);
}

export function setUnlockedBadges(ids: string[]): void {
  writeJson(BADGES_KEY, ids);
}
