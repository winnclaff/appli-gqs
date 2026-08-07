-- ============================================================
-- Schéma Supabase — App révision Soins d'Urgence (v1 GQS)
-- Public, sans compte utilisateur. Contenu en lecture seule côté client.
-- Progression et badges gérés en local storage côté client (pas de table user).
-- ============================================================

-- ---------- Référentiels (v1 = un seul : GQS, prêts pour AFGSU/PSE plus tard) ----------
create table referentiels (
  id uuid primary key default gen_random_uuid(),
  code text unique not null,              -- ex: 'gqs', 'afgsu2', 'pse1'
  name text not null,                     -- ex: 'Gestes Qui Sauvent'
  official_source_name text not null,     -- ex: 'DGSCGC - Ministère de l'Intérieur'
  official_source_url text,
  is_free boolean not null default true,  -- v1: true pour GQS. false pour les futurs référentiels payants
  sort_order int not null default 0
);

-- ---------- Thèmes (= chapitres du référentiel) ----------
create table themes (
  id uuid primary key default gen_random_uuid(),
  referentiel_id uuid not null references referentiels(id) on delete cascade,
  title text not null,                    -- ex: 'Secourir une personne'
  icon text,                              -- nom d'icône (lucide-react)
  short_description text,
  sort_order int not null default 0
);

-- ---------- Fiches mémo (= fiches PR/FT/AC du référentiel) ----------
create table memo_cards (
  id uuid primary key default gen_random_uuid(),
  theme_id uuid not null references themes(id) on delete cascade,
  title text not null,                    -- ex: 'Compression directe'
  action_steps jsonb not null,            -- liste structurée des étapes (conduite à tenir)
  diagram_url text,                       -- schéma / visuel du geste
  source_ref text,                        -- ex: '[02FT01 / 12-2023] GQS Compression directe'
  source_name text not null,              -- ex: 'GQS - DGSCGC, éd. déc. 2023'
  source_url text,
  sort_order int not null default 0
);

-- ---------- Quiz (regroupement logique, le tirage réel se fait à la volée côté requête) ----------
create table quizzes (
  id uuid primary key default gen_random_uuid(),
  theme_id uuid references themes(id) on delete cascade,  -- NULL = quiz mixte (toutes thématiques du référentiel)
  referentiel_id uuid not null references referentiels(id) on delete cascade,
  title text not null,
  mode text not null default 'theme' check (mode in ('theme', 'mixed')),
  default_question_count int not null default 5
);

-- ---------- Questions ----------
create table questions (
  id uuid primary key default gen_random_uuid(),
  theme_id uuid not null references themes(id) on delete cascade,  -- rattachement direct pour permettre le mode mixte
  question_text text not null,
  choices jsonb not null,                 -- ["choix A", "choix B", "choix C", "choix D"]
  correct_choice_index int not null,
  explanation text not null,
  source_ref text,
  source_name text not null,
  source_url text
);

-- ---------- Badges (définitions statiques ; état débloqué géré en local storage client) ----------
create table badges (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text not null,
  icon text,
  criteria_type text not null check (criteria_type in ('quiz_completed', 'theme_mastered', 'streak', 'score_perfect')),
  criteria_value int not null default 1   -- ex: nombre de quiz, longueur de série, etc.
);

-- ---------- Sécurité : lecture publique seule, aucune écriture côté client ----------
alter table referentiels enable row level security;
alter table themes enable row level security;
alter table memo_cards enable row level security;
alter table quizzes enable row level security;
alter table questions enable row level security;
alter table badges enable row level security;

create policy "public read referentiels" on referentiels for select using (true);
create policy "public read themes" on themes for select using (true);
create policy "public read memo_cards" on memo_cards for select using (true);
create policy "public read quizzes" on quizzes for select using (true);
create policy "public read questions" on questions for select using (true);
create policy "public read badges" on badges for select using (true);

-- Aucune policy insert/update/delete : le contenu est seedé manuellement (SQL ou script), pas via l'app.
