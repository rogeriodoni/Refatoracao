-- Remove os dados de TESTE do Erro328 (Movimentacao de Cartoes)
SET NOCOUNT ON;
BEGIN TRAN;
DELETE FROM SigCdCrd WHERE cidchaves LIKE 'T328%';
DELETE FROM SigCdCtt WHERE cidchaves LIKE 'T328%';
DELETE FROM SigCdCar WHERE cidchaves LIKE 'T328%';
COMMIT;
