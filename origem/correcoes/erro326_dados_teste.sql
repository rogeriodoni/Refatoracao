-- =============================================================================
-- Erro326 - Dados de TESTE para "Relacao de Contagem por Referencia"
--           (Formsigrecrf / sigrecrfBO)
-- O relatorio cruza a CONTAGEM (SigCdCrf + SigCdCri) com o SALDO de estoque
-- (SigMvEst), restrito a produtos com cunis = 'UN' e a contas cadastradas em
-- SigCtCtg. No banco: SigCdCrf/SigCdCri/SigCtCtg vazias e NENHUM produto 'UN'.
-- Para nao mexer em produto real, cria 4 produtos de teste TST326A..D (copia
-- do produto 036) com saldo proprio na conta de estoque 11210/1121001.
--
-- Marcadores: SigCdPro.cpros / SigMvEst.cpros LIKE 'TST326%'
--             cidchaves LIKE 'TST326%' (SigMvEst, SigCtCtg, SigCdCrf, SigCdCri)
-- Contagem com DATA 01/01/2000 (o campo "Data" da tela eh a data EXATA da contagem).
-- Idempotente. Limpeza: erro326_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRAN;

DELETE FROM SigCdCri WHERE cidchaves LIKE 'TST326%';
DELETE FROM SigCdCrf WHERE cidchaves LIKE 'TST326%';
DELETE FROM SigCtCtg WHERE cidchaves LIKE 'TST326%';
DELETE FROM SigMvEst WHERE cpros LIKE 'TST326%';
DELETE FROM SigCdPro WHERE cpros LIKE 'TST326%';

DECLARE @emp char(3) = '001', @gru char(10) = '11210', @est char(10) = '1121001';
DECLARE @cod char(10) = 'TST326', @dat datetime = '2000-01-01 10:00', @ven char(10) = 'DANISA';

-- produto / descricao / saldo em estoque / quantidade contada
DECLARE @p TABLE (seq int, cpros char(14), dpros varchar(65), saldo numeric(9,3), contado numeric(5,0));
INSERT @p VALUES
 (1, 'TST326A', 'TESTE ERRO326 - ANEL (CONTAGEM CONFERE)',   5, 5),
 (2, 'TST326B', 'TESTE ERRO326 - BRINCO (FALTA 2)',          3, 1),
 (3, 'TST326C', 'TESTE ERRO326 - COLAR (SOBRA 2)',           4, 6),
 (4, 'TST326D', 'TESTE ERRO326 - PULSEIRA (NAO LIDO)',       2, 0);

-- Produtos de teste (molde = produto real 036), unidade UN
SELECT TOP 0 * INTO #pro FROM SigCdPro;
INSERT INTO #pro SELECT * FROM SigCdPro WHERE cpros = '036';
DECLARE @i int = 1;
IF (SELECT COUNT(*) FROM #pro) <> 1 RAISERROR('Produto molde 036 nao encontrado', 16, 1);
WHILE @i <= 4
BEGIN
    UPDATE #pro SET cpros = (SELECT cpros FROM @p WHERE seq = @i),
                    dpros = (SELECT dpros FROM @p WHERE seq = @i),
                    cunis = 'UN';
    INSERT INTO SigCdPro SELECT * FROM #pro;
    SET @i = @i + 1;
END
DROP TABLE #pro;

-- Saldo de estoque (SigMvEst): empgruests = emps(3) + grupos(10) + estos(10)
INSERT INTO SigMvEst (codcors, codtams, cpros, emps, estos, grupos, moedmeds, sqtds, teqtds, tipests, tsqtds,
    unitmeds, cidchaves, dtalts, empgruests, tipoestos, dtimeds, qtimeds, spesos, unitmfis, medipis)
SELECT '', '', p.cpros, @emp, @est, @gru, '', p.saldo, p.saldo, '', 0,
    0, 'TST326EST' + RIGHT('00000000000' + CAST(p.seq AS varchar), 11), GETDATE(), @emp + @gru + @est, 1, '19000101', 0, 0, 0, 0
FROM @p p;

-- Conta de estoque controlada por contagem
INSERT INTO SigCtCtg (cidchaves, grupos, contas, empresa)
VALUES ('TST326CTG00000000001', @gru, @est, @emp);

-- Contagem (cabecalho + itens)
INSERT INTO SigCdCrf (cidchaves, conferido, datas, vends, cods, emps)
VALUES ('TST326CRF00000000001', 0, @dat, @ven, @cod, @emp);

INSERT INTO SigCdCri (cidchaves, cods, emps, grupos, estos, qtds, estoque, cpros)
SELECT 'TST326CRI' + RIGHT('00000000000' + CAST(p.seq AS varchar), 11), @cod, @emp, @gru, @est, p.contado, p.saldo, p.cpros
FROM @p p;

COMMIT;

SELECT i.cpros, p.dpros, p.cunis, e.sqtds AS saldo_estoque, i.qtds AS contado, i.qtds - e.sqtds AS diferenca
FROM SigCdCri i
JOIN SigCdPro p ON p.cpros = i.cpros COLLATE DATABASE_DEFAULT
JOIN SigMvEst e ON e.cpros = i.cpros COLLATE DATABASE_DEFAULT AND e.emps = i.emps COLLATE DATABASE_DEFAULT AND e.grupos = i.grupos COLLATE DATABASE_DEFAULT AND e.estos = i.estos COLLATE DATABASE_DEFAULT
WHERE i.cidchaves LIKE 'TST326%' ORDER BY i.cpros;
