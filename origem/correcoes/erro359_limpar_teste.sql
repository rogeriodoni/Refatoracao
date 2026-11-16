-- Erro359: remove os titulos de teste do Fluxo Financeiro Sintetico
SET NOCOUNT ON;
DELETE FROM SigMvCcr WHERE cidchaves LIKE 'T359CCR%';
SELECT COUNT(*) AS restantes FROM SigMvCcr WHERE cidchaves LIKE 'T359CCR%';

