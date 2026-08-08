-- ============================================================
-- Seed v3 — Combler le contenu PSE et AFGSU (0 et 1 fiche → couverture complète)
-- À exécuter en une fois dans Supabase SQL Editor.
--
-- Partie 1 : retag de fiches existantes dont le contenu est identique en
--            PSC/PSE selon la RTN 2026 (aucune réécriture, juste levels).
-- Partie 2 : extension de 2 fiches existantes avec un détail PSE en plus.
-- Partie 3 : 7 nouvelles fiches PSE spécifiques (technique équipier).
-- Partie 4 : 5 nouvelles fiches AFGSU (cadre, modules, ORSAN, damage control).
-- ============================================================

-- ---------- Partie 1 : retag fiches partagées grand_public → + psc/pse ----------

update memo_cards set levels = ARRAY['grand_public','psc'] where title = 'Protection';
update memo_cards set levels = ARRAY['grand_public','psc'] where title = 'Alerte';
update memo_cards set levels = ARRAY['grand_public','psc','pse'] where title = 'Hémorragies externes';
update memo_cards set levels = ARRAY['grand_public','psc','pse'] where title = 'Compression directe';
update memo_cards set levels = ARRAY['grand_public','psc'] where title = 'Perte de connaissance';
update memo_cards set levels = ARRAY['grand_public','psc'] where title = 'Libération des voies aériennes';
update memo_cards set levels = ARRAY['grand_public','psc'] where title = 'Position latérale de sécurité';
update memo_cards set levels = ARRAY['grand_public','psc','pse'] where title = 'Arrêt cardiaque';
update memo_cards set levels = ARRAY['grand_public','psc','pse'] where title = 'Compressions thoraciques';
update memo_cards set levels = ARRAY['grand_public','psc','pse'] where title = 'Insufflations';
update memo_cards set levels = ARRAY['grand_public','psc','pse'] where title = 'Défibrillation';
update memo_cards set levels = ARRAY['grand_public','psc'] where title = 'Défibrillateur automatisé externe (DAE)';
update memo_cards set levels = ARRAY['grand_public','psc'] where title = 'Plaies';
update memo_cards set levels = ARRAY['grand_public','psc','pse'] where title = 'Étouffement (adulte et grand enfant)';
update memo_cards set levels = ARRAY['grand_public','psc','pse'] where title = 'Étouffement (nourrisson < 1 an)';

-- ---------- Partie 2 : extension de 2 fiches avec détail PSE ----------

update memo_cards set
  levels = ARRAY['grand_public','psc','pse'],
  action_steps = '["Utiliser le garrot uniquement si la compression directe est inefficace ou impossible sur une hémorragie de membre.",
    "Le placer à quelques centimètres de la plaie (5 à 7 cm), entre la plaie et la racine du membre, jamais sur une articulation.",
    "Privilégier un garrot de fabrication industrielle (barre de serrage ou mécanisme à cran) ; les garrots pneumatiques sont également reconnus comme garrots industriels. Les garrots élastiques de prélèvement sanguin sont à exclure.",
    "Serrer jusqu''à l''arrêt complet du saignement et ne jamais le desserrer sans avis médical.",
    "Noter et transmettre l''heure de pose aux secours."]'
where title = 'Garrot';

update memo_cards set
  levels = ARRAY['grand_public','psc','pse'],
  action_steps = '["Écarter la victime de la source de chaleur en toute sécurité pour le sauveteur.",
    "Refroidir la zone brûlée à l''eau tempérée du robinet, dès que possible, pendant 10 à 20 minutes.",
    "Retirer sans forcer les vêtements et bijoux avant qu''ils n''adhèrent ; ne pas décoller ce qui colle à la peau.",
    "Alerter le 15 dès le début du refroidissement pour toute brûlure grave (surface > moitié de la paume, cloques étendues, localisation à risque, origine chimique/électrique/radiologique).",
    "Protéger la brûlure avec un tissu propre non pelucheux, ou un film alimentaire posé sans serrer comme protection non adhérente ; ne jamais appliquer crème ni pommade.",
    "Chez le jeune enfant, surveiller un refroidissement excessif du corps en cas d''arrosage prolongé."]'
where title = 'Brûlures — conduite à tenir';

-- ---------- Partie 3 : 7 nouvelles fiches PSE ----------

insert into memo_cards (theme_id, title, action_steps, source_ref, source_name, source_url, levels, sort_order) values

('a0000000-0000-0000-0000-000000000103', 'Packing et pansements hémostatiques',
'["Réservé aux plaies hémorragiques profondes formant une cavité, quand la compression directe simple ne suffit pas.",
  "Remplir la cavité de compresses (packing) avant d''appliquer un pansement compressif d''urgence par-dessus.",
  "Une gaze hémostatique peut être utilisée dans le packing, mais ne doit jamais être posée au contact direct des organes ou viscères.",
  "Maintenir la compression et alerter sans délai."]',
null, 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
ARRAY['pse'], 4),

('a0000000-0000-0000-0000-000000000106', 'RCP et DAE chez le nourrisson — spécificités équipier',
'["Compressions thoraciques : les deux pouces l''un sur l''autre, au centre du thorax, mains englobant la cage thoracique.",
  "Si un pouls est perçu mais la respiration reste inefficace : insuffler à une fréquence de 20/min chez le nourrisson (contre 10/min chez l''adulte et le grand enfant, 15/min chez le nouveau-né).",
  "Positionnement des électrodes de DAE déterminé par le poids et non plus par l''âge : au-dessus de 25 kg, positionnement adulte ; en dessous, positionnement pédiatrique.",
  "La réanimation se poursuit pendant la pose des électrodes ; un vêtement gênant peut être simplement déplacé plutôt que retiré."]',
null, 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
ARRAY['pse'], 6),

('a0000000-0000-0000-0000-000000000102', 'Retrait des équipements de protection individuelle (EPI)',
'["Retirer les gants en premier, en les retournant pour ne pas toucher leur face contaminée.",
  "Réaliser une friction hydroalcoolique des mains juste après le retrait des gants.",
  "Retirer ensuite les protections respiratoire et oculaire en dernier.",
  "Cet ordre limite le risque de contamination du visage par des mains encore souillées."]',
null, 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
ARRAY['pse'], 1),

('a0000000-0000-0000-0000-000000000108', 'Suspicion de lésion du rachis — critères d''âge',
'["Suspecter une lésion du rachis face à des réponses non fiables, des signes d''atteinte rachidienne/médullaire, ou un accident à haut risque.",
  "S''ajoute désormais un critère d''âge : 65 ans et plus à lui seul, ou la présence d''antécédents à risque — ce sont deux critères indépendants, pas cumulatifs.",
  "Dans tous les cas : ne pas mobiliser la victime, stabiliser la tête à deux mains si elle est consciente et coopérante, alerter."]',
null, 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
ARRAY['pse'], 2),

('a0000000-0000-0000-0000-000000000109', 'AVC — prise en charge par l''équipier',
'["Rechercher les signes évocateurs : faiblesse d''un bras, déformation du visage, trouble du langage ou de la vision, céphalée sévère inhabituelle.",
  "Noter précisément l''heure d''apparition des premiers signes.",
  "L''oxygénothérapie systématique a été supprimée de la procédure PSE 2026.",
  "Installer la victime à plat si elle le tolère, ou en position latérale de sécurité en cas de nausées ou vomissements.",
  "Alerter le 15 sans délai et transmettre l''heure de début des signes."]',
null, 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
ARRAY['pse'], 6),

('a0000000-0000-0000-0000-000000000110', 'Coup de chaleur — repérer les signes précoces',
'["Le diagnostic ne repose pas uniquement sur une température corporelle supérieure à 40°C.",
  "Des signes neurologiques (confusion, propos incohérents, troubles de la coordination) peuvent précéder l''élévation thermique mesurée.",
  "Le contexte (exposition prolongée, effort intense par forte chaleur) prime autant que le seul chiffre de température.",
  "Distinguer refroidissement passif (ombre, déshabillage, ventilation) et refroidissement actif avancé selon la gravité, et alerter précocement en cas de doute."]',
null, 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
ARRAY['pse'], 3),

('a0000000-0000-0000-0000-000000000109', 'Détresse respiratoire liée aux opiacés',
'["Suspecter une intoxication aux opiacés/opioïdes face à une respiration très ralentie associée à une altération de la conscience.",
  "La ventilation artificielle est indiquée en dessous de 6 mouvements respiratoires par minute.",
  "En cas d''arrêt cardiaque associé, débuter la réanimation en priorité ; l''administration de naloxone intervient après le début de la réanimation, pas avant.",
  "Alerter le 15 dans tous les cas."]',
null, 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
ARRAY['pse'], 7);

-- ---------- Partie 4 : 5 nouvelles fiches AFGSU ----------

insert into memo_cards (theme_id, title, action_steps, source_ref, source_name, source_url, levels, sort_order) values

('a0000000-0000-0000-0000-000000000112', 'AFGSU 1 et 2 — publics et cadre',
'["L''AFGSU 1 s''adresse au personnel non soignant ; l''AFGSU 2 est réservé aux professionnels de santé inscrits à la 4e partie du code de la santé publique (infirmiers, aides-soignants, médecins, etc.).",
  "L''AFGSU 2 inclut des techniques plus avancées avec du matériel : oxygénothérapie, relevage, brancardage.",
  "L''attestation doit être recertifiée tous les 4 ans, aux deux niveaux, pour rester valide.",
  "Le socle premiers secours enseigné en AFGSU 1 et 2 renvoie explicitement aux enseignements du référentiel PSC : les mises à jour PSC concernent donc aussi les professionnels de santé."]',
null, 'AFGSU (Arrêté 30/12/2014 modifié 01/07/2019)',
'https://www.legifrance.gouv.fr/loda/id/JORFTEXT000030057015/',
ARRAY['afgsu'], 1),

('a0000000-0000-0000-0000-000000000113', 'Modules AFGSU — urgences vitales et potentielles',
'["Une urgence vitale engage immédiatement le pronostic vital ; une urgence potentielle peut évoluer vers une urgence vitale en l''absence de prise en charge.",
  "Module 1 (\"urgences vitales\", commun aux AFGSU 1 et 2) : protection, alerte, victime inconsciente, arrêt cardio-respiratoire, obstruction des voies aériennes, hémorragies.",
  "Module 2 (\"urgences potentielles\") : malaise, traumatismes, brûlures, hygiène ; en AFGSU2 s''ajoutent le relevage/brancardage, l''accouchement inopiné et la protection contre le risque infectieux.",
  "Le chariot d''urgence, l''oxygénothérapie et le matériel de surveillance relèvent du module \"urgences vitales\" en AFGSU2, pas du module \"urgences potentielles\"."]',
null, 'AFGSU (Arrêté 30/12/2014 modifié 01/07/2019)',
'https://www.legifrance.gouv.fr/loda/id/JORFTEXT000030057015/',
ARRAY['afgsu'], 1),

('a0000000-0000-0000-0000-000000000113', 'Module risques collectifs et situations sanitaires exceptionnelles',
'["Ce module existe dès l''AFGSU 1 : il n''est pas réservé aux professionnels formés en AFGSU 2.",
  "En AFGSU 2, son contenu est approfondi et complété par les dispositifs ORSAN et ORSEC, la doctrine du damage control et les risques NRBC-E.",
  "Objectif : savoir réagir aux alertes et participer à une prise en charge médico-psychologique en situation exceptionnelle."]',
null, 'AFGSU (Arrêté 30/12/2014 modifié 01/07/2019)',
'https://www.legifrance.gouv.fr/loda/id/JORFTEXT000030057015/',
ARRAY['afgsu'], 2),

('a0000000-0000-0000-0000-000000000111', 'ORSAN — organisation de la réponse sanitaire',
'["ORSAN signifie Organisation de la Réponse du Système de santé en situations sanitaires exceptionnelles (santé, piloté par les ARS).",
  "Ce dispositif est né des limites des anciens plans blancs, propres à chaque hôpital pris isolément.",
  "Il comprend plusieurs sous-plans selon le type de situation : ORSAN EPI (épidémie), ORSAN BIO, ORSAN CLIM (climatique), ORSAN NRC, ORSAN AMAVI (afflux de victimes).",
  "ORSAN (Santé/ARS) et ORSEC (Intérieur/sécurité civile) sont complémentaires et coordonnés, pas redondants."]',
null, 'Décret n° 2024-8 du 3 janvier 2024 (SSE)',
'https://www.legifrance.gouv.fr/jorf/id/JORFTEXT000048963247',
ARRAY['afgsu'], 1),

('a0000000-0000-0000-0000-000000000111', 'Damage control — principes',
'["Le damage control cherche à éviter la triade létale chez un traumatisé grave : hypothermie, acidose, troubles de la coagulation.",
  "Ces trois éléments s''auto-entretiennent et deviennent très difficiles à inverser une fois enclenchés.",
  "Dès l''AFGSU, le PSC et le PSE, des gestes simples y participent : compression manuelle, garrot, positions d''attente, couverture isothermique, oxygène si disponible, pansements hémostatiques.",
  "Le concept, initialement chirurgical, s''est élargi à une prise en charge globale dès le stade préhospitalier — la prévention précoce de la coagulopathie en est l''enjeu prioritaire."]',
null, 'Doctrine médicale — Damage control',
null,
ARRAY['afgsu'], 2);
