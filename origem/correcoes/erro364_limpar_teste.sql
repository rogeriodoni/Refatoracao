-- Erro364: remove as NFs de teste 000032..000034 (vendas 9364..9366)
SET NOCOUNT ON;
DELETE FROM SigMvPar WHERE cidchaves LIKE 'T364%';
DELETE FROM SigMvNfi WHERE cidchaves LIKE 'T364%';
DELETE FROM SigMvCab WHERE cidchaves LIKE 'T364%';

