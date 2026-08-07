import { LEVELS, type Level } from '../types/domain';

type Props = {
  value: Level;
  onChange: (l: Level) => void;
};

export function LevelToggle({ value, onChange }: Props) {
  return (
    <div className="card p-3 mb-6">
      <div className="text-xs uppercase tracking-wide text-slate-500 mb-2 font-semibold">
        Votre niveau
      </div>
      <div className="grid grid-cols-2 gap-2 sm:grid-cols-4">
        {LEVELS.map((l) => {
          const active = value === l.code;
          return (
            <button
              key={l.code}
              type="button"
              onClick={() => onChange(l.code)}
              aria-pressed={active}
              className={
                'px-3 py-2 rounded-lg text-sm font-semibold text-center transition ' +
                (active
                  ? 'bg-brand-600 text-white'
                  : 'bg-white text-slate-700 border border-slate-300 hover:border-brand-300')
              }
            >
              {l.short}
            </button>
          );
        })}
      </div>
      <div className="text-xs text-slate-500 mt-2">
        {LEVELS.find((l) => l.code === value)?.description}
      </div>
    </div>
  );
}
