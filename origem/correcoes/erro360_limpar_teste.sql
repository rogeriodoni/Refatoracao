-- Erro360: remove as fundicoes de teste 900001..900003
SET NOCOUNT ON;
DELETE FROM SigCdFud WHERE cidchaves LIKE 'T360%';
DELETE FROM SigCdFun WHERE cidchaves LIKE 'T360%';
SELECT (SELECT COUNT(*) FROM SigCdFun WHERE cidchaves LIKE 'T360%') AS fun, (SELECT COUNT(*) FROM SigCdFud WHERE cidchaves LIKE 'T360%') AS fud;

