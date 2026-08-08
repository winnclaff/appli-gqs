import { useEffect, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { ChevronLeft, Play, Repeat, Shuffle } from 'lucide-react';
import { fetchQuestionsByIds, fetchThemesForLevel } from '../lib/api';
import { resolveIcon } from '../lib/icons';
import type { Theme } from '../types/domain';
import { Loader, ErrorBox } from '../components/Loader';
import { useLevel } from '../lib/useLevel';
import { getMissedQuestionIds } from '../lib/gamification';
import { getQuestionAttempts } from '../lib/storage';

const QUIZ_COUNT = 5;

export function QuizHubPage() {
  const navigate = useNavigate();
  const [level] = useLevel();
  const [themes, setThemes] = useState<Theme[] | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [missedIds, setMissedIds] = useState<string[]>([]);

  useEffect(() => {
    let cancelled = false;
    setThemes(null);
    setError(null);
    (async () => {
      try {
        const t = await fetchThemesForLevel(level);
        if (!cancelled) setThemes(t);
      } catch (e) {
        if (!cancelled) setError(e instanceof Error ? e.message : 'Erreur de chargement');
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [level]);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      const allMissed = getMissedQuestionIds(getQuestionAttempts());
      if (allMissed.length === 0) {
        if (!cancelled) setMissedIds([]);
        return;
      }
      try {
        const available = await fetchQuestionsByIds(allMissed, level);
        if (!cancelled) setMissedIds(available.map((q) => q.id));
      } catch {
        if (!cancelled) setMissedIds([]);
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [level]);

  return (
    <section>
      <Link
        to="/"
        className="inline-flex items-center gap-1 text-sm text-slate-600 hover:text-brand-700 mb-3"
      >
        <ChevronLeft className="h-4 w-4" aria-hidden /> Accueil
      </Link>

      <h1 className="text-2xl font-bold mb-2">Lancer un quiz</h1>
      <p className="text-slate-700 mb-6">
        5 questions tirées aléatoirement, différentes à chaque partie. Filtrées selon votre
        niveau (modifiable depuis l'accueil).
      </p>

      {missedIds.length > 0 && (
        <button
          type="button"
          onClick={() =>
            navigate('/quiz/run', {
              state: { mode: 'review', questionIds: missedIds, count: missedIds.length },
            })
          }
          className="btn-secondary w-full mb-3 border-amber-300 bg-amber-50 text-amber-900 hover:bg-amber-100"
        >
          <Repeat className="h-5 w-5" aria-hidden />
          Revoir mes erreurs ({missedIds.length})
        </button>
      )}

      {error && <ErrorBox message={error} />}
      {!themes && !error && <Loader />}

      {themes && (
        <>
          <button
            type="button"
            onClick={() => navigate('/quiz/run', { state: { mode: 'mixed', count: QUIZ_COUNT } })}
            className="btn-primary w-full mb-6"
          >
            <Shuffle className="h-5 w-5" aria-hidden />
            Quiz mélangé (tous thèmes)
          </button>

          <h2 className="text-lg font-semibold mb-3">Ou choisir un thème</h2>
          {themes.length === 0 ? (
            <p className="text-sm text-slate-600">
              Aucun thème disponible à ce niveau pour le moment.
            </p>
          ) : (
            <ul className="grid gap-3">
              {themes.map((theme) => {
                const Icon = resolveIcon(theme.icon);
                return (
                  <li key={theme.id}>
                    <button
                      type="button"
                      onClick={() =>
                        navigate('/quiz/run', {
                          state: {
                            mode: 'theme',
                            themeId: theme.id,
                            themeTitle: theme.title,
                            count: QUIZ_COUNT,
                          },
                        })
                      }
                      className="card p-4 flex items-center gap-3 w-full text-left hover:border-brand-300 hover:shadow transition"
                    >
                      <div className="p-2 rounded-lg bg-brand-100 text-brand-700 shrink-0">
                        <Icon className="h-6 w-6" aria-hidden />
                      </div>
                      <div className="flex-1">
                        <div className="font-semibold">{theme.title}</div>
                        {theme.short_description && (
                          <div className="text-sm text-slate-600 mt-0.5">
                            {theme.short_description}
                          </div>
                        )}
                      </div>
                      <Play className="h-5 w-5 text-brand-600 shrink-0" aria-hidden />
                    </button>
                  </li>
                );
              })}
            </ul>
          )}
        </>
      )}
    </section>
  );
}
