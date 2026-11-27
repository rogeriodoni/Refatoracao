-- =============================================================================
-- Erro395: remove os dados de teste do lookup de FormSIGPGCNB
--
-- NAO apaga o convenio do erro393 (marcador ZZTCEB) - esse tem script proprio.
-- =============================================================================
SET NOCOUNT ON;

DELETE FROM SigCdEmp WHERE cemps IN ('Z01','Z02','Z90') AND razsocs LIKE 'ZZ TESTE%';
DELETE FROM SigCdCeb WHERE cidchaves LIKE 'ZZTC95%';

SELECT (SELECT COUNT(*) FROM SigCdEmp WHERE razsocs LIKE 'ZZ TESTE%')    AS empresas_teste_restantes,
       (SELECT COUNT(*) FROM SigCdCeb WHERE cidchaves LIKE 'ZZTC95%')    AS convenios_teste_restantes,
       (SELECT COUNT(*) FROM SigCdEmp)                                   AS total_sigcdemp,
       (SELECT COUNT(*) FROM SigCdCeb)                                   AS total_sigcdceb;
