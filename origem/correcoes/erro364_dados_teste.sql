-- =============================================================================
-- Erro364 (imagem erro364.png) - Dados de TESTE para "Emissao Global de Nota
--           Fiscal" (Formsigregnf / sigregnfBO)
-- A grade lista NFs da empresa corrente com Impress = 0 e Cancelas = 0. A serie 1
-- ja tem 3 assim (000028, 000029, 000030). Cria mais 3, clonando a venda real
-- 001/VENDA/32 (SigMvCab + SigMvNfi + SigMvPar, herdando as colunas NOT NULL):
--   NF 000032 - venda 9364 - usuario 4CONTROL
--   NF 000033 - venda 9365 - usuario 4CONTROL
--   NF 000034 - venda 9366 - usuario LOJA   (para testar o filtro Usuario)
-- Marcador: cidchaves LIKE 'T364%'
-- Idempotente. Limpeza: erro364_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;
DECLARE @edn_ori char(29) = '001' + LEFT('VENDA' + SPACE(20), 20) + RIGHT(SPACE(6) + '32', 6);

DELETE FROM SigMvPar WHERE cidchaves LIKE 'T364%';
DELETE FROM SigMvNfi WHERE cidchaves LIKE 'T364%';
DELETE FROM SigMvCab WHERE cidchaves LIKE 'T364%';

DECLARE @i int = 1;
WHILE @i <= 3
BEGIN
    DECLARE @num int = 9363 + @i;
    DECLARE @edn char(29) = '001' + LEFT('VENDA' + SPACE(20), 20) + RIGHT(SPACE(6) + CAST(@num AS varchar(6)), 6);
    DECLARE @nf char(6) = RIGHT('000000' + CAST(31 + @i AS varchar(6)), 6);
    DECLARE @usu char(10) = CASE WHEN @i = 3 THEN 'LOJA' ELSE '4CONTROL' END;

    SELECT * INTO #cab FROM SigMvCab WHERE empdopnums = @edn_ori;
    UPDATE #cab SET empdopnums = @edn, numes = @num, usuars = @usu,
           cidchaves = 'T364CAB' + RIGHT('0000000000000' + CAST(@i AS varchar(13)), 13);
    INSERT INTO SigMvCab SELECT * FROM #cab;
    DROP TABLE #cab;

    SELECT * INTO #nfi FROM SigMvNfi WHERE empdopnums = @edn_ori;
    UPDATE #nfi SET empdopnums = @edn, numes = @num, nfis = @nf, impress = 0, cancelas = 0,
           totnotas = totnotas + (@i * 100),
           cidchaves = 'T364NFI' + RIGHT('0000000000000' + CAST(@i AS varchar(13)), 13);
    INSERT INTO SigMvNfi SELECT * FROM #nfi;
    DROP TABLE #nfi;

    SELECT * INTO #par FROM SigMvPar WHERE empdopnums = @edn_ori;
    UPDATE #par SET empdopnums = @edn, numes = @num,
           cidchaves = 'T364PAR' + RIGHT('00000000000' + CAST(@i AS varchar(11)), 11) + RIGHT('00' + CAST(parcs AS varchar(2)), 2);
    INSERT INTO SigMvPar SELECT * FROM #par;
    DROP TABLE #par;

    SET @i = @i + 1;
END

SELECT n.series, n.nfis, n.dopes, n.numes, n.impress, n.cancelas, n.totnotas, c.usuars
  FROM SigMvNfi n JOIN SigMvCab c ON c.empdopnums = n.empdopnums
 WHERE n.series = '1' AND n.impress = 0 AND n.cancelas = 0 ORDER BY n.nfis;