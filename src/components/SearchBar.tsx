import { useEffect, useRef, useState } from 'react';
import { Link } from 'react-router-dom';
import { BookOpen, HelpCircle, Search, X } from 'lucide-react';
import type { Level } from '../types/domain';
import { searchAll, type SearchHit } from '../lib/api';

type Props = { level: Level };

export function SearchBar({ level }: Props) {
  const [query, setQuery] = useState('');
  const [hits, setHits] = useState<SearchHit[] | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const debounceRef = useRef<number | null>(null);

  useEffect(() => {
    if (debounceRef.current) window.clearTimeout(debounceRef.current);
    if (query.trim().length < 2) {
      setHits(null);
      setError(null);
      return;
    }
    debounceRef.current = window.setTimeout(async () => {
      setLoading(true);
      setError(null);
      try {
        const results = await searchAll(query, level);
        setHits(results);
      } catch (e) {
        setError(e instanceof Error ? e.message : 'Erreur de recherche');
        setHits([]);
      } finally {
        setLoading(false);
      }
    }, 250);
    return () => {
      if (debounceRef.current) window.clearTimeout(debounceRef.current);
    };
  }, [query, level]);

  const showResults = query.trim().length >= 2;

  return (
    <div className="mb-6">
      <div className="relative">
        <Search
          className="absolute left-3 top-1/2 -translate-y-1/2 h-5 w-5 text-slate-400 pointer-events-none"
          aria-hidden
        />
        <input
          type="search"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder="Rechercher une fiche, un geste, un mot-clé…"
          className="w-full pl-10 pr-10 py-3 rounded-xl border border-slate-300 bg-white text-slate-900 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-brand-500"
          aria-label="Recherche"
        />
        {query && (
          <button
            type="button"
            onClick={() => setQuery('')}
            className="absolute right-2 top-1/2 -translate-y-1/2 p-1 rounded hover:bg-slate-100"
            aria-label="Effacer la recherche"
          >
            <X className="h-4 w-4 text-slate-500" aria-hidden />
          </button>
        )}
      </div>

      {showResults && (
        <div className="mt-3">
          {loading && <div className="text-sm text-slate-500 py-2">Recherche…</div>}
          {error && <div className="text-sm text-red-700 py-2">{error}</div>}
          {!loading && !error && hits && hits.length === 0 && (
            <div className="text-sm text-slate-500 py-2">
              Aucun résultat pour ce niveau. Essayez un autre mot ou changez de niveau.
            </div>
          )}
          {!loading && !error && hits && hits.length > 0 && (
            <ul className="grid gap-2">
              {hits.slice(0, 20).map((hit) => (
                <li key={hit.kind === 'memo_card' ? `c-${hit.card.id}` : `q-${hit.question.id}`}>
                  {hit.kind === 'memo_card' ? (
                    <Link
                      to={`/themes/${level}/${hit.theme.id}`}
                      className="card p-3 flex items-start gap-3 hover:border-brand-300 hover:shadow transition"
                    >
                      <BookOpen className="h-5 w-5 text-brand-600 shrink-0 mt-0.5" aria-hidden />
                      <div className="flex-1 min-w-0">
                        <div className="text-xs text-slate-500 uppercase tracking-wide">
                          Fiche · {hit.theme.title}
                        </div>
                        <div className="font-semibold truncate">{hit.card.title}</div>
                      </div>
                    </Link>
                  ) : (
                    <Link
                      to={`/themes/${level}/${hit.theme.id}`}
                      className="card p-3 flex items-start gap-3 hover:border-brand-300 hover:shadow transition"
                    >
                      <HelpCircle className="h-5 w-5 text-slate-500 shrink-0 mt-0.5" aria-hidden />
                      <div className="flex-1 min-w-0">
                        <div className="text-xs text-slate-500 uppercase tracking-wide">
                          Question · {hit.theme.title}
                          {hit.question.question_number != null && (
                            <> · N°{hit.question.question_number}</>
                          )}
                        </div>
                        <div className="font-semibold line-clamp-2">
                          {hit.question.question_text}
                        </div>
                      </div>
                    </Link>
                  )}
                </li>
              ))}
              {hits.length > 20 && (
                <li className="text-xs text-slate-500 text-center py-1">
                  {hits.length - 20} autres résultats. Affinez votre recherche.
                </li>
              )}
            </ul>
          )}
        </div>
      )}
    </div>
  );
}
