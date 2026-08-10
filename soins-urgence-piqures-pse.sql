-- ============================================================
-- Fiche manquante PSE — Piqûres et envenimations
-- Comble le seul trou détecté lors de l'audit questions/fiches PSE :
-- la question N°3 (piqûre de méduse) n'avait aucune fiche associée.
-- ============================================================

insert into memo_cards (theme_id, title, action_steps, source_ref, source_name, source_url, levels, sort_order) values

('a0000000-0000-0000-0000-000000000110', 'Piqûres et envenimations',
'["Piqûre de méduse : rincer abondamment à l''eau de mer, jamais à l''eau douce ni au vinaigre.",
  "Retirer les résidus de tentacules visibles sans les toucher à mains nues (utiliser un objet rigide, du sable ou un gant).",
  "Piqûre d''insecte (guêpe, abeille) : retirer le dard s''il est visible, désinfecter la zone, appliquer du froid pour limiter l''inflammation.",
  "Surveiller l''apparition de signes de réaction allergique grave (gonflement du visage ou de la gorge, difficulté respiratoire, malaise) : alerter immédiatement le 15 si l''un de ces signes apparaît.",
  "Toute piqûre avec douleur intense persistante, réaction étendue, ou localisation à risque (visage, cou, bouche) justifie un avis médical."]',
null, 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
ARRAY['pse'], 4);
