# Prompt maître — App révision Soins d'Urgence (build autonome)

Lis d'abord CLAUDE.md à la racine (conventions du projet) avant de commencer.

## Objectif
Construire en autonomie complète la v1 de l'application, du scaffold jusqu'au déploiement, sans t'arrêter pour demander validation entre les étapes — SAUF si un test échoue et que tu ne peux pas le corriger toi-même après 2 tentatives, auquel cas tu t'arrêtes et expliques clairement le blocage.

Avance par phases. Après chaque phase, exécute le test de vérification indiqué. Ne passe à la phase suivante que si le test passe. Si un test échoue, corrige et reteste avant de continuer.

## Fichiers fournis (à utiliser tels quels, ne pas réinventer le contenu)
- `soins-urgence-schema.sql` : schéma complet Supabase (tables, RLS)
- `soins-urgence-seed-gqs.sql` : contenu réel du référentiel GQS déjà reformulé et sourcé (2 thèmes, 14 fiches mémo, 20 questions, 3 quiz, 4 badges)

---

## Phase 1 — Scaffold
- Initialiser Vite + React + TypeScript + TailwindCSS v3 + React Router.
- Mettre en place la structure de dossiers standard (components, pages, lib, types).
- Configurer Supabase client (variables d'env dans `.env.local`, ne jamais commiter de clé).

**Test de vérification** : `npm run build` doit passer sans erreur.

## Phase 2 — Base de données
- Exécuter `soins-urgence-schema.sql` puis `soins-urgence-seed-gqs.sql` sur le projet Supabase.

**Test de vérification** : une requête de lecture simple (via script ou Supabase CLI) doit retourner 2 thèmes, 14 memo_cards, 20 questions, 3 quizzes, 4 badges. Si un nombre ne correspond pas, arrête-toi et signale l'écart avant de continuer.

## Phase 3 — Écrans de contenu
Construire dans l'ordre :
1. **Home** : liste des thèmes du référentiel GQS (cards : titre + description courte)
2. **Écran thème** : affiche toutes les memo_cards du thème, chacune avec ses étapes (liste numérotée) et sa source visible (source_name, cliquable si source_url existe)
3. **Lancement de quiz** depuis l'écran thème : bouton pour lancer le quiz du thème (mode 'theme')
4. **Écran d'accueil quiz** (accessible aussi depuis Home) : permet de choisir entre un quiz par thème ou le quiz mélangé (mode 'mixed'), avec un nombre de questions sélectionnable (5 ou 10, tiré aléatoirement parmi les questions du thème ou du référentiel)
5. **Déroulé du quiz** : une question à la fois, choix multiples, feedback immédiat ou différé (à ta discrétion, reste cohérent)
6. **Résultat de quiz** : score final + reprise de chaque question avec l'explication et la source affichées

**Test de vérification** : navigation manuelle simulée (ou test e2e léger si tu en as le temps) — depuis Home, on doit pouvoir atteindre chaque écran en 2 clics maximum, et un quiz complet (lancement → réponses → résultat) doit fonctionner sans erreur console.

## Phase 4 — Gamification (locale, sans compte)
- Écran "Mes badges" accessible depuis Home : badges débloqués en couleur, badges verrouillés grisés avec leur critère visible.
- Stockage en `localStorage` uniquement : historique des quiz (score, date), badges débloqués. Pas d'authentification, pas de table Supabase pour cet état.
- Logique de déblocage : vérifier après chaque quiz terminé si un badge doit être débloqué (quiz_completed, score_perfect, streak selon les critères en base).

**Test de vérification** : compléter un quiz avec un score parfait doit débloquer le badge "Sans faute" visible immédiatement sur l'écran badges. Vider le localStorage doit réinitialiser la progression (comportement attendu, à documenter dans un commentaire de code, pas un bug).

## Phase 5 — Style
- Mobile-first, contraste élevé, lisible rapidement (contenu utilisé aussi en situation de stress).
- Ton rassurant mais sérieux, pas d'esthétique clinique froide.
- Larges zones de tap, peu de texte par écran.

**Test de vérification** : vérifier au moins un écran sur mobile (375px de large) sans débordement ni texte tronqué.

## Phase 6 — Déploiement
- Connecter le repo GitHub à Netlify, auto-deploy configuré sur push.
- Vérifier que les variables d'environnement Supabase sont bien configurées côté Netlify (pas commitées dans le repo).

**Test de vérification** : l'URL Netlify doit afficher la Home avec les 2 thèmes visibles.

---

## Hors périmètre (ne pas construire, même si ça semble logique de l'ajouter)
- Comptes utilisateur, authentification, paiement
- Contenu AFGSU / PSE1 / PSE2
- Progression serveur / cross-device
- Chatbot ou fonctionnalité IA

## À la fin
Résume en quelques lignes : ce qui a été fait, l'URL Netlify, et tout écart par rapport à ce prompt (nombre de questions différent, test qui a nécessité plus de 2 tentatives, etc.). Louis validera à l'écran, pas dans le code.
