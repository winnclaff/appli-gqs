import {
  Info,
  HeartPulse,
  Footprints,
  Repeat,
  Star,
  Flame,
  BookOpen,
  Award,
  type LucideIcon,
} from 'lucide-react';

const ICON_MAP: Record<string, LucideIcon> = {
  info: Info,
  'heart-pulse': HeartPulse,
  footprints: Footprints,
  repeat: Repeat,
  star: Star,
  flame: Flame,
};

export function resolveIcon(name: string | null | undefined, fallback: LucideIcon = BookOpen) {
  if (!name) return fallback;
  return ICON_MAP[name] ?? fallback;
}

export { BookOpen, Award };
