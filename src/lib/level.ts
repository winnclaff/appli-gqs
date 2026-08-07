import type { Level } from '../types/domain';

const LEVEL_KEY = 'gqs.level.v1';
const DEFAULT_LEVEL: Level = 'grand_public';

export function getLevel(): Level {
  try {
    const raw = localStorage.getItem(LEVEL_KEY);
    if (raw === 'grand_public' || raw === 'psc' || raw === 'pse' || raw === 'afgsu') {
      return raw;
    }
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
