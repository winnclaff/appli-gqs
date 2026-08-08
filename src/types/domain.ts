export type Referentiel = {
  id: string;
  code: string;
  name: string;
  official_source_name: string;
  official_source_url: string | null;
  is_free: boolean;
  sort_order: number;
};

export type Theme = {
  id: string;
  referentiel_id: string;
  code: string | null;
  title: string;
  icon: string | null;
  short_description: string | null;
  sort_order: number;
};

export type MemoCard = {
  id: string;
  theme_id: string;
  title: string;
  action_steps: string[];
  diagram_url: string | null;
  source_ref: string | null;
  source_name: string;
  source_url: string | null;
  levels: Level[];
  sort_order: number;
};

export type Quiz = {
  id: string;
  theme_id: string | null;
  referentiel_id: string;
  title: string;
  mode: 'theme' | 'mixed';
  default_question_count: number;
};

export type Question = {
  id: string;
  theme_id: string;
  question_number: number | null;
  question_text: string;
  choices: string[];
  correct_choice_index: number;
  explanation: string;
  source_ref: string | null;
  source_name: string;
  source_url: string | null;
  levels: Level[];
  referentiel_codes: string[];
};

export type BadgeCriteriaType =
  | 'quiz_completed'
  | 'theme_mastered'
  | 'streak'
  | 'score_perfect'
  | 'daily_streak';

export type Badge = {
  id: string;
  title: string;
  description: string;
  icon: string | null;
  criteria_type: BadgeCriteriaType;
  criteria_value: number;
};

export type Level = 'grand_public' | 'psc' | 'pse' | 'afgsu';
export type QuizMode = 'theme' | 'mixed' | 'review';
export type QuestionCount = 5 | 10;

export const LEVELS: { code: Level; label: string; short: string; description: string }[] = [
  {
    code: 'grand_public',
    label: 'Grand public (GQS)',
    short: 'Grand public',
    description: 'Gestes qui sauvent — sensibilisation ouverte à tous.',
  },
  {
    code: 'psc',
    label: 'Citoyen (PSC)',
    short: 'PSC',
    description: 'Prévention et Secours Civiques niveau 1.',
  },
  {
    code: 'pse',
    label: 'Secouriste (PSE1/PSE2)',
    short: 'PSE',
    description: 'Premiers Secours en Équipe.',
  },
  {
    code: 'afgsu',
    label: 'Professionnel de santé (AFGSU)',
    short: 'AFGSU',
    description: "Attestation de Formation aux Gestes et Soins d'Urgence.",
  },
];
