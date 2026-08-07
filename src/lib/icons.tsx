import {
  Info,
  HeartPulse,
  Footprints,
  Repeat,
  Star,
  Flame,
  BookOpen,
  Award,
  PhoneCall,
  Shield,
  Droplet,
  Wind,
  User,
  Bandage,
  Bone,
  Activity,
  Sun,
  Siren,
  Scale,
  Briefcase,
  type LucideIcon,
} from 'lucide-react';

const ICON_MAP: Record<string, LucideIcon> = {
  info: Info,
  'heart-pulse': HeartPulse,
  footprints: Footprints,
  repeat: Repeat,
  star: Star,
  flame: Flame,
  'phone-call': PhoneCall,
  shield: Shield,
  droplet: Droplet,
  wind: Wind,
  user: User,
  bandage: Bandage,
  bone: Bone,
  activity: Activity,
  sun: Sun,
  siren: Siren,
  scale: Scale,
  'book-open': BookOpen,
  briefcase: Briefcase,
};

export function resolveIcon(name: string | null | undefined, fallback: LucideIcon = BookOpen) {
  if (!name) return fallback;
  return ICON_MAP[name] ?? fallback;
}

export { BookOpen, Award };
