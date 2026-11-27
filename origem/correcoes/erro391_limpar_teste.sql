-- Erro391: remove as contas e movimentos de teste do Bloqueio de Contas
-- (FormSIGBLCTA). Ordem: parcelas -> cabecalhos -> contas.
SET NOCOUNT ON;
DELETE FROM SigMvPar WHERE cidchaves LIKE 'ZZTST%';
DELETE FROM SigMvCab WHERE cidchaves LIKE 'ZZTST%';
DELETE FROM SigCdCli WHERE IClis LIKE 'ZZT%';

SELECT (SELECT COUNT(*) FROM SigCdCli WHERE IClis     LIKE 'ZZT%')   AS contas_restantes,
       (SELECT COUNT(*) FROM SigMvCab WHERE cidchaves LIKE 'ZZTST%') AS cabecalhos_restantes,
       (SELECT COUNT(*) FROM SigMvPar WHERE cidchaves LIKE 'ZZTST%') AS parcelas_restantes;
