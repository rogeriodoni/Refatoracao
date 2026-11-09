-- Remove os dados de TESTE do Erro333 (Cotas de Desconto)
SET NOCOUNT ON;
BEGIN TRAN;
DELETE FROM SigMvItd WHERE cidchaves LIKE 'T333%';
DELETE FROM SigMvItn WHERE cidchaves LIKE 'T333%';
DELETE FROM SigMvCab WHERE cidchaves LIKE 'T333%';
DELETE FROM sigcddes WHERE codigo = 'T333COTA';
COMMIT;
