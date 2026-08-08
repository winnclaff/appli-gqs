import { useEffect, useState } from 'react';

const COLORS = ['#dc2626', '#f59e0b', '#16a34a', '#2563eb', '#db2777'];
const PIECE_COUNT = 24;

// Petit effet de confettis CSS pur, déclenché une fois au montage, pas de
// dépendance externe. Se retire du DOM après l'animation.
export function Confetti() {
  const [visible, setVisible] = useState(true);
  const [pieces] = useState(() =>
    Array.from({ length: PIECE_COUNT }, (_, i) => ({
      id: i,
      left: Math.random() * 100,
      delay: Math.random() * 0.3,
      duration: 1.6 + Math.random() * 0.8,
      color: COLORS[i % COLORS.length],
      rotate: Math.random() * 360,
    })),
  );

  useEffect(() => {
    const t = window.setTimeout(() => setVisible(false), 2600);
    return () => window.clearTimeout(t);
  }, []);

  if (!visible) return null;

  return (
    <div className="pointer-events-none fixed inset-0 z-50 overflow-hidden" aria-hidden>
      {pieces.map((p) => (
        <span
          key={p.id}
          className="absolute top-[-10px] w-2 h-3 rounded-sm"
          style={{
            left: `${p.left}%`,
            backgroundColor: p.color,
            animation: `gqs-confetti-fall ${p.duration}s ease-in ${p.delay}s forwards`,
            transform: `rotate(${p.rotate}deg)`,
          }}
        />
      ))}
    </div>
  );
}
