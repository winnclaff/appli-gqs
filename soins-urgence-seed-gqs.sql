-- ============================================================
-- Seed de contenu — Référentiel GQS (v1)
-- Contenu reformulé à partir des recommandations officielles DGSCGC
-- (arrêté du 30 juin 2017, éd. décembre 2023). Aucun texte copié tel quel.
-- Source affichée systématiquement sur chaque fiche et question.
-- ============================================================

-- ---------- Référentiel ----------
insert into referentiels (id, code, name, official_source_name, official_source_url, is_free, sort_order)
values (
  'a0000000-0000-0000-0000-000000000001',
  'gqs',
  'Gestes Qui Sauvent',
  'DGSCGC - Ministère de l''Intérieur',
  'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels',
  true,
  1
);

-- ---------- Thèmes ----------
insert into themes (id, referentiel_id, title, icon, short_description, sort_order) values
('a0000000-0000-0000-0000-000000000101', 'a0000000-0000-0000-0000-000000000001', 'Informations générales', 'info', 'Protection et alerte : les deux premiers réflexes avant tout geste de secours.', 1),
('a0000000-0000-0000-0000-000000000102', 'a0000000-0000-0000-0000-000000000001', 'Secourir une personne', 'heart-pulse', 'Hémorragies, perte de connaissance, plaies et arrêt cardiaque.', 2);

-- ============================================================
-- MEMO CARDS
-- ============================================================

insert into memo_cards (theme_id, title, action_steps, source_ref, source_name, source_url, sort_order) values

('a0000000-0000-0000-0000-000000000101', 'Protection',
'["Écarter ou supprimer immédiatement le danger si vous pouvez le faire sans risque pour vous-même.",
  "Si le danger ne peut pas être supprimé, délimiter largement et clairement la zone dangereuse pour empêcher toute intrusion.",
  "Si la victime ne peut pas s''éloigner seule d''un danger réel et immédiat, un dégagement d''urgence peut être envisagé — reste une manœuvre exceptionnelle et risquée.",
  "Face à une attaque ou une situation de violence : s''échapper si possible, sinon se cacher et se barricader, puis alerter dès que possible."]',
'[01AC01 / 12-2023] GQS Protection', 'GQS - DGSCGC, éd. décembre 2023',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels', 1),

('a0000000-0000-0000-0000-000000000101', 'Alerte',
'["Évaluer rapidement la situation et les risques avant d''appeler.",
  "Composer le 15 (SAMU), le 18 (pompiers) ou le 112 (numéro d''urgence européen) ; le 114 est réservé aux personnes malentendantes ou ne pouvant pas parler.",
  "Donner le numéro d''où vous appelez, la nature du problème, le nombre de victimes et la localisation la plus précise possible.",
  "Rester en ligne, répondre aux questions et suivre les consignes jusqu''à l''indication de raccrocher."]',
'[01AC02 / 12-2022] GQS Alerte', 'GQS - DGSCGC, éd. décembre 2023',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels', 2),

('a0000000-0000-0000-0000-000000000102', 'Hémorragies externes',
'["Comprimer immédiatement l''endroit qui saigne avec la main, si possible avec un tissu propre entre la main et la plaie.",
  "Allonger la victime pour retarder l''apparition d''une détresse liée à la perte de sang.",
  "Maintenir la compression sans interruption et alerter les secours.",
  "Si la compression ne suffit pas à arrêter un saignement sur un membre, envisager un garrot au-dessus de la plaie."]',
'[02PR01 / 12-2022] GQS Hémorragies externes', 'GQS - DGSCGC, éd. décembre 2023',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels', 1),

('a0000000-0000-0000-0000-000000000102', 'Compression directe',
'["Appuyer fermement sur la plaie avec la main, en interposant un tissu propre si possible.",
  "Maintenir la compression de façon continue jusqu''à l''arrivée des secours.",
  "Un pansement compressif peut remplacer la main uniquement s''il a permis d''arrêter le saignement au préalable."]',
'[02FT01 / 12-2023] GQS Compression directe', 'GQS - DGSCGC, éd. décembre 2023',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels', 2),

('a0000000-0000-0000-0000-000000000102', 'Garrot',
'["Utiliser le garrot uniquement si la compression directe est inefficace ou impossible sur une hémorragie de membre.",
  "Le placer entre le cœur et la plaie, jamais sur une articulation.",
  "Serrer jusqu''à l''arrêt complet du saignement et ne jamais le desserrer sans avis médical."]',
'[02FT02 / 12-2023] GQS Garrot', 'GQS - DGSCGC, éd. décembre 2023',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels', 3),

('a0000000-0000-0000-0000-000000000102', 'Perte de connaissance',
'["Vérifier l''absence de réponse en parlant à la victime et en la stimulant légèrement.",
  "Si elle ne répond pas, l''allonger sur le dos, libérer ses voies aériennes et contrôler sa respiration pendant 10 secondes maximum.",
  "Si elle respire et que l''événement n''est pas traumatique, la placer en position latérale de sécurité.",
  "Alerter les secours et surveiller la respiration en continu jusqu''à leur arrivée."]',
'[02PR02 / 12-2023] GQS Perte de connaissance', 'GQS - DGSCGC, éd. décembre 2023',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels', 4),

('a0000000-0000-0000-0000-000000000102', 'Libération des voies aériennes',
'["Placer une main sur le front de la victime et deux ou trois doigts de l''autre main sous la pointe du menton.",
  "Basculer doucement la tête en arrière tout en élevant le menton (chez l''adulte et l''enfant).",
  "Chez le nourrisson, amener la tête en position neutre plutôt qu''en bascule complète."]',
'[02FT03 / 12-2023] GQS Libération des voies aériennes', 'GQS - DGSCGC, éd. décembre 2023',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels', 5),

('a0000000-0000-0000-0000-000000000102', 'Position latérale de sécurité',
'["Aligner les jambes de la victime et placer son bras côté sauveteur à angle droit.",
  "Placer le dos de son autre main contre son oreille, côté sauveteur, et attraper la jambe opposée derrière le genou.",
  "Faire pivoter la victime vers soi en tirant sur la jambe relevée, jusqu''à ce que le genou touche le sol.",
  "Stabiliser la position, ajuster la jambe du dessus à angle droit et ouvrir légèrement la bouche pour permettre l''écoulement des liquides."]',
'[02FT04 / 12-2023] GQS Position latérale de sécurité', 'GQS - DGSCGC, éd. décembre 2023',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels', 6),

('a0000000-0000-0000-0000-000000000102', 'Arrêt cardiaque',
'["Vérifier l''absence de réponse, puis l''absence de respiration normale (10 secondes maximum).",
  "Une respiration absente ou anormale (agonique) doit être traitée comme un arrêt cardiaque.",
  "Alerter les secours immédiatement, si possible en mode haut-parleur pour agir en même temps.",
  "Débuter la réanimation cardio-pulmonaire (compressions thoraciques, associées aux insufflations si possible) et faire chercher un défibrillateur."]',
'[02PR03 / 12-2023] GQS Arrêt cardiaque', 'GQS - DGSCGC, éd. décembre 2023',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels', 7),

('a0000000-0000-0000-0000-000000000102', 'Compressions thoraciques',
'["Placer la victime à plat dos, sur une surface dure si possible.",
  "Chez l''adulte : talon d''une main au centre de la poitrine, l''autre main par-dessus, doigts entrecroisés et relevés.",
  "Comprimer verticalement, bras tendus, à une profondeur d''environ 5 cm sans dépasser 6 cm.",
  "Maintenir une fréquence de 100 à 120 compressions par minute, en laissant le thorax reprendre sa forme entre chaque compression."]',
'[02FT05 / 12-2023] GQS Compressions thoraciques', 'GQS - DGSCGC, éd. décembre 2023',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels', 8),

('a0000000-0000-0000-0000-000000000102', 'Insufflations',
'["Basculer la tête en arrière et pincer le nez de la victime.",
  "Insuffler progressivement jusqu''à voir la poitrine se soulever, pendant environ une seconde.",
  "Réaliser deux insufflations en 5 secondes maximum avant de reprendre les compressions."]',
'[02FT06 / 12-2022] GQS Insufflations', 'GQS - DGSCGC, éd. décembre 2023',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels', 9),

('a0000000-0000-0000-0000-000000000102', 'Défibrillation',
'["Allumer le défibrillateur automatisé externe (DAE) dès qu''il est disponible et suivre ses instructions vocales.",
  "Dénuder et sécher si besoin la poitrine de la victime avant de coller les électrodes selon le schéma indiqué.",
  "Ne plus toucher la victime pendant l''analyse et le choc si l''appareil le demande.",
  "Reprendre immédiatement les compressions thoraciques après le choc, ou si aucun choc n''est nécessaire."]',
'[02FT07 / 12-2023] GQS Défibrillation', 'GQS - DGSCGC, éd. décembre 2023',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels', 10),

('a0000000-0000-0000-0000-000000000102', 'Défibrillateur automatisé externe (DAE)',
'["Le DAE analyse automatiquement l''activité électrique du cœur et détecte une anomalie éventuelle.",
  "Il guide le sauveteur par des messages vocaux et délivre ou invite à délivrer un choc si nécessaire.",
  "On le trouve dans les lieux recevant du public : gares, aéroports, centres commerciaux, certains lieux de travail."]',
'[02AC02 / 12-2022] GQS Défibrillateur automatisé externe - DAE', 'GQS - DGSCGC, éd. décembre 2023',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels', 11),

('a0000000-0000-0000-0000-000000000102', 'Plaies',
'["Évaluer la gravité : une plaie est grave en cas d''hémorragie associée, d''objet pénétrant, ou de localisation au thorax, à l''abdomen, à l''œil ou près d''un orifice naturel.",
  "Face à une plaie grave : ne jamais retirer un corps étranger, installer la victime en position d''attente adaptée et alerter les secours.",
  "Face à une plaie simple : se laver les mains, rincer abondamment la plaie à l''eau, protéger avec un pansement et conseiller une vérification de la vaccination antitétanique."]',
'[02PR04 / 12-2022] GQS Plaies', 'GQS - DGSCGC, éd. décembre 2023',
'https://www.interieur.gouv.fr/Le-ministere/Securite-civile/Documentation-technique/Secourisme-et-associations/Les-recommandations-et-les-referentiels', 12);

-- ============================================================
-- QUESTIONS
-- ============================================================

insert into questions (theme_id, question_text, choices, correct_choice_index, explanation, source_ref, source_name, source_url) values

-- Thème 1 : Informations générales
('a0000000-0000-0000-0000-000000000101',
 'Face à un danger que vous ne pouvez pas supprimer (ex : encombrement de la voie publique), que devez-vous faire en priorité ?',
 '["Retirer la victime du danger immédiatement", "Baliser et délimiter la zone pour empêcher toute intrusion", "Attendre les secours sans agir", "Prévenir uniquement les témoins présents"]',
 1,
 'Quand le danger ne peut pas être supprimé, on le contrôle en délimitant clairement la zone dangereuse plutôt qu''en intervenant directement.',
 '[01AC01 / 12-2023]', 'GQS - DGSCGC, éd. décembre 2023', null),

('a0000000-0000-0000-0000-000000000101',
 'Quel numéro composer en priorité pour un problème de santé urgent nécessitant un avis médical ?',
 '["Le 18", "Le 15", "Le 114", "Le 17"]',
 1,
 'Le 15 est le numéro du SAMU, en charge de la réponse médicale et des urgences de santé.',
 '[01AC02 / 12-2022]', 'GQS - DGSCGC, éd. décembre 2023', null),

('a0000000-0000-0000-0000-000000000101',
 'Quelle information n''est PAS indispensable à donner lors d''un appel aux secours ?',
 '["La localisation précise", "Le nombre de victimes", "La nature du problème", "Votre numéro de sécurité sociale"]',
 3,
 'Les informations essentielles sont le numéro d''appel, la nature du problème, le nombre de victimes et la localisation — pas de données administratives.',
 '[01AC02 / 12-2022]', 'GQS - DGSCGC, éd. décembre 2023', null),

-- Thème 2 : Secourir une personne
('a0000000-0000-0000-0000-000000000102',
 'Face à une hémorragie externe abondante, quel est le premier geste à réaliser ?',
 '["Alerter les secours avant tout autre geste", "Comprimer immédiatement l''endroit qui saigne", "Allonger la victime jambes surélevées", "Rechercher un garrot"]',
 1,
 'La compression immédiate de la plaie prime : l''alerte est réalisée après avoir débuté ce geste si le sauveteur est seul.',
 '[02PR01 / 12-2022]', 'GQS - DGSCGC, éd. décembre 2023', null),

('a0000000-0000-0000-0000-000000000102',
 'Un pansement compressif peut remplacer la compression manuelle...',
 '["Dès le début, sans compression manuelle préalable", "Uniquement si la compression manuelle a déjà permis d''arrêter le saignement", "Uniquement en cas de plaie au thorax", "Jamais, il faut toujours garder la main"]',
 1,
 'Le pansement compressif ne remplace la main que si le saignement est déjà arrêté ; sinon il faut reprendre la compression directe.',
 '[02FT01 / 12-2023]', 'GQS - DGSCGC, éd. décembre 2023', null),

('a0000000-0000-0000-0000-000000000102',
 'Où doit être placé un garrot par rapport à la plaie ?',
 '["En dessous de la plaie (plus loin du cœur)", "Directement sur la plaie", "Sur l''articulation la plus proche", "Entre le cœur et la plaie"]',
 3,
 'Le garrot se place entre le cœur et la plaie, jamais sur une articulation.',
 '[02FT02 / 12-2023]', 'GQS - DGSCGC, éd. décembre 2023', null),

('a0000000-0000-0000-0000-000000000102',
 'Une victime ne répond pas, ne réagit pas, mais respire normalement, suite à un malaise. Que faites-vous ?',
 '["La laisser sur le dos et surveiller", "La placer en position latérale de sécurité", "Débuter des compressions thoraciques", "Lui donner à boire"]',
 1,
 'Une victime qui respire normalement après une perte de connaissance non traumatique doit être mise en position latérale de sécurité pour maintenir ses voies aériennes libres.',
 '[02PR02 / 12-2023]', 'GQS - DGSCGC, éd. décembre 2023', null),

('a0000000-0000-0000-0000-000000000102',
 'Combien de temps maximum pour apprécier la respiration d''une victime inconsciente ?',
 '["3 secondes", "10 secondes", "30 secondes", "1 minute"]',
 1,
 'L''appréciation de la respiration se fait sur 10 secondes maximum.',
 '[02PR02 / 12-2023]', 'GQS - DGSCGC, éd. décembre 2023', null),

('a0000000-0000-0000-0000-000000000102',
 'Pour libérer les voies aériennes d''un adulte inconscient, le bon geste est :',
 '["Pencher la tête vers l''avant", "Basculer la tête en arrière en élevant le menton", "Tourner la tête sur le côté sans la bouger", "Ne rien faire avant l''arrivée des secours"]',
 1,
 'La bascule de la tête en arrière associée à l''élévation du menton dégage la langue et libère le passage de l''air.',
 '[02FT03 / 12-2023]', 'GQS - DGSCGC, éd. décembre 2023', null),

('a0000000-0000-0000-0000-000000000102',
 'La position latérale de sécurité (PLS) sert principalement à :',
 '["Réanimer une victime en arrêt cardiaque", "Permettre l''écoulement des liquides et éviter que la langue n''obstrue les voies aériennes", "Arrêter une hémorragie", "Immobiliser une fracture"]',
 1,
 'La PLS maintient les voies aériennes libres chez une victime inconsciente qui respire, en laissant les liquides s''écouler et en évitant la chute de la langue.',
 '[02FT04 / 12-2023]', 'GQS - DGSCGC, éd. décembre 2023', null),

('a0000000-0000-0000-0000-000000000102',
 'Une victime ne répond pas, ne réagit pas et ne respire pas. Vous êtes seul avec un téléphone portable. Que faites-vous ?',
 '["Vous quittez la victime pour aller chercher de l''aide avant tout geste", "Vous activez le haut-parleur, alertez et débutez immédiatement la réanimation", "Vous attendez 2 minutes pour confirmer l''arrêt cardiaque", "Vous commencez uniquement par les insufflations"]',
 1,
 'Avec un téléphone portable et le mode haut-parleur, l''alerte et les gestes de réanimation peuvent être menés en même temps, sans perdre de temps.',
 '[02PR03 / 12-2023]', 'GQS - DGSCGC, éd. décembre 2023', null),

('a0000000-0000-0000-0000-000000000102',
 'Une respiration anormale et agonique chez une victime inconsciente doit être considérée comme :',
 '["Un signe rassurant", "Un arrêt cardiaque", "Un simple ronflement à surveiller", "Un signe d''évanouissement bénin"]',
 1,
 'Une respiration agonique (lente, bruyante, inefficace) doit être traitée comme un arrêt cardiaque et déclenche la réanimation immédiate.',
 '[02PR03 / 12-2023]', 'GQS - DGSCGC, éd. décembre 2023', null),

('a0000000-0000-0000-0000-000000000102',
 'Chez l''adulte, à quelle fréquence doivent être réalisées les compressions thoraciques ?',
 '["40 à 60 par minute", "60 à 80 par minute", "100 à 120 par minute", "150 à 180 par minute"]',
 2,
 'La fréquence recommandée pour les compressions thoraciques chez l''adulte est de 100 à 120 par minute.',
 '[02FT05 / 12-2023]', 'GQS - DGSCGC, éd. décembre 2023', null),

('a0000000-0000-0000-0000-000000000102',
 'Quelle est la profondeur recommandée pour les compressions thoraciques chez l''adulte ?',
 '["Environ 2 cm", "Environ 5 cm, sans dépasser 6 cm", "Environ 10 cm", "Peu importe, seule la fréquence compte"]',
 1,
 'Les compressions doivent atteindre une profondeur d''environ 5 cm, sans dépasser 6 cm chez l''adulte.',
 '[02FT05 / 12-2023]', 'GQS - DGSCGC, éd. décembre 2023', null),

('a0000000-0000-0000-0000-000000000102',
 'Combien de temps maximum doivent durer deux insufflations successives ?',
 '["1 seconde", "5 secondes", "15 secondes", "30 secondes"]',
 1,
 'Les deux insufflations ne doivent pas excéder 5 secondes au total, pour ne pas retarder la reprise des compressions.',
 '[02FT06 / 12-2022]', 'GQS - DGSCGC, éd. décembre 2023', null),

('a0000000-0000-0000-0000-000000000102',
 'Que faire pendant que le défibrillateur (DAE) analyse le rythme cardiaque de la victime ?',
 '["Continuer les compressions thoraciques", "Ne plus toucher la victime et s''écarter", "Réaliser les insufflations", "Retirer les électrodes"]',
 1,
 'Pendant la phase d''analyse, il ne faut plus toucher la victime : tout mouvement peut fausser l''analyse du DAE.',
 '[02FT07 / 12-2023]', 'GQS - DGSCGC, éd. décembre 2023', null),

('a0000000-0000-0000-0000-000000000102',
 'Le défibrillateur automatisé externe (DAE) est un appareil...',
 '["Réservé aux professionnels de santé", "Utilisable en sécurité même par une personne peu ou pas formée", "Qui remplace totalement les compressions thoraciques", "Dangereux pour le sauveteur en cas de mauvaise utilisation"]',
 1,
 'Le DAE est conçu pour être utilisé en toute sécurité par des sauveteurs peu ou pas formés : il guide chaque étape par la voix.',
 '[02AC02 / 12-2022]', 'GQS - DGSCGC, éd. décembre 2023', null),

('a0000000-0000-0000-0000-000000000102',
 'Face à une plaie grave avec un corps étranger planté (ex : morceau de verre), vous devez :',
 '["Retirer immédiatement le corps étranger", "Ne jamais retirer le corps étranger", "Le retirer seulement s''il est petit", "Le pousser plus profondément pour le stabiliser"]',
 1,
 'Un corps étranger dans une plaie ne doit jamais être retiré : cela risquerait d''aggraver la blessure, notamment l''hémorragie.',
 '[02PR04 / 12-2022]', 'GQS - DGSCGC, éd. décembre 2023', null),

('a0000000-0000-0000-0000-000000000102',
 'Face à une plaie simple (petite coupure superficielle), la conduite à tenir est :',
 '["Se laver les mains, rincer à l''eau, protéger par un pansement", "Appliquer un garrot par précaution", "Appeler systématiquement les secours", "Ne rien faire, ça va cicatriser seul"]',
 0,
 'Une plaie simple se nettoie à l''eau courante après lavage des mains, puis se protège par un pansement adhésif.',
 '[02PR04 / 12-2022]', 'GQS - DGSCGC, éd. décembre 2023', null);

-- ============================================================
-- QUIZ (regroupements) — le tirage réel des questions se fait à la volée côté app
-- ============================================================
insert into quizzes (theme_id, referentiel_id, title, mode, default_question_count) values
('a0000000-0000-0000-0000-000000000101', 'a0000000-0000-0000-0000-000000000001', 'Quiz — Informations générales', 'theme', 5),
('a0000000-0000-0000-0000-000000000102', 'a0000000-0000-0000-0000-000000000001', 'Quiz — Secourir une personne', 'theme', 5),
(null, 'a0000000-0000-0000-0000-000000000001', 'Quiz mélangé — GQS', 'mixed', 5);

-- ============================================================
-- BADGES (définitions ; état débloqué géré en local storage côté client)
-- ============================================================
insert into badges (title, description, icon, criteria_type, criteria_value) values
('Premier pas', 'Terminer votre premier quiz.', 'footprints', 'quiz_completed', 1),
('Habitué', 'Terminer 5 quiz.', 'repeat', 'quiz_completed', 5),
('Sans faute', 'Obtenir un score parfait à un quiz.', 'star', 'score_perfect', 1),
('En série', 'Enchaîner 3 bonnes réponses d''affilée.', 'flame', 'streak', 3);
