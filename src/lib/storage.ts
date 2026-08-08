const HISTORY_KEY = 'gqs.quiz_history.v1';
const BADGES_KEY = 'gqs.badges_unlocked.v1';
const ATTEMPTS_KEY = 'gqs.question_attempts.v1';
const STREAK_KEY = 'gqs.streak.v1';

const MAX_ATTEMPTS_STORED = 400;

export type QuizHistoryEntry = {
  quizId?: string;
  themeId: string | null;
  mode: 'theme' | 'mixed' | 'review';
  score: number;
  total: number;
  maxStreak: number;
  completedAt: string;
};

export type QuestionAttempt = {
  questionId: string;
  themeId: string;
  correct: boolean;
  answeredAt: string;
};

export type StreakState = {
  current: number;
  longest: number;
  lastPracticedDate: string | null; // YYYY-MM-DD, heure locale du navigateur
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

// ---------- Suivi par question (pour "questions à revoir" + progression par thème) ----------

export function getQuestionAttempts(): QuestionAttempt[] {
  return readJson<QuestionAttempt[]>(ATTEMPTS_KEY, []);
}

// FIFO plafonné : évite une croissance illimitée du localStorage sur une longue utilisation.
export function recordQuestionAttempts(attempts: QuestionAttempt[]): void {
  const next = [...getQuestionAttempts(), ...attempts].slice(-MAX_ATTEMPTS_STORED);
  writeJson(ATTEMPTS_KEY, next);
}

// ---------- Streak quotidien ----------

function todayLocalISO(): string {
  const d = new Date();
  const y = d.getFullYear();
  const m = String(d.getMonth() + 1).padStart(2, '0');
  const day = String(d.getDate()).padStart(2, '0');
  return `${y}-${m}-${day}`;
}

function isYesterday(dateStr: string, today: string): boolean {
  const [y, m, d] = dateStr.split('-').map(Number);
  const date = new Date(y, m - 1, d);
  date.setDate(date.getDate() + 1);
  const [ty, tm, td] = today.split('-').map(Number);
  return date.getFullYear() === ty && date.getMonth() === tm - 1 && date.getDate() === td;
}

export function getStreak(): StreakState {
  return readJson<StreakState>(STREAK_KEY, { current: 0, longest: 0, lastPracticedDate: null });
}

// À appeler une fois par quiz terminé. Incrémente si le dernier jour pratiqué
// était hier, repart à 1 si l'écart est plus grand, ne change rien si déjà
// pratiqué aujourd'hui (pour ne pas gonfler la série en rejouant plusieurs
// quiz le même jour).
export function touchStreak(): { state: StreakState; incrementedToday: boolean } {
  const today = todayLocalISO();
  const prev = getStreak();

  if (prev.lastPracticedDate === today) {
    return { state: prev, incrementedToday: false };
  }

  const current = prev.lastPracticedDate && isYesterday(prev.lastPracticedDate, today)
    ? prev.current + 1
    : 1;
  const next: StreakState = {
    current,
    longest: Math.max(prev.longest, current),
    lastPracticedDate: today,
  };
  writeJson(STREAK_KEY, next);
  return { state: next, incrementedToday: true };
}
