-- Erro375: remove os lancamentos de falha/perda de teste
SET NOCOUNT ON;
DELETE FROM SigCdFea WHERE cidchaves LIKE 'T375%';
