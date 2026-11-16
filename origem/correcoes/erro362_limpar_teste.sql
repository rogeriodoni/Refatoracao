-- Erro362: remove faixas de preco e caracteristica de teste
SET NOCOUNT ON;
DELETE FROM SigCdPft WHERE cidchaves LIKE 'T362%';
DELETE FROM SigPrCpP WHERE cidchaves LIKE 'T362%';
DELETE FROM SigCdPpi WHERE cidchaves LIKE 'T362%';
DELETE FROM SigCdPpc WHERE cidchaves LIKE 'T362%';

