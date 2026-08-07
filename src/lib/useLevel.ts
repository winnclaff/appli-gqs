import { useEffect, useState } from 'react';
import type { Level } from '../types/domain';
import { emitLevelChanged, getLevel, onLevelChanged, setLevel as persistLevel } from './level';

export function useLevel(): [Level, (l: Level) => void] {
  const [level, setLevelState] = useState<Level>(() => getLevel());

  useEffect(() => {
    return onLevelChanged((l) => setLevelState(l));
  }, []);

  function update(l: Level) {
    persistLevel(l);
    setLevelState(l);
    emitLevelChanged(l);
  }

  return [level, update];
}
