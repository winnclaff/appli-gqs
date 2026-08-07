-- ============================================================
-- Migration schema v2 — App révision Soins d'Urgence
-- - Étend le contenu au-delà du GQS : PSC / PSE / AFGSU
-- - Ajoute levels (public visé) et referentiel_codes (source) sur questions
-- - Ajoute levels sur memo_cards pour filtrer par niveau utilisateur
-- - Ajoute question_number (N° de la base Notion) + notion_url
-- - Ajoute code slug sur themes pour référencement stable
--
-- Sans utilisateur en base, sans progression serveur ; donc migration
-- destructive : on truncate le contenu, on ré-insère via le nouveau seed.
-- ============================================================

-- ---------- ALTER TABLES ----------
alter table themes add column if not exists code text unique;

alter table memo_cards
  add column if not exists levels text[] not null default '{}';

alter table questions
  add column if not exists question_number int,
  add column if not exists levels text[] not null default '{}',
  add column if not exists referentiel_codes text[] not null default '{}',
  add column if not exists notion_url text;

-- N° unique par question quand présent
create unique index if not exists questions_question_number_uidx
  on questions (question_number)
  where question_number is not null;

-- Index pour les filtres par niveau
create index if not exists memo_cards_levels_gin_idx on memo_cards using gin (levels);
create index if not exists questions_levels_gin_idx on questions using gin (levels);

-- ---------- RESET du contenu (schema conservé, données remplacées) ----------
-- Ordre : dépendances filles d'abord (les FKs ON DELETE CASCADE le feraient,
-- mais on est explicite pour la lisibilité)
truncate table quizzes, questions, memo_cards, themes, referentiels restart identity cascade;

-- ---------- REFERENTIELS ----------
insert into referentiels (id, code, name, official_source_name, official_source_url, is_free, sort_order) values
('a0000000-0000-0000-0000-000000000001', 'gqs', 'Gestes Qui Sauvent',
 'DGSCGC - Ministère de l''Intérieur',
 'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
 true, 1),
('a0000000-0000-0000-0000-000000000002', 'psc', 'Prévention et Secours Civiques (PSC)',
 'DGSCGC - Ministère de l''Intérieur (RTN 2026)',
 'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
 true, 2),
('a0000000-0000-0000-0000-000000000003', 'pse', 'Premiers Secours en Équipe (PSE1/PSE2)',
 'DGSCGC - Ministère de l''Intérieur (RTN 2026)',
 'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
 true, 3),
('a0000000-0000-0000-0000-000000000004', 'afgsu', 'AFGSU (Attestation de Formation aux Gestes et Soins d''Urgence)',
 'Arrêté du 30 décembre 2014 modifié le 1er juillet 2019',
 'https://www.legifrance.gouv.fr/loda/id/JORFTEXT000030057015/',
 true, 4),
('a0000000-0000-0000-0000-000000000005', 'sse_2024', 'Situations Sanitaires Exceptionnelles',
 'Décret n° 2024-8 du 3 janvier 2024',
 'https://www.legifrance.gouv.fr/jorf/id/JORFTEXT000048963247',
 true, 5),
('a0000000-0000-0000-0000-000000000006', 'damage_control', 'Doctrine médicale — Damage control',
 'Recommandations médicales issues du secours tactique',
 null,
 true, 6);

-- ---------- THEMES (14) ----------
insert into themes (id, referentiel_id, code, title, icon, short_description, sort_order) values
('a0000000-0000-0000-0000-000000000101', 'a0000000-0000-0000-0000-000000000001', 'alerte',
 'Alerte', 'phone-call',
 'Numéros d''urgence et message d''alerte : ce que doivent savoir les secours.', 1),
('a0000000-0000-0000-0000-000000000102', 'a0000000-0000-0000-0000-000000000001', 'protection_epi',
 'Protection / EPI', 'shield',
 'Se protéger, protéger la victime, protéger les témoins.', 2),
('a0000000-0000-0000-0000-000000000103', 'a0000000-0000-0000-0000-000000000001', 'hemorragies',
 'Hémorragies', 'droplet',
 'Compression, garrot, pansement compressif : arrêter le saignement.', 3),
('a0000000-0000-0000-0000-000000000104', 'a0000000-0000-0000-0000-000000000001', 'obstruction_va',
 'Obstruction des voies aériennes', 'wind',
 'Étouffement : claques dorsales, compressions abdominales, particularités du nourrisson.', 4),
('a0000000-0000-0000-0000-000000000105', 'a0000000-0000-0000-0000-000000000001', 'pls',
 'Perte de connaissance / PLS', 'user',
 'Reconnaître, libérer les voies aériennes, mettre en position latérale de sécurité.', 5),
('a0000000-0000-0000-0000-000000000106', 'a0000000-0000-0000-0000-000000000001', 'rcp_dae',
 'Arrêt cardiaque / RCP / DAE', 'heart-pulse',
 'Massage cardiaque, insufflations, défibrillation.', 6),
('a0000000-0000-0000-0000-000000000107', 'a0000000-0000-0000-0000-000000000001', 'plaies',
 'Plaies', 'bandage',
 'Plaies simples ou graves, corps étrangers, positions d''attente.', 7),
('a0000000-0000-0000-0000-000000000108', 'a0000000-0000-0000-0000-000000000001', 'traumatismes',
 'Traumatismes', 'bone',
 'Os, articulations, rachis : ne pas mobiliser, stabiliser, alerter.', 8),
('a0000000-0000-0000-0000-000000000109', 'a0000000-0000-0000-0000-000000000001', 'urgences_medicales',
 'Urgences médicales', 'activity',
 'Malaise, AVC, difficulté respiratoire, allergie grave.', 9),
('a0000000-0000-0000-0000-000000000110', 'a0000000-0000-0000-0000-000000000001', 'environnement',
 'Environnement', 'sun',
 'Brûlures, chaleur, froid, piqûres, électricité.', 10),
('a0000000-0000-0000-0000-000000000111', 'a0000000-0000-0000-0000-000000000001', 'sse',
 'Situations sanitaires exceptionnelles', 'siren',
 'ORSAN, ORSEC, damage control, risques NRBC-E.', 11),
('a0000000-0000-0000-0000-000000000112', 'a0000000-0000-0000-0000-000000000001', 'cadre_reglementaire',
 'Cadre réglementaire / organisation', 'scale',
 'Public visé, durée, encadrement, recertification des formations.', 12),
('a0000000-0000-0000-0000-000000000113', 'a0000000-0000-0000-0000-000000000001', 'contenu_technique',
 'Contenu technique', 'book-open',
 'Modules AFGSU, notions d''urgences vitales et potentielles.', 13),
('a0000000-0000-0000-0000-000000000114', 'a0000000-0000-0000-0000-000000000001', 'organisation_materiel',
 'Organisation / matériel', 'briefcase',
 'Matériel pédagogique, chariot d''urgence, oxygénothérapie.', 14);

-- ---------- QUIZZES (regroupements ; le tirage réel se fait à la volée côté app) ----------
-- On simplifie : un quiz mixte tous niveaux confondus, filtré côté app par le level choisi.
-- Les quiz par thème sont dérivés dynamiquement dans l'app à partir des themes.
insert into quizzes (theme_id, referentiel_id, title, mode, default_question_count) values
(null, 'a0000000-0000-0000-0000-000000000001', 'Quiz mélangé', 'mixed', 10);
