-- ============================================================
-- Corrige un doublon : la fiche "Piqûres et envenimations" a été
-- insérée 4 fois (soins-urgence-piqures-pse.sql exécuté plusieurs fois).
-- Garde une seule occurrence, supprime les 3 autres.
-- (uuid n'a pas de min()/max() en Postgres, on compare via ctid à la place.)
-- ============================================================

delete from memo_cards a
using memo_cards b
where a.title = 'Piqûres et envenimations'
  and b.title = 'Piqûres et envenimations'
  and a.ctid > b.ctid;
