# CLAUDE.md — App révision Soins d'Urgence

## Stack
Vite + React + TypeScript + TailwindCSS v3 + React Router + Zod + Supabase + Netlify.
Même stack que Ovalia et la brasserie.

## Contexte projet
Webapp gratuite, grand public, sans compte utilisateur (v1). Révision des gestes de premiers secours.
v1 = référentiel GQS (Gestes Qui Sauvent, arrêté du 30 juin 2017, DGSCGC) uniquement.
Référentiels futurs (AFGSU, PSE1/PSE2) : payants, ajoutés plus tard sans casser le v1.

## Règles de contenu (strict, non négociable)
- Aucun contenu ne doit être copié tel quel depuis un référentiel officiel (PDF, site). Toujours reformuler.
- Chaque memo_card et chaque question doit afficher sa source (source_name + source_ref si disponible).
- Ne jamais présenter l'app comme certifiante. C'est un outil de révision, pas une formation officielle GQS/PSC1/AFGSU/PSE.
- Les noms de gestes et vocabulaire technique doivent rester fidèles au référentiel source (ex: "position latérale de sécurité", pas d'invention).

## Langue
UI et contenu utilisateur : français.
Code (variables, fonctions, composants) : anglais.

## Modèle de données
Voir soins-urgence-schema.sql. Points clés :
- Pas de table utilisateur en v1. Progression et badges = local storage côté client uniquement.
- `quizzes.mode` = 'theme' (questions d'un seul thème) ou 'mixed' (questions piochées dans plusieurs thèmes du référentiel).
- Le tirage de questions est une requête à la volée (N questions aléatoires filtrées), pas un jeu de questions figé en base.
- `referentiels.is_free` distingue le contenu gratuit (GQS) du contenu payant à venir.

## Gamification (v1)
- Badges définis en base (table `badges`), état débloqué stocké en local storage navigateur.
- Pas de compte = pas de portabilité de la progression entre appareils. Comportement attendu, pas un bug.
- Ne pas construire de logique serveur pour la progression en v1.

## Git
Commits faits manuellement par Louis en PowerShell. Ne jamais ajouter de métadonnée Co-Authored-By.

## Déploiement
Netlify, auto-deploy depuis GitHub, même pattern que la brasserie.

## Ce qui n'est PAS dans le v1 (ne pas anticiper dans le code)
- Comptes utilisateur, authentification
- Paiement / paywall
- Contenu AFGSU / PSE1 / PSE2
- Progression serveur, historique cross-device
- Chatbot ou toute fonctionnalité IA
