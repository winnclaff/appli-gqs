-- ============================================================
-- Refresh des 60 questions depuis Notion (Quiz Secourisme)
-- Date d'export : 2026-08-08
--
-- Louis a corrigé plusieurs entrées après relecture vs les PDF officiels.
-- Notamment N°4 (114 conservé en GQS), N°8 (film alimentaire non retiré),
-- N°12, N°15 (coach → leader), N°23, N°30, N°33, N°37.
--
-- Stratégie : DELETE FROM questions puis INSERT complet.
-- Les IDs Supabase changent — sans impact car les quiz sont tirés à la volée.
-- ============================================================

delete from questions;

insert into questions (theme_id, question_number, question_text, choices, correct_choice_index, explanation, source_name, levels, referentiel_codes) values

-- N°1
('a0000000-0000-0000-0000-000000000112', 1,
 'Quelle est la différence de public visé entre l''AFGSU niveau 1 et l''AFGSU niveau 2 ?',
 '["AFGSU1 pour les professionnels de santé, AFGSU2 pour le grand public","AFGSU1 pour le personnel non soignant, AFGSU2 pour les professionnels de santé (4e partie du code de la santé publique)","Les deux niveaux s''adressent exclusivement aux médecins","Il n''existe aucune différence de public entre les deux niveaux"]',
 1, 'L''AFGSU 2 inclut des techniques plus avancées avec du matériel (oxygénothérapie, relevage, brancardage).',
 'AFGSU (Arrêté 30/12/2014 modifié 01/07/2019)', ARRAY['afgsu'], ARRAY['afgsu']),

-- N°2
('a0000000-0000-0000-0000-000000000103', 2,
 'Que signifie le packing introduit dans la doctrine PSE 2026, et dans quel cas s''applique-t-il ?',
 '["Remplir de compresses une plaie cavitaire profonde avant le pansement compressif","Retirer tout pansement déjà posé","Appliquer uniquement un garrot, sans pansement","Verser un antiseptique directement dans la plaie"]',
 0, 'Technique alignée sur les pratiques du secours tactique. La gaze hémostatique ne doit jamais être posée au contact direct des organes et viscères.',
 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)', ARRAY['pse'], ARRAY['pse']),

-- N°3
('a0000000-0000-0000-0000-000000000110', 3,
 'Comment rincer une piqûre de méduse selon la RTN 2026 ?',
 '["Au vinaigre","À l''eau douce","À l''eau de mer","À l''alcool"]',
 2, 'Changement par rapport aux recommandations antérieures qui mentionnaient le vinaigre.',
 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)', ARRAY['pse'], ARRAY['pse']),

-- N°4 (CORRIGÉE : 114 reste enseigné en GQS)
('a0000000-0000-0000-0000-000000000101', 4,
 'Quels numéros d''urgence sont enseignés lors d''une sensibilisation GQS selon la RTN 2026 ?',
 '["18, 15, 112 uniquement, le 114 ayant été retiré en 2026","18, 15, 112 et 114","15 et 18 uniquement","112 uniquement, numéro européen unique"]',
 1, 'Correction : le 114 reste bien enseigné en GQS dans l''édition 2026, contrairement à ce qu''indiquait une source secondaire utilisée initialement (vérifié sur le PDF officiel RTN GQS 2026, section Alerte).',
 'RTN GQS + PSC (DGSCGC, éd. 2026)', ARRAY['grand_public','psc'], ARRAY['gqs','psc']),

-- N°5
('a0000000-0000-0000-0000-000000000114', 5,
 'Quel matériel pédagogique est désormais obligatoire pour dispenser une formation GQS selon la RTN 2026 ?',
 '["Uniquement un mannequin de RCP, sans autre exigence","Mannequin de RCP avec poumons, maquette de DAE, DAE de formation, maquette de coupe de tête, téléphone neutralisé, matériel de pansement/garrot","Aucun matériel n''est formellement exigé","Un simple document PDF suffit, sans matériel pratique"]',
 1, 'Première fois qu''une liste de matériel pédagogique obligatoire est formalisée pour le GQS ; elle impose un audit des dotations existantes chez les organismes de formation.',
 'RTN GQS (DGSCGC, éd. 2026)', ARRAY['grand_public'], ARRAY['gqs']),

-- N°6
('a0000000-0000-0000-0000-000000000112', 6,
 'Quel est le cadre d''une sensibilisation GQS (âge minimum, durée, ratio d''encadrement) ?',
 '["Public à partir de 16 ans, 4h minimum, 1 formateur pour 30 stagiaires","Public à partir de 10 ans, 2h minimum, 1 formateur pour 15 stagiaires maximum","Public à partir de 6 ans, 1h minimum, 1 formateur pour 10 stagiaires","Public à partir de 18 ans, 2h minimum, 1 formateur pour 20 stagiaires"]',
 1, 'Une adaptation est prévue pour les participants en situation de handicap.',
 'RTN GQS (DGSCGC, éd. 2026)', ARRAY['grand_public'], ARRAY['gqs']),

-- N°7
('a0000000-0000-0000-0000-000000000106', 7,
 'En cas de pouls perçu chez une victime en détresse ventilatoire, quelles fréquences d''insufflation appliquer selon l''âge ?',
 '["10/min adulte et enfant, 20/min nourrisson, 30/min nouveau-né","20/min adulte et enfant, 10/min nourrisson, 15/min nouveau-né","12/min quel que soit l''âge","10/min adulte, 10/min enfant et nourrisson"]',
 0, 'Fréquences actualisées en 2026 ; les 5 insufflations initiales chez l''enfant et le nourrisson (y compris noyade) ont été supprimées.',
 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)', ARRAY['pse'], ARRAY['pse']),

-- N°8 (CORRIGÉE : film alimentaire non retiré, choix A/B inversés, bonne réponse = B)
('a0000000-0000-0000-0000-000000000110', 8,
 'Le film alimentaire (film plastique) fait-il toujours partie des moyens de protection recommandés pour une brûlure en 2026 ?',
 '["Non, il a été retiré des moyens de protection recommandés","Oui, il reste recommandé comme protection non adhérente de la zone brûlée","Oui, mais uniquement pour les brûlures du visage","Le film alimentaire n''a jamais été mentionné dans les recommandations"]',
 1, 'Correction : contrairement à ce qu''indiquait une source secondaire utilisée initialement, le film alimentaire n''a pas été retiré des recommandations (vérifié sur le PDF officiel RTN PSE 2026, fiche Brûlures 07AC01).',
 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)', ARRAY['pse'], ARRAY['pse']),

-- N°9
('a0000000-0000-0000-0000-000000000109', 9,
 'En cas de réaction allergique grave (anaphylaxie) sans amélioration, au bout de combien de temps peut-on réaliser la seconde injection d''adrénaline par auto-injecteur selon la RTN 2026 ?',
 '["1 minute","5 minutes","10 à 15 minutes","30 minutes"]',
 1, 'Délai raccourci pour limiter le risque d''aggravation en l''absence d''amélioration.',
 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)', ARRAY['pse'], ARRAY['pse']),

-- N°10
('a0000000-0000-0000-0000-000000000106', 10,
 'Quel est le ratio compressions thoraciques / insufflations en RCP selon l''âge de la victime ?',
 '["30:2 chez l''adulte, 15:2 chez l''enfant et le nourrisson","15:2 chez l''adulte, 30:2 chez l''enfant et le nourrisson","30:2 dans tous les cas, quel que soit l''âge","15:15 chez l''adulte comme chez l''enfant"]',
 0, 'Le ratio 15:2 chez l''enfant et le nourrisson a été officialisé dans l''édition 2026.',
 'RTN GQS + PSC + PSE (DGSCGC, éd. 2026)', ARRAY['grand_public','psc','pse'], ARRAY['gqs','psc','pse']),

-- N°11
('a0000000-0000-0000-0000-000000000112', 11,
 'Depuis la RTN 2026, quels professionnels de santé peuvent animer une sensibilisation Gestes Qui Sauvent, en plus des formateurs habituels ?',
 '["Uniquement les médecins","Les infirmiers, masseurs-kinésithérapeutes et pharmaciens (4e partie du code de la santé publique)","Aucun professionnel de santé n''est autorisé","Uniquement les sapeurs-pompiers professionnels"]',
 1, 'Objectif affiché : densifier le maillage territorial de la formation citoyenne vers l''objectif de 80 % de citoyens formés.',
 'RTN GQS (DGSCGC, éd. 2026)', ARRAY['grand_public'], ARRAY['gqs']),

-- N°12 (CORRIGÉE : choix A et B inversés, justification enrichie)
('a0000000-0000-0000-0000-000000000113', 12,
 'Quel module de l''AFGSU 2 aborde le chariot d''urgence et l''oxygénothérapie ?',
 '["Le module \"urgences potentielles\"","Le module \"urgences vitales\"","Le module \"risques collectifs\"","Aucun module ne traite ce sujet"]',
 1, 'Ce module de 10h en AFGSU2 ajoute aussi la maintenance et la matériovigilance du matériel d''urgence ; le module "urgences potentielles" reste centré sur malaise, traumatismes et brûlures (source : arrêté du 30 décembre 2014, annexe 2).',
 'AFGSU (Arrêté 30/12/2014 modifié 01/07/2019)', ARRAY['afgsu'], ARRAY['afgsu']),

-- N°13
('a0000000-0000-0000-0000-000000000106', 13,
 'Comment se positionnent les pouces pour les compressions thoraciques chez le nourrisson selon la RTN 2026 ?',
 '["Côte à côte, au centre du thorax","L''un sur l''autre, thorax englobé par les mains","Avec un seul pouce, l''autre main sur le front","Avec la paume de la main, comme chez l''adulte"]',
 1, 'Changement de technique par rapport à l''édition précédente.',
 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)', ARRAY['pse'], ARRAY['pse']),

-- N°14
('a0000000-0000-0000-0000-000000000112', 14,
 'Tous les combien d''années l''AFGSU doit-elle être recertifiée pour rester valide ?',
 '["Tous les 2 ans","Tous les 4 ans","Tous les 6 ans","Une seule fois, sans recertification"]',
 1, 'Cette périodicité de recertification est obligatoire pour maintenir la validité de l''attestation, niveau 1 comme niveau 2.',
 'AFGSU (Arrêté 30/12/2014 modifié 01/07/2019)', ARRAY['afgsu'], ARRAY['afgsu']),

-- N°15 (CORRIGÉE : coach → leader)
('a0000000-0000-0000-0000-000000000106', 15,
 'Quel est le rôle du leader introduit par la RTN 2026 en cas d''arrêt cardiaque ?',
 '["Réaliser seul toutes les compressions thoraciques","Guider, encourager et corriger les gestes des autres secouristes présents","Appeler les secours à la place des autres intervenants","Remplacer le DAE en cas de panne"]',
 1, 'C''est une fonction nouvelle, absente des recommandations 2023.',
 'RTN GQS + PSC + PSE (DGSCGC, éd. 2026)', ARRAY['grand_public','psc','pse'], ARRAY['gqs','psc','pse']),

-- N°16
('a0000000-0000-0000-0000-000000000103', 16,
 'Comment positionner un garrot selon la RTN 2026 ?',
 '["Directement sur l''articulation la plus proche","À quelques centimètres de la plaie (5 à 7 cm), entre la plaie et la racine du membre, jamais sur une articulation","Le plus loin possible de la plaie, près du tronc","Autour du cou pour les hémorragies de la tête"]',
 1, 'L''heure de pose doit être transmise aux secours pour la prise en charge médicale ultérieure.',
 'RTN GQS + PSC + PSE (DGSCGC, éd. 2026)', ARRAY['grand_public','psc','pse'], ARRAY['gqs','psc','pse']),

-- N°17
('a0000000-0000-0000-0000-000000000106', 17,
 'Quel seuil pondéral détermine le positionnement des électrodes de DAE selon la RTN 2026 ?',
 '["10 kg","15 kg","25 kg","40 kg"]',
 2, 'Ce seuil remplace la distinction adulte/nourrisson. La RCP se poursuit pendant la pose des électrodes ; un soutien-gorge peut être simplement déplacé plutôt que retiré.',
 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)', ARRAY['pse'], ARRAY['pse']),

-- N°18
('a0000000-0000-0000-0000-000000000103', 18,
 'Les garrots pneumatiques sont-ils reconnus comme garrots industriels dans la RTN PSE 2026 ?',
 '["Non, ils sont formellement interdits","Oui, ils sont reconnus comme garrots industriels au même titre que les dispositifs à barre de serrage ou à cran","Uniquement en dernier recours, jamais recommandés","Seulement pour un usage vétérinaire"]',
 1, 'Nouveauté de l''édition 2026, spécifique au niveau équipier (PSE).',
 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)', ARRAY['pse'], ARRAY['pse']),

-- N°19
('a0000000-0000-0000-0000-000000000106', 19,
 'Combien de fiches de procédure arrêt cardiaque la RTN 2026 prévoit-elle en PSE, contre combien auparavant ?',
 '["4 fiches, contre 2 auparavant","2 fiches (équipe / sauveteur isolé), contre 4 auparavant","1 fiche unique pour tous les cas","6 fiches selon l''âge de la victime"]',
 1, 'Simplification du chapitre arrêt cardiaque dans l''édition 2026.',
 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)', ARRAY['pse'], ARRAY['pse']),

-- N°20
('a0000000-0000-0000-0000-000000000109', 20,
 'Face à une suspicion d''AVC chez une victime consciente, l''administration systématique d''oxygène fait-elle toujours partie de la procédure PSE 2026 ?',
 '["Oui, systématiquement dès la prise en charge","Non, elle a été supprimée ; la victime est installée à plat ou en PLS si nausées/vomissements","Oui, mais uniquement en cas de fièvre associée","Oui, mais seulement chez l''enfant"]',
 1, 'Évolution notable par rapport aux recommandations antérieures qui prévoyaient une oxygénothérapie systématique.',
 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)', ARRAY['pse'], ARRAY['pse']),

-- N°21
('a0000000-0000-0000-0000-000000000110', 21,
 'Le diagnostic de coup de chaleur repose-t-il uniquement sur une température corporelle supérieure à 40°C selon la RTN 2026 ?',
 '["Oui, le diagnostic repose uniquement sur une température supérieure à 40°C","Non, les signes neurologiques peuvent précéder l''élévation thermique et le contexte prime sur le seul seuil de 40°C","Non, il faut attendre une température supérieure à 42°C","Oui, mais seulement chez l''enfant"]',
 1, 'Une fiche technique dédiée distingue désormais refroidissement passif et refroidissement actif avancé.',
 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)', ARRAY['pse'], ARRAY['pse']),

-- N°22
('a0000000-0000-0000-0000-000000000103', 22,
 'Dans quels cas le pansement compressif doit-il être posé systématiquement, même en l''absence de saignement visible ?',
 '["Une simple égratignure","Une amputation ou un arrachement d''une partie du corps, même sans saignement visible","Une plaie superficielle du bras","Une brûlure simple"]',
 1, 'Nouveauté 2026 : indiqué aussi quand l''hémorragie est déjà contrôlée manuellement et que le secouriste doit se libérer, ou quand la victime ne peut pas comprimer elle-même. Reste exclu pour les plaies du cou, de la tête, du thorax et de l''abdomen.',
 'RTN GQS + PSC + PSE (DGSCGC, éd. 2026)', ARRAY['grand_public','psc','pse'], ARRAY['gqs','psc','pse']),

-- N°23 (CORRIGÉE : critères indépendants, bonne réponse = B)
('a0000000-0000-0000-0000-000000000108', 23,
 'Quel nouveau critère d''âge fait suspecter une lésion du rachis selon la RTN 2026 ?',
 '["50 ans et plus, uniquement combiné à des antécédents à risque","65 ans et plus, à lui seul, ou la présence d''antécédents à risque (deux critères indépendants)","60 ans et plus, sans autre critère","75 ans et plus, systématiquement"]',
 1, 'Précision : le texte relie les deux critères par "ou" (deux critères indépendants), pas "et" (vérifié sur le PDF officiel RTN PSE 2026, fiche Traumatismes du rachis).',
 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)', ARRAY['pse'], ARRAY['pse']),

-- N°24
('a0000000-0000-0000-0000-000000000102', 24,
 'Dans quel ordre retirer ses équipements de protection individuelle (EPI) selon la RTN 2026 ?',
 '["Protections respiratoire/oculaire en premier, gants en dernier","Gants en premier, friction hydroalcoolique, puis protections respiratoire et oculaire en dernier","Tout retirer simultanément","Friction hydroalcoolique avant tout retrait d''équipement"]',
 1, 'Cet ordre est inversé par rapport aux recommandations antérieures.',
 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)', ARRAY['pse'], ARRAY['pse']),

-- N°25
('a0000000-0000-0000-0000-000000000104', 25,
 'Quels critères déclenchent les claques dans le dos en cas d''étouffement selon la RTN 2026 ?',
 '["Dès la moindre toux, même efficace","Uniquement si la victime est inconsciente","Victime incapable de parler ou de tousser, toux devenue inefficace (ou nourrisson incapable de pleurer/respirer)","Uniquement en cas de cyanose des lèvres"]',
 2, 'La fiche obstruction partielle a disparu au profit d''une approche binaire (obstruction totale ou non), basée sur des critères fonctionnels.',
 'RTN GQS + PSC + PSE (DGSCGC, éd. 2026)', ARRAY['grand_public','psc','pse'], ARRAY['gqs','psc','pse']),

-- N°26
('a0000000-0000-0000-0000-000000000109', 26,
 'À partir de quel seuil de fréquence respiratoire la ventilation artificielle est-elle indiquée en cas d''intoxication aux opiacés/opioïdes ?',
 '["Moins de 6 mouvements/minute","Moins de 12 mouvements/minute","Moins de 20 mouvements/minute","Uniquement en l''absence totale de respiration"]',
 0, 'L''administration de naloxone intervient après le début de la réanimation en cas d''arrêt cardiaque, pas avant.',
 'RTN PSE1/PSE2 (DGSCGC, éd. 2026)', ARRAY['pse'], ARRAY['pse']),

-- N°27
('a0000000-0000-0000-0000-000000000106', 27,
 'Faut-il attendre les instructions vocales du DAE après la délivrance (ou non) du choc électrique pour reprendre la RCP ?',
 '["Attendre les instructions vocales du DAE avant de reprendre","Attendre 30 secondes avant de reprendre","Reprendre immédiatement la RCP après le choc, sans attendre les instructions vocales","Ne plus reprendre la RCP après un choc"]',
 2, 'Chaque seconde d''interruption des compressions thoraciques pénalise les chances de survie.',
 'RTN GQS + PSC + PSE (DGSCGC, éd. 2026)', ARRAY['grand_public','psc','pse'], ARRAY['gqs','psc','pse']),

-- N°28
('a0000000-0000-0000-0000-000000000103', 28,
 'Face à une hémorragie externe, qui doit réaliser la compression en premier selon la RTN 2026 ?',
 '["Le secouriste, systématiquement","La victime elle-même, si elle en est capable","Un témoin désigné par le secouriste","Personne, il faut attendre les secours"]',
 1, 'Ce changement de logique, inspiré des situations à victimes multiples, permet au secouriste de rester disponible pour l''alerte ou la prise en charge d''autres victimes.',
 'RTN GQS + PSC + PSE (DGSCGC, éd. 2026)', ARRAY['grand_public','psc','pse'], ARRAY['gqs','psc','pse']),

-- N°29
('a0000000-0000-0000-0000-000000000112', 29,
 'Le contenu du socle premiers secours enseigné en AFGSU 1 et 2 s''appuie-t-il sur un autre référentiel de sécurité civile ?',
 '["Non, les deux référentiels sont totalement indépendants","Oui, les référentiels AFGSU renvoient explicitement aux enseignements du PSC","Non, l''AFGSU se base uniquement sur le PSE2","Oui, mais uniquement pour l''AFGSU1"]',
 1, 'D''où l''intérêt, pour un professionnel de santé, de connaître aussi les mises à jour du référentiel PSC (RTN 2026).',
 'AFGSU (Arrêté 30/12/2014 modifié 01/07/2019)', ARRAY['afgsu'], ARRAY['afgsu']),

-- N°30 (CORRIGÉE : nuance industriels vs improvisés)
('a0000000-0000-0000-0000-000000000103', 30,
 'Quel type de garrot la RTN 2026 recommande-t-elle en priorité ?',
 '["Le garrot élastique de prélèvement sanguin","Le garrot improvisé, toujours préférable","Le garrot de fabrication industrielle (barre de serrage ou mécanisme à cran)","Peu importe, tous les garrots se valent"]',
 2, 'Nuance : le texte décrit les deux types de garrot sans les hiérarchiser explicitement ; seule l''efficacité du garrot industriel est qualifiée d''"excellente" (vérifié sur le PDF officiel RTN PSC/PSE 2026, fiche Garrot). Les garrots élastiques de prélèvement sanguin restent explicitement exclus.',
 'RTN GQS + PSC + PSE (DGSCGC, éd. 2026)', ARRAY['grand_public','psc','pse'], ARRAY['gqs','psc','pse']),

-- N°31
('a0000000-0000-0000-0000-000000000111', 31,
 'Que signifie le sigle ORSAN et à quoi sert ce dispositif ?',
 '["Organisation de la Réponse de Sécurité Civile","Organisation de la Réponse du Système de Santé en Situations Sanitaires Exceptionnelles","Organisme Régional de Sécurité et d''Assistance Nationale","Ordre des Secours et de l''Assistance Nationale"]',
 1, 'Le plan ORSAN est né des limites des anciens plans blancs propres à chaque hôpital.',
 'Décret n° 2024-8 du 3 janvier 2024 (SSE)', ARRAY['afgsu'], ARRAY['sse_2024']),

-- N°32
('a0000000-0000-0000-0000-000000000107', 32,
 'Quelle position d''attente adopter face à une plaie de l''œil ?',
 '["Assise, tête penchée en avant","Allongée, yeux fermés, sans bouger la tête","Debout, tête en arrière","Allongée sur le ventre"]',
 1, 'L''immobilisation de la tête limite le risque d''aggravation de la lésion oculaire.',
 'RTN PSC (DGSCGC, éd. 2026)', ARRAY['psc'], ARRAY['psc']),

-- N°33 (CORRIGÉE : reformulée complètement)
('a0000000-0000-0000-0000-000000000113', 33,
 'Que couvre le module 2 de l''AFGSU consacré aux "urgences potentielles" ?',
 '["Malaise, traumatismes, brûlures, hygiène (+ relevage/brancardage, accouchement inopiné, protection risque infectieux en AFGSU2)","Uniquement le chariot d''urgence et l''oxygénothérapie","Protection et alerte uniquement","Risques NRBC-E exclusivement"]',
 0, 'Le chariot d''urgence et le matériel de surveillance relèvent en réalité du module "urgences vitales" en AFGSU2, pas du module "urgences potentielles" (source : arrêté du 30 décembre 2014, annexes 1 et 2).',
 'AFGSU (Arrêté 30/12/2014 modifié 01/07/2019)', ARRAY['afgsu'], ARRAY['afgsu']),

-- N°34
('a0000000-0000-0000-0000-000000000111', 34,
 'Quels gestes concrets, enseignés dès l''AFGSU/PSC/PSE, participent à la logique de damage control ?',
 '["Uniquement la pose d''une perfusion","Compression manuelle, garrot, positions d''attente, couverture isothermique, oxygène si disponible, pansements hémostatiques","Uniquement l''administration de médicaments","Le transport rapide sans aucun geste préalable"]',
 1, 'Ces gestes simples de premiers secours participent à la lutte précoce contre la triade létale, en amont de la prise en charge chirurgicale.',
 'Doctrine médicale — Damage control', ARRAY['afgsu'], ARRAY['damage_control']),

-- N°35
('a0000000-0000-0000-0000-000000000110', 35,
 'Quelle conduite à tenir face à un malaise lié à la chaleur ?',
 '["Couvrir la victime pour la réchauffer","Lieu frais et aéré, déshabiller, rafraîchir, faire boire par petites quantités","Faire boire une grande quantité d''eau rapidement","Masser les membres pour stimuler la circulation"]',
 1, 'Objectif : abaisser rapidement la température corporelle tout en surveillant l''état de conscience.',
 'RTN GQS + PSC (DGSCGC, éd. 2026)', ARRAY['grand_public','psc'], ARRAY['gqs','psc']),

-- N°36
('a0000000-0000-0000-0000-000000000111', 36,
 'Cite au moins trois sous-plans du dispositif ORSAN.',
 '["ORSAN NORD, ORSAN SUD, ORSAN EST","ORSAN EPI, ORSAN BIO, ORSAN CLIM, ORSAN NRC, ORSAN AMAVI","ORSAN 1, ORSAN 2, ORSAN 3","ORSAN A, ORSAN B, ORSAN C"]',
 1, 'Chaque sous-plan cible un type de situation sanitaire exceptionnelle spécifique.',
 'Décret n° 2024-8 du 3 janvier 2024 (SSE)', ARRAY['afgsu'], ARRAY['sse_2024']),

-- N°37 (CORRIGÉE : reformulée complètement)
('a0000000-0000-0000-0000-000000000111', 37,
 'Le module "risques collectifs" de l''AFGSU est-il réservé aux professionnels formés en AFGSU2 ?',
 '["Oui, il n''existe qu''en AFGSU2","Non, il existe dès l''AFGSU1, mais il est approfondi et complété par ORSAN en AFGSU2","Non, il n''existe dans aucun des deux niveaux","Oui, mais uniquement pour les formateurs"]',
 1, 'Contrairement à une idée reçue, ce module n''est pas propre à l''AFGSU2 : c''est son contenu qui est enrichi (ORSAN) au niveau 2, pas son existence (source : arrêté du 30 décembre 2014, annexes 1 et 2).',
 'AFGSU + Décret n° 2024-8 (SSE)', ARRAY['afgsu'], ARRAY['afgsu','sse_2024']),

-- N°38
('a0000000-0000-0000-0000-000000000108', 38,
 'Quel est le principe d''action général face à un traumatisme des os ou des articulations ?',
 '["Mobiliser rapidement la victime pour vérifier l''étendue des lésions","Ne pas mobiliser la victime ni la partie du corps atteinte","Faire marcher la victime pour tester la douleur","Masser la zone douloureuse"]',
 1, 'Toute mobilisation risque d''aggraver la lésion ; le secouriste protège, alerte et surveille.',
 'RTN GQS + PSC (DGSCGC, éd. 2026)', ARRAY['grand_public','psc'], ARRAY['gqs','psc']),

-- N°39
('a0000000-0000-0000-0000-000000000110', 39,
 'Face à une brûlure d''origine électrique, quel est le geste prioritaire ?',
 '["Toucher immédiatement la victime pour la dégager","Supprimer le risque électrique avant tout contact, puis arroser à l''eau tempérée","Arroser abondamment sans se soucier du courant","Attendre l''arrivée des secours sans intervenir"]',
 1, 'La protection du sauveteur prime : couper le courant ou écarter la source avant tout contact.',
 'RTN GQS + PSC (DGSCGC, éd. 2026)', ARRAY['grand_public','psc'], ARRAY['gqs','psc']),

-- N°40
('a0000000-0000-0000-0000-000000000108', 40,
 'Que faire face à une victime consciente se plaignant de douleur au cou après un traumatisme ?',
 '["Faire bouger doucement la tête pour évaluer la douleur","Demander de ne pas bouger la tête, stabiliser à deux mains, alerter","Asseoir la victime et la faire marcher","Installer un coussin sous la tête sans autre précaution"]',
 1, 'Cette conduite vise à limiter le risque d''aggravation d''une éventuelle lésion du rachis cervical.',
 'RTN PSC (DGSCGC, éd. 2026)', ARRAY['psc'], ARRAY['psc']),

-- N°41
('a0000000-0000-0000-0000-000000000107', 41,
 'Quels critères définissent une plaie grave, par opposition à une plaie simple ?',
 '["Uniquement une plaie qui saigne abondamment","Hémorragie associée, mécanisme pénétrant, localisation thorax/abdomen/œil/orifice, aspect déchiqueté","Toute plaie de plus de 2 cm","Une plaie qui touche uniquement la peau"]',
 1, 'Ces critères déterminent une conduite à tenir spécifique (position d''attente, alerte prioritaire) différente de la plaie simple.',
 'RTN PSC (DGSCGC, éd. 2026)', ARRAY['psc'], ARRAY['psc']),

-- N°42
('a0000000-0000-0000-0000-000000000105', 42,
 'Avant de mettre en PLS, comment apprécier la respiration d''une victime inconsciente ?',
 '["Prendre le pouls pendant 30 secondes","Regarder, écouter, sentir le flux d''air pendant 10 secondes maximum","Demander à la victime de respirer profondément","Observer la couleur des lèvres uniquement"]',
 1, 'Cette appréciation détermine la suite de la conduite à tenir (PLS si respiration présente, RCP sinon).',
 'RTN GQS + PSC (DGSCGC, éd. 2026)', ARRAY['grand_public','psc'], ARRAY['gqs','psc']),

-- N°43
('a0000000-0000-0000-0000-000000000110', 43,
 'Quels critères distinguent une brûlure grave d''une brûlure simple ?',
 '["Uniquement la douleur ressentie par la victime","Cloques sur une surface > moitié de la paume, destruction profonde, localisation à risque, origine chimique/électrique/radiologique","La couleur rouge de la peau, quelle que soit la surface","La durée d''exposition à la chaleur uniquement"]',
 1, 'La paume de la victime sert d''unité de mesure simple pour estimer la surface brûlée.',
 'RTN PSC (DGSCGC, éd. 2026)', ARRAY['psc'], ARRAY['psc']),

-- N°44
('a0000000-0000-0000-0000-000000000113', 44,
 'Que couvre le module 1 de l''AFGSU consacré aux "urgences vitales" ?',
 '["Malaise, brûlures, hygiène","Protection, alerte, inconscient, arrêt cardio-respiratoire, obstruction des voies aériennes, hémorragies","ORSAN, ORSEC, damage control","Chariot d''urgence et oxygénothérapie uniquement"]',
 1, 'Ce module est commun aux AFGSU 1 et 2.',
 'AFGSU (Arrêté 30/12/2014 modifié 01/07/2019)', ARRAY['afgsu'], ARRAY['afgsu']),

-- N°45
('a0000000-0000-0000-0000-000000000110', 45,
 'Face à une brûlure grave, à quel moment faut-il donner l''alerte ?',
 '["Après la fin complète du refroidissement","Dès le début de l''arrosage","Uniquement si la victime perd connaissance","Il n''est pas nécessaire d''alerter pour une brûlure"]',
 1, 'Alerter tôt permet de ne pas retarder l''arrivée des secours pendant les 10 à 20 minutes de refroidissement.',
 'RTN PSC (DGSCGC, éd. 2026)', ARRAY['psc'], ARRAY['psc']),

-- N°46
('a0000000-0000-0000-0000-000000000105', 46,
 'Dans quelle situation la PLS doit-elle être utilisée ?',
 '["Victime consciente qui se plaint de douleurs","Victime qui ne répond pas mais respire, suite à un événement non traumatique","Victime en arrêt cardiaque","Victime traumatisée, quelle que soit sa respiration"]',
 1, 'Si l''origine est traumatique ou inconnue, la victime inconsciente qui respire est laissée sur le dos plutôt que mise en PLS.',
 'RTN GQS + PSC (DGSCGC, éd. 2026)', ARRAY['grand_public','psc'], ARRAY['gqs','psc']),

-- N°47
('a0000000-0000-0000-0000-000000000109', 47,
 'Quels sont les signes évocateurs d''un AVC à reconnaître ?',
 '["Toux sèche et essoufflement","Faiblesse d''un bras, déformation du visage, trouble du langage, trouble de la vision, céphalée sévère inhabituelle","Douleur abdominale et vomissements","Fièvre et frissons"]',
 1, 'La reconnaissance rapide de ces signes conditionne la rapidité de la prise en charge médicale (fenêtre thérapeutique de l''AVC).',
 'RTN GQS + PSC (DGSCGC, éd. 2026)', ARRAY['grand_public','psc'], ARRAY['gqs','psc']),

-- N°48
('a0000000-0000-0000-0000-000000000107', 48,
 'Quelle position d''attente adopter face à une plaie de l''abdomen ?',
 '["Allongée, jambes tendues","Allongée, jambes fléchies","Assise, jambes pendantes","Debout, penché en avant"]',
 1, 'Cette position détend la paroi abdominale et limite la douleur.',
 'RTN PSC (DGSCGC, éd. 2026)', ARRAY['psc'], ARRAY['psc']),

-- N°49
('a0000000-0000-0000-0000-000000000113', 49,
 'Quelle est la différence entre "urgence vitale" et "urgence potentielle" au sens de l''AFGSU ?',
 '["Il n''existe aucune différence entre les deux notions","Une urgence vitale engage immédiatement le pronostic vital ; une urgence potentielle peut évoluer vers une urgence vitale sans prise en charge","Une urgence potentielle est toujours plus grave qu''une urgence vitale","Ces deux termes ne concernent que les enfants"]',
 1, 'Cette distinction structure directement l''organisation des modules 1 et 2 de l''AFGSU.',
 'AFGSU (Arrêté 30/12/2014 modifié 01/07/2019)', ARRAY['afgsu'], ARRAY['afgsu']),

-- N°50
('a0000000-0000-0000-0000-000000000107', 50,
 'Face à une plaie grave avec corps étranger, quel geste est formellement interdit ?',
 '["Le retirer immédiatement pour nettoyer la plaie","Ne jamais le retirer, le laisser en place et stabiliser","Le retirer uniquement s''il est petit","Le retirer après désinfection"]',
 1, 'Le retrait pourrait aggraver l''hémorragie ou les lésions internes ; le corps étranger doit être laissé en place et stabilisé.',
 'RTN GQS + PSC (DGSCGC, éd. 2026)', ARRAY['grand_public','psc'], ARRAY['gqs','psc']),

-- N°51
('a0000000-0000-0000-0000-000000000105', 51,
 'Chez le nourrisson inconscient qui respire, quelle est la particularité de la position de sécurité ?',
 '["Comme l''adulte, à l''identique","Sur le côté, dos contre le sauveteur","Toujours sur le dos, jamais sur le côté","En position assise, tête penchée en avant"]',
 1, 'Cette adaptation tient compte de la morphologie du nourrisson.',
 'RTN GQS + PSC (DGSCGC, éd. 2026)', ARRAY['grand_public','psc'], ARRAY['gqs','psc']),

-- N°52
('a0000000-0000-0000-0000-000000000107', 52,
 'Quelle est la conduite à tenir face à une plaie simple ?',
 '["Appliquer directement un pansement sans nettoyage","Lavage des mains, rinçage à l''eau courante, antiseptique, pansement adhésif, conseil de consultation médicale","Ne rien faire, la plaie guérit seule","Appliquer un garrot systématiquement"]',
 1, 'La consultation médicale reste conseillée même pour une plaie simple, notamment pour vérifier la couverture antitétanique.',
 'RTN GQS + PSC (DGSCGC, éd. 2026)', ARRAY['grand_public','psc'], ARRAY['gqs','psc']),

-- N°53
('a0000000-0000-0000-0000-000000000109', 53,
 'Quelle conduite à tenir spécifique face à un malaise vagal ?',
 '["Position debout, bras levés","Position accroupie, jambes croisées, crochetage des doigts","Position allongée, jambes surélevées à 90°","Position assise, tête penchée en arrière"]',
 1, 'Cette manœuvre vise à limiter la chute tensionnelle liée au malaise vagal.',
 'RTN PSC (DGSCGC, éd. 2026)', ARRAY['psc'], ARRAY['psc']),

-- N°54
('a0000000-0000-0000-0000-000000000110', 54,
 'Combien de temps faut-il refroidir une brûlure à l''eau courante ?',
 '["2 à 3 minutes suffisent","Au moins 10 minutes, idéalement 20 minutes","Au moins 1 heure","Le refroidissement est déconseillé"]',
 1, 'Le refroidissement précoce et prolongé limite l''extension en profondeur de la brûlure.',
 'RTN GQS + PSC (DGSCGC, éd. 2026)', ARRAY['grand_public','psc'], ARRAY['gqs','psc']),

-- N°55
('a0000000-0000-0000-0000-000000000101', 55,
 'Quelles informations minimales transmettre lors du message d''alerte ?',
 '["Uniquement le nom de la victime","Numéro d''appel utilisé, nature du problème, nombre de victimes, localisation précise","Uniquement l''adresse, sans autre détail","Le numéro de sécurité sociale de la victime"]',
 1, 'Le sauveteur reste ensuite en ligne pour répondre aux questions et appliquer les consignes de l''opérateur.',
 'RTN GQS + PSC (DGSCGC, éd. 2026)', ARRAY['grand_public','psc'], ARRAY['gqs','psc']),

-- N°56
('a0000000-0000-0000-0000-000000000111', 56,
 'Quelle triade le "damage control" cherche-t-il à éviter chez un traumatisé grave ?',
 '["Fièvre, douleur, inflammation","Hypothermie, acidose, troubles de la coagulation","Tachycardie, hypertension, polypnée","Choc, sepsis, défaillance rénale"]',
 1, 'Ces trois éléments s''auto-entretiennent et deviennent très difficiles à inverser une fois enclenchés.',
 'Doctrine médicale — Damage control', ARRAY['afgsu'], ARRAY['damage_control']),

-- N°57
('a0000000-0000-0000-0000-000000000111', 57,
 'Quel est l''enjeu prioritaire mis en avant par le concept moderne de "damage control resuscitation" ?',
 '["La prévention précoce de la coagulopathie","La réduction du temps de transport uniquement","L''augmentation systématique de la pression artérielle","La sédation profonde immédiate"]',
 0, 'Le concept, initialement chirurgical (damage control surgery), s''est élargi à une prise en charge globale dès le préhospitalier.',
 'Doctrine médicale — Damage control', ARRAY['afgsu'], ARRAY['damage_control']),

-- N°58
('a0000000-0000-0000-0000-000000000109', 58,
 'Quels signes lors d''un malaise imposent une alerte immédiate ?',
 '["Fatigue légère et bâillements","Douleur dans la poitrine ou signes évocateurs d''un AVC","Faim ou soif intense","Éternuements répétés"]',
 1, 'Ces signes doivent déclencher une alerte sans délai, avant même d''approfondir l''interrogatoire.',
 'RTN GQS + PSC (DGSCGC, éd. 2026)', ARRAY['grand_public','psc'], ARRAY['gqs','psc']),

-- N°59
('a0000000-0000-0000-0000-000000000109', 59,
 'Quelle position d''attente adopter face à une victime consciente en difficulté respiratoire ?',
 '["Allongée sur le dos","Assise","Allongée jambes surélevées","Position latérale de sécurité"]',
 1, 'Cette position facilite le travail respiratoire par rapport à la position allongée.',
 'RTN GQS + PSC (DGSCGC, éd. 2026)', ARRAY['grand_public','psc'], ARRAY['gqs','psc']),

-- N°60
('a0000000-0000-0000-0000-000000000111', 60,
 'Comment le dispositif ORSAN s''articule-t-il avec le dispositif ORSEC ?',
 '["Ce sont deux noms différents pour le même dispositif","ORSAN (Santé/ARS) et ORSEC (Intérieur/sécurité civile) sont complémentaires et coordonnés","ORSEC a remplacé ORSAN en 2024","ORSAN ne concerne que les hôpitaux militaires"]',
 1, 'Cette articulation illustre la coordination interministérielle en situation sanitaire exceptionnelle.',
 'Décret n° 2024-8 du 3 janvier 2024 (SSE)', ARRAY['afgsu'], ARRAY['sse_2024']);
