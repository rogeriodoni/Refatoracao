-- =============================================================================
-- Erro378 (imagem erro378.png) - Dados de TESTE para "Relatorio Comparativo de Impostos"
--           (Formsigreimp / sigreimpBO / SigReIp1.frx detalhado, SigReIp2.frx resumido)
-- O relatorio soma as NFs (SigMvNfi) de operacoes fiscais (SigCdOpe.NFiscals 1/2)
-- cujo tipo operacional (SigCdOpe.TipoOps) foi marcado em cada grade.
-- As NFs existentes sao de 2023/2024 - o periodo da imagem eh HOJE (16/11/2026).
-- Cria 6 NFs da empresa 001, serie 1 (clones da NF real 000030):
--   ENTRADAS (marcar 5 DEVOLUCAO DE VENDA e 7 COMPRAS):
--     T37801 NF COMPRA FORNECEDOR (7) F000000029  16/11  Total 10.000,00 ICMS 1.800,00 IPI 500,00
--     T37802 NF DEVOLUCAO VENDA   (5) C001000034  16/11  Total  2.000,00 ICMS   360,00
--   SAIDAS (marcar 1 FATURAMENTO e 4 VENDAS):
--     T37803 VENDA                (4) C001000034  16/11  Total 15.000,00 ICMS 2.700,00 ICMS-ST 300,00
--     T37804 NF VENDA CLIENTE     (1) C001000039  16/11  Total  8.000,00 ICMS 1.440,00
--     T37805 VENDA CANCELADA      (4)             16/11  Total  5.000,00 -> NAO entra (Cancelas = 1)
--     T37806 VENDA                (4)             15/11  Total  7.000,00 -> NAO entra (fora do periodo)
-- Resumido esperado: E = 12.000,00 / ICMS 2.160,00 / IPI 500,00
--                    S = 23.000,00 / ICMS 4.140,00 / ICMS-ST 300,00
-- Marcador: SigMvNfi.cidchaves LIKE 'T378%'
-- Idempotente. Limpeza: erro378_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;
DELETE FROM SigMvNfi WHERE cidchaves LIKE 'T378%';
SELECT * INTO #n0 FROM SigMvNfi WHERE cidchaves = '0016UQ0PO2SF54240203';   -- NF 000030
DECLARE @i int = 1;
WHILE @i <= 6
BEGIN
    SELECT * INTO #n FROM #n0;
    UPDATE #n SET
        cidchaves = 'T378NFI0' + CAST(@i AS varchar(1)),
        emps = '001', series = '1',
        nfis = 'T3780' + CAST(@i AS varchar(1)),
        dopes = CASE @i WHEN 1 THEN 'NF COMPRA FORNECEDOR' WHEN 2 THEN 'NF DEVOLUCAO VENDA'
                        WHEN 4 THEN 'NF VENDA CLIENTE' ELSE 'VENDA' END,
        emis = CASE @i WHEN 6 THEN '20261115' ELSE '20261116' END,
        cfis = CASE @i WHEN 1 THEN '1.102' WHEN 2 THEN '1.202' ELSE '5.102' END,
        clifors = CASE @i WHEN 1 THEN 'F000000029' WHEN 4 THEN 'C001000039' ELSE 'C001000034' END,
        totnotas = CASE @i WHEN 1 THEN 10000 WHEN 2 THEN 2000 WHEN 3 THEN 15000 WHEN 4 THEN 8000 WHEN 5 THEN 5000 ELSE 7000 END,
        valicms  = CASE @i WHEN 1 THEN 1800 WHEN 2 THEN 360 WHEN 3 THEN 2700 WHEN 4 THEN 1440 WHEN 5 THEN 900 ELSE 1260 END,
        icmss    = CASE @i WHEN 3 THEN 300 ELSE 0 END,
        valipis  = CASE @i WHEN 1 THEN 500 ELSE 0 END,
        cancelas = CASE @i WHEN 5 THEN 1 ELSE 0 END;
    UPDATE #n SET empdopnums = emps + CAST(dopes AS char(20)) + STR(378000 + @i, 6);
    INSERT INTO SigMvNfi SELECT * FROM #n;
    DROP TABLE #n;
    SET @i = @i + 1;
END
DROP TABLE #n0;

SELECT n.nfis, n.dopes, o.tipoops, o.nfiscals, CONVERT(char(10), n.emis, 103) emis, n.cfis, n.clifors,
       c.razaos, n.totnotas, n.valicms, n.icmss, n.valipis, n.cancelas
  FROM SigMvNfi n JOIN SigCdOpe o ON o.dopes = n.dopes LEFT JOIN SigCdCli c ON c.iclis = LEFT(n.clifors, 10)
 WHERE n.cidchaves LIKE 'T378%' ORDER BY n.nfis;
