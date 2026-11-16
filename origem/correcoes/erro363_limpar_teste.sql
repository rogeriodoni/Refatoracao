-- Erro363: remove a forma de pagamento e a venda/NF 000031 de teste
SET NOCOUNT ON;
DELETE FROM SigMvPar WHERE cidchaves LIKE 'T363%';
DELETE FROM SigMvNfi WHERE cidchaves LIKE 'T363%';
DELETE FROM SigMvCab WHERE cidchaves LIKE 'T363%';
DELETE FROM SigOpFp  WHERE fpags = 'T363 BOLETO';

