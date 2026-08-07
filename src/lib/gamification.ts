import type { Badge } from '../types/domain';
import type { QuizHistoryEntry } from './storage';

// Retourne les ids de badges qui doivent être débloqués vu l'historique complet.
// Pure : ne touche pas au localStorage.
export function computeUnlockedBadgeIds(
  badges: Badge[],
  history: QuizHistoryEntry[],
): string[] {
  const totalQuizzes = history.length;
  const hasPerfect = history.some((h) => h.score === h.total && h.total > 0);
  const bestStreak = history.reduce((m, h) => Math.max(m, h.maxStreak), 0);

  return badges
    .filter((badge) => {
      switch (badge.criteria_type) {
        case 'quiz_completed':
          return totalQuizzes >= badge.criteria_value;
        case 'score_perfect':
          return hasPerfect;
        case 'streak':
          return bestStreak >= badge.criteria_value;
        case 'theme_mastered':
          // Pas de critère précis en v1 — on considère qu'un thème est maîtrisé
          // si un quiz mode 'theme' a été réussi parfaitement.
          return history.some(
            (h) => h.mode === 'theme' && h.score === h.total && h.total > 0,
          );
        default:
          return false;
      }
    })
    .map((b) => b.id);
}

// Calcule la plus longue série de bonnes réponses consécutives dans les réponses d'un quiz.
export function computeMaxStreak(
  correctFlags: boolean[],
): number {
  let max = 0;
  let current = 0;
  for (const ok of correctFlags) {
    if (ok) {
      current += 1;
      if (current > max) max = current;
    } else {
      current = 0;
    }
  }
  return max;
}
