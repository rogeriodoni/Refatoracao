-- Remove os dados de TESTE do Erro326 (Contagem por Referencia)
SET NOCOUNT ON;
BEGIN TRAN;
DELETE FROM SigCdCri WHERE cidchaves LIKE 'TST326%';
DELETE FROM SigCdCrf WHERE cidchaves LIKE 'TST326%';
DELETE FROM SigCtCtg WHERE cidchaves LIKE 'TST326%';
DELETE FROM SigMvEst WHERE cpros LIKE 'TST326%';
DELETE FROM SigCdPro WHERE cpros LIKE 'TST326%';
COMMIT;
