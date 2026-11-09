-- Remove os dados de TESTE do Erro332 (Demonstrativo de Balanco)
SET NOCOUNT ON;
BEGIN TRAN;
DELETE FROM SigCdFes WHERE cidchaves LIKE 'T332%';
DELETE FROM SigOpCfe WHERE cidchaves LIKE 'T332%';
DELETE FROM SigCdFcx WHERE cidchaves LIKE 'T332%';
DELETE FROM SigCdDpr WHERE cidchaves LIKE 'T332%';
DELETE FROM SigPrDmo WHERE cidchaves LIKE 'T332%';
COMMIT;
