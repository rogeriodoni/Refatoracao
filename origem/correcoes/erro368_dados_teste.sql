-- =============================================================================
-- Erro368 (imagem erro368.png) - Dados de TESTE para "Resumo de Cheques Pendentes"
--           (FormSIGREHPE / SIGREHPEBO / SigReHpe.frx)
-- O relatorio soma SigChe.Valors por operacao (Umovs) SO das operacoes de DEBITO
-- (SigCdOpt.Tipos = 'DB'). Ja existem ENTRADA (12 cheques) e CHQ DEVOLVIDO (1).
-- Acrescenta (clone do cheque real 99325003, trocando chave/operacao/valor):
--   T368001 CHQ REPOSTO   1.250,00  (DB - entra)
--   T368002 CHQ REPOSTO     750,00  (DB - entra; soma com o anterior)
--   T368003 BAIXAR        4.100,00  (DB - entra)
--   T368004 DEPOSITO      9.999,00  (CR - NAO entra: prova o filtro)
-- Marcador: SigChe.nums LIKE 'T368%'
-- Idempotente. Limpeza: erro368_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;
DELETE FROM SigChe WHERE nums LIKE 'T368%';
SELECT * INTO #c FROM SigChe WHERE nums = '99325003';
DECLARE @i int = 1;
WHILE @i <= 4
BEGIN
    SELECT * INTO #n FROM #c;
    UPDATE #n SET nums = 'T36800' + CAST(@i AS varchar(1)),
                  ncheques = '36800' + CAST(@i AS varchar(1)),
                  umovs = CASE @i WHEN 1 THEN 'CHQ REPOSTO' WHEN 2 THEN 'CHQ REPOSTO' WHEN 3 THEN 'BAIXAR' ELSE 'DEPOSITO' END,
                  valors = CASE @i WHEN 1 THEN 1250 WHEN 2 THEN 750 WHEN 3 THEN 4100 ELSE 9999 END;
    INSERT INTO SigChe SELECT * FROM #n;
    DROP TABLE #n;
    SET @i = @i + 1;
END
SELECT a.Umovs, COUNT(*) AS cheques, SUM(a.Valors) AS Valor
  FROM SigChe a, SigCdOpt b WHERE a.UMovs = b.Operacaos AND b.Tipos = 'DB'
 GROUP BY a.Umovs ORDER BY a.Umovs;