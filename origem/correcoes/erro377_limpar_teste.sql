-- Erro377: remove as cartas de correcao e as ocorrencias de teste
SET NOCOUNT ON;
DELETE FROM SigNfCor WHERE cidchaves LIKE 'T377%';
DELETE FROM SigCcOco WHERE ncodigos IN (91, 92, 93);
