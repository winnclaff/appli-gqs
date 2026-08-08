import { Flame } from 'lucide-react';
import { getHistory, getStreak } from '../lib/storage';

export function StreakCard() {
  const streak = getStreak();
  const quizCount = getHistory().length;

  if (quizCount === 0) {
    return (
      <div className="card p-4 mb-6 flex items-center gap-3 bg-brand-50 border-brand-200">
        <Flame className="h-8 w-8 text-brand-300 shrink-0" aria-hidden />
        <div>
          <div className="font-semibold">Commence ta série aujourd'hui</div>
          <div className="text-sm text-slate-600">
            Un quiz par jour suffit pour progresser durablement.
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="card p-4 mb-6 flex items-center gap-4">
      <div className="flex items-center gap-2">
        <Flame
          className={'h-8 w-8 shrink-0 ' + (streak.current > 0 ? 'text-orange-500' : 'text-slate-300')}
          aria-hidden
        />
        <div>
          <div className="text-2xl font-bold leading-none">{streak.current}</div>
          <div className="text-xs text-slate-500 whitespace-nowrap">
            jour{streak.current > 1 ? 's' : ''} de suite
          </div>
        </div>
      </div>
      <div className="h-8 w-px bg-slate-200 shrink-0" />
      <div className="text-sm text-slate-600">
        {quizCount} quiz complété{quizCount > 1 ? 's' : ''}
      </div>
    </div>
  );
}
