import type { Level } from '../types/domain';

const LEVEL_KEY = 'gqs.level.v1';
const DEFAULT_LEVEL: Level = 'grand_public';

// Le niveau vit désormais dans l'URL (/reviser/:level, /quiz/:level,
// /themes/:level/:themeId) pour que chaque référentiel ait une page indexable
// séparément par les moteurs de recherche. localStorage ne sert plus que de
// mémoire "dernier niveau consulté" pour les écrans sans niveau dans l'URL
// (ex: le badge dans le header, /quiz/run).
export function isValidLevel(value: string | null | undefined): value is Level {
  return value === 'grand_public' || value === 'psc' || value === 'pse' || value === 'afgsu';
}

export function getLevel(): Level {
  try {
    const raw = localStorage.getItem(LEVEL_KEY);
    if (isValidLevel(raw)) return raw;
  } catch {
    // localStorage indisponible — on retombe sur la valeur par défaut.
  }
  return DEFAULT_LEVEL;
}

export function setLevel(level: Level): void {
  try {
    localStorage.setItem(LEVEL_KEY, level);
  } catch {
    // silencieux
  }
}

const LEVEL_CHANGE_EVENT = 'gqs:level-changed';

export function emitLevelChanged(level: Level): void {
  window.dispatchEvent(new CustomEvent<Level>(LEVEL_CHANGE_EVENT, { detail: level }));
}

export function onLevelChanged(handler: (level: Level) => void): () => void {
  const listener = (e: Event) => handler((e as CustomEvent<Level>).detail);
  window.addEventListener(LEVEL_CHANGE_EVENT, listener);
  return () => window.removeEventListener(LEVEL_CHANGE_EVENT, listener);
}
