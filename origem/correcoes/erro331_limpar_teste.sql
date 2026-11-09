-- Remove os dados de TESTE do Erro331 (Cotacao de Compras)
SET NOCOUNT ON;
BEGIN TRAN;
DELETE FROM SigCtTpc WHERE cidchaves LIKE 'T331%';
DELETE FROM SigCtTps WHERE cidchaves LIKE 'T331%';
DELETE FROM SigCtTfn WHERE cidchaves LIKE 'T331%';
DELETE FROM SigCtTct WHERE cidchaves LIKE 'T331%';
DELETE FROM SigCtTdc WHERE cidchaves LIKE 'T331%';
COMMIT;
