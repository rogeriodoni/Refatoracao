-- Remove os dados de TESTE do Erro327 (Debitos/Creditos Pendentes)
SET NOCOUNT ON;
DELETE FROM SigMvCcr WHERE cidchaves LIKE 'T327CCR%';
