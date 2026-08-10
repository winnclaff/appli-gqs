-- ============================================================
-- Signalement d'erreurs sur les questions (bouton "Signaler une erreur")
-- Écriture publique (n'importe quel visiteur peut signaler une question),
-- lecture réservée à l'administrateur via le Table Editor Supabase
-- (session authentifiée du dashboard, qui contourne RLS) — aucune policy
-- SELECT n'est créée pour le rôle public.
-- ============================================================

create table error_reports (
  id uuid primary key default gen_random_uuid(),
  question_id uuid references questions(id) on delete set null,
  question_number int,
  created_at timestamptz not null default now()
);

alter table error_reports enable row level security;

create policy "public insert error_reports" on error_reports
  for insert
  with check (true);
