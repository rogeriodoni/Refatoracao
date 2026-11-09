-- Erro338: remove o demonstrativo de teste 'TESTE DRE' e suas linhas
SET NOCOUNT ON;
DELETE FROM SigCdMri WHERE cidchaves LIKE 'T338%';
DELETE FROM SigCdMrr WHERE balancos = 'TESTE DRE';
