-- ============================================================
-- Seed v2 — Fiches mémo complémentaires
-- À exécuter APRÈS soins-urgence-seed-v2.sql
-- 10 nouvelles fiches ciblant les thèmes sans contenu au niveau grand public / PSC.
-- Aligné sur la RTN 2026 (GQS/PSC). Aucune formulation copiée du référentiel.
-- ============================================================

insert into memo_cards (theme_id, title, action_steps, source_ref, source_name, source_url, levels, sort_order) values

-- ---------- 104 : Obstruction des voies aériennes (2 fiches) ----------

('a0000000-0000-0000-0000-000000000104', 'Étouffement (adulte et grand enfant)',
'["Reconnaître : la personne ne peut plus parler, tousser efficacement ou respirer ; elle porte souvent les mains à la gorge.",
  "Donner jusqu''à 5 claques dorsales entre les omoplates, avec le talon de la main, la personne penchée en avant.",
  "Si sans effet, réaliser jusqu''à 5 compressions abdominales (méthode de Heimlich) au-dessus du nombril, poings serrés vers soi et vers le haut.",
  "Alterner 5 claques et 5 compressions tant que l''obstruction persiste et que la personne reste consciente.",
  "Si la victime perd connaissance : l''allonger au sol, alerter les secours et débuter la RCP."]',
null, 'RTN GQS + PSC (DGSCGC, éd. 2026)',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
ARRAY['grand_public','psc'], 1),

('a0000000-0000-0000-0000-000000000104', 'Étouffement (nourrisson < 1 an)',
'["Reconnaître : le nourrisson ne peut plus pleurer, tousser efficacement ou respirer.",
  "L''installer à cheval sur l''avant-bras, tête plus basse que le corps, et donner 5 claques dorsales entre les omoplates.",
  "Si sans effet, retourner le nourrisson dos contre l''avant-bras et donner 5 compressions thoraciques (2 doigts au milieu du thorax).",
  "Alterner 5 claques dorsales et 5 compressions thoraciques tant que l''obstruction persiste.",
  "Ne jamais réaliser de compressions abdominales chez le nourrisson."]',
null, 'RTN GQS + PSC (DGSCGC, éd. 2026)',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
ARRAY['grand_public','psc'], 2),

-- ---------- 108 : Traumatismes (1 fiche) ----------

('a0000000-0000-0000-0000-000000000108', 'Traumatismes des os et articulations',
'["Ne pas mobiliser la victime ni la partie du corps atteinte.",
  "Ne pas tenter de replacer une déformation visible.",
  "Éviter toute manipulation qui déclenche ou aggrave la douleur.",
  "Alerter le 15 ou le 18 selon la situation et rester auprès de la victime.",
  "Protéger du froid, du chaud excessif et rassurer en attendant les secours."]',
null, 'RTN GQS + PSC (DGSCGC, éd. 2026)',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
ARRAY['grand_public','psc'], 1),

-- ---------- 109 : Urgences médicales (5 fiches) ----------

('a0000000-0000-0000-0000-000000000109', 'Suspicion d''AVC — reconnaître avec VITE',
'["Signes VITE : Visage qui s''affaisse d''un côté, Instabilité ou faiblesse d''un bras, Trouble de la parole, En urgence — appeler le 15.",
  "Noter l''heure d''apparition des premiers signes : elle conditionne la fenêtre thérapeutique.",
  "Installer la victime dans la position où elle se sent le mieux (demi-assise si consciente).",
  "Ne rien lui donner à boire ni à manger.",
  "Rester auprès d''elle et surveiller son état jusqu''à l''arrivée des secours."]',
null, 'RTN GQS + PSC (DGSCGC, éd. 2026)',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
ARRAY['grand_public','psc'], 1),

('a0000000-0000-0000-0000-000000000109', 'Douleur thoracique — suspicion d''infarctus',
'["Reconnaître : douleur ou serrement intense dans la poitrine, éventuellement irradiant dans le bras, la mâchoire ou le dos, avec sueurs, essoufflement, angoisse.",
  "Alerter le 15 immédiatement, sans attendre que la douleur s''aggrave.",
  "Installer la victime au repos strict, en position assise ou demi-assise selon son confort.",
  "Ne rien lui donner à boire ni à manger.",
  "Surveiller conscience et respiration : en cas d''arrêt cardiaque, débuter la RCP et faire chercher un DAE."]',
null, 'RTN GQS + PSC (DGSCGC, éd. 2026)',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
ARRAY['grand_public','psc'], 2),

('a0000000-0000-0000-0000-000000000109', 'Malaise vagal',
'["Reconnaître : sensation de faiblesse, pâleur, sueurs, nausées, vue qui se trouble.",
  "Aider la personne à s''accroupir ou à s''allonger avec les jambes surélevées si possible.",
  "Alternative en position assise prolongée : croiser les jambes et crocheter les doigts en tirant (manœuvre anti-évanouissement).",
  "Desserrer les vêtements, aérer et éviter la station debout tant que la personne n''a pas pleinement récupéré.",
  "Si le malaise se prolonge ou s''accompagne d''un autre signe (douleur, trouble de la parole…), alerter le 15."]',
null, 'RTN PSC (DGSCGC, éd. 2026)',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
ARRAY['psc'], 3),

('a0000000-0000-0000-0000-000000000109', 'Réaction allergique grave (anaphylaxie)',
'["Reconnaître : gonflement du visage ou de la gorge, difficulté respiratoire, éruption cutanée étendue, malaise ou perte de connaissance après contact avec un allergène (aliment, piqûre, médicament).",
  "Alerter le 15 immédiatement.",
  "Si la victime possède un stylo auto-injecteur d''adrénaline, l''aider à l''utiliser dans la cuisse (au travers des vêtements si besoin).",
  "Installer selon les signes : allongée jambes surélevées si malaise, assise si difficulté respiratoire, PLS si inconsciente et respire.",
  "En l''absence d''amélioration, une seconde injection d''adrénaline peut être réalisée 5 minutes plus tard (RTN 2026)."]',
null, 'RTN PSC + PSE (DGSCGC, éd. 2026)',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
ARRAY['psc','pse'], 4),

('a0000000-0000-0000-0000-000000000109', 'Difficulté respiratoire',
'["Reconnaître : essoufflement au repos, respiration bruyante ou sifflante, incapacité à finir une phrase, lèvres bleutées.",
  "Installer la victime en position assise ; ne pas la forcer à s''allonger.",
  "Alerter le 15 et rester en ligne pour transmettre les évolutions.",
  "Si la personne a un traitement personnel adapté (inhalateur pour asthme, auto-injecteur d''adrénaline), l''aider à le prendre.",
  "Surveiller la conscience et la respiration en continu."]',
null, 'RTN GQS + PSC (DGSCGC, éd. 2026)',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
ARRAY['grand_public','psc'], 5),

-- ---------- 110 : Environnement (2 fiches) ----------

('a0000000-0000-0000-0000-000000000110', 'Brûlures — conduite à tenir',
'["Écarter la victime de la source de chaleur en toute sécurité pour le sauveteur.",
  "Refroidir la zone brûlée à l''eau tempérée du robinet, dès que possible, pendant 10 à 20 minutes.",
  "Retirer sans forcer les vêtements et bijoux avant qu''ils n''adhèrent ; ne pas décoller ce qui colle à la peau.",
  "Alerter le 15 dès le début du refroidissement pour toute brûlure grave (surface > moitié de la paume, cloques étendues, localisation à risque, origine chimique/électrique/radiologique).",
  "Protéger la brûlure avec un tissu propre non pelucheux ; ne jamais appliquer crème, pommade ni film alimentaire (retiré des recommandations 2026)."]',
null, 'RTN GQS + PSC (DGSCGC, éd. 2026)',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
ARRAY['grand_public','psc'], 1),

('a0000000-0000-0000-0000-000000000110', 'Coup de chaleur et malaise thermique',
'["Reconnaître : peau chaude et sèche, température corporelle élevée, maux de tête, nausées, confusion voire perte de connaissance après exposition à la chaleur.",
  "Mettre la victime à l''ombre, dans un lieu frais et aéré.",
  "Déshabiller partiellement pour favoriser l''évacuation de la chaleur.",
  "Rafraîchir activement : linges humides sur le corps, brumisation, ventilation.",
  "Faire boire par petites gorgées si la personne est consciente ; alerter le 15 si les signes ne cèdent pas rapidement ou si la victime perd connaissance."]',
null, 'RTN GQS + PSC (DGSCGC, éd. 2026)',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
ARRAY['grand_public','psc'], 2);
