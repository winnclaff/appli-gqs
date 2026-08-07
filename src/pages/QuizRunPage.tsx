import { useEffect, useMemo, useRef, useState } from 'react';
import { Link, Navigate, useLocation, useNavigate } from 'react-router-dom';
import { Award, Check, ChevronLeft, RotateCw, X } from 'lucide-react';
import { fetchBadges, fetchGqsReferentiel, fetchQuizQuestions } from '../lib/api';
import type { Badge, Question, QuizMode } from '../types/domain';
import { Loader, ErrorBox } from '../components/Loader';
import { SourceTag } from '../components/SourceTag';
import { addHistoryEntry, getUnlockedBadges, setUnlockedBadges } from '../lib/storage';
import { computeMaxStreak, computeUnlockedBadgeIds } from '../lib/gamification';
import { resolveIcon } from '../lib/icons';

type LocationState = {
  mode: QuizMode;
  themeId?: string;
  themeTitle?: string;
  count: number;
};

export function QuizRunPage() {
  const location = useLocation();
  const navigate = useNavigate();
  const state = location.state as LocationState | null;

  const [questions, setQuestions] = useState<Question[] | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [currentIdx, setCurrentIdx] = useState(0);
  const [answers, setAnswers] = useState<(number | null)[]>([]);
  const [revealed, setRevealed] = useState(false);

  useEffect(() => {
    if (!state) return;
    let cancelled = false;
    (async () => {
      try {
        const ref = await fetchGqsReferentiel();
        const qs = await fetchQuizQuestions({
          mode: state.mode,
          themeId: state.themeId,
          referentielId: ref.id,
          count: state.count,
        });
        if (!cancelled) {
          setQuestions(qs);
          setAnswers(new Array(qs.length).fill(null));
        }
      } catch (e) {
        if (!cancelled) setError(e instanceof Error ? e.message : 'Erreur de chargement');
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [state]);

  const finished = useMemo(
    () => Boolean(questions && answers.length && answers.every((a) => a !== null)),
    [questions, answers],
  );

  if (!state) return <Navigate to="/quiz" replace />;
  if (error) return <ErrorBox message={error} />;
  if (!questions) return <Loader label="Préparation du quiz…" />;

  if (questions.length === 0) {
    return (
      <section>
        <Link
          to="/quiz"
          className="inline-flex items-center gap-1 text-sm text-slate-600 hover:text-brand-700 mb-3"
        >
          <ChevronLeft className="h-4 w-4" aria-hidden /> Retour
        </Link>
        <ErrorBox message="Aucune question disponible pour ce quiz." />
      </section>
    );
  }

  if (finished) {
    return (
      <QuizResult
        questions={questions}
        answers={answers as number[]}
        mode={state.mode}
        themeId={state.themeId ?? null}
        themeTitle={state.themeTitle}
        onRestart={() => {
          navigate('/quiz/run', { replace: true, state });
        }}
      />
    );
  }

  const q = questions[currentIdx];
  const chosen = answers[currentIdx];
  const isLast = currentIdx === questions.length - 1;

  function handlePick(idx: number) {
    if (revealed) return;
    const next = answers.slice();
    next[currentIdx] = idx;
    setAnswers(next);
    setRevealed(true);
  }

  function handleNext() {
    setRevealed(false);
    if (!isLast) setCurrentIdx((i) => i + 1);
  }

  return (
    <section>
      <div className="flex items-center justify-between mb-4 text-sm text-slate-600">
        <Link to="/quiz" className="inline-flex items-center gap-1 hover:text-brand-700">
          <ChevronLeft className="h-4 w-4" aria-hidden /> Quitter
        </Link>
        <span>
          Question {currentIdx + 1} / {questions.length}
        </span>
      </div>

      <div className="w-full bg-slate-200 h-1.5 rounded-full mb-6 overflow-hidden">
        <div
          className="bg-brand-600 h-full transition-all"
          style={{ width: `${((currentIdx + (revealed ? 1 : 0)) / questions.length) * 100}%` }}
        />
      </div>

      <h1 className="text-lg font-semibold mb-4">{q.question_text}</h1>

      <ul className="space-y-2 mb-6">
        {q.choices.map((choice, i) => {
          const isChosen = chosen === i;
          const isCorrect = q.correct_choice_index === i;
          let cls = 'card w-full text-left p-4 flex items-start gap-3 transition';
          if (!revealed) {
            cls += ' hover:border-brand-300 hover:shadow';
          } else if (isCorrect) {
            cls += ' border-green-500 bg-green-50';
          } else if (isChosen && !isCorrect) {
            cls += ' border-red-500 bg-red-50';
          } else {
            cls += ' opacity-60';
          }
          return (
            <li key={i}>
              <button
                type="button"
                onClick={() => handlePick(i)}
                disabled={revealed}
                className={cls}
              >
                <span className="mt-0.5 shrink-0 w-6 h-6 rounded-full border border-slate-300 text-xs font-semibold flex items-center justify-center bg-white">
                  {String.fromCharCode(65 + i)}
                </span>
                <span className="flex-1">{choice}</span>
                {revealed && isCorrect && (
                  <Check className="h-5 w-5 text-green-600 shrink-0" aria-hidden />
                )}
                {revealed && isChosen && !isCorrect && (
                  <X className="h-5 w-5 text-red-600 shrink-0" aria-hidden />
                )}
              </button>
            </li>
          );
        })}
      </ul>

      {revealed && (
        <div className="card p-4 mb-4 bg-slate-50">
          <div className="font-semibold mb-1">Explication</div>
          <p className="text-slate-800 text-sm mb-3">{q.explanation}</p>
          <SourceTag
            sourceName={q.source_name}
            sourceRef={q.source_ref}
            sourceUrl={q.source_url}
          />
        </div>
      )}

      {revealed && !isLast && (
        <button type="button" onClick={handleNext} className="btn-primary w-full">
          Question suivante
        </button>
      )}
      {revealed && isLast && (
        <button type="button" onClick={handleNext} className="btn-primary w-full">
          Voir mon résultat
        </button>
      )}
    </section>
  );
}

function QuizResult({
  questions,
  answers,
  mode,
  themeId,
  themeTitle,
  onRestart,
}: {
  questions: Question[];
  answers: number[];
  mode: QuizMode;
  themeId: string | null;
  themeTitle: string | undefined;
  onRestart: () => void;
}) {
  const correctFlags = answers.map((a, i) => a === questions[i].correct_choice_index);
  const correct = correctFlags.filter(Boolean).length;
  const total = questions.length;
  const isPerfect = correct === total;

  const [newlyUnlocked, setNewlyUnlocked] = useState<Badge[]>([]);
  const savedRef = useRef(false);

  useEffect(() => {
    // Une seule persistance / évaluation, même en StrictMode.
    if (savedRef.current) return;
    savedRef.current = true;

    (async () => {
      try {
        const maxStreak = computeMaxStreak(correctFlags);
        const history = addHistoryEntry({
          mode,
          themeId,
          score: correct,
          total,
          maxStreak,
          completedAt: new Date().toISOString(),
        });
        const badges = await fetchBadges();
        const previouslyUnlocked = new Set(getUnlockedBadges());
        const allUnlocked = computeUnlockedBadgeIds(badges, history);
        setUnlockedBadges(allUnlocked);
        const newly = badges.filter(
          (b) => allUnlocked.includes(b.id) && !previouslyUnlocked.has(b.id),
        );
        setNewlyUnlocked(newly);
      } catch {
        // Si Supabase échoue ou localStorage indispo, on n'affiche pas de badges — pas bloquant.
      }
    })();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <section>
      <h1 className="text-2xl font-bold mb-1">Résultat</h1>
      <p className="text-slate-600 mb-4 text-sm">
        {mode === 'mixed' ? 'Quiz mélangé' : `Quiz — ${themeTitle ?? 'thème'}`}
      </p>

      <div
        className={
          'card p-6 mb-6 text-center ' + (isPerfect ? 'border-green-500 bg-green-50' : '')
        }
      >
        <div className="text-4xl font-bold">
          {correct} / {total}
        </div>
        <div className="text-slate-600 mt-1">
          {isPerfect ? 'Sans faute — bravo !' : 'Continue, chaque révision compte.'}
        </div>
      </div>

      {newlyUnlocked.length > 0 && (
        <div className="card p-4 mb-6 border-amber-300 bg-amber-50">
          <div className="flex items-center gap-2 font-semibold text-amber-900 mb-2">
            <Award className="h-5 w-5" aria-hidden />
            {newlyUnlocked.length === 1
              ? 'Nouveau badge débloqué'
              : `${newlyUnlocked.length} nouveaux badges débloqués`}
          </div>
          <ul className="space-y-2">
            {newlyUnlocked.map((b) => {
              const Icon = resolveIcon(b.icon, Award);
              return (
                <li key={b.id} className="flex items-start gap-2 text-sm text-amber-900">
                  <Icon className="h-5 w-5 shrink-0 mt-0.5" aria-hidden />
                  <span>
                    <span className="font-semibold">{b.title}</span> — {b.description}
                  </span>
                </li>
              );
            })}
          </ul>
          <Link
            to="/badges"
            className="inline-block mt-3 text-sm font-semibold text-amber-900 underline"
          >
            Voir tous les badges
          </Link>
        </div>
      )}

      <div className="flex gap-2 mb-8">
        <button type="button" onClick={onRestart} className="btn-primary flex-1">
          <RotateCw className="h-5 w-5" aria-hidden />
          Rejouer
        </button>
        <Link to="/quiz" className="btn-secondary flex-1">
          Autre quiz
        </Link>
      </div>

      <h2 className="text-lg font-semibold mb-3">Reprise des questions</h2>
      <ul className="space-y-4">
        {questions.map((q, i) => {
          const chosen = answers[i];
          const ok = correctFlags[i];
          return (
            <li key={q.id} className="card p-4">
              <div className="flex items-start gap-2 mb-2">
                <div
                  className={
                    'shrink-0 w-6 h-6 rounded-full flex items-center justify-center text-white text-xs font-bold ' +
                    (ok ? 'bg-green-600' : 'bg-red-600')
                  }
                >
                  {ok ? <Check className="h-4 w-4" /> : <X className="h-4 w-4" />}
                </div>
                <div className="font-semibold flex-1">{q.question_text}</div>
              </div>
              <ul className="space-y-1 mb-3 text-sm">
                {q.choices.map((choice, ci) => {
                  const isCorrect = ci === q.correct_choice_index;
                  const isChosen = ci === chosen;
                  let cls = 'flex items-start gap-2 p-2 rounded ';
                  if (isCorrect) cls += 'bg-green-100 text-green-900';
                  else if (isChosen) cls += 'bg-red-100 text-red-900';
                  else cls += 'text-slate-700';
                  return (
                    <li key={ci} className={cls}>
                      <span className="font-mono text-xs mt-0.5">
                        {String.fromCharCode(65 + ci)}.
                      </span>
                      <span className="flex-1">{choice}</span>
                    </li>
                  );
                })}
              </ul>
              <p className="text-sm text-slate-800 mb-2">{q.explanation}</p>
              <SourceTag
                sourceName={q.source_name}
                sourceRef={q.source_ref}
                sourceUrl={q.source_url}
              />
            </li>
          );
        })}
      </ul>
    </section>
  );
}
