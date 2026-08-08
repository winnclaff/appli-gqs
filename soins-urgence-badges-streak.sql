-- ============================================================
-- Ajout des badges de streak quotidien (jours de suite, pas la série
-- de bonnes réponses dans un quiz qui existe déjà via criteria_type 'streak').
-- ============================================================

alter table badges drop constraint if exists badges_criteria_type_check;
alter table badges add constraint badges_criteria_type_check
  check (criteria_type in ('quiz_completed', 'theme_mastered', 'streak', 'score_perfect', 'daily_streak'));

insert into badges (title, description, icon, criteria_type, criteria_value) values
('Trois jours de suite', 'Réviser 3 jours d''affilée.', 'calendar-check', 'daily_streak', 3),
('Une semaine assidue', 'Réviser 7 jours d''affilée.', 'calendar-check', 'daily_streak', 7),
('Un mois de régularité', 'Réviser 30 jours d''affilée.', 'calendar-check', 'daily_streak', 30);
