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
  question_text: string;
  choices: string[];
  correct_choice_index: number;
  explanation: string;
  source_ref: string | null;
  source_name: string;
  source_url: string | null;
};

export type BadgeCriteriaType =
  | 'quiz_completed'
  | 'theme_mastered'
  | 'streak'
  | 'score_perfect';

export type Badge = {
  id: string;
  title: string;
  description: string;
  icon: string | null;
  criteria_type: BadgeCriteriaType;
  criteria_value: number;
};

export type QuizMode = 'theme' | 'mixed';
export type QuestionCount = 5 | 10;
