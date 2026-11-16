-- Erro378: remove as NFs de teste
SET NOCOUNT ON;
DELETE FROM SigMvNfi WHERE cidchaves LIKE 'T378%';
