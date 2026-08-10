# CLAUDE.md — QuizSecours (app révision Soins d'Urgence)

## Nom de l'app
**QuizSecours**. Anciennement nommée d'après le référentiel GQS — renommée car "Gestes Qui Sauvent"
est une marque déposée. Ne jamais utiliser "Gestes Qui Sauvent" / "Gestes qui sauvent" comme nom de
l'application (titre, header, footer, meta). Les mentions factuelles des référentiels eux-mêmes
(GQS, PSC, PSE, AFGSU comme noms de formations officielles) restent normales et nécessaires —
c'est uniquement le nom de l'app qui a changé.

## Stack
Vite + React + TypeScript + TailwindCSS v3 + React Router + Zod + Supabase + Netlify.
Même stack que Ovalia et la brasserie.

## Contexte projet
Webapp gratuite, grand public + apprenants secourisme, sans compte utilisateur.
Depuis la v2, l'app couvre plusieurs référentiels (RTN 2026 GQS/PSC/PSE, AFGSU, Décret SSE 2024, Doctrine damage control).
L'utilisateur choisit son référentiel via l'écran d'accueil en roue ("/"), qui l'envoie vers "/reviser"
où l'app filtre thèmes, fiches et quiz en conséquence.

Priorité éditoriale : le grand public doit pouvoir trouver rapidement des réponses claires et fiables.

## Règles de contenu (strict, non négociable)
- Aucun contenu ne doit être copié tel quel depuis un référentiel officiel (PDF, site). Toujours reformuler.
- Chaque memo_card et chaque question doit afficher sa source (source_name + source_ref si disponible).
- Ne jamais présenter l'app comme certifiante. C'est un outil de révision, pas une formation officielle GQS/PSC/PSE/AFGSU.
- Les noms de gestes et vocabulaire technique doivent rester fidèles au référentiel source (ex : "position latérale de sécurité", "compressions abdominales", "adrénaline auto-injecteur" — pas d'invention).
- Style d'écriture : mélange technique + vulgarisé. On garde les termes officiels (PLS, DAE, RCP, adrénaline…) parce qu'ils circulent aussi côté formés et grand public, avec des reformulations simples.

## Langue
UI et contenu utilisateur : français.
Code (variables, fonctions, composants) : anglais.

## Modèle de données
Voir `soins-urgence-schema-v2.sql` et le seed correspondant. Points clés :
- Pas de table utilisateur. Progression, badges et niveau choisi = local storage côté client uniquement.
- `questions` a des colonnes `question_number` (N° d'origine Notion), `levels` TEXT[] (public visé), `referentiel_codes` TEXT[] (sources documentaires).
- `memo_cards` a une colonne `levels` TEXT[] pour filtrer par niveau utilisateur.
- `themes` a un `code` slug stable pour référencement.
- `referentiels` : 6 entrées (gqs, psc, pse, afgsu, sse_2024, damage_control).
- `quizzes.mode` = 'theme' (questions d'un seul thème) ou 'mixed' (questions piochées dans plusieurs thèmes) ; la table n'est plus l'autorité — les quiz sont dérivés côté app à partir des thèmes disponibles pour le niveau actif.
- Le tirage de questions est une requête à la volée (N questions aléatoires filtrées par niveau, éventuellement par thème).
- La base de contenu est maintenue dans Notion ("Quiz Secourisme", page "Appli GQS"). Elle est régulièrement re-générée en SQL vers Supabase (le seed n'est PAS édité à la main pour les questions).

## Gamification (v1 conservée)
- Badges définis en base (`badges`), état débloqué stocké en local storage navigateur.
- Historique quiz (score, max streak, date) en local storage.
- Logique de déblocage : `computeUnlockedBadgeIds` dans `src/lib/gamification.ts`.
- Pas de compte = pas de portabilité de la progression entre appareils. Comportement attendu.

## Niveaux (v2)
- 4 niveaux : `grand_public` / `psc` / `pse` / `afgsu`.
- Toggle en haut de la Home + badge visible dans le header (Layout).
- Persistance : `src/lib/level.ts` (localStorage `gqs.level.v1`).
- Consommation dans les composants : `useLevel()` hook (`src/lib/useLevel.ts`).
- Filtrage côté requêtes : `contains('levels', [level])` sur Postgres arrays GIN-indexés.
- Une fiche/question peut être multi-niveaux (ex: `['grand_public','psc']`).

## Recherche (v2)
- Barre sur la Home. Interroge fiches (titre + étapes) et questions (texte + choix + justification) filtrées par le niveau actif.
- Recherche client-side (`searchAll` dans `src/lib/api.ts`) — dataset petit, pas de full-text côté Postgres nécessaire.

## Git
Commits faits manuellement par Louis en PowerShell. Ne jamais ajouter de métadonnée Co-Authored-By.

## Déploiement
Netlify, auto-deploy depuis GitHub. `netlify.toml` en racine (SPA redirects + build config).
Variables d'env sur Netlify : `VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY`.

## Ce qui n'est PAS dans le périmètre (ne pas anticiper dans le code)
- Comptes utilisateur, authentification, paiement, paywall
- Progression serveur / historique cross-device
- Chatbot ou toute fonctionnalité IA
- Édition en ligne des questions/fiches (le contenu est maintenu dans Notion, re-généré en SQL)
