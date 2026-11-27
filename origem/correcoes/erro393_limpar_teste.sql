-- Erro393: remove o convenio bancario de teste (FormSIGPGCNB / SigCdCeb)
SET NOCOUNT ON;
DELETE FROM SigCdCeb WHERE cidchaves LIKE 'ZZTCEB%';
SELECT COUNT(*) AS convenios_de_teste_restantes FROM SigCdCeb WHERE cidchaves LIKE 'ZZTCEB%';
