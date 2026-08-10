import { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { ChevronLeft, Lock } from 'lucide-react';
import { fetchBadges } from '../lib/api';
import { getUnlockedBadges, getHistory, getStreak } from '../lib/storage';
import { computeUnlockedBadgeIds } from '../lib/gamification';
import { resolveIcon, Award } from '../lib/icons';
import type { Badge } from '../types/domain';
import { Loader, ErrorBox } from '../components/Loader';
import { useDocumentMeta } from '../lib/useDocumentMeta';

const CRITERIA_LABELS: Record<Badge['criteria_type'], (v: number) => string> = {
  quiz_completed: (v) => (v === 1 ? 'Terminer 1 quiz' : `Terminer ${v} quiz`),
  score_perfect: () => 'Obtenir un score parfait',
  streak: (v) => `Enchaîner ${v} bonnes réponses d'affilée`,
  daily_streak: (v) => (v === 1 ? 'Réviser 1 jour' : `Réviser ${v} jours de suite`),
  theme_mastered: () => 'Maîtriser un thème (100 % en quiz de thème)',
};

export function BadgesPage() {
  const [badges, setBadges] = useState<Badge[] | null>(null);
  const [unlocked, setUnlocked] = useState<string[]>(getUnlockedBadges());
  const [error, setError] = useState<string | null>(null);
  useDocumentMeta(
    'Mes badges',
    'Suivez votre progression et débloquez des badges en révisant les gestes de premiers secours.',
  );

  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const b = await fetchBadges();
        if (cancelled) return;
        setBadges(b);
        // Recalcule à l'affichage : au cas où un critère aurait changé ou où
        // l'utilisateur revient sur cette page sans être passé par la fin d'un quiz.
        const derived = computeUnlockedBadgeIds(b, getHistory(), getStreak().longest);
        const merged = Array.from(new Set([...unlocked, ...derived]));
        setUnlocked(merged);
      } catch (e) {
        if (!cancelled) setError(e instanceof Error ? e.message : 'Erreur de chargement');
      }
    })();
    return () => {
      cancelled = true;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  if (error) return <ErrorBox message={error} />;
  if (!badges) return <Loader />;

  return (
    <section>
      <Link
        to="/"
        className="inline-flex items-center gap-1 text-sm text-slate-600 hover:text-brand-700 mb-3"
      >
        <ChevronLeft className="h-4 w-4" aria-hidden /> Accueil
      </Link>
      <h1 className="text-2xl font-bold mb-2">Mes badges</h1>
      <p className="text-slate-600 mb-6 text-sm">
        {unlocked.length} / {badges.length} débloqués. La progression est enregistrée sur cet
        appareil (localStorage), elle n'est pas synchronisée entre appareils.
      </p>

      <ul className="grid gap-3 sm:grid-cols-2">
        {badges.map((b) => {
          const isUnlocked = unlocked.includes(b.id);
          const Icon = resolveIcon(b.icon, Award);
          return (
            <li
              key={b.id}
              className={
                'card p-4 flex items-start gap-3 ' +
                (isUnlocked ? '' : 'opacity-60 grayscale')
              }
            >
              <div
                className={
                  'shrink-0 p-2 rounded-lg ' +
                  (isUnlocked
                    ? 'bg-amber-100 text-amber-700'
                    : 'bg-slate-100 text-slate-500')
                }
              >
                {isUnlocked ? (
                  <Icon className="h-6 w-6" aria-hidden />
                ) : (
                  <Lock className="h-6 w-6" aria-hidden />
                )}
              </div>
              <div className="flex-1">
                <div className="font-semibold">{b.title}</div>
                <div className="text-sm text-slate-700">{b.description}</div>
                <div className="text-xs text-slate-500 mt-1">
                  Critère : {CRITERIA_LABELS[b.criteria_type](b.criteria_value)}
                </div>
              </div>
            </li>
          );
        })}
      </ul>
    </section>
  );
}
