import { Link, Outlet } from 'react-router-dom';
import { HeartPulse } from 'lucide-react';

export function Layout() {
  return (
    <div className="min-h-screen flex flex-col">
      <header className="bg-brand-600 text-white sticky top-0 z-10 shadow-sm">
        <div className="max-w-3xl mx-auto px-4 py-3 flex items-center gap-2">
          <Link to="/" className="flex items-center gap-2 font-bold text-lg">
            <HeartPulse className="h-6 w-6" aria-hidden />
            <span>Gestes Qui Sauvent</span>
          </Link>
        </div>
      </header>
      <main className="flex-1 max-w-3xl w-full mx-auto px-4 py-6">
        <Outlet />
      </main>
      <footer className="max-w-3xl mx-auto px-4 py-6 text-xs text-slate-500 text-center">
        Outil de révision. Ne remplace pas une formation officielle GQS/PSC1/AFGSU/PSE.
      </footer>
    </div>
  );
}
