-- Erro382: remove os historicos e os tipos de ocorrencia de teste do inventario 3
SET NOCOUNT ON;
DELETE FROM SigIvTrH WHERE cidchaves LIKE 'T382%';
DELETE FROM SigBaOco WHERE codigos IN ('91', '92', '93');
