import { useEffect, useState } from 'react';
import { Link, Navigate, useNavigate, useParams } from 'react-router-dom';
import { ChevronLeft, ChevronRight, ListChecks, Award } from 'lucide-react';
import { fetchThemesForLevel } from '../lib/api';
import { resolveIcon } from '../lib/icons';
import type { Level, Theme } from '../types/domain';
import { LEVELS } from '../types/domain';
import { Loader, ErrorBox } from '../components/Loader';
import { LevelToggle } from '../components/LevelToggle';
import { SearchBar } from '../components/SearchBar';
import { StreakCard } from '../components/StreakCard';
import { useLevel } from '../lib/useLevel';
import { isValidLevel } from '../lib/level';
import { useDocumentMeta } from '../lib/useDocumentMeta';

export function HomePage() {
  const { level: levelParam } = useParams<{ level: string }>();
  const navigate = useNavigate();
  const [, setGlobalLevel] = useLevel();
  const [themes, setThemes] = useState<Theme[] | null>(null);
  const [error, setError] = useState<string | null>(null);

  const valid = isValidLevel(levelParam);
  const level: Level = valid ? levelParam : 'grand_public';
  const levelInfo = LEVELS.find((l) => l.code === level);

  useDocumentMeta(
    levelInfo?.label ?? 'Réviser',
    levelInfo?.description ?? 'Fiches mémo et quiz de premiers secours.',
  );

  useEffect(() => {
    if (valid) setGlobalLevel(level);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [level, valid]);

  useEffect(() => {
    if (!valid) return;
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
  }, [level, valid]);

  if (!valid) return <Navigate to="/" replace />;

  return (
    <section>
      <Link
        to="/"
        className="inline-flex items-center gap-1 text-sm text-slate-600 hover:text-brand-700 mb-3"
      >
        <ChevronLeft className="h-4 w-4" aria-hidden /> Changer de référentiel
      </Link>

      <h1 className="text-2xl font-bold mb-2">{levelInfo?.label ?? 'Réviser'}</h1>
      <p className="text-slate-700 mb-6">{levelInfo?.description}</p>

      <StreakCard />

      <LevelToggle value={level} onChange={(l) => navigate(`/reviser/${l}`)} />

      <SearchBar level={level} />

      <div className="grid gap-3 mb-8">
        <Link
          to={`/quiz/${level}`}
          className="card p-4 flex items-center justify-between hover:border-brand-300 hover:shadow transition"
        >
          <div className="flex items-center gap-3">
            <div className="p-2 rounded-lg bg-brand-100 text-brand-700">
              <ListChecks className="h-6 w-6" aria-hidden />
            </div>
            <div>
              <div className="font-semibold">Lancer un quiz</div>
              <div className="text-sm text-slate-600">
                Par thème ou mélangé, 5 ou 10 questions
              </div>
            </div>
          </div>
          <ChevronRight className="h-5 w-5 text-slate-400" aria-hidden />
        </Link>
        <Link
          to="/badges"
          className="card p-4 flex items-center justify-between hover:border-brand-300 hover:shadow transition"
        >
          <div className="flex items-center gap-3">
            <div className="p-2 rounded-lg bg-amber-100 text-amber-700">
              <Award className="h-6 w-6" aria-hidden />
            </div>
            <div>
              <div className="font-semibold">Mes badges</div>
              <div className="text-sm text-slate-600">Voir sa progression locale</div>
            </div>
          </div>
          <ChevronRight className="h-5 w-5 text-slate-400" aria-hidden />
        </Link>
      </div>

      <h2 className="text-lg font-semibold mb-3">Thèmes disponibles à votre niveau</h2>
      {error && <ErrorBox message={error} />}
      {!themes && !error && <Loader />}
      {themes && themes.length === 0 && (
        <div className="text-sm text-slate-600">
          Aucun thème pour ce niveau pour le moment.
        </div>
      )}
      {themes && themes.length > 0 && (
        <ul className="grid gap-3">
          {themes.map((theme) => {
            const Icon = resolveIcon(theme.icon);
            return (
              <li key={theme.id}>
                <Link
                  to={`/themes/${level}/${theme.id}`}
                  className="card p-4 flex items-start gap-3 hover:border-brand-300 hover:shadow transition"
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
                  <ChevronRight
                    className="h-5 w-5 text-slate-400 shrink-0 mt-1"
                    aria-hidden
                  />
                </Link>
              </li>
            );
          })}
        </ul>
      )}
    </section>
  );
}
