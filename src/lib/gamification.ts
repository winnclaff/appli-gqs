import type { Badge } from '../types/domain';
import type { QuestionAttempt, QuizHistoryEntry } from './storage';

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

// Ne garde que le dernier essai de chaque question (les tentatives sont déjà
// stockées en ordre chronologique, donc la dernière écrase les précédentes).
function latestAttemptByQuestion(attempts: QuestionAttempt[]): Map<string, QuestionAttempt> {
  const map = new Map<string, QuestionAttempt>();
  for (const a of attempts) map.set(a.questionId, a);
  return map;
}

// Questions dont le dernier essai est raté. Une question qui a été ratée puis
// réussie ensuite n'apparaît plus dans la liste.
export function getMissedQuestionIds(attempts: QuestionAttempt[]): string[] {
  const missed: string[] = [];
  for (const [id, a] of latestAttemptByQuestion(attempts)) {
    if (!a.correct) missed.push(id);
  }
  return missed;
}

// Progression sur un thème : nombre de questions dont le dernier essai est
// correct, sur le total de questions disponibles à ce thème/niveau.
export function computeThemeMastery(
  attempts: QuestionAttempt[],
  themeId: string,
  totalQuestionsInTheme: number,
): { masteredCount: number; total: number } {
  const latest = latestAttemptByQuestion(attempts.filter((a) => a.themeId === themeId));
  let masteredCount = 0;
  for (const a of latest.values()) {
    if (a.correct) masteredCount += 1;
  }
  return { masteredCount, total: totalQuestionsInTheme };
}
