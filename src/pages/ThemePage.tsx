import { useEffect, useState } from 'react';
import { Link, useNavigate, useParams } from 'react-router-dom';
import { ChevronLeft, ListChecks } from 'lucide-react';
import { fetchMemoCards, fetchQuestionsForTheme, fetchTheme } from '../lib/api';
import { resolveIcon } from '../lib/icons';
import type { MemoCard, Theme } from '../types/domain';
import { Loader, ErrorBox } from '../components/Loader';
import { SourceTag } from '../components/SourceTag';
import { useLevel } from '../lib/useLevel';
import { computeThemeMastery } from '../lib/gamification';
import { getQuestionAttempts } from '../lib/storage';

export function ThemePage() {
  const { themeId } = useParams<{ themeId: string }>();
  const navigate = useNavigate();
  const [level] = useLevel();
  const [theme, setTheme] = useState<Theme | null>(null);
  const [cards, setCards] = useState<MemoCard[] | null>(null);
  const [questionCount, setQuestionCount] = useState<number | null>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!themeId) return;
    let cancelled = false;
    setTheme(null);
    setCards(null);
    setQuestionCount(null);
    setError(null);
    (async () => {
      try {
        const [t, c, qs] = await Promise.all([
          fetchTheme(themeId),
          fetchMemoCards(themeId, level),
          fetchQuestionsForTheme(themeId, level),
        ]);
        if (!cancelled) {
          setTheme(t);
          setCards(c);
          setQuestionCount(qs.length);
        }
      } catch (e) {
        if (!cancelled) setError(e instanceof Error ? e.message : 'Erreur de chargement');
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [themeId, level]);

  if (error) return <ErrorBox message={error} />;
  if (!theme || !cards) return <Loader />;

  const Icon = resolveIcon(theme.icon);
  const mastery =
    themeId && questionCount != null && questionCount > 0
      ? computeThemeMastery(getQuestionAttempts(), themeId, questionCount)
      : null;

  return (
    <section>
      <Link
        to="/"
        className="inline-flex items-center gap-1 text-sm text-slate-600 hover:text-brand-700 mb-3"
      >
        <ChevronLeft className="h-4 w-4" aria-hidden /> Accueil
      </Link>

      <header className="flex items-start gap-3 mb-4">
        <div className="p-2 rounded-lg bg-brand-100 text-brand-700 shrink-0">
          <Icon className="h-6 w-6" aria-hidden />
        </div>
        <div>
          <h1 className="text-2xl font-bold">{theme.title}</h1>
          {theme.short_description && (
            <p className="text-slate-600 mt-1">{theme.short_description}</p>
          )}
        </div>
      </header>

      {mastery && (
        <div className="mb-4">
          <div className="flex items-center justify-between text-xs text-slate-500 mb-1">
            <span>Progression</span>
            <span>
              {mastery.masteredCount}/{mastery.total} maîtrisée{mastery.masteredCount > 1 ? 's' : ''}
            </span>
          </div>
          <div className="w-full bg-slate-200 h-1.5 rounded-full overflow-hidden">
            <div
              className="bg-green-500 h-full transition-all"
              style={{ width: `${(mastery.masteredCount / mastery.total) * 100}%` }}
            />
          </div>
        </div>
      )}

      <button
        type="button"
        onClick={() =>
          navigate('/quiz/run', {
            state: { mode: 'theme', themeId: theme.id, themeTitle: theme.title, count: 5 },
          })
        }
        className="btn-primary w-full mb-6"
      >
        <ListChecks className="h-5 w-5" aria-hidden />
        Lancer le quiz de ce thème (5 questions)
      </button>

      <h2 className="text-lg font-semibold mb-3">Fiches mémo</h2>
      {cards.length === 0 ? (
        <p className="text-sm text-slate-600">
          Pas encore de fiche pour ce thème à votre niveau. Les questions du quiz couvrent
          cependant ces contenus.
        </p>
      ) : (
        <ul className="space-y-3">
          {cards.map((card) => (
            <li key={card.id} className="card p-4">
              <h3 className="font-semibold text-lg mb-2">{card.title}</h3>
              <ol className="list-decimal list-outside pl-5 space-y-2 text-slate-800 mb-3">
                {Array.isArray(card.action_steps) &&
                  card.action_steps.map((step, i) => <li key={i}>{step}</li>)}
              </ol>
              <SourceTag
                sourceName={card.source_name}
                sourceRef={card.source_ref}
                sourceUrl={card.source_url}
              />
            </li>
          ))}
        </ul>
      )}
    </section>
  );
}
