-- Erro371: remove o produto de teste T371, seu saldo e seu historico
SET NOCOUNT ON;
DELETE FROM SigMvHst WHERE cidchaves LIKE 'T371%';
DELETE FROM SigMvEst WHERE cidchaves LIKE 'T371%';
DELETE FROM SigCdPro WHERE cpros = 'T371';
