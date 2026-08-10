import { useNavigate } from 'react-router-dom';
import { Award, HeartPulse, Siren, Stethoscope, Users, type LucideIcon } from 'lucide-react';
import { LEVELS, type Level } from '../types/domain';
import { useLevel } from '../lib/useLevel';
import { useDocumentMeta } from '../lib/useDocumentMeta';

type Segment =
  | { kind: 'level'; level: Level; icon: LucideIcon; label: string }
  | { kind: 'badges'; icon: LucideIcon; label: string };

const LEVEL_ICONS: Record<Level, LucideIcon> = {
  grand_public: HeartPulse,
  psc: Users,
  pse: Siren,
  afgsu: Stethoscope,
};

const WHEEL_LABELS: Record<Level, string> = {
  grand_public: 'GQS',
  psc: 'PSC',
  pse: 'PSE',
  afgsu: 'AFGSU',
};

const SEGMENTS: Segment[] = [
  ...LEVELS.map((l) => ({
    kind: 'level' as const,
    level: l.code,
    icon: LEVEL_ICONS[l.code],
    label: WHEEL_LABELS[l.code],
  })),
  { kind: 'badges' as const, icon: Award, label: 'Badges' },
];

const RADIUS_PERCENT = 38;

export function WheelPage() {
  const navigate = useNavigate();
  const [, setLevel] = useLevel();
  useDocumentMeta(
    'Accueil',
    'Choisissez un référentiel de premiers secours (GQS, PSC, PSE, AFGSU) pour réviser ses fiches et ses quiz gratuitement.',
  );

  function handleSelect(segment: Segment) {
    if (segment.kind === 'badges') {
      navigate('/badges');
      return;
    }
    setLevel(segment.level);
    navigate(`/reviser/${segment.level}`);
  }

  return (
    <section className="flex flex-col items-center py-4">
      <div className="relative w-full max-w-[340px] aspect-square mx-auto">
        <div className="absolute inset-[24%] rounded-full bg-brand-600 text-white flex items-center justify-center text-center p-4 shadow-lg">
          <p className="text-sm font-semibold leading-snug">Que souhaitez-vous réviser ?</p>
        </div>

        {SEGMENTS.map((seg, i) => {
          const angle = (360 / SEGMENTS.length) * i - 90;
          const rad = (angle * Math.PI) / 180;
          const x = 50 + RADIUS_PERCENT * Math.cos(rad);
          const y = 50 + RADIUS_PERCENT * Math.sin(rad);
          const Icon = seg.icon;
          const key = seg.kind === 'badges' ? 'badges' : seg.level;
          return (
            <button
              key={key}
              type="button"
              onClick={() => handleSelect(seg)}
              className="absolute w-16 h-16 -translate-x-1/2 -translate-y-1/2 rounded-2xl bg-white border border-slate-200 shadow-sm flex flex-col items-center justify-center gap-0.5 hover:border-brand-300 hover:shadow-md active:bg-slate-50 transition"
              style={{ left: `${x}%`, top: `${y}%` }}
            >
              <Icon className="h-5 w-5 text-brand-600" aria-hidden />
              <span className="text-[11px] font-semibold text-slate-700 leading-tight">
                {seg.label}
              </span>
            </button>
          );
        })}
      </div>

      <p className="text-sm text-slate-600 text-center mt-6 max-w-xs">
        Choisissez un référentiel pour accéder à ses fiches et ses quiz, ou consultez vos badges.
      </p>
    </section>
  );
}
