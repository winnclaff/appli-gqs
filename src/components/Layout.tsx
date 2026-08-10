import { Link, Outlet } from 'react-router-dom';
import { HeartPulse } from 'lucide-react';
import { useLevel } from '../lib/useLevel';
import { LEVELS } from '../types/domain';

export function Layout() {
  const [level] = useLevel();
  const label = LEVELS.find((l) => l.code === level)?.short ?? level;
  return (
    <div className="min-h-screen flex flex-col">
      <header className="bg-brand-600 text-white sticky top-0 z-10 shadow-sm">
        <div className="max-w-3xl mx-auto px-4 py-3 flex items-center justify-between gap-2">
          <Link to="/" className="flex items-center gap-2 font-bold text-lg">
            <HeartPulse className="h-6 w-6" aria-hidden />
            <span>Réviser les gestes</span>
          </Link>
          <span
            className="text-xs bg-white/15 border border-white/30 rounded-full px-2.5 py-1 font-semibold"
            title={LEVELS.find((l) => l.code === level)?.description}
          >
            {label}
          </span>
        </div>
      </header>
      <main className="flex-1 max-w-3xl w-full mx-auto px-4 py-6">
        <Outlet />
      </main>
      <footer className="max-w-3xl mx-auto px-4 py-6 text-xs text-slate-500 text-center space-y-1">
        <p>Outil de révision. Ne remplace pas une formation officielle GQS / PSC / PSE / AFGSU.</p>
        <p>
          Créé par{' '}
          <a
            href="https://www.instagram.com/un_homme_en_blanc/"
            target="_blank"
            rel="noreferrer noopener"
            className="font-medium underline underline-offset-2 hover:text-brand-700"
          >
            @un_homme_en_blanc
          </a>
          . Malgré toute l'attention portée à ce projet, des erreurs peuvent subsister.
        </p>
        <p>v{__APP_VERSION__}</p>
      </footer>
    </div>
  );
}
