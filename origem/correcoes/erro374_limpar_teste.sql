-- Erro374: remove os titulos de teste, obs e recorrencia
SET NOCOUNT ON;
DELETE FROM SigMvCcr WHERE cidchaves LIKE 'T374%';
DELETE FROM SigTtCcd WHERE cidchaves LIKE 'T374%';
DELETE FROM SigTtRec WHERE cidchaves LIKE 'T374%';
