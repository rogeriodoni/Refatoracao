-- Erro373: remove as contas de teste
SET NOCOUNT ON;
DELETE FROM SigCdCli WHERE iclis LIKE 'T373%';
