-- Remove os dados de TESTE do Erro325 (Cheques Prorrogados)
SET NOCOUNT ON;
BEGIN TRAN;
DELETE FROM SigChea WHERE cidchaves LIKE 'TST325%';
DELETE FROM SigChe  WHERE nums LIKE '99325%';
COMMIT;
